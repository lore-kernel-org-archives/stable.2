Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760679;
	b=mdzH3Px/rTanY6puBEvP4IdL0TB4Cb8FDeeKZAd7e+Ci2x1uLD2eDcHc5r+52yXI7sTm
	 /5hLY29tXBDT6d1tDlqRbq/kUa2XUaJYqv3cK9q/ceA4AIMAKVbvR1KUq14Ud9rucCgLC
	 o790m6D18ll+dYx6t24OhpXdPHbNqOJY469o4BORMyzc6Kpg+hfmM+nrlzRUElf/wfhBs
	 l1Dvm3CZFk77tPq9z50QBzYEzwobjhlD4LioFG1ygEr1G5dOvr7wQaL7ciNR9rpy42Z3u
	 Bxq10NiYoPjhzUxgSTow9VHhcEcvh0nZjumeTUibuRo97z8ycHO3KDa5CvaPr9bcslw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m2cOO5Qmzsel13rD0d2Ch8Hy2dAKGNhwuzhw2PgQ5Ps=;
	b=OngxKsLm6GYm1nmyMRfI92HjIfAiTrx3jx03N3ngMCY45qOfBHIAij74GkV0JFrUV07P
	 wncFZmgyMsLMBTSGco9mi8jId4oLVNexUmikGw3sFL5T/gzdJkIYXwd2FO/DGCRtW3sHX
	 pwpXKehBYIXhvspCsi3RZkKdCK2kg2rubnZsEj6yj0oneHvAMWKA3VJKmpWnQdHjq2bBu
	 pQgRTjHBPGrrWPtVu62g8b9WWeHWVZq8NmiQ2h1Ngc5ZcvIobPDp8ggECJF2HsUqqfi8h
	 3nGCL9/KaWBSWmjMS/NHQhxLC81RGBtE34K6pErd07v4bE+82qW60KlV/bedk0isTpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lody6JOY;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB2606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11FB2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lody6JOY
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3ada2f39f30so220628a91.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792760678; x=1793365478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m2cOO5Qmzsel13rD0d2Ch8Hy2dAKGNhwuzhw2PgQ5Ps=;
        b=lody6JOYmoR5Ixf41CrcWzhJx7o1D5JML/EyQN9jrlJH3u5aECQWyw3U4Hb8STtYoD
         E1CHTWPAWSiLuzioHSPhqQ2mwanOGgeaDkB4qeSQVW3sCTg1FxDp1X+o/nFw0Up0rQoc
         1Vl2rvrIWgelIA/aP5M9oMsi8x1zgxoK+S6GDPLH7UeHhb5FwWjcEK+TfMSjZO4SeJw0
         KcDu5u0/yELowsCoi314qQqJlVsMt2JU2AnVZV57wj3FnkLDJjnTHxsuOtT4CEssv2p/
         xomWbtGma/06G7aCzjTdaFcCwUrmCo794208gPOT0mdV/iHfrLv1yLlqagaDRe8ceIoy
         FR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760678; x=1793365478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m2cOO5Qmzsel13rD0d2Ch8Hy2dAKGNhwuzhw2PgQ5Ps=;
        b=VUasFX9CCd4qjLmmd8xMlsh4ZTPW7sXxsUA+6Uq64c2sSZs60QtcK4vDRDuPum32B3
         v0Kkvq91crHonjjQ/EgzlTZ/icfm/QoSne87FcWz37XM54G9oeGHguvncBUkjbpM2HyU
         7jkmmDtw/DcP5b0NbY4cZRFfm2ExzSAU9x4AZpmUtQsPY12d4mDJhBIww409gGCqTt/f
         Z/j8BKlxcqM7D3SNSqJjFVONNMFE5bQQpSL+Q2CsR/5pF8tSoxYf74mWhtYST8hW+hwz
         79YQRU2x2JoWCVcCl/Ofk/RAog7dl3WoH7IJlO38S4Qf1Gi3vsFyCtLXWaq88ghPqPar
         YbNA==
X-Forwarded-Encrypted: i=1; AKwUvBxWdXuN0t55RwaFgXssJJCcJaXsWTD75kOsSqbn36WlJsAd5PiEm8GJOH6CcH+OsKrk9Bocyro=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAQwrvmhOonbb0lYF1ck5URc2IoMfiqQ62JPUUHziCXErLniL7
	EpWOc08CTkAWzDz1pG8p0qvtoKK8W31X69kXq4a46DCjA7r+XrUUE+E=
X-Gm-Gg: AYBFou2jpYSvkOkSYjrzZLpRoNWEVl9ZAf59a47B4fV7qmGOBpB1GjWYm8HlVnsI9+D
	mPpuPh8WBj7tmeeSANLpS9xPPRcf6dm+daNDSg8PMjtJMfcXe25CQYEkpvkGqa+nINE73E4ycS7
	NSS1LsRUYCR3CLl5FSODKR9n4iWhtI2phx4E45GV+ILJzZ9F8CUUrL0vo8Sq2VTxnn3ByoR4zis
	DGaZeQoE1daaIjvnzG7YdU821zMy7qCUoP7+ujGZyqn1nZhVvRAGjX+Wz4lUdnFW/JNoxyeIQYz
	XxtSz2gJSwFekk751xlCrZoWaUWdB2p2ywu86LHsqx560/4djM1V78GSQ3VXCHelZgTmCny+oTV
	iD8TKuGirhCQjsTgYoG6iYjXwgzsg6VaxI/V60gq2uXd1TsDRi5usDH2h4FCSKjeVd2Tn9fclND
	BLYeeZ7ffB/Hb7NXhHyjTMcMSE/2RtViHjqlz51zQhGiGls3zJlA1RypjOV3IBGW7Yp8odpEM2J
	4JgW+awNpxs603yXfEFRwlF2TY/kSRj1v3xoHSqOlcxqwYVZ8THhPJI4g2zHrt61dBu76Ijf2gQ
	xiVAIkkpkw==
X-Received: by 2002:a17:90b:3810:b0:3ac:452b:4a63 with SMTP id 98e67ed59e1d1-3adce09fa89mr1966572a91.55.1792760678220;
        Fri, 23 Oct 2026 06:04:38 -0700 (PDT)
Received: from WIN-2DEDQG69EF6.localdomain ([109.105.193.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add282a8bcsm1349017a91.2.2026.10.23.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:04:37 -0700 (PDT)
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
Subject: [PATCH v4 1/3] rust: time: rename the rem_nanos() divisor
Date: Fri, 23 Oct 2026 21:04:11 +0800
Message-Id: <20261023130413.178487-2-chenhan0017.work@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023130413.178487-1-chenhan0017.work@gmail.com>
References: <20261023130413.178487-1-chenhan0017.work@gmail.com>
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
Changes since v3:
- Carry FUJITA Tomonori's Reviewed-by; code unchanged.

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

