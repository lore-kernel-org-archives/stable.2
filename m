Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530028;
	b=Zn+98jxxUGgI17si1f4jcpJUpmChrI4AK66mpk6XKqPu8ikf9MP7U3l/fhMwtS630QFn
	 2o7qkw1Jl5nU24WGi6qhZJ8grid+BihV37uqcjnstT2XEsYBaEXfVNVFKZ1iJquQW0Pyp
	 apwv6FR4Wf9Wg6C8xwEvVHTd7g/EOjxL1pQx8T/TRSY89R+nGTgw2eSUr3wNwHp27qowx
	 sIK5s46clNUmAflYy/ZfHr1k7t+JYIDRF2u6bN47uOGo3bFC0kSrfHiOeWSm85jvIjQo5
	 TYinzoMvgJvrvzmAj4UxuNPWYzSupkMB1G3jVLuP7Lj7fqkb5AoVBU7VRDyRQd3+h/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530028;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=Y+fJrmJptylg6LmetrQR9O6Ff+vDIRZl7nEW/rjgcls=;
	b=I4L5pYWNSUn8okA9+CnNJVSrAa/ClYmDfwozT/Hf6GQQ1vybc6zxotClL7dJQKoLPcHa
	 O9CiDHwgAa1mSWmy3vOj01Mq3P1xUHe5Xo2AnzCJbgYbwRhX5jnKnJeZKl4E7a1dkiqso
	 I35Dns3Zo36ittEFnrIPNc/W49v7rwU/a377C6IggM73n2Fxm1YRAihqf7JShhEP63rPX
	 anFfjNLArB72Ffi2qekLGqVYDAGS710PwgDIOQdddotmj/BQqWRTY36uEaE5YyOzQQg71
	 IPAeaVwq+jQ9u9cyr2/NzD5hbrjZWxABjbLt+UXYDEcYHcOrykJ2JSSEHDcOTtaw6jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WPDRrke5;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A01606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68A01606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WPDRrke5
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C56FF4E41290;
	Tue, 20 Oct 2026 21:00:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A94A60393;
	Tue, 20 Oct 2026 21:00:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCCE810328934;
	Tue, 20 Oct 2026 23:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792530020; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Y+fJrmJptylg6LmetrQR9O6Ff+vDIRZl7nEW/rjgcls=;
	b=WPDRrke5T8TB/wqbFEaz2+Agwqv4I01z6q+qookgRRzkGOjhgk10uXHl77DNtENs4C9tUT
	NU41iagqie9GuxArEORIwEc1JboMtUG21YSGG5VOol7B49m4Pseo2CsUpkCP0lhwW/yr1n
	+zMtKH8bzx03QqoYreAoKs9gVGIeRGV3H3oqIsO43Duk9FYJMPC27+TzqnY9p1FSgncxpp
	gPyS6QuX4MRpcUcUHIzxvEnBNfn9IpXp0s6pq37zeeryGg3VyWuX7BcpRoryQ1t/sQ8XWL
	9Mt2ANYPb9aaAQaKJ0CA7f6rRv1ONm7qXJHMzvNnPte0yTUhdbagEa+PY3UIEA==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 23:00:06 +0200
Subject: [PATCH 6.6.y] OPP: Fix race between OPP addition and lookup
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
Message-Id: <20261020-cve-2026-74405-6-6-v1-1-cf8212266b3d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1L+2inTkIzoVcRFm4w6LqoktSild
 zdV/up9eG9B0WxacGwWZJ2t2GOs0O0axFs/XpUsVYZjJx07pjgrbUB77zmQ1HlOhz5JCGFwqOI
 z68Xev+gJ0kr7wfl/l9dw1zhtQazrF+yhWAF9AAAA
X-Change-ID: 20261020-cve-2026-74405-6-6-40d9ad6555b2
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Di Shen <di.shen@unisoc.com>, Ling Xu <ling_ling.xu@unisoc.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792530012; l=2503;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=g53gdTiczYQPgEOObo9GR+YdzfHQicKaWEYxIkpP7Ic=;
 b=dQZsoLbdpOTbRjIrdjo/mFpZXbJieKtYL5UJ9u/Q6NP0H2ns0hsuQEso6krdpSXmlhPqwj5R9
 ThE8WP6GMYaBQQeES0hBr2Bwz21yvodGEXPyd+mBY1mL/jOzY3RVXTg
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
index 218cb2e7f360..50ae3c639250 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1998,12 +1998,12 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
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
base-commit: cecd39af8a1ab81373fd9fa765b2f7ab73becaad
change-id: 20261020-cve-2026-74405-6-6-40d9ad6555b2

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

