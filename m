Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1A39AD55
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828992; cv=none; b=Ps/UfpCmYtes2HJwL/+tnuiFZeq5kDOTlHcLS3Jb4cnR2bh4HTWPzap0zprkC23Zejn7viJiKCEdWTV7vwK1VzS6w2Z/kdfgtkoRDSpwMo+dOkrOzsKptVHAJe0VDKo9H+6v7A4xCtU+DRLajAnZx0cSJG80K0BykJYeLCIcDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828992; c=relaxed/simple;
	bh=0iE4B+H/PWOqhBQhrVrQf016Oen26cIaR2ItiNH3ox4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oqtF1gdc0MyAKEqCODnLWJprtYAAxUgz/itQ0qmuxlQ2cI5NwbobSl2n9NpZNECLxJuQVU6qdGVcyG7DcN8gOZXWq4czmKwMUxAnSMWggMlJuLPKOCoMjzQM0E0qTIsLSlsGnZHhm51c2aFrsIjr6s8McEKIk+ZIEWnACt7Kca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB3/yf5i; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB3/yf5i"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so1990013a91.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790828990; x=1791433790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B06JoZPLCNF+l0TL779mHjy3Jv2yuL2a2Q/W5oguOB4=;
        b=YB3/yf5izPetnGw7c4W5BdFlqqiHBlqFFxijosZEuSunuzrQm0h9ChgeT/erCFh+kt
         /Td/HB7MNjqyUrXFclKZscN80V7vRAK5NnkQw4O1zqMNYSldGXiwM6EcOvkBjtvx3459
         mPc3st/Y0fUFrQmJc3r0u1tJbj/Z4FUx9bd/ADpkIvkMZiwng/v8V/a03xGgKLufAdhY
         slDuxVy0N+BGPger96/15/u9gyyWi1MIvVk/ii4wG7WhQJ5bMueJ255ZJF04cEHFCPyn
         ctEJZGVH4x2LiQ1jEJp2e2yJDrkQE0lvsqoOA6Wp7Jzq8tTI4ghNc15/My99tnMXuihu
         WG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790828990; x=1791433790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B06JoZPLCNF+l0TL779mHjy3Jv2yuL2a2Q/W5oguOB4=;
        b=F+bpu1cv9mmWHapjM7pXgMzbL7QWTnY4ZK8JB6h/thlyZcpNGHu8ImexbrxgclMaqA
         0krKUTTVcMuvcvfrm2XuzAUSx//yxySNvZ2xa1ITosWY7qIXkmIl0qdsDJyB9xarxHU6
         vbR9h8o7KRYVh6aRQhnYx4Z7RHyDgZaRulbHxUia9+EUxC/t+cogJZKEhRJYQOl2xQRD
         fpTCYGOYJeDRpzPy2qS5WtuwsOZ5kGYIPc+xgSoykXgZATKmcYg1xXQxtxBlhttkxY/2
         t5vfjWOEYSsdrUwS8/LKuYxAGpXOgd3fDXpP7yh3momG+O0bsUT4GJn977D9vVYjLirh
         dKVQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0VRVHM1YDRCl0iIhZ7nhwHadhjPNV7Myix2aggWGqtOO+k0CuV9mTsQrzpvWbBpK1Yif9epY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/Txv+vfKmMQM/czV9Rs8l3La4aX9FhGLuMuespBqG8Ui8lA7K
	MB5pFCYv+4ToedFmJlsgDRwp5Vx8nXHX4pIN4nq3o6lrHVgaaouD1ns=
X-Gm-Gg: AYBFou0+Ovh0/BE+fJo9QVqxmC5ePAFWXQk0foM1dK8Y2gDM2QjTayEValcQLgP17DL
	BziTw5ybVqquPzfHftxmNqo9zvNhIJh742eUMsnArENuoXyFaarwi+upA6SyNZs4qhmyel5FDcG
	VerZ899cPkJ3u9EIZ17TKUEyCYRoyzoQK/4Uul1N09AL+2MpsHP2clhCjdLuc0hxDAAiJvWXMN2
	OphKeVFseH6Eq5oH6dBWTEm8RpQ4i8CblUwpwR02uRveXamWdcs7ec3rI1ViRDj62GG1qeXRgNq
	FRVfmOq+C7rM2bsmZj+5ADoNDedEhUeyZWB9WX9AGvQgVLg6BG3uqfC/yolhsY2W7jb5WsSrD4P
	RYaMmxr9/msO13V5nq6DYR7fYIV4W4rruvazhpnZ6dcySyVtQDRk0i5iAib8n38IvAGF0eT3AJQ
	LHmXeMVxjsg3s1ng+IFqCDUN2dGHdiHlX/LWNJAPwJ7AgizpAOg1IYHSw8cT7pNbMgBQT8j6/ou
	VRM9H/teX6B+X7Y221aDYpXlpU+BohzCxecmw==
