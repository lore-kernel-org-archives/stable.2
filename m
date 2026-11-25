Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619514;
	b=fuVt3zDUnZoIDUl1Fg221cppX6QRnf6gGwwaQ4yIlIofwu/nMuCBJ15EiT9iUCvGlY10
	 wNxN+2WjDzP5CEYrwdrKEPVXtTKl7zu/t736filNTsbNvRv+AbdVuyjJanmj03+2qd61R
	 MGTFBH69TwGJIWyQVYqEFKDo7zp+g8t2fWR9IOGfElqJ/6YZnJZTJ1pdzppCDC3pTvBKA
	 zLjZOcDF6vdP3tA6iom/X/u/skDwO6BL/+e/bMVGq/owOd+xLhb6okgaNtVX4H8YB2LQa
	 rdOQzTy+iWnoeD3TODWnBRBaf9hzpAeZTLQi9qH9fWo6fqhaE3NJCH4FtumJbr89aPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lNBXm0q1k4P7phGHtx0Xa8xv+4tozeXxm5xK+HkHpUQ=;
	b=bCgdvWeLJGA8i4M/meF4961mKwXPKKxz7vxHFy/kwQX+t47VBsYgBsMX4x1ecW+S/cSL
	 S2fQABLjazLZ+i3rzfqotmX6NtPe55cXpUx48GszYzMaDmVR8S/7T68ih+lnc4ku2+JLz
	 1ei3D8JQtUkv/Z1X6JRRYJ5auCV2XB5Ge/H0X7B1QvYD0jmehCZRzEIYay6XQREvrbvJz
	 MYfV4U5iJZ1mfepiS+wTd4y8ZpnANzWEMZ9sFy15+mxkvIRG3yz8xplJrPlQOi98mz7/8
	 nw0CJsA8d+K14RsTNKnXLAZXX9GfXkMUe4MhvSXgRDrpI2S0VwgKkVPQk1ggYP08/0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYkngbtL;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256C606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C256C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYkngbtL
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b244fb7fffso5933346c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619513; x=1796224313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lNBXm0q1k4P7phGHtx0Xa8xv+4tozeXxm5xK+HkHpUQ=;
        b=FYkngbtLBupY4SW+Gi5CvJI/RThSemFU30t8q8RC5C0+wEAoNbMCT4gGjbT0Ve1/gb
         cUJ7jWNPAdZwh1k1Gva6pUWVmeOTVV9zSTaywgdhOthfhJe4/ZCtz9VSKF0a9IIB8/UR
         ieWyb1eYasBrrIMzB85tNNrlSyIhWUrIPzX9M1CYjKPwKGfk1/aSlgmjh+DmmTyAPGC/
         zFSkpummh1ckVIih/J7OUpkhi9BEyhVncWqCSLEaxg+pr0fXqSSm0FzXKsZHcB63DgmF
         C0YV8Dktmd+juZEwd+fOYASzSWxJj9Bv7M60HXEYbEONzYZ0tPNDudddE07NMg6hJ9++
         pTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619513; x=1796224313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNBXm0q1k4P7phGHtx0Xa8xv+4tozeXxm5xK+HkHpUQ=;
        b=R5Y7ykNvwLcjE3rfDmWnUkMsUYozKYest0kKaSMxowKKLZAhdXXHxMmhBu9WFCFJKo
         CwIzXuaXmFdhHAHexle/BEExniMhGgNTrcEwtoUlKpN20jH/AnAI2RSf72IotoakOH54
         PGEBALbkODM4aeQUYoyExh/XpUs+4WahXkFkA2JWlGnmWIoMlf0bBYPmu2vnF76akVvq
         lcDC7PrYnjkR0lKNmsPbaiVpqNO0ks7WXXjElFSr7pT7ntqNhlxgMGYBSFJAkHAc9gYQ
         nnShL7EVztW5QA5qzMzMpwlgEpvfSdNxZlncu8I4k28Lq3nCTfzuVcO0A+z5/9SWuIjZ
         NDYQ==
