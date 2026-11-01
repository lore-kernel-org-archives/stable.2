Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569877;
	b=l6oORBe0Y77IbQGgXN3tUZeDHNjz4ypGQoOveT4DV8NsKcE4HQFBdyzGI++m5gs6Qx6o
	 +/KFUvizKw5PMC6MYt4ATj/Ze19zvIiCuiZBlEEXo+K1Vbl5nTySVZ7dPzNrvfzHYA268
	 S6F5mI7q6KE9imECHPcik5G0egKfxuURLYlGAnChvNZdiND9k/MtGi5l2UYRrkTEDEVk1
	 leiehoN2T//mMp03fcRsW1BGp+q6x8D0bUOnN7bUPQ3gQZV5G0MDZipHJ5gS30oaXgUTf
	 U5V8gxsd5vmYzrweo4AMG2snBQ2LRZf9rynHE0pGLKG29y9v7pPU44rAfHLW+RJEA5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gXbCJ+Z4Wlm8GkoiAeg5stJ+hb5LXK7yuiODoWXbq4E=;
	b=uF8hCnNsuVaZarEoOYEe4pgtYaQp0IJVdbcr9klE6iumEVkjnPolIoOw2Eq54LYe7V2B
	 3qWPNCoXX1JK3vf1IvbNhtaEEeiErKAkGlbSCfC5j5xUmEzXmtA4n7cwZlP0As5I5WQ6i
	 /aHRoK8CEVsBfdj0pw6ZgkG16J4NfOwmuSVtjk9rf5fhE8L3Y5w8wuzRFPup59WfArEOU
	 EE7K9f9qSxN3ET6S08se5LoY+zKT3JyFxTlWqW5H43alg+lMbVZcTYVcY+hDp15id7k6l
	 h6523v9xzw2Z8t5fv2eNQKqumFQs34NS/mv/4Xo5JTQ8F2rYSPJqKI4+ttvpsz/2fpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UlB7U4z;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DD606A32C
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 21:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 211DD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UlB7U4z
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso24476685e9.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 13:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793569875; x=1794174675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gXbCJ+Z4Wlm8GkoiAeg5stJ+hb5LXK7yuiODoWXbq4E=;
        b=0UlB7U4z8EPZoo87aj+uGyErmzAju9AXIJqWYcxdkHWWDjaj7u+VJqzpFrh0Qa4yrH
         ExXB/uYXubhbjIYdDON5wDB78kL//bgXTF7c5MFqTlfWHSqRmBrTrTwzn6X2tdjfjoUG
         mrOxgCM89gw172sFDIn5v8ewHvNbFUTkredsUAizHBskDxdw4t8c2WWvV7gN3PMwVW9T
         6snABxlqEchBwhfFgPtVyAnmta8GObGNOwyRPC9l1guNv9DwVttc93IarxTK4bG1DENm
         9zDmyEVbELYdVGcebvtK5RMve8g3clLLx/nCbfNgXUY5mUsTKDgklVRqHPGNUKXS9AYF
         WknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793569875; x=1794174675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gXbCJ+Z4Wlm8GkoiAeg5stJ+hb5LXK7yuiODoWXbq4E=;
        b=uziVQ4OMf82xl4Sjml8NZt8+yvAGBCvYdOYtCQHhOztWhEe/U5hTaDGOWFGRn+MzkR
         LTTQHaszI3B9IEwiqjXgtCeHetOncUdRdQ7wmiUlUN7GE0sFRYRG0NZ7Y0mBqloBucC2
         2+chWYqg1MfArZaga0KWKhv2iKack+nzTznohGTsoialxHvtexLOkNi8QIYlpE4q7xAc
         1MYa2PHXfe5GefLxKYZQywo7frG76l43LzfogVKh7igv2OQ9gMdEq4YsCTwebUg34cLS
         kOkdb0SH2eifbYbTAFu8uQ2i/alCAQ8Fn5gK9JOUlTBKJklQljt4F9OekvBeHhISp25T
         gJ/A==
X-Forwarded-Encrypted: i=1; AKwUvByuv8eGRNGr6hH6e3y0B/w/1u9zG7W44pfhcTVULJH7wlGA7lvFubllVdeN5XoLUE8/vumqoag=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbUY5N98CDMqOcqw5Kig3sjuFAIWLrf0p0imUEYF2UBVjecNmI
	Te6U+gpyPuv/07l40L8wX83BzitXARGMTKb/3mbkr3WBiYIp7DZUGvM=
X-Gm-Gg: AYBFou0HcLKtyaBu0Lav/FrnRoAFKSlOLhbUzxBhJybEvTFb/yUANInKX+pYoOrVXR7
	zJ/ibWjupfVgBz5yb1zsyCPFqwfrCY90ACjmbaCN9LfGTbqEAVUQ5QDkBVrk85g7XT10lvvvRB1
	lIfgKltGfacSBG8q3RC6aFfVgZOdPcGF8znvAadHvX4fPaVbkuA6U9j6qvvzXWMqs4DBv6PAer/
	xwWrFPNvuiXe9tM+gS72AV1DRckbLLbq30/nCfBXkdZdjHSYR7uMCirTpmP3ob8s8UgvTwOKhKv
	XW/OlYRxCaP93YOBIeiCXFwkjv4gyNah77BXiYqDorxPTRDPJ17Wq+r3vmbhk01ol0SCdINC/rF
	/KX3ozRlJ2/Jjp5tEyAH2Z59GZNWxh1m/VWP28ghhtIPWmUkprgmviVx+wTwuZa1FVSVMkUPfVI
	kzDOy6/a0La8RB7kwK5fQYDIb78oViSPHNmCR5tIzQrrQZf/q7/0MbjqxiWVjuIZSA0dpJ4WTXI
	yZp+aAYabt2cLwhfCsnRflEG09okWKlRnO31SRkm4b2y1qxl2077OeXR9KZODyL/e0vyYOT/Q==
X-Received: by 2002:a05:600c:4e48:b0:4a2:150f:1610 with SMTP id 5b1f17b1804b1-4ac183d16eemr180666545e9.23.1793569875535;
        Sun, 01 Nov 2026 13:51:15 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09ad5ff8sm157249425e9.4.2026.11.01.13.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 13:51:14 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 1/2] wifi: mwifiex: validate WMM queue_index in firmware response
Date: Sun,  1 Nov 2026 21:51:11 +0000
Message-ID: <20261101215112.3199197-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101215112.3199197-1-tristmd@gmail.com>
References: <20261101215112.3199197-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

mwifiex_ret_wmm_get_status() uses the firmware-provided queue_index to
index into priv->wmm.ac_status[] without checking it is within bounds.
A firmware response with queue_index >= IEEE80211_NUM_ACS causes an
access past the end of the array.

Add a bounds check before using queue_index as an array index.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/wmm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 841505e83c7fd8..158e4a2ec0dd69 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -943,6 +943,9 @@ int mwifiex_ret_wmm_get_status(struct mwifiex_private *priv,
 				    tlv_wmm_qstatus->flow_required,
 				    tlv_wmm_qstatus->disabled);
 
+			if (tlv_wmm_qstatus->queue_index >= IEEE80211_NUM_ACS)
+				break;
+
 			ac_status = &priv->wmm.ac_status[tlv_wmm_qstatus->
 							 queue_index];
 			ac_status->disabled = tlv_wmm_qstatus->disabled;
-- 
2.47.3

