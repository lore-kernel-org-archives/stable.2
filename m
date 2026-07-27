Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDAC416866;
	Mon, 27 Jul 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158366; cv=none; b=jy38DhWfOahWplNqkPlhJ8shK9YNtbO6ZYLP1i+kvl2Cum73c2qQs1A+8kmZpSGeMrlIwpEFAx4xynwtXz5ffeLsPIDhVyr4IdI2aQlu1LDRP3IzVu9ja4eNYHMQnLRiQry8F+CyMJ/cYluugu0AICXJ0eztMAF92bJSt08eY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158366; c=relaxed/simple;
	bh=BEjytT77xW4MyGZxiMK8fMlUv45mdnYSkgth6Jo8zjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YilDLmsEBVPS2mcrC+9pPeeDFC4J0fGE6X+ZL8KHgUgLT+rMG0Z29SYc5orEiY7LN1WiIOLDg+Qh1Wyl0B1XyPDSqBc2cdeZBycc8pwQ6l4DA5N6Nc+FrjWXqeeGGXvtG/hrcwcX+spSc1wKE1Y3dpOUi1j9YruNlxGbV2fALFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=JbQgIeme; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=bLMH4gSw; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="JbQgIeme";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="bLMH4gSw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158360; bh=BEjytT77xW4MyGZxiMK8fMlUv45mdnYSkgth6Jo8zjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JbQgIemejFDNpxE0blFQGHaYJEj+CYtKGRqxEebV6E+csX4tyaif/94JyX+KrYekQ
	 ignt2m7jSM67UdfntOlSDNRoD8fAJurGAtB2cYH0ClwZwZRdvRqp7DDdEyw4q4Fuhi
	 qlPSf2o4YusOCbCsJEOZbFLIPgvUzZfZS2SIFCAaaAp4Qb4MI8tukJeSRvxos5OtLJ
	 zrRZhwEkDFpVwujw6hwM+4InWuH37lTKEeYqo0dwIp31ZQFk8tVPImyEKsSoo1VdNq
	 f58Mxj8nx74UO2T7gHPdnFMwUChlAztbDtwONBXADvi1xkWEVRTqk+wzzJ4bvH+FkA
	 ++Qhyl9461ukg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 42BBF42566; Mon, 27 Jul 2026 14:19:20 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158358; bh=BEjytT77xW4MyGZxiMK8fMlUv45mdnYSkgth6Jo8zjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLMH4gSwyrTtTPCkT27A4J6ph+mVVhGms75V1gvwpcicJaPqisexQ5hl50BxEXk7z
	 rd3YT4oi1u4gjZmNMay9j5fSHV6lgQruKMKyjocivThaqS7N6ledXIKblE+z4NRFTh
	 KsFD37TzXak1UHcGBD0irQWRn0Nf8IGqB8iGHZaoGnwFgofroFPQfR6n5nmHx2Wq1q
	 bC5A3IvoflRUuggNTZVRxzJNywV3R1pEi1HksqCDh9giNFpO2oKlXgQVH5VkYuETaV
	 4wlTc0AYBzWDVbXLG9lEg4zETOFXQxOEfKHDqFjDIT7LcKOu9wYouoYPqqWZHQec+W
	 WmKQkkgdZ9L1Q==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id CFD6D4255A;
	Mon, 27 Jul 2026 14:19:18 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 12/15] media: rc: Fix use after free in bpf progs
Date: Mon, 27 Jul 2026 14:18:55 +0100
Message-ID: <dfacc746477c6b05da4a0b1479c93d33bc310c3b.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit dccc0c3ddf8f ("media: rc: fix race between unregister and
urb/irq callbacks"), rcdev->raw is no longer set to NULL after device
unregister. raw->progs could point to stale data.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/bpf-lirc.c  | 18 +++++++++++++-----
 drivers/media/rc/rc-ir-raw.c | 11 +++--------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 2f7564f26445..14ab611e7445 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -148,12 +148,13 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
 	if (ret)
 		return ret;
 
-	raw = rcdev->raw;
-	if (!raw) {
+	if (!rcdev->registered) {
 		ret = -ENODEV;
 		goto unlock;
 	}
 
+	raw = rcdev->raw;
+
 	old_array = lirc_rcu_dereference(raw->progs);
 	if (old_array && bpf_prog_array_length(old_array) >= BPF_MAX_PROGS) {
 		ret = -E2BIG;
@@ -186,12 +187,13 @@ static int lirc_bpf_detach(struct rc_dev *rcdev, struct bpf_prog *prog)
 	if (ret)
 		return ret;
 
-	raw = rcdev->raw;
-	if (!raw) {
+	if (!rcdev->registered) {
 		ret = -ENODEV;
 		goto unlock;
 	}
 
+	raw = rcdev->raw;
+
 	old_array = lirc_rcu_dereference(raw->progs);
 	ret = bpf_prog_array_copy(old_array, prog, NULL, 0, &new_array);
 	/*
@@ -235,7 +237,8 @@ void lirc_bpf_free(struct rc_dev *rcdev)
 	struct bpf_prog_array_item *item;
 	struct bpf_prog_array *array;
 
-	array = lirc_rcu_dereference(rcdev->raw->progs);
+	array = rcu_replace_pointer(rcdev->raw->progs, NULL,
+				    lockdep_is_held(&ir_raw_handler_lock));
 	if (!array)
 		return;
 
@@ -316,6 +319,11 @@ int lirc_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (ret)
 		goto put;
 
+	if (!rcdev->registered) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	progs = lirc_rcu_dereference(rcdev->raw->progs);
 	cnt = progs ? bpf_prog_array_length(progs) : 0;
 
diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index 96849faafde3..b32f3cff9401 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -651,8 +651,11 @@ void ir_raw_event_free(struct rc_dev *dev)
 {
 	if (dev->raw) {
 		timer_delete_sync(&dev->raw->edge_handle);
+		mutex_lock(&ir_raw_handler_lock);
 		if (dev->raw->thread)
 			put_task_struct(dev->raw->thread);
+		lirc_bpf_free(dev);
+		mutex_unlock(&ir_raw_handler_lock);
 		kfree(dev->raw);
 		dev->raw = NULL;
 	}
@@ -662,9 +665,6 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 {
 	struct ir_raw_handler *handler;
 
-	if (!dev || !dev->raw)
-		return;
-
 	kthread_stop(dev->raw->thread);
 	timer_delete_sync(&dev->raw->edge_handle);
 
@@ -677,11 +677,6 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 
 	lirc_bpf_free(dev);
 
-	/*
-	 * A user can be calling bpf(BPF_PROG_{QUERY|ATTACH|DETACH}), so
-	 * ensure that the raw member is null on unlock; this is how
-	 * "device gone" is checked.
-	 */
 	mutex_unlock(&ir_raw_handler_lock);
 }
 
-- 
2.55.0

