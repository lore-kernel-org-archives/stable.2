Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C323793DF;
	Thu,  6 Aug 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038059; cv=pass; b=fkmWQv6lxGNnI0hPV/lyffFZVxzvakAjHs4H9P+YjnSUZdgBPdmTEqWSU6w+zFKfIK5BB/aGLhwTIxyajXmOYAtHoJiJVxspnUcuDkNKPN7LNrNq+TBpPcDOD4B+ooprHbEJ+54/jBO18DpAFmVr5nnDcW/439AcIMC74GQzrHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038059; c=relaxed/simple;
	bh=pNk14jUouuqTN8G55ZLL3RQLoiul/rXw/gr7y2Th8sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsLqSWtItZr8Isg5viRJa64OuCvnBg/ROsaCzBTU60FdUWBwT1PM9R5fFtBY5ZkUDpwlxkeCoW/v+VhpxGpQYWa1m4RlpJPQ5aAoqDMM+iJjEtjE0PtIPBboyz1z28avSESe/IYrO17PX0349lm2PCGaL9DtoLvnLIqyklzkRCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=a85xBBkI; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="a85xBBkI"
ARC-Seal: i=1; a=rsa-sha256; t=1786038052; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=j9chQyil08vtOjaKNbMKAGcMQu6gcY4g2A04qd3k+v5k0+u6WJWG+1hhwTmzW5Ty6vRHHo/Skw80RsF4WBkSf9WtL2mU2vLFyYu/+GONO4EuMMBkSlFQOW7UEeyAOFRlBJlxc/BJ+DjoouD1w4ad7Tb5BhpF8z3KYyucHhvD1UI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786038052; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MAkanyA7Ec47Z4mPgoWZ4lZFFh61EbJbxkbpYqeAcqQ=; 
	b=Lelw7360qg/vA9qtpjVNFNUwqYNzfRLcch1T+j4aw6RYqLEJ+VUJH+iwInunBKnljvbkkU/CMxUH7KnWxCNLcBdMM6RV1745v4iu2WsohnCTgnMd6CdGVYmh1Gy26qCuz0faIkTI9KXW1C+Yqp9dBdb/z8iI314MjWg1uzRkDGs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786038052;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MAkanyA7Ec47Z4mPgoWZ4lZFFh61EbJbxkbpYqeAcqQ=;
	b=a85xBBkI6s7o3wMhoJMZkeizL7WIlNpJNPBr97Vb51+C1zyGbwtYH28juNE58ATr
	6eQFLQ28vD5aZulr0b/wYyMrflsOefVFusYYxhPjdJGzYAX4klfnh9rgzjKw6Z3Z51n
	6RMrncXD4yLdS0qJzDHOdnbVqzwtB6Qco8cO9wZ0=
Received: by mx.zoho.eu with SMTPS id 1786038049322706.2931247516475;
	Thu, 6 Aug 2026 19:40:49 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: reject HCI_CMD_SYNC params_len above 255
Date: Thu,  6 Aug 2026 17:39:53 +0000
Message-ID: <20260806174001.267127-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

mgmt_hci_cmd_sync() checks that the message length agrees with params_len
but puts no upper bound on it. params_len is __le16 while the parameter
length in the HCI command header is a u8:

	struct hci_command_hdr {
		__le16	opcode;
		__u8	plen;
	} __packed;

hci_cmd_sync_alloc() assigns one to the other:

	hdr->plen = plen;

	if (plen)
		skb_put_data(skb, param, plen);

so a params_len of 256 leaves plen at 0 while all 256 bytes are still
appended. The frame handed to the driver then declares no parameters and
carries 256 of them. On a length framed transport such as H:4 the
controller takes the trailing bytes as the start of the next packet.

The mgmt socket MTU is HCI_MAX_FRAME_SIZE, so params_len can reach about
1KB this way. Commit 03f1700b9b4d ("Bluetooth: MGMT: reject malformed
HCI_CMD_SYNC commands") only made params_len agree with the message
length, a value that fits the message but not the header field is still
accepted.

Reject params_len that does not fit the header field.

Fixes: 827af4787e74 ("Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
Checked on a vhci controller, with the emulated controller printing what
it receives on the transport.

Before:

  sending HCI_CMD_SYNC with params_len=256
  controller saw: read()=260 bytes, hdr.plen=0, params carried=256
  first params bytes: aa aa aa, last: 5a
  HCI_CMD_SYNC: opcode 0x005b status 0x00

After:

  sending HCI_CMD_SYNC with params_len=4
  controller saw: read()=8 bytes, hdr.plen=4, params carried=4
  valid: opcode 0x005b status 0x00
  sending HCI_CMD_SYNC with params_len=256
  HCI_CMD_SYNC: opcode 0x005b cmd status 0x0d

One thing I left alone: hci_cmd_sync_alloc() performs the same truncation
for every caller, so a guard there would cover more than this one entry
point. All in kernel callers I looked at pass a fixed sizeof(), except
msft_add_monitor_sync() which computes total_size from the pattern list a
user supplies through MGMT_OP_ADD_ADV_PATTERNS_MONITOR. That one looks
like it can exceed 255 as well, but it needs a controller with MSFT
extension support and I have not verified it, so I am not claiming it
here. Happy to send a follow up for either if you want it.

 net/bluetooth/mgmt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 167d75e34526..c16b0b80c193 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2668,6 +2668,14 @@ static int mgmt_hci_cmd_sync(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
 				       MGMT_STATUS_INVALID_PARAMS);
 
+	/* The HCI command header carries the parameter length in a u8, a
+	 * larger value would be truncated there while the parameters are
+	 * still appended to the frame in full.
+	 */
+	if (le16_to_cpu(cp->params_len) > U8_MAX)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 	cmd = mgmt_pending_new(sk, MGMT_OP_HCI_CMD_SYNC, hdev, data, len);
 	if (!cmd)

base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
-- 
2.55.0

