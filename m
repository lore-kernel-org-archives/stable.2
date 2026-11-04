Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801851;
	b=JdmtD9SPGOOuF91VNKLE8R/WpB1r0OBPbCqkSknr8rKNQbRXIfcT7lO+/VjADgCLM3XQ
	 zgBcijDILtfA5dIyCs1MN46+BL5sgk019GhoDZO3k3Prf2h6OtXi7zDPnbIsK5JoRc9Rj
	 IaliHMiPp9bRSO93NBvB3wTFl36GiN++kB+hkraw2BHFH+Np5/Q/Co38XPkV/Qj9RV52G
	 OOXxi2b7hL1NJZQg4XK0hukpRea2CYnNOHdVpLMm5Wa4qUbgvPfnKmi4s9SA90TH2yDa0
	 2WTgBIZhfh4u3p4oZFL6ilV8z6a9zo8EBwjIbeVv1ocnLc7/iq0I6QGpVRj6Yq34jKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801851;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eBHxByOMHlOdtocKDli7VeGYfIsgXF8CSjPkN77O5m4=;
	b=zB46x5Ahtm+rmgrc8iES3oEQQ6403Hof4U6CVuz09Rsc6DiIAud+C4ZwpAB11iqYVLiQ
	 45SJ173rFnwoeihhH3Qfx5lNMam2pwfiEDo4bA9z3pKVpWX228Q+kiDLAc6DiIWh3/qX/
	 qdsENDA7h7P6YqLUoeSJyL0kDh33Sl/M6tYzaB7CZodPmMlnCxPMwKz6wfIZLVwCi4IlJ
	 WFHWgdD/y48FBUNP6fUTldFazfAgORxKkv5Cb2Qga28aTRqT5GLe9ikNwz3OV1DheY2Pi
	 K8fFW7H1m7CR4+xddIZIe3JDnCzjvWZIs+cRHyTH+yfde1zw2PhZxG78tfzrBxC4aKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GId0wtlM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A089606EE90
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GId0wtlM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17AE1F000C1;
	Wed,  4 Nov 2026 14:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801850;
	bh=eBHxByOMHlOdtocKDli7VeGYfIsgXF8CSjPkN77O5m4=;
	h=Subject:To:Cc:From:Date;
	b=GId0wtlMvorfmv5NCU810oTET08O9MPzR6OBa2ZAZTnbfdC8P++4zz95hhBGm2ETE
	 5RTv4Yy0u/OZXEittuhRUHGZOxOznnvI3aFggRuxy1hZYU3GpyqfcQE7K+2f4mCGRg
	 x1oG3h5SVx9E/p0BAadNdlRW1ZDNsLmkdKZjs65s=
Subject: FAILED: patch "[PATCH] media: marvell: mcam: stop DMA and cancel s_bh_work before" failed to apply to 6.6-stable tree
To: fanwu01@zju.edu.cn,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:17:29 +0100
Message-ID: <2026110429-consent-correct-15d0@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0f29f84317c1e35f6a9265277be33e60d3fc8c1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110429-consent-correct-15d0@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f29f84317c1e35f6a9265277be33e60d3fc8c1c Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Fri, 7 Aug 2026 05:35:53 +0000
Subject: [PATCH] media: marvell: mcam: stop DMA and cancel s_bh_work before
 freeing DMA buffers

In vmalloc mode the frame-completion IRQ queues mcam_frame_work() on
cam->s_bh_work, which memcpy()s from the dma_bufs[] that
mcam_free_dma_bufs() frees with dma_free_coherent().  mccic_shutdown()
frees those buffers without stopping the controller, so while streaming
a late frame IRQ can re-arm the work after the buffers are gone, causing a
use-after-free.

Stop the controller in mccic_shutdown() when streaming is still active
(gated on an open fd, which holds a runtime-PM reference, so the device
is powered), cancel s_bh_work in mcam_free_dma_bufs(), and move
INIT_WORK() into mccic_register() before the device can be published.

Fixes: 67a8dbbc4e04 ("[media] marvell-cam: Basic working MMP camera driver")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/marvell/mcam-core.c b/drivers/media/platform/marvell/mcam-core.c
index c1e8a2a3012d..2d0b8b60c509 100644
--- a/drivers/media/platform/marvell/mcam-core.c
+++ b/drivers/media/platform/marvell/mcam-core.c
@@ -406,6 +406,8 @@ static void mcam_free_dma_bufs(struct mcam_camera *cam)
 {
 	int i;
 
+	cancel_work_sync(&cam->s_bh_work);
+
 	for (i = 0; i < cam->nbufs; i++) {
 		dma_free_coherent(cam->dev, cam->dma_buf_size,
 				cam->dma_bufs[i], cam->dma_handles[i]);
@@ -1306,7 +1308,6 @@ static int mcam_setup_vb2(struct mcam_camera *cam)
 		break;
 	case B_vmalloc:
 #ifdef MCAM_MODE_VMALLOC
-		INIT_WORK(&cam->s_bh_work, mcam_frame_work);
 		vq->ops = &mcam_vb2_ops;
 		vq->mem_ops = &vb2_vmalloc_memops;
 		cam->dma_setup = mcam_ctlr_dma_vmalloc;
@@ -1864,6 +1865,12 @@ int mccic_register(struct mcam_camera *cam)
 		goto out;
 	}
 
+#ifdef MCAM_MODE_VMALLOC
+	/* Init before sensor bind: armed by IRQ, cancelled on probe-error paths. */
+	if (cam->buffer_mode == B_vmalloc)
+		INIT_WORK(&cam->s_bh_work, mcam_frame_work);
+#endif
+
 	mutex_init(&cam->s_mutex);
 	cam->state = S_NOTREADY;
 	mcam_set_config_needed(cam, 1);
@@ -1922,10 +1929,15 @@ void mccic_shutdown(struct mcam_camera *cam)
 	 * take it down again will wedge the machine, which is frowned
 	 * upon.
 	 */
+	mutex_lock(&cam->s_mutex);
 	if (!list_empty(&cam->vdev.fh_list)) {
 		cam_warn(cam, "Removing a device with users!\n");
+		/* Stop so the IRQ can't re-arm s_bh_work after the buffers are freed. */
+		if (cam->state == S_STREAMING)
+			mcam_ctlr_stop_dma(cam);
 		sensor_call(cam, core, s_power, 0);
 	}
+	mutex_unlock(&cam->s_mutex);
 	if (cam->buffer_mode == B_vmalloc)
 		mcam_free_dma_bufs(cam);
 	v4l2_ctrl_handler_free(&cam->ctrl_handler);

