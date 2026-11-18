Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001075;
	b=3LcmZp8wE6GZ+HZhzry/61Ua5yJ2l/wCR4asoR7stJmwXJVeRhIFOEGgYvsMyGVidoID
	 MJq40ZZV1EJIiBoYQOv0e4gXtM582BzD2QAS6XQeCs/govdWK2PYAyChvzavViVqEp/R/
	 o/1cIR06gMoykkQW3uR+VZn+VZPOLgMBY0xxeNzHW0NLVXw9IfdZfkrprOdsjuCz3Q+cK
	 yv8XEMZqgTWG2wBCtWlheqCRIIlDiQ5icwTXF97kecwIUEYuixGfxbEDCV+QeP4+/699F
	 o8M3x80xkTMBBm66wJJZtvDYU8HU2XLQiAOQZ/bZs/UM6rdTT2MdqTAOmzXThl0FtVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=NgxcydZ7W7diTZLrEW7mmD64GYiEJTtactewUU2r9BU=;
	b=1qShccSCiB2CWuwPZ/YBglco9AsRuc9WMaXHxCpoBUdr2S6YlL+9mv5CMeLVOJqkSFtZ
	 kOU8zQMn6eHaIye2uPipt2RaLgq4ilH6tNIawSJE+GHrk3cDxkogyRzsVHJV3h3sp5NIS
	 5sKnyqYOIq8dRroBPFc2YjjDd+XRI3e5Pw0523N18ZQw4pB7TrTBPN3T4D/bkPDWhF3gk
	 0tZnynG38Ohq/d7FT+t5ChmnuUKor5I+b9vBClUiBqaP5Qf0YjqytzbtOe/mjuMlyMNEs
	 ysRQXcw8CampN7NXvIdKizdxrnij/aey1FrFCKwmxbztcwoyCyMS5KJohhUy24E25sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nTYKR7vS;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336E606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9336E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nTYKR7vS
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4a4191ae436so817254f8f.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795001073; x=1795605873; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NgxcydZ7W7diTZLrEW7mmD64GYiEJTtactewUU2r9BU=;
        b=nTYKR7vSpmKhR0Ssct/nW+P9T+b621hzUsbStNf5cIUdGf5KKRDXanH0lgGuqHHc4q
         8pLVSBHj0W6WuX6nG1UR0s49rfRBqocVJ5vxatLU5NG2qdVRRNt8pTocYZvE4Zf8697o
         uuuKUOsSwQ8NXC8aTTtAXN0qfkkug4m+Jy3TNcVyaCvq4Wz1HQzYvAQYbx5ClmMXPxPf
         Of4kXO5JFsIZssgaXv0hkJP4Vhn4pbaz7L32Fumg1gQVL2aFbIqwebA2Hpz3IsG9xaAY
         NwLNyJUm7Ie0m7ccBlkQIdrTmjimOJJxznjQqL7DhuyskKymiEOn9Zyyxh+wZumNfM8m
         al8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001073; x=1795605873;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgxcydZ7W7diTZLrEW7mmD64GYiEJTtactewUU2r9BU=;
        b=Y085ptYMfdFThdsTuu9nXApmpBqyB5zEHXStOcHpelKb1/K5mHIsRVfaBlCFMG+gst
         Y8uukKjXKgq9GFR6EwvV1KgFUBOQ6l6B++8sl18C5NVL5LVZjXngAZLj2CUSOQa2s3aN
         gz2fYn+etK1fjdDx9ONrqngph8PmrHYlXUAUWOMtbHGAglcdtfWOQX7rhRCiRHuYacV/
         xWZoyvz5DX7fX0hQ/lVdgCUJY/7xTDYKN8kNQ2lnJiOOnU7GY0XKTQFfsaKcAHj9fjX1
         /D/Czg4mAxLBOyKsOEatgfDNngYkNLf+XN1GFTcDepij6AnQwljqkh12b9lTHT8sWOiR
         BoXQ==
X-Forwarded-Encrypted: i=1; AL+hErEazYEMRTl/KQuGsunDAufIOTDvIpgaQW7DyuWRhpNDVGWFBCxhEeKviplLK74tkcPZ8vw01a8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+T0jf9vNUyeDxqJL8xI2IM8cc64C8izPB64Ic5pxhsH3bXum1q
	Zn/6Z7MXeEUv0gltPaa90Z3Ez67nzJpZ7CP15Av6N4fAWsxdSvq0Mfe75erWi/rxaHureknp0IF
	6hor2Wvg//nZEMWspfg==
