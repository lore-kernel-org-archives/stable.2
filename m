Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824132;
	b=bWL9Q8IWUg4EwhJ8NFZmy7xJGoJPSTceUeNGumFvVMsslU22UG7Vi+XZsKLUTviFomqC
	 ulHUHyqPJcSOjVaUr3IPnuK/lNqvCH6iwnBEj7N7BeDAsoyjE/Wphx1mgffm6C2gdhSXP
	 vD3urGW+OrrFrIE/HMZvINzt+UTXrVIbJMr0Maj6RAu5rIVZ2eGoHAq+NPpHoGQ+OXQyZ
	 EbiE8z2M8pR0hTYSwaAy87h3Bu5JzwqU9zC+wKyWElnU+aXKWnANPTa065tuK96H8Qczd
	 Dg4dMzcNVYuQkNe8jkX/nGoh3VtIaHH3730sBvS9weH3ER4ddI+ivnb4bRo6nD/O3RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824132;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AwQP4H/eh5ZMRTEl5ilFe/W3uFxpCVXNXzLoecS/mRc=;
	b=bTvZNVCazRcr+g7xzYVutzQ8dCzVFUwJ2ZMxk+s13M9Sjw7DOXWh6G/dhBxbnMPcBO8G
	 5OsxOy4adjiZLjfK5M9cviM/tRcrX1saGK3dssmqQfA5jtV2ZLewUpwo0J2Oe3H/iG7X1
	 D56ybllAdXloUIEkzYq8Yqqzm0n3bRxnEE4gldvJOePcLAlBNbdmIxQHJ2BH1/tqLwGJO
	 Y5gPJ17fmC5+pSwqfm6xHAATrA0aHxTuzoQR934WRGm9/1ieCFwnvIwNN2eAVWN7034AZ
	 vxMx1WNYJi4PA+M4MO+8L6tuns4rGs4OAis1ICtgOsrzhBwWv9lNz5W5vN1RPRvCnLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=S8EASZi1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EFA606D820
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=S8EASZi1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EAE1F00919;
	Wed,  4 Nov 2026 20:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793824132;
	bh=AwQP4H/eh5ZMRTEl5ilFe/W3uFxpCVXNXzLoecS/mRc=;
	h=Subject:To:Cc:From:Date;
	b=S8EASZi1ey60GYOh2wvKFww8iaySNG7TjNqvxXBJR9vGpJuxIA/tg0ueVSNVBRZES
	 fJvIYgun4yGZEdsO6ECR49kLJqJBoS1A/TWHrm+6mNM8jr3eCLb0Bkp8o3FcxTkUJM
	 i3qhDUiklH/QV9Opi1+3UjmNKTZr27mPy7cVyZCM=
Subject: FAILED: patch "[PATCH] HID: prodikeys: validate fixed-format MIDI reports" failed to apply to 5.10-stable tree
To: yaojiale02@163.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:28:50 -0500
Message-ID: <2026110450-magnifier-vaseline-6e69@gregkh>
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
git cherry-pick -x 0ff37294c41bd925258893310398bc2b45fcd4a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110450-magnifier-vaseline-6e69@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ff37294c41bd925258893310398bc2b45fcd4a7 Mon Sep 17 00:00:00 2001
From: Jiale Yao <yaojiale02@163.com>
Date: Thu, 24 Sep 2026 22:44:11 +0800
Subject: [PATCH] HID: prodikeys: validate fixed-format MIDI reports

The HID core invokes raw_event callbacks before validating the report
length.  Prodikeys reports 0x01 and 0x04 are passed to handlers that always
read bytes one through three, regardless of the supplied size.  A truncated
report can therefore cause an out-of-bounds read.

Require four bytes for the two fixed-format reports.  Keep report 0x03 on
its existing variable-length path, which derives the number of note pairs
from size and only accesses complete pairs.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: 3a370ca1dcf8 ("HID: Prodikeys PC-MIDI HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index fba01e4fcab1..bf5add40d3e1 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -772,8 +772,13 @@ static int pk_raw_event(struct hid_device *hdev, struct hid_report *report,
 		if (report->id == data[0])
 			switch (report->id) {
 			case 0x01: /* midi keys (qwerty)*/
-			case 0x03: /* midi keyboard (musical)*/
 			case 0x04: /* extra/midi keys (qwerty)*/
+				if (size < 4)
+					break;
+				ret = pcmidi_handle_report(pm, report->id,
+							   data, size);
+				break;
+			case 0x03: /* midi keyboard (musical)*/
 				ret = pcmidi_handle_report(pm,
 						report->id, data, size);
 				break;

