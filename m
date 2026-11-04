Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824127;
	b=MMa99CrElPP7RP6X0guUDwsVqMoVimsUnH6aMjm1sE6wI+MVPfS52VK42MTQfuQNUseY
	 gJhLqxUP89ehX2SQcJd39qeL1j7VzERNh7XEVPTz6gnNk4B40Z5H/uPu/25TCIN7veMKK
	 tgw8uCfwxyNMK4e/f+ytkEmjHcP8VVyPBxd0BIy9KQCJZ7Lo+ZHTftckbO6rXr5jNbpKD
	 GaUoa6eRMZZ/0KV+3CynDQ1wzjEAcB55SOB+QXk3u9iFCBjW9sUOVoSZLgwgEfRPRkSMh
	 B3mT89aEzRmPfNM/4bYcMwldLAVENuOvTbZnpuTavzPhRjQhJ3t2md0Js7j+eJFunwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824127;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vrI9yHr8Qhf7tDI83+s3G7qB7koLDWMticfeNjXJg8U=;
	b=yRbAelCvFsVcbVJFckKMfMAWZG0HBlCMrtgaPO6yJEB/hCIwEE91LLo1WECKiTT3qU4r
	 LtgPKPq9Rk/UByOa6BstjTp/0DlMxaeYRMFCud/CO40LyJh30KH2i0/VV0rJ/sLeZyMNh
	 KzXeWtLBX3+Gd2MduWh5p7IoOj1Oht9l3RmC7rJbF1miQ2AE3l3T65147/Da1Fl7Yuoc2
	 bIMba4iZPLBW8IbCefqBQfDRGCy9xnHnnj7GXhvSY+aUvEwRqpBuHtFlrOnKj8owwKLvk
	 Ko6jdD+q4fPfKhj/93/sF/ogBZUx3Ojzkl32JQZHzSrm4jrooFNLE88Gxt8JL4IZZGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sAZ8a0FV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25E6070AAA
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sAZ8a0FV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D6C1F000C1;
	Wed,  4 Nov 2026 20:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793824126;
	bh=vrI9yHr8Qhf7tDI83+s3G7qB7koLDWMticfeNjXJg8U=;
	h=Subject:To:Cc:From:Date;
	b=sAZ8a0FVVYRbictsV35OaNFgPsLzhUiea+u0tjo7fR8TByba04LybeKKOH13y2C2N
	 vze7N9nbCGoobQgfxtTpkmoED1IId5WSE2FeizbDnQb9eMbFEtVbucsFr7AXqgvItx
	 dYo8L9DzUt4lI04Fd+akYg2CiJM/6u6TXxCi4cB8=
Subject: FAILED: patch "[PATCH] HID: prodikeys: validate fixed-format MIDI reports" failed to apply to 6.6-stable tree
To: yaojiale02@163.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:28:44 -0500
Message-ID: <2026110444-unlisted-unaired-f627@gregkh>
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
git cherry-pick -x 0ff37294c41bd925258893310398bc2b45fcd4a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110444-unlisted-unaired-f627@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

