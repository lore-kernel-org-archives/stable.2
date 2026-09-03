Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB91E4B2CC8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444946; cv=none; b=YDpKvs2C1Juiz0JZt+WTNm9PmoNcU25otg73EsCKhI/t0hM/zYjoVFXeVilhhfTsQ9p310BU3Aw0J9isg/Y+ap+CmNVV5JdoW1eGBycFOywdCcXCN51OO+UC4qyDsvcMgaspaR/JWQweYjeF4OSvHWIBotFixApkCQId57DDago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444946; c=relaxed/simple;
	bh=skeHtgJLRynVjIqUlLcrnBDfrvg0e9Oa+WphmTjXu7M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZjUk6nTdnXPiTXYz7hlHKBo6aeMXJNfoBmMxCaHdaZg4gEUsdVObnBWVs1SDGGdtlJvo9qkB8u7kFdHC+1FQ0CDX7vBXxKFm7lR0DjGAJtzT4qmOw35cvbdUk5JDaS6DuN9nAwRqaj0HtBBdlhxHFalL9PTGsla3PaJgryGOIKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MHowAK9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MHowAK9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33BF1F00A3E;
	Thu,  3 Sep 2026 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444926;
	bh=SNnuJL0moj0uDJLLsuGy4gJ0pUQOZRRTIFGINZw8R4o=;
	h=Subject:To:Cc:From:Date;
	b=MHowAK9k8hewZOpraK0BT5M37u+agUfTVODyD1hE4FPfoaQ+ydn7YdXEci9LtQY7n
	 fzO8bn8fC4IYxg73mCX8lVKj2icy6vVDss2SVkczKHeZ215iy4gG+5r6q5wzkuzDLy
	 wJeMLCXvrrc/bCRlEzAvocRcvQqMkmOFrm00KC18=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_conn: re-enable advertising only for" failed to apply to 5.10-stable tree
To: valentin.kindschi@fiveco.ch,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:55:18 +0200
Message-ID: <2026090318-staring-emphases-67af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ed5fb41d3b6b6e665e7f97fd54bd1f9531c7477f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090318-staring-emphases-67af@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed5fb41d3b6b6e665e7f97fd54bd1f9531c7477f Mon Sep 17 00:00:00 2001
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Date: Tue, 18 Aug 2026 15:29:34 +0200
Subject: [PATCH] Bluetooth: hci_conn: re-enable advertising only for
 peripheral role

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

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 19b7629b1cc1..8de98af2fb58 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1391,7 +1391,8 @@ static void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	/* Enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
 	 */
-	hci_enable_advertising(hdev);
+	if (conn->role == HCI_ROLE_SLAVE)
+		hci_enable_advertising(hdev);
 }
 
 /* This function requires the caller holds hdev->lock */

