Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1073803DC
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792235526; cv=none; b=LH/Y25yz/h3gzrJTb+MQIkRaAuiQmK0LvR1yr0509oZWHWO50iDiVqDEaBsrEPhkw0181oYpe4ca5KfgKznbItdf4Ge8IOiFCu/Hydolq6njXoKpQ6G2pxGRcAwfUrcqALeoW4ISAkCGrM/fTTpo3XdFwtGbtbgvQe2KouKo4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792235526; c=relaxed/simple;
	bh=uh9SS2WMqmUt4cpgp+wv9TrfsT1TAr44dlN+wtjyrDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohxUNUal/u93Nq8YwDK7cZLk72jmvc/n6Q9+jVqrjdyJyZQblu35TdRUG+XHgp4kFceol25U8G4RGKj1tR+9BwmWJhuh9CC6uJe6dy4O4FF0X4iSGO1b6BOV0jYyP6+saxZObtES9+EAR8BtIWp8DkB5QWotp8SzNvS4Daujkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqKXqkfM; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqKXqkfM"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3abe4fb64d2so507121a91.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792235523; x=1792840323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkH44/WMax9Nf0vxizpHzIgEQxchbF7m2t+NOJIeX+U=;
        b=RqKXqkfMYuK9PqL/ckYuiIt9u/yhe2Ba/XfDmm6534ciUbcVjOsBjdOFDl7zV1Um+b
         rU4TpVAetDUl+IMJksQleLN008FVLZZ/GwRpAWaTitFfRPrkuZtoVZ0fObEECmbSgRGh
         VZvNEAOVzNYzN7qrIl19F2AJgyS+ihWX7cvwgk/Iwwp61ADyZDBEswwfDDvVoBXJiHLK
         +GRVI+GJ277QxRcNe36y9qK7drJF8O2NvkHplFwQ5+gRL3CaPa/G+mGTq4BwEvqtOBPN
         Ol3eGNUO/KSNnVzsIG4QHXODKxCzFfaYM4s61vcvjvHI7xSdIkcNhKVd3+9OObjhEpjr
         YiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792235523; x=1792840323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VkH44/WMax9Nf0vxizpHzIgEQxchbF7m2t+NOJIeX+U=;
        b=N15rZwFQU7djtZV2QrgshQlhr8FfLLO4KRjYGSw2XYRQRd5qdsWebS9MkDiimnSl2t
         eBQ1dXRIoCo20NXIOe3tEmAX7OFwDwijhIzOA4jU2hjp8SxMCxySJnL8V/Mtc2PqI4g/
         Vvt2W0Lwb/AwqzlDRIBGedq+VLX9HTRR9Bn5dUgmdIruNmuUyopJtbDskFpqHcR0bZ7X
         M5tv1/EBBAsSOyDjs0c4SGfL1JPDkoSpZoViUgNcpl6wnPR7q6lk09J8NRfLEKL1XDXe
         H9MA4ubF/BnFWdmSEWLYAW1kzfswbWzHz7vsS/uymVyauPOrCiEY+tshnd43R++gmWtL
         HpIw==
X-Forwarded-Encrypted: i=1; AKwUvBwu+PJMgRzvV333cf1um67+I3G7M6CQl4Vu2ixz0orOXTjNHHlsEdfe6DxpkXymKBLAn07KOTs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZGj0fQAfUpccePlNpV10IO98uzKfk0/8VRcPrQJD/0OgB6PFQ
	Z9s4nrmPLS5J3h+m5C/HZpU2FWnP63szV9aVE3suDrAtm2gJ9amvtJU=
