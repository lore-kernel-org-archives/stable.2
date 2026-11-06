Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977228;
	b=J/iCVw9LjOyhKh330PKs5lIIs66KwakaINUtQe/dufIjcJRYZmRb+noMkyH/3ogoZngR
	 CBG/aZqZ+HKPccSmRvzz6ZEFWVchUGpiAIEc3jusWpWtIjFm7u1cXTnmjd3wjsXDxw8ot
	 eFLE65AIw5ulabFin1QEAm6JiZz6VnL7Ctl5nesyCrL4hsN7m1Ep1CNvNII0AeRNHLiyM
	 QU2bWHJOgEFqTZO0ouEinp6ghHvmpaBf5SWUOtoNSYKADVaS7OYAX/2ZkwI+wtG088eXQ
	 ykVacYp+iwBPhMeF9BbgXLZU+E+fOHJ4y38jwIOs70cVgoS1Y5Ti2tu7DpM6AtkTZ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977228;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=lEwWZMnT2E5q2mu75iPMVwDrV0VDr43djSV3nOSktwA=;
	b=MeTokMWFkhVPDQTiqcC/RTuWLixG2eaxrAOLjOBclLCn8JEs9tM2K5HY1eKXph+M1zM0
	 KUt22olE32Vm906moPmFJA4mHl4gtXhj+VSoqHuTqeMeiWS5KbeoxLdm5h6Y2BhZG0YT5
	 I6LeAZUasEaMFaxF2EdgCe1Bjj7B6nkcKXM1gUEk7Rzyg+Qj11ty5oh0fNj3ghiBfcMuc
	 XrxXA9Ki9+uHlXMiLfHRn9DjHS03vIwiiMGBmSUFpzxY9cLsEhjfvu4iLmqvS5G7g7yQ+
	 NAq0dOyIzHgjN8ddzxPcV5fpVB4cIxdBcnMo7bcpYrL/fT5dpExADz7sf3RzLFtWd4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1B606A329;
	Fri,  6 Nov 2026 15:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E1B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLj620pGhz8Xrr9;
	Fri, 06 Nov 2026 23:00:26 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A6F0GWE055283;
	Fri, 6 Nov 2026 23:00:17 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 23:00:20 +0800 (CST)
X-Zmail-TransId: 2afa6aedeb84f92-76f49
X-Mailer: Zmail v1.0
Message-ID: <20261106230020595sdtR1cTOchAJ3lWjuD06g@zte.com.cn>
In-Reply-To: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn>
References: 20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn
Date: Fri, 6 Nov 2026 23:00:20 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvMl0gbnZtZXQ6IHpuczogcmV0dXJuIHRoZSBuYW1lc3BhY2UgbG9va3VwIGVycm9yIGZvciBJZGVudGlmeQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6F0GWE055283
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 06 Nov 2026 23:00:26 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDEB8A.000/4jLj620pGhz8Xrr9

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_execute_identify_ns_zns() jumps to done when nvmet_req_find_ns()
fails, and that label overwrites status with a successful copy of the
zeroed identify data.  An Identify with CNS 05h and CSI 02h for a
missing NSID therefore completes with SUCCESS and zeroed data instead
of Invalid Namespace.

Return the lookup error instead.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
and CONFIG_BLK_DEV_ZONED.

An Identify with CNS 05h and CSI 02h for a namespace that does not
exist (NSID 100) completes successfully and returns a zeroed structure:

  unpatched                            patched
  ret=0, all 4096 bytes zero           ret=24587 (Invalid Namespace)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 92f5c1435582..cea05b4bc740 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -108,7 +108,7 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 
 	status = nvmet_req_find_ns(req);
 	if (status)
-		goto done;
+		goto out;
 
 	if (nvmet_ns_revalidate(req->ns)) {
 		mutex_lock(&req->ns->subsys->lock);
@@ -140,7 +140,6 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 		mar--;
 	id_zns->mar = cpu_to_le32(mar);
 
-done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
 out:
 	kfree(id_zns);
