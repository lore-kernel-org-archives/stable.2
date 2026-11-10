Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320215;
	b=TLOUVTQBwXPF75aKwlZlpFQNizSeHnW234k57wt/PsA0UckVIKovkXHo6oQ5PxnSlV0J
	 lRAuppF+VV/8cKHFzYVOQjWeCcPpHTYxr63LkZKYqc7usT/dNHj2mniYtMibLReWMf/Dq
	 vfMdLHRNDUT2/9uSVMpKW+Zw36Xg04vMqAcM6xsFA4nHR9G/66IYAlP3NtoVJyn7fTeYU
	 fseDdl8u1BFByMHLocp2NrWU59kVMFd1QaBloVVAtEUA1rmvR4WB6z6BEC22Gj71Lo3A3
	 5jvAnQK9DVqU2RLLuOqXT5HoroBj7HlCuPJR3oNSmJ5TJfOoqxuN28yZxbzNem5+XSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JoUVayiuI9v81z48bbNEROSCPBJgInqLvaekhmzI0kY=;
	b=VICpfJOhkLz4O0sYTlSmSPMSq34mnjiQJv6ctGtQOaQTeZvvEIQZDNOeeaXn6Kp91Uvx
	 PK3BWzAvyti1lbu+4ug3aPERyHCSoDhC3iq+a26813bjm5txhTEp9KQ2lqsNBdxzgmYqI
	 ROnNZBt8rKQr9wBKlpT56tNhSgVCnxmGZaSf8+wyVamLkngA0LRuCWeTRBUvqF31eMPia
	 9En+9fNCElIORcAZWCbA8ATUtCRVldoHPbbOAlRW8SU0stktJBVib1cgxBEyTtqeFxgz8
	 QVYLBw8EN3WLgl1Y7UJak8xeE0tysNMXwPurd76QEXn78dRoj21spOlJeBD/YiL+Giw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYmParPB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10B60A2601
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYmParPB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3021F008A1;
	Tue, 10 Nov 2026 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320214;
	bh=JoUVayiuI9v81z48bbNEROSCPBJgInqLvaekhmzI0kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DYmParPBx/VMbneQPLpcDXjyG7hgFbDmxJNJYUm9GYw0zBRH9LZnakQZT3Ej0BBs1
	 yZJS+mbplZw1NxlZ8tSVDNnln1dpjRBcMQA2NtQUHdTEKwXhqn6Q3GkV00csdtp+b8
	 7WsHvN4XVfSBTvS3OOFNOTsCEA1e9uNCIiqVYzLHNBlkmHrEJvCrd8PggL+upgQu53
	 Uci2oUpJ0/NVEdNvM3QR8qOqc+gfx477dmxaBlOL2TrQR0tK16ifHuo23+T1NE1Lqp
	 UzFT+2+OKRDrwX5iogOrDXKohPbO6eaC8tdXMxrT5cXOYjEhD1D4+VPPuQuYi2qxna
	 sgtipjLmU4etg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] ALSA: control: Track in-flight control read/write/tlv accesses
Date: Tue, 10 Nov 2026 09:16:49 -0500
Message-ID: <20261110141408.1841234-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141408.1841234-1-sashal@kernel.org>
References: <20261107061731-failed-5.10-ad63c5b62843@kernel.org>
 <20261110141408.1841234-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit e94fdbd7b25d87e64688bb109e2c550217a4c879 ]

Although the power state check is performed in various places (e.g. at
the entrance of quite a few ioctls), there can be still some pending
tasks that already went into the ioctl handler or other ops, and those
may access the hardware even after the power state check.  For
example, kcontrol access ioctl paths that call info/get/put callbacks
may update the hardware registers.  If a system wants to assure the
free from such hw access (like the case of PCI rescan feature we're
going to implement in future), this situation must be avoided, and we
have to sync such in-flight tasks finishing beforehand.

For that purpose, this patch introduces a few new things in core code:
- A refcount, power_ref, and a wait queue, power_ref_sleep, to the
  card object
- A few new helpers, snd_power_ref(), snd_power_unref(),
  snd_power_ref_and_wait(), and snd_power_sync_ref()

In the code paths that call kctl info/read/write/tlv ops, we check the
power state with the newly introduced snd_power_ref_and_wait().  This
function also takes the card.power_ref refcount for tracking this
in-flight task.  Once after the access finishes, snd_power_unref() is
called to released the refcount in return.  So the driver can sync via
snd_power_sync_ref() assuring that all in-flight tasks have been
finished.

As of this patch, snd_power_sync_ref() is called only at
snd_card_disconnect(), but it'll be used in other places in future.

Note that atomic_t is used for power_ref intentionally instead of
refcount_t.  It's because of the design of refcount_t type; refcount_t
cannot be zero-based, and it cannot do dec_and_test() call for
multiple times, hence it's not suitable for our purpose.

