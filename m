Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51394388E57
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096928; cv=none; b=hQza50CQxauDsIJgUwd7G46Z0bUewZbPe74tJ0HLhVmUDEBP/yW9F9lUk1/VsL/jS/WFCYDwyFDZxUu5k2q/X63e6Ge8V7RvhCiSPzz05pARcYyt6x68m9pESJnIWsvZzTMYkn1h94rgNz7vYs3WggFDkjUX9ceu3zyjBKwpV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096928; c=relaxed/simple;
	bh=X77pmgWq3NFw7wMo4iNRfZf3xMlWRmzNPeZJxMc0HYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+OKOwI9Iy+Ag+ywAOH8cIkfu/Eh2q0bO6GUPne8VzHtkdzQCuv2AND3/kI+xKz+h1O8BOdmtyjHwpYAb9FOCLWEsf7tOWqi3B/5dBSBhKwcanACEnAee2aOPJV7OeZZujNL/sdiV+/FmFhU972jch4Iwshqr+ZfyTwXV6yfymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StO3s0Q+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StO3s0Q+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722F91F00898;
	Fri, 29 May 2026 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096926;
	bh=7Ji9131wvN1RIIJjbdj+LH5XI7JHjxS+TJPNbBfgm6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=StO3s0Q+bBvdsD3Go3p9R6uz5UDvCbw606NNSQmFIOtW93qVrAetcfyxB89rIt+YT
	 HJcMgxuvlSx3zewI0IEUyk4msQqeiUk1VeQkIQvj596BbgFiJE09D0sfmam8v3rk5Y
	 RylinF7ojvmkiFQe6x3s2nJlbdmCXcK7qqdmgF3WU3QrW9FpmYWXtgFYVhF+QOqGtm
	 wvVHo04lt5dqLChaSdPp+HW5cIIhnNIV9brHqyGDznXVgPtizocsPnBxYejeooUyU/
	 9WWtPaRKDr0HqYJtivQd50BFMD6aKgEFcv6C6NnJhXNWOpeUZjT0M5P39aMOxQqXNy
	 CR1vfkXdLBtrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] Bluetooth: MGMT: validate Add Extended Advertising Data length
Date: Fri, 29 May 2026 19:22:04 -0400
Message-ID: <20260529232204.1873991-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529232204.1873991-1-sashal@kernel.org>
References: <2026052818-stubble-amigo-9213@gregkh>
 <20260529232204.1873991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit d3f7d17960ed50df3a6709c5158caff989c8c905 ]

MGMT_OP_ADD_EXT_ADV_DATA is registered as a variable-length command,
with MGMT_ADD_EXT_ADV_DATA_SIZE as the fixed header size.  The handler
then uses cp->adv_data_len and cp->scan_rsp_len to validate and copy
cp->data, but it never checks that those bytes are part of the mgmt
command payload.

A short command can therefore make add_ext_adv_data() pass an
out-of-bounds pointer into tlv_data_is_valid().  If the bytes beyond
the command buffer are addressable, they can also be copied into the
advertising instance as scan response data, where the caller can read
them back via MGMT_OP_GET_ADV_INSTANCE.  The trigger requires
CAP_NET_ADMIN in the initial user namespace; KASAN reports an 8-byte
slab-out-of-bounds read.

Reject commands whose length does not match the fixed header plus both
advertising data lengths before parsing cp->data.

Fixes: 12410572833a ("Bluetooth: Break add adv into two mgmt commands")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 94d29c4e5f21e..9bd5615b634d9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8084,9 +8084,15 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct adv_info *adv_instance;
 	int err = 0;
 	struct mgmt_pending_cmd *cmd;
+	u16 expected_len;
 
 	BT_DBG("%s", hdev->name);
 
+	expected_len = struct_size(cp, data, cp->adv_data_len + cp->scan_rsp_len);
+	if (expected_len != data_len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	adv_instance = hci_find_adv_instance(hdev, cp->instance);
-- 
2.53.0

