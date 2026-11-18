Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001145;
	b=ExcNcToV49v62qK4X2DImkNIwKuFBPckniT7eKDi1PCplVJPfv+MjEyUIgobfuLlJDKd
	 vdG4nZkXrhbb+C9QMa/o2hVbDbDMuULoD69JvIW54pynFrOHJUqr1GuKEYHrhoHBIYf/J
	 ZxALxrc9Xnwag7aaMCCZ9htvMnBiXjceyROM7h1d//GnrvWT5esYtWdAeGJ+ds4wyG4Uj
	 4F6jDDlXZ9WsH+brDMhd2X8S6VscuuGPd3fV+wCLSbQ7VqT8jWiEV/bNpQHsMAUT5GjMk
	 KVQrv0Q80dRnLNL7ZtW4tamaqg8EzLWoi40G2ZU/kM3Z+OHOo+gUVHSq9b89INSlM3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Jj3AiIIXmRC9FyTihY7j7RN1Wu5qfeANt23v7y2ZS24=;
	b=5pQreyJSdEyB0CtMw3RkYLV7fTAprwLiMc9Eil5T5ByeFR0LeHo9L8bjwDybmSM1vqnI
	 akopo5tpye4/LnYMqCoGttrBSxRAb5toreeGzVFj74IGIDHL2qzYmWgPewfJuM7JyRhpB
	 ReZWm6HgTCPhHa0E92Ez6H23/1mrrMntO6MrCV5y3f7MudvUq4R+5cZD+advZAd7xmDS3
	 o083X0v5KJLHzXplqeA1jdrW2Lpd38sCbKIFfh+jGPSl4/g22qXEMgYtrkUIlLyezfdPq
	 8SbR5oQ67UrHXuNRcPJDvIoziKiD3gW9ZIVrs228N/PWZhF6oiFckklDUi2jAQ6TDJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cqskiwFE;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB524606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB524606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cqskiwFE
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4b9fde3044dso6327645e9.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795001143; x=1795605943; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jj3AiIIXmRC9FyTihY7j7RN1Wu5qfeANt23v7y2ZS24=;
        b=cqskiwFE/oWO/rqVLm4kkogciIji3y4Kjq4RgbP821CCVY/g4AxdF16yvfpwBFVFGp
         tGEazMi+uCxsu+p2LZn50ixtULmFWxHVge+hVo/5D+4DRD/AdfXTrOOOP6g2cVZIPjkH
         xIc8+ihl+8Elr0xhuw6ORHwxcWo117GwjA7/dLJDyZpYUYTSZgIXNppmZM9yrKc2B3dC
         L+es4JT0fWntwtEF9WzX4Ae8vtjS3xpIdp5wPdAWSxnd7jFZrMPLIPzfxdzaN1mk3bH5
         XWFHfOfqUuhvPrc2Kg31cD8+/T5OrywHWQSF7rv3r3TN9zoOO/Vw9CGrYectyl2v7Vfe
         nzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001143; x=1795605943;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jj3AiIIXmRC9FyTihY7j7RN1Wu5qfeANt23v7y2ZS24=;
        b=SIKtRxId74kohmb/BmBd7nQcZFZGo2H2tsniBCFawlU+QjexmGhwmlKwrPqeA5/8qm
         GHhD9qAX8Qe1mT9YgW2ncy/3l/njFx+KomuAPvJf6lQhq1AruiBekQs4KrWW5Tn3sNmP
         gX+bGNDK825IufJJSuoqLf0wp6mddayyiQxuyOgGbhlzNrp3LlGsecY8E7LImfc1HDED
         uQ/TG9kBbKUe5VrZr51CKFuair8FCvY9Ee9Mu7+jkCEdQ5ci5+e4hd3gsjPajJIj/fjO
         ycBD6M5jXTnfP7hB8aH805YdvXnDOkfqgTi03M18rrIrSI4cxnwu8BiNrvk/MqCF35u+
         zlYg==
