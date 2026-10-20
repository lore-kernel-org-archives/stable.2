Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530479;
	b=l44M7t8WA1/9ZG2Ut8LC0eh7qiYOCOkcOkT6OEf5YMdcw8wjbDH5Bluzt/8scpt+HcDY
	 7EYWN5doANqWm8D6j50QgfCN2ihhhfIDvI2Kesz61ATRv/8URr784pdt9Ss6FSBmhYnoN
	 I8/tgMHPjbjU2ln9NbvSjPv+NGcpQs9CvFOf6KP3JzZPTiyh9RPMW2f00iWettn+GS4zy
	 oSTo0VA3vP+3B2rY0I14QEDvL6l3JrC++kLM7PxEyDg3rteNzFT7PsFfgBcJ+Kf84hTlw
	 71TTNJNdEgdapmVbSJGpUkaiLVWVQ09tUaUOPygdPa/QIdQz0TEnJp0rF7/0EqcfXog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530479;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=Mpk9BbL9RpgARuzuSjUngsVt/TvRZcu1wm2dYtDVOcM=;
	b=KQKKaMOUcQ0d08J7qnmxkJy4AApExhgNVrrqM7e6AGUgnbNoPtV3N/ACu3Vtvj3qJQu6
	 QlPtM3DaAtTfVkFQk2CoLDh4UEFYK8TVoKxy1t5Ttw4QhC0Yuah62HksV7aCCmg++Mqgr
	 Y5DNPe3Zsf8RjYLW+5B24GITAPPtPW5a+DlImUIFDfFX/ysu+OanIV+E4KFxoXsR6SIQA
	 n8Zf/FVC3MaNXjuMHwZVKOqMmS32e+TdIHxE4bByDDK9rl/eh4VC0iKDQ2KV7vkj08FC1
	 ex73QWaEU0iw1JZBdvYQ9f2y4VW30ox6Utbjo7Arc7fSbG8pNz0jQhDgF13EdK87+rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qiTDqQ0L;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82DF606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C82DF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qiTDqQ0L
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 83295C5CD67;
	Tue, 20 Oct 2026 21:08:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B6DC860393;
	Tue, 20 Oct 2026 21:07:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9F9610328934;
	Tue, 20 Oct 2026 23:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792530471; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Mpk9BbL9RpgARuzuSjUngsVt/TvRZcu1wm2dYtDVOcM=;
	b=qiTDqQ0LBOGCCt92HIh3UWl0qTLN1o5mFZ7iyWZO5Adg+iCdaeZvS3CH6a3o/CgZ5Nwsbk
	RZD6Nmi04AOwPnBhgTJBaXwuZQq++AJcfgRwg+9TGBOK+xoey5OV935gmPwN2Hh8d3mQtO
	mnmw22rMyT9okat+G4EDYhSGi6vI7tiih4A742a6QUTl5htLspy0NRQM6fJFjhZuKEVtp7
	01QTJCyh2AdLxtrAWbyDu7i6MHrkgwQxpBKKTvMqLMiXkKkEXIx33YSC/D43GuOWymuPya
	Xc3dGgsElf8XRf2p21D4Lhyc+a7SxgHNAtxj0Hg2xHxOXscjH6fWsL8fC9+WPQ==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 20 Oct 2026 23:07:39 +0200
Subject: [PATCH 5.10.y] OPP: Fix race between OPP addition and lookup
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
Message-Id: <20261020-cve-2026-74405-5-10-v1-1-e59b22d4afa8@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAyF4auQri1pJ8yQeBXjgqkV6gLNjBAI4
 e4Muvxe8v4NsibTDNdqg6SzZXuPBXypQIZu7BXtUQyOXGByhDIrnsC2acijRyb0LhLH0LJIgPL
 8JH3a8qvewNdM9Qr3/56n+FL5nknY9wMN9G08fwAAAA==
X-Change-ID: 20261020-cve-2026-74405-5-10-52b01b671cc6
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Di Shen <di.shen@unisoc.com>, Ling Xu <ling_ling.xu@unisoc.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792530465; l=2836;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=+edd1FfW8jXh/gCmuT5j4CWdMGwn1RrhOMJ08Wo/ilE=;
 b=y1INg4AfNO+GpAZjB9cf41gZmt5a0SmIOLSh2f8Pypcb0g6+8KGI51diOOCHNRoVrYp+51XXP
 +eBLvAd3DffB+GUGxz/QLhXTFMe07SkFMG+wPojW0WupTabX/gspk9q
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
When I'm backporting a patch for a lot of LTS, currently I cherry-pick
for each LTS, and if there is no conflict and it compiles I send it to
this list for each LTS. Is this okay for you, as it show that the
backport was tested for multiple versions ? Or would you prefer that I
only send a new patch if there was something to do ?
---
 drivers/opp/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7999baa075b0..76db501ff515 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1511,12 +1511,12 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		}
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
base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
change-id: 20261020-cve-2026-74405-5-10-52b01b671cc6

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

