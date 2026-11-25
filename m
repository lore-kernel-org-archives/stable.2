Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625321;
	b=Sa09Hcvnfej/n8dhaVDKcokijT/rP3Oco9NWtrujZNqt1I9hzCM+GPPwKswFcFGpQf5t
	 /hPXiz9KqBDeXPExyBIDH0srNIAW09Nud01qtPLFfwJQtCipWvzaEB9Pm8hMxGnzC4MrE
	 o+EKICt6fBU81oUatNO5WJxcRJ0quIjTpgvokSF3IDoMNhju58uBa4HDphJjvsFduLpJG
	 PgqYpYtqRoXaTzbJ4gYHBwe0BLHyHVx0VBotTyksv+9x0YgyWbXnH+LC/ajoY4BFdX+Y/
	 XMDgq2BT7Fly/3nCuOzW4SQJNJti9iuner+be7jBE67WLGL5mNBAA+co+rV7enHhrig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625321;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WYUcNC7xRhslKEy6mzjQu4qrOpFev5avD1h3lBBRHvQ=;
	b=vuwCMmw/l/BSiS5TmgJzSoaGnYRRv/dISIo6ju9lzJ0NC78ekfQZLqimKuh7Zk+pUzL+
	 UkAekO2/2CR2py8x4Jqj+6t985TaXazKeQ59eDpWSaHOdWoLjirMYQAGYTSUdbK8R/xcB
	 NrjY9WQ/nJ59u6r1BXNDdzcn3D/2M/RY1go3uLk4kiZ932cuBhjf8cvRuH5JRWSLYTMoF
	 OeY/zIt/omaiNUvUxPvJq2ywaPpfQNmy6LplmzvRnrTRHIjp2YON/kEC7tXYq2/hQXOSR
	 XowXVG4FdpjtVJ7y/rzNekyOfi6Q1H5q85ZYXW1Tv43bQYukI3X/ikGXQpVkdawznwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=em2GIRjJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ACA606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=em2GIRjJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2551F000C6;
	Wed, 25 Nov 2026 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625321;
	bh=WYUcNC7xRhslKEy6mzjQu4qrOpFev5avD1h3lBBRHvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=em2GIRjJtMZAAV8ecXaAN8iYgYqf0v6O5/AWCewY2215Cztnc3zCgPvEKNjjh1YP+
	 RNBwluz/9rXvsgQmzKVCJMy1RADkh0RZEV4yitQOqYSOsY+XtXsN7PqQOIWs46O2vx
	 SX0D1e0i3zE4wHEi+A+QKprsAq2NUWms4w/gQUPTao9gIXxIhKSNpoIeW0s624loW6
	 hN6Ia94SETs4/0nm0cxFtVjvabqbG0trtZNroRb1XL3CK/AIWY0Eg6ouRxA9TlIJJj
	 niM/uq1MgbKYhUg67foiEtpgIejw4y+0ZY/Wd+8vRyO+SsdaMY8Sk9DgkpYwLzrK5C
	 h7C4DyqaTN+DA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunjung Ko <hj351016@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Wed, 25 Nov 2026 11:48:39 -0500
Message-ID: <20261125164822.880854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112529-action-earphone-4130@gregkh>
References: <2026112529-action-earphone-4130@gregkh>
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
[ sashal: changed timer_delete_sync() call to the older del_timer_sync() API in tpm_common_read() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-dev-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index ff86a1fdb5cdc..ddd4434edd33e 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -129,6 +129,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush = false;
 	int rc;
 
 	if (!size)
@@ -161,9 +162,18 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	if (!priv->response_length) {
 		*off = 0;
 		del_timer_sync(&priv->user_read_timer);
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

