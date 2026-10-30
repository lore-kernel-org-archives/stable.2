Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379296;
	b=EXYtG7Z29oLE6vy/zspnDn3uQchHSvbQ5pJlCygHpFhMBil7B0DO3qRWDP3pLm6vQDTY
	 kHPdbjQOKN8LAXoBzVAuoRd8jBkkBIDLIOmobxUzf27ggXOxJ1fTrMQV32lQhVVWulG08
	 YEFyYrAEyFZCNzGjDHihTrMvpRuewkaviYfGICjaVhke0OKTQPITCu+C2HLVEdHPeNKqI
	 2KjXS6Lbp5ds+q9ACz5+56O7bC6aheHj7HNnAbi1ZctoWHDm/10F/AmPWl0qCDwAK3Pwc
	 7/UxX8AZk0wVKeIfavkhegnhbz8WH3t3FH1NZOc9N5M8o7sLRSWy5Z9dNAOVGadPLfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379296;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=nbV82IFwuuiTS8AA+/V+YE4I9u5uPPJ2Xt2fo3gijys=;
	b=MG+IxfJL+k2peUB60e1cc1iyptHZFeUvrd3W8Aavjz/nvpbOwAsvT9H+RWNQn4snQ+z3
	 jsD3Z9B6kURUO0hRE8LmsIEetg+IY+shFzkRbn1/qvcP6h1phZs0WKwRLPoziuuv6PByG
	 nKPHJgJfOj1HAVFb6xsu+sgjb36eWKg7BgQdLwyzPK966DVsDmzkxbEJ94sgCGj+SuYtj
	 1uW40r+9LicxUKlPSgXtIO2er4wI/ZMTiYG/E6tM00dQXECwqLwPWygE5SK6UjRvDMSiU
	 5xIzDqeZgoLIjRTSdKaogmPLrmGHysEB1/JCsIGgIni63wbE7XwJIczJ0EFMmYAKcFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=P254I4xT;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C1606A330;
	Fri, 30 Oct 2026 16:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C97C1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=P254I4xT
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52f74f122;
	Sat, 31 Oct 2026 00:54:43 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] media: siano: Fix potential use-after-free on graph failure
Date: Sat, 31 Oct 2026 00:54:39 +0800
Message-ID: <5c6211f11581350506d7324854af353a606388e9.1793377439.git.liguangshuo@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa18dbc326303a1kunm4d3d9b7e52a3b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZThoZVhlPHRpLS04dHxlMSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=P254I4xTcRHgKe2Z0ltHrQK86gkD+bV8QtC01b6ylVsdwGLLwFOufkRlVCIbqia8NlzERfrJ270vfAWXQXLjqITjDSXNP4xgEKyQmrkra24Rus9O1H48iYpnCnfOmzmJhLKlSoehtKguIF28XGN0O9LbOgCGW6mspLdKd1oyK60=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=nbV82IFwuuiTS8AA+/V+YE4I9u5uPPJ2Xt2fo3gijys=;
	h=date:mime-version:subject:message-id:from;

If dvb_create_media_graph() fails, the core client remains registered
with a context that is freed by the error path. Subsequent core device
teardown calls smsdvb_onremove() with this stale context.

Unregister the core client before freeing its context. Leave the media
device to the transport on hotplug failure, since the USB probe error
path also releases it.

This issue was found by our static analysis tool under development.

Fixes: 0d3ab8410dcb ("[media] dvb core: must check dvb_create_media_graph()")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the changed object with x86_64 allmodconfig.
No runtime or fault-injection testing was performed.

 drivers/media/common/siano/smsdvb-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/smsdvb-main.c b/drivers/media/common/siano/smsdvb-main.c
index 415c24fbbb65..664868627bf5 100644
--- a/drivers/media/common/siano/smsdvb-main.c
+++ b/drivers/media/common/siano/smsdvb-main.c
@@ -1217,6 +1217,7 @@ static int smsdvb_hotplug(struct smscore_device_t *coredev,
 	mutex_unlock(&g_smsdvb_clientslock);
 
 	smsdvb_debugfs_release(client);
+	smscore_unregister_client(client->smsclient);
 
 client_error:
 	dvb_unregister_frontend(&client->frontend);
@@ -1228,7 +1229,6 @@ static int smsdvb_hotplug(struct smscore_device_t *coredev,
 	dvb_dmx_release(&client->demux);
 
 dvbdmx_error:
-	smsdvb_media_device_unregister(client);
 	dvb_unregister_adapter(&client->adapter);
 
 adapter_error:
