Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631360;
	b=N7CqZYlV09NZnUpVbxov6pORYL/4ituuf+P/M+qoGnpQtzkeTzjewbWWsv66C4W2P8Oy
	 ku5+tEYkia8LIsCG3pee9bErSaqbTZAce3NFYT3nI7ZBonpTvUvN+K/g6NqGPHWWCXKSz
	 q4iNrMnTobQzmcuREGUJufobm16qgv1IYk33j3dKK1EIGuVvhC0GFD0GKCVVKqCj6f1NX
	 uSM7Hxfx2DvXgSs7KOwHXkl0fHr8E0wxtIuN9+DolgqyeCVu/SZTs7Uu8Bgpwy9ZKkDCN
	 DBAw/ORVOmxkH4GXzm/hhuTUf6gXWLjIUJzNHThfTRuoWBd/FMs2zlAfjgVhyOlBtYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=MPec9+oZOl3NUF/zdJzqxPG2IuL/zAra5tVbTfu2gTI=;
	b=m/xyMpruqfMaMsUxqd4wA2q7/BBqhkASt127c4CuNTYWOOruF2O//84H178K0foHFI3M
	 0HukK7HCGAjQdJxPyHgtOTw04vwEcUqzW1dTwiTqHK5WxGTLQgoVe7B1XmcAd9U40LWza
	 bnGjqfnEBr8kO/91n2xe9xSGAERK+Wmw0YirpebZQ0SxBolzRmzo0+ouQ280hZHJKbCAP
	 sgMbaHt3lDGHtIZTJBjWbyRZ1XAbcHj7ZiXgucPj1uMxCE0z98sfLVcVA8XXkGjaRtpbU
	 0m6GybE5VGQV9gbzqs8YAhfvjvRFq6EJHorCvMSFHuTH6BMVqeyKpHLaIilgQ2Vxx0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iNz6/pKc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC4606F3C6;
	Mon,  2 Nov 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNz6/pKc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5968D1F00A17;
	Mon,  2 Nov 2026 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631360;
	bh=MPec9+oZOl3NUF/zdJzqxPG2IuL/zAra5tVbTfu2gTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iNz6/pKcCyOMBU4Z5dqXpPGbVTXupCPKYHhA8n+/Kxpl0xPSfrnruRurU5XYB1ME5
	 1Ayzi7TURQnw9xYp42q/NjQeosQT8GGFuk+ViWSHCLTzgrYjp1hvbdSklbBz2OiGH2
	 slrT02oWUX6NSSe30gsWc0CDYU/YaSpBgSJHGWM6fXFzzsfc88bEgMOBw7VGashcao
	 kt8v3WICcuUB7WQ5iqCK5ShHZJusZ10BZCJlDou3x/hwR6vP2kPAilOQU2BZIcRbKj
	 PXJp+EGgxFrhiCr4zsFlXEjGiWRmLG7VhsksfhKYclYhG/ifzfPlmnWJK+1jG/U0X0
	 AdffInxJpZ04w==
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
Subject: Re: [PATCH v5 2/3] rust: time: make Delta division and remainder
 fail consistently
In-Reply-To: <20261031103206.24051-3-chenhan0017.work@gmail.com>
References: <20261031103206.24051-1-chenhan0017.work@gmail.com>
 <9rgWozT8EB7LL-tasC5IweVXppzvHxYie6ulSGjv_GuH2l4kNHHLFucqa0f9BtPX9RmZg2tUxBp2EljFlxokEA==@protonmail.internalid>
 <20261031103206.24051-3-chenhan0017.work@gmail.com>
Date: Mon, 02 Nov 2026 15:51:45 +0100
Message-ID: <87mrrrmgla.fsf@t14s.mail-host-address-is-not-set>
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
> Changes since v4:
> - Explain that the preceding zero-divisor check establishes the C call
>   precondition; keep MIN/-1 checks for Rust panic semantics.
> - Retain the output-pointer validity explanation for the remainder call.
>
>  rust/kernel/time.rs | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 16b44e82d2ac..c9a2dc50ff4c 100644
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
> +            // SAFETY: `rhs.value` is non-zero due to the check above.

Please add to the commit message that this safety requirement was wrong,
and the commit fixes it.

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
> +            // SAFETY: `divisor` is non-zero due to the check above.
> +            // `&mut rem` provides a valid, aligned, writable pointer for this call.

Same.

Why did you change the wording of the original line?

Best regards,
Andreas Hindborg


