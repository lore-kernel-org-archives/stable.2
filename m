Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBB3B52FB
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405895; cv=none; b=dY/wjNbRD+hdNbekKSWzEZIdOtrIEpk/Rn3Gqdk81bmY3iUJ0awUzdEgD9T8ZJ9TxKEsmsEUtlTeLIy4omhHR8CCgnNxSKP6f/Fk/ZZ1HEBCjlWILEKXN5tdtQsql+oJgt+KhMZSYSMFcsrzjjU1WpukiKjjcqoC56XDWblgNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405895; c=relaxed/simple;
	bh=vGaIUsGVpELfxLhZ6ARkyXuPHABoIn8e+KLzq0V48wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QapcdOTjZp+QoW0UYbAQIc1uG1oZuPDGnvTZGuq2rFX+NQK5hZ+wYrLj+8RuiE21qmoJZrLdure5sgWsgWDBeoy8ViAZtlQn+EGpbBCNztGsJHAIN4fMFU8V19S7REHrGh7hwlORFD/034TXALsxLZBbH+QlCh3DeWcaAf2J2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU/AxnSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU/AxnSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29981F000E9;
	Mon, 10 Aug 2026 23:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405894;
	bh=VJjFVcO558EnRxxUOXkzgFzdcAUXKqdfKmM6ZBeO6oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mU/AxnSf+RkvXCa7kMSs7rJih5AfqasOMp7bkNeBqi7i2nwog7Ac/6JWkwTxMosYX
	 TMXH3Rj0ZSH4uMeuQEkplrEkC7u43wa0rGVraKdS0HcUrDNQ2ra1WgmOm1aUChy2UD
	 jkHVlOW7vHVN6va9h5yvM1owj48Wb3AyoZVsFP/VgVgXvElW21YRQXrIKn4oOEoF6v
	 6orzufEC1OcjCt6FNkNIRr9k7u2ow+HlP4Jm8zBB217jQxRZ/k1XQmM5sTsNfeM/3y
	 8VZQ4ptcJZ5lPGMqEO3rkM1NiGb5/LWOtheHji6Vx83Jk5hBVcG5xZJcd38z+MJ+T5
	 BO82nefvT3zWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
	Simon Horman <horms@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/6] Bluetooth: MGMT: Remove unused mgmt_pending_find_data
Date: Mon, 10 Aug 2026 19:51:27 -0400
Message-ID: <20260810235129.3217516-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810235129.3217516-1-sashal@kernel.org>
References: <2026080548-angelfish-scored-d506@gregkh>
 <20260810235129.3217516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

[ Upstream commit 276af34d82f13bda0b2a4d9786c90b8bbf1cd064 ]

mgmt_pending_find_data() last use was removed in 2021 by
commit 5a7501374664 ("Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: d0a7b48ad092 ("Bluetooth: mgmt: fix UAF in pair command cancellation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt_util.c | 17 -----------------
 net/bluetooth/mgmt_util.h |  4 ----
 2 files changed, 21 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 17e32605d9b00..dba6a0d66500f 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -229,23 +229,6 @@ struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 	return NULL;
 }
 
-struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
-						u16 opcode,
-						struct hci_dev *hdev,
-						const void *data)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
-		if (cmd->user_data != data)
-			continue;
-		if (cmd->opcode == opcode)
-			return cmd;
-	}
-
-	return NULL;
-}
-
 void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data)
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index bdf978605d5a8..f2ba994ab1d84 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -54,10 +54,6 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 
 struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 					   struct hci_dev *hdev);
-struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
-						u16 opcode,
-						struct hci_dev *hdev,
-						const void *data);
 void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data);
-- 
2.53.0

