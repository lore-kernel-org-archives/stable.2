Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742998;
	b=EkfPwABIkQjAiilghGpqcG3uQNLMzXWXxspjWMOrmBTWEetMgSCr8S+StyeTR+3B0PjZ
	 VaZGoRyfMReBjjQn0UMcy7uRf70NIgxUomBmZot7/UWuYt7JwZw1oliLBnkQyp7eAEO0n
	 bUOrTOJZKHkZrnvWFHh4Wi6UtPAX2qhIm2hSAoIwPXuY5d/r/5kw2UKM9KuOv0n7Ub+Tl
	 1VAgbj43s5jOIoFXq8CM6vBQZ3Rt0mU9NrrvaYxzmc8URPfUATLGtefcwua7f8pwNFzfD
	 BsqEDtstayPIT1WCdYEBju9CGHR67Tkw/YOtFlwnjFIENLgDMi2aB7bOTDfDQE36AQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PydVMHArz0TUuVCof4/KPrJGkSdN7KAo4OoEVIb5fy8=;
	b=rIryjanDQCphmvdcvZLw5XJGjoMcBIIU4mCto2+J1TKoexThEEceJTPor5YAenjbNDu8
	 pWuys9Tp5x28i9/GbAEB96Ju7x73lqPr5OsFH1jdNQMs0yjWV4oKyhSnSKMts1OQqQH05
	 7Rgcb1SDIKh7JB0IkORWB2QqC6cx+daegVXssoc8KmBbxgenpelqtw3/SD4bAhdFx3D3W
	 QIEZbBt/BE+dbncuYD2fUh+sBo/z9QZvGIJnRSgBsZ75fZxhWQwJpm7MWPYLTI169MhTq
	 IeVZi+kZe39/rOn67/VDpNUUDjFS7YRENSrmgx7uPZNu3aWGDjTLqM8mhf6Su02C26A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="kXE9su/X";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E96606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kXE9su/X
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d870d54so358985f8f.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792742995; x=1793347795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PydVMHArz0TUuVCof4/KPrJGkSdN7KAo4OoEVIb5fy8=;
        b=kXE9su/XrilHaMKHCZIVTSdlDgafpj4k8kcjJWY97ikZ6FAKv8qH/jtWzp+Uv6eGiy
         G1cJGlVl6/XQpDeWDN9vHzYUzXzKM4zZlRcKCAvcz4pquWFVY2cFjMUGExIoZllY6XyH
         BVyfkcu2JSiFuSq1KcSAs5frWzt5QQRYvG4goHN4LzhTNc9YKMrbSkRBASZBwkmM7/Zx
         bvH6hk5WznqLWYmqUlW/8LBf55c6LEbGe4YHsQDRHhxhVd8vr3jI9/NTQ+XOFo7ULSNS
         PHGoCtvALIZEvKYcq6IZ7ncDbvIdmP6iJNSIM4HbWlV7ldcVXWYVZLljeItOkYCmsPux
         /hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792742995; x=1793347795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PydVMHArz0TUuVCof4/KPrJGkSdN7KAo4OoEVIb5fy8=;
        b=U0tJMXhFyFXYLHLXxlO30/bwnB3BWLP/Uz86GYfFAbmK7Ll3ybfdj+rnFj77w3fhLG
         MRcxBUlfvtieonlSBIC+7Bx8WbttDG9Fue9WA3GUa/BMffRCC+30UrbtT7nZw1gsMsqQ
         /2235ccqHAy1K+B0k/6dDZsBLv/AZupjQiVFiDait1yfjBT/AsSZyCWOaBkSwKWiuDzk
         7x8lZwCjFL/6QUNXacbZ5Fc+Sc3xsr/NkewjQElq64CQ+DbqcqFpFPhGULEVxOJhlKz9
         ezk/7eUd1JL9/JXseNeyH0p0mIsZ6oCGtZzGkWxAk/wQKNpkrI8JI6alk7D3HHQX+YVT
         yv7A==
X-Forwarded-Encrypted: i=1; AKwUvBzrrdkmIaUGRu1jPad4yNsolGAlFi35UC0S7blY5RmZHaIz/J2yeSVbgVllIaKROtZCmqFrrQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQde7WLANLYNA8lNfjCBTH/pleKXIoUX9M6hSVTv2VH0kqLkn1
	V31ISbDbWLi41nMHATt9eMKFn1PeFi2rC0huBx3GINTtjcx0XSPh1VQS0r7Nr06sjbk=
