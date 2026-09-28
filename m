Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907946EF8A
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582937; cv=none; b=CC7T/IdgzNI78y2T5nfotOchkdYblmxTUP0POCcK5RcJsNWxzSOhspfX3J9CesUaVyWaD85ci8edp9IzRyel8Fuo3Qnt09+z5X7kx6AWJo7hpvUyBToSCyuUoquX36BnR3Kunrl6UumWTpSQoI3t2fABxt5zKeaHPzCuofNNW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582937; c=relaxed/simple;
	bh=a+Cx/K6ziP0SEIDxtX6S676B2BEPAJ05ipAgni4FXrk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LwP1zBbdhA7uFwTMTUJ8BJQJW5Bofq3FpoeuVrT8C0dwvscMUYdsRn1IT3nO8gqhrXDEkWXzlKEPLHrXZfigK/vGMCIhQkq4dkLuygj417D1rl9oAGpuJqrLvQYsfeqfrOps7DjOQSWnxQlgxAgjZEkUyYpjVxipP6X5qVbjLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AdeYp/Rh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AdeYp/Rh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8AC7F4E41089;
	Mon, 28 Sep 2026 08:08:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5FF22601BD;
	Mon, 28 Sep 2026 08:08:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5ADF1102F1EA7;
	Mon, 28 Sep 2026 10:08:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=SiH8FKhScuA/RKMb5zAKgAMUR3gPiStPY70Ob7KyrAs=;
	b=AdeYp/Rh8YMzlNoTgQExGey+OWaAXCul6vAfuPDWGL2CgYY/7GQrFSzmw1UjJKUctN/uSt
	2bAzOFNd4lAfRlb58nycphOqVdbVL7dK0+yeIFeWttc0GaC1s5Jl53BqDdQ5YqQCdUtfPB
	roPrYDwuHl6dAU2MfRJGvXwrTdmzLyeQs4yqlGsHVxJ1N31V7M0DcYCOvqSGWaGl79ARHF
	EH4E4M1ZeMZXZ2HzXRieMEALGPASYWvAYcCU8UolvCkqsr1C8rgfklfOfmLSD6Bawkpy65
	jWdio5gxwm493+Gl/NUS1eHHVDXnacpLgJxKkaj+r80J9rLkFK+JY7ZdEcpRQw==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: [PATCH 5.15.y v2 0/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 10:08:48 +0200
Message-Id: <20260928-cve-2026-52988-5-15-v2-0-519003db6b26@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2SVtcQn15H8YDlAWqVFKWmwkh
 H+34N3jm8zMWyGwtxzgkq3gOdpg3ZhAnTIwQzPeGW2XGJRQpdCK0ETGHZCUrioklITcF7LgUpd
 dw5CWk+fefo7XG1AuKV+g/uXh3T7YzPvl3hxsmJ1fDn2UR/+vKUoUSSeoUWdZ6F5dW+fmpx1z4
 15Qb9v2BbespFTSAAAA
X-Change-ID: 20260925-cve-2026-52988-5-15-ef313e696dae
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
- Link to v1: https://patch.msgid.link/20260925-cve-2026-52988-5-15-v1-0-ef05a24139f2@bootlin.com

---
Pablo Neira Ayuso (2):
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase

 include/linux/rculist.h       | 29 +++++++++++++++++++++++++++++
 net/netfilter/nf_tables_api.c |  4 ++--
 2 files changed, 31 insertions(+), 2 deletions(-)
---
base-commit: 0248c33e835ecbec3a591f93fdaae53f7b90a4d6
change-id: 20260925-cve-2026-52988-5-15-ef313e696dae

Best regards,
--  
Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>

