Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019529;
	b=unPYiICgwyQqw18IqwbigY0l8Ps4gprzwE81SX5AcH6J+ZsKwQkDGhMpzE6XSghpnDsk
	 O0Kc7Qt5pVqgQl0M5tipw39Kz2XIXtntHqmMPZdVCAqwprJeJ6BgsfbjmXmpZ8rucWF8c
	 lddKMrNPqsxqmgblD7qEKc9a7XlKWoBedwPle/VbmAKytV+mqXppNzCq8T70c5B5XOtHB
	 QgslxVHJFyvOKqGaDAvVGTtYdDqS8VPZptqR3DRQpXzxp9reGsq6j5LNA2ZqyaYv9lIPg
	 vUb47eYSLYmOq1rlqs2XcjEyNjO94SJe7ou/TSXjIKCBumVO3Km0GV0NA0Im8mkLp0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=1AcPxe8YD9t4RV8npHRzFGvkXCba4Ptv/GRveQw64xk=;
	b=pS+MgC9padNT58N5croSHIgsCkd7prNyaL078zSVPVoaCzK6wZ23o7PPgdd8QeJsd8hS
	 j3Xm0vb7KW96hYK6qDcDDoH4Hns4RFzFU6urJ3QhlWP8V/m1Tf08HXSE5ZolPRNCF76GP
	 nUriWzBW/2xJfCKkwDsxsf21ehqepERrms+wamr4OuoVdo4239pNOXzg94p878RDQjGwB
	 Nu2DAjanqdCVAzOQjkdcfq+LTdyxDErWJnFzFpX+1FxEO/E5LP6XUFI/8fnA2E3W4d62G
	 R6sD/yCk2bDRqUfpDp5XhnLj21Zv24A40pr3wfhuex9UG1bkmHgJsiHxXs3fZLm3dOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkYTrHBt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69D606A326;
	Mon, 26 Oct 2026 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkYTrHBt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AB31F01825;
	Mon, 26 Oct 2026 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793019529;
	bh=1AcPxe8YD9t4RV8npHRzFGvkXCba4Ptv/GRveQw64xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SkYTrHBtnhMCcCk9oA3UT22C+yXYFPA5MynIsZMPLs5t0UYLyg3NmXqSWG2RCi+Bx
	 ZDWPwev7WT+akDxc63PkPECOilkNVeyJQZvq9/1GJyDP1jXEG8mMZRw08JX6J+llbB
	 SLFAN0XOb0Oi3N3ForFsU//0MHKDW4DUxdIdjcVQVb5pd05ajDav8EersdxLDkQqC1
	 icJTZFLoOTD73TkZv03usW0NCTPHG05p+418aE48/XRuaWaPMZxGiKNYeqmEPR58Io
	 0ba3Nx7Xc3xteumaaLaj/pKiG3t68eUbmwBT9IZUUgM5uhfn1bkUBmBwM/rRoB6YAD
	 l/duhPOFI7HIg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: chenhan <chenhan0017.work@gmail.com>, rust-for-linux@vger.kernel.org
Cc: boqun@kernel.org, fujita.tomonori@gmail.com, frederic@kernel.org,
 lyude@redhat.com, tglx@kernel.org, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 miguel.ojeda.sandonis@gmail.com, tomo@flapping.org,
 georgeandrout13@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: time: make Delta division and remainder
 fail consistently
In-Reply-To: <20261023130413.178487-3-chenhan0017.work@gmail.com>
References: <20261023130413.178487-1-chenhan0017.work@gmail.com>
 <om4kxbW6RonEr7EJOnn5nizbkBZi1B662AdSPv_iWS7XNJXuPCDAsOeWG0SMSeK7XqoTrwOPzwMC1jS2nKknXQ==@protonmail.internalid>
 <20261023130413.178487-3-chenhan0017.work@gmail.com>
Date: Mon, 26 Oct 2026 13:53:26 +0100
Message-ID: <87bj8goc6x.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"chenhan" <chenhan0017.work@gmail.com> writes:

> Delta's division and rem_nanos() use Rust operators on 64-bit and C
> helpers on 32-bit. The report shows that rem_nanos(0) can return 10 for
> a 10 ns dividend on ARMv7, while the same call panics on x86-64. The
> i64::MIN / -1 case also differs, and neither API documents these inputs.
>
> Check for zero divisors and i64::MIN with -1 before the architecture-
> specific code, and document the panic conditions on each method. This
> matches Rust's signed division and remainder operators, including when
> overflow checks are disabled. Valid-input results and API signatures
> are unchanged; invalid inputs now panic on 32-bit too.
>
> No in-tree calls to either API were found at the base commit. The checks
> stay in the existing methods so the fix does not depend on introducing
> a math module.
>
> Fixes: 4521438fb076 ("rust: time: Implement basic arithmetic operations for Delta")
> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1254
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: chenhan <chenhan0017.work@gmail.com>
> ---
> Changes since v3: none.
>
>  rust/kernel/time.rs | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 16b44e82d2ac..4415e91a5227 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -412,8 +412,20 @@ fn mul_assign(&mut self, rhs: i64) {
>  impl ops::Div for Delta {
>      type Output = i64;
>
> +    /// # Panics
> +    ///
> +    /// Panics if `rhs` is zero, or if `self` represents [`i64::MIN`] nanoseconds
> +    /// and `rhs` represents `-1` nanosecond.
>      #[inline]
>      fn div(self, rhs: Self) -> Self::Output {
> +        if rhs.value == 0 {
> +            panic!("attempt to divide by zero");
> +        }
> +
> +        if self.value == i64::MIN && rhs.value == -1 {
> +            panic!("attempt to divide with overflow");
> +        }
> +
>          #[cfg(CONFIG_64BIT)]
>          {
>              self.value / rhs.value
> @@ -421,7 +433,7 @@ fn div(self, rhs: Self) -> Self::Output {
>
>          #[cfg(not(CONFIG_64BIT))]
>          {
> -            // SAFETY: This function is always safe to call regardless of the input values
> +            // SAFETY: The checks above exclude a zero divisor and `i64::MIN / -1`.

Why change the safety comment here? If the function is always safe to
call, the exclusion is not relevant. Was the old comment wrong?

>              unsafe { bindings::div64_s64(self.value, rhs.value) }
>          }
>      }
> @@ -615,8 +627,21 @@ pub fn to_jiffies_timeout(self) -> Delta<Jiffy> {
>      }
>
>      /// Return `self % divisor` where `divisor` is in nanoseconds.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `divisor` is zero, or if `self` represents [`i64::MIN`]
> +    /// nanoseconds and `divisor` is `-1`.
>      #[inline]
>      pub fn rem_nanos(self, divisor: i32) -> Self {
> +        if divisor == 0 {
> +            panic!("attempt to calculate the remainder with a divisor of zero");
> +        }
> +
> +        if self.value == i64::MIN && divisor == -1 {
> +            panic!("attempt to calculate the remainder with overflow");
> +        }
> +
>          #[cfg(CONFIG_64BIT)]
>          {
>              Self {
> @@ -628,7 +653,8 @@ pub fn rem_nanos(self, divisor: i32) -> Self {
>          {
>              let mut rem = 0;
>
> -            // SAFETY: `rem` is in the stack, so we can always provide a valid pointer to it.
> +            // SAFETY: The checks above exclude a zero divisor and `i64::MIN / -1`.
> +            // `&mut rem` provides a valid, aligned, writable pointer for this call.

Again, was the old safety comment wrong?

Once kunit supports the `#[should_panic]` attribute, we can assert the
behavior on all platforms.

Best regards,
Andreas Hindborg