X-Forwarded-Encrypted: i=1; AL+hErE8/WVsOFMcJbQTpTjfEH6YPaf7WaBvxT/S/v/XwyMYKnFQ5/FPvNGLFsHodPQsv/ycGczzxF8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VuhUeB5ItphrDvPoFoALkmroWapgPq8RIpLIRCpcZ0uAKHnCs
	eDhXrtipaB7i5TK4QVdRjpxCoeHAvyier7+rGm5O6LOe0g9SCNSL22Y17n+ftRzRmr6FqMSUcSz
	UFv1ZqOkHSptdLeFpRg==
X-Received: from wmte3.prod.google.com ([2002:a05:600c:8b23:b0:4a1:e44e:ffd0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:82e4:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb7da0f6edmr48886255e9.6.1795001142665;
 Wed, 18 Nov 2026 03:25:42 -0800 (PST)
Date: Wed, 18 Nov 2026 11:25:40 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADOL/WoC/x3MywqDMBBG4VeRWTuQCaK0r1K6MOZvOyhjSfAC4
 rsbXH6Lcw7KSIpMz+qghFWzzlYgdUXDr7cvWGMxeedbcf7BQS0i8WKjzZsx1NZ+YnGN66IgBAG V9p/w0f3+vt7neQFEjIZgZwAAAA==
X-Change-Id: 20261029-binder-unknown-einval-10407d1ebb1e
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+SUG3kGuFCHmoOrycx6vsE5gV58r45W54JR1JLI8nZM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/Ys1O60Q4+eQ4Q/yuYRDRcG8xoT83OLtaGNPV
 vXdNKpiB/WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCav2LNQAKCRAEWL7uWMY5
 RnQzD/9rqO6NyxT/nmnnELkRkLu7U9+ISwS+vCpWIzuwnmpCfBmyxPgj/Lpx7AIsNSxXI5pqtgH
 NN9NXXhKca+hm996cJudy5RwJtUq2ap9g7dUYSjxDuaO4Hy38ZqWuH1yi9NiPcN0FkL/j7Lcjab
 rnJsuslLGOjndwf/oWqboGBXUP/Grk6iFSVcWvrlHrXZIIA9d37DAWb+PYjJ7NCF5psHnNWjsKn
 DpdrDJwdPilNHOvFaR8WJBZqz29D5oypCZZAbwsasBEM8XcX1tvPzZMFXQmloGJffcqB5bycJyO
 Oz0NhTdFw2L4Acv10bSgcNNs8xKvVeSQFTdWB/e2Hf7ZcUnHAAZOqAJ13NKyPtyTm4gdUvwdqu5
 XUvmQLfE8VnXaTbETDRDpTOVaFMFRIl6hXDbUdorYojNeJvtiuxMpz3mk1vS7AIXOunT1n+wfsh
 lSnCvwPriX5Y8LVe/pFHsyMNOUh2V2CXuUg/szkfQ+LEqGMOXsuo2wXSSA3tJpF895C0BGq0amx
 kjUA7MYUv6QkVJCG87FjiYuTfRdrEB6ZHLRx4WP0OT4Vb1lHc2sNnXrnziaJU83f0ZRohOmLcYw
 35hRKL0RmopHM0iXWkSfTzmYyf+tesZ/t3BMZkCUdonjdNjzL5l52ywt55+mktTzEvMDKcz2FRq idU6S63mf9dD0gw==
X-Mailer: b4 0.14.3
Message-ID: <20261118-binder-unknown-einval-v1-1-ef4ece277b26@google.com>
Subject: [PATCH] rust_binder: report EINVAL for unknown handles
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

Currently unknown handles are reported as ENOENT, which userspace
doesn't treat as a fatal error. However, providing the wrong handle is a
fatal API violation, and indicates UAF in the userspace process.

Thus, change it to EINVAL to match C Binder and make userspace treat it
as a fatal error.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index e97213250beb..406d80cfff08 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -958,7 +958,7 @@ pub(crate) fn get_node_from_handle(&self, handle: u32, strong: bool) -> Result<N
             .lock()
             .by_handle
             .get_mut(&handle)
-            .ok_or(ENOENT)?
+            .ok_or(EINVAL)?
             .node_ref()
             .clone(strong)
     }

---
base-commit: 917fcbf033154a6c8d83cfa6c88f012b71eb37b2
change-id: 20261029-binder-unknown-einval-10407d1ebb1e

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

