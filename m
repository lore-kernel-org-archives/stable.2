Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529931;
	b=iOW6Z847OUDEsuxthVzGuTS8JLYIl23u+qITi1nMv8UwqDVXMsgk6XHxzdpdy53OFroG
	 qysEMDJAL8Vp8+1lnkENAKWWl47ga5zmgDy6bPadwH/VMd6CSFYXwo9Uzx0CPddCLepqh
	 qaF+5UuJrUvvD2wnRJ6blH0vc/cf7+seyWJW3JtaqFPb+AT/gFrWT5Uj/Dd5tIP6RzLtr
	 GZp2F5Mm7RuTRjqPIfetKXyZtOaUsNe3X5RAM3Xk/oUVoLnUniPlN7DTql45hmgWSg7pp
	 HV0dtlBL/jU6tWphz8wgKR2dgazCmBLc4Id8d4YPSuMlqLxsSQYsHgNFu+Lwq5a1P6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529931;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=n6+LD5+9ecDiImAETNE5dMrb08V37h1x7jrMagywSCo=;
	b=w8kSn7bDXzVkQu8xBaketUL6El4T4bqbR8TsTcfSOMFIXvc9x1bRI4lN4QIfB8ZJVbHi
	 o1l4wS5gyID2Z3k4Vd9+Z6Gn6eJgXGSIHRkWmvEjjyPixqazuIJEwMN1/AXvmYmR0Gahm
	 0Rud5+O0RTXaoO9ICYFzAFUS/9NqVR5mQcFtG1UDfzXV8d76VKPO0GtH4EfqIEX06kl3R
	 lq6DwPikpWSIDhZcqVPNTqPMhW9MAkUmKuSejor4ou2c3rehw6Ygk+FpjVAoohFPNnyCJ
	 yBOvXbRHc2y4LkDZRZPP7osvSqlBLeWnd7dmWn1f9hz8Z+fBF3Ak7t9PHxRaYg/Wz8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ihNQoWiQ;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A281606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A281606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ihNQoWiQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 892031A128B;
	Tue, 20 Oct 2026 20:58:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48A2860393;
	Tue, 20 Oct 2026 20:58:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8054610328D20;
	Tue, 20 Oct 2026 22:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792529926; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=n6+LD5+9ecDiImAETNE5dMrb08V37h1x7jrMagywSCo=;
	b=ihNQoWiQCps8nFikc+tVtu2TCDzXa4wVMnjgDyRmRft+mRvOxP+fouSFVc117JCACidK1H
	+R6ZCFUQedPsBpxqKC0XvrZ81Fm8jKqNS11Pjq9LD9z1imwwlIiqDSRPAcSLqRX2pGSU39
	b2JdjKBwA6HwrJgW3j4uj79yo0Cj3Hw4JgLcK0+dgFaZGrQ31q/ShsEYp1DExISF3jcK7A
	IPsQQ9pDGbqNJpHx6d+snzVbbF3Eeo/gdaRqFwNaJJg+D4KEcFNp0uZxkb1wbeDfnc9AHh
	f0wYUlPkkLJzZgaxQJ92pLT6Eu2uBcz5wj6mOG5JGf+IYh+01r0iKfJF1xoYSw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 22:58:30 +0200
Subject: [PATCH 6.12.y] OPP: Fix race between OPP addition and lookup
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
Message-Id: <20261020-cve-2026-74405-v1-1-106d595143b2@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAyF4auQri2ZFhiMVzEu6FigLtDMIJEQ7
 u6gy+8l798gaTRNcCk2iLpYsueUQacCwthNg6Lds4Ede3LsMCyKB7Cta9egkJdKqvYsxJBPr6i
 9fX7BK/iSuFzh9t/TWx4a5qMG+/4Fw/3eQnoAAAA=
X-Change-ID: 20261020-cve-2026-74405-b16b3b378b12
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Di Shen <di.shen@unisoc.com>, Ling Xu <ling_ling.xu@unisoc.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792529919; l=2499;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=VPmCb2GATyXPy5rj0m6KptWzVA9RMNTJ2rDEOpuexAM=;
 b=JLPAtza9xz1AC8UJ+GwmGkMV6B5F7kdv9EI0T1n68UM0Ebi9cywbAoo4+mvI1L79IO5oVmG9E
 Mrf3TlICoMDCnvhJvz6MxQtPBVpCkssyyznY13+7une1l5uKgcOE9r3
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
index b5df41ce3aff..8ac63a55f735 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2026,12 +2026,12 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
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
base-commit: 7fdb7c1824a1f9979d648d7ae28ac446bcee9c6e
change-id: 20261020-cve-2026-74405-b16b3b378b12

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

