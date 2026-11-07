Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050209;
	b=muWVnagMHWHBMn5hABD98dhaeblY6wNj3D4oAP4TzwumQOdsiKOXrALC+R90llhYUQap
	 Eo6zEWmzhPLQrMvMiTXK6UICh5TpvlVHhzFzj0QMBDOzcDZphQ7BujWTy7WlOfVj21TkP
	 nRTQwkOqMZynrGu5vpmXoR8dpNbQC7/718uWNyqxu6Ps4okqNGxC3pdVIjKdZ75vssFsR
	 za2Salc4aImuwJJLYW2WpZmqWalL0iGhr24XsSFFEydCh4/csCVI9JOvYnqVWUT6lBCFq
	 7QCv93Kahjyq2Dvi7J/lhyyJK7Zpc+deC+1d3cvVguyrtDdp44GW+t2n16jyPvTvmdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=atc3t1qdRJ/N0Enco2WN+An2mJ/liMRXuI3veZWvxK4=;
	b=dMAsjIZuhpCqJnYvADFNtTCHc1Ps8Dqc2jwz1HNi9Zab3y6e+Mxsf2BFIc5WjGCAZI9z
	 eYDyAin1/S+Dcs1fl8CjeEQkMcSJUm0VFoyhLufHHbKTBwiQUGb7CnOEjgPnrYSzhhn4H
	 jkhPc0GCVvuV+77lFQ5VydXxLZtDSCffwlqWc5M2AeJmmIPjTzPZCa4PMuCns9Rz+DPR1
	 tQ+I+fTzkKIvKYC8cHDflIk1KLSQnU+r74Nd3HOvSOIKYOd39AKDdDsdffjyA4Co7435i
	 gp8rA88F3KfkQdL7UuDWvBiKVw9BsvYafyk6L6EbXcj+JIXKdivNaxWlNrGLhnYYHig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I4Lo/sKL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4Lo/sKL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4800E1F0089F;
	Sat,  7 Nov 2026 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050208;
	bh=atc3t1qdRJ/N0Enco2WN+An2mJ/liMRXuI3veZWvxK4=;
	h=From:To:Cc:Subject:Date;
	b=I4Lo/sKLkTfopN045aWFm2zHFHMbDPZQYDVPwy3Bbnpw6I5o/3KRenSlPXd7k7qVd
	 8m8pv2t+T+8hx/vkJ/AzDfF69BGdhkWH/GzzaTTn+6kmVXz7vgAi7CPgSZhOlTC0Z7
	 qiUw0RT8/wG61B1h0HNmf4j7MHBpa1TQV/T0tOv2LUZbUdvG0qN6WDXUdzYReGAElZ
	 lCKEx3+exDLQGcp+g0RAhG0pxIxFn8iPvtYc1y6owOOgy5AwGha8+NtQ/ulopIvpYn
	 vz/ZL8KuDzwlsl+RhGcC6DmyXCcm3lqPV7IuxgJc+d1jg9xcCUJ/xOX+VDTvGuIYkc
	 F0snL4kS1PkcA==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	ehristev@kernel.org,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: atmel-isi: release unregistered video device on remove" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:47 -0500
Message-ID: <20261107061646-failed-5.10-c0a6d78dad3a@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c0a6d78dad3af1def80f04df82bfd70456ec406c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061646-failed-5.10-c0a6d78dad3a@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c0a6d78dad3af1def80f04df82bfd70456ec406c Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 15 Sep 2026 19:25:10 +0800
Subject: [PATCH] media: atmel-isi: release unregistered video device on remove

atmel_isi_probe() allocates the video device before registering the
V4L2 async notifier. The video device is registered later from the
notifier complete callback once the remote subdevice has been bound.

The remove path relies on the notifier unbind callback to unregister
the video device. However, if the remote subdevice is never bound, or
the complete callback fails before video_register_device() succeeds,
the video device remains unregistered. In that case the unbind path
does not release the object allocated by video_device_alloc(), and the
remove path leaks it.

Only unregister the video device from the unbind callback when it has
actually been registered, and clear the driver pointer afterwards.
After unregistering and cleaning up the notifier, release the video
device directly if the pointer is still present. This covers devices
that were allocated but never registered while avoiding a second
release of successfully registered devices.

This issue was found by manual code inspection.

Fixes: d12c9088c0b2a ("[media] atmel-isi: remove dependency of the soc-camera framework")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/platform/atmel/atmel-isi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index f5e85271a275a..fa33d11f736fc 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1121,10 +1121,13 @@ static void isi_graph_notify_unbind(struct v4l2_async_notifier *notifier,
 {
 	struct atmel_isi *isi = notifier_to_isi(notifier);
 
+	if (!video_is_registered(isi->vdev))
+		return;
+
 	dev_dbg(isi->dev, "Removing %s\n", video_device_node_name(isi->vdev));
 
-	/* Checks internally if vdev have been init or not */
 	video_unregister_device(isi->vdev);
+	isi->vdev = NULL;
 }
 
 static int isi_graph_notify_bound(struct v4l2_async_notifier *notifier,
@@ -1323,6 +1326,8 @@ static void atmel_isi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	v4l2_async_nf_unregister(&isi->notifier);
 	v4l2_async_nf_cleanup(&isi->notifier);
+	if (isi->vdev)
+		video_device_release(isi->vdev);
 	v4l2_device_unregister(&isi->v4l2_dev);
 }
 
-- 
2.53.0




