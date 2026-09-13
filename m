Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B2D1337FF6D;
	Sun, 13 Sep 2026 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789304371; cv=none; b=RXi63+Wge97UZraO5J1YNe3JziBKkuL92vTAttGkU+2mX1OqMdcAFgaer284BBifhJDe5/TLcTXRQckVWo9kUQ8noR01wevk0ainrr9/UcUQoLOxpgAudS+BWEWqNuF6s7B+7fbmS80cJGV1+sZNZ5YKwL85ElfAkykNyzSY380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789304371; c=relaxed/simple;
	bh=zDlw6V0PtRlhjN26GnafC+FxR1y6BBk8TOEVrB57KCA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BcrhEKvPRed76vfGyqptWUTPDkmj/GgpKzBR5Z9LzgHFH/3EHh3IwNqj1PchYizmt0yBg0XFsPOTJx5sGZoutl6ySzoGs6uxo6tEZVc0B/HHyQal5o0eGIfrp4HKI0R0lKHvb1JeWjx969m5qGzJExSvpK/3o9YjNTv9ni4qgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=GCeMUhNC; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="GCeMUhNC"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
	<jiri@resnulli.us>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>, <stable@vger.kernel.org>
Subject: [PATCH] bonding: alb: Fix overflow in TLB gap calculation
Date: Sun, 13 Sep 2026 20:58:59 +0800
Message-ID: <20260913125859.2349-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc7.internal.baidu.com (172.31.50.51) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1789304354;
	bh=gnJR7tPojdxPKnkvCbICGOEhsQF4X44trF83MxAXOLg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=GCeMUhNCdZUlN0ITkEAePmjBUy6il0IL04Y76Ck2UkBL17AA309TEk0u1k2fPSY+q
	 J7PdUHjPTKaNYjyGZyGhBUCtOJpw8SEW5ebhi37LF5zocLesmhz4dbGNWFvCtdbzGH
	 gEbJF42TAOtVkcrpQhumygdeICDDlFmBQ+EBt/yfM+jL9udLnMNc5ifsZwTGfFWs+4
	 JkEEv17xMerNqUv53wg8fHvAZyzR3E3H6/380snfj/sXR0gMfa8sbZ0s9+8GQUmkTs
	 XBxM5VtXLq194Gux1FoDptbfNdIjMqv+urTTn3sBj3Ijc2O2hrjMfSLKQkaA1T27PR
	 EYsPg2NZm7izw==

From: Li RongQing <lirongqing@baidu.com>

compute_gap() shifts 32-bit values before converting them to s64,
which can overflow for high speed network devices. The overflowed
value is then incorrectly used in the TLB load balancing calculation.

Convert the operands to s64 before shifting so the arithmetic is done
in 64-bit width.

Fixes: 097811bb48c7 ("bonding: optimize tlb_get_least_loaded_slave")
Cc: stable@vger.kernel.org
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/bonding/bond_alb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 43ac8e2..b520040 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -160,8 +160,8 @@ static void tlb_deinitialize(struct bonding *bond)
 
 static long long compute_gap(struct slave *slave)
 {
-	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
-	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
+	return ((s64)slave->speed << 20) - /* Convert to Megabit per sec */
+	       ((s64)SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
 }
 
 static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
-- 
2.9.4

