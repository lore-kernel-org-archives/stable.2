Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7F40961C;
	Fri, 25 Sep 2026 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324515; cv=none; b=ncrLBBL95PoYgqv/QrZT4r5mOjzrQCnIH/2hnrXC5M+QriBz91gji/L6yWNtqEFcvrQ0EuVXL4C8D4nquVdyYVL1bGKkjVtf16UG66SEXoUmSRNwDGG2Av6UBGm9XgPVFsuaKu0SDQG2qPWH19XO09kYmo5ElWOZXTBJpTdsko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324515; c=relaxed/simple;
	bh=XRZGdwnsmXfy7ODo929Rv3pVCZ9Vrb7nyzkknhvNac8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s7p8W2zY6EV5E+Xmm55oHgaWgxmxe9oT5qmMcAjYcUspXp1D5o8Q968hrjAB8531AURUkuf8CV5IrrYtergOkltveMHbGllSytg2r3TkW2cmuFc9PHMU4RJzpusgUp17JTRlT/GEJM1XpJNYBTB/7DjHZ7LxO6e8bXehp2umgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eeGAzQcb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eeGAzQcb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2D796C13989;
	Fri, 25 Sep 2026 08:22:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67C7A6073B;
	Fri, 25 Sep 2026 08:21:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D98D210329481;
	Fri, 25 Sep 2026 10:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790324510; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=WJEOOHDEroosiW5OA4VEC9VWJhCAGpOz6ArvQKGz63k=;
	b=eeGAzQcbyGbUAqsdJMaBMUqetkO80fldN3OaNeAwBVCYEqs61rPNhzbZAm539WH6PDtOGV
	PFA2gTX4JAzJJ0OGnodR7J76EjGwA+TWx+TD5v5ieNN62ArwxYfClsBGawgGRjz7K9cphT
	OrVc23jvsWxnn6toy24jUw2xR38jPE6p1md8rVDadXpTWa1xlcvsSQUaWGQdf0S07mbbPN
	YF5271/S5ErSFiDe7I9wkzL1A0YCsy52FhSuUP0L7XhAisjCXbvlXh4O3JSpxYUbVqGoL2
	4aNPw8VQ16Wnk1NAiM3Xjp0VYp35T4b92O1z5ps5YAe3Qj8aHZxkV+H75QSJkw==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: [PATCH 5.15.y 0/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Date: Fri, 25 Sep 2026 10:21:41 +0200
Message-Id: <20260925-cve-2026-52988-5-15-v1-0-ef05a24139f2@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche3YJLdmG+iqGA5RB1wOaFoiG8
 O4UPX6TzL9RQlQkuhYbRaya9DVlmEtB4dFNd7AO2WQr6ypvhcMKPsFifdOwsBHGWJsazruhA+X
 nO2LUz696IymNlF9q/3ta+ifCfCZp3w9Z4NbOfwAAAA==
X-Change-ID: 20260925-cve-2026-52988-5-15-ef313e696dae
To: stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: thomas.petazzoni@bootlin.com, rcu@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, netdev@vger.kernel.org, 
 "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>, 
 Sasha Levin <sashal@kernel.org>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

I backported an additional patch, which adds list_splice_rcu(), which is
required.

Signed-off-by: Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>
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

