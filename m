Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64646C836
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582438; cv=none; b=bZtDXsB9GtdRqsZHJ+FgobZKL0Q+MuS2K9lALQqz9XI7OiWghIQN3zw474OyhykBw5TMZXpDQfxA4jyT2Wx6y7/Y2IX6HpJ6MZ3baeJYs1xmku8S8GDx34En2e2/1qFugb/ZAH2Ek/kL7y/ALoEQtR3JXznLcirthOPyyRRGISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582438; c=relaxed/simple;
	bh=GpwWX011HQZjMPJcjOmwRFe7sxtALH15bEdyufXG/yU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kwCNLoRO0LEER7NxpCT8Ts3rtPV6OhArk1ErpZhwb0o9dYJMKPFwTpGyRM/HjsqSsi4Y1wbBCCjUxXvT/bc+X1bjN9iRWSwi4kYHzcE9d/zQ3NAPGmOEWkIos/CTTOBcRLTLEM6JHNfJeLA0fQRRrrnvAgiR8fIlFj/lOXUOddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j7euTmnp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j7euTmnp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3ED79C5CD51;
	Mon, 28 Sep 2026 08:01:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20E4A601BD;
	Mon, 28 Sep 2026 08:00:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 083FE102F1EA6;
	Mon, 28 Sep 2026 10:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=x1Kn7hDuVKOSi0etVz2INsEnbXmYVcObjNCJBpQwmYs=;
	b=j7euTmnpkzgA2YkrLz11oHK9cPs5fLOeNHhbZTQBRpEH//Nf/yplkeZNYlNU0k+s68r7bk
	87YFaRG7pjCrqB6InIWqiX+u+pQjGm0waSPQBdEq6/usEM9DS6CuMrOYSuIadf2g8TaUqJ
	7mPtwbl4B897lGW0jGjHjPP0sX8TPQRGksDyvRaUle2CpK/m8d+UhhkAu8+4Dmgnf3Mi+V
	gIlZEk5wsVXwck+XuJ+7uP+g2TTqq5sDMMFYkUWR/CT/bqHK4uOb4GGX1VLzhmndP617i4
	xW7IhuumuHKINVtUHZFz13AfeERYH/nHnTZ+PfddK08yx2aXkCWyejyw9MKafw==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: [PATCH 6.12.y v2 0/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 10:00:20 +0200
Message-Id: <20260928-cve-2026-52988-6-12-v2-0-74d198e65cb2@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX4Xs2SXtyl89+R6Gg20XqVFqWmwkh
 HcX8O7xm8zMN0Pk4DjCKZshcHLR+WEFOmRg+utwY3R2ZSBBlVBUokmMG2BJqmmwQkkorS6OnVI
 sWMG6fAXu3Gd/vUCVS8onaH95fOs7m3G73Jq9i6MP065Pcu//NSWJAq0sbN3Ulowuz9r78eGG3
 PgntMuyfAHoehsJ0gAAAA==
X-Change-ID: 20260925-cve-2026-52988-6-12-1db43f99e0e9
To: stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>, miguel.gazquez@bootlin.com, 
 thomas.petazzoni@bootlin.com, 
 "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

An additional patch was backported, which adds list_splice_rcu(), which is
required.

Signed-off-by: Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>
---
Changes in v2:
- Added missing Signed-off-by
- Link to v1: https://patch.msgid.link/20260925-cve-2026-52988-6-12-v1-0-d14d787d2cb5@bootlin.com

---
Pablo Neira Ayuso (2):
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase

 include/linux/rculist.h       | 29 +++++++++++++++++++++++++++++
 net/netfilter/nf_tables_api.c |  8 ++++----
 2 files changed, 33 insertions(+), 4 deletions(-)
---
base-commit: e2acc2211022246c77740d5df08265cc27eedcc5
change-id: 20260925-cve-2026-52988-6-12-1db43f99e0e9

Best regards,
--  
Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>

