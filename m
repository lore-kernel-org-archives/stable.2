Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602820;
	b=ATUKfASRlMS0rBfZVdKXuWX4TMXPiWj/fFbgggn1Hk1JDfTQsYiH/NZ4meEbD3iL9uRl
	 xuxDPURSGgEl85EOPz054tuWNLghyyi3idqotjIy2hNtSmr7oaCBZyvaPWQiobnHqFkEL
	 lKlVxYy/C63OOBpK7u92Jp1WAQnZXytrrPACaR48+Z+CWnyV6Sf8FrR4ivHJu+9ZwGXvd
	 nih76wU66we1SjgbLAmzuFI/nAofFWTQP8O0rCSQCZL3I5CecsfgjD4jU4K2ovHYbMVC0
	 pLhaxy9hw+ckf0FTpcZpgVYtOmTAHFur+xWCEyrgXKasz/fJyVPfO5P9lC76bFsXVKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602820;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eS7YqChYy6mvAAgHkNw2QPPafd2HxPoen788UYRGNuU=;
	b=2JM7WFPjvwXpAl2Qv3BIhggO9Ev/V+8SlRQpfNRI+mwWqVuGOLwJfXnpnknZSXA3SZYQ
	 4ZqKp80Al4eXUoPwQkge3g/CyJBI4bYkagScSI0e5q9eYP5UHW6w7smSIIOgmhGXD6+jF
	 xPCsRKxg3EImvskZ+NWpK/eSabJ6rlkXH245j/EFZscW4G+0BlXGxYTW2JVdQqga96sQz
	 7gOsWgbVAc6gYz+v4+Oa9DoljFaGvqW8X53qBgMTsk+fw38Aw53xz0ecXzFGbZvYz8gs9
	 3Uf1dWrhKt4l45U8/TFXb19Pn/9zh4v6YQ7damcwdo/ExzKv1OSGJ98/ocz0Bf4EPJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NHJQ5H5S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A6606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NHJQ5H5S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDEE1F000C6;
	Wed, 25 Nov 2026 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602820;
	bh=eS7YqChYy6mvAAgHkNw2QPPafd2HxPoen788UYRGNuU=;
	h=Subject:To:Cc:From:Date;
	b=NHJQ5H5SPXCdzu39vTm+fXfalMQtrWUJub1em5paDp2HMKmg/gE/TL6IfRsDESlqM
	 mTm6wEiOCBf1sWpH+pSQGApwL4bR7N8YBUD1RrkRdFEwlsqMj3Z6nhUsAgfX1KXzuH
	 OIuzRlpgNB++powzz0knc0/G9I9B3PYjg3BLVpyE=
Subject: FAILED: patch "[PATCH] tpm: flush timeout work outside buffer_mutex to avoid" failed to apply to 5.15-stable tree
To: hj351016@gmail.com,jarkko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:14:29 +0100
Message-ID: <2026112529-action-earphone-4130@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c22052a012698ce56d599d75b669d55778521c7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112529-action-earphone-4130@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

