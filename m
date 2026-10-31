Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442752;
	b=GaV62j2Cu8YlNwSSJKTbHc+t8VK9d26WE5N9tF+jxHSdYai2sjFA5qzoDcaTM7PAfxKM
	 3r+ugUjcxl0igaIY5HBl9gi/a7oGTE4iazamVTPexAvCVqLdQzcCA25gQVo8t1QELR/Nd
	 8MWbeC94UR875cFns9HwVFu2r9bIGNU40hFWScaMVez9/4QkGDdmEhdfJH9grWagXhQrV
	 ueXhhjEpFzsa8T5JD8+xNO1xWV1ty2ughGiweTbx4Kh2PEdf16KHQDbM9U8QXSULgvZ6n
	 N01unCuxFc7P/cC5beRJx5E3eB2JEtJ0EI8ZseX5hQDmbVhB/htZf4n7/ulFWLpX/EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oJN7YW5/O/ypFLA5SZlEpqsSiwnIwF3r1Sqf8UEUf7U=;
	b=LHCbGqpWDUt2u7u5gLM3LtyAuk/6rtaHMlB6A0L5NlpMnma/IcobkpIORP6csRHpPN9Y
	 uzDC9jLNRKtjjwa2YVLCXMJCl4MEquXznQL3Ze1TAMSQDxXMPTy3tdxAwneF/LdWJ+Ziu
	 AP6b9AkDSnMhWdzjF6/SGOK1rJsnfz8acaxvunsn4xby3T9I8jkkrS8VVmjaNg/VJMCG3
	 tFC5fTRqF0D3SQS7hEcIYKoIBWddRIb1uvDv0niSyb2SD0RCeshLr7ZI9/uFZGuHU+wr9
	 ZYepbR9i0aYtG7mw4A+9xyZciMH26TNmSHTXgVQXxpEUnXB1LYDDH71kC/OIuzpWqZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IG2dBK1D;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00B606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 10:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC00B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IG2dBK1D
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2eb0981df4aso3252385ad.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442751; x=1794047551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oJN7YW5/O/ypFLA5SZlEpqsSiwnIwF3r1Sqf8UEUf7U=;
        b=IG2dBK1D/gON6XrQZb6YL4yw44KeH4c93SSt801VAPx7/9qdsTBfQkL1IrxWBKO69t
         Nyf7j8xBomGvQ0LAiZ5F7hJNix1WkxBFT4xlj1cU9d/t4CJe43YrMqqpEwMFvGqWPAho
         CUWhmY3Y4zsVyG2pWNKK2FcJ5m2zN+eWMS5bAUmkFZIhm8QIFOBdfnVy4hm9meIYx0C6
         3PXF3JCnsrM24zVv9wrdrILEBBPjtNhs7raZw7HWa53ANAFLvn61w2aTwdFYqX1+BWG6
         POMgq+7RdxCTPjYp4SwAwZ/CCJcPd2vz812Kl3xcZ0pr9CkNJ6aolObgJFTcvE9WywN2
         y68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442751; x=1794047551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oJN7YW5/O/ypFLA5SZlEpqsSiwnIwF3r1Sqf8UEUf7U=;
        b=O3OHOJIZGu8yaxR1v+4b2wDtD4mKnCenJe2ikcZYlHcT1T8NvrNYmvd6K4uBgUudga
         eYGjuBhJw9ZA3aXomhtf2Kv+cOkW5wHkuIWi86d+x6UJoUzUxC1saLZeQ+oSvmRQ/Tks
         OS1ns4pNxrH9/aY58HuG/Rl1JzQPOwDg6e8sWVfLO88vLOZaO/CB88fJYp+dCgnp6Cic
         dql8pbFPhURugK1lDSVQyXxRMF4BwpbauPzu3EXEb0JdefSBkWhpl0V0D+bA0ULheYWc
         yMNTbubV4Ud7rrQQU9E/WGT1GQuj6CYv3z5VDAfGMlvPnD2fNr7YMMIjuFL9+b6544+o
         UzyA==
X-Forwarded-Encrypted: i=1; AKwUvBxq5pKMCrVnvKGjv5rqNyv3vwWOjHkVMBEzcDupAwfEp6nj+yQOMpEGCoET8EAevGKHXCaNqV8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtyyr0pIvyd7hTQ4EyCHtEQRK+R3F49oQL3uNp5OQXxWq2v5OX
	FNEzIWTlSeilImq0x5smnW0sRLrKrfTM0Bdjx6Rx04WYRF6SS1uxIWw=
X-Gm-Gg: AYBFou0NUDOnY6J4cJIJKW5S+pSBQ2xVOCVcqciiUBDd838Wue/hbvcWjZM31aUA/S7
	Q5eOKo1Hq2ALW/tR80MEbdKmWUBiQByacEs825BSk8Fo3+OiGIgVrK8QNnsbYP9UO8zSsgUGcPn
	kJ+zOGPZfDz4zyFf8Tj+W1myRQWcoExVAsKNvRhVBYArd3c5R8T4k86fzwv3KGYWkLG22fJvL8a
	IjU8esf25EWRylgM+I8UlT6xV9oxPlhQi6fKFTE21vSlz+mJv0fiCFLW+e8KeXACuEpFhaPLy75
	+UyGGB/I3HIWsmF9uixkJvfXOkXredPBD9capoxOXW8FnbXfflrLB+MmVMMSxLdbWSlXYQMpcL6
	k/rrAydwywOLdWUs3R7zHaJrZ0S1Cl6Y9iqMMEu0j6NRdbzK4JNbLJR3uTanJUhHy6Fv9W1BYQL
	v3OMN+NxjxCndf9hc/h1faDFOfcIzYaghgdtxLb1pxuuYDKPVJotZFbypBqZlkja/IK8YTGoz2a
	NhEFDt6wPceMnJOIlOHD/P9ur8DrIz8//MJ3H650W15g8xa1cWlMOYZqmeUDKJOJssy55oOQRyr
	9B0eZ/a7fqdmnLoaVhAMVa3dEvdNVRU3pvswRNXoomLYmIuGFiWTSo09/T89GQ==
X-Received: by 2002:a17:902:f686:b0:2e9:87e8:71c8 with SMTP id d9443c01a7336-2eb36395e36mr51829245ad.4.1793442751062;
        Sat, 31 Oct 2026 03:32:31 -0700 (PDT)
Received: from WIN-2DEDQG69EF6.localdomain ([2a13:a5c6:1ff1:280f:be24:11ff:feb0:8690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3928104asm14817275ad.53.2026.10.31.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:32:29 -0700 (PDT)
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
Subject: [PATCH v5 1/3] rust: time: rename the rem_nanos() divisor
Date: Sat, 31 Oct 2026 18:32:04 +0800
Message-Id: <20261031103206.24051-2-chenhan0017.work@gmail.com>
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

The argument to rem_nanos() is the divisor, while self holds the
dividend. Rename the argument and correct the documentation. Drop the
architecture-specific implementation explanation from the public API
documentation; the argument type already states the divisor's width.

This does not change the function's type or behavior. It is a preparation
for documenting and checking the invalid divisors in the next patch.

Cc: stable@vger.kernel.org # prerequisite for the Delta division/remainder fix
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Assisted-by: LLM
Signed-off-by: chenhan <chenhan0017.work@gmail.com>
---
Changes since v4: none.

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