X-Gm-Gg: AYBFou149m3Junf8YJmhrkTylHtDYzl0gtsReQ72Q6ytbOMXLphodKxgy8b4LBP/Vbs
	J0RryQ+Syg8LDkHSrC5A1isnHQhNXkuhrFSiUHE7KWp2xNpXQQeiVsj4MQBOkQcXLZJ4eM8VyR+
	OA6PVY6lWAZhfCdg2IgGQy5rraX0dejeXOA1wMiyCZOV5cUAQpYDQePfN7GX05tHsjCY7N/H1gE
	KUc4p9MpzpOdDGQG3N/1rjEnISITbZ19e/0GY7TDhaiBVSEc/JZvwnH7NUIOUcz4s6Zn2uBxVRB
	lqu4ZdtLh60cOGr58xMg5w1klh+wi4lZUUu5uBNoqSaUk0iEWMg89VX2O1js8w5xYGie8ZzukNt
	0sNm6DtvGS7GLsKwXiDHg+bS4a6AuVlNF7WU/Ljf1CwvmMGfotrY9jrIvcNssLeisL2OSaTY+7N
	TykWaIexu6/16mA7tB9e64KaK7A7JYc1dFeifk+lmVCJkORUAfnIZCRhTdIOh357qYVpoeuUSIL
	mdm4Ru/x0DIcnlHmvYRPXWpRqeywXDCiFC/z17HD7ixI4SuUWbJ7eipRnKjGh9j2u3L1mpxkZwg
	togTc7MJNl8n3kafTeVXnVZfbCiuLf9wjA==
X-Received: by 2002:a05:600c:608c:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4a2167acd9bmr9976075e9.21.1792742995238;
        Fri, 23 Oct 2026 01:09:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:6877:44a0:5297:9502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2153c1b7csm18493655e9.1.2026.10.23.01.09.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 01:09:54 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Vinod Koul <vkoul@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: dma-jz4780: Fix NULL dereference in tx_status after terminate
Date: Fri, 23 Oct 2026 10:09:53 +0200
Message-ID: <20261023080953.16963-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

jz4780_dma_terminate_all() sets jzchan->desc to NULL. The cookie of a
cyclic transfer never completes, so a later jz4780_dma_tx_status() call
with that cookie finds no descriptor on the channel's lists, takes the
else branch and reads jzchan->desc->vdesc.tx.cookie through the NULL
pointer.

The driver has always allowed this, but it only shows once something
calls tx_status() on a terminated cyclic channel, as
snd_dmaengine_pcm_sync_stop() does since commit 88e98af9f4b5 ("ALSA:
pcm_dmaengine: Don't synchronize DMA channel when DMA is paused").
Closing a playback stream then oopses:

  epc : jz4780_dma_tx_status+0x184/0x210
  Call Trace:
  [<8048e104>] jz4780_dma_tx_status+0x184/0x210
  [<805804d8>] snd_dmaengine_pcm_sync_stop+0x4c/0x94
  [<8058f068>] snd_soc_pcm_component_sync_stop+0x80/0xc0
  [<805775b8>] do_hw_free+0x20/0x6c
  [<80577650>] snd_pcm_release_substream+0x4c/0x9c
  [<805781ac>] snd_pcm_release+0x48/0x9c

Only compare the cookie with the current descriptor's when there is one.

Fixes: d894fc6046fe ("dmaengine: jz4780: add driver for the Ingenic JZ4780 DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
Apologies to the stable list: two copies of this patch reached it earlier
today from test sends, with the Cc trailer still in place. Please ignore
those. This is the real submission, and it is the same patch.

Seen on an Ingenic X1600 (HiBy R1, compatible "ingenic,x1830-dma" as
fallback) on v7.3; the code is shared by all the SoCs this driver
supports. The patch is build-tested on 734bef548a96 (v7.3-7363).

 drivers/dma/dma-jz4780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 6070dfdb7114..7f827be502f1 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -658,7 +658,7 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 		/* On the issued list, so hasn't been processed yet */
 		residue = jz4780_dma_desc_residue(jzchan,
 					to_jz4780_dma_desc(vdesc), 0);
-	} else if (cookie == jzchan->desc->vdesc.tx.cookie) {
+	} else if (jzchan->desc && cookie == jzchan->desc->vdesc.tx.cookie) {
 		residue = jz4780_dma_desc_residue(jzchan, jzchan->desc,
 					jzchan->curr_hwdesc + 1);
 	}

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.39.5