X-Gm-Gg: AYBFou3C4ird8QsVFdRUPZ3VS3vYABnp8QDBvN2vTieR47BVjmOaePjiQ08qh/sjGfP
	00bkcD+IQWfFR7lkxEGHB8R7yJ2UKlQaQZitgCok9OTuuK2ySN4GyWOLqRauJ7eCWrZuzKtAA2b
	2yXJOk5ftvNUWiNYXP71Ti4jBXeSwgLPSjYIsE8GVXc4ED6cNHnvcnqDGugUuM/hpNnnnzbPBJd
	R/S0rJgBqtJf1LdXdPmndQlbhB6N10FwkEU+3p0cn+tjdlWoL8ZVQ+hquvMFnxohA1ez2WIjfCj
	ZilFSRS0ZkfKKmSZWiSGzJPKPjgI1yfBI5aPFCUNh57VF+8//XNWPmtgbIA4CC1Xxj28/Pr8drV
	R7I+9nrudslx9IemCAMttf1m53aMglpqdvgB0R0cC0/BueCBn98h+xut5+/wj1r0oe11ge1rP5S
	v/F+COSSzSpcCrKWjERtXrpuElhRCsRfh8hJWhd8mySZZaw/v7/VTC6t6ZQaIsEKWcoJfBNA1NV
	2LgJJv0Kgap+9FLcHR5vIO4O6nR
X-Received: by 2002:a17:90b:1f91:b0:3ac:38dc:6b9e with SMTP id 98e67ed59e1d1-3acef13e57fmr1849616a91.25.1792235523056;
        Sat, 17 Oct 2026 04:12:03 -0700 (PDT)
Received: from WIN-2DEDQG69EF6.localdomain ([2a0c:9a40:9205:1:be24:11ff:fe93:ff0e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd403c212sm2974687a91.4.2026.10.17.04.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 04:12:01 -0700 (PDT)
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
Subject: [PATCH v3 1/3] rust: time: rename the rem_nanos() divisor
Date: Sat, 17 Oct 2026 19:11:32 +0800
Message-Id: <20261017111134.22546-2-chenhan0017.work@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261017111134.22546-1-chenhan0017.work@gmail.com>
References: <20261017111134.22546-1-chenhan0017.work@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The argument to rem_nanos() is the divisor, while self holds the
dividend. Rename the argument and correct the documentation. Drop the
architecture-specific implementation explanation from the public API
documentation; the argument type already states the divisor's width.

This does not change the function's type or behavior. It is a preparation
for documenting and checking the invalid divisors in the next patch.

Cc: stable@vger.kernel.org # prerequisite for the Delta division/remainder fix
Assisted-by: LLM
Signed-off-by: chenhan <chenhan0017.work@gmail.com>
---
 rust/kernel/time.rs | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 5ae377e70dd8..16b44e82d2ac 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -614,16 +614,13 @@ pub fn to_jiffies_timeout(self) -> Delta<Jiffy> {
         Delta::<Jiffy>::from_jiffies(jiffies)
     }
 
-    /// Return `self % dividend` where `dividend` is in nanoseconds.
-    ///
-    /// The kernel doesn't have any emulation for `s64 % s64` on 32 bit platforms, so this is
-    /// limited to 32 bit dividends.
+    /// Return `self % divisor` where `divisor` is in nanoseconds.
     #[inline]
-    pub fn rem_nanos(self, dividend: i32) -> Self {
+    pub fn rem_nanos(self, divisor: i32) -> Self {
         #[cfg(CONFIG_64BIT)]
         {
             Self {
-                value: self.as_nanos() % i64::from(dividend),
+                value: self.as_nanos() % i64::from(divisor),
             }
         }
 
@@ -632,7 +629,7 @@ pub fn rem_nanos(self, dividend: i32) -> Self {
             let mut rem = 0;
 
             // SAFETY: `rem` is in the stack, so we can always provide a valid pointer to it.
-            unsafe { bindings::div_s64_rem(self.as_nanos(), dividend, &mut rem) };
+            unsafe { bindings::div_s64_rem(self.as_nanos(), divisor, &mut rem) };
 
             Self {
                 value: i64::from(rem),
-- 
2.34.1