X-Gm-Message-State: APuU4Z8J6lOIqMRldc87ffolTnYF4nvpdzZwr48NWqxQOIvbpOsiFIPV
	cDUueVuLPvYh99nmvvmYvBObAaFkiquVuylJrP6sk5dOSQDN5Mf01t7hqDnPrs95
X-Gm-Gg: AZFdTZebZ+5VZ8gb8dZgqaMyWMWRGf1b+x+8FsHQPAR3zAo1JSCBcp7zXPt0ctcoypO
	+3FBfcndVljnYggczq3sp4aGsOep3qvx/n7WqnOKu8C5/sjix7m8dvB06XGIonKfrrJvX/iR+YR
	OQhR2BdsBdTrde1dRYOgqZIhmn2iMtSK93mc+crUS2/ZCFHGF21mo7x/AbjwCtICjiavQYJR8qO
	/03ZhFKZnszSNzSJuUIgSHwl1HwIAzk0LCeL5Fjf8kJ5y/xar7SYlpPsvvMAcv6lv5eOIQ0icUn
	JQPrigg2bRoS/SRBIX89cSjyjVhHxygSc+Fli/sH35MuRSkjiYkbQ8uXvzRDOe53cMp+G4/Voij
	47/F+4P1hnyjJzsaElYT+19QPAdgzoZgwJcihejBdF1nYGAkQdg2+qvFMQBuWYFu3Hvf13Pg+Oy
	3hz7VKgtIMA4sHeUVddTwf51fUctgiBPo4JmdFf9pkPPippUr/Mxxk9tRmedxTjauuDkE/UA/mm
	3FOr42V7UcazCoVJpHCbIqchxxzlhPB5Jot0yDI79PVndkRGXkjHNrgLKty0uNuiN544ky191B/
	jS1mlqvVPdtIdL1WHLgjdXxDBlYBj4ZXA757ebSqpYX2OSEKXPVjYaJlIDENV8SE7iBoFagfD+g
	kpM29aUIY5W60FhcTp25qOBglaT+t3j3iPF8t6FapnqE2Ds3KAduDib5kJp/pHKLIlQ18ZxTniG
	ecTKDgBt2czl5wKwyeofdX4Fgk0hFg59nmULB19/L/Wg==
X-Received: by 2002:a05:7022:b056:20b0:160:a80f:3ed2 with SMTP id a92af1059eb24-1b5568652e2mr18645900c88.10.1795619512602;
        Wed, 25 Nov 2026 07:11:52 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm51063985c88.7.2026.11.25.07.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:11:52 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 5.15.y] iio: proximity: sx9500: ignore event config writes that don't change state
Date: Wed, 25 Nov 2026 20:41:46 +0530
Message-ID: <20261125151147.341588-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112541-onslaught-uncapped-4491@gregkh>
References: <2026112541-onslaught-uncapped-4491@gregkh>
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

commit b8ed9165906597b69a46fabf39ab41690721ebe8 upstream.

sx9500_write_event_config() adjusts the channel and close/far user
counts on every write, even when the event is already in the requested
state. Writing 0 to a disabled event and then 1 leaves the counts at 0,
so the channel and its interrupts stay off while the event reads as
enabled. As channel_users[] is shared with raw reads, those can then
wait forever for a conversion. Writing 1 twice and then 0 has the
opposite effect.

Return early when the state doesn't change, as
sx_common_write_event_config() does.

Fixes: 4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ Context: write_event_config() still takes int state here and tests
state == 1; the added check is unchanged. ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9500.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 3e4ddb2e8c2b..d7b8fba66773 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -551,6 +551,12 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->mutex);
 
+	/* The user counts must only change when the state does. */
+	if (data->event_enabled[chan->channel] == state) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	if (state == 1) {
 		ret = sx9500_inc_chan_users(data, chan->channel);
 		if (ret < 0)
-- 
2.53.0

