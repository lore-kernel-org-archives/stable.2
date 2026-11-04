Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799876;
	b=HnU8gQrU5Gt2RM2gtgxSMi7MnJMi4gw8YCaYMap545821ZMd5elcC/odxV8mMj81hz3a
	 ALlYKsr+o52mNQcUzIZ+0wUkuMuOw5lrPqGo8Xvh6HY1pjSM0Se1CNnTSyO0HfD43gosI
	 aRh16GBfMwy1DaADbXqh7ZjLS51/D2I7pPPqUGfA/XEejro40MCNfTZnB8rTGaue5xqce
	 8F4bjsyEmP5W5N2kKhOq6UfaIPYNYdaDFPKmiftyuaim0PN+3KzmjxinFoPVLYtvhWGkr
	 2zQ6SygaqS0Wu807trA9VCtqAD+eJQE7/t66wrJWjbVdCGLXWi4/n+ffL3Ru7C4HwGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799876;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pmpDY+bbZacgr+GpSVebdKeSwOS1svToB+DIT97wJCc=;
	b=1AI/jxp5pSgbk2FSiCu1Iw8BTgpQ5hpN+d9s29YjXINUQ2zNyLAABQ80Z/70sWsJR+5w
	 6ZHrZiJ0UVettgYztGtmd45F413XZZ7AmANCiK8n9BtFBbrCgwhqyOSf0CzB2NetPLjBc
	 UvC9C4B+ka9zLTs2stb6+75yiluoshLq65LUOKyg1cN440i/8nfUhjHcVc+FRsax0K0v6
	 IDK4IeDJncj3Gg++Ket67aktkg24StoDrE+5ucb3d4WSVF0X1erBLDUES28UG+rIZHAYq
	 m+85ctBAwE/m4nuS0v93d2ZnDDLiMBsN1rtWXZlUse8uMzzRVbxM1j05S9vM4J/uBGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QTPVhbXC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987D606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QTPVhbXC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E2F1F00919;
	Wed,  4 Nov 2026 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799876;
	bh=pmpDY+bbZacgr+GpSVebdKeSwOS1svToB+DIT97wJCc=;
	h=Subject:To:Cc:From:Date;
	b=QTPVhbXCN+SnK6/kj6o44PguaapDbqFeS76GNrVgmcGtz/+DgL2fUeKFy98Y8D1rq
	 wCn7FOBp+1Ia+sv3tPpt20BkN4SvI1F3v/wLVjXMoHM1DmihJQmwI+c4F7dJanB33I
	 1UE15a5vwtGrwREA7JxjN1oCmDS8xty9wkyK+A7U=
Subject: FAILED: patch "[PATCH] HID: wacom: Setup SW_MUTE_DEVICE according to the order of" failed to apply to 5.10-stable tree
To: ping.cheng@wacom.com,jkosina@suse.com,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:44:26 +0100
Message-ID: <2026110426-partner-wildcard-01e9@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 97ce491bcef2d231b8d51cee8e579183319a5ba4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110426-partner-wildcard-01e9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 97ce491bcef2d231b8d51cee8e579183319a5ba4 Mon Sep 17 00:00:00 2001
From: Ping Cheng <ping.cheng@wacom.com>
Date: Wed, 7 Oct 2026 15:03:35 -0700
Subject: [PATCH] HID: wacom: Setup SW_MUTE_DEVICE according to the order of
 input registration

The refactored SW_MUTE_DEVICE code assumed that stylus will be
the first regiestered input. In reality, touch can be registered
before stylus, such as the Wacom Cintiq Pro 13 and 16.

This patch covers both touch-first and stylus-first cases.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..cf459c16b39a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3977,10 +3977,18 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
-		if (wacom_wac->has_mute_touch_switch ||
-		    (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch))) {
+
+		/*
+		 * This is to setup the touch switch for those devices that report
+		 * pen interface first. The setup can only be done here since this
+		 * routine is only called once. When we are here, the shared
+		 * has_mute_touch_switch has been set by the pad.
+
+		 * There are two ways of reporting inputs from firmware: stylus first
+		 * or touch first. This path covers the stylus input first case.
+		 */
+		if (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch)) {
 			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
-			wacom_wac->has_mute_touch_switch = true;
 		}
 		/* setup has already been done */
 		return 0;
@@ -4403,7 +4411,26 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT3_BT:
+		break;
+
 	case HID_GENERIC:
+		if (wacom_wac->shared) {
+			/*
+			 * The setup of touch switch capability can only be done
+			 * here for those devices, such as Cintiq Pro 13 and 16,
+			 * that have touch input registered before stylus and pad
+			 * inputs.
+			 *
+			 * There are two ways of reporting inputs from firmware:
+			 * stylus first or touch first. This path covers the touch
+			 * input first case.
+			 */
+			if (wacom_wac->has_mute_touch_switch &&
+			    wacom_wac->shared->touch_input) {
+				input_set_capability(wacom_wac->shared->touch_input,
+				    EV_SW, SW_MUTE_DEVICE);
+			}
+		}
 		break;
 
 	default:

