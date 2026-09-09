Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A0525A84
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951323; cv=none; b=mvDJ2IBPXqIdtDU3/RKIn7gniFG+qp5oVcGUDmNpN52YOn5PDtizv8ewqpn6h/9p+JQHSaiIN9PRDhgCYWWypJwmvwyHkO+17knO+vbh8XLZIM4XL52YkRniavNzdRrHbiUhIb1FgdV1A6hYMKNOq9Wj+lCqTo7C4pK+HXvvlkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951323; c=relaxed/simple;
	bh=AyENbymj6JkAfA1ZtIRByAoEpqh/hUQw3IDT72PQHbI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KCeenTdPyB0td99iXiwShsE72jbqO3ahGrCipok5nONaXV13ehV5lCa8qJjMEguQ3Y/HQrj44/clJRXNBOXuUYj9VoTdWU9WQvaDskmS0tS+Ce/CCOyS9F7TGYpxF7F1vgmdF8pJVChmmMd85P5VIoT+9+rVhu1BbCWs0sRZxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BpZAZGzI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BpZAZGzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B781F00A3A;
	Wed,  9 Sep 2026 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951320;
	bh=Vtj8fpiYxa/Qo7NzbFTfRxPBHVWGh3HHPzIoQ5Bd9fE=;
	h=Subject:To:Cc:From:Date;
	b=BpZAZGzIe+eIHl7PneQdsaJy1AXF2eQbRvVcvRVDaiZOMcaO/eJeBlQrPOCwSTpMS
	 43ZYMBLpVda2DxQiB53TL0y8SVDizMwgz3gOOm3Wl8RDuAdcjKw5i4FPygRLqm6d5r
	 aQrFisP439X92DCalO0/EifTK0HLkAYEAumLgcW8=
Subject: FAILED: patch "[PATCH] media: rkvdec: Propagate platform_get_irq() errors" failed to apply to 6.12-stable tree
To: ahmisaranrao@gmail.com,detlev.casanova@collabora.com,hverkuil+cisco@kernel.org,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:48:28 +0200
Message-ID: <2026090928-grew-headdress-5025@gregkh>
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
git cherry-pick -x c37aca64206fafe938119e801a3fd10a537a051f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090928-grew-headdress-5025@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

