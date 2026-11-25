Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625606;
	b=ofWCDzpMsCnZFzpv5E+ajk8S/93ibmWa27Ba79sm7Eb7UsO1owEUW1do0YdPzksRRYW4
	 3Lfon/7Hwx+eaf7LrDc0Uygy7PgNrE19Q8Iq1LeZGB8yJdd9lRBSZTgvBvIavdpKddx7W
	 WI5EdTLpHmgYPomPrUvFLez3OkX/kZje7lcjr3G8189lb4R6Q0CO+YHcuNEtaFdbE7fQY
	 kfn8hykfD2l0b1GaO5cdRk2mTdijlSxrdZCNnc2o2UiK2fnMu7p5N1Vv9LR9clgFc6xkR
	 1ImTQeroI/7NvOIE8p9FqPRVo/JNOD0FfbLUvNGSi7kyHb0BahOV8dbidJi3IdH3y+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ar4VUFHWBm2UFuIsGSaF7bP78WwdPuVce/uP7EkMF4g=;
	b=Gkp/zcAUlXcuraNJ44e/Joncrfl3K/7eurTvVHrbFMX8IjVxmjpPwlxVe87ozwiZlOdQ
	 XrcIIVaLZvdnaaRps7NGnW1UoCwRR09aQt0X6qvBCGLPmeN6q1cqn6Nr/IpBJh0zqqwAT
	 JmbMLLbfUSlKVOVQkZFiGOKGlE1D5EmYQyjsLxJK7xTt+i10Kuc3W9lzszSknw7I+fxEZ
	 /GfP5L7kiO44sKISWYJyO4VH6XZjd0IwQr6p5tl/7Aee5A/lhcz77SRlvdNJ0m3XB5J/d
	 G1W4wUu2CQpL9L/qMePTJ5nLR+IdpGFZOaseZr2CY9az5fzpxbpDCzW+4U2Qs0hMI7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mB1R1Pmn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA2606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mB1R1Pmn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ED71F000C0;
	Wed, 25 Nov 2026 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625606;
	bh=ar4VUFHWBm2UFuIsGSaF7bP78WwdPuVce/uP7EkMF4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mB1R1PmnbIrvZ1mgOtxovz9cGBo6yoGEuSULOBKJeMAuXwQBJnYqI/WYwhoH8cm0h
	 QsznDq0JhsE3JfHBsooDWOXSFanz/bEgRYAxMcMmgfzrQhDtOB2dvk8E7uJ8FVMUFo
	 iJiD2OY/5y/wp4j5CHV9paYFpmaWQz0S6TjOhNiA5jezj6TTqPY8uz7tZIfvQ8NLsf
	 bOkwUocyFM3kwIJbrLszacQsXEBhqL9ywoGCdkhs+BM/YQnApCeQ7VfC1PWwrWiArk
	 d6dA06LAwx94/Pa5vtY/l8oCq5nArtUkEG2FW5AtfZnKxTn+ewTk7Ey8kvJarYOG5R
	 cImDNPLRekY2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunjung Ko <hj351016@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Wed, 25 Nov 2026 11:53:24 -0500
Message-ID: <20261125165303.891541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112530-ooze-unknowing-551a@gregkh>
References: <2026112530-ooze-unknowing-551a@gregkh>
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

From: Hyunjung Ko <hj351016@gmail.com>

[ Upstream commit c22052a012698ce56d599d75b669d55778521c7c ]

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
[ sashal: Context lines adjusted: the tree's older timer API name is used around the hunk, and line offsets differ, but the fix itself is applied unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-dev-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 012ff0b73aa53..8ed25c6f01fa9 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -130,6 +130,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush = false;
 	int rc;
 
 	if (!size)
@@ -162,9 +163,18 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	if (!priv->response_length) {
 		*off = 0;
 		del_singleshot_timer_sync(&priv->user_read_timer);
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
 
-- 
2.53.0

