Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329A41B37D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329603; cv=none; b=lDXH/Y5CWvm0YWumbFy59CeOA9S+29G286XEIyjAaAIoJaUyLZZLwRgiku5vmqd/F6zhfr3njhL4L3dDWzjcXra9izD7b7Aru9ieiv4sfo09G1BGIuUGQczViNUZioYGGgdoykRq9x3Hfu+n0Uq1MZrOG+JIJLyVvmqFY25bd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329603; c=relaxed/simple;
	bh=GFvQgaPzla6YR4iVdDl215/HjmBFozr1zg6BO5M1P8M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AIyqQuKtAgmwZRlTZglXwBOUwYA1D59v4W/cMDjy2Zs9siGjBvMTU6ATT1wmDgVNrWzD+CxS+Jf1cGMhvQ0RIJnBKRdzg6LLQvCrfuLTiODQF1/0H9DgKJWwqDJfP14tDNikWNQejzCF2N1diZsTrXFM85TcuZ290PY9INTL+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yJ3GOoSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yJ3GOoSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ABF1F000E9;
	Wed, 29 Jul 2026 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329597;
	bh=rM+pWU/88YratxJv71jCZH6gWzuWDW4g7cMQ7FxGsvg=;
	h=Subject:To:Cc:From:Date;
	b=yJ3GOoShZIR2Z5N6kE4rqnX02/CBktNposZrZMNkKsyj0uiJXT7QwLREtKIheyKRg
	 ANNz2ruZaTOLncCiU+O+xzGA7AvmWaJ0mEhrmULSdvl8Vo8c+BdH6KTfNoGvf2EK1H
	 ujB0k0jhL1z13R0gkJ7de0u2viF14AOIeFHYodfo=
Subject: FAILED: patch "[PATCH] media: imx219: Fix maximum frame length in lines" failed to apply to 6.6-stable tree
To: sakari.ailus@linux.intel.com,dave.stevenson@raspberrypi.com,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:52:55 +0200
Message-ID: <2026072955-retouch-favorably-ee17@gregkh>
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
git cherry-pick -x 2c4f1ba7354312ad2d6e34e70a518a51a9344715
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072955-retouch-favorably-ee17@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c4f1ba7354312ad2d6e34e70a518a51a9344715 Mon Sep 17 00:00:00 2001
From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Sat, 21 Feb 2026 01:38:15 +0200
Subject: [PATCH] media: imx219: Fix maximum frame length in lines

The driver used the maximum frame length in lines value of 0xffff, but the
maximum appears to be 0xfffe instead. Fix it.

Fixes: 1283b3b8f82b ("media: i2c: Add driver for Sony IMX219 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index a09699299b4e..0b9ff639e9f7 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -72,7 +72,7 @@
 
 /* V_TIMING internal */
 #define IMX219_REG_FRM_LENGTH_A		CCI_REG16(0x0160)
-#define IMX219_FLL_MAX			0xffff
+#define IMX219_FLL_MAX			0xfffe
 #define IMX219_VBLANK_MIN		32
 #define IMX219_REG_LINE_LENGTH_A	CCI_REG16(0x0162)
 #define IMX219_LLP_MIN			0x0d78

