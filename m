Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933513;
	b=aex+KjF9YzyftcO7AtxzRE9bhKY18zR59pYZfbbFnFQ0sOuKbI13LHSsnZc0hY6DMW/Y
	 3KEY3IEuvPGpj//yw+2WPyiN8FymBgE0GkC1SGN8GszjxvMDVQTN59Vl1KkUE2a54AynK
	 BF74xJ2bfwZhg8bHXIgjUz5pfrwU0YRNDSwYUsFRQlndj7D6rP+fZJj1Z5zmt/KLh3glE
	 a05lH6Q6VXcMTtFIMwsCcdTNdnRAvNRIK5KYsgXlsekPS3UaWti+Vy4ITND9Qto8yTB6e
	 zliJquB+0GL2g8rvNKj5WBpMqOO++B+ae58G7yYyA61MsAqtHsDeAxTdSdqlZLoRWyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933513;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7DbAY79DNO2fCj1Ug+nf3QknPyL+0mRDt4L91TpAjeQ=;
	b=QJ3C9KFO3X8yihVxdIe6vkyPXKJVWmVWnnG+bkCHWsdGGTQK2gatCxzmY95Td7E9B/VN
	 viHmQIN1uqskQA0LEECUMu/o9ZpREEXrcO+tOuYE6eVnEk6dcj+wK/BKzGr1nUg4jS+n9
	 5Ubvu54QGY7xgi4ZPR34XsgYK9TgnHUumlBcCHEpUMGLJMDBa1Q9uQQp5k73Sn7T0hsIY
	 uvkiaZFLo35kvzKEvG/c5LgVpxKY3rXMt3C3UlHPXewYCygtj13L/SvIv6vdZKYT+1Sd1
	 bVEwqvzy9ERFcW90hUs+xFRklF9TXL+ZYT0Xg1kfrgrRCGwi0OlYWDexUBdVDfgo/Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzB+bOY4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105C606A31C;
	Tue, 17 Nov 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzB+bOY4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D3A1F000C8;
	Tue, 17 Nov 2026 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933513;
	bh=7DbAY79DNO2fCj1Ug+nf3QknPyL+0mRDt4L91TpAjeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PzB+bOY47T36STQrwGQpYEvYyBOB4V87/EJWx7z+oK0DgqJ+My3erSd74Eov9aH6Y
	 mFHvQpFbZI3F9hKrWRshLlvQ3OnknrNrJwstoQxzXqoO3eCxqK5UQQ9TVgrTRHBimB
	 IcaWw70UudomtGgDlNoXgnnZo5Yr/s17tZaXZA5azNS2FyQaA9ZcQMBl6UmW1x0dED
	 Ih3iw/34ZBFONYOWQQIrHqZN5Tsjwv4Kd09gqymLauEVxcWl5OajliWAI6G6ri+m1y
	 /noo0cePHN5S0wkQ60UT4jvoyrR1oP2qDrC46QdCD4tV6+enEAD2+RtpqI6+EopeNM
	 wG87nBVbQgG8A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 02/11] dmaengine: ae4dma: Let the pending work exit before cancelling it
Date: Tue, 17 Nov 2026 16:37:03 +0000
Message-ID: <20261117163809.622249-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261117163809.622249-1-lee@kernel.org>
References: <20261117163809.622249-1-lee@kernel.org>
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

ae4_pending_work() loops forever waiting for interrupts, so it never
returns once it has started running, which it does 100us after probe.
ae4_destroy_work() calls cancel_delayed_work_sync() on it, which waits
for the running work to finish and therefore blocks indefinitely,
hanging device removal and, once the work has started, the probe error
path in ae4_core_init().

Add a per-queue stop flag that ae4_destroy_work() sets, then wake the
queue's wait queue so that the work leaves its loop before it is
cancelled and its workqueue destroyed.

Fixes: 90a30e268d9b ("dmaengine: ae4dma: Add AMD ae4dma controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: New patch, so that ae4_destroy_work() can no longer hang

 drivers/dma/amd/ae4dma/ae4dma-dev.c | 8 ++++++++
 drivers/dma/amd/ae4dma/ae4dma.h     | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index 8de3bef41b58..be86188da16c 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -23,9 +23,13 @@ static void ae4_pending_work(struct work_struct *work)
 
 	for (;;) {
 		wait_event_interruptible(ae4cmd_q->q_w,
+					 READ_ONCE(ae4cmd_q->stop) ||
 					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
 					   atomic64_read(&ae4cmd_q->intr_cnt)));
 
+		if (READ_ONCE(ae4cmd_q->stop))
+			break;
+
 		atomic64_inc(&ae4cmd_q->done_cnt);
 
 		mutex_lock(&ae4cmd_q->cmd_lock);
@@ -81,6 +85,10 @@ void ae4_destroy_work(struct ae4_device *ae4)
 		if (!ae4cmd_q->pws)
 			break;
 
+		/* Make ae4_pending_work() leave its loop so that it can be cancelled */
+		WRITE_ONCE(ae4cmd_q->stop, true);
+		wake_up(&ae4cmd_q->q_w);
+
 		cancel_delayed_work_sync(&ae4cmd_q->p_work);
 		destroy_workqueue(ae4cmd_q->pws);
 	}
diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 57f6048726bb..affb1d7d9d7d 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -60,6 +60,7 @@ struct ae4_cmd_queue {
 	u32 dridx;
 	u32 tail_wi;
 	u32 id;
+	bool stop;
 };
 
 union dwou {
-- 
2.56.0.679.gc527c65306-goog

