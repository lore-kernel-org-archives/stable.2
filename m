Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F23DA5AE
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541411; cv=none; b=MFDkDJ1ht+Yfh9seEq7sG47r+OVE2Dwvk17xB4ZOux9DxQxaO4vVIXCroO6shD5CcWc+aokRRSPUdSwQxFR1TO0CHrnCzMED1WbBBC4cYhDKbJhpWskUwSZB88CWY5eLx5NGJG4i6s4uBNucgNYPTc+B+muRfCzzLTuyAtT02T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541411; c=relaxed/simple;
	bh=+vvvEpFO8PE4F90LULOyOcCwj2o/7Fxi+SBgr8p4vrc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=llduCHDMp5U68N7ak/Ely+1mN4nf//zyHc7sozYWEz8kUNM2EMxBKOm1H4RwG9SzXXQDX7QByLcUli895GTXtnRN3DusecQlkZTYEsFOkuRx0gYOS5iQRE5f1ymfSLKTcsSniX45qKF629P97aHgyy1ezEneG6n2rdMIiqdTFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KP9w+yFa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KP9w+yFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF83E1F00ACF;
	Mon, 20 Jul 2026 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784541404;
	bh=s2hOposGP+b3VZXQPxSCwnRldmQ72HDFUxdWp6rwBS8=;
	h=Subject:To:Cc:From:Date;
	b=KP9w+yFaohXKtSO0nGmT/8f/c3bzYIcPFgJ2NM+vHvq2nmvhWk+1vHFNoYHVb7/vD
	 5JkNZ6M27lCBerY9PXWX16c1l3fGxjgID11xdOYJS6vhTeGs6ZVvDK+EQ+MfPQj4Af
	 gXlmp8tBqx2fr2kIhXti+M0bnp2bpjBMvWmVgf44=
Subject: FAILED: patch "[PATCH] fbcon: Use correct type for vc_resize() return value" failed to apply to 6.12-stable tree
To: yujiacheng3@huawei.com,deller@gmx.de,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 11:56:35 +0200
Message-ID: <2026072035-endorse-escalator-4d05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 84202754fb1727dc3ee87f47104e4162ecc8ba3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072035-endorse-escalator-4d05@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

