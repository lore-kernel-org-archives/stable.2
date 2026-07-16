Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A1341D63A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207058; cv=none; b=k19naJMm4bF290C0r74QkQwtFLswl3x5VUvghKAy7V37IgF4RShXLdbYFN5NkPgwZmTLhvA36NauMZfKd+h5E+U4xHQR+FaU2o2t3IIiDWUgx5D0E/hR8XhynolrMBB0abTzJQgHCz07SxCbNrnBdWyW3EnA4gl4RpkTWJFUPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207058; c=relaxed/simple;
	bh=LNd1lskcqll4Yp9NKwpDx7XKmKvMyVJhLiwxX+qRwEU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j2hRf+uIaVm3fSKGgszniCCYbrPcd9xAymxzuCs0ezHzH0Y6LnlOzb484lHldWg719Ynbx7U+qDWOQrFUcRe9dJx6Jvtw6feOxkhav2AZn8wurjVjosrWW7eSQ0W4DIVgEjU8ANIgiH5dDH900l/63iwVOfhXU9+NUlFbAJXmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MBHHCfMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MBHHCfMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEED81F000E9;
	Thu, 16 Jul 2026 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784207057;
	bh=gAFlZvc2EuJvKAsbmMlnTi0pdL/Q/126Pn7Mk3Uk2/8=;
	h=Subject:To:Cc:From:Date;
	b=MBHHCfMxrsa40CGtLMGL1nYapgWp5jA2whDQ0phCKd+J3AHeka/M3On+dHd2ppTgg
	 49LjCsmXvsGl8Kv4ksiBfsJzX+LJac9H81mmhikImHUHO/PXI/X8zV0VBGljVt/UHI
	 jaLLB/WtdY6aHT36WnSPMkDVsAf33qw9ZbSKdVFg=
Subject: FAILED: patch "[PATCH] Input: mms114 - reject an oversized device packet size" failed to apply to 5.15-stable tree
To: hexlabsecurity@proton.me,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 15:01:45 +0200
Message-ID: <2026071645-latch-matchless-9242@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 66725039f7090afe14c31bd259e2059a68f04023
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071645-latch-matchless-9242@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66725039f7090afe14c31bd259e2059a68f04023 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Sun, 14 Jun 2026 14:19:43 -0700
Subject: [PATCH] Input: mms114 - reject an oversized device packet size

mms114_interrupt() reads a packet of touch data from the device into a
fixed-size on-stack buffer

	struct mms114_touch touch[MMS114_MAX_TOUCH];

which holds MMS114_MAX_TOUCH (10) events of MMS114_EVENT_SIZE (8) bytes,
i.e. 80 bytes. The length of the I2C read into it is taken verbatim from
the device:

	packet_size = mms114_read_reg(data, MMS114_PACKET_SIZE);
	if (packet_size <= 0)
		goto out;
	...
	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
			(u8 *)touch);

packet_size is a single device register byte (0x0F) and the only check
is the lower bound packet_size <= 0; it is never bounded against the
size of touch[]. A malfunctioning, malicious or counterfeit controller
(or an attacker tampering with the I2C bus) can report a packet_size of
up to 255, so __mms114_read_reg() writes up to 175 bytes past the end of
touch[] on the IRQ-thread stack: a stack out-of-bounds write that can
overwrite the stack canary, saved registers and the return address.

A well-formed device never reports more than the buffer holds, so reject
an oversized packet and drop the report, consistent with the handler's
other error paths, rather than reading past the buffer.

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260612-b4-disp-dc4b8dc4-v1-1-d7cb0a828d92@proton.me
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 9597214d9d3c..4d748a13408d 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -226,6 +226,12 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	if (packet_size <= 0)
 		goto out;
 
+	if (packet_size > sizeof(touch)) {
+		dev_err(&client->dev, "Invalid packet size %d (max %zu)\n",
+			packet_size, sizeof(touch));
+		goto out;
+	}
+
 	/* MMS136 has slightly different event size */
 	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
 		touch_size = packet_size / MMS136_EVENT_SIZE;

