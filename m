Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200438;
	b=BEWQUnmZuPLBzs5VQ7m2V9m0eiyhR7YCfVFwovnvJxu+qGMOJJuWIFlxoEOy/V3AlSo/
	 0toIJBshA0n2lncoDkarfSNENHKNfl7j8Lky0sumr9JQfZ48ITKpe4ybLxx+/ICqXnDX1
	 DEjxOYaohPBKaXPTxPE7DffXDcRbMA8FUar8Go0FeNwfpMqJ0o7XZidWfriP0gDgi+D4M
	 zHWiz6WNsNTTe6/IUop9wFqYzq6tRGre3x9dHzBh/xsz4Ayc4VOBV/02WvOlxMWw7mCGp
	 d0zCJro5U5hf1bhY+5o491tS+N2cIP+92ANwuSJGj0Sc8xCbwGqeebk+JQIkSvACl8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=oESDww53zGSoGH4IO1bUrrqGEhAQT6H46eRyViPIMYQ=;
	b=t/m7MAzWqSZPuHMQ8TkYWtpyEVPokJW3L/uJPL5560lQ3A06+10DmHWMQNxj+1L6H6hB
	 ep41ji3L4+SJ69T6SKUoI/bC11y0HrEGxKRbUKFMZbRPWBPAJWW9eOt1zK5lKehR1YDjA
	 d+Tm834Ci8LDLJ/OYseOg0PYpuqTTiYYDh666c0GtJWQ4/RkpDZzYcuBGAlebTbj4/v91
	 QgqX/IQeHz2s8H+2LQm5NITvPLrg6YUdYRFRITedgbGwuhyppJg8AAwGUKY+o2+QN76X5
	 cbzsVpWCMezzfaKCzv3e8vA5gJC02l2TANIu+KjZxE/uweYEMiQK3jeznwv0X7v2yJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UwNoimSt;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CDB606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 05:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7CDB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UwNoimSt
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-825b40f8a26so185972a34.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 21:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794200436; x=1794805236; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oESDww53zGSoGH4IO1bUrrqGEhAQT6H46eRyViPIMYQ=;
        b=UwNoimStSSPQTdJ+XmanVE386Z3IgzT3eWxbLpFXXMkNjf/noTv8mxVn7eyG3MYHAz
         bNTT0kEnP6BvRx4sao4ayQdh7/I/3dMVoLK33SNaPiF5n049eeiw+jDEmWU/C/ixw0zf
         bN/1GckfHsze3jyUtV+I/NrY0qcwBqZ+xGorxjWeJfIMXS+mgJVJNPXjlo810Y8Ipaas
         FLalFKze3VMLEMvltQ91D2thIlkLoMhIG/+rUYOTpQL8/j2vE3BiupnSa0aNn+e8eEcL
         qv/1lpNVoICG5mAElMpPmO/eMKVyRzYLuZ5zXxUaKSbJIxrVO/MQhiiS/MaTAY/vD/s1
         S91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794200436; x=1794805236;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oESDww53zGSoGH4IO1bUrrqGEhAQT6H46eRyViPIMYQ=;
        b=vMGloiX40zzuHwEiZx7XLzQhfh4BeG0M5n3OWTflMAEd4WgwnIpq/SRLuAx/cM6JHg
         CDgiO+ytSGgmbMcyaeJ65KGWcAO44snXmNEZiU7q7sWia3WeabrMxLSIx9qrXT3i4vb9
         wlzyfuO5SjE0T4BUfNnTMPb6MOua5dPaUDVnKycOAGTHLt4M+bKuIBsNAISiAsidPkpz
         /fNdXDkn8AVyKnaFf00OTwWJySkKZ0elZV65Y3M2y+rRTxNtQFc87ZExdd9yZb7B4oFL
         y1NQ4Gw25Fw5omATQ6tNEf4blqNPfkEOgZQUafO7oWuE5KepIerXkMj7dhuz/c4ydbcG
         nMmA==
X-Forwarded-Encrypted: i=1; AL+hErG4aw+E1ESlftB4cF+8dGUmZzJIKR61yutfWTUFKFYLRyPIX+Xb7huw+xhTQzRtDd/SEW9kJmA=@vger.kernel.org
X-Gm-Message-State: APuU4Z90gQ/kzDHwomJ5iVuOX8i3PxoiYRrcd/w47/y+nfFGDZIIOydU
	F4IwD0HDFowGn7eJIF6WgajSgbJEuaOH1lZbCRC9Vq4L+JGztYU3ce1f
