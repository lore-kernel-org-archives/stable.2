Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802664;
	b=cofk/D3qJieQTcu0Doag4WUSmobOIVMuoAXOdClu5lNQtFjBlqSS9nz/+o5vEnSynoj+
	 v2N6EbZoZmcZQFXCXC48XAqAatiu7bTLx7g3+s2Ujh1FFD83TZd5LW6ddyT8ETAxKxekn
	 7B1l00XtbFFOoqC5dkJRx1jWy4dBDZLIDv7rODM8CZoeXfzxNTtOdpSxgkGJgpvd38oYp
	 zm59NQQ0NxOpY+AKTnA+Na2uYRXAIzgBHf8LGdiAOa91r6u7R7nNPeuWmsYpFdnEi1N3c
	 iS1ny3kfX64RrQmO8yFLdT2nBLXglrxtuQkWiycLCsfx2vCWr5rDsMRxdBK9ECbMs9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802664;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T9isEb6lb/KAN+sVxkOnpq+g7t6DUc3iEPBhCVKM7D8=;
	b=F2d6i3gWPc3OHgHSqxTheoU2NSdYdvqE6JH+7WxrEZZTe1Gp5Rg5Yz2WVnekHxyAtxLA
	 iyPQhXUDF/X3rzgbWLxHK3VZ3oDDjxpJQVJog2h3HiGi5r3z680EqH/R22B8/LlSkAqSv
	 qhe3sBSJwIf6B2IiLQYIu2P/MutbLc8SW5YoDEcF537m5xkk7lYCETYYVRMbyhxjlw6hc
	 OjbmYlHkEuS68Pc+f0NbXEirScoKy1JAeY1L9GMKHRgu8zJuZZ/jxn1rELm+TYuOP97i0
	 g+4JyOfRCtGQ8i7zTI6IUwCTrX7OAfa0lHr1Ps4wvd2pZv8nFwASeM2BAJINgBv0ePw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EIVtuUJr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72028606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EIVtuUJr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0413F1F000C1;
	Wed,  4 Nov 2026 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802664;
	bh=T9isEb6lb/KAN+sVxkOnpq+g7t6DUc3iEPBhCVKM7D8=;
	h=Subject:To:Cc:From:Date;
	b=EIVtuUJrhF7dmHHsljnGNwNvbZrHa7+pj4iC12jTLVi9YobG2iHViPSJ0HK2hwYF5
	 YValEuJsoEP9L6CvwrSSGtx4z1BjXn9f5J4gTsaG/NXVumX8j/tz5dIbzBNmLo8J/S
	 lHvEu89xN3j17OFJRqiTkSN+2kPRU28lPfxAzYIs=
Subject: FAILED: patch "[PATCH] media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device" failed to apply to 6.6-stable tree
To: sean@mess.org,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:30:55 +0100
Message-ID: <2026110455-abacus-sitting-9c3b@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b3f5daf3222999d3f92f606a4eb5e35ab90fd0e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110455-abacus-sitting-9c3b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

