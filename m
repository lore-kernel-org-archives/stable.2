Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD148989F;
	Thu, 17 Sep 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647894; cv=none; b=kaOjoahl+lxv3Pr5FSnaGTf0ZTkMaN2WRrhtisMFfMDlXYSiOZ9A3lz9p2K6/RTvelND3F+V97uacU52Jmti11BYh/3PZtFKhi6/LyJ2ULbUxK8miAooWpg0OV4nJVIGv3TpdybzKeVNHnN11d3Nk5IP1MvSxStuBv3TU3URpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647894; c=relaxed/simple;
	bh=ZVaLZX4L8uLGmkbKP16kYoloUEcOdLrpfEcnDaaf3vw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pE+QtKoRs2Z0RgEQomN7r4PSVx62OQMxVLsqgDMhERB2ZI50ZCyrPyhmQAdxKlhy0U4ie+8vctw95ILGVPQMgwYUIfMmUkQG+5FWXqD04eosRF1gzoCJmhdA8gT4KPYPRbBLRLc3bv2ilKUaCitedV7krJoHYxg3bU+nPA/giwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=AO2NsmMd; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AO2NsmMd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=O6
	jnzeyBJkyxD6laQjv8cRGwY5hK8lmL8YHPVL9lo1c=; b=AO2NsmMdZ7W4ZD3ukP
	9fmQRKpjIJ+ABwSV+oZ0QEwYUUeGZRLguPdPzkHC2ReBynKUwLdWIvVpl+LmZzQO
	8qPUdr/sm5jleOCUucUwXUJq14y3jRbTj8ef0Y/sWrcYrOhebpEhbISKrSbx4o4o
	tTCDLAUaKZE7YRT+kOTlwqTzw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgCX3_aW26tqCBLDHw--.42583S2;
	Thu, 17 Sep 2026 20:22:47 +0800 (CST)
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
Subject: [PATCH net] net: stmmac: fix the invalid VID programmed by VLAN perfect filtering
Date: Thu, 17 Sep 2026 20:22:45 +0800
Message-Id: <20260917122245.1338365-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgCX3_aW26tqCBLDHw--.42583S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1DAw15JryxAF13Jr4rAFb_yoW8Zr4Dpa
	y7Ca4vkFyqqF17XanrKr40vayYq3y3trWYgrWUKFWfuF4UGasIqrW3KFZ5uw47ArZ5Xrya
	ywsrCw15Ca4qyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uo5lnUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRiieWqr25gm9QAA37

From: Linkui Xiao <xiaolinkui@kylinos.cn>

for_each_set_bit() leaves its iterator equal to the bitmap size once the
loop terminates, so the 'vid' read after the loop in stmmac_vlan_update()
is always VLAN_N_VID (4096) and never the last VLAN ID that was found.

Cores that do not support VLAN hash filtering (dma_cap.vlhash == 0) fall
back to the single VID perfect match filter and hand that value straight
to the MAC. vlan_update_hash() therefore programs MAC_VLAN_Tag with
VID 4096, a value that can never match an incoming 802.1Q tag, so the
perfect filter ends up discarding all VLAN tagged traffic. Both
stmmac_test_vlanfilt_perfect() and stmmac_test_dvlanfilt_perfect() walk
this path and fail as a result.

Remember the VID while iterating so that the last active VLAN ID is the
one passed to the perfect match filter. When hash filtering is available
'hash' is non-zero as soon as at least one VID is active, so
vlan_update_hash() keeps ignoring 'pmatch' and nothing changes there.

Fixes: c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if HASH is not available")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 62c3441911e7..af2d38a2bb3d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6844,13 +6844,13 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 		crc = bitrev32(~stmmac_vid_crc32_le(vid_le)) >> 28;
 		hash |= (1 << crc);
 		count++;
+		pmatch = vid;
 	}
 
 	if (!priv->dma_cap.vlhash) {
 		if (count > 2) /* VID = 0 always passes filter */
 			return -EOPNOTSUPP;
 
-		pmatch = vid;
 		hash = 0;
 	}
 
-- 
2.25.1