X-Gm-Gg: AYBFou0NV7xB4sXKKJ43I4sXzr8iWLqNa9kD69IbngQuyYpa4LZrnWSPHQhbmtnSVx8
	yEY4NNRV8RHSAETLTg9BK7ZJyWiuO4T5484yex/Y2n40JKrz01pbbUo3AAFol/Frd/N03ZeSHf2
	PHnaSqnVBzKyJ8dnbH9TMhkNlgfk8m3ZM+QZF41/FRgYo7kO7NBnoScIm8W/3MueH6OkIa3O0fB
	ZB0IL+lIlm56lefePOwPxzii9aMmRZS5JFUnfUdcELKex31Pz/Dz5dZH/e7yczlpUFFjMHfJRys
	sO30HaYRP3GKdLbI2IbJZt3JJSysyIlAwY6qrKAg/hiDZEoSHtf0S3Lxy3gEDLErtEgA60LhswS
	6803ifAHkML7aiRIAccbVX5qwvN4CIUpWSG7icLwmvSB1ZFOs9fjzCe26ZlEP0P2L7fBFsjI3hD
	3qLVteIRqMLfYou15QjK6PbM/7of3vVQTG3sHZTHZyY911T6GHmeHQzmvqFudfWjwQ1ukZJm60D
	Kv1eDR2D2kG8F5fHekwnTq2baKQTHaX44jHLHbuUALTgSvh9X4ITYZU7yoVFaaM1j/BO26oVVih
	nMjt1p/P8brVD/U/9rkV412nGzZsG3dp9NBhmY6u//SPwwSB/bWqd6870EP6ZwkIdAhj7DChPcp
	kmpXzn5gawul2wxxOXa8jxgiWhgXgHzspAsyryeECDiG/wiAJqNitlhwGP1JWCGa9x091QWkKjE
	kUcjQDn//p8kxHh2rYyFgexPbma8IIfdutMRKsZIJQYaG2UAnrmUE=
X-Received: by 2002:a05:6830:b13:b0:81c:dbd7:65dc with SMTP id 46e09a7af769-85f50783fccmr2360049a34.7.1794200436306;
        Sun, 08 Nov 2026 21:00:36 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fb2be33sm2953090a34.13.2026.11.08.21.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:00:35 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 22:00:32 -0700
Subject: [PATCH] dmaengine: tegra: only advertise supported pause
 operations
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
Message-Id: <20261108-submit-tegra186-dma-pause-caps-v1-v1-1-9cc9b17a033d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQ7CIBBEf6Xh7EZAJY2/YjwssNI1KRKgjUnTf
 xfs8U1m3myiUGYq4j5sItPKhT+xgToNwk0YAwH7xkJLbZSSI5TFzlyhUsioRgN+Rki4FAKHqcC
 qwJirVxct/U1q0Twp04u//4/H8+AmeZOrXdwbFtvcZoxu6lFTUgwc6Xzs9v0Hy5/Ip6cAAAA=
X-Change-ID: 20261108-submit-tegra186-dma-pause-caps-v1-664d1320d502
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Pavan Kunapuli <pkunapuli@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: Rajesh Gumasta <rgumasta@nvidia.com>, 
 Thierry Reding <treding@nvidia.com>, Akhil R <akhilrajeev@nvidia.com>, 
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Tegra186 does not support pausing a channel, but the driver installs
device_pause and device_resume for every variant. Both callbacks return
-ENOSYS on Tegra186.

dma_get_slave_caps() derives cmd_pause and cmd_resume from the presence
of these callbacks. Clients such as generic 8250 therefore accept RX DMA
channels that cannot satisfy their pause requirement. A receive timeout
then reaches an unsupported pause operation instead of being excluded
when the channel capabilities are checked.

Only install the pause and resume callbacks when the matched chip data
advertises hardware support. Keep them available on Tegra194 and later.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/tegra186-gpc-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index e76c58f213d8..72266f490e8a 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1518,8 +1518,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
 	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
 	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
-	tdma->dma_dev.device_pause = tegra_dma_device_pause;
-	tdma->dma_dev.device_resume = tegra_dma_device_resume;
+	if (cdata->hw_support_pause) {
+		tdma->dma_dev.device_pause = tegra_dma_device_pause;
+		tdma->dma_dev.device_resume = tegra_dma_device_resume;
+	}
 	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-submit-tegra186-dma-pause-caps-v1-664d1320d502

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

