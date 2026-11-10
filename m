Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272859;
	b=h1SSNLO/XZdiL8Jqvm3UI3xoGR8HpNPACDMoVq0RfViW6Eyd4ORxB8lwH0JY0CGKtBfM
	 Iqn/cDUOC3DzBuXM89o+5ldzuQyGtuX+1Y33jqh8o9WCkQ7ngaLmcKYywiOfgIbH7/yva
	 SXzXZcpjX5rjyTdDIrxq7ZLm8juQEFF1O5gLpgHy8HRX59WYEl51WMUTfuCdg3SuqO+si
	 7Z/34H8P8nDFeCi28Wm3AKjWsxRti3s1voXrGTqMPcddncmmlPDq3DVb0XhMr9Czc47zC
	 5vPXDSSPsCQD4I6rJ9RB/J+dVyEwsVRYkWy01XUyUxF8eRupxw1LBp5rL2ehoL+QMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272859;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7J3shRCbi3FUB7yp6CjaBBjLzLKb5PLfzLKFb+i5i9k=;
	b=IC5yavTPsIVj4pTJFqluu9yAHEl0QDSEip3YCAQPPsIKI81PR80dKaTfWZCV2MhnZsb9
	 VLZao14GQE6zaEplfynxTmarNgm1oel99lb/wg0PWk3bwzxIGFj4JFGG/NSV9PIXJKBSX
	 T76YbkNuX+RtMBa1En4r5Gu+9wJcpsBc+UnFqgyIT8rRn+6SuLtdbSHKirxmC5J5AXOF7
	 2kmbphMuC5GffxUD6oVR4h4/oMP3oIqXTBxp54vs0ZM7wwRUgYU85I7jRddc1KnbhHwZo
	 Wnx3RaRbrq9Bv6Q8UrCU9GllzqlpGdgfZH9PFz8aaYKPo6z2ZudV3b12wk9xCWqNWlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEbO+HfT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E29606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEbO+HfT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEF21F008A1;
	Tue, 10 Nov 2026 01:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272859;
	bh=7J3shRCbi3FUB7yp6CjaBBjLzLKb5PLfzLKFb+i5i9k=;
	h=From:To:Cc:Subject:Date;
	b=TEbO+HfTPtVfSckKb+vNbh9xbIsPne0zdnNAR9JfL4zKPUExlr8jD780d5RbHkSty
	 6LV/1roTokxWSR9OHhaIeDdvM/pdJSIrvzCgCurdujEiDBndrOVgxMQO7w/UAaEn9R
	 d0M2aiCmT/S9P1FexkWyy3qhv9jXM6XHnY77kNX6U00b6BfkelK7JjHcDhiEGsIUru
	 E655fDMZ533cgn5bjquvJMe+i36CqjR4Cgk9aFY1Zr68swmoJGlTa/PYDVXrpIU7Ue
	 mcyBvGLRKAjhy6wP0r9q8jVtKxDsACpH7T007bcR6+RyZlpBgDSbEalfeyvFUjbcaW
	 rawhK7Yh2E+Pw==
From: Sasha Levin <sashal@kernel.org>
To: valentin.kindschi@fiveco.ch,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: hci_sync: pause advertising for the scan address update" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:37 -0500
Message-ID: <20261109200737-failed-6.12-56ed6b127a27@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 56ed6b127a27c418dc2daa3fd076539d8fe69c4c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200737-failed-6.12-56ed6b127a27@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 56ed6b127a27c418dc2daa3fd076539d8fe69c4c Mon Sep 17 00:00:00 2001
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Date: Tue, 20 Oct 2026 12:51:50 +0200
Subject: [PATCH] Bluetooth: hci_sync: pause advertising for the scan address
 update

hci_active_scan_sync() programs a non-resolvable private address with LE
Set Random Address on every active scan start.

BLUETOOTH CORE SPECIFICATION Vol 4, Part E, 7.8.4 says the controller
shall return Command Disallowed (0x0C) for that command while legacy
advertising or scanning is enabled. hci_pause_addr_resolution(), called
just above, only stops advertising when LL privacy is in use, so on a
controller without it the command is issued while advertising is still
on:

  Bluetooth: hci0: Opcode 0x2005 failed: -16

