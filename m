Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558E471263
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768168; cv=none; b=j4yAOC3383mhn/dUTn3jg0HeViz0xPK5YpWCzGeB/TT2PivcvptsOV0IZ0JnsV+Sy/NUc6AeDhQtO6WeIUCY4f5y+60XgIv2Ek9CSSR22pT6hhZ/101HGKVIJbXA4XrUSx6/Os1GJY/B736ney034mInHlPps5eskTk2kXzN73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768168; c=relaxed/simple;
	bh=npY9k7AFnw82SreTQKFdfsy2K0Ycvk3hlIx2MeJRqig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8HT+DHOkMUitZMYbQ0utJGpRu4BXShIO4anK4gHnc866dUDmqr+W59afYschpJ0UG/PPPkMsS1bo//r1cExjaUw2BLZNXW2VgbSsguAiRXJyKWynfsdJZGlxWbfAT2EJEjlo40CPAXskPHpQ/LMgqgt1JhdHTCh74UQ4eX6xTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U28MHvn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U28MHvn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39E61F000E9;
	Wed, 26 Aug 2026 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787768150;
	bh=vK2XqGu1U+sANg3QS1AP3a1I3jF5cd5YaVm1sByGs3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U28MHvn2la6JdyIlxJlnjjiGBB5vfQrH0Ga99afD/ckgP2hPz8ldrigpjqHLDoqbN
	 t/IAQ5qXZvWxk8wNZxXkYfCATxT2zIWmknJKAYxrjnuN5uVu653paKYwO4sVMU1zi5
	 ynTE9o8JlC3IdLh7luIqafATO2T5DQdZhL2XNbbq3S1973gBV2CnJ4XQ6E2ujbTeXk
	 8wTIRjRffLj58RYStSO+bbe9ATUIStGBFxnpDD6AURnu25OSgp57rlxEJpftYpHRCy
	 LKVO9vQze+E51fHuDRFFo9/4eeI1vZnPCpIR4UsbMKTtdwVHvuWy0iKJU7nGZqKOd9
	 9pps0ldhy7LTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()
Date: Wed, 26 Aug 2026 14:15:47 -0400
Message-ID: <20260826181548.2868994-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082512-chimp-sixties-ddb1@gregkh>
References: <2026082512-chimp-sixties-ddb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

[ Upstream commit da0186f19a7433d3d5607b0f61e9a3de17d1f721 ]

Use bt_dev_err() instead of bt_dev_dbg() to log error message in
hci_update_event_filter_sync().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: f57b399c4fa1 ("Bluetooth: hci_sync: Fix accept list UAF during suspend")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b6a69898ebc47..c16e1cea19076 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6038,7 +6038,7 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 						 &b->bdaddr,
 						 HCI_CONN_SETUP_AUTO_ON);
 		if (err)
-			bt_dev_dbg(hdev, "Failed to set event filter for %pMR",
+			bt_dev_err(hdev, "Failed to set event filter for %pMR",
 				   &b->bdaddr);
 		else
 			scan = SCAN_PAGE;
-- 
2.53.0

