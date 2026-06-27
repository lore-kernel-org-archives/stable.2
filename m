Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1975809;
	Sat, 27 Jun 2026 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782531709; cv=none; b=Dg4M0nAn4Lt2OjiKqEpD4hHkjHBKG7hL1Zmg+j1Tldj8ie+ZEV6UFZZPSmgn2JHggEIHTRZKsIvA2YIibEwzALKCoRGU5PePr4gYv77o9JA2zxgmHtdAELwA6e7BDrb8nr7CDhGxCQuCuU3Ml9ArPrIXKJ6S7xHohqOPtWeh8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782531709; c=relaxed/simple;
	bh=M4//0bVBdjFvOB+c0rpyZ8FWd9hqVzJmF04tUj1AYd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ml0o0bc95jjRjRUzvR/wuLQPHFqU0PcTS+CC3wtrMN0QLyBdVceOrXQle+/31awPPBKNA3TOY9cUgUDRd+tObWeVbxH7pEKCHpZKg2pHiUY6X0bfR7ZL9dUigT7l6jxHFdLc5HDloTK5+8AnjsxbtoMVRFReGl3dloVvmcgZEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAA329N4Rj9qulaBAw--.43090S2;
	Sat, 27 Jun 2026 11:41:45 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drivers/usb/typec/altmodes: dp_altmode_probe: missing typec_altmode_put_plug on error path
Date: Sat, 27 Jun 2026 11:41:43 +0800
Message-Id: <20260627034143.59224-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA329N4Rj9qulaBAw--.43090S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43ZrykCr1Dury8XryrZwb_yoW8GF4DpF
	4UWrWDtFy7JFZ3t3W8Jr4j9FW8W3WkA3y5GrWSkw1Sqrn8Jw4jq3y8GrWq9ryxWFZ5Xayr
	Xw13KryYkrykAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjIJmU
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgLA2o-ErFryAAAsS

In dp_altmode_probe(), typec_altmode_get_plug() acquires a reference on
plug. When the data role check fails (TYPEC_HOST check), the function
returns -EPROTO without calling typec_altmode_put_plug(plug), leaking the
plug reference. Other error paths (ENODEV, ENOMEM) correctly release the
reference.

Add typec_altmode_put_plug(plug) before returning on the EPROTO error
path to fix the leak.

Cc: stable@vger.kernel.org
Fixes: 41294342fad7 ("usb: typec: altmodes/displayport: do not enter mode if port is the UFP")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/typec/altmodes/displayport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 263a89c5f324..06fe04e9e9b5 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -766,8 +766,10 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	struct dp_altmode *dp;
 
 	/* Port can only be DFP_U. */
-	if (typec_altmode_get_data_role(alt) != TYPEC_HOST)
+	if (typec_altmode_get_data_role(alt) != TYPEC_HOST) {
+		typec_altmode_put_plug(plug);
 		return -EPROTO;
+	}
 
 	/* Make sure we have compatible pin configurations */
 	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
-- 
2.39.5 (Apple Git-154)