It does not converge either. hdev->random_addr is only set on a
successful command complete, so it stays BDADDR_ANY, and the deferral
added by commit c2994b008492 ("Bluetooth: hci_sync: Fix not setting
Random Address when required") requires it to be set. Unlike the
resolvable address a few lines above, which is reused while rpa_valid(),
the non-resolvable one is regenerated and rewritten on every call, so a
controller that refuses the write is asked again at the scan restart
period of about 10 s, for as long as discovery keeps restarting.
Observed on a BCM43455, which has no LL privacy and no extended
advertising, 190 rejections in one capture, every one retrying the same
address:

  < LE Set Random Address  Address: 02:16:91:90:F1:D4 (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed
  < LE Set Random Address  Address: 26:90:57:96:9A:3E (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed

Pause advertising for the address update, and resume it once the update
is done and before the scan is started. The pause does not outlive the
function: it is taken only when nothing else holds it, and every exit
resumes advertising, which also releases the pause taken by
hci_pause_addr_resolution(). A failed pause returns before marking
anything paused, so the error path is a no-op.

The resume in the error path is no longer guarded by ll_privacy_capable().
That guard matched a pause taken only under LL privacy; the pause added
here is unconditional, and hci_resume_advertising_sync() returns early
when nothing was paused.

One caveat this widens, raised on the previous posting. When
HCI_ADVERTISING is set, hci_pause_advertising_sync() also clears
HCI_DISCOVERABLE and HCI_LIMITED_DISCOVERABLE and zeroes discov_timeout,
and hci_resume_advertising_sync() restores only HCI_ADVERTISING, so the
discoverable state is lost. It reproduces today on an LL privacy
controller through hci_pause_addr_resolution(); the unconditional pause
makes it reachable without LL privacy as well. hci_suspend_sync() also
pauses unconditionally, so a device that suspends loses the same state
on any controller today. That asymmetry is pre-existing and is left
alone here rather than folded into a scan path fix.

Legacy controllers have one random address register, shared by the
scanner and the advertiser. Restoring the advertiser here can reprogram
it when the advertiser is non-connectable, so the scan then uses that
address rather than the one generated for it. Both are non-resolvable
and neither is linkable to the identity address. With privacy enabled
both roles already share one resolvable address the same way.

With the patch, on the same hardware:

  < LE Set Advertising Enable    Enable: 0x00              Success
  < LE Set Random Address                                  Success
  < LE Set Advertising Parameters                          Success
  < LE Set Advertising Enable    Enable: 0x01              Success
  < LE Set Scan Parameters                                 Success
  < LE Set Scan Enable           Enable: 0x01              Success

The address write is accepted, and advertising is restored before the
scan is started.

Over 119369 btmon records and about 12 minutes of the normal workload of
that device, alternating active and passive scanning with ten outgoing
connection attempts, every LE Set Random Address succeeded and there were
no Command Disallowed responses of any opcode, against one per scan
restart before.

Patch 1 is required: without it the resume added here returns -EPERM on
the controllers this fixes and leaves advertising disabled.

Fixes: 3c44a431d62b ("Bluetooth: hci_sync: Resume adv with no RPA when active scan")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5.5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c2f2a0c0e73d9..c9e80b9574551 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6340,6 +6340,7 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	u8 filter_policy = 0x00;
 	/* Default is to enable duplicates filter */
 	u8 filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	bool paused;
 	int err;
 
 	bt_dev_dbg(hdev, "");
@@ -6363,6 +6364,12 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	if (err)
 		goto failed;
 
+	/* LE Set Random Address is disallowed while advertising is enabled. */
+	paused = !hdev->advertising_paused;
+	err = hci_pause_advertising_sync(hdev);
+	if (err)
+		goto failed;
+
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
 	 * private address.
@@ -6372,6 +6379,9 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	if (err < 0)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
+	if (paused)
+		hci_resume_advertising_sync(hdev);
+
 	if (hci_is_adv_monitoring(hdev) ||
 	    (hci_test_quirk(hdev, HCI_QUIRK_STRICT_DUPLICATE_FILTER) &&
 	    hdev->discovery.result_filtering)) {
@@ -6395,9 +6405,8 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 		return err;
 
 failed:
-	/* Resume advertising if it was paused */
-	if (ll_privacy_capable(hdev))
-		hci_resume_advertising_sync(hdev);
+	/* No-op when advertising was not paused. */
+	hci_resume_advertising_sync(hdev);
 
 	/* Resume passive scanning */
 	hci_update_passive_scan_sync(hdev);
-- 
2.53.0




