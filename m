Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1FB3DC4C6
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541419; cv=none; b=YnYGek1dJVOdBQyRRw7I5lrchj6KJvZ7ffkQoLF7fS1UJ0GudSIFQo4B80qIdzrrhz7B9Mcby1YEdZhMVoS0xldRPYlOJu8T+DAOZN/WtOT80HEGuxhE1IKCbZi3Ts+MjdHc4DwAY0oZQ7uc3C06XkiTsdjrOrZiQEH1g75dfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541419; c=relaxed/simple;
	bh=FgNwCnfcFgalmiG2Kx5h/dDquCIm0ZUco5slyygwzGQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qurnQZ6qtknhwX+CmaxSP/dZ20W0fNyZ9KbmMdxy1QAE8ffr3lQnWpBXySEEQdmNZAqknc4iOV+M4ODiVAI39HfHvkziIsyM9OpiYQChlwb6ZPG0mLY1h3wTe0U60Yam/2zV8C0nkSaOvTN+hsSTKw4pkyQDHM29WrlWcUj7N5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zby6qWoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zby6qWoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BFE1F000E9;
	Mon, 20 Jul 2026 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784541415;
	bh=0Kcr8M7rQt2q9NrYEnz63IUk7FI7p+Ur1n255crI6Ps=;
	h=Subject:To:Cc:From:Date;
	b=Zby6qWoZi4PJ2Aw9HWGEKF60VjN2pFnGTaEpTCuEZBUVPm/ylq5jCGPshB3kAtsDz
	 1baqneVaKrP8HYjfDqs/yecluymvASvpEHIMD7YQWpEWoP5Zt+mGXPHNKQcaXTHNO1
	 9A8jhnVqgwik2K83KRh61DN5nxAvTJTi6fLgIxPA=
Subject: FAILED: patch "[PATCH] fbcon: Use correct type for vc_resize() return value" failed to apply to 6.1-stable tree
To: yujiacheng3@huawei.com,deller@gmx.de,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 11:56:35 +0200
Message-ID: <2026072035-secular-countdown-b586@gregkh>
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
git cherry-pick -x 84202754fb1727dc3ee87f47104e4162ecc8ba3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072035-secular-countdown-b586@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 84202754fb1727dc3ee87f47104e4162ecc8ba3a Mon Sep 17 00:00:00 2001
From: Jiacheng Yu <yujiacheng3@huawei.com>
Date: Thu, 14 May 2026 17:19:18 +0800
Subject: [PATCH] fbcon: Use correct type for vc_resize() return value

The return value of vc_resize() is int, but fbcon_set_disp() stores it
in an unsigned long variable. While the !ret check happens to work
correctly by coincidence (negative values become large positive values),
the types should match. Use int instead.

Eliminates the following W=3 warning:

  drivers/video/fbdev/core/fbcon.c: In function 'fbcon_set_disp':
  drivers/video/fbdev/core/fbcon.c:1494:14: warning: implicit conversion from 'int' to 'unsigned long' [-Wconversion]

Fixes: af0db3c1f898 ("fbdev: Fix vmalloc out-of-bounds write in fast_imageblit")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b0e3e765360d..641687a734d5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1440,8 +1440,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct vc_data **default_mode, *vc;
 	struct vc_data *svc;
 	struct fbcon_par *par = info->fbcon_par;
-	int rows, cols;
-	unsigned long ret = 0;
+	int rows, cols, ret;
 
 	p = &fb_display[unit];
 

