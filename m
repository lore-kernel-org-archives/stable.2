Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202051;
	b=afspAglYQF5UZffqSM1+9dUhbIWrAWbYAX1CrH4ivLrklQz9Om0aELd8hs1mGKcy8c3C
	 lg7QqPEOVAD75DxYzwjVPRnjxleMxjLTv/NxaUbH0+5pyeB8h2E/hg99xiF+2oX0ZmpE6
	 WQ/R/2LeoW90025n0ABzNT7cOuKnu0zbl+wLAEv27mEtLwk8lSyWjc0eknnaghk4jluPw
	 8YWXhvg3RBq+dGorEBv81zFwO7IhQOvRYbBkxjAcSiuoma5BZ9TR4IcvA5yexJX7moXKl
	 i/L0p5WxdC3P4xCCxyA5G3wWfszhnPjf8UCMBQQ63Ju6vuJJWspqS5GyLhZUDs3xknA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=eAKYaySrSQHr6pJJw0QDlSkZ3hLgQhrVNe7eEGIicUs=;
	b=NqyrrReKyIA7dVbn/uwcrJ9mwXbwEPiP4pGaDXc6b5hyHMrc+bWvaGa+TX0kRjLUSW6H
	 wpYrKxPuc4RPbn82ofuJ1oeeFZVvMhh+4Y0UJ/oTlpt2r6C3FC1Okidn7ZwjE8P4KNorH
	 GkZxBfN28teqIUTnaSEtySR/MqadVwqLyw2DD75udZapAifxT8+UXlADEFSdjeVdE2f1y
	 dHsNy1ZCtJMmUwx7vAcclkrOPNEOc296Ak6RhRW/2ZQszGEN2XwrrFEHZobvs68i+Kt84
	 sM3bEw0o4dQkoNYLToGv1qHEwdiVBCB1+B/fH0t+PEqXk1QpAu3VWFoEfKhjuzUtAzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cnMgl2Cu;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863B60A263C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E863B60A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cnMgl2Cu
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-845788309b4so683454a34.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202046; x=1795806846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eAKYaySrSQHr6pJJw0QDlSkZ3hLgQhrVNe7eEGIicUs=;
        b=cnMgl2CuU+LJjonclnZ/k9to9GbpGYULFct/bYc5Bl5bKnK7C+PA71CLfOkHxpwS+V
         V2x5oRqU6XhvDyMurKvd3MmE/WJzduLTgR17QjdK39Y/o/LUniBHRWm5GjPuJm8Hw+y1
         k3+8EBrwsg6Fa2ScrItarXSLP8nmn0U/fnT60b+O9wgP9ty1FFOlATKQrRmR644mjSEZ
         JccUQ46RHOIfdpQoXi9cYyfPAstkzTCH4XGC2+Xabp7Ccg4qzOwR6r2T08cq3MY8jwQ9
         /Xpo0M2cMPNnv/uHKfrdvodSmVVqWIjmL7kzgEspXEsL2G5fTNozOOQjtBxFPqEVMawN
         yZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202046; x=1795806846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAKYaySrSQHr6pJJw0QDlSkZ3hLgQhrVNe7eEGIicUs=;
        b=dRlkTTdHsyuFfaFKB7a+yiA53Bt17aXy3aOGLzDAoSi74VDBK0Au6frDadGQO3otbJ
         ijIZM0aSwtUM9StwZGwuiaM+bfKf0Vco+KIGBQoxXm2edgAiUR7+83MKTQVBkVNLXEbj
         +OvVmRle482Y53DKAysMY9JC3hcLBK8RUbRt9QX2qp2l+j92QRpKsLc0oi6jAz/qXsHi
         Oju/nKTvNtT9XpEGE2UK2J0CY2tTsxvrDBxGc30n2EI68EyiMaN5zWcsI4YIx+CMqQJW
         A6LZID4hLdkdLVsr+UAKfOAq87L23L5Dp4AWway0IIEgk+yO0Kmf3kq07Py/BcNNgZNP
         +jNA==
X-Forwarded-Encrypted: i=1; AL+hErF5Leftk+QbxJvmb1l4e1I5RhJzkW3lGKDyC09QHu+8M8Htm6jN6Bx/wLI6c7zJ2LONJEGbkYU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Kbf4BaAc5IoicWvSQKI8HiyXgKuLiQ08sK13dptUH26e5vmDN
	MhWxrtypBuF6pOPv60OGBl7xsEQrE3nte4mOMemb6SSVb57lV5tnsdJx7ZEqtg==
