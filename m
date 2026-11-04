Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801868;
	b=qkFu1h+0w0mwuAsAZtBGU/DGxiu98+2S8kH+dqmVTpfKWAey0FIIuv5EotA3oSfAcRiU
	 fN6EGYyjmfoYAHDTQhdR9nMG3FrJzkSqemrU9HCLKydXmwbChBngHBMTIgjnsWopwlJho
	 IO4pKOfzU1qm5n6BFNN+3GnlkafmGyy+7EOYkMYEQ5l2RAOpG3tz6DGoFaKCoGz+hJQRt
	 BnZi8eDgNLu0Td7b1DVIM+KoF2Cu8e9DrFFhTVVRrQUU3cX4g2k1sfgQHWYl/LA3urtxr
	 JAOHLNdzDVjfRP7/H5F3fDPCKYxF1zF4jCfAx7VI6W4a/GmxigFLwbPkqsUPa8Twcpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801868;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A5MbAV8/VA/wYWWnAk7V9Kpjn4TjPNbSs9KdX3QtqWM=;
	b=nDvD2EkQErfkjQb+i4F/ufTphqCyZ0w5zKfXO5vIhhshva/tYIu9ZqL9mNwM7AOxdjTc
	 1X3PaSfrqm08Wo6fBiMvqyPR0ORJKpYphcoGe02DHcUitqLQXNe5RaEcn4VO3aU/X/5D0
	 sDHK04dQYY7VCjXnHcdj4VS98LtTyMdla7pc+Vm7fdBo272AycZ+PulwcIrOmgvK+Ps4V
	 i16u9WO60puiqfG0aD7+421+MvEzh0eBImAGAXiXkqU9YlvowqM5SS+fvHxZ44VW3ZU0U
	 f2s+WD426wob3Mp6CWLn02LLSU8cTxu4FppeoS0n7ysVBG+t2b4V95M7remzEh+FEcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HQmTVqKX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2F606D810
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HQmTVqKX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CB11F000C1;
	Wed,  4 Nov 2026 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801867;
	bh=A5MbAV8/VA/wYWWnAk7V9Kpjn4TjPNbSs9KdX3QtqWM=;
	h=Subject:To:Cc:From:Date;
	b=HQmTVqKX3SoDOvwhMNG0yH9L0ziUzbnT/5HXJBmCVL9TYuNdEPCaVFoETFBJ8bIvu
	 GdRTWTntACuNrk3QN8iGc7SUmccl4OgTeK4K2Z5YHYcbKdpHjFcoKDmWOQ2DC2UtPy
	 6A+XxNttGNuSskbBF2IbSjirCAndVLeGrSnHlZT0=
Subject: FAILED: patch "[PATCH] media: microchip-csi2dc: fix async notifier leak on probe" failed to apply to 6.1-stable tree
To: congnt264@gmail.com,ehristev@kernel.org,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:17:43 +0100
Message-ID: <2026110443-shell-unplanned-01c4@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x c7528789244ce7329ca883170fb9315d739ae985
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-shell-unplanned-01c4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c7528789244ce7329ca883170fb9315d739ae985 Mon Sep 17 00:00:00 2001
From: Cong Nguyen <congnt264@gmail.com>
Date: Sat, 8 Aug 2026 16:07:29 +0700
Subject: [PATCH] media: microchip-csi2dc: fix async notifier leak on probe
 error path

csi2dc_of_parse() ends up calling csi2dc_prepare_notifier(), which
registers the V4L2 async notifier with v4l2_async_nf_register(). The
probe error label csi2dc_probe_cleanup_notifier is reached after
csi2dc_of_parse() has already succeeded (e.g. when media entity init,
csi2dc_power() or v4l2_async_register_subdev() fail), but it calls only
v4l2_async_nf_cleanup() and never v4l2_async_nf_unregister().

The notifier therefore stays chained in the global notifier_list while
the enclosing struct csi2dc_device is freed, leading to list corruption
and a use-after-free when the list is next walked.

Unregister the notifier before cleaning it up on the error path,
matching the teardown already done in csi2dc_remove().

Fixes: 2de0b3c0f678 ("media: atmel: introduce microchip csi2dc driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/microchip/microchip-csi2dc.c b/drivers/media/platform/microchip/microchip-csi2dc.c
index e69292f3b2a9..b2c17ff2322f 100644
--- a/drivers/media/platform/microchip/microchip-csi2dc.c
+++ b/drivers/media/platform/microchip/microchip-csi2dc.c
@@ -735,6 +735,7 @@ static int csi2dc_probe(struct platform_device *pdev)
 	return 0;
 
 csi2dc_probe_cleanup_notifier:
+	v4l2_async_nf_unregister(&csi2dc->notifier);
 	v4l2_async_nf_cleanup(&csi2dc->notifier);
 csi2dc_probe_cleanup_entity:
 	media_entity_cleanup(&csi2dc->csi2dc_sd.entity);

