Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876873D649F
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473493; cv=none; b=GpgEnswPQ6itFfVyNKa83/cgZGJNeZkPXWumIy6wGeH7jpzs2ZFlSrOvoF4wV8Zv2aLaulIU4GEUdngKkpAGSccsW48ZmgZxjDRDMdtCP4RC2DEdXfDNFgtRl+1YSxffYpM1GvlaAUA6ozomZgZWys0aIHxQJ//00CdfLi1e3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473493; c=relaxed/simple;
	bh=8g5Sd3uFifK3ZVwdy+TGQIZh+jmWxcGuzGLJlv4ed50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0ij8QCGrQK3xbhotIKctEtJhqSqxjMJgp+wykof7+YYW6bWLpMGh5sGLo9GEl2RTzVDkfLRvxUONN5nNahRu5PxMrVdx3dKKT3Uqp9v7PJJCvEle7EiPVoX8weauk25Atsd4Iwl4ksMJlkZUEyoFq3dKxCNn2kIKod608qe7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJOgV5xm; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJOgV5xm"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso2278487a91.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789473492; x=1790078292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BrGTdKyYWPDzcFJDUsLHUxteyx4n5jj5bbwXZChmZq4=;
        b=UJOgV5xmpcexrx8WPOzF9+dgeAnoI4fLkiJQBwICqMb4rqapGLQSNET7cz+2SLajNI
         WDg+PsecXJMOVrUsub/T31Ol1fpThGMqBdexgwxa0hsnCSEWa8QCmlPmE12vyDDeVMD/
         +7RHE2w+yrWIcffX13f3zwkHpnz+99yldeqfXvPvNDa6ckxAxOVmUTCBmuST1RfdOW8C
         0XAE6rKzw+0JtIAzqwUytVkFRSvh1htg7Ow00kMDHACP87Dfq5JscoWCAMZAMCmHyMZB
         fmBQAmcIO+DypvpTOLciOnZADrXzLR00iIyQOgPR4Y8eYQx93Lo483onOkYrYZvXCWUg
         G55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789473492; x=1790078292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BrGTdKyYWPDzcFJDUsLHUxteyx4n5jj5bbwXZChmZq4=;
        b=DiY9rMaLaVATh0+0IgFGLVeaaPbU7p6XImZOV9IVGhO612S+rMa/7JoPHJ5fCn4Ksy
         nohzzoZ1AThdj7jDQy1hTLeRwKG/mmdkn3GaLXcjksZ4AyUYGVDZTqpEXKeqZub/lYZ6
         g38rmnbvjvo4DPVP8yILtMGtqBF5ASTJTfjevtT8D91BRpEBcHxwlY0Cu7xB3/N+7EWo
         vQRoZBI6jEG44TVGq/i/He69ZEOa3i+7LothEII2xSQaGXPSgJqjX5mYG7xyCbDOZgeE
         RPG7n/9h01YWJuZF/N/N5Fc2HbIu3ljGqC50mdKBQ5BKatohV1ydtVs5Y82/pDbTSJVf
         QYaQ==
X-Gm-Message-State: AFuF++mFuzvK7r0tL7rzAyFqIihZ40+GblxUN9xgCubtAtQdARwM2HH3
	D9mrmNnFixbdairgfZA8fE/lC07qU2NS7W4NzcJQV0DA3ImkOYojSEf4
X-Gm-Gg: AYBFou2rL0b2IBMjAszslP9xNHJ7Oit8DneUmLFUvgDDgTQvC3GAmm4SsNKGT0Yln6T
	5jOCu9cmbsAo3UNecnh3v0JxEJaNsFSOUxQdmCxLn9xLSs6afbl1QGuNNqIXTHO+vGzvdNgmuTu
	WFEnrxIJuYP81AvNd3NnAlIe0IvX7B1fOLEhAZL8sg0wpFTyZ4xO2oB45Ndr6oSMHxFCOkLColf
	iIBBMFVP3m+dMqPpy5SZnjZ4VU4Q9iBH27E/JMcnPgZsHtwYAy3SbiKFy0sl7nF8JqHSuwaxfy4
	Opjz3NExNzBXnlPhrIKR/02f/bg4qUscBfJK3X+kkVKurXYnPXdcSlSyDOJw1UVZ8B3KdGu7L/j
	TbzxvOB1oHwLetkgaNLJjrzCwHhGn75p5TQa9rH9w0J9KpHXBRgnvXesrNPg+2ze3bWaKXgLjIs
	RwO+cjffwEUksN2tGQ0fn1q1SjDI1znyt+EdpmHIczuB/vq661hzc3PA==
X-Received: by 2002:a17:90a:d648:b0:39d:cbb1:c96f with SMTP id 98e67ed59e1d1-39dec09a779mr13558544a91.18.1789473491565;
        Tue, 15 Sep 2026 04:58:11 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdacba6bsm4953697a91.14.2026.09.15.04.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:58:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Fei Shao <fshao@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Steve Cho <stevecho@chromium.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] media: mediatek: vcodec: destroy core workqueue on remove
Date: Tue, 15 Sep 2026 19:57:53 +0800
Message-ID: <20260915115753.2411047-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The decoder probe allocates core_workqueue for latency-based decoder
architectures. The probe failure paths destroy the workqueue, but the
normal remove path only destroys decode_workqueue.

As a result, removing a latency-based decoder leaves core_workqueue
allocated after the device lifetime has ended.

Destroy core_workqueue during remove for latency-based decoder
architectures, matching the cleanup performed by the probe failure
paths.

This issue was found by manual code inspection.

Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 .../media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
index e936ed8dffba..426d060d937c 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
@@ -570,6 +570,8 @@ static void mtk_vcodec_dec_remove(struct platform_device *pdev)
 	struct mtk_vcodec_dec_dev *dev = platform_get_drvdata(pdev);
 
 	destroy_workqueue(dev->decode_workqueue);
+	if (IS_VDEC_LAT_ARCH(dev->vdec_pdata->hw_arch))
+		destroy_workqueue(dev->core_workqueue);
 
 	if (media_devnode_is_registered(dev->mdev_dec.devnode)) {
 		media_device_unregister(&dev->mdev_dec);
-- 
2.43.0

