Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488D4B488F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951330; cv=none; b=F9yJ0FSR7AI76o/3YbHPEV/YbUOuR6jzUpywT43z+3rQCrEVDQGCBYaE3UiyMLQSRCA+IsuXnsWHgJJGtGh/1Sq8vwy1gvOwE1frkHnI7eOgy2i5KfAQsI6ohdcQcqDIYlf7GZtP6OmkYsC4wuNjKDEg4sDtaSUMQ4c378A6VDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951330; c=relaxed/simple;
	bh=z2GYSQu/s9GNmSqM7w45Qkt2nz/g+up2n/P25CLgCs4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O6vQbfkJiaLhxRxL1Xq4SlBA5dxwzgncZr/zJG4+EDJLQ6uAU4NbbmNif1I9buyXqA8iAfUSIBUz8tyg6+uRMFjxVVPN4mUO6+nkMOU2yFXkqFmsK6PU1u8HgTaRykPLaqIuFvNZh79+rFl+VlTZwvuN7S49JyZGg3MKL1K4ol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YddqhxYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YddqhxYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D9A1F00A3D;
	Wed,  9 Sep 2026 10:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951329;
	bh=HZEwvcbTyMMoPzdC3LAIX/o+kwqDO0OvbePxPjJI2dc=;
	h=Subject:To:Cc:From:Date;
	b=YddqhxYGWyzHdFix3of9AP0feP+Vc/e6qYKNGfONMlwQDtYFIwdDYR4P5klUTKmrE
	 +DwWWEw8ShCMnXRk9YREh2csgGvI03FA11R+6ZmxcTiNqzpHLvpfA7ikvZo6xFgccn
	 8RWJv9RFvGi82xaa2SBFx80z1xPBoFs3iIdmrPhc=
Subject: FAILED: patch "[PATCH] media: rkvdec: Propagate platform_get_irq() errors" failed to apply to 6.1-stable tree
To: ahmisaranrao@gmail.com,detlev.casanova@collabora.com,hverkuil+cisco@kernel.org,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:48:29 +0200
Message-ID: <2026090929-dictate-motto-3cf4@gregkh>
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
git cherry-pick -x c37aca64206fafe938119e801a3fd10a537a051f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090929-dictate-motto-3cf4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c37aca64206fafe938119e801a3fd10a537a051f Mon Sep 17 00:00:00 2001
From: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>
Date: Wed, 1 Jul 2026 16:42:03 +0530
Subject: [PATCH] media: rkvdec: Propagate platform_get_irq() errors

platform_get_irq() returns a positive IRQ number on success and a
negative error code on failure. It no longer returns zero. The driver
currently returns -ENXIO for all failures, which loses useful errors
such as -EPROBE_DEFER.

Return the error from platform_get_irq() directly.

Fixes: cd33c830448b ("media: rkvdec: Add the rkvdec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>
Reviewed-by: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec.c b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
index 4fd06f4c04db..061281f903f3 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
@@ -1818,8 +1818,8 @@ static int rkvdec_probe(struct platform_device *pdev)
 	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					rkvdec_irq_handler, IRQF_ONESHOT,

