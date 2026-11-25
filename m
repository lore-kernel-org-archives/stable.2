Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640518;
	b=sayWYSNxpZgZXrMOJhqscwkln9ylw8NEAJyevAIYakhZ53LIJek6UD2O0a5/yl9nlzPv
	 mjLvRFGr2+KPaIVFMTpmBXK9y4nr0w/KpyIU3TJ2GokXUDgzj2QeobNbxM4lpFgDBuPd8
	 Bkmoe1c8FXTXp+wCH57E92uAeAzuvB3o0dosuTxti+UVsm2/tR7qVRNhhsZS6hDEYGm97
	 HvjhUQYI8h4WajOAQlz7KeUP+qFIG39mbjtKNdvw7ePKun8EilWG641oW6cxMdnGg0QdP
	 qbVZ94oIDxmX2Hs2oIqdhAs61rEvcsEX5uMNA6rLd3cwKIeCZgrrnBPs3TJahbv07mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rAeuXzOlCTRhm8c9AePoBHHIXKhwDESJdrRFhkUvSY0=;
	b=OjY53WZ7mlESYsIi60npi0ZaH9l++KvXgWNvgpk+cvyey6ZmtDdcdV0dm49yAx0dg4YH
	 KAbqYGS2KSDZjwGA7S9R392fsfMo0ge7irM0bMa4tt2nkQbWV8fmS30/FwVszhDZEw8iC
	 dvaUgDzMrID1JHnA1tcmrAvz8iEBwP/jwUZbY98PT8suHYWmjFtYHFjwIQBR4L4zZGTWH
	 B+wtZdZXVVAI0L1BQRIcKZuMNleY8GblElAPOm3GUE0riV68S73BDfjyboCvtuuwgCJ5Z
	 /sNOmcX3M054hwM9M2MfaYsJrtW7+WLI0Jmk5Mv9H4zxR3KP1WSkuEr+TcNNYO9fYGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lp4R2a8F;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E1606A33C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 579E1606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lp4R2a8F
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so390936c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795640516; x=1796245316; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rAeuXzOlCTRhm8c9AePoBHHIXKhwDESJdrRFhkUvSY0=;
        b=lp4R2a8FRe4Jzh5GBlKmTB7KM/zji+OXsUnFdo9VPbYSW1/vAFwwdd0bjA9xJZe+TD
         Pp+K0qdeIwk3XCf4f7sBpTTqRkjXN/+onfZ35Jy4Yx5kQsyaNa360bnl6mrnWVcxdBdE
         D+/TH8Wn5LmZ9X5+0sssGg0XQanZiUPBMcFmHiAxmqhJekAijeD8RNwoJOwzp/EngXXo
         aoms+2u+8egAut+nWgO3AZhull00a7gi0Fzb5wuuPZnD6+iOmvxf6c3GvMMk0XK0ThgN
         rQVoYgg5h1UL/1j0T3e1WhL3wqaGj4drQkK8Svtj5Mzb76FbMxKL+89ovWABVnfRn1k8
         Eb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640516; x=1796245316;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rAeuXzOlCTRhm8c9AePoBHHIXKhwDESJdrRFhkUvSY0=;
        b=L+WtADtWZPENr+igEw5+W7mKRuwZMAGmQmtpIwI+zyKlxykfqwP1ZCDtMjtDjb5dzm
         rwaF+YUWJ572Z7QjA7dQAT4TptU/MYVkAl7TcYegvqHM5FVE4lF6/eP3TdrplVYnqhks
         DKStm2pTQAZKP4HcFEuRUz4tDuTeTCwoK1zaqk5gcfw7XqNsgpDxnB6ArrD4GAgNTB+b
         OoTJ9XAqqmXBhpddZyMHbjtPH4nsAZ982/3ca/YCCifQW6uBpLDmmTgn3fTu7ktOjw5L
         9ivpFhXzzJ76c9Z9aB2cBvft5w5zRr4ZaCgEn3n0si23LsHuFYFlWV2H2b410rhAGp+N
         booA==
X-Forwarded-Encrypted: i=1; AL+hErHfDyeDYSydZKC6waMjwdB15vZ6tzkG9S817AdshFbhUWNUwvzhzOCD0xyRYLIxc+8dr8vrQ8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+c9f2RBvA4R7O5JV2B7/6axpcfJ3AqagexcAX6Uy+fDBkrIEhk
	huDKuD2vTohkO/smW9cTVmbmo79Vra03WmS3UjkdzP+8KqVvdyTNypf7eZBlO9NMQIFeclDROGW
	CTA==
X-Received: from dled8-n1.prod.google.com ([2002:a05:701b:42c8:10b0:1b5:3444:f158])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3b8e:b0:1b5:32d7:7d73
 with SMTP id a92af1059eb24-1b5568f3283mr23214323c88.30.1795640515933; Wed, 25
 Nov 2026 13:01:55 -0800 (PST)
Date: Wed, 25 Nov 2026 21:00:37 +0000
In-Reply-To: <20261125210038.1277960-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125210038.1277960-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125210038.1277960-3-elkin@google.com>
Subject: [PATCH wireless 2/3] wifi: mwifiex: check TLV header size in ext scan report
From: Elkin Cruz <elkin@google.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mwifiex_handle_event_ext_scan_report() loops while bytes_left is
non-zero and immediately dereferences tlv->header.type and
tlv->header.len (4 bytes) before checking whether bytes_left can hold a
complete struct mwifiex_ie_types_header. When 1 <= bytes_left < 4, this
reads past the end of the firmware event buffer.

Require bytes_left >= sizeof(struct mwifiex_ie_types_header) in the
outer loop condition, matching the inner TLV loop directly below.

Fixes: 21f58d200388 ("mwifiex: implement extended scan feature")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index bdd4b8465863..53aa16c1df33 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2649,7 +2649,8 @@ int mwifiex_handle_event_ext_scan_report(struct mwifiex_private *priv,
 
 	tlv = (struct mwifiex_ie_types_data *)scan_resp;
 
-	for (idx = 0; idx < num_of_set && bytes_left; idx++) {
+	for (idx = 0; idx < num_of_set &&
+	     bytes_left >= sizeof(struct mwifiex_ie_types_header); idx++) {
 		type = le16_to_cpu(tlv->header.type);
 		len = le16_to_cpu(tlv->header.len);
 		if (bytes_left < sizeof(struct mwifiex_ie_types_header) + len) {
-- 
2.56.1.839.g22a8290db9-goog

