Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602815;
	b=KLpGyPd2cpa4ZplCQ5P085cKpvwyz7ScNCLZm6fqVD+oSP6b07crGvSLTbCJAtTV+Utc
	 jEaEAsRZltkd+CqL4gki0GwJa7BtKyCrMK1dSLjhOIoQAdC2vaz1wueDxN9x0nXI+DY5u
	 EEwDiW2Cd/mCjVknSZk459DsVUjXPUvPcqIDMxR/3dYxgGAjbWB1oKN+AXVoxLRE4Er0n
	 Bc8NBJnHlO5OBYmS2efLacmyOsk2Uv/5CeQOjaZ3m13wVBx/19ju3h6Fc2JaR9KQeevhf
	 aQBR+MwEC/djqhWZwh3qnjKQqIoUr6gvmdEOhUshh9IkJKHWCaE91RulQ5oj5W9iY/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602815;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+rLDM4m/5oU6iypJTr5b10JrUOMAkqjl9EhsTVmyzOM=;
	b=2mPNZrrY2YcYgBUOOFG5KgDKFleNKdklGrIGfUsFIFQtE9RVis5tkV42Aq7m7W27eNxO
	 zBnvKgS04rY97f/1ylYpmGqan8Io+Ee+CXj/Z3nMbLhPzJEHFFmMzCBczHXXWiHItquge
	 4LDMlNeN4LdhSV2SuGrWpzbU95fpS0ET1gQ6IJjPG3NS7qW2F/qRWHaUyUbUYo+r+jqoS
	 KJVm/zvxQy8qhM4r+S7U4XioJQ+qvIxNEtk8RMWhB8dkC+Vran4Xo8Hy/c/eOp8sWtj2n
	 Xrf/0Dkv8uvfSW4CYHV9Vavcf1DregWasqTORoN9SgfM24JpnizwBT6owtYvuB8/x9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zPotjkpu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD5606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zPotjkpu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19391F000C0;
	Wed, 25 Nov 2026 10:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602814;
	bh=+rLDM4m/5oU6iypJTr5b10JrUOMAkqjl9EhsTVmyzOM=;
	h=Subject:To:Cc:From:Date;
	b=zPotjkpuiRbovglA7w+UVTuJqDFetbWovTWtBF0qyh/4tlXNBDkrTHYGf5HCndW6Q
	 wrbSK2IrGZ9bsrmSQHd7WS/LTJTS8FOpCUQdf5w+KHykWy9FJH9Wvf/YYfaNbwAQtX
	 XBlcj6mhCu1seyqM2BUIXShgE3I94x3IzMIf59Lc=
Subject: FAILED: patch "[PATCH] tpm: flush timeout work outside buffer_mutex to avoid" failed to apply to 6.12-stable tree
To: hj351016@gmail.com,jarkko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:14:28 +0100
Message-ID: <2026112528-stimulant-rarity-a146@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c22052a012698ce56d599d75b669d55778521c7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112528-stimulant-rarity-a146@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c22052a012698ce56d599d75b669d55778521c7c Mon Sep 17 00:00:00 2001
From: Hyunjung Ko <hj351016@gmail.com>
Date: Mon, 9 Nov 2026 01:58:12 +0900
Subject: [PATCH] tpm: flush timeout work outside buffer_mutex to avoid
 deadlock

tpm_common_read() calls flush_work(&priv->timeout_work) under
priv->buffer_mutex, but tpm_timeout_work() also takes buffer_mutex, so a
running timeout work deadlocks the flush. Flush after unlocking; the timer
is deleted under the lock, so no new work can be queued.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261108165812.676876-1-hj351016@gmail.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 6569212dc6b8..ee91f456f975 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush = false;
 	int rc;
 
 	if (!size)
@@ -164,9 +165,18 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	if (!priv->response_length) {
 		*off = 0;
 		timer_delete_sync(&priv->user_read_timer);
-		flush_work(&priv->timeout_work);
+		flush = true;
 	}
 	mutex_unlock(&priv->buffer_mutex);
+
+	/*
+	 * tpm_timeout_work() takes buffer_mutex, so flush it after dropping
+	 * the mutex to avoid a deadlock; the timer is deleted above, so no new
+	 * timeout work can be queued once the mutex is released.
+	 */
+	if (flush)
+		flush_work(&priv->timeout_work);
+
 	return ret_size;
 }
 

