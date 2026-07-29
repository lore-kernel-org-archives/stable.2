Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F2488DB2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330132; cv=none; b=sqkJEomA5nCFY9/jTaFvJPkOincaNoH+2Be8waqyJLiUe8pM9LvPpcIRPdlnngJN11rieOhxG7v6/lbcylHUY4vqhmUsM89j78NyJA8FILmZeBgjQ9etZbZJruFlyt9oKHUT6gsarbF+ewdjtt7L67KftIOaeLtxQSFPm8itkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330132; c=relaxed/simple;
	bh=N4ROvFYaoxCqUGSeImHE5hrQlX75MF8sgvWfFq6EmRQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wf+2jihv95tUY6n4yh9P7LwxbhM3IU8yB4xF4xrnoa0IJhNe7IGqyn3fPOjlLXoBN9yX/k/aUW+KRD5YrznS1kwf8Q04j6EfNxcCynxzlSN/81htv2tsETU7wT2+B9fSg2FUr+Y0qbpeFd8EniyxNGPLXwehhUXH2kouHXZIl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ou6ozo60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ou6ozo60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3621F000E9;
	Wed, 29 Jul 2026 13:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330125;
	bh=9v1j8gN5SOR5kuGRDdYwIQsiqMvOtG+aAdfjN90A+Lc=;
	h=Subject:To:Cc:From:Date;
	b=Ou6ozo60tRv9SqUeb+voN3A/j88ATzbwtJAFbxL+1GhNJPtE+x4yjHtW7qQ8MrGHX
	 PXRVH9MliuwZbRxsKjjB3tNMnhvsOUxHr3KYO1vjiAAEYf3mEaQr3Qo4PClxTEQ8vO
	 OIZsHkOecKDFLphiz6bc2LrUzxvNss/aKAftag8E=
Subject: FAILED: patch "[PATCH] media: stm32: dcmi: unregister notifier on probe failure" failed to apply to 5.15-stable tree
To: mhun512@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:01:01 +0200
Message-ID: <2026072901-quack-squad-8260@gregkh>
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
git cherry-pick -x 084973ebd67b28f0945c5d45408f86c58b540110
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072901-quack-squad-8260@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 084973ebd67b28f0945c5d45408f86c58b540110 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 26 Apr 2026 21:43:49 +0900
Subject: [PATCH] media: stm32: dcmi: unregister notifier on probe failure

dcmi_graph_init() registers the async notifier before dcmi_probe() toggles
the reset line. If reset_control_assert() or reset_control_deassert()
fails afterwards, probe returns through err_cleanup and the driver core
will not call dcmi_remove().

Unregister the notifier before cleaning it up on that error path,
matching the successful remove path and the V4L2 async notifier lifetime
rules.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Fixes: d079f94c9046 ("media: platform: Switch to v4l2_async_notifier_add_subdev")
Cc: stable@vger.kernel.org
[hverkuil: added Fixes tag]

diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index e5663fbe6422..eeb0199864dd 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -2195,6 +2195,7 @@ static int dcmi_probe(struct platform_device *pdev)
 	return 0;
 
 err_cleanup:
+	v4l2_async_nf_unregister(&dcmi->notifier);
 	v4l2_async_nf_cleanup(&dcmi->notifier);
 err_media_entity_cleanup:
 	media_entity_cleanup(&dcmi->vdev->entity);

