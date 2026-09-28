Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DBB46E019
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582737; cv=none; b=i02LfU65a4dJhT34Lpud5Q8PtTayF6eGpNdhj3z0xKWhOiipwCJpU1TYUluiTk1annVXMdVxBzSQk3Yq6rFsSlmcVGhlI6bVksjgwAjOwfsx9qkiTJ6oUCReK/96KHr0FbC6QuVUeAEc6G7mVorQBJ4EQKxxkcjxn0sgDl8KHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582737; c=relaxed/simple;
	bh=2z4fnZXKpmQrLF5kkxbv8yx8WN3YD6wSXW40zqD8FVw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mPGWM76qDwIObarqXonSaRtm99YMeK6i/Q/4eeL8VKP7xbv52nLHJkbVAUH+qCaYFts16q5NYW2l+ifXtJlLyXBK+B5FgbJSyPuQ1ysJ1gnsMOKNePqgBNUw0LVsOUzRatW/8NHCaGfuNRwSAf5dKtiO257SrZEgmCpgZ+/LpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FAh3QAAg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FAh3QAAg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6DDE1C5CD51;
	Mon, 28 Sep 2026 08:06:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FDC6601BD;
	Mon, 28 Sep 2026 08:05:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1139102F1EA7;
	Mon, 28 Sep 2026 10:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582731; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=mgPxiDDN+omzTMC0h88vjrKadXLFtP6jWiDCqU81XzA=;
	b=FAh3QAAgoumG5Q1GQhP3IkAwIFBZ0welRCbs6CkPU4kY700pxi1Uf5IF5qvln1O12MCK7O
	vkNe6gSbHRRijRrBFLlQ6FoQmNNA1CgZiljkciPk85IdQ0OaHuL5N4STaG+ITUXc16VhSQ
	We5kR87OxXpzsGL5U9r/ZtvfSFo/JGP0fSo5m9CtRQB/oB2ssaNreP9uQrYsSO95Qdt5a+
	Cxj6BfsJwzVry2/W0N5W9MCG2LfGw5bdlqD/WHAOga/9sfZzToMFWHbUIZR0jHfr0kDK6/
	LSnK/Og592RAdsINPzNqqrPEUlGLmLmS8f/HZEf3HvF9sbc2qFyUMVthdfOiow==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: [PATCH 6.1.y v2 0/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 10:05:18 +0200
Message-Id: <20260928-cve-2026-52988-6-1-v2-0-727cab14b35c@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ6CMBBGr2Jm7ZC2QAFX3sOwgNqRMUpNi42Ec
 HcL7l2+l+9ngWA92wCnwwLeRg7sxgTqeAAzdOPNIl8TgxJKi0aVaKLFDbBUTV2jRolU5Er0WuR
 dVUEqvrwl/uyjF9CZzGZofzq8+7s10za4BQcOk/Pzfh7lHv/3EyUKJNJF0iRyonPv3PTgMTPuC
 e26rl9+zSCkzwAAAA==
X-Change-ID: 20260925-cve-2026-52988-6-1-f4320b603a77
To: stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>, miguel.gazquez@bootlin.com, 
 thomas.petazzoni@bootlin.com, 
 "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

A conflict was resolved: One hunk of upstream commit was not taken since
not applicable to this kernel version.
An additional patch was backported, which adds list_splice_rcu(), which is
required.

Signed-off-by: Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>
---
Changes in v2:
- Added missing Signed-off-by
- Link to v1: https://patch.msgid.link/20260925-cve-2026-52988-6-1-v1-0-ff64026f03ff@bootlin.com

---
Pablo Neira Ayuso (2):
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase

 include/linux/rculist.h       | 29 +++++++++++++++++++++++++++++
 net/netfilter/nf_tables_api.c |  4 ++--
 2 files changed, 31 insertions(+), 2 deletions(-)
---
base-commit: 1a8763b93150b2c8f3992c27a5ce7857fee4ab0f
change-id: 20260925-cve-2026-52988-6-1-f4320b603a77

Best regards,
--  
Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>

