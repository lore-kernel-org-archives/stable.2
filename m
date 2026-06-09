Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C59265CBE;
	Tue,  9 Jun 2026 04:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977831; cv=none; b=kcdJK/fGCiwikzv0GNLOCfWPLgCr2eJYqeh41QVxaLdIYEcSZBvE7zrTJzPguqUb/Z8hAEqJ7KMKzIncZnsvg0OHyKZH478VJmjf1e0PGSAoN9DmyEhtpKCCN23JzTFHXya9seGlSokg71C8n33ncY1mo9BNa0uumJ+2virQ+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977831; c=relaxed/simple;
	bh=QE/gTtocO5p3/oxMZ5sqafT99WDMTLDcWsOb5PvjkQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFzf69yrDEZQn3Q2X3WJ8rtKANXb4JPDHX4A34ZA7yvfqCfwrT9W5hU4RoP2Zh9MG7IQ+jgdgSk06UHG62+VlbIPFUUbrX1nve9xofzg25TllUlIUUw41LlzcH6sVXT/YQuUweiX2v1NtVdoPLPf6jbBWfAP6XLZO9hX+0ON2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACnTNWikCdqd672AA--.11950S2;
	Tue, 09 Jun 2026 12:03:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mchehab@kernel.org
Cc: kees@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: dvb-usb: fix refcount leak in dvb_usb_adapter_frontend_init()
Date: Tue,  9 Jun 2026 04:03:37 +0000
Message-Id: <20260609040337.192589-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnTNWikCdqd672AA--.11950S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrJr1kKr18AF48trW5Wrg_yoW8GFW3pa
	n5KrWjkrWUt3Z7X3yUAwn8GFZ5Ga18KryrKa17CwsxuF48G342krWrKa47tF4kGw4xJa4q
	qwsrXry7Kr1UCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRR_-Bt
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4NA2onY0fBWQAAs4

After all frontends are registered via dvb_register_frontend(),
if dvb_create_media_graph() or dvb_usb_media_device_register()
fails, the function returns directly without calling
dvb_unregister_frontend() and dvb_frontend_detach() for each
frontend. This leaves them with a leaked reference count.

The caller's error path calls dvb_usb_adapter_dvb_exit() which
does not handle frontend cleanup. Add the missing cleanup by
calling dvb_usb_adapter_frontend_exit() on the error path.

Fixes: 9f80679511b0 ("[media] usb: check media device errors")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
index 029dad86a059..923f25ccb1e8 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
@@ -326,10 +326,16 @@ int dvb_usb_adapter_frontend_init(struct dvb_usb_adapter *adap)
 
 	ret = dvb_create_media_graph(&adap->dvb_adap, true);
 	if (ret)
-		return ret;
+		goto err_fe_cleanup;
 
 	ret = dvb_usb_media_device_register(adap);
+	if (ret)
+		goto err_fe_cleanup;
+
+	return ret;
 
+err_fe_cleanup:
+	dvb_usb_adapter_frontend_exit(adap);
 	return ret;
 }
 
-- 
2.34.1

