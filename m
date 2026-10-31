Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793455127;
	b=lfLjjF1UljO4b+Qs1KkGBCLT7Oqj+TPxZacj+KaUZ2LP/NdchEwZFeDjnUMyrtcCKVvC
	 +0Bs88fmdGsWck6bOWfOGhGFv0tj43bWzeIpcAEieMXsPsiEf6QYO8FOFy7RH+nfxgNFY
	 8SdmzC1aFffjvXGr+T1DvYGvmvSN6mmGgg3xIhLxNxnKjjuEhJySC4dlJ4FT1caeuju4l
	 kW+gzMuK851U63Rwa16YaqRHoKiqUIlpYY9RxerxYOpj9/Wl225MScSUDmuUW+6SLeaxY
	 jShXpgwxeVKfgUH1ot9jbWhs9Aydbn9/fUFWErvYy1CS8YxoGHTNf5PtDo0xUgq3hvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793455127;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=GjGyYPqN6ABzGQWTravT6MIzH9CljgHIVuIlMzWcs6Y=;
	b=0yPuVZgvjwdNdJRpup4MQPYzWQMat+zlalDohuiPn8YnYK/gfuzSXV7manXv043UC1cG
	 SAcYxYyJINa9OeXmToNTEkO4qWDPr9ZXzIfkSoMPdmeW3TKCMfMDy7y9x8dRN3FFqsaoX
	 AMF5WYOf4Nh88EtAUkJzNtbbrl/M6JWZ/+L1IANDeWNuU7ACrzdqXn7A2i60EpCtONuMx
	 mMGWSwIBLGmdmiIjx1LSic5CIppWs9cZmJ+kSgchLwXRuH8Y5wQ9kbn1VmZHIFjWeQfCF
	 qL646qihcc66sQgeCrtgndu7p5k9RzCkAkIvz0KasJ+qihlgdx5tsAsjhjbAgmhPhag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Dib4UUL2;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE66606A31A;
	Sat, 31 Oct 2026 13:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AE66606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Dib4UUL2
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5306b5bf6;
	Sat, 31 Oct 2026 21:58:39 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	Michael Krufky <mkrufky@linuxtv.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] media: cxusb: Fix URB leak on start_streaming failure
Date: Sat, 31 Oct 2026 21:58:39 +0800
Message-ID: <571c9fb8ed616125263768da034d54aec6ddb02c.1793455088.media-usb.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa192415e0603a1kunm670a63218615e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEMdVhhPTx5KTUoeTBkZS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=Dib4UUL2L7/BEZBGXKit7/mVe0/KcR4kU7LTCQQ/sZYU5YXFIWSU3Yg3FLclZTPzUiVJET/LtebH6oDBiLl2vEs1EKBfu3hLE5OTNOQV/bRk7zCzwPCLoRcuApOV7SDu8MYOLCNWef1LJ18q0G0lBiB2EjhdsH94nS25mlxjAWg=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=GjGyYPqN6ABzGQWTravT6MIzH9CljgHIVuIlMzWcs6Y=;
	h=date:mime-version:subject:message-id:from;

When the streaming buffer allocation fails during one of the first two
URB iterations, cxusb_medion_v_start_streaming() jumps to ret_freeab,
which only frees the auxiliary buffer.  The URBs already allocated and
stored in cxdev->streamurbs[] are leaked: the error label that calls
cxusb_medion_urbs_free() is skipped, and videobuf2 does not call
stop_streaming() after a failed start_streaming().

Jump to ret_freeu instead so the already allocated URBs are freed too
before the auxiliary buffer.

This issue was found by our static analysis tool under development.

Fixes: e478d40540544 ("media: cxusb: add analog mode support for Medion MD95700")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the changed objects with x86_64 allmodconfig.
No runtime or fault-injection testing was performed.

 drivers/media/usb/dvb-usb/cxusb-analog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/cxusb-analog.c b/drivers/media/usb/dvb-usb/cxusb-analog.c
index 8c7d0888c721..648f947e8cce 100644
--- a/drivers/media/usb/dvb-usb/cxusb-analog.c
+++ b/drivers/media/usb/dvb-usb/cxusb-analog.c
@@ -822,7 +822,7 @@ static int cxusb_medion_v_start_streaming(struct vb2_queue *q,
 		if (!streambuf) {
 			if (i < 2) {
 				ret = -ENOMEM;
-				goto ret_freeab;
+				goto ret_freeu;
 			}
 			break;
 		}
@@ -879,8 +879,6 @@ static int cxusb_medion_v_start_streaming(struct vb2_queue *q,
 
 ret_freeu:
 	cxusb_medion_urbs_free(cxdev);
-
-ret_freeab:
 	vfree(cxdev->auxbuf.buf);
 
 ret_unstream_md:
base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.43.0

