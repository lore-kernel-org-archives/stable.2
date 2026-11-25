Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624751;
	b=YWI3IDp/GBdC3iMRNSOZRXGv9gkg0u0tFzDD+hmmZjZ/ancXJG5rs5kCD3y+wyAR8Sq7
	 DPRM0qIpXwIkaAr4JDsqWPA3f+2EwUxzjIXhnlXkTxFC/2Apk1mIOA+zk748jt2qWACHo
	 g+Qf6wfxBfdWDZ292A1Nkl0Q44Afm/8jIkOR4gFc7QFLscZ5sT2DhjNyrdfX0XS9vikes
	 1txrjk7Uis82yHOH66GTSbUopbyzCFicdb2snTjZN0vvmG4HqRdZeWWSDTUD3nn/l+zZW
	 x3iR+8Tc0s0EHBuJM6xtNGcqOYemobxgM0ytwT4jhwM6te7jp8w3yHL3NIJeoFIsiiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/sVep4Xm2Sp6M25vUxaDDZDqQuLbM2/VK0aCHnShjVE=;
	b=QOMeYy1/OPZU7pB7jGD8ZIiLFn9dJdLMforWxBOrJkgjPEqe7PV7ZX+X4qrFlj1IwHU+
	 FWOhAwf+V1zDHYcF434yDAaTewhNfFo8rAAoHGruzWiw9yhPKw9zqQ+UuO6UKmQxdb/0n
	 E6VaMQaEMU/RqDwe/tCQWGSHYAB3j57srM5nNlJrYijOcLc+GSU6UocFUYa1OmuoCjijo
	 3XiGH877ufXWrCXzLZM1GLEH6Z2X0GqD4fsmCVlpkbW5dJKNFfpA485iROoBb3gQR+ye+
	 pLxwvGpEHL9982XVmzB0qnteYIQARAltWvhKSgKArOeKhMsPxSHHhVb3tzqWo6e3Zzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNmd6K5g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E645606A338
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNmd6K5g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DD51F000C4;
	Wed, 25 Nov 2026 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624751;
	bh=/sVep4Xm2Sp6M25vUxaDDZDqQuLbM2/VK0aCHnShjVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LNmd6K5gztn/P2jIBk4Vjz8cFTCzen0nVLNG76JjxLxgKUGTsgcSHP5TKRfG0jSg0
	 0AjIG2zfnmCVo9jR/lebR8SNeBO0M3VRzToMOZoS92OTD6ZeOOHylgqqACPiFGRRRh
	 Ljv7lmZ2I7sDVOshtT9NsNomYfbiutILxS+JbqhV0L0U19aVD/ie+OCjRQqBtcVEWN
	 9cnA8mbftgil/MGo9sVujShKTKNWNFIyv3BYk4j6ZoR6WtjdGBRvQnIL0pGQIOivZ7
	 67nMFGZlYWSULmQrXR2pf+JX6F3/kCEURk9g0ZiTiGUXbu6trgdY4gSoKGjEMZN6DQ
	 ElImSXwslwb+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunjung Ko <hj351016@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tpm: flush timeout work outside buffer_mutex to avoid deadlock
Date: Wed, 25 Nov 2026 11:39:08 -0500
Message-ID: <20261125163851.838129-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112528-stimulant-rarity-a146@gregkh>
References: <2026112528-stimulant-rarity-a146@gregkh>
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
[ sashal: Replaced timer_delete_sync() with the older del_timer_sync() name that this tree uses; the rest matches upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-dev-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 1bfdcb9794e20..98b35c4e8bc8c 100644
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

