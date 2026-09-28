Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472E466B6E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582345; cv=none; b=Uwv8zX2Dw0TgPTyT0NwIzuiaVWHQAWnZu1YtAGPvm99O3H3v2dGJtoipK61KWBK+K35nL0OPZnZZWkaNHSK9sY7bQL6ZyFkxXG7IYi28EgI1rcNeumtPKbYuM6BLRLQmvDPMDC3nfe6Gy/MiRrV0/odevsCnkC1mjKUDMBv9zkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582345; c=relaxed/simple;
	bh=JMEXADvcZeBT8OgiNlX7fhSj6s59UX4/c08s67ntiWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kz+6UxFRw+8xpUKWxlK/R2wihQaIUqcvmKCyj7sjNh7AOoPkfQjVW9iZSR+rXetdg74K/iNcLG2EwH4L8hizrPpV4ec0Em6E3D+YaLaLeeIa0M+O+Xi5Pm7XOOh7Ax260NEuMvGbqMxhGahkWat3oY1RFCmd69T3xGJC69eV4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=myvSsGtY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="myvSsGtY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BE1554E41093
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:59:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8D5D8601BD;
	Mon, 28 Sep 2026 07:59:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2828C102F1EA6;
	Mon, 28 Sep 2026 09:58:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582339; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=RXeuYrVH6epmbVpn1QgYfyvHDhvmHY6QE7EVLpWYNBA=;
	b=myvSsGtYSYvZSOh3FiUXdSLm3UxMl7lK93mzZJqoExl+eX3Rw/ATibw3K7WR7AXYsfVKYY
	7zUyLV5pAKpXFOUJbwq1y1Z2PM6tE9QBW9TRb/f7FKm2gNVO+qxi6kwdoyUJltjKOuL65V
	tG7I7yZYIdXkcngyF4tp0lkWyQakLlJ/B3XDIPdIu49L7KYZ55d747AW/c0zOma4qGxGLV
	mfsd8fSK5bz7gT/cnC0QUxzMclkTM0LopKApFLsNJZy6tGBi458omFOftH+MoFMygavyfI
	RfGDA0ApgBHH9G0mXNBbjmb9wDPcBxEwF/qQ/TZZZ85999GE335/FEios3EF0Q==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: [PATCH 6.18.y v2 0/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 09:58:45 +0200
Message-Id: <20260928-cve-2026-52988-6-18-v2-0-6492e680c52a@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ7CIBREr9L8tb8BBARX3sN0IfhrMVoMVGLT9
 O62de/yTWbmTZApBcpwrCZIVEIOsV9A7Crw3aW/EYbrwiCY0MwKhb4QroBKWGNQIzdoPbH9QVs
 nZQvL8pWoDZ/t9Qy65qYeofnl+e3u5If1cm12IQ8xjZu+8K3/11Q4MtSGOSGNVZKrk4txeIS+9
 vEJzTzPX/AGeI7SAAAA
X-Change-ID: 20260925-cve-2026-52988-6-18-9ce03769b44f
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
- Link to v1: https://patch.msgid.link/20260925-cve-2026-52988-6-18-v1-0-680b24895415@bootlin.com

---
Pablo Neira Ayuso (2):
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase

 include/linux/rculist.h       | 29 +++++++++++++++++++++++++++++
 net/netfilter/nf_tables_api.c |  8 ++++----
 2 files changed, 33 insertions(+), 4 deletions(-)
---
base-commit: e8694cdbd7db99fa26f6e8c80a2a337e0de29a2f
change-id: 20260925-cve-2026-52988-6-18-9ce03769b44f

Best regards,
--  
Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>

