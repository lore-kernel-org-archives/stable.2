Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625128;
	b=TTFPMNIXKfGSU2x6LD8bqbUyt1Khrfu1u3a+VG+Q+ImDCfhb8kXGW4zYSDaXBxdxjkNo
	 ZLrdGNWR9szmFmmf6/LMSARZXGuNcxnPP58Lk6ds/fwqHXMoL9agBML0ILmCsPsk+CTWb
	 ugoyKF7YrmdqD4KlHqs4tVYGp8slkQrJMtS+sXxgYrhVkjwMnfUJ92pGEJg/t3ZfTp1VZ
	 PXpPdcRL1JS4Zbrg8nF2yWh5s1tSsKuO9poKpTBc07BruuhsZHKZGrqrF2X0Gpk3/iSlz
	 uXed3XcMyhN5oM2MM4Bpipxg9yVgaIJfexq3Eym8EIxMS7EifTkHSHjgx/9VbUpA22A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qnJd7InjJPGVJKwlILKiU52xshaP/XDtKARS1S/Yp7o=;
	b=uWVp/XooXFPLM0JwaI7genuk9n8rTHd6K6009KvVH5LYKH8iCnh/8qG5FI+eSJESQHM8
	 wOiPHPkGeOCsQ4bsWmqCE4fda9rv+Q1llMLEbhdrOIxv65Qepm84F6IRaWncvAhpfeqJE
	 F8vEicaiVY+zcWI2Lst+GeZJhGKadGQJpFP4s5dhYsWv6pDU00KWpXHn8F7vBG3YVncqo
	 ccj50IBe650Tf4rTgT/02cC/N6mEmGm8sNqXQA1h03dEeWIpAtlmCDfOcXuccE9RTJ7BT
	 Wg962l3eUS1p1o4ViP8rDkvjcxc9RjztauwiVGn723eY8zUc98ItdoknFLGj59AS/dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOCthaIw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97298606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOCthaIw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7E41F000CF;
	Wed, 25 Nov 2026 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625127;
	bh=qnJd7InjJPGVJKwlILKiU52xshaP/XDtKARS1S/Yp7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IOCthaIw+PPK5dFgxcI7USVFUeH00l+FcnBwjd5x8s75BYHqWpYtCS5kfEG5IX+ja
	 U0n9oDMyBA+nIBb+zEZ5ouQL2RiYeGRkQRJ2gBPE+LfCqXVPa+SN762Vz7IDPQA/Li
	 hj/AhgoEcZy2nhEPF98xURB1zsBqwEtw2u9H1ZujopRMhc/69HxvEzrSCPk6n3H3kZ
	 SDYHsu/1yDicw8wG9xTyb2fHfyj2UAXLk47ydkueTsmKnNP/ixTR/2pgz7zySKx98P
	 Dfl/JcDHqt89p7+FQXkG+ZkEpzLuGvRDl+H0rG2FZzIhfGL9Ea9Kbk0rXOOlSCMvGr
	 IfCmwBgyRJ2vA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunjung Ko <hj351016@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Wed, 25 Nov 2026 11:45:26 -0500
Message-ID: <20261125164459.866975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112529-manhole-ranging-68d9@gregkh>
References: <2026112529-manhole-ranging-68d9@gregkh>
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
[ sashal: Adapted the timer call to the older API, using del_timer_sync() in place of timer_delete_sync(). ]
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

