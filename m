Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520543E484
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870250; cv=none; b=PvwvAL6wCNLwffi29W/1GepZO6lS5Tg3IRulY2EBhjy0KHBhPRHvA/wVl8EC3lWPXcn+wN6TOd94yHq/Ut/Nm5lRmbnqM39CjdTCsrffO+gB8zU1RHXSt4nybxaDi5NQHgJi/QQlU2beXCr4EYqBOTHJZdJYRRfRxssILDKlU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870250; c=relaxed/simple;
	bh=16mLcB0EShCWet9cg7DvO4dSGwvcwgzKIZs73vh2ODk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aWkFdmvjjGE5TiJLwhp00rDLJp6IMxTWfEpgDAxrLaNLwU8sqNUPyAUgcpE+ku4Wu04jQ8Mr3NgD8kDMg9SyLOTia/nVew1h+wKU8uz7lQA2dcTihlkLHP/F0TMCA3JdNBbYbjvjG3R0jfuIRBVGd8fE0Fw51Yzng/Ozt1vbrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2whsfM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2whsfM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EB41F00A3A;
	Tue,  8 Sep 2026 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788870248;
	bh=4zmF/N5kWJ2QvsDM+MuuZUhXAYipT92oY+DqdWrquiU=;
	h=Subject:To:Cc:From:Date;
	b=x2whsfM5WMji9GkG8oODyYB2aiJwPTpqcEgNEYACgphO4CooaQQEARY0boWQwrOlc
	 B8UxKHBHikp6nP+PkTi+jcEamRoJWJtpxx3YdNyaH/FkJA9KwLJv0Jym5eFwoKlIO/
	 /95/tK6Fdc3xqQ2C5SzxdxIw2wYasIDNC/xL6hKU=
Subject: FAILED: patch "[PATCH] usb: gadget: f_mass_storage: fix null pointer dereference in" failed to apply to 6.1-stable tree
To: jeffinphilip14@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:23:51 +0200
Message-ID: <2026090851-depress-crushed-5c8c@gregkh>
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
git cherry-pick -x 2c0f5ca48674a5b5f9fa4a9c3325aa48053af0bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090851-depress-crushed-5c8c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

