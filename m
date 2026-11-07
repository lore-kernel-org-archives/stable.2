Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048089;
	b=DYjELeVnms776KpiXikxzbYUUsEijjTrpDLdPRvz1MJUKj9cIKLYuYeevnpVkrGRNy9G
	 fzBtIeEK+qG/xc8105hjPTjG7kjgz/xcTf342JkQsh55s+Cwav36Fc2D6a9MsyahpykSa
	 9HRLp3CBMfel3N0ikRKOCP6OplnmC9VQqCVGSNQ8iCC/Lop/t+tY/696lFyItiB4ByDq5
	 Hr3s36g2mKI95JTXV4lc5/Tx50bcDLDnrCUIx4zi9lE9GmNRzfHZpeLL8WrW5vB3APZvp
	 aWYLBgQCKefHM3clmj8AA8sUtFszhjLzkKjfej864EwvLjFTRdpjNNNKF+dY3BPRp8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fCWZMaUvEhxkIJ4yh+bsMreFmyi4Hd/HYt/j4f2ycgc=;
	b=ue71CWkonEXTLxP9+orMgq1OJXca6VKOH6oaNVkyWdSh7I4OOebblWrfT6L9Qn2Ts45i
	 mz0mX9+9Fiu0GXRCe1ujycAzQluH+7YTsroJDICGMPWrOKFsSeh5E5+oh+jtbprB791Ix
	 06WjwNl+yocLz34YoYpkksgD+Nx7wMIefVkt8Onw7Mrg+PJKy+qO5vCla0JR8QO3nlVib
	 GGkIp/aEaNdEBftUGICQNnm7mg4JhbpAkSyYm9BQpqw59WQCpcXrmFbactfF2FGHcmoEc
	 NWbWwugvcErzAlKj5R/RX1QO5WUx+30BdXRneWwJ7D9sdfVE3pNWEJeTboLi04LhZDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1GmchnC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1GmchnC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105341F0089F;
	Sat,  7 Nov 2026 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048088;
	bh=fCWZMaUvEhxkIJ4yh+bsMreFmyi4Hd/HYt/j4f2ycgc=;
	h=From:To:Cc:Subject:Date;
	b=T1GmchnC0hVh7sQdoIZ5T50e9Ft6kkaqJS/dmzgmbxc8CN+Q/8QBYywkwzDjqaD79
	 zaL0j6GlWieo0BVi8oowaGz0PFEDbNOzc3ezcc+NkLKkXtciYr8WerJfVcaifWvLXl
	 zmRQI+kNCF75MPlPZOP9zL9ifh+WAn1PMBs8yhJIZDFYJ+4vAD24rbZnZM23YlJ3So
	 dblHwyiyCVlDEEZaRt7endW79w/PnuB1DBm48NaN33YV5U46GFDd3n3l6KtDwcib7j
	 +BX8P+XMjYm3ymi91lxj16rdJEqfB1cwgMBiIB1/XX6a4B9ZB4mXfzk7L1PViw/zxF
	 0R1ubXtDd5V0A==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: disable histogram and flush AWB work on teardown" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:27 -0500
Message-ID: <20261107054127-failed-6.1-00d87c379915@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 00d87c379915a3689b2488bd37f490875d79e20f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054127-failed-6.1-00d87c379915@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 00d87c379915a3689b2488bd37f490875d79e20f Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:01 +0530
Subject: [PATCH] media: microchip-isc: disable histogram and flush AWB work on
 teardown

isc_stop_streaming() and the isc_start_streaming() error path dropped the
runtime PM reference with the histogram still enabled. A HISDONE firing
just before the stop, or a failed isc_update_profile() on the start path,
can queue isc_awb_work(), which reads the histogram registers before
taking its own PM reference and faults on the unclocked device.

Disable the histogram, synchronize the IRQ and flush the work before the
device is left unclocked. isc_configure() is the one enabling the
histogram and then calling isc_update_profile(), so do the cleanup in its
own failure path; isc_stop_streaming() does the same on teardown.
synchronize_irq() must come before cancel_work_sync(), so an in-flight
handler cannot re-queue awb_work after it is cancelled.

Fixes: 93d4a26c3dab ("[media] atmel-isc: add the isc pipeline function")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../media/platform/microchip/microchip-isc-base.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index debbc38717de1..0f486dd5bd82c 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -289,6 +289,7 @@ static int isc_configure(struct isc_device *isc)
 	struct regmap *regmap = isc->regmap;
 	u32 pfe_cfg0, dcfg, mask, pipeline;
 	struct isc_subdev_entity *subdev = isc->current_subdev;
+	int ret;
 
 	pfe_cfg0 = isc->config.sd_format->pfe_cfg0_bps;
 	pipeline = isc->config.bits_pipeline;
@@ -321,7 +322,15 @@ static int isc_configure(struct isc_device *isc)
 		isc_set_histogram(isc, false);
 
 	/* Update profile */
-	return isc_update_profile(isc);
+	ret = isc_update_profile(isc);
+	if (ret) {
+		/* flush the histogram work before the clocks are gated */
+		isc_set_histogram(isc, false);
+		synchronize_irq(isc->irq);
+		cancel_work_sync(&isc->awb_work);
+	}
+
+	return ret;
 }
 
 static int isc_prepare_streaming(struct vb2_queue *vq)
@@ -425,9 +434,13 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
+	isc_set_histogram(isc, false);
+
 	/* let a running IRQ handler finish before the clock is disabled */
 	synchronize_irq(isc->irq);
 
+	cancel_work_sync(&isc->awb_work);
+
 	pm_runtime_put_sync(isc->dev);
 
 	/* Disable stream on the sub device */
-- 
2.53.0




