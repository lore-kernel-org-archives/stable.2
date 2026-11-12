Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445343;
	b=WYtNFm5gTQAwRgE6jr+8JgmjtjHNZVe//EZQN1/wjz+JkSvVqLD+aJm1IkLxH6Rg6DaX
	 HJ2AVBzYmqLSFHylmMVetm426Odq17UyCm66Buu7rssZdiPC2qBBujYRPw1u0GcI5kGgm
	 pTzc9/XaubAewj6ksLXdSLiyXckNglEyU3vLukcoFDeqI0EZ15tmv3FcEB2XT/u8JXqzY
	 2lu5cW2ytqEL3km8L0b0mCemWUtM6oRXkQ30fyO+0JV1Nv3CuiCf2o0aAFU+SIGhUuNcm
	 Zyy44QiB7n6IcS82jOQ/fxN0W6FMnJudiiaBDlj6sC+Ka708akxPhnFBfKphQStlrjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445343;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HrApAmizTKZvKmJkArs2TChF9RSa+uCYcJdqbbzoIdQ=;
	b=c4KwjQI508x3KXOAFoVy+8nih5q+8kcYnfsqql74NyPs/YZAPEbyvV/Jt9kpY+EsYCoI
	 DjP4nC5wvcyVosDHmftpMM7pYStgWyAFFEIVaAmbtFY9DmgAWZyuRyhwrfeMGFuFkCerG
	 EaYJi1whFrNlD1WCDcQFGxASxsqnPqoo6pxEpikT7p225P344mxhCM3FnzmvY/fk/wEmf
	 wIGhRt7XkYOF0yzl+pQaHtIoGTwt4pwzXKDw21URU2WSPqsWi7VINK9RtNkyqS03qPMgj
	 fUKsmpBsCOzpdxflxZiuWzgwl2UI5jzlJP2NGkWImz16F9lvowzRGLEGC9E0vwQbmiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhAOSejt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA92606A32A;
	Thu, 12 Nov 2026 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhAOSejt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08B61F00A05;
	Thu, 12 Nov 2026 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445342;
	bh=HrApAmizTKZvKmJkArs2TChF9RSa+uCYcJdqbbzoIdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nhAOSejtUjP0YkjSMzjC6dVYjzTLchDzVzVvH+7Fnjw7GRKPdXTUidRvr1W82UPF6
	 2nmJkcpa4Cu2ysci4TAswBqgdMbLTjpeRnZhFiicMa9lCitloAtThfkB2N/ZW9Jbme
	 EM/SGF0fYC4yEx66H7rWfbaAiB56t84KJXM4bzBcEVYjSjecTKoVjDNV9Un135OoQD
	 b/RKGThjd06DSvQnnX2uNjBfAdr2RVYuWzvoMnXGGllp3qN5sPm9RspTshA8ndz6CR
	 VLELeaWlH4BHQvKu4VGH6i8ER+WwuPnbYSXg0EQDyx6+8++X7C5ywR14OoLsMxdGTP
	 vRjDTOMT1NO6A==
Date: Thu, 12 Nov 2026 01:57:39 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Leon Romanovsky <leon@kernel.org>, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>, Thorsten Leemhuis
 <linux@leemhuis.info>, "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook
 <kees@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dan Carpenter
 <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, SJ
 Park <sj@kernel.org>, Bradley Morgan <brads@mainlining.org>, Sasha Levin
 <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 6/6] agents: add a skill to write KUnit tests
Message-ID: <20261112015739.2ad28e01@foz.lan>
In-Reply-To: <20261111225940.1573565-7-tytso@mit.edu>
References: <20261111225940.1573565-1-tytso@mit.edu>
	<20261111225940.1573565-7-tytso@mit.edu>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Nov 2026 17:59:38 -0500
"Theodore Ts'o" <tytso@mit.edu> wrote:

> Add a skill under agents/skills/writing-kunit-tests/ to guide coding
> assistants when designing, implementing, verifying, or reviewing KUnit
> unit tests. Point the skill at the KUnit and process documentation and
> cover unit testing principles (testing behaviors rather than
> implementation details, keeping tests focused and DAMP, choosing
> non-default and distinct test values, using narrow expectations, and
> maintaining test isolation), KUnit resource management and static stub
> idioms, and verification with kunit.py.
>=20
> Update Documentation/process/coding-assistants.rst to list the new skill
> and note that skills only inspect and report unless their task is to
> write or modify code or tests.

You should probably make it a little bit more generic, also mentioning=20
tools/unittests/.=20

Currently, we have there Python unit tests meant to detect bugs related
to documentation build, covering basically kernel-doc.

Goal is mainly to avoid regressions, as it was somewhat frequent in the
past that changes at kernel-doc complex regular expressions would break
something.

Regards,
Mauro

>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  Documentation/process/coding-assistants.rst |  11 +-
>  agents/skills/writing-kunit-tests/SKILL.md  | 344 ++++++++++++++++++++
>  2 files changed, 351 insertions(+), 4 deletions(-)
>  create mode 100644 agents/skills/writing-kunit-tests/SKILL.md
>=20
> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/=
process/coding-assistants.rst
> index f0bae6bfe9a0..bb927fea5024 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -28,10 +28,11 @@ skill with a ``SKILL.md`` entry point in the `Agent S=
kills format
>  documents that apply to its task and adds only what assistants tend to g=
et
>  wrong.
> =20
> -Skills inspect and report. They do not change files, create commits or t=
ags,
> -or send mail. A skill returns its result with the evidence for it, or sa=
ys what
> -is missing. Do not fill a missing result with a guess or a placeholder, =
and do
> -not finalize the work until it is resolved.
> +Unless a skill's task is to write or modify code or tests, skills only i=
nspect
> +and report: they do not change files, create commits or tags, or send ma=
il. A
> +skill returns its result with the evidence for it, or says what is missi=
ng. Do
> +not fill a missing result with a guess or a placeholder, and do not fina=
lize
> +the work until it is resolved.
> =20
>  The following skills are available:
> =20
> @@ -43,6 +44,8 @@ The following skills are available:
>    tree.
>  * agents/skills/commit-message/SKILL.md writes, rewrites or reviews a co=
mmit
>    message or cover letter, and writes the text of a pull request.
> +* agents/skills/writing-kunit-tests/SKILL.md designs, writes, verifies, =
or
> +  reviews KUnit unit tests.
> =20
>  Licensing and Legal Requirements
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/agents/skills/writing-kunit-tests/SKILL.md b/agents/skills/w=
riting-kunit-tests/SKILL.md
> new file mode 100644
> index 000000000000..1f19b585b9b4
> --- /dev/null
> +++ b/agents/skills/writing-kunit-tests/SKILL.md
> @@ -0,0 +1,344 @@
> +---
> +# SPDX-License-Identifier: GPL-2.0-only
> +name: writing-kunit-tests
> +description: >-
> +  Design, implement, verify, or review KUnit unit tests for the Linux ke=
rnel.
> +  Use when writing new KUnit tests, expanding existing KUnit test suites,
> +  adding regression tests with KUnit, or reviewing KUnit test patches.
> +---
> +
> +# Write KUnit tests
> +
> +Before writing or modifying any code, read the relevant kernel documenta=
tion:
> +- **KUnit Framework & Style**:
> +  `Documentation/dev-tools/kunit/usage.rst`,
> +  `Documentation/dev-tools/kunit/style.rst`,
> +  `Documentation/dev-tools/kunit/start.rst`, and
> +  `Documentation/dev-tools/kunit/api/functionredirection.rst`
> +- **Kernel Development & Patch Submission**:
> +  `Documentation/process/development-process.rst`,
> +  `Documentation/process/coding-style.rst`,
> +  `Documentation/process/submitting-patches.rst`, and
> +  `Documentation/process/license-rules.rst`
> +- **AI Coding Assistants & Tool-Generated Content**:
> +  `Documentation/process/coding-assistants.rst` and
> +  `Documentation/process/generated-content.rst`
> +
> +Also inspect existing KUnit tests in the target subsystem (e.g., `*-test=
.c` or
> +`tests/*_kunit.c`) to follow established local conventions for file nami=
ng,
> +symbol visibility, Kconfig, and Makefile integration.
> +
> +---
> +
> +## 1. Core Unit Testing Principles
> +
> +Apply the following software testing best practices to ensure KUnit test=
s have
> +high **fidelity** (fail when code is broken), **resilience** (only fail =
when
> +actual behavior breaks, not during internal refactoring), **precision**
> +(pinpoint the exact defect on failure), and **clarity** (serve as execut=
able
> +documentation):
> +
> +### 1.1 Test Behaviors, Not Functions or Implementation Details
> +- **Avoid a 1:1 function-to-test mapping**: A single C function often ex=
hibits
> +  multiple distinct behaviors (e.g., normal insertion, merging with left=
/right
> +  neighbors, splitting an existing entry, error handling), and a single =
logical
> +  behavior may span multiple functions (e.g., insert followed by lookup =
and
> +  removal). Write separate test cases for each distinct behavior.
> +- **Test public/subsystem APIs over internal details**: Exercise the unit
> +  through its intended interface rather than testing private helper func=
tions in
> +  isolation whenever possible. If internal implementation details are
> +  refactored without changing observable behavior, existing tests should
> +  continue to pass.
> +- **Do not write "change-detector" tests**: Never write tests that merely
> +  mirror the implementation line-by-line or assert an exact sequence of
> +  internal helper calls without checking the resulting state or output.
> +
> +### 1.2 Keep Tests Focused
> +- **One scenario per test case**: Each `static void test_...(struct kuni=
t *test)`
> +  function should test a single scenario or behavior.
> +- **Do not chain unrelated scenarios in one test**: Avoid mutating state=
 across
> +  a long sequence of unrelated scenarios in a single test function where=
 side
> +  effects from an earlier check can mask bugs or invalidate assumptions =
in
> +  later checks.
> +- **Include the scenario and expected outcome in test names**: Name test
> +  functions so a developer can tell what scenario is being exercised and=
 what
> +  should happen from the function name alone (e.g.,
> +  `test_es_insert_adjacent_same_status_merges_extents` or
> +  `unpack_u32_with_null_name_fails` rather than just `test_insert` or
> +  `test_unpack`).
> +
> +### 1.3 Make Tests DAMP, Not Overly DRY
> +- **Prioritize readability by inspection (DAMP =E2=80=94 Descriptive and=
 Meaningful
> +  Phrases)**: Because tests do not have their own tests, their correctne=
ss must
> +  be obvious to a human reviewer reading top-to-bottom. Do not over-abst=
ract
> +  tests just to eliminate a few lines of duplication.
> +- **Keep cause and effect together**: Set up the specific inputs that dr=
ive a
> +  test's outcome directly inside the test case body right before the cal=
l under
> +  test and its `KUNIT_EXPECT_*` checks. Never hide the critical input va=
lues
> +  that determine an expected output inside a distant `.init` function.
> +- **Include only relevant details (hide noise)**: Use helper functions t=
o hide
> +  irrelevant boilerplate setup (such as allocating a dummy `super_block`,
> +  initializing locks, or zeroing unrelated struct fields), but pass the =
values
> +  that actually matter to the test explicitly as arguments at the call s=
ite:
> +
> +  ```c
> +  /* BAD: Critical values hidden inside helper, or noisy setup inline */
> +  inode =3D create_test_inode();
> +  KUNIT_EXPECT_EQ(test, get_quota_blocks(inode), 42); /* Where did 42 co=
me from? */
> +
> +  /* GOOD: Helper hides boilerplate; test-relevant value is explicit */
> +  inode =3D create_test_inode_with_reserved_blocks(test, 42);
> +  KUNIT_EXPECT_EQ(test, get_quota_blocks(inode), 42);
> +  ```
> +
> +### 1.4 Don't Put Logic in Tests & Prefer Literals/Constants
> +- **State expected outputs directly**: Never compute expected values in
> +  assertions using arithmetic, bit shifts, string concatenation, loops, =
or
> +  conditionals that duplicate the production algorithm. Computing expect=
ations
> +  in tests can introduce bugs in the test itself or mask a shared bug in
> +  production code.
> +- **Prefer literals or named constants in assertions**: Compare actual r=
esults
> +  against concrete literals or self-explanatory constants rather than dy=
namic
> +  expressions derived from the system under test.
> +
> +### 1.5 Choose Robust Test Values & Think Beyond Line Coverage
> +- **Test with non-default values**: In the kernel, structs are frequently
> +  zero-allocated (`kzalloc` / `kunit_kzalloc`). If you test a setter, pa=
rser,
> +  or lookup using `0`, `false`, `NULL`, or enum value `0`, a broken
> +  implementation that never writes the field will still pass! Always use
> +  non-zero, non-default test values for positive tests.
> +- **Use distinct values for each parameter**: When calling a function th=
at
> +  takes multiple arguments of the same or compatible types (e.g.,
> +  `ext4_es_insert_extent(inode, lblk, len, pblk, status, ...)`), use cle=
arly
> +  distinct values (e.g., `lblk =3D 10`, `len =3D 5`, `pblk =3D 1000`) so=
 swapped
> +  arguments or off-by-one mixups are caught immediately.
> +- **Think beyond line coverage**:
> +  - **Branch & Condition coverage**: For compound boolean conditions like
> +    `if ((a && b) || !c)`, write test cases that exercise each condition
> +    independently, not just a single path that executes the line.
> +  - **Boundary & Edge cases**: Test `0`, `1`, exact power-of-two/cluster
> +    boundaries, maximum legal limits (e.g., `INT_MAX`, `ULONG_MAX`,
> +    `EXT_MAX_BLOCKS`), overflow/underflow boundaries, empty trees/lists,
> +    single-element collections, and multi-element spans.
> +  - **Error paths**: Test invalid inputs, `-EINVAL` / `-ENOMEM` / `-ENOS=
PC`
> +    conditions, and verify that error paths leave data structures in a v=
alid,
> +    uncorrupted state without leaking resources.
> +
> +### 1.6 Prefer Narrow Assertions & Make Failures Actionable
> +- **Actionable failure messages**: When a test fails, the test name and =
KUnit
> +  failure log alone should be enough to start debugging without adding
> +  `printk`s and re-running.
> +- **Use specific KUnit expectation macros**:
> +  - Use `KUNIT_EXPECT_EQ(test, actual, expected)`, `KUNIT_EXPECT_NE`,
> +    `KUNIT_EXPECT_LT`, `KUNIT_EXPECT_LE`, `KUNIT_EXPECT_GT`, `KUNIT_EXPE=
CT_GE`
> +    for integers/enums (instead of `KUNIT_EXPECT_TRUE(test, a =3D=3D b)`=
, which
> +    only prints `Expected true, got false`).
> +  - Use `KUNIT_EXPECT_PTR_EQ`, `KUNIT_EXPECT_NULL`, `KUNIT_EXPECT_NOT_NU=
LL`,
> +    `KUNIT_EXPECT_NOT_ERR_OR_NULL` for pointers.
> +  - Use `KUNIT_EXPECT_STREQ` / `KUNIT_EXPECT_MEMEQ` for strings and buff=
ers.
> +- **Use `_MSG` variants in loops and helpers**: Whenever an expectation =
is
> +  inside a helper function, loop, or table-driven check, use
> +  `KUNIT_EXPECT_*_MSG(test, ..., "context fmt", ...)` so the failure out=
put
> +  identifies the exact case or index that failed.
> +- **Prefer narrow assertions**: Assert only the struct fields or propert=
ies
> +  relevant to the behavior under test, rather than asserting every unrel=
ated
> +  field of a large struct (which creates brittle tests that break whenev=
er
> +  unrelated fields change).
> +
> +### 1.7 Test Isolation, Order Independence, and Zero Flakiness
> +- **Complete independence between test cases**: Every test case must pas=
s when
> +  run by itself (`kunit.py run suite.test`), in any order, or repeatedly.
> +- **Never leak mutable shared state**: Avoid file-scope mutable globals.=
 Prefer
> +  allocating per-test context in `test->priv` via `kunit_kzalloc(test, .=
..)` in
> +  `.init`. If a suite shares a fixture structure, ensure `.init` and `.e=
xit`
> +  completely reset all trees, lists, flags, and stub counters before and=
 after
> +  every single test case.
> +- **No "sleep gambling"**: Never use `msleep()` or arbitrary delays to w=
ait for
> +  asynchronous work in unit tests. Test synchronous entry points, flush
> +  workqueues deterministically, or inject synchronous stubs.
> +
> +### 1.8 High Fidelity & Smart Use of Test Doubles (Real > Fake > Stub > =
Mock)
> +- **Prefer real implementations first**: Use real kernel data structures=
 (e.g.,
> +  `rbtree`, `xarray`, `list_head`, in-memory anonymous `super_block` / `=
inode`,
> +  or `kunit_device_register()`) whenever they run fast and deterministic=
ally in
> +  memory.
> +- **Use fakes or stubs to isolate heavyweight dependencies**: When code =
under
> +  test interacts with hardware, disk I/O, journals, block allocators, or=
 global
> +  kernel state, isolate it using:
> +  1. **Lightweight in-memory fakes** (e.g., an ops struct backed by a me=
mory
> +     buffer), or
> +  2. **KUnit static stubs** (`KUNIT_STATIC_STUB_REDIRECT` and
> +     `kunit_activate_static_stub`).
> +- **Avoid overusing mocks / interaction verification**:
> +  - Prefer **state testing** (verifying return values and resulting data
> +    structure state) over **interaction testing** (verifying that functi=
on X
> +    was called).
> +  - Only verify **state-changing** external calls (e.g., verifying that a
> +    delayed-allocation block reservation was claimed or released), never
> +    read-only query helpers.
> +  - When verifying stub calls, only check arguments relevant to the beha=
vior
> +    being tested.
> +
> +### 1.9 Parameterize Repetitive Tests Judiciously
> +- **Use parameterized or table-driven tests for input/output matrices**:=
 When
> +  testing the same behavior across many input combinations (e.g., extent
> +  merge/split geometries, timestamp bit-decoding tables, hash test vecto=
rs),
> +  use `KUNIT_ARRAY_PARAM` / `KUNIT_ARRAY_PARAM_DESC` with `KUNIT_CASE_PA=
RAM`
> +  (or a clean table-driven helper) to avoid copy-pasting identical test
> +  functions.
> +- **Do not put conditional logic inside parameterized tests**: If a
> +  parameterized test requires `if (param->expect_error)` or
> +  `switch (param->mode)` inside the test function to decide what asserti=
ons to
> +  run, split it into separate parameterized or standalone tests instead.
> +
> +---
> +
> +## 2. KUnit Framework Idioms & Mechanics
> +
> +### 2.1 Expectations vs. Assertions
> +- **`KUNIT_EXPECT_*`**: Records a test failure and logs diagnostic detai=
ls, but
> +  **continues** executing the rest of the test case. Use `KUNIT_EXPECT_*=
` for
> +  the behavioral checks in your test.
> +- **`KUNIT_ASSERT_*`**: Immediately **aborts** the current test case
> +  (terminating the KUnit kthread) on failure. Use `KUNIT_ASSERT_*` for
> +  preconditions whose failure makes continuing impossible or unsafe (e.g=
.,
> +  `KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr)` after memory allocation or o=
bject
> +  lookup before dereferencing `ptr`).
> +- **CRITICAL**: **Never** use `KUNIT_ASSERT_*` in `.exit()`, `.suite_exi=
t()`,
> +  or `kunit_resource` / action cleanup callbacks. Aborting during teardo=
wn
> +  skips subsequent cleanup steps and causes memory or resource leaks in =
the
> +  running kernel.
> +
> +### 2.2 Resource & Memory Management
> +- **Managed memory**: Always prefer `kunit_kmalloc()`, `kunit_kzalloc()`,
> +  `kunit_kcalloc()`, `kunit_kmalloc_array()`, and `kunit_kstrdup()` over=
 raw
> +  `kmalloc`/`kzalloc`. KUnit automatically frees these allocations when =
the
> +  test case exits=E2=80=94even if a `KUNIT_ASSERT_*` aborts the test mid=
way.
> +- **Deferred cleanup actions**: For non-memory resources (e.g., unregist=
ering a
> +  shrinker, freeing slab cache objects, releasing locks/superblocks, cle=
aning
> +  up trees), either clean them up in `.exit` or register a deferred acti=
on
> +  immediately after acquisition using `kunit_add_action_or_reset()`:
> +
> +  ```c
> +  KUNIT_DEFINE_ACTION_WRAPPER(my_resource_cleanup, my_resource_cleanup_w=
rapper,
> +                              struct my_resource *);
> +  ...
> +  ret =3D kunit_add_action_or_reset(test, my_resource_cleanup_wrapper, r=
es);
> +  KUNIT_ASSERT_EQ(test, ret, 0);
> +  ```
> +  Always use `KUNIT_DEFINE_ACTION_WRAPPER()` rather than casting function
> +  pointers to `kunit_action_t`, as casting function pointers breaks Cont=
rol
> +  Flow Integrity (CFI).
> +- **Safe `.exit` functions**: Remember that `.exit` and `.suite_exit` ru=
n even
> +  if `.init` or `.suite_init` failed or exited early. Always guard `.exi=
t`
> +  cleanup against NULL or partially initialized pointers.
> +- **Fake devices**: When code under test requires a `struct device *` (e=
.g.,
> +  for `devm_*` managed APIs), use `kunit_device_register(test, "name")` =
from
> +  `<kunit/device.h>`.
> +
> +### 2.3 Testing Static Functions & Isolating Dependencies
> +Check how the target subsystem exposes internal functions to KUnit tests=
 and
> +follow the local convention:
> +
> +1. **Subsystem export macros** (e.g., `EXPORT_SYMBOL_FOR_EXT4_TEST(fn)` =
or
> +   `VISIBLE_IF_KUNIT` / `EXPORT_SYMBOL_IF_KUNIT(fn)` from
> +   `<kunit/visibility.h>` paired with
> +   `MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");` in the test file).
> +2. **Conditionally `#include`ing the test file** at the bottom of the `.=
c` file
> +   under `#if IS_ENABLED(CONFIG_<SUBSYSTEM>_KUNIT_TEST)` if the subsystem
> +   already uses that pattern to test `static` functions directly.
> +3. **Function Redirection (Static Stubs)**: To intercept calls to extern=
al
> +   functions during a test without refactoring production APIs:
> +   - In the real function (right after variable declarations):
> +     ```c
> +     #include <kunit/static_stub.h>
> +     ...
> +     KUNIT_STATIC_STUB_REDIRECT(my_external_fn, arg1, arg2);
> +     ```
> +   - In the KUnit test:
> +     ```c
> +     kunit_activate_static_stub(test, my_external_fn, my_external_fn_stu=
b);
> +     ```
> +   - If the stub needs the current `struct kunit *`, call
> +     `kunit_get_current_test()` (`#include <kunit/test-bug.h>`).
> +4. **Suppressing expected warning backtraces**: If a test intentionally
> +   triggers `WARN()` / `WARN_ON()`, wrap the call in
> +   `kunit_warning_suppress(test)` and verify with
> +   `KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1)` so intentional warni=
ngs do
> +   not pollute kernel logs.
> +
> +### 2.4 Suite, File, and Kconfig Nomenclature
> +Unless the subsystem has an established convention (such as `fs/ext4/*-t=
est.c`
> +linked into `ext4-test.o`), follow `Documentation/dev-tools/kunit/style.=
rst`:
> +
> +- **Subsystem & Suite naming**: Name the suite `<subsystem>_<area>` using
> +  underscores, without redundant `_kunit` or `_test` suffixes in `.name`
> +  (unless matching existing suites in that directory).
> +- **File naming**: Place new standalone test files in `tests/<suite>_kun=
it.c`
> +  (or match the subsystem's existing `*-test.c` / `*_kunit.c` pattern).
> +- **Kconfig**:
> +  ```kconfig
> +  config FOO_KUNIT_TEST
> +  	tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
> +  	depends on FOO && KUNIT
> +  	default KUNIT_ALL_TESTS
> +  	help
> +  	  This builds unit tests for foo.
> +
> +  	  For more information on KUnit and unit tests in general,
> +  	  please refer to the KUnit documentation in
> +  	  Documentation/dev-tools/kunit/.
> +
> +  	  If unsure, say N.
> +  ```
> +
> +---
> +
> +## 3. Building, Running, and Verifying Tests
> +
> +Build and run the KUnit tests before finalizing or committing changes:
> +
> +1. **Run the test suite with `kunit.py`**:
> +   ```bash
> +   ./tools/testing/kunit/kunit.py run <suite_name>
> +   ```
> +   (If a `.kunitconfig` exists in the repo root or subsystem directory, =
pass
> +   `--kunitconfig=3D.kunitconfig` or `--kunitconfig=3D<subdir>/.kunitcon=
fig`, or
> +   add needed configs via `--kconfig_add CONFIG_...=3Dy`).
> +2. **Verify zero build warnings**: Ensure the added or modified files co=
mpile
> +   with zero compiler warnings or errors.
> +3. **Verify test isolation**: Run individual test cases using glob filte=
ring to
> +   confirm no test depends on state left behind by an earlier test:
> +   ```bash
> +   ./tools/testing/kunit/kunit.py run "<suite_name>.<test_case_name>"
> +   ```
> +4. **Verify test fidelity**: Confirm that the tests actually exercise the
> +   intended code paths (e.g., via GCOV/coverage if configured, or by
> +   verifying that breaking the condition under test causes the KUnit
> +   expectation to fail).
> +
> +---
> +
> +## 4. Coding Style, Licensing, and Commits
> +
> +Follow `Documentation/process/coding-style.rst`,
> +`Documentation/process/submitting-patches.rst`,
> +`Documentation/process/license-rules.rst`, and
> +`Documentation/process/coding-assistants.rst`:
> +
> +- **SPDX & Module Macros**:
> +  - Line 1 of every new `.c` test file must be
> +    `// SPDX-License-Identifier: GPL-2.0` (or the appropriate
> +    GPL-2.0-compatible identifier).
> +  - Include `MODULE_LICENSE("GPL");` and `MODULE_DESCRIPTION("...");` at=
 the
> +    bottom of the test module.
> +- **Checkpatch**: Run `./scripts/checkpatch.pl` on the changes and fix a=
ll
> +  reported `ERROR`, `WARNING`, and `CHECK` issues.
> +- **Commits**: When asked to create a commit, use the `commit-message` s=
kill
> +  (`agents/skills/commit-message/SKILL.md`). Explain what behaviors and =
edge
> +  cases are covered, any minimal production code hooks added (such as
> +  `KUNIT_STATIC_STUB_REDIRECT` or KUnit symbol exports), and how the tes=
ts were
> +  verified. Never add a `Signed-off-by:` tag.
> +- **Report verification status**: Clearly state what was built and tested
> +  (including `kunit.py` and `checkpatch.pl` results), and explicitly note
> +  anything that could not be built or verified.



Thanks,
Mauro