X-Gm-Gg: AYBFou0DaBoYwaDyUF1pgO4RD7ikxRbJzFYnqRfqFkFGtmKVeqNoHNSwZl4sSju7Kot
	CfvqAfwCvAl7ijicuE315fZbylyEJ1zh1NmUiYcAPnuJDGqHEpvApopZgMFq0O+5FT/Ca+3y6Le
	h/YjrvRZ9RJu5GtN0+6alz3MtSnWFTvWWnh/hvvej09cbSU4ys3QZazGzv9tX2+3uIhm73HqYms
	n3COMd2gsWitOncADjSB1ocee+xhx0YAB/q8ngAeLUc2HV8E6ECCnkxwaH6aOWbP+WC8WzY0oqT
	1yVnvsoDae1Q7pE5R/GZzP7Ft/DL+SBz7v85mdfjNx5vueqAJOpPzaWL1XViYE1LrQ+8umr9obI
	rLBmoC6JbSZkOwCIVXFXuKniT2Km+BfvUNbNOrSWYAq7iFaVVon9SfAS0VHM/hRBZV2Pa+HNzIw
	GwzEcOgcpjZmU6oS/D5TDQYxO2Hjj5seSmZMFw/2ZIX3eWeEFZ3C4ZCJxX9h+MHpmYZmVVVUksV
	vQoTRc53KsJGAMz+iNzEzuGFAbqouo8vRkx6U0W9sOZZqGmEarEJimIotsOCtYUGa0m8AZI9u2B
	BBI8Qw9/fXM/oeJmbcHFFB8xSOa6Wur+9yVBm+zfxS1t7tZx9RaJjJGahsG5sHjW4rCEHH+km7k
	bl8ypUNtMoDi8HoQiCZSaXzfqv2JVqE9eJrGIoLnstDQZgx6NSDTqEufZLG9ACKOSnhXTaUtZBO
	sYA+8lOfhncCWJyWLY32acZO1sYADZd7XhZJlqHx0OYH8QgZDC2mdQ
X-Received: by 2002:a05:6830:681c:b0:81f:6e05:c1aa with SMTP id 46e09a7af769-863159c5575mr4569187a34.18.1795202045739;
        Fri, 20 Nov 2026 11:14:05 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm2654782a34.14.2026.11.20.11.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:14:05 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:13:56 -0700
Subject: [PATCH v9 6/9] dmaengine: dw-axi-dmac: retain descriptors until
 callbacks drain
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
Message-Id: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-6-48ab58961d6e@gmail.com>
References: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
In-Reply-To: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Wang YuWei <1973615295@qq.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

Termination frees every descriptor while a pending period callback can
still refer to one through vc->cyclic. An executing callback has already
cleared that pointer, but still receives a pointer to the descriptor's
tx_result and can use it after termination frees the descriptor.

An error interrupt can also move the cyclic descriptor to desc_completed
before termination. Looking only at the head of desc_issued therefore
does not cover every pending cyclic callback.

Use vchan_terminate_all() after stopping the channel to clear the pending
alias and move the collected descriptors to desc_terminated. The existing
synchronize callback drains the tasklet before reclaiming that list.
Descriptors already detached onto the tasklet's private completed list
remain owned by the tasklet. Repeated termination preserves the retired
list, including when called from a completion callback.

Descriptors that a client has prepared but not submitted remain available
for submission. Channel resource release still reclaims any left unused.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Reported-by: Wang YuWei <1973615295@qq.com>
Link: https://lore.kernel.org/r/tencent_C00D995A9F70206DFD1330DCB1222EEBCB07@qq.com/
Reported-by: Mitch Barnett <mitch@accuratesound.ca>
Link: https://lore.kernel.org/r/YT6PR01MB63707769A78186335441B06879D87F2@YT6PR01MB637077.CANPRD01.PROD.OUTLOOK.COM/
Cc: Wang YuWei <1973615295@qq.com>
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 99b648d4ca76..2547f9596ae6 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1202,7 +1202,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	int ret;
-	LIST_HEAD(head);
 
 	scoped_guard(spinlock_irqsave, &chan->vc.lock) {
 		bool enabled;
@@ -1219,7 +1218,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 		if (chan->direction == DMA_MEM_TO_DEV)
 			dw_axi_dma_set_byte_halfword(chan, false);
 
-		vchan_get_all_descriptors(&chan->vc, &head);
+		vchan_terminate_all(&chan->vc);
 
 		axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
 		chan->desc = NULL;
@@ -1234,8 +1233,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 		return ret;
 	}
 
-	vchan_dma_desc_free_list(&chan->vc, &head);
-
 	dev_vdbg(dmaengine_chan_dev(dchan), "terminated: %s\n", axi_chan_name(chan));
 
 	return 0;

-- 
2.53.0

