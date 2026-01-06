struct Predicate<Target> {
    let evaluate: (Target) throws -> Bool
}