X-Received: by 2002:a17:90b:5343:b0:3a4:c8d2:6c2c with SMTP id 98e67ed59e1d1-3a4d18e5bfcmr1354421a91.49.1790828989566;
        Wed, 30 Sep 2026 21:29:49 -0700 (PDT)
Received: from WIN-2DEDQG69EF6.localdomain ([139.180.198.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f43a12c9sm2600392a91.2.2026.09.30.21.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:29:48 -0700 (PDT)
From: chenhan <chenhan0017.work@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: a.hindborg@kernel.org,
	boqun@kernel.org,
	fujita.tomonori@gmail.com,
	frederic@kernel.org,
	lyude@redhat.com,
	tglx@kernel.org,
	anna-maria@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	miguel.ojeda.sandonis@gmail.com,
	tomo@flapping.org,
	georgeandrout13@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] rust: time: make Delta division and remainder fail consistently
Date: Thu,  1 Oct 2026 12:29:42 +0800
Message-Id: <20261001042942.109012-1-chenhan0017.work@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delta's division and rem_nanos() use Rust operators on 64-bit and C
helpers on 32-bit. The report shows that rem_nanos(0) can return 10 for
a 10 ns dividend on ARMv7, while the same call panics on x86-64. The
i64::MIN / -1 case also differs, and neither API documents these inputs.

Use Rust's signed division and remainder semantics on both architectures,
as discussed in the report. Div should behave like i64 division, and
rem_nanos() supplies the corresponding remainder operation with a 32-bit
divisor. Both reject zero divisors and i64::MIN with -1, even when Rust
overflow checks are disabled.

Check these inputs before entering the architecture-specific code and
document the panic conditions. This preserves the API signatures and
valid-input results, but intentionally makes invalid inputs panic on
32-bit too. No in-tree callers of either API were found at the base
commit. Correct the rem_nanos() parameter name to divisor as well.

Tested on x86-64 and ARMv7 QEMU with a built-in Rust module that passes
runtime operands to both APIs. Separate boots verify each panic case;
valid-input tests cover mixed signs, signed extrema and full-width
division operands.

Fixes: 4521438fb076 ("rust: time: Implement basic arithmetic operations for Delta")
Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1254
Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-5869573842
Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-5869925737
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: chenhan <chenhan0017.work@gmail.com>
---
Changes in v2:
- Put the checks directly in div() and rem_nanos(), following Tomonori's
  suggestion. Each proposed helper had only one caller, and no other
  concrete users were found to justify a math module.
- Move # Panics onto div(), remove private-helper references, link the
  integer types, and describe each API's input domain separately.
- Explain the arithmetic and pointer conditions in the SAFETY comments.
- Add Georgios' Reported-by and all M:/R: contacts requested by Miguel.
- Cite the issue discussion establishing the intended panic semantics.
- Replace the local CONFIG_SAMPLE_RUST_REPRO name with a description of
  the test; the API calls and expected results are explained below.
- Base this revision on timekeeping-next at 2ea0119f72db, preserving the
  new to_jiffies_timeout() method, and rerun x86-64/ARMv7 validation.

Caller audit: no calls to either API outside their definitions were found
on the base above or rust-next at c82c75ae11fa. This covered tracked Rust
sources, including drivers, samples and lib, using named-call searches
and inspection of division expressions in Delta/Instant users, including
elapsed() results. Time-unit conversions use fixed positive divisors;
to_jiffies_timeout() uses an unsigned multiply/add/divide helper;
num/bounded.rs operates on generic integer types. None provides a concrete
extra user for the proposed signed helpers.

I kept the stable Cc as suggested. The 32-bit invalid-input behavior does
change, and I have not identified an affected in-tree caller or audited
all stable branches. Please let me know if this consistency fix should
not be backported.

On the MIN / -1 safety question: div_s64_rem() computes a quotient even
though the caller discards it. V1 already checked this input before the C
call; v2 keeps the guard and makes the representable-quotient condition
explicit in the SAFETY comment. Rust's signed remainder operator panics
for this input even though the mathematical remainder would be zero.

Testing: CONFIG_SAMPLE_RUST_REPRO in v1 was a local Kconfig option for
samples/rust/rust_repro.rs; neither was included in that submission.
The built-in module read dividend: i64, divisor: i32 and an operation
selector from module parameters during init, then evaluated one of:

    Delta::from_nanos(dividend) / Delta::from_nanos(i64::from(divisor))
    Delta::from_nanos(dividend).rem_nanos(divisor).as_nanos()

For v2, an expanded module passes black_box operands to the actual Delta
APIs. Each architecture has a valid-input boot with 26 division and 21
remainder comparisons, and four separate boots for the panic cases.
The following core cases pass on both x86-64 and ARMv7:

    dividend    divisor    division        remainder (nanoseconds)
    10          0          panic           panic
    i64::MIN    -1         panic           panic
    10          3          3               1

Further valid cases include mixed signs, i32::MIN divisors,
i64::MIN/i64::MAX dividends and full-width i64 divisors for division.
Both configurations have CONFIG_RUST_OVERFLOW_CHECKS=y; I have not
boot-tested with it disabled. The added checks are unconditional.

For the identity question: chenhan is the identity I consistently use,
and chenhan0017.work@gmail.com is my email address. I also participate
in issue #1254 as WindDevil on GitHub.

 rust/kernel/time.rs | 46 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 5ae377e70dd8..31a1c95bc786 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -412,8 +412,20 @@ fn mul_assign(&mut self, rhs: i64) {
 impl ops::Div for Delta {
     type Output = i64;
 
+    /// # Panics
+    ///
+    /// Panics if `rhs` is zero, or if `self` represents [`i64::MIN`] nanoseconds
+    /// and `rhs` represents `-1` nanosecond.
     #[inline]
     fn div(self, rhs: Self) -> Self::Output {
+        if rhs.value == 0 {
+            panic!("attempt to divide by zero");
+        }
+
+        if self.value == i64::MIN && rhs.value == -1 {
+            panic!("attempt to divide with overflow");
+        }
+
         #[cfg(CONFIG_64BIT)]
         {
             self.value / rhs.value
@@ -421,7 +433,7 @@ fn div(self, rhs: Self) -> Self::Output {
 
         #[cfg(not(CONFIG_64BIT))]
         {
-            // SAFETY: This function is always safe to call regardless of the input values
+            // SAFETY: The divisor is non-zero and the quotient is representable.
             unsafe { bindings::div64_s64(self.value, rhs.value) }
         }
     }
@@ -614,16 +626,33 @@ pub fn to_jiffies_timeout(self) -> Delta<Jiffy> {
         Delta::<Jiffy>::from_jiffies(jiffies)
     }
 
-    /// Return `self % dividend` where `dividend` is in nanoseconds.
+    /// Return `self % divisor`, where `divisor` is a number of nanoseconds.
+    ///
+    /// A non-zero result has the sign of `self`, and the magnitude of the result
+    /// is strictly smaller than that of `divisor`.
     ///
-    /// The kernel doesn't have any emulation for `s64 % s64` on 32 bit platforms, so this is
-    /// limited to 32 bit dividends.
+    /// The divisor is an [`i32`] because `div_s64_rem()`, used on 32-bit
+    /// platforms, takes a signed 32-bit divisor. The dividend remains an [`i64`].
+    ///
+    /// # Panics
+    ///
+    /// Panics if `divisor` is zero, or if `self` represents [`i64::MIN`]
+    /// nanoseconds and `divisor` is `-1`, matching Rust's signed remainder
+    /// operator even though the remainder would be zero.
     #[inline]
-    pub fn rem_nanos(self, dividend: i32) -> Self {
+    pub fn rem_nanos(self, divisor: i32) -> Self {
+        if divisor == 0 {
+            panic!("attempt to calculate the remainder with a divisor of zero");
+        }
+
+        if self.value == i64::MIN && divisor == -1 {
+            panic!("attempt to calculate the remainder with overflow");
+        }
+
         #[cfg(CONFIG_64BIT)]
         {
             Self {
-                value: self.as_nanos() % i64::from(dividend),
+                value: self.as_nanos() % i64::from(divisor),
             }
         }
 
@@ -631,8 +660,9 @@ pub fn rem_nanos(self, dividend: i32) -> Self {
         {
             let mut rem = 0;
 
-            // SAFETY: `rem` is in the stack, so we can always provide a valid pointer to it.
-            unsafe { bindings::div_s64_rem(self.as_nanos(), dividend, &mut rem) };
+            // SAFETY: The divisor is non-zero and the quotient is representable.
+            // `&mut rem` provides a valid, aligned pointer to a writable `i32` for this call.
+            unsafe { bindings::div_s64_rem(self.as_nanos(), divisor, &mut rem) };
 
             Self {
                 value: i64::from(rem),

base-commit: 2ea0119f72dba597aa8a98cbdb72c564bfc5cb38
-- 
2.34.1
