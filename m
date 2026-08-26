Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042C46D096
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766498; cv=none; b=h4sZRsTAMgRN9FE1v2yKH3g4XkqvQPHh725A5phoXe2Kp1LZS/sXHRQ1ymhdjBRDCHb4hBU9B40zJeGcCPgFFa8k8YtBrvYfSiTbyXFjL3o2woi6pLkQuEKGwOwM9MsbF6rUafUvvcgyFZOjybPPAZjjk/oMgJLuhZWtdQwjBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766498; c=relaxed/simple;
	bh=7s9QdydL3BOO9IDNHJ2BJJKkEglO7QW6HP6E5wVqZb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giD1oL7gcdzNgEWm21dVwXqEQVp4WzMNgxQHemaaXJzSYSl0ja/c7pHB/g+RN/LVFy6AEtbylkG90WthN/rUus9ywT/yJE8ldCfAOVk4xWcb77djbfOMe0IoFaHGp1DNfYQF3X4o9G7Iv6Pgvw6aUa37sGcSEIyKsbhI92tvsFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkZUrjg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkZUrjg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500181F00A3A;
	Wed, 26 Aug 2026 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766477;
	bh=Y4oKnMjDHQVRuvLSLAQPjxDtVI4rBTQqDjuvf0sU81k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jkZUrjg+4IQEy1rmNOjI7AQ5g/kLQKXNQNA5GSnh0Gz0P3hRfoI8OB2GHgbhP5dip
	 ScW9CykaTLQ3cRdwXmVZql6qmLCoGsEZqfycbehtwepvrOCYkBBoRTBmjbZnpau+Oj
	 dmA4raxV1hHYIW9RaQnQ1T8gBWgxJTHiKpW1MkUJeupvMVVXQQE1BE26qbeXSk0kjM
	 arTOS34rOA3DbVOW5ukohppKShv5ylCjZ9EyzceoLlqaY26+7A8L9OnTUqvovyJea0
	 3eSO6yeeaKm8CtbA4gcQMQsJ2xZQaRxcSvM598CiOUnb5mF/YJ9C9n/O9iu9lx89S3
	 LK67vdZmYH3sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()
Date: Wed, 26 Aug 2026 13:47:54 -0400
Message-ID: <20260826174755.2489121-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082511-unpadded-identity-f2f9@gregkh>
References: <2026082511-unpadded-identity-f2f9@gregkh>
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
index ec99b08125806..62d53d1743bfa 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6239,7 +6239,7 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
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

