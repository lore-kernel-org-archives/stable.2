Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530239;
	b=w31VwMQNwbTsRddy8pacC5K3GmCRgpnvUAbh9/l3UJFut9F8pg7JEyDSK+n3AEEDx5b8
	 lwv59hQuP+FAEIXjLBXQNeE1YCCg8ImljX2epcw1JbDI64SYgdU+Cp/o/oQzJpBZ2f7Fd
	 h3JSexG4C1YwC5HPBXuN0PoPZfyQEWXwQ8qK4p7ow9OU0EWhKTde7UuS09GQXPEiTjxR5
	 wYBXt3umQ9BI4TRKpvnkSPDlYxQlTm1PZV20H82xqaOHzsgBcrADkzgjz//j87M8YS5tr
	 prpyEdQ3EddC4a3c/QBqjrQS8BIBYameHATcEcCtyJgPqk3oZZM11wnbK9YRO0cKXeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530239;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=KB2GZPV8p53+dXyweYj9mbh8j9qRPtiURUJQ9M6nrdE=;
	b=nZaVWclHOTixUcF3zI1hVF6HrllUhMW4UIp1RTp++ZfEmqbHGamolWbVJJBfhtK3ILch
	 EFX1VesU8BQ4fE1dbytJKncT/JjFiUa9vjPnNjONIyR0zDWHmBhTgtgLaWvCKPxUaNtgg
	 7vT6vm7WbB0QWO3BZLEAl/sX+60scu9Sn0hQ+CURRdEvTEr1L/I6+C3uy5j9zfpgEXdMQ
	 RUpxq1JyakrPQUX5qB23W9yrjHHbXsRsU4hFFxrTRkZPOULMrMq8oVdPGlhYUA5aAgCal
	 AZB9HvHgPy9S0rJL9+vI/K57wCuNj2kwz8o4nAWCZO2157ECnMH2IZCqteRg38uB6CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kzOtrDmg;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB77606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEB77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kzOtrDmg
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0317C5CD67;
	Tue, 20 Oct 2026 21:04:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E002B60393;
	Tue, 20 Oct 2026 21:03:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0E4910328934;
	Tue, 20 Oct 2026 23:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792530230; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=KB2GZPV8p53+dXyweYj9mbh8j9qRPtiURUJQ9M6nrdE=;
	b=kzOtrDmgPwixnfn7RoqOE3+XdZl+vbcs3RMGJeC5jwckLX2JHZT7Se9qMwrDZTq69BLqSc
	tpLpY6x4WuqAfTEv4XVeMldx3nZ7eZPVMTvG0dSGCNuX5LZSYN1nh0FsfdskQvcMHAwmuf
	L3fxV9F0FLL2Sec3G122fOPlI1CfULUm5bebW4/2aDuJZ3oZzhX69qlB7rbmcb/pqHaumC
	K3W1mqhhtKWsK/m56upelssgIPP7SAROcobnPa5KKAMuvZL0V4tIkiS0PkdiXuiv33HS9w
	wWYEPSWneWBrLnBqMNNxoM7mnn6WHjjMvdojleoTjikIjswb/CrXeMB5Jw11zw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 23:03:38 +0200
Subject: [PATCH 5.15.y] OPP: Fix race between OPP addition and lookup
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
Message-Id: <20261020-cve-2026-74405-5-15-v1-1-d71668a66800@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1L+2imTmETwKuIijqOOiypJLUrp3
 U118+F9eG9G1WJase9mFJ2s2mNo4DYd5JaHq5KdG8OzT449k0xKK9AuBI4UybWRJD5wytuQ0cx
 n0Yu9f9UDYu9i/8Hx/9fX6a4yrkksyxeKGXgqfwAAAA==
X-Change-ID: 20261020-cve-2026-74405-5-15-5c6c2406a34a
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Di Shen <di.shen@unisoc.com>, Ling Xu <ling_ling.xu@unisoc.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792530223; l=2504;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=bKmAwy/CSyzfn3FlNpvpsj1T3Hbt/oc43Y/1LY6vLoQ=;
 b=TPoGR/gVuprYFCRtlg+lBYQc57azV6NuxEnDCWLDHEZdvhABzL96wxisctqUDXfvAo6KMyLWy
 y1dlGrD2KYrDpaROrccdqv9wPh+iGC/iZXR1nGGpwLQkXgjjtaV/Ed8
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
index dbd69d8e44e4..4bcea866954a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1720,12 +1720,12 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
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
base-commit: 792fbe1537d8daeca9bd1917e84078b5432aadc2
change-id: 20261020-cve-2026-74405-5-15-5c6c2406a34a

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

