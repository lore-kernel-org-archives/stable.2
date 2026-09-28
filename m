Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB183372B2B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583021; cv=none; b=OYSXxlHMXhm4ZVmpPFriGyXRjTkMBQhtkW1ORhwjkiYQZKCwta2KBqEoCQGKesBDyWf9X6Ef9Kv72sY8DvI4oAGjvXIuUfgivD5JARnQ+Z4TxQacVd/b3uW97umw9qyDnY0Qfj9ekxaXx2kdmJ2RhGYMy3q5upbVDsE9OieUq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583021; c=relaxed/simple;
	bh=mUpm9g9fG/jw8WfOKL/IMMA/xFvD3mmPqqtKUEc0hsA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WBlBF517WhirPq78sZbZ5sXGwm//307d4B46/PakFcaUHo+OCcYEU+Fu5qNI489rxEi7/1Q/G1rI/tcDUIDWl3PTXvMXQDgAc4Bej1Lv3EU7VWc2A3U3ejAoRDwfaXZs/zfp9vDnUMZo8s+82uX6tUP9eO4C5nFKwoV2Is2O0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fh2ge9PL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fh2ge9PL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 127AC4E41091;
	Mon, 28 Sep 2026 08:10:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB244601BD;
	Mon, 28 Sep 2026 08:10:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3887102F1E84;
	Mon, 28 Sep 2026 10:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790583016; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=75thV0WsIywipkkMyREQKO6XRSjLzATwfBEv97IwOkQ=;
	b=Fh2ge9PLqAqOQ8QnXhkLm0/K+CT/vHqsGpAbYBus7ubROnix9O2PwwDR4ENcCn3yxUZua2
	w+6va7bArhMYZe0Py1jXBwJQqLm3eJqKdKbS7WWrLjyBTUwuyeF9oj2h75SKLtx3hKGCUA
	E6HxmgiNyJtLlK0LKCZLjQwvQ8Y7E6/vZYyBCCjxtfBEiC/mcOom+t6zJben+/Zwd+ylyA
	5ZYXNFeIMeNz9c8wXoT7hYYerFZdwMGOKr5gOgmjpQXbcCQNOk4mAb2f6Niel290fAWxGw
	8ObrHOoTYUC0HrCe7akq+ejG/b5SNWRN4932Vd8bqzK0HW3vkpncBzo+EpqXOw==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: [PATCH 5.10.y v2 0/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 10:10:11 +0200
Message-Id: <20260928-cve-2026-52988-5-10-v2-0-d44de149a5ac@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2SXtaoFy8j8MB1oXqVFqWmwkh
 H8X8O7xTWbmzRA5OI5QZzMETi46P6xAhwxs3w43RnddGUhQITQptIlxA1SkqwoVSoGdsqejaQt
 dWA3r8hW4c5/99QIqlyKfoPnl8W3ubMftcmv2Lo4+TLs+yb3/15QkCpTacKmISyJzNt6PDzfk1
 j+hWZblCzt2by/SAAAA
X-Change-ID: 20260925-cve-2026-52988-5-10-f5c43ba696c9
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
- Link to v1: https://patch.msgid.link/20260925-cve-2026-52988-5-10-v1-0-19be752e722b@bootlin.com

---
Pablo Neira Ayuso (2):
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase

 include/linux/rculist.h       | 29 +++++++++++++++++++++++++++++
 net/netfilter/nf_tables_api.c |  4 ++--
 2 files changed, 31 insertions(+), 2 deletions(-)
---
base-commit: 1797d8bf8d0c2e74defad605d14e3553d43a3caf
change-id: 20260925-cve-2026-52988-5-10-f5c43ba696c9

Best regards,
--  
Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>

