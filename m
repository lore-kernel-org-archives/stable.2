Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582517;
	b=cmc2uuA9a23CqaB0MQjIMokIjzueHoH1RBPNENn40mROrtQeTWUKH16bWqKmnhm+qoHp
	 uffK8di097UR1TRILNx91DYJeU/PhHePLt2b8ObJvbM5BCGWxjM2qwVYscc71JB1QwibM
	 vphQ4utWcHkj+NzE/yXnuLpXuMzuapL+KIzF+jxCGn7KFk19318mx8VCYJY+zIKbQ63JB
	 uUT7kAhhwYsadA5+kGhWUVpjVmVXBk/frusWkv8ZAoBZn0arSvoFml7d2tdNO2yohUdPi
	 2r9t5BmWUnTnfoAfvLu5AkmzS9PXvnXVO00ZiYjS8eiILl9KrAKSdPHXy6G/OumTMvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582517;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mGrf7JaZq0O646GLAmSYUiskE8wdIOIlTShy4qrY0vM=;
	b=c07WvhHkmgciPsLJXC6CSCpU8zWb7vCTCPgWbmWmjdnFsKiP9Pcoq+RoSMeWVHX7jBC8
	 7F76ZVlopY8w3MBu/fjYvE59Z6NA3G9ij8+0HYa4ea1ehVqhKE8KOQNZsQsBRTvOvAqN1
	 r58v0GR6fteAeEwf3gJXAldB++rJFtnX2lpHzvrKM5HpDaJ0CSY37ga6W3V/bZmvItLHp
	 qkFojbR81DU4KRIRHd1ZYrI2LNiYQiZrC+4hUQxBPYXGL8eXdS9eJl8H0a1rcl0TW1EEW
	 /FcG8o08a0zumdfqYxZ8CXCc4kdFQHjkxnzGgbSc93o6pCc9QGCwRpgBA2R14MZbC/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=VjjXHV99;
	arc=none smtp.remote-ip=79.135.106.113
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6E0606A8BC
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F6E0606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=VjjXHV99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794582513; x=1794841713;
	bh=mGrf7JaZq0O646GLAmSYUiskE8wdIOIlTShy4qrY0vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VjjXHV99mmbhtDEufZikm/ZoocZH2bHKzB79O7HL50lCrWV08l4ZdvUKK9LlfKvlq
	 WBB9Fmp8jeZFKOUuVNCwNqkLgV8ER/N8zkKwfUZilAZJVQn21Oo5G7D3UlIFL3V+rU
	 UVbj9q4xyw7HCXaP/7BcttQjG0dxrQMLuy0iA41CfpIfhLFQ9dnAXxe3ZB0+xlSKNi
	 A0B9fFKkbFxwDupVTk2iK1XZg00lGJy/FsEp70Qf9mPccdrNe5UnO6Pv6czkvKxi55
	 PAMYo7rf+mI1xY/nUyonFJdlcea2mLBzSnCddY2rqQsBJS3ZAzgCHr/LMHQXXYf1Rb
	 wmtmR3IAPl4XA==
X-Pm-Submission-Id: 4jR0y74PzRz1DF5P
From: Michael McAllister <me@michaelmcallister.org>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/msm/dsi: clear the DMA buffer pointer after freeing it
Date: Fri, 13 Nov 2026 15:08:02 +0000
Message-ID: <179458248277.51880.11276326781897812340.msm-dsi-double-free@michaelmcallister.org>
In-Reply-To: <6m4cssgagnpvm2wawyj62veoqbglxv62rcqgxzaxvjynhn3dts@tlkaxvd6ph3n>
References: <179422752570.88190.13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org>
 <6m4cssgagnpvm2wawyj62veoqbglxv62rcqgxzaxvjynhn3dts@tlkaxvd6ph3n>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

The DSI host survives component unbind. On DSI v2, freeing the command
buffer leaves tx_buf pointing at freed memory. If a later bind fails
before allocating a new buffer, another unbind can free it again.

Clear tx_buf after freeing it, as we already do for tx_gem_obj.

Fixes: 5e05be782645 ("drm/msm/dsi: free TX buffer in unbind")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/bug/linux-6f5085d3-ef49-482c-86e4-a2438bc1b91f
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Hi Dmitry, thanks for flagging. I've addressed the double-free in a separate patch.

Thanks,
Michael

 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 64fc54dff4..3feb260a31 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1301,9 +1301,11 @@ void msm_dsi_tx_buf_free(struct mipi_dsi_host *host)
 		msm_host->vm = NULL;
 	}
 
-	if (msm_host->tx_buf)
+	if (msm_host->tx_buf) {
 		dma_free_coherent(dev->dev, msm_host->tx_size, msm_host->tx_buf,
 			msm_host->tx_buf_paddr);
+		msm_host->tx_buf = NULL;
+	}
 }
 
 void *dsi_tx_buf_get_6g(struct msm_dsi_host *msm_host)
-- 
2.39.5

