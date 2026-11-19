Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082557;
	b=5fiZ6iXjLqwYn58lVbHGfGcNz6MEcWQSsyD+qyrNqASiQK46ROcH4TNlq9Wwvkw8RSNd
	 H3fFO0R+TU4/IIz/5S2mv1R0cZ6Tyafy4W/HjZkAKHH+qcqmZhQ+LhxSOtc9jPcUL5vqc
	 HDelvyMU+Ga0c6mGUwhTfINPqUnK3y5Hybsb2A0f2BxnMJV/iZaDrbdkzpncNW6LOx0UP
	 5GExPPEwB3neEo3Fe6OvjSxENyrYuiudrvjnxByZfc3ZDgCcXFtbg81hyQWwRxOX96sLz
	 +CBcWvORcu8+hhm0nRQxQNiI1sjrDmL4vUygUTH8alIQRUUNx0G5WgV1B/16jkO5UBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
	b=nW9wR7f/X95gFzoLtdYVLUC8uH0t9hrn5U8RysPjz//4HKBPy7CGQhAaqjY0gx3TXNQX
	 YB/BhvzUHlD9zjNgb4xzJZh8n/pyqfyt1HrhLPEDrub9GcXMwCykT8a2qZPpsKnjAAJwM
	 1jX3whZLdWZ2PHsy+CDbdrV2QD5ri7Hf4hkf1Wbz6bFFXrbbApArVGPYkNqhzAJw1Mlby
	 AdRvxKfpMfJAvDhF3IbxLMIg31fOdUnXZ7YCNfMMdvsrAjuLR+yTNluJHDc/F5ADwP/Xh
	 dRNY43NhSMpnSoGW/a58L7o3YupGNsPXeY+uwfWDjcEOCv0LAdNWvvpAkKdtZuWF3MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdTIfOeL;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4760A3802
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74E4760A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdTIfOeL
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-70b875f6f13so1727465eaf.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 02:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082555; x=1795687355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
        b=zdTIfOeL/7d+RS4Zt6Awzo6rb6wnu6WousZ/R88LlA3yr0tZDPkSAtaCaKBBXX/qb9
         NpQrleP8lK5nW65IK+0le216BnWWjIgMO5H1Gw9I9zt3VnnHGdJibzVKovL3Cc860dpJ
         r2/SR6Eq0um1536Nfu5IE0PQcAhb+W7DQn/tkfXU08UyncERGTkE3Mx8D1bOGB0vC3x4
         3OzPFY1bVX3GYIERM1dUI76jQscxbzQzTNZZm6vWAGCOBlDfUQKGuD/tDUPgTU/2FXD4
         hLEsyXsYcEuVyi+A5m9H7sHe1V4Ug8hj2zL3/TAMqS5QoWQdyzlBuf+hU/vSMvIuQfJf
         LL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082555; x=1795687355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
        b=lB7tmOCkv4dgW2kadaHTEFUBywz91NVkzd1lv0foI33mmM2KhQXJO/GSUsVvRaUIN7
         +gQayDmlYmUV1kJhfPL/QuVk5hnSA6azAGMXnraU2q4Wql77Fqs8NGMoYEVkVkAOkiiJ
         47LN+Uily6A0hWR7tkuz/2cukGNt+wEuTAOkg6lWRWWyfVu1M6gS3Om4pb9CsJJ2GT9I
         UeX7CRRl3IZ3OENHQOq0ChxGswLF6OX56+NeYGuOTKqi+8ziGmdhD9v9RgOG2m9v9zHJ
         mdcvNDj5jjy0/hx4trJb8YF495okXMsqSRjskPAY5LwCt8lRu0gtMLt0lBthFBxUwW+x
         gDdA==
