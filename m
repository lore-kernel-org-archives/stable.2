Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621C437471
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562676; cv=none; b=dBstld7zHjW/+qdj5E5eWt6hoetw1UWlb3tsaBCLOHz+S57Srp9YgYJ01MYhI/9nVLYlsWOBQIRP3T2MFR8+3+IDXdIQSck8hMm6WZOLPs0QLSlO2/l8UkIc6EM6+Ou45D1J2NSk6BPBgmSc2uuoohY+vX5qe37DOaoIa1J/Ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562676; c=relaxed/simple;
	bh=tmGlUr7QLuFflhJSvK1Ixb/OCZvxQOui/6DxC9+4kKw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iLWj+8W+tEap7h/ahQVCbosuLpE20vrgLfqTZ5Yh4hUcyOfhwFxa9nN92AQ48jfJQMFRwf8QmSQh0xX2BxBAXqj+fmem4F8Ye5IZEj7irrMGNz8WeDCOEx4Y2F4klicRjzMswga+rI0IIxbSiGKugU7iDLdIjJJYEUIgKQRMckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bkCT3r6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bkCT3r6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5281F000E9;
	Mon, 20 Jul 2026 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562675;
	bh=xV1sYmFZM6YI74wmqaXrMqmjml4+5QSBhGtRjN9hwF0=;
	h=Subject:To:Cc:From:Date;
	b=bkCT3r6j7o4M2Yu3yOE9JQ6n88wYDtFVdC7Shd+D13QMX+DVAlXkNVJ62WwoyRg1s
	 COZaCckXktxfYupWr7vWyMOR3jqSCmyDE2jWpqJQTuydtt4E6vslUPxxCE6y3Zet3B
	 BXD+U2Ae8derZ6VjZbFL2Fv1W/ATntB0moEL7RfY=
Subject: FAILED: patch "[PATCH] Input: ims-pcu - fix firmware leak in async update" failed to apply to 5.10-stable tree
To: dmitry.torokhov@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:44:52 +0200
Message-ID: <2026072052-exterior-oncoming-f12b@gregkh>
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
git cherry-pick -x d48795b5cd6828d36b707e8d62fc9e5c90e004ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072052-exterior-oncoming-f12b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d48795b5cd6828d36b707e8d62fc9e5c90e004ab Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 22 May 2026 10:25:31 -0700
Subject: [PATCH] Input: ims-pcu - fix firmware leak in async update

The firmware object was not being released if validation failed.
Use __free(firmware) to ensure the firmware is always released.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index ea11368834a3..4f8265c0772f 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -935,9 +935,10 @@ static int ims_pcu_handle_firmware_update(struct ims_pcu *pcu,
 	return retval;
 }
 
-static void ims_pcu_process_async_firmware(const struct firmware *fw,
+static void ims_pcu_process_async_firmware(const struct firmware *_fw,
 					   void *context)
 {
+	const struct firmware *fw __free(firmware) = _fw;
 	struct ims_pcu *pcu = context;
 	int error;
 
@@ -957,8 +958,6 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 	scoped_guard(mutex, &pcu->cmd_mutex)
 		ims_pcu_handle_firmware_update(pcu, fw);
 
-	release_firmware(fw);
-
 out:
 	complete(&pcu->async_firmware_done);
 }

