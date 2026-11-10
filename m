Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338361;
	b=V0hYCuoH8zpwfAABhe1iXsrNOMeY0ciG2BQtKPltRJAUYfDGtNhfcfb/sfWa5QdRRZLd
	 iJDJsCfawfunF6U30vYegxNE6g3VU/OgxMqMnTdTHoXxwdpta+iotd5oEVo52jGmtd3aQ
	 9sv1hsQH0npsbwdWOl0rXfP40hQ6MWdbNSVUFXAVjcCe388AjE1vZU38njBhfYRHZq8BW
	 q0KNf9I4YFE2Q337tVvHRf30zufm4DqekoYF1fEvmzElz2ETFwTfrwW1V2cNdEezSAE8K
	 ta/3LLmn3FjhpQsG2nwrho2iNOvKstzS5dnGcZJmfrYi92AMxmWlEtrYvu3mmrdgF5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338361;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zAns4FXCzfSAya9n3q83Qh1aTXvRPcb7a9FvmFLNz6U=;
	b=WbcHF+uTORWN7AbvpEaUuru/ilM+NXiVWvWpDOH2D/0VjwO90T467UTmR9Zr/WeihZfJ
	 zfcF56iMneOQgQgjgWZTZlqqyFv0+xduaCiFiiM++jDaEyuW3q9KmdtI0QQjoy92UYHe3
	 oPvPuwbC1s98waAwJGHBZN1pc/qpuoz1B2jQj5B5YY7UH8E5fhzoCBzW8uT8BQzLSRuUW
	 7mRVe76aJ0SnBBRkrkXIwEAvpNK0maQ8YxxG5/cOPhqqGQ/xp7eJNwtvdpMCvIhrwLGPT
	 JWNi15RWjxekksFm7P8jmS9dsy2PgjrC+usxsi/6e/OvzfyBZR33+cJ7IWlOfpbiM7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/aHthEm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC0606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/aHthEm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534851F0089F;
	Tue, 10 Nov 2026 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338360;
	bh=zAns4FXCzfSAya9n3q83Qh1aTXvRPcb7a9FvmFLNz6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M/aHthEmwAQIQvGOogRCjSWPYo/dw8/tYTei4exhm+/ePtMBC8YZc/uytYipQsE4A
	 hspxWIeJKWbsg8NjEJE45aH/aYXsUhDVLumRRWSsRtiSjbPBSV8ke32EeH22QJhhwz
	 PvqWQjdVPnmBTbSIrmotTb+OE5Uwl6oqp0vUGnc40QBnkDPaFc09W2sNVETeIGT8gr
	 1U7B0Uu76Zs2JKRIKZ5HpfkZ+4BrGUGkPoZFmDQ2GQjV6ENQQMg3jTIWMAtZZY98A9
	 BwnM5xzDedDB9FwG6QqJPwKZPxYINN7XDXXu6wubUdrPaKnjpaG+B33Hu/vw7V5OQI
	 i9cBCdKbVhLBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm-bufio: fix non-working memory limit
Date: Tue, 10 Nov 2026 14:19:18 -0500
Message-ID: <20261110191534.3506041-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053426-failed-6.6-1190dbeaeaa0@kernel.org>
References: <20261107053426-failed-6.6-1190dbeaeaa0@kernel.org>
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
[ sashal: Adapted the oldest_buffer assignment to use params.last_accessed. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-bufio.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 8f121a7e87bca..b8addbc3a3430 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -2499,6 +2499,13 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
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
@@ -2828,9 +2835,23 @@ static unsigned long __evict_a_few(unsigned long nr_buffers)
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
@@ -2855,11 +2876,23 @@ static void evict_old(void)
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

