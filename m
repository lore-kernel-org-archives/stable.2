Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793539472;
	b=Pqblq9rzKm4j5lpeAtRNEE7lhibGIe9DrZCcBjH7wawoxSssNXufkXTnJmpRUOC9rW/K
	 6s/aD2LojIXSxYYunkHmr5tyJmr7CZAWf4ulyW7KtBLdW9s7EDmJ6A8J7e6OHmH2yjomz
	 cycNSsUmpv1pC1AVAoGA+UVAsDpFhMQWl2dnCWuZwHqwLo2fJePsd4fRrJVdBzZb44Su6
	 U8k9+LPzuXZq9kQAKhz1V6FRiefhBgD97c4fnIa7LI3MjgjrL4sLHotuNpxdnFDNOk5Dm
	 lEwN/VbwTWx1Yl/Vahs4AoffUbz/iEOrZsrnS3RECEzGOacWLb4aHQhhuNe5UGdjB9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793539472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LzlgOuGdib5YOq34P/i6bRldhrAYEuaYlkzFNFcIg4Q=;
	b=bHKELkZs4q8kAfRFzfpg/erDkry7+4FVvpw22O+aWLYXk+GUQ1fV86YqztxGbKlD/sZx
	 czXF3X33uFWkj8yhJLvv8/2OpCA09CrZeOAFfvYXxeTpa+plVk065pC9cncNDWuKw21bj
	 IT9FHJIeCJiq8ZSQ5h/ThQ0Awd4gX/ZuhjCEuPFuF+WCA1ZnYvQ86t8NAo6QTvrNNehyf
	 626KBjGwbegEFBv5VWuQumEOFFjpm2d5RcRAxyJykSq48kMl1RmdexepevUUIFwWQbxeT
	 rIeaTXrPDBoz1Pck5V4MS82OsSm34dQa3dRffHu/R6JSI2YaKhB55n3juqmEDmeTxHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=korea.ac.kr;
	spf=pass smtp.mailfrom=korea.ac.kr;
	dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=ETepvLu0;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F958606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 13:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F958606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=ETepvLu0
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b2d149693fso4045527b3.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 05:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea.ac.kr; s=google; t=1793539469; x=1794144269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzlgOuGdib5YOq34P/i6bRldhrAYEuaYlkzFNFcIg4Q=;
        b=ETepvLu0v3btKNzRkiQzA8a2GUrFc5vI1Pg6UN3Q759yFkLyQJh7sqyODCeM0gEGwi
         YFnwzYXL2dtvZ8q/IIGEb5bveVzbGBsLNLELkCbs/6ARqLbj4G0psW+zjvHZxqTwiGkl
         PDO1ZJ5sLqwfQB8MMpZ6UB7hwuSf32eYRbvK7rLwgRTBh8679DF+4Q4c4+NgCnxeAwT6
         ZpFYlyr3cc+eDFZqGot95/cQxNBt3nq3Dimr7tvTiNo4g/Uj8GA27s+YeG4KXWIZVHDO
         95HNmnIatqbqN4kwgwSbwggyr0tshtyyT++f+F5U319CEWlILSH7awfSkDFGmD3vOCK1
         atag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793539469; x=1794144269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LzlgOuGdib5YOq34P/i6bRldhrAYEuaYlkzFNFcIg4Q=;
        b=J1Ct88b6KicB1kJjlTWJRH9T3TPh0HHO6TNDs0OGBSxhtUdkSx/IrOOCN+XIyzGmbY
         sxMkD9JhiwA4O9c9Aji/kogX5Xue3iemE9oJjleHLaaFvx2vgK0vlaCXwkzl13L34Aco
         TGF8lyTSvjsLfcfuSUw6yVithWrV2LcQtOKgT3r6w5VzhE4dZvICIjyG/5Sd2iSSiys1
         FHc+lQDOYzRY4UQC2h3vPwhbAHeITqzkigH+pxRtJFDxVr446rI2H6XFhnLNz5VhDUpy
         8doG4bs16cxST9iBkAxy106X44x6jSxCK4bmckvuINb41+FtI2ZgFk3H6I+P/XqlPgWe
         ayVg==
X-Forwarded-Encrypted: i=1; AKwUvBy7cAB3Woo5gnvMYLVUMuMFb0rVaCOF2oz3qVyW9LNwunz3wrjM6d26loHURfBT44H8oJsUHV8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3cVpFksEG9NJms4x2IxlamCUeg7VE2OQ55b0OtuFSkuNHgOTi
	nEiOpKG5ofJe48N2/m54WGUK1xsU/xX4li9QfPi9m2zi7QN0qYXLHi55BNvirnOOZrMccwFG3Z8
	U1YxGTXUw
X-Gm-Gg: AYBFou1RlX8HGzTa+qbnRSv0nNP0ZuCF+43OmApwNXA6Hcd8+Y6imvEl5ZTLKCBagpf
	Lqipiz9SgwT2qDnlM+yvyEvqrUb8t8gVgSjNWsBJO8a43bj95mUnqwNDRZbgETVwLmd5/mRRGkB
	TDlrRIkEPh85QrlOZZ/BTEAmSw2Yid+p2lWPq4GL69ljxU2VHNyTRKa/BeDnGMyeJWSbs0SyWk0
	AU8PQddmH0ktN35rtrzOjeonPuOhOgMEZ87ENdvWrcP0faKsrUjX29rGJkfVDyEgEjoqsZahKoQ
	+H3PktyVGPALg9ThDjcYX7ri2BddAoeIOxxFhCkPGPifeyUCD1XP5SGsOxd0NV7xWPxzRTNHnOF
	5Ymqwcs41xZs3pxum9slK5rwT8AXRhe9QvSvEAliENx05+Wmi1DlYubPIG4io1PKMn2JXRMzHB3
	YDRA/JxGlQI7IMSH3Gsb0ZkLKaAAwpAgfua5TGfoJwlZ7DtqSTWHuvLUr1rlQLS2ieQtuGz0saH
	dRNCv9IsM4d9YYx/2JNx8r+AqghCgMdyp+3MB02IJGBVrnM0uJWMAx69adRD+X4wjruduYC
X-Received: by 2002:a05:690c:4:b0:8b0:a352:f978 with SMTP id 00721157ae682-8b2b65af008mr40507547b3.4.1793539469488;
        Sun, 01 Nov 2026 05:24:29 -0800 (PST)
Received: from s2lab05.. ([163.152.163.130])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b716433bsm37301417b3.26.2026.11.01.05.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:24:28 -0800 (PST)
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jai Luthra <jai.luthra@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Naushir Patuck <naush@raspberrypi.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ingyu Jang <ingyujang25@korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: rp1-cfe: Use IS_ERR() check for media_entity_remote_source_pad_unique()
Date: Sun,  1 Nov 2026 22:24:22 +0900
Message-Id: <20261101132422.1396104-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514193148.2357371-1-ingyujang25@korea.ac.kr>
References: <20260514193148.2357371-1-ingyujang25@korea.ac.kr>
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

media_entity_remote_source_pad_unique() returns either a valid struct
media_pad pointer or an error pointer (ERR_PTR(-ENOTUNIQ) or
ERR_PTR(-ENOLINK)); it never returns NULL. The current NULL check
therefore never triggers, and the "pad not connected" error path is
unreachable.

Replace the NULL check with an IS_ERR() check so the validation
actually detects malformed media graphs.

Fixes: 6edb685abb2a ("media: raspberrypi: Add support for RP1-CFE")
Cc: stable@vger.kernel.org
Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
Changes in v2:
- Add Fixes: and Cc: stable tags, as requested by Jai Luthra.
- Collect Reviewed-by tags from Dave Stevenson and Jai Luthra.
- Diff unchanged.

Link to v1: https://lore.kernel.org/all/20260514193148.2357371-1-ingyujang25@korea.ac.kr/

 drivers/media/platform/raspberrypi/rp1-cfe/cfe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c b/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
index 8375ed3e97b9f..91e9fa0341e06 100644
--- a/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
+++ b/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
@@ -1779,7 +1779,7 @@ static int cfe_video_link_validate(struct media_link *link)
 		link->source->entity->name, link->source->index,
 		link->sink->entity->name, link->sink->index);
 
-	if (!media_entity_remote_source_pad_unique(link->sink->entity)) {
+	if (IS_ERR(media_entity_remote_source_pad_unique(link->sink->entity))) {
 		cfe_err(cfe, "video node %s pad not connected\n", vd->name);
 		return -ENOTCONN;
 	}
-- 
2.34.1

