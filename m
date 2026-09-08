Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7250C285
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870259; cv=none; b=GOXhG1/uocv38oKa+f/zOjvkWUxxwN8UwkcWvzixxFpOlETqgzIMPkaVVkRD3we7rTUvc1xYUPWBtV+MOnv73QvBQ7HzE8pVeBnFqL7Bvf99fHgFEhez8tfgbU/vJLF3bdXo9Ik5xoLWxsM5VQBmBVODiRklHpL2dUezElL8mCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870259; c=relaxed/simple;
	bh=F/Dr10HsGyHpTqTi3KkzzPeUL5+msUu8mYjw5UC56cM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hdTauOZzTEyVZyJsqGuG01ExEKZX7JJESqAiR/hDmr1+AUBApHqkd7ik5E70MaYKjVb0ijnoj26UFEjhzy/PlONQUnu2BMt69K8ZB95zUe+4yGP9YLZRf9XzemzRhiUzFKTttEeb+Te2dQbP8p2xy8Qtu8CPhxLuxJdON4c/qIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6odPVi1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6odPVi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A841F00A3A;
	Tue,  8 Sep 2026 12:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788870257;
	bh=tuCIj4eBcCCYk9BQa6R9v0KLLswMTHwIoOc5U2Rhe84=;
	h=Subject:To:Cc:From:Date;
	b=u6odPVi17Z4rFOmUu/FNm1HLpsQ/skexhd2I32DdbFTBOy9Kw7QHwZ4ZgUNvRJVm3
	 CldhiF8KN3SzDgwkqmE0nqHUKgDWayskEhZndsC2RSyK1OTuoqTlutHC8SLxTmghSK
	 xVZaMD3WyRp68ZNTkFORWgkVu8//8DSKIR/pJs3U=
Subject: FAILED: patch "[PATCH] usb: gadget: f_mass_storage: fix null pointer dereference in" failed to apply to 5.15-stable tree
To: jeffinphilip14@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:23:52 +0200
Message-ID: <2026090851-disprove-ointment-dbd3@gregkh>
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
git cherry-pick -x 2c0f5ca48674a5b5f9fa4a9c3325aa48053af0bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090851-disprove-ointment-dbd3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c0f5ca48674a5b5f9fa4a9c3325aa48053af0bc Mon Sep 17 00:00:00 2001
From: Jeffin Philip <jeffinphilip14@gmail.com>
Date: Tue, 18 Aug 2026 09:29:04 +0530
Subject: [PATCH] usb: gadget: f_mass_storage: fix null pointer dereference in
 fsg_common_set_num_buffers()

Previously fsg_num_buffers_validate() was removed as it was not
necessary due to Kconfig setting the limits for n from 2 to 256 with
default as 2. However, setting the page content in such a way that
kstrtou8() reflects n value as either 0 or 1 bypasses these
restrictions leading to a null pointer dereference if n is 0. Fix
this by adding a check for n < 2 and returning -EINVAL if n is
either 0 or 1 consistent with Kconfig logic.

Reported-by: syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=791be35f1fbcc85d06d7
Fixes: fe5a6c48fd95 ("usb: gadget: storage: get rid of fsg_num_buffers_validate()")
Cc: stable <stable@kernel.org>
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260818035904.10324-1-jeffinphilip14@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 1a0fbc808ee2..fc4818fb2a8b 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2747,6 +2747,9 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
 	struct fsg_buffhd *bh, *buffhds;
 	int i;
 
+	if (n < 2)
+		return -EINVAL;
+
 	buffhds = kzalloc_objs(*buffhds, n);
 	if (!buffhds)
 		return -ENOMEM;

