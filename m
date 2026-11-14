Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662523;
	b=Md8Z6iI351GXHqlndPxUv6Vd1aQaKD4V7cpJ7MM0hzaHmUFkL5YnJ2pTErL8PnqR52gV
	 NFcMO67x1Gs7dWeClFWRvkLZ1xqPWllPLYfyaLqHCDYn2LIBrSxPDW+vjedz/3aqSYL14
	 TkG43Nb64MZfiEVLDoUt8jihiWpI3dkvwMamXYMZ9Enjg+ppyseFNtnH9X/nQfzWk+PkY
	 R3V3R1Io/skJ5iIm7UiJiRt8bgo/lKBvcJNbapey6ReKG4kSlNT0wSzFU5c+Uu6v3WzfE
	 YUpSKRn/3HP0hRkdO5h8OQ3w9U3r0hf42Xw8AISx88obolNWHkgBlEnmJxJoFXVWLUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9h8JQm53JFkss3jpRTcSkvq9+LBsANnwMRLoN5htXjc=;
	b=3+QUz9ff/56cEWBtwndt37rcMmVJ0w4wOtPAtP5VxrUbkUgnVPlrB2QIw8ImG8zqhGb/
	 MLvR/JHmfN/YioOlqtEULURVvSKGoptlcCtovutkTKoCX9eYnc3Jr8Ch8+MHnDYrHCsA0
	 1dIkTqVeV8VuS6Qw3W5k6GsTFqEeZhNhJQQlikg90Jc9sNmHzfMBkc51ByHIRahuY0LQ1
	 KmZvykN9Rqxy3w42OLsXPS7xz2oYzVUVEZYeNoBbe9DrRjjQ0Ty608x9R1uZxeYsPbfcm
	 ZE3l9ndqiPja0i6hwAFUaUBLe727fn2ONJ2NPurBTgnTwDK6ydkl0Zv5/Ei+b/uynAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MpSG+rPv;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFADA606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 13:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFADA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MpSG+rPv
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso12792955e9.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794662521; x=1795267321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9h8JQm53JFkss3jpRTcSkvq9+LBsANnwMRLoN5htXjc=;
        b=MpSG+rPvvT7+YpUToJscWnj9fgICL5h92bHI5OxRpjsFXH37Y3Q+Bq2Xat3cM3rZG6
         vfiP/luagPV/9giV2yZgF/Tc+j+zpfs5cABUrcWoLDpGFCImrlKGepVskqOe0Qb1i92Q
         G8jD9/nADscOHLE6LbZ8tEB5ZG9r1k9NOSKNQ077829TXNAc+OgHVAac4a9FzerRJZXE
         3HnUDquaX6xjsmEQZLmpnyh6C0lB2bcYPafRVEHfJYpspbIubx697mSJmSIDbV0n19Z8
         0KvkS7f/fOszh3uqsy+lfxxeQA/y3sNXqZBDQvF6P9VzEr5fjO75m8pLq3gwDfsYvVeJ
         oAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662521; x=1795267321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9h8JQm53JFkss3jpRTcSkvq9+LBsANnwMRLoN5htXjc=;
        b=cB/9QsI/Mh2VRJ63a5aTRPkdjYj9lMLtwe9Ed04litYSxFBIWraFI577+TpH7xgA8J
         H8l2FQelimeVfJaSClSEmmDoaw3bRKsy4Fc3Y/IRiCDCr7xYowOIYdxAaqpGHqdRhp3d
         flIbRva1O1KxZdkd5Xgt9cThG3fCVGS7No0VMCAXWuNHT7wSF4gMEANje91llVU2HpIJ
         6FNS2rSFhnSDO11uEOXOa9qjAxWKxgMnz5EW82WfMZt2Z5M46eedLf9H0g3ncE11dsnH
         eeNItwrTIaxZrCRfIWPtVKullPmPWXkMlxYZqH40OSJCFSAb0rjtoZuoQOi/ohYKET12
         mjRQ==
X-Forwarded-Encrypted: i=1; AL+hErFnFUZwMeRnVCdcG/pwnKIutDX/fhdtc88L8OnAUrmz/5PXdHaCyeU15Jh7FRNu/FMN7IxsgqA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8U55Clnz1KpuMjtaUZpPRu2hM/sa5sLxbWbugXupFg33kg5+Hb
	EsByQ/xz+HbYuKeIbgl77jX670WWeIo1D0v8HwkOmlbhvVGSR3nDLSc7
