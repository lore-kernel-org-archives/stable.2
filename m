Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619566;
	b=3h12HkFyZPhCQKPd7ZC0gFMk15AW2cmxn5bzYuddsYD8kUNpPWoXxMpdFMB4GAbcwEKV
	 Nqs3N1dOwuychKVszfCeRbezAuZ0/tt/cb+Hw378i4WwCwP0TpCq3YkkGhh4n+bPChgxb
	 K1ClcWsjYxC8KAjtoWW27FgPfntFjXVJriv3+Zb5KjTKRkNqOVN1Pvwz2cCHkvk/CG4Sd
	 1lMCxXZfuRzyocjl2+H2dDAG7T+854hMey/wpK7BxmHdZsLH9SpFspXoZwDwCUGdrkGWb
	 VytmTu5ikDp4E6s0OPC38lmHMttFUYEIWZNr66UKy8DE0i/3XAmKmMMgvj30GDIxeiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CIyGXCXSnOGbVeFCA4ZzO8vNPNndy3UmYT4yCyDyn8A=;
	b=DKPmO753n/mmOYR71603ySzfHejE7JX4MqR27K+I/8Y3+141HK1pnhfvAmEPVKGRWzaR
	 g3lBt0gGQC6UFEC5kGfpunC/4fjn7wmP6hYNJsq2JxEF6Ra7Dn63au0cFbelmOO9lbYrL
	 ioRp3ml+EIsfkJzNkVKGGZI5PqykKZcunp+iYouqvkPYEijJbv1zeR/YN4rCh7146IMk6
	 3YX5Icw/+9hOQcIzRO3aQXr4YVCuoYvd86Tn29M5lA5SLVGQE5F5op/TBJVRcj9AsTXoZ
	 ksxPn7qAeSg/+XLgf6jE6YBcxbvhN9WUIyOYWICpz8jts/O84eexXSm0k1A8k4ln+yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuZrhgt3;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B03606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0B03606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuZrhgt3
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5569551d19dso70922171cf.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619565; x=1796224365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CIyGXCXSnOGbVeFCA4ZzO8vNPNndy3UmYT4yCyDyn8A=;
        b=WuZrhgt3t6B1lkyjsJoRjyHb65WytRTkENwD8cQKegMIsnMThrzziqZnNyAB27Y0q6
         kMMbj9fESxQ1ue0fEOhFheQCa2zJB1w1qXZ3j50idDLTVJwkQG/5vTeGjkDvEOORMk8s
         S7y9litaBN8y/fV9z5OPXbwoMqNI2W/LDDI52VQ4I03/P7tD/uQGeNp071vZu4AnnSYI
         x/k91DGEQPCiJqQXo65myJ6opiqxuU+1Zvi/xITyKIUhBuIUBBXxWP71M+efvT0IPaRf
         j9RV0dz7KklWIFCyCD7LPqWQN5d32BeC5eJ7wAHZod10+DUuG32mzpTIbiKMRVK33aJZ
         8aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619565; x=1796224365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CIyGXCXSnOGbVeFCA4ZzO8vNPNndy3UmYT4yCyDyn8A=;
        b=kRc90LgtB1yxMeoWueDnxrk4EqiKO4B1wggLivvHpMDG8vT92FmRB0euHTBRTH2Goe
         Xod+6THoKY3IlhEvyX8jiYOMTt9QSie9MZr6xDCC2wDHZHaxFLZ3UCBL3uaz9DAPeiOx
         RGMYWCbfnHjfPaKD2eCoc2epRxBurf+bw6taRu/mndjFyULTFu2ImpysQCk1TAzWO4cK
         VLGZMvrMGZrmMQljj6CnVT90QqiUybVA02ndEhLkTBOJR9cDHUiFEtvMOoO7dMM3W42k
         Jheg+qBxWUfi+3UFsCxBipdbRj8I/FJyEtOQQis/wz/MojztKVBbUcvIcz9ENPwDbaCr
         PN7w==
X-Gm-Message-State: APuU4Z9JpJOfCU8+NP7XSHIpTp0xOFuYZ7LnqLGqXHDhsbqwyX4Ea5IY
	rikyC4Ow0JhgjBPrkFPFtz19E4NjsOfzMaQcnUOoqtADhEoIweVp5AL4r8Q/0b3n
X-Gm-Gg: AZFdTZfmePID0DLiKX17319yKm39rrWz2R3yAQjN1q6+KdcOXmYZJCECHY9dYM4R2fj
	cLHukBGVSKSCmQqOY7CVFcsxFQ1RYR94RFTS5ohZWQnOe5iamHujVT9XH0rWSMk+5b9A98WlaIS
	eRE0cUWV6cvjZIVVICbKRQdCydN5/ZIB2NVug3Uckr8gN+XOhueMf7AwIwUeOwlxyerOgTGpeX6
	B6hNdTdnuV2Mg11TjSzVKkudpOa7wuyOFbTQtbvXTqjp2StRl06ucXBraQm4/JuGGJknKfcpnrN
	Me0vTMLRHYJHT81UjVLy6dYByFSmEjo9P7xgYABbwtHF2RimBg01PDI8REpACkTaF9JWkICpnnF
	7YO2vG3lolXFWZr8jHJb7fzpsIv38vNCkcpwNV8pm40wNvjN7R8YPptaWiC8zmrgMECBUI5jZll
	9E5jQjZeyOjjzoz6e0t//Aim2Ntjy04CbIXUsYrSd0aOSdMaV1DfzAV2Xcu//SoASbiMYIiKBWt
	UG4EnJMzobW1nI4TwHpaKBo3ycH6G4gMFnmoUvICpGi7v68NCWwpVA18IEuaoA5pkZkzprBKX6S
	8LftgAVat2f686Km7ItTI9YxM1rT8i7HfJrol8KXc36ENArspCxNDqBMALBICgqvk6yLTAn2P1G
	PnguGqL7FUV9E0QaPlvRVhynXTntjKqBKe3t/nf74wCqdKeyRIsWRA4G5+arsmbNO4A8Z8AFBtV
	WLTOMOz8XNo5PixqHOaJ2AaG+ZpJpSvPMKNPRt8qz2jA==
X-Received: by 2002:a05:622a:1ba5:b0:55a:eed5:7ba1 with SMTP id d75a77b69052e-55d76a02037mr320681941cf.17.1795619564596;
        Wed, 25 Nov 2026 07:12:44 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7889ea4csm158336661cf.26.2026.11.25.07.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:12:44 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.12.y] iio: proximity: sx9500: ignore event config writes that don't change state
Date: Wed, 25 Nov 2026 20:42:36 +0530
Message-ID: <20261125151239.341766-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-drainpipe-glamorous-4154@gregkh>
References: <2026112540-drainpipe-glamorous-4154@gregkh>
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
index 3f4eace05cfc..1041d3defe4e 100644
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

