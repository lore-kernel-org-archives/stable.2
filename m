Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D69498906
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951319; cv=none; b=d0ZKPs5WLHFHYA1zYK/lzwjnJMuXgIowJVP++JVs7gEUjRkKLvojVLevzDEUKOCj4O9ba/AB9PHSG6QUvq5gOgTZwkVoboRiDN7yoLn1PQFMVymogeW8ZfM7GM7Lj+r9k1Ht9s7RlGHI/49zSQikMvpNAOd6tvnujI0EUzsghuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951319; c=relaxed/simple;
	bh=tntEUwAs95xKpITHO/cH+7YftZJa8H4beotkTBEEWug=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GwQyoYI5ly+cxs3b/NLXAC6Awf6HBECIrrzRMDvApkmWR8OrX9g9a1ro7XoOMz7gb8yeXnNaQyuAVxakUh6dyVApb3/OTXe5oAOugwWHurJd6U2jcvERMiNRam307eAXt/HV0v+yyT+qRweaXXmbLh+AI2FdTuEu8aGbpH+DxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z0TjXGHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z0TjXGHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641A71F00A3A;
	Wed,  9 Sep 2026 10:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951317;
	bh=Zw+HIUI2ByLlnJfr/92xGVAbEpHaqrLmoS9U6JqrsXg=;
	h=Subject:To:Cc:From:Date;
	b=Z0TjXGHoGOy7wsFe0cY3SMFALlvNbTKepf+p5rGvr2UKrgLEXcEScd3Gg4sMD5vv3
	 GThORvk6J2A9RzA5op5mzdAoiQZwTVrd3nFYPeMYs5DgTy+XO47ZC3n8gFyUz+0idg
	 1NlgLOd11aGXqwZKMgDVkUN0Tj00vBU3IDjQi7ns=
Subject: FAILED: patch "[PATCH] media: rkvdec: Propagate platform_get_irq() errors" failed to apply to 6.6-stable tree
To: ahmisaranrao@gmail.com,detlev.casanova@collabora.com,hverkuil+cisco@kernel.org,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:48:28 +0200
Message-ID: <2026090928-froth-sprinkler-1445@gregkh>
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
git cherry-pick -x c37aca64206fafe938119e801a3fd10a537a051f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090928-froth-sprinkler-1445@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

