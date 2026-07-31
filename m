Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415330B502
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465661; cv=none; b=V5hHdSHQtveHRxl6kee4MvyxzgoYKoKaWeFgY8XZT5crjaM6OUVdt920vLEn4W7Dbb50ZBFPpKb3rhRjb1JFgYh6xTByAmSbn0byZxjFMH/gvYIcAYzjIsfmDZfCRJAb/iXsEhKzRYMcguA1utp2IA5Hkzu1z/M490PKx0Egnrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465661; c=relaxed/simple;
	bh=0faRj8fp6uH65E0DzSeuecSo80Tw5OP3V5iAm//kRio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+TgyUVXQi4IIAY2DjqxueKJOZKRfqSNLssVe4zRdgITP2GE6dtFvDkoTQn0+eYx4f0XxR26CNJztKKUlQ529oHn5PgJqI9x3myxzXcTDsP+6CYJwq/4hMGONyxi8jnQQkvVLwvb6CWDQd9HtYBF3Z/E3as9uUlQVQ1cmjXodEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DirHe8wv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DirHe8wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C851F00A3D;
	Fri, 31 Jul 2026 02:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465660;
	bh=UTXzzdi8Np288OBLMfLlcFpDxt4vc4URtuVsP+IDZQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DirHe8wvcEgkBlwFGgybJ8f3wWqLzcXn/vzq7SbkY1PNrFVaIMlSW8bmUfONhO7sA
	 9Hh2cT+qVONvxlCPWQKoeBlvuKEEg/OZEZQXjB5wH03X56BdHhisKIS1Pbc3LBgUuG
	 HgLmRkKaF/GG14FKi1qj31l3UEViU3p16kFEHEoEysd80sbQRYDYroEhd7Igf5CVfH
	 RVu0lbbb0V+qloZzeRm+qTQKQ+/jCWoksHKWhChEDfYYvYThYP0pUsDNNfz3+zP3cx
	 C9NvzeDIrWyP8SLE2FRvm5ZW5GPkjycMIH5lYwxX9F0FBbX38K3HEbx2WEd+Qoy3xG
	 oPosQk/Xb6ZPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] usb: typec: ucsi: split connector lock classes
Date: Thu, 30 Jul 2026 22:40:56 -0400
Message-ID: <20260731024057.3338855-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731024057.3338855-1-sashal@kernel.org>
References: <2026072727-giveaway-lumpiness-947f@gregkh>
 <20260731024057.3338855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 8c22256bbafad3dc5fdbe9f684d045b67ff06a68 ]

Lockdep detects a possible recursive locking scenario during
ucsi init:

[    5.418616] ============================================
[    5.418634] WARNING: possible recursive locking detected
[    5.418706] --------------------------------------------
[    5.418725] kworker/4:1/82 is trying to acquire lock:
[    5.418759] ffff888119a34648 (&con->lock){+.+.}-{3:3}, at: ucsi_init_work+0x1a78/0x2eb0 [typec_ucsi]
[    5.418801]
               but task is already holding lock:
[    5.418835] ffff888119a34080 (&con->lock){+.+.}-{3:3}, at: ucsi_init_work+0x1a78/0x2eb0 [typec_ucsi]
[    5.418884]
               other info that might help us debug this:
[    5.418904]  Possible unsafe locking scenario:

[    5.418937]        CPU0
[    5.418956]        ----
[    5.418991]   lock(&con->lock);
[    5.419013]   lock(&con->lock);
[    5.419033]
                *** DEADLOCK ***

[    5.419387] Call Trace:
[    5.419406]  <TASK>
[    5.419425]  dump_stack_lvl+0x61/0xa0
[    5.419448]  print_deadlock_bug+0x4a6/0x650
[    5.419483]  __lock_acquire+0x62b6/0x7f50
[    5.419507]  lock_acquire+0x11b/0x390
[    5.419654]  __mutex_lock+0xbc/0xcd0
[    5.419741]  ucsi_init_work+0x1a78/0x2eb0
[    5.419785]  ? worker_thread+0xf53/0x2bc0
[    5.419819]  worker_thread+0xff4/0x2bc0
[    5.419842]  kthread+0x2a7/0x330
[    5.419863]  ? __pfx_worker_thread+0x10/0x10
[    5.419896]  ? __pfx_kthread+0x10/0x10
[    5.419916]  ret_from_fork+0x38/0x70
[    5.419936]  ? __pfx_kthread+0x10/0x10
[    5.419969]  ret_from_fork_asm+0x1b/0x30
[    5.419991]  </TASK>
[    5.420009] ---[ end trace 0000000000000000 ]---

The problem is that all connector locks belong to the same
lockdep lock class, so the following loop:

	for (i = 0; i < ucsi->cap.num_connectors; i++)
		ucsi_register_port(connector[i])
			mutex_lock(&connector[i]->lock)

looks like a recursive acquire of the same mutex.  Put each connector
lock into a dedicated lock class so that lockdep doesn't see it as a
possible recursion.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260515060042.136083-1-senozhatsky@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and ordering in port unregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
 drivers/usb/typec/ucsi/ucsi.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index ad1a199d92ea..de9fc082bc7c 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1231,6 +1231,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 	INIT_WORK(&con->work, ucsi_handle_connector_change);
 	init_completion(&con->complete);
 	mutex_init(&con->lock);
+	lockdep_set_class(&con->lock, &con->lock_key);
 	INIT_LIST_HEAD(&con->partner_tasks);
 	con->ucsi = ucsi;
 
@@ -1479,6 +1480,9 @@ static int ucsi_init(struct ucsi *ucsi)
 		goto err_reset;
 	}
 
+	for (i = 0; i < ucsi->cap.num_connectors; i++)
+		lockdep_register_key(&connector[i].lock_key);
+
 	/* Register all connectors */
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
 		connector[i].num = i + 1;
@@ -1508,6 +1512,9 @@ static int ucsi_init(struct ucsi *ucsi)
 	return 0;
 
 err_unregister:
+	for (i = 0; i < ucsi->cap.num_connectors; i++)
+		lockdep_unregister_key(&connector[i].lock_key);
+
 	for (con = connector; con->port; con++) {
 		if (con->wq)
 			destroy_workqueue(con->wq);
@@ -1776,6 +1783,7 @@ void ucsi_unregister(struct ucsi *ucsi)
 		usb_power_delivery_unregister(ucsi->connector[i].pd);
 		ucsi->connector[i].pd = NULL;
 		typec_unregister_port(ucsi->connector[i].port);
+		lockdep_unregister_key(&ucsi->connector[i].lock_key);
 	}
 
 	kfree(ucsi->connector);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 2cb34913358d..9ac5ad87f401 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -350,6 +350,7 @@ struct ucsi_connector {
 
 	struct ucsi *ucsi;
 	struct mutex lock; /* port lock */
+	struct lock_class_key lock_key;
 	struct work_struct work;
 	struct completion complete;
 	struct workqueue_struct *wq;
-- 
2.53.0

