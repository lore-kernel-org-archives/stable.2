Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C69457E7A
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582861; cv=none; b=ddIWxUin2ExHwcWq0lgENbguMX14CnSgFyB7D3HlUF6rAsWRfmUkPQBbsUpNPaPifeikHf2cAgbP2XeW2X+Gs2XrGyKzWxKMDINIfOKkhSo91bS5PLpEms6VdyZRUVvpFnwR8O2fyywJyPIKqDdjlY9wHjKqvLbvStzqzckTFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582861; c=relaxed/simple;
	bh=GLJPQiar11muv8NEyz9fm+xXonfnYIY3DLZQy1eLwB4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MQH5WhsCvKGBRAanPWSwras4Xn8HLbNTJWSQD0HXg3AlkCsXZPUlc2k1zCzeSuXSz3THRqZZBRPB6PPGzldjrIAr1wJyajXWA9g+rajc18ois7K/pW6jKY0dnlUi7o8rh01Ic0OcLo3b1Lfxj16qSzicqCLCtz92yRqaZdW+N0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0Ha7HW+w; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0Ha7HW+w"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5DC7D1A0FDB;
	Mon, 28 Sep 2026 08:07:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2BA7A601BD;
	Mon, 28 Sep 2026 08:07:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EEDC102F1EA2;
	Mon, 28 Sep 2026 10:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582857; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ACylhHS6Ia6991aFDLQ9BXhqlekN3JdZS9yyhSVvd44=;
	b=0Ha7HW+wJ6sZMrDZMAwPzZQzOMZxcEeXCKyVuemBOMo3LaVOjnmJ/DkRdYrWS2bsiACMCw
	J62Zp8GNzin3xgMAyanxAAA6gvpkkREKUk7chohPBnRY8wmjqNbhoqX63VLj3731uWvDSj
	JWxwoNiJ+nVo+zcLgx2/dNylDtvUdwod602lED7eybyY69tJXl6xPdC+XRDyXwhdvJVVP5
	6L3pFDG8PLffClNeNhvn2H+ZACAyS7W+JxdeG4qloE0H3xUxoqs7S+MAvJwrZ/LbjwEvgF
	pfeIDaAhBCCuB/kPz0uzVR+q3F5hLR0UyYCLEJjN7O2ruSCCBcN9B+CXZU0D4g==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: [PATCH 6.6.y v2 0/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 10:07:24 +0200
Message-Id: <20260928-cve-2026-52988-6-6-v2-0-0d40c1553ff1@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ6CMBCFr0JmbUkp6QCuvIdhQdup1Cg1LTYSw
 t0tuDdv9b28nxUiBUcRzsUKgZKLzk8ZxKkAPQ7TjZgzmUFwgbwTkulEbAcmRde2DLNUZa1pBiN
 J1pCLr0DWfY7RK2CJ5QL9z45vdSc974N7cHRx9mE5zlN1xP/9pIpxZqSqOTYtWcSL8n5+uKnU/
 gn9tm1fSKu6G88AAAA=
X-Change-ID: 20260925-cve-2026-52988-6-6-b1ffd7ad5e53
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
- Link to v1: https://patch.msgid.link/20260925-cve-2026-52988-6-6-v1-0-d5b30678ef66@bootlin.com

---
Pablo Neira Ayuso (2):
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase

 include/linux/rculist.h       | 29 +++++++++++++++++++++++++++++
 net/netfilter/nf_tables_api.c |  8 ++++----
 2 files changed, 33 insertions(+), 4 deletions(-)
---
base-commit: 79643295eba17affbd16ca97f3ef04c90266b28c
change-id: 20260925-cve-2026-52988-6-6-b1ffd7ad5e53

Best regards,
--  
Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>

