Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641149E159;
	Mon, 21 Sep 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999130; cv=none; b=GICl2ZAhqQabK4fBD5ZEY5HLa+6LREGkWmHXxn+VPvlWkr1j3g3il1Y2ABSYqeAVC8l7LcFSbrzFYDr3NiKFHXL1dmYjgTmeOkgIbYaT2gT12CHHoI/dr0J3fy67ZuPoylPDOWl3aFSejSuoPIrtxA984K4vyhpmo+s2vQ7QT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999130; c=relaxed/simple;
	bh=9VD3wpbw2GP6bkcpMOjffpYrxwp03EDfsioL+Q+vuvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8xwJVHXs/RHZhzxX/9Ns/H1pR77UzlEWPyOYyIcLX6yCxsm4VMqUFLR/Ft3F5ItkXErwHzeGKkf6C6rMiQfJX0LlSdOjnJNExpM6TFwl7ekStQtrWUh3QuaKHBhGfIThKAmg/I8zsVTmNOKLlkB2MHqmYX6qh991LW/KV3SRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=fcRNP8jJ; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="fcRNP8jJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=50
	5rhK+elsmWiU1fs3MwwoGHwe7b9tZRevoRsk65ahQ=; b=fcRNP8jJK1mcMFHqhC
	Zhc2c3n4AScqc+sDmqGZP2YwRjnUM58zZdt0m9so6JWYTp5NaQJDit2zY2PQOx63
	RS5rZSR9RR+A7T29O72/SKxIbujUDat4o7pHx2AmKz59IXgpaNMwYiMGc4IvbAlw
	bh29iLT14wgpv4bzRHu2VSbj8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD33wG+N7FqH9M7Bw--.62914S3;
	Mon, 21 Sep 2026 21:57:21 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/2] net: stmmac: fix a divide by zero in stmmac_xdp_xmit_xdpf()
Date: Mon, 21 Sep 2026 21:57:16 +0800
Message-Id: <20260921135716.218420-2-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921135716.218420-1-xiaolinkui@126.com>
References: <20260921135716.218420-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33wG+N7FqH9M7Bw--.62914S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy8Zr1fCFW7Zw1fKr1UGFg_yoW8uryUp3
	yfCa90yr1kJr43Jw4kGw409Fy5Jay0yF47K3W8t393ZF45ZrZIqry3tayYqF17Ar4kX3ya
	kw4Dur1DC3Wqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtDG5UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQEF22qxN8HcogAA3l

From: Linkui Xiao <xiaolinkui@kylinos.cn>

tx-frames 0 is a valid coalescing request: it only stops the frame count
from raising TX completion interrupts, while the coalescing timer armed
by stmmac_tx_timer_arm() keeps reclaiming the descriptors. That is why
stmmac_xmit(), stmmac_tso_xmit() and stmmac_xdp_xmit_zc() all test
priv->tx_coal_frames[queue] before taking the modulo, and why
__stmmac_set_coalesce() rejects the request only when tx-usecs is zero
as well, since then nothing would complete the transmissions.

stmmac_xdp_xmit_xdpf() is the one transmit path that takes the modulo
without the test, so

	ethtool -C eth0 tx-usecs 10 tx-frames 0

followed by an XDP_TX or an ndo_xdp_xmit frame divides by zero, which
oopses in softirq context on the architectures that trap on a zero
divisor.

Add the missing test, which leaves set_ic false exactly like the other
transmit paths do.

Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
v3:
- New patch. stmmac_xdp_xmit_xdpf() is the only transmit path that divides
  by tx_coal_frames[queue] without a zero test; add the missing test the
  way stmmac_xdp_xmit_zc() has it. (Sashiko review)

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e2e680dd980c..276187f50ee3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5256,7 +5256,9 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 
 	tx_q->tx_count_frames++;
 
-	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
+	if (!priv->tx_coal_frames[queue])
+		set_ic = false;
+	else if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
 		set_ic = true;
 	else
 		set_ic = false;
-- 
2.25.1

