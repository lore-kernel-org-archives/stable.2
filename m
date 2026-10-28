Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164025;
	b=Uc+YkHQms7+WDdTglyGeJoMRY9yUH9FePCIuUCWN6P5i1y7/5ZW9c47RImf8Of/38N02
	 5ZNIBSicA8G0n1EVo/IsadNxZGpKZqFznNpYA+bGY9TjaRTrrE8OhQAepsTYdsPxNAf6Q
	 Yd4ZOhrEcRm8BghCZj/eg8Rl9dhvbJoVvaf/310cRW/gpVx9pTwNP5Iq5P8bDqNKfeNSA
	 PhYLvlgpq7huThBB5WVPU6kZkqLia93CgVB4Ep6DL3aLopPrzW7slh0+FMqBzKCRI5U0D
	 /cqL7xH2ZxzyWXu7yG7Fw6gVwCGTddW6YfDEq8otrJRKWPqavI25ljF64aI1Nl6UcYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164025;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Cf9gfNcIiu11cnWlAOGnF/eh2esPSE/DuMDNIb7pmvc=;
	b=egHhrf+vvBWre1BtfWAbmORfhtAReoVmAwOhfEIO16/j1eOupN6atID6qw1ukHNM0KPZ
	 0mGb8IWiTGxL51Y3A+ZiChqyy/fmOnvnw07j7SX30x3+kGsCDwSfL8RQ8ypQ35fzhCjZN
	 2oRHjl2qDCH/vydDjtwURceJtMMu5tIzNQmOKcYokpl3BsASZlLUkiFHTnLkxLivgeMEI
	 hPqxVSiVAouj3Q3d657Zh7guMvwcVy6fI4RDCpjS6mkdLtr/OOC22+Kg2skq0gQwY9A6t
	 Gjlu0NrVsRSoZ95e9iDY2MXpLv/tKIOzBDPJAlLN9G1k7l9czDsChTf1kV4jXGNmcfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WAJYNrW0;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E35606A321;
	Wed, 28 Oct 2026 05:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E35606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WAJYNrW0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Cf
	9gfNcIiu11cnWlAOGnF/eh2esPSE/DuMDNIb7pmvc=; b=WAJYNrW08Kv4DQ0T5U
	3oFGq+opfUHtXHQceZdk3HsYgncdUegaHI6CvBCb4RBbslMRpOIi79FWW7AyL9pU
	2L64SWxJcjFkvLcbwBV6aix+fJpb6PdNdT/Y3YeG5uOdQ/RTpmQu/z1MkmQj7ypp
	MeraIcukohG2xrb0/HqJ6jzI4=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnkXTtguFqCksJCQ--.34486S2;
	Wed, 28 Oct 2026 13:06:53 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Free unlisted commands on queue failure
Date: Wed, 28 Oct 2026 13:06:52 +0800
Message-Id: <20261028050652.134403-1-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgBnkXTtguFqCksJCQ--.34486S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryxZw1kJF1fZw4rJr45Awb_yoW8GF15pF
	Wvq3Z8ArWUJF47JF4xtay8uFW7X3Z5uFW2krZ7Z34fArZ8XF4kZry8KFyjvr1YyrZ7Jay0
	gF10gF13uwnrAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYa0PUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzg3uKWrhgu30jgAA3a

mgmt_pending_new() allocates a command without adding it to the pending
list. set_phy_configuration() and read_local_ssp_oob_req() use this
helper before queuing synchronous HCI work.

If hci_cmd_sync_queue() fails, the work item does not take ownership of
the command. The error paths call mgmt_pending_remove(), which assumes
the command is linked and calls list_del() on its zeroed list node. This
can cause a NULL pointer dereference instead of releasing the command.

Free the unlisted command directly on queue failure.

Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3b9c82bd2f02..66f167849942 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4432,7 +4432,7 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 				      MGMT_STATUS_FAILED);
 
 		if (cmd)
-			mgmt_pending_remove(cmd);
+			mgmt_pending_free(cmd);
 	}
 
 unlock:
@@ -8619,7 +8619,7 @@ static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
 				 read_local_oob_ext_data_complete);
 
 	if (err < 0) {
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 		return err;
 	}
 
-- 
2.34.1