X-Received: from wrud4.prod.google.com ([2002:a5d:4f84:0:b0:48f:beda:6924])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2383:b0:490:f98f:addd with SMTP id ffacd0b85a97d-4a6331c6cdamr5728890f8f.4.1795001072496;
 Wed, 18 Nov 2026 03:24:32 -0800 (PST)
Date: Wed, 18 Nov 2026 11:24:25 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOiK/WoC/x3MQQqDMBBG4avIrB3IBFpMryJdaPLXzCaVGSiCe
 HdDl9/ivZMcpnB6DScZfur6bR0yDpTr0jawlm6KIT4lxMSrtgJjuOXK6lywFJ4kpIw1iTwy9XQ 3fPT4b+f3dd2c6z16ZgAAAA==
X-Change-Id: 20261029-binder-esrch-is-dead-8109ceb9115c
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wZRKSXn6TR6MdqwykIO/PARHCDKLEFWKsF5C3d2QD3c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/YrrtJoXrIaXn2dfYFATxfXU8esNx7i83ho1K
 IYauU+mWy6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCav2K6wAKCRAEWL7uWMY5
 RvvbD/9NEP5A+vzaHatKFT8hAu+P+BohRZ9ddIu5EuKxN7Dv8TP7AV1tBovrhxsLz2yCbz6jPgM
 5xkhKoW9gjX0BD4Uum6GqgXa5LJgTpNJeGYaxZ4KhL22x5ACHnepNqGq1CWX/LZXpHUJni0nbwA
 YdOdcm2YzqiVWtl4fQf7Tlrjm4/nON3eyV9W1mLrgHabPsSB7VrHqxgi0Egj6ZuyLMwfRJTwK/p
 1HKXmyOGt4K71MxmiuJC8jsd5tqhwPH8wDyY0nGF5+LP09xgvhXC01fjYj9vKM67l0iuhPrA4SS
 YuUsP2UfGpIbFuzL3UeXs29VgtMUJ4iG/sydfYUp2kPDBCT13MZqkRoGo9QB2wXdofhk/fjxd4N
 dDxh8tSx+r3/A3NN8TEoGhNTVdsgAr+nuqFtrS46yyntbqMv+RKy5kcRVCO+6bmtY9TEjJy06KK
 wuuOuw6Y5855Of0qTGbV6rPH+FyxDFGCIMpz/qIJ22oLdQpZIqV0XVgPF0rfZV6ktSqaaQekDim
 RyBjlOWn0J63yRt4WWfH82cfie6lvMkdAKpKOK3Q4oml0JeVGPbPx+yLTXyGlRbbR9ngoZMVKsy
 p+a7/qiSy0KMp1N9PoCKiK0ffiK8ptzeVo1dBgnU9CeOLBFIfRXy4z8B3hNA06CFLBWLVzq3o9w KO8LOTm+X6DoDDQ==
X-Mailer: b4 0.14.3
Message-ID: <20261118-binder-esrch-is-dead-v1-1-a45bb951fd14@google.com>
Subject: [PATCH] rust_binder: treat ESRCH as BR_DEAD_REPLY instead of BR_FAILED_REPLY
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When sending a message concurrently with it exiting, the transaction may
fail with ESRCH if the timing is right. Since this is delivered to
userspace as BR_FAILED_REPLY, userspace thinks that something went wrong
with the transaction, but actually the target process just died. This
usually leads to the sender aborting.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/error.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index acf0aa09c555..00f1519a8d77 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -78,8 +78,12 @@ pub(crate) fn new_frozen_oneway() -> Self {
 impl From<Error> for BinderError {
     #[track_caller]
     fn from(source: Error) -> Self {
+        let reply = match source {
+            ESRCH => BR_DEAD_REPLY,
+            _ => BR_FAILED_REPLY,
+        };
         Self {
-            reply: BR_FAILED_REPLY,
+            reply,
             source: Some(source),
             line: ErrorLocation::caller(),
         }

---
base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
change-id: 20261029-binder-esrch-is-dead-8109ceb9115c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

