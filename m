Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674986;
	b=pfRPv7ms0jjWlpRs1gqZe2lBLQ4y9wDzViag3nouaEREgJ0LP7bumOZCxtEEYJc1wwLT
	 4zCHQSBN0M/hT5qPzWEzwZS49C+B6MlYfIPjP7CMDMpwwsjHRGRfMAX8boCH0dbhjnHz6
	 90okPCyk+FG55evfrfrf4xr5YZMrJE6cstoa5VznkU8s4N3bCuV+ARbovCoJMxf4Gaef5
	 S5MLXXnV8EKDPQHc+i1lmHihy9lpF+2ELcKkDiMOgyaJEVzzDXjO4LFqsx1bwGf77K8rj
	 OUqYc8cuyBNoU8FXI/8AJL813obCDHtHTM5lbjCbflqB7SNie8+yqiCANnV9KQeWI9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674986;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ac1Ikm+0oUYJ7NoGwgsIR9r0KMDjWbZv2G87ig7VjRE=;
	b=tykwdYNvolTnpOmcBCFW6ZnQczTIf+sqgb008+8CXNwGe9ID/xmUA0YSokPDQ4ct2G00
	 xKURjr6g2j+WR1LlMBz6foiYLZ5glqrgrLKx5jUztJGGusfwJFd7gbBHmRK5EWVwheiMY
	 3f6FS4Llr9WYAR165EA1w8bB7Hy73foGYQYI4V0QoP3B+vZo4zn1JANJSN5rI/40EWxeu
	 9oIQvRbxYejHItRWFDVXG2AoceAQj9k8J/IHY2lFX8nf0zx4pyeJlmGRbXYRxilnwTi27
	 a9XrfYai4n3tpH6yhfVcPPxLA+qffCtgnkUVgyD9BCauvpHeD34LqFBXy6kjjYpUiag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dm8Vdzys;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0389606A31C;
	Thu, 26 Nov 2026 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dm8Vdzys
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674986;
	b=HYwoYTV7VCyWdr1zsXsjaxEhSVbD/hvEOen4zJh/+7cLZEmtDhi/dU4zcS4WtQ7N90Pd
	 bi/F9R5o6ycDwP/k7zQf88ksRZNEFDNJ701lWhxOuDTn/cWYgcWUPjtoTVmNW4/5LC9x7
	 E8sUzYaV46UhJJ+vWY/qwFKmfnrPdfJUKGH82SGFSsMgGMO0Vt9un3JCNYRKs8oQZpGxY
	 4Mos4r4H/OKv6fcmliUiXPbvnfQiD5DESrS6PJ5wo+O8J5TyrRjgsvXNerSZr3FPnKAde
	 ocwiavFaDyJNs1lZLAV5DieKHHJqa/J4mqQR8XdlfFYxS7l2xhDdBplfPylbgKrhWTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674986;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ac1Ikm+0oUYJ7NoGwgsIR9r0KMDjWbZv2G87ig7VjRE=;
	b=mSrXut7+j3Mcc6KnKxnhlh6s1su8sj9qsZKx+psZO/KiANaGCG/d2kuKslJlebPJZicj
	 WOIRI4r0QG9ElObOZHp9aRLR9OvFoo2lqo0AQ6qucZwv4SjsJ32lD4k2rc7ZY4OsHUvH7
	 K+7whiDdt2L4MQe68cUrmUqouyL68uSq+tfysbziflJRHuALQVv1xhHYKk+IZvMRDFGEq
	 iqh3sBbr/CyaTdNq7WbUMvbHPuh1iYlos0FXQ23PZ68OKKM6+mxaUgEHzSOaZr0dtSSqF
	 Q9PfQyCYtQ6oz5w4zHJImkN6Uz9kejD4dU6uTaRL7JbvjiOsZx7xOnsVzHTblL2go0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C3DFC1F000CF;
	Thu, 26 Nov 2026 06:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674986;
	bh=ac1Ikm+0oUYJ7NoGwgsIR9r0KMDjWbZv2G87ig7VjRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dm8Vdzys+IyPKd71LRZ81B0Uc1OswETRrg/mcvejV0FeIs/PcLUevILJeJxkwgEn9
	 gkx3tCWiK45uRxooTyjCASwGN64KfafLSTIvK2QUXNEnz6vcaiQ3T1y8snhopRN3BF
	 lmbyUXEYDc4l5vYAhkMVlzmnVpqKwaSiM6FEkJlS89TmZwCz3qQRkbUtnNOnMvBb7+
	 uSJHmlxFvsJNei2/Pq+kmPIkuuwioPvSP81bq4vTjNiM7IvMk5h+rn1JWygVpUQOJc
	 Z12K8rvYnAiB2MofTptxyZ+RncEBtu+Tys7LwMwyXsjh3lctLM6HkQd4SMKUrKlnHH
	 Bambavahz1rnw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 146F74D28D;
	Thu, 26 Nov 2026 06:35:57 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 06:18:43 +0000
Subject: [PATCH 6.12.y v2 3/4] virtio_balloon: factor out
 virtballoon_quiesce()
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
Message-Id: <20261126-virtio-final-v2-3-4cfd5590e924@certik.com>
References: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
In-Reply-To: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
 Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795673921; l=3100;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=Y4oTZs4IcsIFztVC2+YESkhgwty/uTkVeQ1e6nZ6dz4=;
 b=qcdJBRYmbcXtqUu829O7b9u5P6UaWBHYczeECADq2OQHpdNioD/XsyoLiv70jw7bwszYUeAgY
 DGoI7CTXSMXDHdG24+K8PTWibQzI/bzg/3nWMQuihsOslkFRgZiudUd
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: "Denis V. Lunev" <den@openvz.org>

commit 29536a923a9412812eb3e378258019b54538a220 upstream.

virtballoon_remove() stops all of the balloon's asynchronous work (the
free page reporting worker, the inflate/deflate and stats workers, the
OOM notifier and the free page shrinker) before tearing the device
down. A following change needs the same teardown from a .shutdown
handler, so move it into a virtballoon_quiesce() helper.

No functional change.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260624140846.2616797-3-den@openvz.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
 drivers/virtio/virtio_balloon.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

Changes in v2
v2: resent through a whitespace-safe path; v1 <CAFaZ9eopsb3vgcpzOjiZ500oafv02QzNV3dEUrvOMN1vV90RuQ@mail.gmail.com> was damaged by my mail client and does not apply.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c67b29e5f799..726aef5be178 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1121,26 +1121,39 @@ static void remove_common(struct virtio_balloon *vb)
 	vb->vdev->config->del_vqs(vb->vdev);
 }
 
-static void virtballoon_remove(struct virtio_device *vdev)
+/*
+ * Stop all asynchronous balloon work. The device must still be alive so that
+ * in-flight requests can drain via the host before it is reset or freed.
+ */
+static void virtballoon_quiesce(struct virtio_balloon *vb)
 {
-	struct virtio_balloon *vb = vdev->priv;
+	struct virtio_device *vdev = vb->vdev;
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING))
 		page_reporting_unregister(&vb->pr_dev_info);
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
+
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update = true;
 	spin_unlock_irq(&vb->stop_update_lock);
 	cancel_work_sync(&vb->update_balloon_size_work);
 	cancel_work_sync(&vb->update_balloon_stats_work);
 
-	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		cancel_work_sync(&vb->report_free_page_work);
+}
+
+static void virtballoon_remove(struct virtio_device *vdev)
+{
+	struct virtio_balloon *vb = vdev->priv;
+
+	virtballoon_quiesce(vb);
+
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
-	}
 
 	remove_common(vb);
 	kfree(vb);


