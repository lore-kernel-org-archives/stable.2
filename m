Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130EA489FD3
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810053; cv=none; b=cGMGiJ8fTAwGC+Ye9YD188KeLUZZpYcbU+qfadgog/LOTG4xPRr3K1FM53Y+L5xXQytgI7HnrTw3q5AWhqn5aLjPzJyd4VvzY33siwzffjFrvxMqqMV14dEUV3dFQmBwhikMZBJSutG7rUVCXGAbo5fasgUUm50xggYiWQk2EUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810053; c=relaxed/simple;
	bh=ivf4MlT/LO9LTO00BTQDTy+7EP0H4UIz1Z8SMlhM8Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7RPNY0beNd2gLhJ+A3cHBuBN5Hb6HnfKRU7f1kIrNxtvLHWmBrjmcCgaitdCcuYfz6PXhTlDjI9CfjWPsBCSnrL+XPMabrrhpR5QFnAfD1HSoHNvGPX+2rMfUXlRCl9fL+2gAdBYc04sxasPIHtvQanR4QDop6TRb9RSAb5oGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWNwjyxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWNwjyxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF271F00898;
	Wed, 30 Sep 2026 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790810046;
	bh=IuZiDpn7P/ovAiI/c+IAFTl74XM/yxMh5v7hmEI4MjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWNwjyxdg3VCuMWILMGoh/DigZA2UfrGj7vdEZaC6FkN08gsIMd/zmIea1Lu70kf0
	 D85E/tbGQoEBMQ9CtQsaBMOCCr1tVAapQ0NWHWjMsW7N1mWkfaiPlWZGrGVOrGJ5k1
	 nEua/Pu9wqLHaR0egvT8/rVdjGlCJzGMljVX/f3QLPEXcvVtS7VXo3zJMUBG8SHbGS
	 /Qzux/+JOW4bU48YS+my0EQKSc/FMqH8QdxrfcKcUO1NtJ3b6eF0eFfyvDWMFASLNe
	 99EHUHf6kpdlfj1qyGF5iMGrTyzJIfuFWg+JP/IoNXmWR/tm5YrTgU5yASInuaKkf4
	 pkvA804Kusltg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] Bluetooth: mgmt: fix race in read_unconf_index_list()
Date: Wed, 30 Sep 2026 19:14:03 -0400
Message-ID: <20260930231404.600931-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092958-commerce-gangly-faea@gregkh>
References: <2026092958-commerce-gangly-faea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit b5dbb41b212c50c095a4dbee3017a84fe94f033b ]

read_unconf_index_list() counts unconfigured controllers before allocating
its response, then checks the device flags again while filling it.

hci_dev_list_lock stabilizes list membership, but it does not serialize the
per-device flags. During asynchronous controller setup, the worker can set
HCI_UNCONFIGURED and clear HCI_SETUP between the two passes. A controller
omitted from the allocation count can then become eligible for the fill
pass, causing an out-of-bounds write to rp->index[].

Allocate space for every device on hci_dev_list. Since list membership
cannot change while hci_dev_list_lock is held, the response remains large
enough regardless of flag transitions. The reported count and response
length still include only eligible unconfigured controllers.

Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ replaced unavailable list_count_nodes() with an unconditional device-counting loop. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3647e51d31062..eb5217b79e598 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -454,13 +454,10 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	read_lock(&hci_dev_list_lock);
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_PRIMARY &&
-		    hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	list_for_each_entry(d, &hci_dev_list, list)
+		count++;
 
-	rp_len = sizeof(*rp) + (2 * count);
+	rp_len = sizeof(*rp) + (sizeof(__le16) * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
 		read_unlock(&hci_dev_list_lock);
-- 
2.53.0

