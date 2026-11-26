Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674988;
	b=TjB2DRbPcuBF7J22MpUxzo8rCINJb4nDVWNGoVxRSSH5bnfjanGipgLDUvMRzP7KBIsK
	 CyHwv7QvPvqEZ0Ajs6NzHpY8hD/6LTE8yujLhFPYjTY9PJPHTiU44EGoP+dlUybPt/3YZ
	 LPHF/ZPH8ZLNhuGCfIuAmqz/Rer+tadTIXXcFTDZJU7oiv5n5hZzXhSb1S59KzxDdORfw
	 x1QMNpbxlYIiy0smxYXUHpWjsQ4zwME0RiXyTWa41hKptsBuVWv5uQtF+9RWGxaRdPuka
	 3e97QPxgmDawiZhpqb3nBBN4N02ujR/2QUEK70NEg1P51UshGFL7w65mKowsLmzshWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674988;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=pX+a3pAm0+kczIi67t1E7b8PvmEcUnVZOk0Q1Sv3XT8=;
	b=R75qYSZYwBxKz0oy1+QhD7tBVj/g2cCK4DASZookriqd0+a9p3duOHAyHjPoR/pFu9VA
	 wDDquEcpyUd/kYmcj7EfCDdcTHOWhfQufbQrPLsesl9VmLlbvZtHbzlH/LBSTEdWKtfA2
	 p2hj0cJXud0MowbgIS8X8U9w6E+9p9AFS+nXGHYmZjbIV54qPhzei5YDU3Xkq9uyOIpAz
	 s8vbFwUfvV3hUoWRs626onf7DKmMd71xynpVY9H/8rhLmYmZVeEyjoLM7T1pECauPyRNf
	 J4JjHcj52ZO3VQqG/cHSp7JoWl/uAhIL+GBTzFRkyGJzoZsWCuEP0D33GCrLUdotyVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gklqrzc2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C3606A326;
	Thu, 26 Nov 2026 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gklqrzc2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674987;
	b=0drhnaBOOVEbovWxwefSpn/MQiSOHydl5wnEQt0FWddc/RQdxF5QFE5grWX7FNomSXV+
	 Khz4u1mC74dHDtn5SiTOV+onEzxaWZJhZu9cU8wdUzkz2yhRwf6IQv5IHqhRieVaH1nB1
	 oWCsIN6wAGQZKxs1hRdoS66zWvHgdSk0yidBjeIYK3w0TlvmcavbDTHNSRtQ++/RMd5vT
	 f/h334o9vabDvZP67QgYrIjPKMvkJtrgKix+k2pqjJxWjCEEuEkUO1lmdzySfKEH9Q4QI
	 IqH5Dez8uQ6ad5ZbFGentJiA4KcHMgRymEGw16gP2BXs+i64LEo/z6RtVL1ZvzQMhQw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674987;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=pX+a3pAm0+kczIi67t1E7b8PvmEcUnVZOk0Q1Sv3XT8=;
	b=JD0Dj8QWJ+l19caxHVC8o4Iy/C61w18RDCjt8TDDmXlNu5r54lb5BlQWw00emxOBPXiw
	 IzPLcqwTDOFBf3Yre7nMs29k/4alqk0aolsvN3/RHMEaYaeLswxWPBxzSUnegkXdpuWpc
	 ZSStJn2EiH30/hWf3Ac/R5PKZ8ejEAVFkXUo4mg2mrvUWBIeXNppVEBe+HuqK/rWYSKx/
	 6hWGuRRszurURuWg9Q9eWeywUjwaDjEXdgRtX3dPXPeFdshzE4tPH4y/2mEGuiJnSa8Ec
	 fzXOWUIzSNWFs4D76RYKcAbt+aLp+RYt6c4Q3rZxrkjiWHMGUSMl4YRicI8iGP7J+cw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C9FE01F000D2;
	Thu, 26 Nov 2026 06:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674987;
	bh=pX+a3pAm0+kczIi67t1E7b8PvmEcUnVZOk0Q1Sv3XT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gklqrzc2drXwT7t916+t/fxi27+aVgQ+O/gq4SZS76Z8MO/QlmswRxPYh6AMFzSLO
	 s7QcvZYheoXw9u9P3yreFNr6qBCvelByywzdnDI5Y/Xa/mpoYrAAYCEkfnncPReesk
	 oe+qUNR98mgWhnXPxMs/Hr1sYFZc7UhfOwlo2/Ok9F/ezG20MOo5ySGKFvgjGaJB3x
	 JrXCEqWqQTfGItsnmJCDovJJc0kaa24RO8NbhLFaYTZu6sy3Dr3IHxaE890BjXCb1g
	 RAUKvRsC8hq6ynbEuvS0cN/I8FwFMwF+9xgrcSYn5MuFF+8z0/BrPj2CM6SBhPGk3f
	 YxqRRGj0f/QOA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 32EC14D291;
	Thu, 26 Nov 2026 06:35:57 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 06:18:44 +0000
