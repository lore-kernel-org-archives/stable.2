Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE5A3A545B
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124017; cv=none; b=gZNp8wEFedUHPwnZfTwJwDhKysMvhq9jq+mc1+KOlIFe4q7RnqW+5M30slRJ85fT0C4bGZOWQLikDxlz7XoSvXgFq7I4kkVCxWIABO5BfPP3ya/tn/0Oc+TZEamRIJcae9pTbmL4oOnsbQjA6EnDG8L4aHPlb/KvNw5wyeawdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124017; c=relaxed/simple;
	bh=baSwirDpA4monkJd3G396GlGsw2NX5Cc/zcZ+SCqjws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHQ5UNJIvz8rKUW8ljhzkTJbSeeHymRX473vT5fqj1Jx7EGGcPGHX6ifA54CCY2tPMtd3RPTpJuQ6vwkONc7/VvBlNiFJNxDDASRJaCBzGvdO6HGnyhup/SX1qHJnb/ogx2xcIKvY7PLzm3E9L/9o5fAjG24asJAv9THspgmg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3iIq2/jp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d96NQf+w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3iIq2/jp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d96NQf+w"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YXvFuUhlC/+OE4W3ff8nmdCq38KYvqxt0ICsJOWSQeQ=;
	b=3iIq2/jpfKCs6dmDVcQ8W7+XpcJ4uRTb5sT0V1S9xzQUoaxsp2a0ZLl9MGgmzretjgzjsX
	NEUp6jKFf9eKMLzNdeSQohhmQPRRyuzEDNhN+HyQkJqIXs/pamlzhFt10Ym6LNjPda6UoU
	THytOOctXIQkOF6ri5SHhXKnD7WgVRjw5zwf1I+Zo4S5bGuSbYu2r99FJQFiu3MjaqiQDJ
	mQlotuMX9jF5wPEbZLTckvDxZEpz6pzI/sID5++pOhs8vXpG7WCIwGtIkaflBLsBP+cmWr
	V9ZJqVUVjHd4d1Ue1T1o3xhmhLVntBU9FoHxo+ClpEVIpaW1hCkebWIzC146yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YXvFuUhlC/+OE4W3ff8nmdCq38KYvqxt0ICsJOWSQeQ=;
	b=d96NQf+wLuKxq6Du417kDBLSH6jws2UUp5b+5lwxQ1C1UnocSs7/dRFE1ZYIItFHp8+Cz+
	8UsPY7Q7JdedXVCA==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/4] ARM: v6.6 and v6.1 stable backports
Date: Mon, 22 Jun 2026 12:26:30 +0200
Message-ID: <20260622102634.780100-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a backport of ARM related fixes. This applies cleanly to v6.6
and v6.1. The v6.18 and v6.12 trees already contain this.

I've been looking at v5.15 and it seems there is code missing so I am
not enitrely sure if it makes sense to backport the last two patches of
the series any further than v6.1. Therefore I am stopping here ;)=20

#1 and #2 are prerequisites for #3.=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Russell King (Oracle) (4):
  ARM: group is_permission_fault() with is_translation_fault()
  ARM: allow __do_kernel_fault() to report execution of memory faults
  ARM: fix hash_name() fault
  ARM: fix branch predictor hardening

 arch/arm/mm/alignment.c |  4 ++
 arch/arm/mm/fault.c     | 94 +++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 22 deletions(-)

--=20
2.53.0

