Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8062388E64;
	Mon,  1 Jun 2026 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304375; cv=none; b=B709y90jVNbxwi9Kb6hGHURR8RomDokTEFEnIw1E1pkCuELrB7GZsaZwXHsAOhWKROS9o3zYHANSShxqt8aD0q2GTjN0wzIPD/l+kOUpUM2GkHg3EhPE3emId2J6dNqupZehcv4nCRzvf0Xwzp1GFjX1Y861JTmrFkOavBjnMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304375; c=relaxed/simple;
	bh=8zQvzTc96q3xI2j7PmvnrJ5g/KnjmGPG3zS0o9WNdNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCbsO8+NhaPORvG8d2FUW2IJk2KfJYpvC0mICBUee881G6uTYvMSroVW6D8XWGV3VV5SpesHml0uuqCDkN0KSumSIiRyydaHNm4TuqFUqUNEpktqoC5NdYBWNzfxlqF8zdCzxwMLdByII+mnv63DlE+hQEPUlQC40vG5/RHSqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Kfqwr/ro; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Kfqwr/ro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780304242;
	bh=JrPdlqiPqB2XYPAwe4Y6ZpExCv4MAfgU7GRIO4GdeiQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Kfqwr/rowy/4cGmxCBFivnMgpcoIGqG1iGHogLPdoZAthBxFpyav64ORFQe2rwSh4
	 ccidlxpOchUw+PIxkbBESnB6bOafw73sp713KwlLCjNpkZKTdwcVUVvl6RxaSLa7fy
	 A62D4Cu6GGjvjkMihpz4yjcoC28lbeZEn3sEP0/E=
X-QQ-mid: esmtpgz12t1780304222t384bbe44
X-QQ-Originating-IP: ALqWp/in1iYHwrhJ4pv5l6nQyw3F+9vwwK7m8dHw2l0=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 16:56:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15784183384065971705
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jarod Wilson <jarod@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: bonding: fix NULL pointer dereference in bond_do_ioctl()
Date: Mon,  1 Jun 2026 16:56:49 +0800
Message-Id: <20260601085649.4029067-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NlqsT6bE7SJIwzwLfkLrULC6yh0N2upuIgQERLXK3M/247FCc6UDwxex
	QtwDJfYrwiNfhIIgXJG7VtzoMKgNHkthoPbt/MDW/vnOamI4lKThZ2lqWF3pwEfs7t0aI2Z
	cA0mB2el0m8vlSuL3wvtuY/LDK1ZdgFXnE8VjDVNfwCbSiRSFZA+UkpOCtS5WcK9lnHGLe8
	gtJa3YYyaQq4IPQ3Ln2cySccjzRdYTBIKujEwcVeJIDsQrbTIsTqD3CtPzh1FTu4kzTqPcx
	3d5WiSmg00MfZRbQnPBB27V7RQ3BsRZ6Xc4NQqIT/PP3fbcIVccp+KxU3q7liZfol30KnTU
	2musW/345i0L6ie7UibErcaHHU/qQQiXEJdP2We5BB2OcrmQqG/8C2axBMr1++q+96E8njS
	wFDwPub+stSv0nxcaJSx250vX1XQroLwcl/y1hdxvMEa/293JVZqdgH6rbGqYZx6MXX8q9y
	z8U5nDLIs1ckBUaaD4vA6zfsgOVJxXZyh/AMG29Eyulrb79P8HqjPdhaHTgPt4GjI+ubIrq
	UjozpZ4yuGoXCM17RezYUN2Kvbv7vES+zqi/zhbp5mAG+LVmHrwXmrZc1kEr/cgzRDXk/Uq
	n6xJUchwuRcGRQFTnj8OfF7kDgKYy9CHP26aCpJQz/NYBkypgRZS7fJCB+K10J/4/kdNdQ6
	qFn/kvC88QiEI1dbIAWg7Mchn4QT1VSZFnpdlcM27hW62uSk87TlUJUXmWraBWhtDlZopHt
	xXwsk+ErAw6ZbIzOqdva/O5CGao6hH1nb+OM4Uy60LdVTCDzCKWjR5NW3AsuB+4rxn7TWK9
	sDUno7Opuyqs9WwvlIEpLmsnc+A5wZALMNRmdD032EKmgItB1qszyFsMT/kg4fkgMU64Eqv
	4AmChrKBDw67R/SXj6uZUh/mbUqqqMvaQJVyOI5WP3JqrBfPCTsfMyldXAFM39hcY7GXvIa
	W9TfT9rHGD9HO6NaGVJdVEafmr0bH+VjNbPnA7WEWUAf9dpPB3HkpPQj10+I9/QUlIGKFQm
	bk/miYm85UQINZ4hOMrU7K+0itTjI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

In bond_do_ioctl(), slave_dev is obtained via __dev_get_by_name() which
can return NULL if the requested interface name does not exist. However,
the subsequent slave_dbg() call is placed before the NULL check:

    slave_dev = __dev_get_by_name(net, ifr->ifr_slave);
    slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev); //here
    if (!slave_dev)
        return -ENODEV;

The slave_dbg() macro expands to netdev_dbg(bond_dev, "(slave %s): " fmt,
(slave_dev)->name, ...) which unconditionally dereferences slave_dev->name
before the NULL check is performed. This results in a NULL pointer
dereference kernel oops when a user calls bonding ioctl (e.g. 
SIOCBONDENSLAVE, SIOCBONDRELEASE, etc.) with a non-existent slave 
interface name.

This is reachable from userspace via the bonding ioctl interface with
CAP_NET_ADMIN capability, making it a potential local denial-of-service
vector.

Fix by moving the slave_dbg() call after the NULL check.

Fixes: e2a7420df2e0 ("bonding/main: convert to using slave printk macros")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/bonding/bond_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 82e779f7916b..8e75453ce0ef 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4621,11 +4621,11 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 
 	slave_dev = __dev_get_by_name(net, ifr->ifr_slave);
 
-	slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev);
-
 	if (!slave_dev)
 		return -ENODEV;
 
+	slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev);
+
 	switch (cmd) {
 	case SIOCBONDENSLAVE:
 		res = bond_enslave(bond_dev, slave_dev, NULL);
-- 
2.20.1

