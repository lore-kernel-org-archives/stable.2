Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602826;
	b=GYwoH+pN2ZhwTyP8PIo4dp1s3AUhrLNjBWolo62B5cG/gJSn+Hc9KvOYWkSrWOLOE/JN
	 t0z8OR3yM42hQ6AfU8MldVLBX4yW/Ft3/ghqqpWuTwGVGRYRmlW+6DgAtx2mxz7JlSIni
	 6zhhce/VMBy7TgmA8SDEpKf2gOACW3a3FqRS57nm/bnU+qWzaIPW4vP+hc/p2eYbNTfpk
	 rZVs908CzBYTeLT1TDZ8zomj6k3nj775ljrF/ys27u6kMYQNc3NpOrZPqvOXR9vmXyIIz
	 8CPqbjd2wJyJtH9mVHuL5zdQh9Yoboi5xcgRw8SuLgoEEWNDrkXNI+A5ZAcVWgOEvkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602826;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YflK8Pu3Oj2th9CQ6/AW8vC+j+3Nw6MDY605TPEX1jE=;
	b=OqQsDPdL8yRYBGLvZUY/XLFEwJ4ejaLJDg2/LkpXO/aDfIdIfhYlFbKg7RbGRu9fEcD0
	 im5QUVUhG0JIfnAf/QeGmqurQ787WngIVsZKkhnhBDnPWRQ7i0sG7r66jhRH7RQAvRQdb
	 LYDr8ZdEeQNvOWBTLlS6puh6PibeR1G+k/3dLLbq2GefqjQyJWVYSMrVzwnF91rbGbqb3
	 ZFlt+cQlYOBEuFMVBtuxCN2VF6OJlMpecU+p2hZtBHr0c40M/voTkF0Zb8W72CYflvJ2i
	 wmSMjqzvEJNiuLR8A0n9cdKegwE6SmNvx8v6psn2wc7AbvIOHcaOvTpv7UAqdyzoEMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vs+OG+gR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2280606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vs+OG+gR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23751F000C4;
	Wed, 25 Nov 2026 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602826;
	bh=YflK8Pu3Oj2th9CQ6/AW8vC+j+3Nw6MDY605TPEX1jE=;
	h=Subject:To:Cc:From:Date;
	b=vs+OG+gRFIEATxwKgK0+bMYhrwMVL+FYTzJ3KG5+CnVdxS3N4+r7xe2t1QsNtUJBN
	 iQZeTe4sN2krb6i8em5VMeU4rxHsszHSXzdAJk41+zGz3xIpyIVVik7Zra3MaJFWfQ
	 WliIixA0lxv1zcZjoTXBjcv3BavZyztePESWktAc=
Subject: FAILED: patch "[PATCH] tpm: flush timeout work outside buffer_mutex to avoid" failed to apply to 5.10-stable tree
To: hj351016@gmail.com,jarkko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:14:30 +0100
Message-ID: <2026112530-ooze-unknowing-551a@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c22052a012698ce56d599d75b669d55778521c7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112530-ooze-unknowing-551a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