Subject: [PATCH 6.12.y v2 4/4] virtio_balloon: quiesce balloon work before
 device shutdown
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-virtio-final-v2-4-4cfd5590e924@certik.com>
References: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
In-Reply-To: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
 Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795673921; l=3090;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=YxT0JEcZt8be1Aod6X8plRSlx7+82SPoYFncZ9ti8IE=;
 b=UgO1apl0z0LJE8kVRiZ9zir503rVvLFWs8V6CuuHmaeib+SvAPyv1AFZA3rdymu7RxtiqSiJP
 xs6LPUIMkX8Au/Y6X6+61gROyuFmnawCJvKoLCtaPjsnOkTdwaQZdUe
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: "Denis V. Lunev" <den@openvz.org>

commit 7e17eef04600c399c7e0f5ce765da5cf9d40d8e1 upstream.

Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()") added a generic virtio bus .shutdown handler that
breaks and resets every virtio device during device_shutdown(), i.e. on
reboot and kexec.

virtio_balloon provides no .shutdown of its own, so that generic path
runs while the balloon's asynchronous work is still armed. Once the
device has been broken, virtqueue_add_inbuf() in
virtballoon_free_page_report() returns -EIO and trips its
WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
ordinary reboot, for example a kexec based upgrade, into a fatal panic
in the middle of device_shutdown(), so the machine never reaches the
new kernel.

Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
inflate/deflate and OOM paths do not warn, they call
wait_event(vb->acked, ...) and would instead block forever on a broken
queue that can no longer complete. The device has to be quiesced, not
just kept quiet.

Add a .shutdown handler that quiesces the balloon via the shared
virtballoon_quiesce() helper while the device is still alive, and only
then breaks and resets it via virtio_device_shutdown(). Unlike
virtballoon_remove() the balloon workqueue is not destroyed, as shutdown
does not free the device and cancel_work_sync() together with stop_update
already prevent any further work from being queued.

Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260624140846.2616797-4-den@openvz.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
 drivers/virtio/virtio_balloon.c |    7 +++++++
 1 file changed, 7 insertions(+)

Changes in v2
v2: resent through a whitespace-safe path; v1 <CAFaZ9epp-Y8efod8a7CQuQqYEjk5L_ruwP+c1SoBRPjdu9uGyQ@mail.gmail.com> was damaged by my mail client and does not apply.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 726aef5be178..efa77daa93b8 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1159,6 +1159,12 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	kfree(vb);
 }
 
+static void virtballoon_shutdown(struct virtio_device *vdev)
+{
+	virtballoon_quiesce(vdev->priv);
+	virtio_device_shutdown(vdev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int virtballoon_freeze(struct virtio_device *vdev)
 {
@@ -1229,6 +1235,7 @@ static struct virtio_driver virtio_balloon_driver = {
 	.validate =	virtballoon_validate,
 	.probe =	virtballoon_probe,
 	.remove =	virtballoon_remove,
+	.shutdown =	virtballoon_shutdown,
 	.config_changed = virtballoon_changed,
 #ifdef CONFIG_PM_SLEEP
 	.freeze	=	virtballoon_freeze,


