Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951763DCDAF
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568101; cv=none; b=Yzal+kzPTxTYU0t1ryfK2rz/HxEV2/oM+8TGG1FpK6Z0ogaDtML0pIKKLWhA/pA/PoyEy31FMT8SsPIT6hsYufeIKPoZliIpSJQY7TFHi6F7rREAa0gIcMUl/L1WJWY1kilX0yTZV5DgG1e4VdSg+n3Yqb5J4ApaXMxSnv0XE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568101; c=relaxed/simple;
	bh=DvV2QF44VZFeCgosqqPoIjoegDCFJCYW3/mtFOZPdxg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tx6b/IRGw8fd37GQcE4djafLjnz470J4OB55OaPeLWgS4PyE8SZumd2AYkxwVixq5YAGMLlV4PFJMkZYldioQpEhfpKYdFkGAvQVrLHUd9gFDxf2PxwGmmHzLlPi9/7+yn5/XvrbbD5ZHyaXF0aLhWjFNa0JBCU0f07tbjTiDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=15nekY83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="15nekY83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D051F00893;
	Thu,  4 Jun 2026 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780568100;
	bh=bT1LMMBibnbHj3VbJhYxCy+FkVuBJIIi7mQlkeBMNA0=;
	h=Subject:To:Cc:From:Date;
	b=15nekY83O+n6VYB43Af655NvTiAbgIS7njO/hQW8QJYRXOiNhU60rklFz8D7b3Edp
	 gNX6FpNkSm9wBe9fvVNdtYIFqfTj8qFOTbpCcWc5UB1Vsu74Ycwz66UeZSj2nQIxd8
	 pJ6n0KAI6mbrzHbcVfiA1ksp8Ooa+f2nGh/vsG8w=
Subject: FAILED: patch "[PATCH] Bluetooth: HIDP: fix missing length checks in" failed to apply to 5.10-stable tree
To: meatuni001@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:14:03 +0200
Message-ID: <2026060403-lavish-water-7a10@gregkh>
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
git cherry-pick -x 2a3ac9ee11dbb9845f3947cef4a79dba658cf6f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060403-lavish-water-7a10@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a3ac9ee11dbb9845f3947cef4a79dba658cf6f6 Mon Sep 17 00:00:00 2001
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 20 May 2026 18:56:43 -0400
Subject: [PATCH] Bluetooth: HIDP: fix missing length checks in
 hidp_input_report()

hidp_input_report() reads keyboard and mouse payload data from an skb
without first verifying that skb->len contains enough data.

hidp_recv_intr_frame() pulls the 1-byte HIDP header before dispatching
to hidp_input_report(). If a paired device sends a truncated packet,
the handler reads beyond the valid skb data, resulting in an
out-of-bounds read of skb data. The OOB bytes may be interpreted as
phantom key presses or spurious mouse movement.

Replace the open-coded length tracking and pointer arithmetic with
skb_pull_data() calls. skb_pull_data() returns NULL if the requested
bytes are not present, eliminating the need for a manual size variable
and the separate skb->len guard.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 976f91eeb745..70344bd3248a 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -179,12 +179,21 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 {
 	struct input_dev *dev = session->input;
 	unsigned char *keys = session->keys;
-	unsigned char *udata = skb->data + 1;
-	signed char *sdata = skb->data + 1;
-	int i, size = skb->len - 1;
+	unsigned char *udata;
+	signed char *sdata;
+	u8 *hdr;
+	int i;
 
-	switch (skb->data[0]) {
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		return;
+
+	switch (*hdr) {
 	case 0x01:	/* Keyboard report */
+		udata = skb_pull_data(skb, 8);
+		if (!udata)
+			break;
+
 		for (i = 0; i < 8; i++)
 			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
 
@@ -213,6 +222,10 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		break;
 
 	case 0x02:	/* Mouse report */
+		sdata = skb_pull_data(skb, 3);
+		if (!sdata)
+			break;
+
 		input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
 		input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
@@ -222,7 +235,7 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		input_report_rel(dev, REL_X, sdata[1]);
 		input_report_rel(dev, REL_Y, sdata[2]);
 
-		if (size > 3)
+		if (skb->len > 0)
 			input_report_rel(dev, REL_WHEEL, sdata[3]);
 		break;
 	}

