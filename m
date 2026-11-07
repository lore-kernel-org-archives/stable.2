Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047668;
	b=sbsjV0NtafSEGxIzYcRTa27fJNglY12yhabDFOoFH4OiqDTXsOA1ho+rmCLUh4Fdy0OK
	 t4kDLC8Z2+IlyDWVr0vmNruRzMtjQ+xjsMA8ItTINA3VKZPCRC3rCZ8ZZlFFDize9lprB
	 lrRnSiAbrS0yT8BTqvQ1t7LZHlYiO+ZT4fZXsBJpt7HV2o26unZ4phtlZ1X1cq7RstEo4
	 ZNjysdeIqbGjQNdHMVnFSSsBpnX2DUPh4NpFlG5aq6MuDfWcssaEq3FlDKiVhm6XmoO/U
	 RSl0yu6Nm6gOglI6pu7i7VSd0XkHl2G2S4MFDKC8e1PxV2r+IRJQ+h/EsyfydROSdXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047668;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ufiufHou7r8hpEk0QKvcktkbXWOeqQYqXtvduwgEcK4=;
	b=LaZEpURqFmB5Y2/cF5oNWvzpmSQgoJebM0o0toD3dry02Kd6B/1Tj9ViHbQ0TJhD7HgZ
	 QSnvhqbowO2TMQBzb8ZTuQGHKqYYJrU5Nee0Ix9RK2hL+ZO020N2BHYnkH08nERBkZpxo
	 o4OcLCD5Fh+YGUzfPD+g2No+5ufLm45xnNp0Fb2mx7f5Y2JaFwlPM+h4rK6yhG9TrtD/6
	 FhPJFh/9MDVYhZbmxc+mY+8lhCkWt+6dam9BHt0hDrPd+LaGKfoBOzy81nN6Eh3jYf2I/
	 mSWUPKGS6p8CE9yOkWVx5tFHvXJRLtNCXXjoWXIUxntrXGsTMN/ESwYPFDKpEPzk9yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUw5lcFx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2594606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUw5lcFx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C171F0089F;
	Sat,  7 Nov 2026 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047667;
	bh=ufiufHou7r8hpEk0QKvcktkbXWOeqQYqXtvduwgEcK4=;
	h=From:To:Cc:Subject:Date;
	b=KUw5lcFxG6pvjAiONbBj3bIFg+UMejH7XvEJOaZrle7GwWBPUdsLCW5He6iKmcEsd
	 6vR5Hn+z8osm8TJAED5hSQSKY1P+KZGiFUYy6ys5bT0ipy457MExoza8gHv5r9iKFT
	 u2+7HZDtO1ZSuQm7LAioWdmewDIp0WDRcJqjIBwVhXWhJTbnt5wE8AM4a7GHniiwv7
	 Vh75Hm4JFDOuGGGT0c3XOG5kYPeSDTetYl3icTVIuGWV+9fUHrgvknud0qcKy8kOTU
	 9RMT8bg1h+G9HExcdjL2qeOKhKzVjlEz0UllaMlOmci7GW0uc5Y28utH8NjKuOAtX1
	 kmJ33QMNK2S8g==
From: Sasha Levin <sashal@kernel.org>
To: mpatocka@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dm-bufio: fix non-working memory limit" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:26 -0500
Message-ID: <20261107053426-failed-6.6-1190dbeaeaa0@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1190dbeaeaa026a4879e675b8556a150c36a7ced
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053426-failed-6.6-1190dbeaeaa0@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1190dbeaeaa026a4879e675b8556a150c36a7ced Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 12 Oct 2026 16:07:58 +0200
Subject: [PATCH] dm-bufio: fix non-working memory limit

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
---
 drivers/md/dm-bufio.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index d58eed96a8ff5..edad64654ef68 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -2545,6 +2545,13 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
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
@@ -2779,9 +2786,23 @@ static unsigned long __evict_a_few(unsigned long nr_buffers)
 
 	dm_bufio_unlock(c);
 
-	if (count)
+	if (count) {
 		c->oldest_buffer = oldest_buffer;
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
@@ -2806,11 +2827,23 @@ static void evict_old(void)
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




