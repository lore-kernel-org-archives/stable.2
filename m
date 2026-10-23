Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747711;
	b=uoCp5CubRXyKVXJxm0A3QENfnL7OwGG8n91ZGVHu0gr2HoBECRVhMYtXZSUS30okoy3e
	 kg66KAlYbQ/K+Uq1pCqVd3dz9UwggT+U3hBwTN9D3GeQmqq20HJeYKq4sDbZ3/plSEe9q
	 iwIbFAZRAJvybTHAK/wk+aX9lcpt/al+FiinH5z+UUYs1hp6DQDjrwZ+9OYWxTbJ1RVkF
	 S5yvibFNBEIqWGvLjKAAJOt0iTkkqaUsG38tWA9s8TolctiHKL7tSWaqqFpATJbvZlbnC
	 1WVcsrSmOg81NDxpjDgpdM/rP+G75Fnz+ubKbOTQGev+RQZjqQcC32vUkcPnqBoUqRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747711;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=YSlxvtlvY3jBosLyqqHP6CS/eUyyDy6Y1qkCFTUHnls=;
	b=RVcH8cGwjxbRpmyBXIm1yIzQPIFS9MIzaSMouWiJEHMqiO6MeXSphAb05x5eA4dnecPY
	 /gKWSXy/CaROyLJW443aOVgN65i1Vh9sQHiXGYoHwPILGtux62W54JOQmmWv35Kwq36Ip
	 wZWXvfIRaHztP79+xyysRGElDMU+W4F6y7RnoRd4OwYzOmKEwFhOY5bD65hS7xNeG+6hj
	 6z8KBqqvoC0bAjg4hHTU7Cf1iNAmtvvtR2sFgCyGbNTyM3RAHlIfFMbTdwomOreMa0ktd
	 t8bHlZA0qKIRVmWDSVXNeTOJFbueestjryz5yZMkCuX1/KXY9COftOEH/MtBGJ1mZww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jUJSWn2i;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57140606A32D;
	Fri, 23 Oct 2026 09:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57140606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jUJSWn2i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YS
	lxvtlvY3jBosLyqqHP6CS/eUyyDy6Y1qkCFTUHnls=; b=jUJSWn2issZj5jCk26
	RTDOajxFtNiRpT0TDB/yut/ttLHICR4pE6katf6rScDznXqQ7//44pRyHZ95sYlE
	gGV8pKb83SGzzpINJUbk2m3ngA1hUpy8Q8c23/nUXDEheRA1q09n1kKikbcbBsBG
	qFzrQH3h9dELpMidjP+3o10k4=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3KHOkKNtqXHGqBQ--.1363S4;
	Fri, 23 Oct 2026 17:28:08 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v4 2/4] media: wave5: use m2m buffer completion helper
Date: Fri, 23 Oct 2026 17:28:01 +0800
Message-Id: <20261023092804.673980-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023092804.673980-1-yaojiale02@163.com>
References: <20261023092804.673980-1-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgD3KHOkKNtqXHGqBQ--.1363S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7JFyruF45ArWUJrWxCr45Wrg_yoW8Jr1xpr
	WYgrZ7AryUXr4qq3WkXw1xuF98Za95WFW8ua1xZa4xX398XF4UZrW2vay5tF4UJr1xtasF
	yr4UZrW3Cr42vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSnmiUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wjFAGrbKKjJjwAA3V

The decoder destination queue handles a runtime resume failure by
completing the queued buffer. The driver is a mem2mem driver, so use
v4l2_m2m_buf_done() to preserve mem2mem queue bookkeeping instead of
calling vb2_buffer_done() directly.

Fixes: 158b39a0f7d1 ("media: chips-media: wave5: Check decoder qbuf runtime resume")
Cc: stable@vger.kernel.org
Tested-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 0088501f93..928f6d93de 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1309,7 +1309,7 @@ static void wave5_vpu_dec_buf_queue_dst(struct vb2_buffer *vb)
 
 	ret = pm_runtime_resume_and_get(inst->dev->dev);
 	if (ret < 0) {
-		vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 		return;
 	}
 
-- 
2.34.1

