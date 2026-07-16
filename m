Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7AA41D63A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207055; cv=none; b=E+RY73WQIBLi+WSxy6y6v/3vy0X7LZxpwPslxvbuaQTsXg1b8tQP4RSdl9Pj3xOKSYQg5X+qtvAZopGgSqdVT/wvBnFcd2UsK/Ua2eB/ZpIgpX0L4P4ZzlP1jawtYwVsxx7b9tF+cGCza4GsHjO4SKZjevETGvL15Y2PRZltgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207055; c=relaxed/simple;
	bh=et4+qOW7pmsjMInEJldXu1mH0JdEZcCxyYHpUaq19D4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lVGiuS+ogCm2yv3GaO/jsGjddhCslHuo4zgChu3pIQuvtwdNek94GiU7XrcjEV+9Dt6koPykXCUl9AMEuA6v32Y2MxE0ODj2SYzBlHtjUeSY2jLNH7uqWrnisRXWCQ3ua458HltiaBLYHSgWle1KxYeJaJk9+1Lzl1aq0FatqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C3eR1nNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C3eR1nNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E991F000E9;
	Thu, 16 Jul 2026 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784207054;
	bh=xb7LiLPTSDkEvqA71s+dfOSbxE2C0KCRec3NPrAx+2Q=;
	h=Subject:To:Cc:From:Date;
	b=C3eR1nNhCh6CoIzktYlD8CPsmABx4SNc2F3pCD1LCnEXYJqTHtSLU8jjAKDld9DF9
	 XieFmU/UcQwm7wWZ5oFa5PFjteyZLfAJxeQZnKm1U0ct3IVAXa0MAfi1hEl2/rN+Br
	 8bZrj1sDSBWbUnzzrdx19sgHXLh0N2gNEo0exwOc=
Subject: FAILED: patch "[PATCH] Input: mms114 - reject an oversized device packet size" failed to apply to 6.1-stable tree
To: hexlabsecurity@proton.me,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 15:01:44 +0200
Message-ID: <2026071644-upscale-amaze-5106@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 66725039f7090afe14c31bd259e2059a68f04023
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071644-upscale-amaze-5106@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