Also, this patch changes snd_power_wait() to accept only
SNDRV_CTL_POWER_D0, which is the only value that makes sense.
In later patch, the snd_power_wait() calls will be cleaned up.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20210523090920.15345-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: ad63c5b62843 ("ALSA: core: Check shutdown flag at D0 power-state, too")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/core.h        | 42 +++++++++++++++++++++++++++++++
 sound/core/control.c        | 23 +++++++++++++----
 sound/core/control_compat.c |  5 +++-
 sound/core/init.c           | 50 +++++++++++++++++++++++++++++++------
 4 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 85610ede9ea01..ac915ce0f3aa1 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -125,7 +125,9 @@ struct snd_card {
 
 #ifdef CONFIG_PM
 	unsigned int power_state;	/* power state */
+	atomic_t power_ref;
 	wait_queue_head_t power_sleep;
+	wait_queue_head_t power_ref_sleep;
 #endif
 
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
@@ -148,12 +150,52 @@ static inline void snd_power_change_state(struct snd_card *card, unsigned int st
 	wake_up(&card->power_sleep);
 }
 
+/**
+ * snd_power_ref - Take the reference count for power control
+ * @card: sound card object
+ *
+ * The power_ref reference of the card is used for managing to block
+ * the snd_power_sync_ref() operation.  This function increments the reference.
+ * The counterpart snd_power_unref() has to be called appropriately later.
+ */
+static inline void snd_power_ref(struct snd_card *card)
+{
+	atomic_inc(&card->power_ref);
+}
+
+/**
+ * snd_power_unref - Release the reference count for power control
+ * @card: sound card object
+ */
+static inline void snd_power_unref(struct snd_card *card)
+{
+	if (atomic_dec_and_test(&card->power_ref))
+		wake_up(&card->power_ref_sleep);
+}
+
+/**
+ * snd_power_sync_ref - wait until the card power_ref is freed
+ * @card: sound card object
+ *
+ * This function is used to synchronize with the pending power_ref being
+ * released.
+ */
+static inline void snd_power_sync_ref(struct snd_card *card)
+{
+	wait_event(card->power_ref_sleep, !atomic_read(&card->power_ref));
+}
+
 /* init.c */
 int snd_power_wait(struct snd_card *card, unsigned int power_state);
+int snd_power_ref_and_wait(struct snd_card *card);
 
 #else /* ! CONFIG_PM */
 
 static inline int snd_power_wait(struct snd_card *card, unsigned int state) { return 0; }
+static inline void snd_power_ref(struct snd_card *card) {}
+static inline void snd_power_unref(struct snd_card *card) {}
+static inline int snd_power_ref_and_wait(struct snd_card *card) { return 0; }
+static inline void snd_power_sync_ref(struct snd_card *card) {}
 #define snd_power_get_state(card)	({ (void)(card); SNDRV_CTL_POWER_D0; })
 #define snd_power_change_state(card, state)	do { (void)(card); } while (0)
 
diff --git a/sound/core/control.c b/sound/core/control.c
index 7b76518e862ec..e5b8c4393c1a9 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -987,7 +987,10 @@ static int __snd_ctl_elem_info(struct snd_card *card,
 #ifdef CONFIG_SND_DEBUG
 	info->access = 0;
 #endif
-	result = kctl->info(kctl, info);
+	result = snd_power_ref_and_wait(card);
+	if (!result)
+		result = kctl->info(kctl, info);
+	snd_power_unref(card);
 	if (result >= 0) {
 		snd_BUG_ON(info->access);
 		index_offset = snd_ctl_get_ioff(kctl, &info->id);
@@ -1079,7 +1082,10 @@ static int snd_ctl_elem_read(struct snd_card *card,
 
 	if (!snd_ctl_skip_validation(&info))
 		fill_remaining_elem_value(control, &info, pattern);
-	ret = kctl->get(kctl, control);
+	ret = snd_power_ref_and_wait(card);
+	if (!ret)
+		ret = kctl->get(kctl, control);
+	snd_power_unref(card);
 	if (ret < 0)
 		return ret;
 	if (!snd_ctl_skip_validation(&info) &&
@@ -1145,7 +1151,10 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	}
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
-	result = kctl->put(kctl, control);
+	result = snd_power_ref_and_wait(card);
+	if (!result)
+		result = kctl->put(kctl, control);
+	snd_power_unref(card);
 	if (result < 0) {
 		up_write(&card->controls_rwsem);
 		return result;
@@ -1633,7 +1642,7 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 		{SNDRV_CTL_TLV_OP_CMD,   SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND},
 	};
 	struct snd_kcontrol_volatile *vd = &kctl->vd[snd_ctl_get_ioff(kctl, id)];
-	int i;
+	int i, ret;
 
 	/* Check support of the request for this element. */
 	for (i = 0; i < ARRAY_SIZE(pairs); ++i) {
@@ -1651,7 +1660,11 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 	    vd->owner != NULL && vd->owner != file)
 		return -EPERM;
 
-	return kctl->tlv.c(kctl, op_flag, size, buf);
+	ret = snd_power_ref_and_wait(file->card);
+	if (!ret)
+		ret = kctl->tlv.c(kctl, op_flag, size, buf);
+	snd_power_unref(file->card);
+	return ret;
 }
 
 static int read_tlv_buf(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id,
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 980ab3580f1b7..3c58741c674f7 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -187,7 +187,10 @@ static int get_ctl_type(struct snd_card *card, struct snd_ctl_elem_id *id,
 		return -ENOMEM;
 	}
 	info->id = *id;
-	err = kctl->info(kctl, info);
+	err = snd_power_ref_and_wait(card);
+	if (!err)
+		err = kctl->info(kctl, info);
+	snd_power_unref(card);
 	up_read(&card->controls_rwsem);
 	if (err >= 0) {
 		err = info->type;
diff --git a/sound/core/init.c b/sound/core/init.c
index 476ab6df3aeb9..f5b97ebba1c18 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -218,6 +218,8 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	mutex_init(&card->memory_mutex);
 #ifdef CONFIG_PM
 	init_waitqueue_head(&card->power_sleep);
+	init_waitqueue_head(&card->power_ref_sleep);
+	atomic_set(&card->power_ref, 0);
 #endif
 	init_waitqueue_head(&card->remove_sleep);
 	card->sync_irq = -1;
@@ -434,6 +436,7 @@ int snd_card_disconnect(struct snd_card *card)
 
 #ifdef CONFIG_PM
 	wake_up(&card->power_sleep);
+	snd_power_sync_ref(card);
 #endif
 	return 0;	
 }
@@ -995,21 +998,28 @@ EXPORT_SYMBOL(snd_card_file_remove);
 
 #ifdef CONFIG_PM
 /**
- *  snd_power_wait - wait until the power-state is changed.
- *  @card: soundcard structure
- *  @power_state: expected power state
+ * snd_power_ref_and_wait - wait until the card gets powered up
+ * @card: soundcard structure
  *
- *  Waits until the power-state is changed.
+ * Take the power_ref reference count of the given card, and
+ * wait until the card gets powered up to SNDRV_CTL_POWER_D0 state.
+ * The refcount is down again while sleeping until power-up, hence this
+ * function can be used for syncing the floating control ops accesses,
+ * typically around calling control ops.
  *
- *  Return: Zero if successful, or a negative error code.
+ * The caller needs to pull down the refcount via snd_power_unref() later
+ * no matter whether the error is returned from this function or not.
+ *
+ * Return: Zero if successful, or a negative error code.
  */
-int snd_power_wait(struct snd_card *card, unsigned int power_state)
+int snd_power_ref_and_wait(struct snd_card *card)
 {
 	wait_queue_entry_t wait;
 	int result = 0;
 
+	snd_power_ref(card);
 	/* fastpath */
-	if (snd_power_get_state(card) == power_state)
+	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0)
 		return 0;
 	init_waitqueue_entry(&wait, current);
 	add_wait_queue(&card->power_sleep, &wait);
@@ -1018,13 +1028,37 @@ int snd_power_wait(struct snd_card *card, unsigned int power_state)
 			result = -ENODEV;
 			break;
 		}
-		if (snd_power_get_state(card) == power_state)
+		if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0)
 			break;
+		snd_power_unref(card);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(30 * HZ);
+		snd_power_ref(card);
 	}
 	remove_wait_queue(&card->power_sleep, &wait);
 	return result;
 }
+EXPORT_SYMBOL_GPL(snd_power_ref_and_wait);
+
+/**
+ * snd_power_wait - wait until the card gets powered up (old form)
+ * @card: soundcard structure
+ * @power_state: expected power state
+ *
+ * Wait until the card gets powered up to SNDRV_CTL_POWER_D0 state.
+ * @power_state must be SNDRV_CTL_POWER_D0.
+ *
+ * Return: Zero if successful, or a negative error code.
+ */
+int snd_power_wait(struct snd_card *card, unsigned int power_state)
+{
+	int ret;
+
+	if (WARN_ON(power_state != SNDRV_CTL_POWER_D0))
+		return 0;
+	ret = snd_power_ref_and_wait(card);
+	snd_power_unref(card);
+	return ret;
+}
 EXPORT_SYMBOL(snd_power_wait);
 #endif /* CONFIG_PM */
-- 
2.53.0

