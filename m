Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658FC4D98EB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780982; cv=none; b=ZsAGKEL5gdgSC67wO3l37U1TaWy199WByMLKSWhLr9rzFRAbzVDAF2qWJQDcxiE/NQMya7Ms6I0vQOIjDyf5RGrkaNyOUJyNYaYssLWrS5BXacaAm7zltYXa9A+Ow+L/3mUcQ1NRI+WVOw4j5dKTFrpodSs6j7ZaGMRpgyPMwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780982; c=relaxed/simple;
	bh=MVHzybsO2uwYRnwGgENNJ9xng2u97sYMQjPRp7mnUVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4p/wYCvBU+BVQuHVhnE487O95rXX0lfK5W41piyMjFcRZZscuY4zxKg5VyyvA8zBvjMS+pwxw0HY8uAP2t77+FUskfO6tiVZId53pF4Mq88LE6eAatvSuuAY4X9Hsn4pW3ipA3MR1LkwvZ+iG2/qiWe0Vv3kPpXJ9/LjIZeRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egs6tOut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egs6tOut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10461F00893;
	Wed, 30 Sep 2026 15:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780972;
	bh=iflOKy3mP+e60d3VBU8bCH7ijzebTLnjdy/aioZVhTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Egs6tOutJJWTHxFJC6zr9iGnlSxsMXjIK5lq/JyPbB6Qy9pwbTBZm0iTN66EEqRoM
	 1zrgwjDk2IVJSD2exIhZxP04tu9vIfUorsOZd2nmJV0uL6rPaYXh/I5nF28E/meoeT
	 LWIdOXrZyvIt18FwJQ6Zao8h7+3BB+6Fxden9m9GGN2nLtjSSgvr0sR6/6VRH1oyjG
	 H9CTRndICWXQn+bPSPiH9SnfQVdXchB+K93/URG7BvhwdV0eyn3xFxgMaToklOAt7g
	 z7AV871E9zAIoBry3FPmqFtAGU3eOYPn3VfDPHUa5gFTXRL97c/soJO8y35COkMLLI
	 qT9WYfX7PBhug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Bluetooth: mgmt: fix race in read_unconf_index_list()
Date: Wed, 30 Sep 2026 11:09:30 -0400
Message-ID: <20260930150930.2341782-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092918-appraisal-strive-14ac@gregkh>
References: <2026092918-appraisal-strive-14ac@gregkh>
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
[ Replaced unavailable list_count_nodes() with a list_for_each_entry() counting loop. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c53b128adb7bd..6173247dd45d7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -500,12 +500,10 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	read_lock(&hci_dev_list_lock);
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
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

