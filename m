Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337702;
	b=KKVinaS88YpBywMqKRgyEr8FKpTL3MPFJVTlqAf/jU6Jw5NuCBtsMJTFDBhoi4eI6bNf
	 fJKnSbak32GvUzCCEIaj3KrCD1psBVeaZF4xBYsd4AwguIX8TG7MlEP2jE4KXKOOOFmdQ
	 FXGVP2Oh0+RMKQ0SXg64qYj40cxMmzYOtpHKCUU0KCnlMr/IHOemB6eGNfR/lCcFbZM3E
	 j5Jrd7o4CzjQ2gMku6nDonuZesjV61X9syT1/5xp0+nTjF0Xt9SOMetIMTud2dDQrYhdH
	 5+3Y2wXO8eMqLObtJTPbXRPUtDKrQdXve0H2H0xKEwAZD1qorSL45yj2JQneIg6XuMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337702;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jG7yjgR5q4cooZVovaCCKFd3LEUH4hCFhOxnWGcWI4Q=;
	b=qmIbeGJOPDtKhCgr2/QgDVaKiW+3yIVx4V6bozxQYiEBFp5DTYyu7NkoF+NBitSgissX
	 0hlif4hsbCNtRzPWeoWJWgc4paxSiQt+Y3WnZl8IF2/4T9qmEmVBSrnIEpDnuEkAkr49s
	 /Tt6eml6E19Vo01Z32HsYrpWtc0y+DN6oTA0rgQAiRb/PY7av5kZFBnSdiTKQWLkVeRA0
	 u2Dvl0OBGyANhuL5jU6FNxrBVlk7w9lrWMdZjg0wbcFVUa/tN8KAgEFsWagXPTl/gmzG+
	 GK0Djik5PHxBa24WvuiYMMx0+I2L8Ivd7brCXGYn92AXOL4MTACWlRyBDHguDGzv1DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhAhT0nR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B66606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhAhT0nR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7951F0089F;
	Tue, 10 Nov 2026 19:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337701;
	bh=jG7yjgR5q4cooZVovaCCKFd3LEUH4hCFhOxnWGcWI4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FhAhT0nRT6gicY/yWMZfFKHgoaM+Gx6FjNR4l9hGz5WIjsQ7HYt9HQHdtBMycC7OJ
	 Ny4Edb5GC1W/jXH9IiKdH7i8aQG6UTYicXzGTuHuGzTQ4oL7gW6AY57sDkpiBVzRrm
	 jM2d7t5gbw8gdRpnOm44MgOkHH4UTrJDgq3Tez1RYdKCBbVbX+ynDAiFK5wCoOTtOL
	 XmgszaZNR8LOuFQthpz3FbUEPvprCTyNjtTYzLinbSemP3WfDiLqAJEJoshNJt0ncd
	 6fyuW4w3hrWb9hvhB7tsmzhiD0g6FNQgO5FaWSR6yuTclyVoEJyhVv/T2QFbEpYnpR
	 6y/xorxFRxtwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] dm-bufio: fix non-working memory limit
Date: Tue, 10 Nov 2026 14:08:19 -0500
Message-ID: <20261110190539.3448006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052200-failed-6.12-1190dbeaeaa0@kernel.org>
References: <20261107052200-failed-6.12-1190dbeaeaa0@kernel.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 1190dbeaeaa026a4879e675b8556a150c36a7ced ]

The function evict_old is supposed to loop and evict buffers while the
allocated size is above the threshold. However if it hits one bufio
client that is empty, it stops and doesn't attempt to scan other
clients.

This commit fixes it, so that it skips empty clients and retries up to
dm_bufio_client_count times.

Fixes: 450e8dee51aa ("dm bufio: improve concurrent IO performance")
Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-5
[ sashal: Retained params.last_accessed in place of the upstream local oldest_buffer variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-bufio.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 601c3e3fe56bb..d2a4fc35c8380 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -2526,6 +2526,13 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	init_waitqueue_head(&c->free_buffer_wait);
 	c->async_write_error = 0;
 
+	/*
+	 * A client with no buffers yet is not holding the oldest buffer in
+	 * the system; leaving this zeroed would claim exactly that and keep
+	 * the client pinned at the front of dm_bufio_all_clients.
+	 */
+	c->oldest_buffer = jiffies;
+
 	c->dm_io = dm_io_client_create();
 	if (IS_ERR(c->dm_io)) {
 		r = PTR_ERR(c->dm_io);
@@ -2861,9 +2868,23 @@ static unsigned long __evict_a_few(unsigned long nr_buffers)
 	count = __evict_many(c, &params, LIST_CLEAN, nr_buffers);
 	dm_bufio_unlock(c);
 
-	if (count)
+	if (count) {
 		c->oldest_buffer = params.last_accessed;
-	__insert_client(c);
+		__insert_client(c);
+	} else {
+		/*
+		 * We evicted nothing, so 'oldest_buffer' tells us nothing new
+		 * and the client keeps its old, possibly very stale, value.
+		 * Requeue it at the back rather than by that value, otherwise
+		 * __insert_client() would put it straight back at the front
+		 * and every subsequent call would pop this same client again,
+		 * never reaching any of the others.
+		 *
+		 * This leaves the list slightly out of order, which is fine -
+		 * it is only ever an approximation.
+		 */
+		list_add_tail(&c->client_list, &dm_bufio_all_clients);
+	}
 
 	return count;
 }
@@ -2888,11 +2909,23 @@ static void evict_old(void)
 {
 	unsigned long threshold = dm_bufio_cache_size -
 		dm_bufio_cache_size / DM_BUFIO_LOW_WATERMARK_RATIO;
+	int unproductive = 0;
 
 	mutex_lock(&dm_bufio_clients_lock);
 	while (dm_bufio_current_allocated > threshold) {
-		if (!__evict_a_few(64))
-			break;
+		if (__evict_a_few(64)) {
+			unproductive = 0;
+		} else {
+			/*
+			 * This client had nothing to give.  Try the others
+			 * before giving up: one idle client, or one whose
+			 * buffers are all held, must not stop us evicting
+			 * from everybody else.  Stop once a whole sweep of
+			 * the client list has freed nothing.
+			 */
+			if (++unproductive >= dm_bufio_client_count)
+				break;
+		}
 		cond_resched();
 	}
 	mutex_unlock(&dm_bufio_clients_lock);
-- 
2.53.0

