Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9813AEF20
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762521; cv=none; b=Muz7AguAkJp7dgSPavnGSCyZ0Ho7OpAhHw3/A4x1M7aqZj0zZYNoShkKP+gv6qNNH7TDbwSWO38rKNNFICo/vKpiQvmMn66pxKxD0Q1q0a+AYKhcyB1SdYybuuMUxA/GoCxJQaMvn/Sdu2kXC4qP3teF63X/Fx+A4agJrXFPosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762521; c=relaxed/simple;
	bh=HQVLVPzjRG5hh8fZIGmX/p3UNdpvdNQwjepL5vkjQ24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O78Wap2Hcaz3E5X0qbKT9Z7CPX0mdy7dnRvkge0Op9KwmKe1uXKIWZtufIc/n/FoH2YMjjCovtGeR1r9i5l8Q3bT2hH/A9KxgvmWx4eys6Omyen2JXWoUHbtUDcJuZy5YLsZ9CuWy4E9KHHFHPYRKdz9IEUUC9xQSCQ5QtNeSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwrocECK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwrocECK"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39647184c73so3809168a91.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 23:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788762518; x=1789367318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1wSKmw/x+Nhq5u1uQ+7oGEZmPqsD7MFhh/OKQ0EiNE=;
        b=RwrocECK6AEI5KhukKMsJQCOLIy9i1qVT7yV9iYiUpxeg3xQhhEGodkJ7Yw8Mp6q14
         CzMOm6253xf0zLwIUAhHIy9rX9n4AsC8hY8LmIail2CCwU5LkWCmATG9enClviPymLjb
         VElL718wfIcogc4u8XH6tfbN4dRGwxAd0v5UadYglREbGEcmeP9qw3/fivdnJ9vqctEG
         rwjL3rLMRxDGidXib13Fgkwc8zNEWTqIoKxB2eoIGGeJVEOoGFDJTi1aEWsA21Olx61E
         1oRVvZLO4z5xF6fraLmQ6SyxNDJTsfTPBG9vQ8O70xoHuoaHp6w2OdzZwRzV3erX9mBy
         0uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762518; x=1789367318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1wSKmw/x+Nhq5u1uQ+7oGEZmPqsD7MFhh/OKQ0EiNE=;
        b=IXA3VBGG4vg2c2u5vBjizKNf5akYY/tgf2xWyo/VGZVftCT71QGPIcQ9hAvfQQ0CMo
         /ZRNi3iP600GuDP/vZmruvPaowDDTF3zRBQ8g2HN4hi9mzGY6/39lWy+Auh7CuNoLhQN
         MY3yohEgtg5PVsGQeW+PfjIy50EIhj0aGauv5RLDc4zUaxIQlG8PEuhiN9VH0ygWb9+6
         u810tKZEDXt41h990/YIKdRSXnO6Mcui8txv7eTub8X/OHblEaLDOnFzg8LSyCwfOYA8
         SQ35wiUX5r/9WEjj5KyFVGBZhOOG6eEgvSj8nSs7Pj5XE42S0q4quJhLS6FBd2trWOcM
         TDiA==
X-Forwarded-Encrypted: i=1; AKwUvBxO12Yglbw3MAfxhvbKb/i1RG+wG4c+53oEmSoP58HuFvtMTvFH+X+63eKnTvyeJgbKTlbe+Ws=@vger.kernel.org
X-Gm-Message-State: AFuF++nuP84lDHK48IMyAn3KidPVZNzIU3w2aZijuQ44BGLTqDSY3nLF
	fZ3X8w4gzofbI6r+FnTylK0nAzGXEWJKNgBMjkEf53Mu0CysSMeqc9QL
X-Gm-Gg: AYBFou3YOhk7h+WCZoh0N2OqTlDR/EjZsMP0q13ccoNZLTyv6yMd2sHdYD2PhEcjMdX
	0N2cOpx20CrXZ9lUvtg/FkgivEWmyyeHxtmCCRjMHcXVFRg0OSjKQs3frl7wc6N8gG0qNTMLuiW
	w5lH9A9VAlNvKKFoLEHM6FFcoL3hooXUkVCwcMgyfkJKTruyonqLQAWToCFINdfe6NpFGoIUiJd
	g7hbc0ru8F8+fichQD7/zbTF7V9KXrqScHrgg2woQw3idPQN9P2Gh/idxcItUj2y+LfjI5fGzZT
	nNmO32ZMZJyNd2qzPhkhBJcu/8mPYfs4Be3n224RWYoBNqpu5cTQv/q/aMNIV9KU5zas6J3f1gi
	3wKvsbp3iL4OQyPtm1AQd1YJYsgnFIpoB1KVuSsigcRnwnD0RpcDtcVcObhglnG9e+q/J81wmm2
	zmKwT5cVQ4LQpB0ZhCdAUHdG0tYU5I7ZgjNkI4GQOf5K+Arx68qPoXYdBxkKyrlTkcZUt/TU1Ru
	NTA08HO2lMnnl/T43tCbegkhoysrmi61vXW/kTzxdkKUIms26j0YaBD0uYSoP4byT3ZmZIQ+1JU
	GHEcQYU=
X-Received: by 2002:a17:90b:2ccd:b0:398:baa7:4c2f with SMTP id 98e67ed59e1d1-39b27c442f8mr16725731a91.5.1788762517830;
        Sun, 06 Sep 2026 23:28:37 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25c974cfsm18978042a91.0.2026.09.06.23.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:28:37 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] media: uvcvideo: Fix NULL deref on events for uninitialized controls
Date: Mon,  7 Sep 2026 14:28:17 +0800
Message-ID: <20260907062819.2519878-2-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907062819.2519878-1-98lawweijie@gmail.com>
References: <20260907062819.2519878-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A null-ptr-deref exists in v6.12.105 and upstream. KASAN crash log:

  KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
  Workqueue: events uvc_ctrl_status_event_work
  RIP: 0010:uvc_ctrl_status_event+0x105/0x280
   uvc_ctrl_status_event_work+0x82/0x240
   process_one_work+0x66f/0x10b0

XU controls are initialized lazily, on the first UVCIOC_CTRL_MAP or
UVCIOC_CTRL_QUERY.  Until then ctrl->info is all zeroes, so
info.mappings is not a valid list head, list_empty() returns false, and
uvc_ctrl_status_event() walks it from a NULL next pointer.

Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/media/usb/uvc/uvc_ctrl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 3ca108b83f1d..21802f9b1b61 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2209,7 +2209,12 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
-	if (list_empty(&ctrl->info.mappings))
+	/*
+	 * An uninitialized control has a zeroed info struct, so its
+	 * mappings list head is not a list: list_empty() returns false
+	 * and the walk dereferences NULL.
+	 */
+	if (!ctrl->initialized || list_empty(&ctrl->info.mappings))
 		return false;
 
 	w->data = data;
-- 
2.43.0

