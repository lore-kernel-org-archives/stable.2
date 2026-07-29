Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D7486E69
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330261; cv=none; b=InBP165xwyoTsYdcQOt1tK/MHLffc8/pbBt02cllZq+x00fcAHZsRg5XIlzTxWd2++G6yue04XWSOf2JR8FVbypcWTdSGC+AS7Bh/Agy4eqY47itG8CP1pTLwgAEd/Hu7cZDMUvT0Vpw7CpllSDe4VV1X7XiGW7pM7sNhZ3Z33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330261; c=relaxed/simple;
	bh=qVlk2eum37mP/Rgx//9Jx1hpm/ubTBNRq9V4b1WvnUI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=duTDI63gJhrnL/GcjQ84tXxD7Bsnl8Y1dLS2ylnFnoG3UzPDxXl35HxP9FEVO/0EvVsGm8vsfEgAVUVgfhp+OheTkeh6Ar0Olh5hGPmkjFXJRjl/GveEbhaLEQ3vhxLFSaxpPI8+MLui1owN3VIIi/vEbXwNLHSvcH6r2wUeSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sYjxR7uL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sYjxR7uL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB3B1F000E9;
	Wed, 29 Jul 2026 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330260;
	bh=xu+ColQagtuOYIcYYbUnL9fIi/rdBoZu/O+AFhPS+9U=;
	h=Subject:To:Cc:From:Date;
	b=sYjxR7uLUDKnwyYHOLvwwOTc16x+rtQK08Xxvz8IQYyfGC+5Rd7NYktJH1GOB9cjf
	 2wwLnxLbGWhwnkACTuWSyE5A+Vpdg3Eloem0ycoktAXaLA92OASCqYSss1bm8Xjexf
	 2wCxI42Dq+nAOXR9zvTTGs2PWXuFEtxTZXEHyvpU=
Subject: FAILED: patch "[PATCH] media: vpif_capture: fix OF node reference imbalance" failed to apply to 5.10-stable tree
To: johan@kernel.org,hverkuil+cisco@kernel.org,khilman@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:03:58 +0200
Message-ID: <2026072958-undead-renewal-0430@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2282f979560af6bbc8ee2c1ee8663197312cee5b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072958-undead-renewal-0430@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2282f979560af6bbc8ee2c1ee8663197312cee5b Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 7 Apr 2026 12:08:31 +0200
Subject: [PATCH] media: vpif_capture: fix OF node reference imbalance

The driver reuses the OF node of the parent device but fails to take
another reference to balance the one dropped by the platform bus code
when unbinding the parent and releasing the child devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT when available")
Cc: stable@vger.kernel.org	# 4.13
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index 15df3ea2f77e..91cb6223561a 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1498,7 +1498,7 @@ vpif_capture_get_pdata(struct platform_device *pdev,
 	 * video ports & endpoints data.
 	 */
 	if (pdev->dev.parent && pdev->dev.parent->of_node)
-		pdev->dev.of_node = pdev->dev.parent->of_node;
+		device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
 		return pdev->dev.platform_data;
 

