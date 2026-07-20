Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0791416CFD
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550913; cv=none; b=IJQlUf4HjQ8v3Y7xwaAKespdx2ZF7H8FB7kLlT7eY6mdoSUHDM9eKc2ZJ8sSfiKt5UIekT7S5XLGo5E4auU2/WldN9ZgdS99MhE1CGvHc5XBUge9waD5Ay9cX4bdfKIAlBNALDuDaj/xDgIIjWoZKEePQWnXjKBRRjfk7jKtLpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550913; c=relaxed/simple;
	bh=bHbED6CkXOG0banLIbNZThvB3HpGRuZmKq7S7JF/nMA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q7r0kdWZvKhkkrVrX72+Yw20A9NlWDV34zjNVNq+/fyV3T2v+fA5yqGHFW5P7OHUSevgTAfWu+DMi/xFOos+XaKGAjNFuT16SDO+8D6xBY2WKdgleOI2Qk45+4vxVs8bZ2+Y2NoIEm5DeivZGYLtf+xQZAU06TkyjF4SXT81Hms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QHCkFwHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QHCkFwHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AE11F000E9;
	Mon, 20 Jul 2026 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550911;
	bh=WY5leojMZidZhC7ktxaF/o0MVK6T5b3XhVKANoil+fo=;
	h=Subject:To:Cc:From:Date;
	b=QHCkFwHr6ZcSFPRBfklYGPn5+ztKRO3Ez9VbpRtc5vWrs2JzCHAXRsPKv4EOvDoHN
	 CkVwBKTcFHUz5qNPHONzUPAzmpnHkNhnmCqzPTcFuPM85HWaiV23428iK1I9D2vm16
	 D/MOUVkUA5WwZieDBUF06WkzWbo/SYF1XNwUga2k=
Subject: FAILED: patch "[PATCH] fbdev: efifb: fix memory leak in efifb_probe()" failed to apply to 6.6-stable tree
To: nihaal@cse.iitm.ac.in,deller@gmx.de,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:30:28 +0200
Message-ID: <2026072028-upstairs-wilder-f34d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 9b6eaf101656958397a6012bf43f6e2e42c9e5cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072028-upstairs-wilder-f34d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b6eaf101656958397a6012bf43f6e2e42c9e5cb Mon Sep 17 00:00:00 2001
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:41 +0530
Subject: [PATCH] fbdev: efifb: fix memory leak in efifb_probe()

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
caller; clarify ownership") the string returned from fb_get_options()
is expected to be freed by the caller, but the string is not freed in
efifb_probe(). Fix that by freeing the option string after setup.

Fixes: 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 47ebc0107209..ad8dec7807c3 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -377,6 +377,7 @@ static int efifb_probe(struct platform_device *dev)
 	if (fb_get_options("efifb", &option))
 		return -ENODEV;
 	efifb_setup(si, option);
+	kfree(option);
 
 	/* We don't get linelength from UGA Draw Protocol, only from
 	 * EFI Graphics Protocol.  So if it's not in DMI, and it's not

