Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530130;
	b=RILpYS1EO/d8Brl8zHdI8ZUjnmMC3g1PR9vFtvkii6SEQ0fWG+hM3RG1xDFXRO9iZumx
	 CFBLQizksgHAEhIWgnsCZed7ccpl7Pfjvfz0HmzXFRxVoTkhThiu4YZbY6VQaqH4jy6Lw
	 nko6TtBMSCoswrWw0h1VWYGV1Othp41vNQJ/T+XMr2m5DkrdrJ8gUZzmSI97M+T32yxBM
	 CjfhHvvquWgIht5sQg0rnM+dZ3tor56mOJoUqKDowd+WQD+KHEVgXkv2xwqcQmrE/XnEz
	 OTcGMOpeLjUyTcbffMWXHkr8V3BWyVWLUbRNK4gJoOSMo6bKXnt9VjTyv3H0hJqiugQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530130;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=3r2WpcDHZ5qf/KBCGMkDz8OWWqIYq7ELW/X3xXJN5XI=;
	b=13lTqFlF2ODePVOLly8COUtjOOUlWK1/BcFY93JURMhVOhXPXuyW9cXsw5VhCNa2a9Sd
	 zSpF8OgYKD/LPQHYbaSSXgH3ej6dnNEMuDASWbKUZkmpYaZxzVfjp15CNI/b/izYPZvIk
	 3K12SecOFJOV1843T+fbeGLAjnREPFIa12Ra9zS9zEnZPhYTjI/UhfWOWa6W5xcxFHZ1h
	 rc783ZWp7iyUiaUoJuA49TEfQsDkTI7RhW9B9dxSSVfEyi5lZ9sFlkEBO/XAnQfpvdwCJ
	 H8hi6BHz42I+jijAYbm/jb3PQZXKU7J8zmwlXH2hYRazKCo6KcZQmTTc3QQr3R7R7bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=v42+GDWj;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA1606A31E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CECA1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=v42+GDWj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F0091A128B;
	Tue, 20 Oct 2026 21:02:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0726560393;
	Tue, 20 Oct 2026 21:02:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42DB710328934;
	Tue, 20 Oct 2026 23:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792530127; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=3r2WpcDHZ5qf/KBCGMkDz8OWWqIYq7ELW/X3xXJN5XI=;
	b=v42+GDWjgdl/NvEKQAVqyWn4BG7FP2TVEnNs3Aa6sFCr0xyE2OI5G9giySUAsRTFuVMY7O
	qJe7jXYzVRRIhDuP/RSp5oE1zwkMWHMl6pOz6C/An/AxWq+PNBypPz3SPT4Zcu2SpgRrTG
	fl7ZO18C9n27AKwxUnFCuZNPFn+9FLHzBd7l/axN+Fm45QgyN5yO3Zml1BgyjQry0ys/C4
	XlBKor0eTfoNazP6G8QY1HXFqnen0sho7AamMTlnfvDqGayX0QWacAX6S6V5QBJaM6f5fF
	v8HMiwtTm/vS1X2LBREzZeKP+M6s/HuEm7r0CqMMueH8FX5T+tLxlk/vh8ywUQ==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 23:01:54 +0200
Subject: [PATCH 6.1.y] OPP: Fix race between OPP addition and lookup
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
Message-Id: <20261020-cve-2026-74405-6-1-v1-1-3ac1824de8a9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CMAxE0atUXuPKDk2qchXEApIBzKKgBCpQ1
 buTwvKNNH+mgmwotGtmypis2H2s0E1D8XocL2BL1eTEBRUnHCfwCu67TjwHVvaiQz/4BKQt1eM
 j42zvX3RPodX2Q4f/XF6nG+JzDdKyfAG6mIfHfQAAAA==
X-Change-ID: 20261020-cve-2026-74405-6-1-5019795deed3
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Di Shen <di.shen@unisoc.com>, Ling Xu <ling_ling.xu@unisoc.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792530121; l=2503;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=myRqw8lglUXL6oCaOY9I1FNOOs/MgQu6e1Ul4CGbyfg=;
 b=oQgEuJkhfuF7qqqPeDjZWbYpegQROsAWrdASpqC34WdUigMp1LHJYkScwQICD/9IOUchX5gbV
 Oj2z5vrxXW5BM+CmV/sIieArCZBcL+9wQMhQeA1cmxnuzJP2sHiDYSJ
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Di Shen <di.shen@unisoc.com>

[ Upstream commit f5e1cc9a284bff2510981643a5bca4bc4c21b81a ]

A race exists between dev_pm_opp_add_dynamic() and
dev_pm_opp_find_freq_exact():

  CPU0 (add)                          CPU1 (lookup)
  -------------------------------     ------------------------------
  _opp_add()
    mutex_lock()
    list_add(&new_opp->node, head)
    mutex_unlock()                    _opp_table_find_key()
                                        mutex_lock()
                                        dev_pm_opp_get(opp)
                                          kref_get()
                                        mutex_unlock()
    kref_init(&new_opp->kref)
                                      dev_pm_opp_put()
                                        kref_put_mutex()

The newly added OPP is inserted into the list before its kref is
initialized. A concurrent lookup can find this OPP and increment its
reference count while it is still uninitialized, leading to refcount
corruption and a potential premature free.

Fix this by initializing ->kref and ->opp_table before making the OPP
visible via list_add(). This ensures any concurrent lookup observes a
fully initialized object.

Fixes: 7034764a1e4a (PM / OPP: Add 'struct kref' to struct dev_pm_opp)
Co-developed-by: Ling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Ling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Di Shen <di.shen@unisoc.com>
[ Viresh: Updated commit log ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 drivers/opp/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4211cfb27350..0ba25aba48ab 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1993,12 +1993,12 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		return ret;
 	}
 
-	list_add(&new_opp->node, head);
-	mutex_unlock(&opp_table->lock);
-
 	new_opp->opp_table = opp_table;
 	kref_init(&new_opp->kref);
 
+	list_add(&new_opp->node, head);
+	mutex_unlock(&opp_table->lock);
+
 	opp_debug_create_one(new_opp, opp_table);
 
 	if (!_opp_supported_by_regulators(new_opp, opp_table)) {

---
base-commit: 79807e970724c1f90cee1316361d61b80db4eef6
change-id: 20261020-cve-2026-74405-6-1-5019795deed3

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