X-Forwarded-Encrypted: i=1; AL+hErFOfPVLJZ4b8fDZo151ikmSqDK8Djxfgiah/NyoTtM6DtB5ee49UGawsJXoZA+eMzKqayUl0EM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Pxqxu1Xlipa9dcTdotkXOWMp9SZ9X89vu0db9f181anksiPH6
	mPnEyHq/Lscmp95pELnrPUxa2NU7vgBtSb/RXXw6U/keTv5Rpb1W2yAR
X-Gm-Gg: AYBFou1gQIYMFPXnu2VgIKARcNBSfI5+1tQHwRTFPjGUsnMW8Jwv9ZavMlGPQkId6tE
	O+tqz4Mf3YESZ0wnQzHWrK0hsUlYUhP05shBDKZu3YVKeGew6CYn7ezshTxw2jUEwj1mZm3S/87
	zxIbcJTvb7FNhWwvAmkXHGMn7JWOCYRn+y51hWOqDuKMn70P2huCqMGWQh9hi+TAVzj9hX71Mds
	NCYdnESNSrOq4nP6DP1156shgp8P9VD5pkPoe+HBiTaqRO1ub9hs938IzdvSFJ5/E8sMzMlz6pG
	TAIIDW7EBekxqYdmxZMMQlSRwj4Ymb33p0SkwaO70MNsIFmVqT/iHLgekVAMzMsrxwEk7Rz86dZ
	h38PXl11wVNXmUXo8zy6OeP/uRCpykqhMXovHrFgsBbgizv4QFR3u3Jd02WM00u/a8lLmphsyMV
	kl6v7nqDJf6ufEhD496DLZOWWDi/avf/DM1kJEqClFrQGjK5CnbSYF4cprpQ8GyoDlOQ2ltY9O5
	MnZ4hI5R/MEFeMNnyvKC2MBAR3Rb0dKl3CV+Rl2obzU9y3CQMFdqvo64rruHYbddQorW1ABDbTw
	nxaU105tSCplKwxIGMtGl8igtvZ0iHnRMpEzrYmq0h3ohwp5Lj3RbQgeWjL5/a1uusTeB/O/OeJ
	m9mSXXnzMLRDGoXeDzO7oofcFbnC7VXmTOB4RlQI9gkoM5G3Q2zOKfxoTqQrbLaHxhHAmdVk/4V
	ySlmsm6VfsUbPDdJsa4OJZI6OJclRM1q48G6dkHG4WlYVk/uhCqqCY
X-Received: by 2002:a05:6820:1690:b0:718:984a:50cd with SMTP id 006d021491bc7-71b18476360mr4278894eaf.25.1795082555567;
        Thu, 19 Nov 2026 02:02:35 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b18fbb9a8sm3906194eaf.0.2026.11.19.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:02:35 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 03:01:41 -0700
Subject: [PATCH v10 7/7] dmaengine: dw: report residue for queued transfers
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-submit-dw-dma-synchronize-v1-v10-7-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only checks the active descriptor, so a status query
reports zero residue for a queued cookie even though none of its data has
been transferred.

Search the issued and submitted queues as well. vchan_find_desc() covers
issued descriptors; submitted descriptors need a separate lookup. The
status getter already reports total_len for a descriptor that is not the
active transaction, giving queued transfers their full remaining length.

Fixes: b68fd0976286 ("dmaengine: dw: move residue to a descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 7a66dc75c546..f9761651c7ec 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -942,9 +942,19 @@ static void dwc_synchronize(struct dma_chan *chan)
 
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
+	struct virt_dma_desc *vd;
+
 	if (dwc->desc && dwc->desc->vd.tx.cookie == c)
 		return dwc->desc;
 
+	vd = vchan_find_desc(&dwc->vc, c);
+	if (vd)
+		return vd_to_dw_desc(vd);
+
+	list_for_each_entry(vd, &dwc->vc.desc_submitted, node)
+		if (vd->tx.cookie == c)
+			return vd_to_dw_desc(vd);
+
 	return NULL;
 }
 

-- 
2.53.0

