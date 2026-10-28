Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163372;
	b=Df6XKoFvhtATip3Mzi+5EIhD9GiC7QMquCSIrX/0lGwFuk7jD3O+DiigiqsjDk5NhFUz
	 Hj7qByFomMgmYicQBrZhqXtCCEBytuXAs1fBk6tsrWQLU0wiZVMZ6235MkCJ9Ay+iDbRB
	 8QLmbrPRlufrlPB+/EVgfR9lEf1VhZJO44hr1ifGYMvNZfj76NUb7qaT5Puq+EeRyLSPB
	 6A/fAM711fHtMphfLcuqi5XGBgLxtR/Z9vQeuRpaZ0trp0dtr/5l6eZDGOD3CJzKrgz8b
	 etpL6mb77xR5+r7JbBf92jPEMAkNIv0TT5YnSRTr3H63M8+Cgct3oHasSf9UXmlJedA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163372;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Rr+qulPkRBwRXBTuvViw2Y1eDQVUou2yE76Q8cgnSGw=;
	b=bgHrL07tVweygGhkFALmtTcWsscaNiLvDvzRxQcWY/cN6QlYYSu5foQ67YZhMX/CtMB1
	 DfGYecZgvHdS9BtO3bvMvhoLY4yCf7AG9/FDnUT7q1TVcqRR5KvYWQ03DtbNRq8i29NiT
	 lBIzTihPeKB9RGAjS+G658leKc12x5Y4jxK4lkwV06OmjvSGIUvLfIKuN8UiQha4W980h
	 OFTxCMj75ipzvqHBFE/EhDotg5o891eOR8/cfuTqp0scZLYkpgwP5TyTbCk1mNNJprlgO
	 FGifW3u34jkVwD/v34rhO1fLh8jZMGYyamnJwKLdu+n74oTrC0aZqJMK1dniIbkB2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lHPHtfZU;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B8606A320;
	Wed, 28 Oct 2026 04:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 552B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lHPHtfZU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rr
	+qulPkRBwRXBTuvViw2Y1eDQVUou2yE76Q8cgnSGw=; b=lHPHtfZUhPuTHUYNen
	ILBSWiVgAaplTgtelF0+kcSM3d/CIJzRazPHwGp6uvsG14cQcO/WXXSI1N1Zqdl2
	Bl3rARbF8KIuT0Hwr0anCDn5fBgVCN27g47tr9/F9q0eFSFI3ZG54we2vwFw/ZwD
	zKnJ4WEfREhV8XLvkZ/eN8Z68=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v7lHgOFqeBlWDA--.52132S2;
	Wed, 28 Oct 2026 12:55:36 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <Ariel.Elior@qlogic.com>,
	Yuval Mintz <Yuval.Mintz@qlogic.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] qed: drain slowpath tasklets during teardown
Date: Wed, 28 Oct 2026 12:55:35 +0800
Message-Id: <20261028045535.110688-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7lHgOFqeBlWDA--.52132S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryrZrWxtFWxKr4DJw1UJrb_yoW8GF43pr
	srGayv9rW8Xr40qanrAa1jqFyrW39rtFWDKrWkJa4rWasYvF10qr1kAryruFy8tr4DWF13
	tFy7Ar1rC3Z8GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUzV8UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7whFf2rhgEiv1wAA3m

qed_nic_stop() disables each slowpath tasklet before freeing the
interrupt and status block resources.  Disabling waits for a running
tasklet, but it does not remove a pending tasklet from the tasklet
queue.  A pending tasklet can therefore retain a pointer to the freed
qed_hwfn and its status blocks.

Kill the tasklet during the final slowpath teardown so pending work is
removed before the resources it accesses are released.

Fixes: fe56b9e6a8d9 ("qed: Add module with basic common support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 28a8a2b9d501..abe8a841b277 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -833,10 +833,10 @@ static int qed_nic_stop(struct qed_dev *cdev)
 		struct qed_hwfn *p_hwfn = &cdev->hwfns[i];
 
 		if (p_hwfn->b_sp_dpc_enabled) {
-			tasklet_disable(&p_hwfn->sp_dpc);
+			tasklet_kill(&p_hwfn->sp_dpc);
 			p_hwfn->b_sp_dpc_enabled = false;
 			DP_VERBOSE(cdev, NETIF_MSG_IFDOWN,
-				   "Disabled sp tasklet [hwfn %d] at %p\n",
+				   "Killed sp tasklet [hwfn %d] at %p\n",
 				   i, &p_hwfn->sp_dpc);
 		}
 	}
-- 
2.34.1

