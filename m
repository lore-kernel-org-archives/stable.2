Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D03441F7FD
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205866; cv=none; b=sI0OOGzajY0noARyAm0t96sPEEYvzLN3Oo4sVfSL1pWH0mYLaUSvBpOeJ4ASwVv/qE4WRwyE1fbPMEWuXImY1GF3bDShyl5BTJuJ8spXoorZy8jxFzOedRzPsY3ohGxlpNtJpkOI8wSdsp2M0XZYlwSGXxQ9RjU+svWuI1GcNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205866; c=relaxed/simple;
	bh=Ksj8HTufJExEzJG3CUwrF9hYnkPIoBondiI8vStls9o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kjKmFPT0/KkW/tuAKE2QUZRum+rTbWvrWL6/s4BegBc7LYFD2viXifNyGz2UXgXxuOIjZ6W0nxmiU2dG2Azxgh8Y1SbhWtNIwbE9D4Nnf9pjsS1QbIspOh+RyijWIJTeMKEclB34IMNH+I/mgYgYu+Bg5sVK9ZqV0aWyI+fhGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S+Ofx6DP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+Ofx6DP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9070B1F000E9;
	Thu, 16 Jul 2026 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784205865;
	bh=BRwCD6u/RcDtCThPV3ZJtxqmLFAaUnXTbkPcBAPrDuc=;
	h=Subject:To:Cc:From:Date;
	b=S+Ofx6DPm5LLGepf/l5EGC+qX1ooXU/YWDWNKee7Kj5lrxtQGarkOfPjrAl2pc/zC
	 x90Fsv6eTlg0ZlcwR72g47WFeWzV+KZXMHnlBjPu8HeBBiGA0t8x0oWaffIxH6Unmh
	 BdLivd6Lra09PkerlpIV+KYvdvZhK8rxT9FaS8ik=
Subject: FAILED: patch "[PATCH] Input: mms114 - fix touch indexing for MMS134S and MMS136" failed to apply to 5.15-stable tree
To: dmitry.torokhov@gmail.com,hexlabsecurity@proton.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 14:44:10 +0200
Message-ID: <2026071610-maximum-nuttiness-8da1@gregkh>
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
git cherry-pick -x a6ac4e24c1a8a533bb61035184fdcc7eede4cc8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071610-maximum-nuttiness-8da1@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6ac4e24c1a8a533bb61035184fdcc7eede4cc8d Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 22 Jun 2026 22:35:18 -0700
Subject: [PATCH] Input: mms114 - fix touch indexing for MMS134S and MMS136

The MMS134S and MMS136 touch controllers have an event size of 6 bytes
rather than 8 bytes. When __mms114_read_reg() reads the touch data
packet from the device into the touch buffer, the events are packed
tightly at 6-byte intervals. However, the driver iterates through the
events using standard C array indexing (touch[index]), where each
element is sizeof(struct mms114_touch) (8 bytes) apart. As a result, any
touch events beyond the first one are read from incorrect offsets and
parsed improperly.

Fix this by explicitly calculating the byte offset for each touch event
based on the device's specific event size.

Fixes: 53fefdd1d3a3 ("Input: mms114 - support MMS136")
Fixes: ab108678195f ("Input: mms114 - support MMS134S")
Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Reviewed-by: Bryam Vargas <hexlabsecurity@proton.me>
Link: https://patch.msgid.link/20260616050912.1531241-1-dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 4d748a13408d..53ad35d61d47 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -217,7 +217,9 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	struct mms114_data *data = dev_id;
 	struct i2c_client *client = data->client;
 	struct mms114_touch touch[MMS114_MAX_TOUCH];
+	struct mms114_touch *t;
 	int packet_size;
+	int event_size;
 	int touch_size;
 	int index;
 	int error;
@@ -234,9 +236,11 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 
 	/* MMS136 has slightly different event size */
 	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
-		touch_size = packet_size / MMS136_EVENT_SIZE;
+		event_size = MMS136_EVENT_SIZE;
 	else
-		touch_size = packet_size / MMS114_EVENT_SIZE;
+		event_size = MMS114_EVENT_SIZE;
+
+	touch_size = packet_size / event_size;
 
 	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
 			(u8 *)touch);
@@ -244,18 +248,20 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 		goto out;
 
 	for (index = 0; index < touch_size; index++) {
-		switch (touch[index].type) {
+		t = (struct mms114_touch *)((u8 *)touch + index * event_size);
+
+		switch (t->type) {
 		case MMS114_TYPE_TOUCHSCREEN:
-			mms114_process_mt(data, touch + index);
+			mms114_process_mt(data, t);
 			break;
 
 		case MMS114_TYPE_TOUCHKEY:
-			mms114_process_touchkey(data, touch + index);
+			mms114_process_touchkey(data, t);
 			break;
 
 		default:
 			dev_err(&client->dev, "Wrong touch type (%d)\n",
-				touch[index].type);
+				t->type);
 			break;
 		}
 	}