X-Gm-Gg: AYBFou3meiGBCNIxw9Pw8a42TXJL774vlcPANvQSMRz/KWTje/ROKtDtbU2Anhtm6Ev
	VKujRieS61G5R2SOUM0tmxVBiC/BOxtwg7MXNCLtzVrPNjc5qSbUeqW2h4nYOlEbwNoIp9hwVYg
	WtRw/nNIXHL5NRKHb2tph2R0NnNOezF2zHbcPpibyTf66505mkMbNFUH/BG1bfWAzHZHXz70GmU
	7+3uEH/7fVcQOic3Fw1Kj3K1Xgi5QGYoPG/spEk8NoZWRELyYJ2HdADdTPjsyx0S3yKwkVZo8Km
	cHXfbtkYvzZVaCSExovJ1c9ygFOx0mpO8QCgyHEI9ejZ6myBWVSmFiQLR2iB1KQddRg3BQ5Mm7I
	eu/qMaAVDfEOUl2zjSkXyGQjHAnQf3qOQzlZ+WIt/NkizpEGCxSltyJF+o3pUSi9hku+RYXG86O
	p2AvT+ocQbF5XlqJrOdjKThwJFBUmfaR9t23WEtl8/NVYs8PERO3S6lmG26EcpDyf9zWXq5n3pC
	bWHdd3fcrKXcAVVtZGDvg2kSkm84nUWdmEJPDdQZEiOmO5PLYqjbQGIMOMu+7sugYdzmhzTGx7W
	w9NqGuxYp/v2PpuPTBdvkWLgZbJKSzN3nlSnH9tPM/M0FU62Jf/fpRG+B/Z5gG7rIdwlggbFWCc
	L718VJ4w13VmZd96l4qPr0OtEOrPLzMPL6/r4WwfWwVl2jstAawHIvneK81AhwNHJAbPmuI5YIn
	B8mfUzGQckYNVM3df31p2SdFZef4ziOzpxTnBS1wuZ+PQL4rt3js4wNY2UDIPPQzOc7JDixU7Wl
	7CTm4s=
X-Received: by 2002:a05:600c:6092:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4bb55a44be7mr107658985e9.8.1794662520855;
        Sat, 14 Nov 2026 05:22:00 -0800 (PST)
Received: from martell.martell0x1 ([156.211.252.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm379872675e9.1.2026.11.14.05.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:22:00 -0800 (PST)
From: Marwan Mohamed Zein <marawanzein222@gmail.com>
To: ojeda@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamir@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	Marwan Mohamed Zein <marawanzein222@gmail.com>,
	spidermana <xuyiwen14@gmail.com>
Subject: [PATCH v2] rust: kernel: fix lifetime of copy_from_iter_raw
Date: Sat, 14 Nov 2026 15:21:55 +0200
Message-ID: <20261114132156.49243-1-marawanzein222@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANiq72mnB8cMmaMWaC-7pJj29JqqumBOSygnM9zA+8eHikm1Kg@mail.gmail.com>
References: <CANiq72mnB8cMmaMWaC-7pJj29JqqumBOSygnM9zA+8eHikm1Kg@mail.gmail.com>
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

The returned slice is derived from `out`, but lifetime elision
ties it to `self` because this is a method. Explicitly bind the
return lifetime to `out` so the returned slice cannot outlive
its backing buffer.

Fixes: 06cb58b310ea ("rust: iov: add iov_iter abstractions for ITER_SOURCE")
Cc: stable@vger.kernel.org
Reported-by: spidermana <xuyiwen14@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1265
Signed-off-by: Marwan Mohamed Zein <marawanzein222@gmail.com>
---
 v2:
- Use full name in author and sign-off.
- Add Fixes and Cc: stable tags as suggested by Miguel Ojeda.

 rust/kernel/iov.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
index 43bae8923..8caf04518 100644
--- a/rust/kernel/iov.rs
+++ b/rust/kernel/iov.rs
@@ -161,7 +161,7 @@ pub fn copy_from_iter_vec<A: Allocator>(
     ///
     /// This will never write uninitialized bytes to the provided buffer.
     #[inline]
-    pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
+    pub fn copy_from_iter_raw<'a>(&mut self, out: &'a mut [MaybeUninit<u8>]) -> &'a mut [u8] {
         let capacity = out.len();
         let out = out.as_mut_ptr().cast::<u8>();
 

base-commit: ee83899302a0457a3ba47464a13e8682bd7ba27d
-- 
2.47.3

