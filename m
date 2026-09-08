Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF69335BB4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883283; cv=none; b=VOyP9Y879SOuOuDmSfEYT8BHGyYD+9N3SrNCxIyFUjvWz50AOKbFJKw0uOkL3xEqKsNDnO7YfMQqtMC8s8RPbIqjkirqn90TVu6Cxv/4ZcRO+iQYaixEQLtziER7SZ2WGpCXpbKAXq0caqaf2uJGZvK3XN1PBuEM3qMxrh5JzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883283; c=relaxed/simple;
	bh=nOD/5+1qmCzN8u2SgUGwsaZB4RKhzCfZLbs3t9txonA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXxei9Oju4VWrgoGP0PqmfwiULOPAjFM3TH/Qm/VZi9vJo+zvGxgqNWlV2WVF2rrhYuoJh3pOPBnJ652K5SPMCC4riKbUlJNDWRkAxuWjrUNHZuvHyNn1bKbXPXUg221hlpYbe0c9+ZZFE3uwSuv4RQfniAwjlGcQYIZnRBxIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN1M0asi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN1M0asi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627221F00A3D;
	Tue,  8 Sep 2026 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883280;
	bh=+pYMCjjdHVO7KIsfMR/rph9xbSAiz1xaEBHjbGRtAxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DN1M0asiFxijJegaQ29uDw1ubQzlEWsxutAksKRFRV//qoSgeENKDnEr+GUvqi9fx
	 7HcjTzMRTKOu/gUrc7zfgd26qMGNY5RWcThYdqfgQD1AdjHZC9h7ep5dS7lx3ZaWDC
	 v9wtsQ4is57fpZXZ4mFaVyUCUFITAd+m8QLufy0qgzkbljxVwid+LPFZ+nebLdtpyG
	 ZViei5u2bODhO0AKk+Ry08NOtkBQZ2Df48i3V3RqaEDb+E1R684dgMs8if6CPllMq3
	 cnuqOmUz35bxrhQoGP6GUMS05bGBKg070T+jIaOOMAnUcVMsdS4DdCrnqEx7GD6EQa
	 N1Vzo0B2pEDSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Valentin Kindschi <valentin.kindschi@fiveco.ch>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] Bluetooth: hci_conn: re-enable advertising only for peripheral role
Date: Tue,  8 Sep 2026 12:01:18 -0400
Message-ID: <20260908160118.2547266-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160118.2547266-1-sashal@kernel.org>
References: <2026090318-moodiness-majorette-1570@gregkh>
 <20260908160118.2547266-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Kindschi <valentin.kindschi@fiveco.ch>

[ Upstream commit ed5fb41d3b6b6e665e7f97fd54bd1f9531c7477f ]

hci_le_conn_failed() unconditionally calls hci_enable_advertising(),
although its own comment states advertising should be re-enabled only
when the failed attempt was made as a peripheral.

hci_le_conn_failed() is reached from hci_conn_failed() for every failed
LE connection, including outgoing central connections. For a central
attempt this enable is redundant: hci_le_create_conn_sync() already
restores advertising via hci_resume_advertising_sync() in its done:
block. Because hci_enable_advertising() only queues the work on
cmd_sync_work, it runs *after* that resume has already succeeded and
set HCI_LE_ADV.

The resulting HCI sequence, captured on a BCM43455 (no LE Extended
Advertising, so legacy advertising is used):

  LE Create Connection                     Status Success
  ... 13.8 s, peer never answers ...
  LE Set Advertising Parameters (0x2006)   Success   <- done: resume,
  LE Set Advertising Enable     (0x200a)   Success      HCI_LE_ADV set
  LE Create Connection Cancel   (0x200e)   Success
  LE Connection Complete                   Unknown Conn Id
  LE Set Advertising Parameters (0x2006)   Command Disallowed (0x0c)

The last command is the queued enable from hci_le_conn_failed() running
as a second hci_enable_advertising_sync() pass. It clears HCI_LE_ADV
(hci_sync.c, "Clear the HCI_LE_ADV bit temporarily"), then sends
LE Set Advertising Parameters while the controller is still advertising,
which the controller correctly rejects with Command Disallowed.

The disable-first call at the top of hci_enable_advertising_sync()
cannot prevent this: hci_disable_advertising_sync() returns early
without sending anything when HCI_LE_ADV is clear, so it is a no-op
exactly when the flag is wrong.

hci_enable_advertising_sync() then returns without sending LE Set
Advertising Enable, so HCI_LE_ADV is never set again. The legacy
software rotation loop re-arms hci_schedule_adv_instance_sync() every
HCI_DEFAULT_ADV_DURATION (2 s), and its "already advertising" shortcut
tests HCI_LE_ADV, which can no longer become true. The command is
therefore retried every 2 s indefinitely:

  Bluetooth: hci0: Opcode 0x2006 failed: -16

Observed on a gateway as 5326 occurrences over 3 hours, ending only when
bluetoothd was restarted. Connection attempts that succeed do not call
hci_le_conn_failed() and never trigger this.

Add the role test the comment already describes. Both other
hci_enable_advertising() call sites reached from a failed/closed LE
connection (hci_cs_disconnect() and hci_disconn_complete_evt()) already
guard on conn->role == HCI_ROLE_SLAVE; this one was missed.

Reproducing needs legacy advertising (ext_adv_capable() false, so the
software rotation loop is used), simultaneous peripheral advertising and
outgoing central connects, and a central connect that times out rather
than failing fast.

The Fixes tag points at the commit that introduced the advertising
restart into this path for the directed-advertising (peripheral) case;
the role test that the later commit 0b1db38ca26b ("Bluetooth: Fix check
for direct advertising") added to the sibling paths was never applied
here.

Fixes: 3c857757ef6e ("Bluetooth: Add directed advertising support through connect()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0bbf025626902..c5b7197240c33 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -790,7 +790,8 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	/* Enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
 	 */
-	hci_enable_advertising(hdev);
+	if (conn->role == HCI_ROLE_SLAVE)
+		hci_enable_advertising(hdev);
 }
 
 static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
-- 
2.53.0

