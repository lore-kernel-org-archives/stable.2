Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182504DB54D;
	Wed, 29 Jul 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338604; cv=none; b=HzQ3DhwWYtl6nu74cBP6wIYIxbBAfYHSTLJOpxKmdKmpgg0n4Fam3oBMCT3V9a5saDzpJSuFeppY7ONZBcpF1y4Pr1p8a9HED7NDQkuWYs83CZhclgEHVjFoTdmZfs/6tX3J6heVx2zEIgJbPj/xHafx7ggm98YYVOA6oXrVAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338604; c=relaxed/simple;
	bh=JhRsa/+QJ/5jIRYkq2jU5uCGsEOE/Y+PdGu7VsOeChY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU5D47ItyArv21WLl+ND207ydl78zyvZdSOI0A9hh2EaJL/DhTunj5dLUHKuqYboHukjjiNJglFSw4fLewxQkAFcbUQOmKdk/6SFStIZeRg3YsALrqSENB2D519RKCkUyY83tdNmujGXx56p+44NRRneRjvIa715wUEO2bgeJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=aP7ZMSMr; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Qu/jsoQD; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="aP7ZMSMr";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Qu/jsoQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338599; bh=JhRsa/+QJ/5jIRYkq2jU5uCGsEOE/Y+PdGu7VsOeChY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aP7ZMSMrKTTXhdaq6ocEnxKw1TYEP/vyvF9gcVNnkWIqmdkaCyx95zsy1V1V8yI+Y
	 t9mqevrwZUioKVPCFrEltPu0PLoS7QeX+T4M+OIK1Rf68OLGaBT5sLPi5XhKqp4gPi
	 /CYg1id5yH3PWI1zuq3p5yx8S8Mw0+U4pPKxXDfRqOu6rBHhmqVEJHvRUInYQ9kSkE
	 Mq+ApoxLzvckPfGgO5VFVh+C8xKVlHcvFwdFRq1tcfa8fTVvInIXoGdBqSl2RHZ7lH
	 Dvu5P8MgKxvfmPm9bUG4qF+BaBNH2VflwqetPrN0EmfdryOeL5Hb0GA9OHQrFXoCuF
	 aq3/aNoavlwSQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id D343942548; Wed, 29 Jul 2026 16:23:19 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338598; bh=JhRsa/+QJ/5jIRYkq2jU5uCGsEOE/Y+PdGu7VsOeChY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qu/jsoQDdxe+5yQW8bK7YAj/a2j9NLkQsjNKlqFU2jcWQtYdOMkF9FyjpI+dpBvip
	 4JqDVasgi7NXB5pXvdi9YqlXWqs5YTavj9qF+aDP+XMrJZBQMbDq53fOnspZN4C9yY
	 90jjLyLNjPmyjkBy0lMATtt7TiBKlCdyFPQ9Us6JTfbO7W9Clvijh3aBt/XDXWR9tX
	 qYH7r931K5j4qIZJQPIgGhbSXY2lO4HHyuVrUvBTGPlsiFDpjff7u1IIhW17hu8PFb
	 EAAabhhGKYk9OkH7C1vRHTubwQ05H1p4T8RxX04ysIH2HKx9Ec0BWrvf/X6HRYkYqd
	 Uqu/EcSDN7T9g==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 0C21142556;
	Wed, 29 Jul 2026 16:23:18 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 15/15] media: rc: Fix use after free in bpf progs
Date: Wed, 29 Jul 2026 16:22:53 +0100
Message-ID: <4e85ac724e45244099b242747684529016c5ed83.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
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
index 86de1b26731d..54b323becb1f 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -632,8 +632,11 @@ void ir_raw_event_free(struct rc_dev *dev)
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
@@ -643,9 +646,6 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 {
 	struct ir_raw_handler *handler;
 
-	if (!dev || !dev->raw)
-		return;
-
 	/*
 	 * After ir_raw_event_unregister() is called, an sync
 	 * call to ir_raw_event_handle() can still arrive. This function
@@ -665,11 +665,6 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 
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

