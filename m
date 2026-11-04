Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802657;
	b=QOLM8g31n6UOeGW0Lgm3+32LaaIGbOjcXW719wGFWB54aV3ou+nSSTlSSFETMBttqslV
	 xXAmqXixt0IUWWlhzVzFsiEapeVkH8J3KbR3TkxzZ4dh6K7Jkn1Va1r+m8k29FKwbH21V
	 J+SP+hzcRwzb5OC1mp989hHtu9M8x74awh9JZsyGoOa5NAQvlrpB7gCBxAC34zEbnNUgk
	 /rHAv4NQTKAn3I26bzLxJbKHzbJy/FUvoAcNskHNuqVsprXN1dsVFZLwXTQKXnK5T/Zzi
	 2dbF7CHLHO3XFHKwJ16CqbndA7ALzIN1kNeTRojxrMIJxSxxXBklIs09Zsz/k/MpJMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802657;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XD/EXMUB/EGI1a48n6a7147ztIb3wZLeNSRxH8aHF68=;
	b=BvZCzcLrEHTJxPLMullIaM3JJa92dIXOdm5kyKF7tkgoUxS0y3ZJMRPGQ8Ud2zKgnnbf
	 I7+YrRWCLstQHywHXF25EriBrwDgLBgsdgohMo/G0CKPQGeQJst3+mW7mgMsRJ78NygfN
	 Y0hvfEDPcx1R5+pL3R9QkX/6b+XJB+K42n0XOot9CmU7rq9LLCrkBP7w6B7+NPNkmkj1P
	 4XDw8U35bmxuEvDUEIERef+E0XFX7io+lXclCvCOsbP9mUBafBWbU1M8V8L8ip2P6s+SA
	 zlmAU+e+FEmJGK6t29rm63LF5JI5OhMKii9QwJ+/G8TWFMiTG1M/2F2J6U3GqdxvwoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FJ0lTSmo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3B606A338
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FJ0lTSmo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598AB1F00A15;
	Wed,  4 Nov 2026 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802656;
	bh=XD/EXMUB/EGI1a48n6a7147ztIb3wZLeNSRxH8aHF68=;
	h=Subject:To:Cc:From:Date;
	b=FJ0lTSmoQhy4Idm937uRR6GX4Wv+LjrJ2lcVs0UFZNYjQSpudsgKSNJODYOO/zbK8
	 pKzUDlleq0oMbS+fW/NIdkxWMkexBf20EHaxyBe7//2QlaeikcHz5KUAyK8dWlY+II
	 e9AfjphII0DPyPT1DFhbIKFG6jZ1v7nvUJntjyrM=
Subject: FAILED: patch "[PATCH] media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device" failed to apply to 6.12-stable tree
To: sean@mess.org,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:30:54 +0100
Message-ID: <2026110454-prepaid-repulsion-f27a@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b3f5daf3222999d3f92f606a4eb5e35ab90fd0e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110454-prepaid-repulsion-f27a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b3f5daf3222999d3f92f606a4eb5e35ab90fd0e4 Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Tue, 1 Sep 2026 10:34:51 +0100
Subject: [PATCH] media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device
 unregister

Mark the device as unregistered before tearing down raw IR/bpf
state, so that racing bpf(BPF_PROG_{ATTACH,DETACH,QUERY}) calls
cannot slip in between ir_raw_event_unregister() completing and
dev->registered being cleared.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 67d86b8ea5e0..37ba19164875 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -2056,18 +2056,18 @@ void rc_unregister_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
+	mutex_lock(&dev->lock);
+	dev->registered = false;
+	if (dev->users && dev->close)
+		dev->close(dev);
+	mutex_unlock(&dev->lock);
+
 	if (dev->driver_type == RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
 
 	timer_delete_sync(&dev->timer_keyup);
 	timer_delete_sync(&dev->timer_repeat);
 
-	mutex_lock(&dev->lock);
-	if (dev->users && dev->close)
-		dev->close(dev);
-	dev->registered = false;
-	mutex_unlock(&dev->lock);
-
 	rc_free_rx_device(dev);
 
 	/*

