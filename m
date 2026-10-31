Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442760;
	b=SJ2xMA49dm2bPTDgnt88zbdKYNWuGmd/xhI161EPPFzDTb79/p/0sK3/M6kxbbRzzfsj
	 v8ooIZHnBq7ffB4g6Kj9Aa2r1Ahv16E1O0rrRpH5qSAyr2KbI/WyYrZMQdK175mwwC3Dm
	 49I573Sd9HCOqMxeShTeLGt9gDVfJMOjeKFHVtqRO1Sc5mgVRGfWS2RYVsYYYqdT485v8
	 vi5Vmua0ZlqEDIPqe/fNu0O4LyVmv00Q2H9RBkzMFkUj5ydu+lIjSMz4JIogT+9vFcash
	 JPGSqqCO2PB4/0dgUl4ZEJVVOSPssH02+tNtwtY3LlUGVcRm7IilPO+WZtTHavkVB9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=72vAZbtr72IoRLAfliiOOLU1MN2tQzGpQYioVXZGm+A=;
	b=nNBExTPghw1z/wZ8eDGDndtC7doLNeRoXb3jU/IN17my5lUmdyeMM+j/YcDV8RzEs+3p
	 etCxAEeBUhwqhg1Yjjo3Vv1aXgwbTzS0nEWbchDciCIScPkDRoyIZqFzy8lugptSrnR2Z
	 wx/DlSkP8RKYwUI8sCrdVrAYWrpB4YEzUTuIujt2pMUgN9HL7rcgr0hM4estHroPyWn+X
	 VHPoptSRcR+M8qXQSR5Z14c/dfdiwBH5EN4d7pg7W7fiyQA3ymR+9ZRrRd0xMRzGky6bF
	 5LcllFLilzFwHp9uSO8c13kmb8kaRQAcBCdh3uRfAEFZAWR3EQq2kPSOrjrZB1XHPPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJla+Xvp;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB2606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 10:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FAB2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJla+Xvp
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ea993271f2so6643355ad.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 03:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442760; x=1794047560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72vAZbtr72IoRLAfliiOOLU1MN2tQzGpQYioVXZGm+A=;
        b=qJla+XvpYJ0n1wOLTp/vA2I0Ph+g/WlxhHj1aX+Gq5FJ3rMIl70HU68QPsOxrFNtMf
         O2d6voG8y7BCFxbNA+HSDr54SHoH8qKQFBMGGvNSaGjpa78feZIva4C5dL39+UdBHCH7
         nQSLGLQ6rBz7eMaJS4A8fys6ZViwQWuEzNhk6E3OUSPwfdUnS8sf/TVgDrekMFW/duJL
         JWoqKcASrAoFQAyJJBZbg5BYxIb//X6sotaKjzYyXeuMgLvaZEWxOmcHNbz5X5FIpD60
         Yvx8LAJbPkN6Pc3npLSHd70Nv0grvVcexKzUMEsaXkGt+iMpHMacdrB5E5FDHuY3f/nU
         1QSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442760; x=1794047560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=72vAZbtr72IoRLAfliiOOLU1MN2tQzGpQYioVXZGm+A=;
        b=AM2Gdp4UC1qfWOPY08nBkYhuGxpXuVRSBgmtmKwPtaa+ZV3jLctINVty46f5XFzQgQ
         0JW1SdUrJWVgrSAJCvkdphirJ+qUkAyEWINONjyihmVopCn2/VsT20htYHaaYbYHiIly
         aBO69rOIYr0nEtWn4u7a6jeE2zbb8MkzpnEQx2TYejzfYGuMU5ri3dCGrR4ERvR+7DZn
         hK8hkwT0ablSwG/JolbP4F/PQqM5qlhbieCsrBUqxxRQBVZ2AJbPssqkA9+mprl0u2bQ
         WQm7qX2WLBFKLzwgYMl1jCTLYAgjcvs53OoCn2FyEF8PT0ZVuRxY6cFm6aWlaSQtxfp3
         zGRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxP1M2laN6bDaRLm60pmlzK8vVQBBP70mUOR0RR39dTyaAzp1ygJe09wwcPYkVE9yqJmYg3oDI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAuVZYc3awJ2RhKcPkbIIVnzGGWR1eHgE9jjgDGp9GYC3pSKTr
	HGL7n6XySpDO0AHXiQNZGw4h/9EIYhLWVqVHGyWvZS8wHGUS4lskgeA=
X-Gm-Gg: AYBFou34DtTuXGMFDjgHCzgWqCQVko1cRnpdoznObE59HHWjqo/mVCRCMk7VCvsbfWb
	Xefoojep4a5X+0+vwNjNZn/nxfF8EQpCsYHvcWvY4r6bWQFCjGWZTMpCRsVJyh0zqFWC6bv2BDi
	EkIV0/fiPyd/hkOwkVSRy1qf5N/Rwcs+Zq7l31cI9bBfieAVc3s8qlx9wSGo67FJdMceaiZ6QB5
	v9DKQvvR2CwkhjvAkg7CG8g9kNipakwXq8IOcdIrIWTjp9ifGCzdRU0ptxcF0kDoIqyJVTlEhVX
	wPQDMumNHa3CcCzVoOr3Rc86U1KIrZxI9CrjNR63zjeDUedN1JSyqK44Llu6WllY27zW0vOhXKp
	hhTvqiwRMDm+JPN6SyDPz4N+ztw26FMDkfRmt5kI1tMAAvEpCtx2Q6rq7XptjMh04zGUoaV51O2
	RCmcv/qIzEmupX6JQ7wf99DzseesWKcd9N6nRCHXajINrt2jStLhKmruSnoaInz/qiFJ1gKQwy6
	2UZj9T2bhS9P5VyfEsbd/jwz9nY+AZAyD1a2nLzt19aRcfLezE3c7LfEGfS7otPq/mjFWtGjqD1
	YI3E/k9YdbpfrSZ0j6yLGiizemVVvNrlNKC6JN4cfnm1mZuBim4oNEG7imqx6A==
X-Received: by 2002:a17:903:298f:b0:2e9:66c4:1713 with SMTP id d9443c01a7336-2eb3647f79emr46870175ad.58.1793442759516;
        Sat, 31 Oct 2026 03:32:39 -0700 (PDT)
Received: from WIN-2DEDQG69EF6.localdomain ([2a13:a5c6:1ff1:280f:be24:11ff:feb0:8690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3928104asm14817275ad.53.2026.10.31.03.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:32:39 -0700 (PDT)
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
Subject: [PATCH v5 2/3] rust: time: make Delta division and remainder fail consistently
Date: Sat, 31 Oct 2026 18:32:05 +0800
Message-Id: <20261031103206.24051-3-chenhan0017.work@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031103206.24051-1-chenhan0017.work@gmail.com>
References: <20261031103206.24051-1-chenhan0017.work@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delta's division and rem_nanos() use Rust operators on 64-bit and C
helpers on 32-bit. The report shows that rem_nanos(0) can return 10 for
a 10 ns dividend on ARMv7, while the same call panics on x86-64. The
i64::MIN / -1 case also differs, and neither API documents these inputs.

Check for zero divisors and i64::MIN with -1 before the architecture-
specific code, and document the panic conditions on each method. This
matches Rust's signed division and remainder operators, including when
overflow checks are disabled. Valid-input results and API signatures
are unchanged; invalid inputs now panic on 32-bit too.

No in-tree calls to either API were found at the base commit. The checks
stay in the existing methods so the fix does not depend on introducing
a math module.

Fixes: 4521438fb076 ("rust: time: Implement basic arithmetic operations for Delta")
Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1254
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: chenhan <chenhan0017.work@gmail.com>
---
Changes since v4:
- Explain that the preceding zero-divisor check establishes the C call
  precondition; keep MIN/-1 checks for Rust panic semantics.
- Retain the output-pointer validity explanation for the remainder call.

 rust/kernel/time.rs | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 16b44e82d2ac..c9a2dc50ff4c 100644
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
+            // SAFETY: `rhs.value` is non-zero due to the check above.
             unsafe { bindings::div64_s64(self.value, rhs.value) }
         }
     }
@@ -615,8 +627,21 @@ pub fn to_jiffies_timeout(self) -> Delta<Jiffy> {
     }
 
     /// Return `self % divisor` where `divisor` is in nanoseconds.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `divisor` is zero, or if `self` represents [`i64::MIN`]
+    /// nanoseconds and `divisor` is `-1`.
     #[inline]
     pub fn rem_nanos(self, divisor: i32) -> Self {
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
@@ -628,7 +653,8 @@ pub fn rem_nanos(self, divisor: i32) -> Self {
         {
             let mut rem = 0;
 
-            // SAFETY: `rem` is in the stack, so we can always provide a valid pointer to it.
+            // SAFETY: `divisor` is non-zero due to the check above.
+            // `&mut rem` provides a valid, aligned, writable pointer for this call.
             unsafe { bindings::div_s64_rem(self.as_nanos(), divisor, &mut rem) };
 
             Self {
-- 
2.34.1

