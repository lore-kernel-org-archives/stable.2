Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624947;
	b=pk1XxHkONY2Gt9K5veVY+LOu8NtHRFCKfDO532s8VFgw+Hl7z5BOnB19bLcUksdxMvX4
	 h/hWfguB6TvIWIdAf7qkTFh/qRWy2iaT6LjgMmsqKCr6E/jJO3w8oO5vLhNVcfn2ckmNR
	 vhD22n6N7i8Rim9EzI4dgopgSqOr1ATfzWgT4XuoTR9h+YId5r6XBmus50WR7TdAr62+F
	 MU8uG5LoEmOiRbTG4DzoMlfNkWhEAHXXzLj/3VKOc5KhxVMBuCJYgDT16qX0hnevXwF49
	 60yYpimCO5MVl+t9iHLcGo8n1jHxnmXYj7Kanv87dqxuoBSMe9P0sC3KSbElzJTqI9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wZbCGetkhzfmFWQTEqRTynmBKVHOtTHKYJP2D1ClC04=;
	b=QAd37l64APAwtNT/mGLCZzgc7xPlIqJOqG6FqXvGPtQkU0tgFMC6rtS6Pl+9jacJzgYd
	 7V9H2qv3SOzU9hHAyXMO9/vQg5HW30Sn80o4siU35XDcz1RkWMEYJYrm2upMZ/F+ks/zi
	 Sn69UM4CzIOLg5lcVNR6JtCLX46mCDluGlfBO+JKiMAA2fRjhUeTSrA7MQQn7UJYYt3MM
	 GtSbXG9hTdmf8Cx5ASbhjBJnop5gka5V/UfogUVXscFDJ9ceEEAJSHFVH/PLdYRt02ajm
	 oPseupu0twtNVMvJ/ojjlRRKsu8OhWsBZ6Uet+p9PP3OtfiH1O4udommVmKGRkm8deQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQVO54l3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8CF606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQVO54l3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A891F000C0;
	Wed, 25 Nov 2026 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624947;
	bh=wZbCGetkhzfmFWQTEqRTynmBKVHOtTHKYJP2D1ClC04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dQVO54l3e5sP7ZYDDonQ/KUxoPd9gQNpwTcycl0fpcYoKpOJ1LIQlETm7CkjuJekA
	 gkCCaM+2X7D8zmoDhaHK/9YNXmFFqFtrQnDmbaGS3oPXFD4z/dLKXeowJX0IsgCk2Z
	 JNJpzsKSr1p4odpN5lK0LZ2y4BreyAjjI/ZuCzM9Y8jUXCD39l42MHmIHlBQ0Uk/VV
	 wJkIbBsAE+4c9zHZbLTFQhy32LEFRfkkrbbhFAXH3Fve5Tti7jl6K+BXaeMOi7GBL0
	 0s0VPHFpTMTdI0V6bD1PmyKV1rzZyzQytoUEZGrKh0GVlSSnY+2dHZdD2JAqB56YcW
	 LASIRYfhJqqXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunjung Ko <hj351016@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Wed, 25 Nov 2026 11:42:24 -0500
Message-ID: <20261125164209.853593-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112529-venus-variably-0981@gregkh>
References: <2026112529-venus-variably-0981@gregkh>
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
[ sashal: Replaced timer_delete_sync() with del_timer_sync(), since the older tree lacks the newer timer API name. ]
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

