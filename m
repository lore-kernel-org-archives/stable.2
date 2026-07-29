Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1AD488D97
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330137; cv=none; b=mQiSMkguVfagRJ42358NS7f/bf9rWS/y7J1KMLJsagcxuqmxNKjKFKwvzf/ptaB3W5WmcI1ieGNHjl7JlvtZ1D8Bmb0OrmbHmXEw75Y5GFEuUXDbdm9Tw2rLC+vT/AP/2zfpSviZzhsPtNdfSm3545POS0rNZBGu1BayFh+86Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330137; c=relaxed/simple;
	bh=MdIRAxyEzXsO0pVwJO7EDI2yZXjZe/TcqD3F/y+3tCM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kcmBSfFqY//Nv5nA0qiMA7fqlGF2bUViSz4jLqZYKrtHUqeFgCbyDtqnXjNlt2G/Ca0JnRQzSapuT/oz0h5fjfdJXOq/3LOSNWrR9+EOAZCvMVTK/PwPAVCHwE8oMsqCBxAwzzwynTfWlGeim137nyohxpuD6ptgwByevAB9UuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2NoxBBmf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2NoxBBmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B881F000E9;
	Wed, 29 Jul 2026 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330133;
	bh=o9+UoG9MbePffv79KQFp15Guy2EPO9DtKQIdP+pzsG4=;
	h=Subject:To:Cc:From:Date;
	b=2NoxBBmfdngIiCRXbK6rTcScvOUWpmqSAJI74OziMUYMeeMNChGUO1FXc+ZmR++rn
	 D/6MuHEQTygzPn6DUE4ZDbaNyy17YN13cPCVLzdAms8ouRmQxjjGd175kWrJ7sMVpa
	 b+E3S1EKUZT8ONpZ3yZoWwpkewB3w97KrschKGbk=
Subject: FAILED: patch "[PATCH] media: ti: vpe: unwind v4l2 device registration on probe" failed to apply to 5.15-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,hverkuil+cisco@kernel.org,y-abhilashchandra@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:01:38 +0200
Message-ID: <2026072938-nervous-nail-c5fe@gregkh>
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
git cherry-pick -x e0f1c9a90ef665f2587c274a8fed59f2dfc575a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072938-nervous-nail-c5fe@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0f1c9a90ef665f2587c274a8fed59f2dfc575a6 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 26 Apr 2026 22:16:31 +0900
Subject: [PATCH] media: ti: vpe: unwind v4l2 device registration on probe
 error

If the vpe_top resource is missing, vpe_probe() returns -ENODEV after
v4l2_device_register() has succeeded. Probe failures do not call the
driver's remove callback, so the v4l2 device remains registered on that
error path.

Route that failure through the existing v4l2_device_unregister() unwind
label, matching the other errors after v4l2_device_register().

Fixes: 4d59c7d45585 ("media: ti-vpe: vpe: Add missing null pointer checks")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/ti/vpe/vpe.c b/drivers/media/platform/ti/vpe/vpe.c
index a7e5a85e72a1..81bd1f9cee30 100644
--- a/drivers/media/platform/ti/vpe/vpe.c
+++ b/drivers/media/platform/ti/vpe/vpe.c
@@ -2539,7 +2539,8 @@ static int vpe_probe(struct platform_device *pdev)
 						"vpe_top");
 	if (!dev->res) {
 		dev_err(&pdev->dev, "missing 'vpe_top' resources data\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto v4l2_dev_unreg;
 	}
 
 	/*

