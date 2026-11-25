Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602817;
	b=xZcE3NUgNFuNM8zlY+Xd0UH1rEeVfLt0YD+TvhMbINPn212T68TrCNPYlFy7EKww1lBs
	 U/jbKcEuUjj873obteSYLWLqzl/w1djz1zexruEzaGtxJVGwmrfeWAlCl492BYrSjRm58
	 F94CQVkvDaAH3knIpQjxTG+1wX8Xzeag8rMu+W3MmcqBLrN6jDqsBPNO9pXx/RpAxpqTJ
	 kktu2cQA/GbzpDjji6Fm5MCMkj2sb32LnAgab70WMUZ9o3k6zMozDTS1IPGSz4FMrbom7
	 e4jNGJpHBNSG5KB+uG1AG4gdSOCttxisUDFRn4xt2AiHoSl8xkdOaqlixcE8dFfYX8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602817;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NogDEivagkdflG14gQ1zuM++0jgIKOUQBsohLFPd5VE=;
	b=ObMP41+Ein4U4/DJBfqSY2yGvG5kIGzN2/JsCoqU4jFZMeT62ZElzogDg39LUbqBw5+V
	 9hcm0MYoiMkmzVr3YRaNSrLzV4u85iB/3RPPLRn+V6uVpN5dzGrbnpG6By+9ti8MAPZYm
	 mlBe7A8y/8OdF+qXMeUAFmXGyIn9TaY9qbmasJmQnYyyEUBsB3Oa/+vcVvvn9udxvahIK
	 W3nUecigUbbkVfv3iLY63HEm7MQ0CaeGTJyv96qBS/WKUIgAhQIOzPYydnMRBIdtVaTDD
	 NxhLMLuqwaw/ZQ9yZRp2+pKUc2k+SS+847JVmK6ZM+Q9VWit2S8tm+J5AUH6aRUN92w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MVWryx0t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD10606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MVWryx0t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3161F000C6;
	Wed, 25 Nov 2026 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602817;
	bh=NogDEivagkdflG14gQ1zuM++0jgIKOUQBsohLFPd5VE=;
	h=Subject:To:Cc:From:Date;
	b=MVWryx0tUPHOLhWDtxZDzF+lWGIEybC82iLWAw22IXDmowjNZTdOtxxw4tZ/2AQwc
	 uRg6HAREvcxqNNmo91Fr8zUEUSnlkb3D9jrCXokhzvlnAs179/bp/1LNchEKeBX06A
	 4UnwRPHFNbmf3mqzR8kCgkQInt26Gm5MSb1MExSM=
Subject: FAILED: patch "[PATCH] tpm: flush timeout work outside buffer_mutex to avoid" failed to apply to 6.1-stable tree
To: hj351016@gmail.com,jarkko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:14:29 +0100
Message-ID: <2026112529-manhole-ranging-68d9@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c22052a012698ce56d599d75b669d55778521c7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112529-manhole-ranging-68d9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

