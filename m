Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379291;
	b=tNV/869iCeetLWINqeu+aTP0yA/ms8BIb9vRJX8YdqbbQltnzacW1/YTxwJx7ZxX9B5m
	 FJYWJnmshPiWs2UksREg/h5xaOv8vUCMax3OfMVtvHqJz8zt3EfgyLg67/Ug0CF2yxtyT
	 2rIFlHkoHxbF7SwENQcxGkrKqiMU4fT54ysMgZ0dKov859y2TR41PDXrVXs13ULZ9QFEZ
	 qOyUNe5D0ri1UOWob1tgQPg40lk1lzLhVIqKolibh9uN/a2PAGz2hmMj4YsR565lHvv5B
	 FYsjswPNk++a7SoqOR1CuXv3iN/RfQWpyYQq9I4Qo8xRJKlcghn4YJHno0WMWIRO35w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379291;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=sNS8f62SH5XlgiEWmyfBwWEu8A0gn1w5KnI+FJHKxvg=;
	b=jOmWX8R2rhOcUBmbpBVWE0xfoXzgP8stU8mX1Fq9ctc4EHMWfJRnfAq2CWipSoDKwdXR
	 YMc/jhMns7SIO+mBT5cXLwBr655BDhLyj2H9GCMZ1vDJUAMp9fpVKfHRXzTUrZvOlw/4M
	 c0GJtTOkVZNxwv3OttinzFqgz8zGFLMjvlJK7P1GIFl9HI8KLVWnFS7AiN9qlJK+TSCnh
	 lLKPLbk2QjZ2r21eyVqnVmHzZUYiiqy+VLI8OxPaflLj5OhxDsS7XCGCHzNY46rDSMylq
	 ElGjNSP7tOjciguJHt46SMS8mGlEHutiUehr7VC8iu/UTWO8Zfo7hmLpcEXhIgTpNng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=IxYPJ3IH;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8F606A31D;
	Fri, 30 Oct 2026 16:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D8F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=IxYPJ3IH
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52f74f124;
	Sat, 31 Oct 2026 00:54:45 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	Andy Walls <awalls@md.metrocast.net>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] media: ivtv: Fix potential double free on ALSA initialization failure
Date: Sat, 31 Oct 2026 00:54:41 +0800
Message-ID: <f2bbe5e1ba4d30d5255133897f970bae984e87c5.1793377439.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793377439.media.git.liguangshuo@mail.sdu.edu.cn>
References: <cover.1793377439.media.git.liguangshuo@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa18dbc3a9c03a1kunm4d3d9b7e52a3e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTENOVk0YSkwZHhpPH05CTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=IxYPJ3IHl9ZZBeg3qu6xhBI2pEyML9HwsEAeI68EmxPuTNbsoL8RCKDrji443vBq2iDnTBPJapPlNILotvjBGBtEq7wuW98/DJKn4VEPRswLGmQNUllv++Df0HekbDzXf+LolMFrMMjihICgu+WfBkOQKfqUKJbFYtOLoiph4Hs=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=sNS8f62SH5XlgiEWmyfBwWEu8A0gn1w5KnI+FJHKxvg=;
	h=date:mime-version:subject:message-id:from;

After snd_ivtv_card_create() succeeds, the card's private_free callback
owns itvsc. snd_card_free() already invokes that callback on subsequent
initialization failures, so the explicit kfree() frees itvsc twice.

Remove the redundant free.

This issue was found by our static analysis tool under development.

Fixes: 269c11fbac4f ("[media] ivtv, ivtv-alsa: Add initial ivtv-alsa interface driver for ivtv")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the changed object with x86_64 allmodconfig.
No runtime or fault-injection testing was performed.

 drivers/media/pci/ivtv/ivtv-alsa-main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/pci/ivtv/ivtv-alsa-main.c b/drivers/media/pci/ivtv/ivtv-alsa-main.c
index 59573debd19e..e06f194c0765 100644
--- a/drivers/media/pci/ivtv/ivtv-alsa-main.c
+++ b/drivers/media/pci/ivtv/ivtv-alsa-main.c
@@ -173,7 +173,6 @@ static int snd_ivtv_init(struct v4l2_device *v4l2_dev)
 err_exit_free:
 	if (sc != NULL)
 		snd_card_free(sc);
-	kfree(itvsc);
 err_exit:
 	return ret;
 }
