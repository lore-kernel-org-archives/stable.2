Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C42E06ED
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125637; cv=none; b=LdsnhbWWnT0nzKkHPnaZQ9cfw087vsG+VMy9SqqK9VKsMJP9iudYGI5BIfDuwXbbf5seEpglHiz7un4WSmy985kmAhegbo6h7oUNaEwSPeSH9YhdFOZGXnyMqCoT/aiflIPGVG24kJCTVnK5JWu1M6Xv4Zh8Si4jIU6xeRxtHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125637; c=relaxed/simple;
	bh=m8PBWOKPZZxgON00ruJEhOjBS0Ajq1Sbq4Lr1ITh1CU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=fR1AGzBSCIJv0my/kPG/JzuXjYmebpHT6oJuNrR+nBbKBwfeEHpzY3CW8zCm+8oyoFpDb1YF3iYaI0raEpTAsErQny0QenD5U9llLoTjyi5F7Wk9Y+hkA2Xi+R35z1klV5AVAmyuoVzqTYGRaSIt+WKGwjPpmw4AWwn/eJf8Gos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ggfP3Oz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ggfP3Oz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF20B1F000E9;
	Wed, 19 Aug 2026 07:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125635;
	bh=STwMFl6b1I4ZRzsPq/cXV++o07BID78mGI6PgzEdFOo=;
	h=Subject:To:From:Date;
	b=ggfP3Oz0uQdkG8I6Hr40840733EzZYSQyEcAJO3VHwsArqnr7DVc/j8U029SzS1Ce
	 IHInlR2NjUadc71/qlrhJ1b7uM9AG37ozLCs3O/Wc8+qjblBHRjcefdVOO1PKB6hk/
	 ClM/VEvkcmw1N6R9hvQd2isMRSsTQPbgfJLj7jcg=
Subject: patch "iio: buffer: Tie IIO dma fence lock lifetime to the fence" added to char-misc-next
To: lars@metafoo.de,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:36 +0200
Message-ID: <2026081936-underpass-shorthand-a940@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: buffer: Tie IIO dma fence lock lifetime to the fence

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From f25ec4627d935dedfb5fe83bd2c2678cdcc19611 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 15 Jul 2026 08:42:44 -0700
Subject: iio: buffer: Tie IIO dma fence lock lifetime to the fence

The `iio_dma_fence` implementation currently uses a lock embedded in the
`iio_dmabuf_priv`. But the `iio_dma_fence` can outlive the
`iio_dmabuf_priv`, which can cause a use-after-free.

Tie the lifetime of the lock to the lifetime of the fence by embedding them
in the same struct.

We can't just hold a reference to the `iio_dmabuf_priv` from the
`iio_dma_fence` since `iio_buffer_dmabuf_release()` might sleep and the
fence release callback is not allowed to sleep.

Note that the `dma_fence` framework now has an internal lock that gets used
when the passing `NULL` for `lock` in `dma_fence_init()`, but in order to
allow this patch to be backportable use an external lock.

Reported-by: codex:gpt-5.6
Fixes: 3e26d9f08fbe ("iio: core: Add new DMABUF interface infrastructure")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/industrialio-buffer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 04b3916f89e2..31c06bffdce8 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -47,9 +47,6 @@ struct iio_dmabuf_priv {
 
 	u64 context;
 
-	/* Spinlock used for locking the dma_fence */
-	spinlock_t lock;
-
 	struct dma_buf_attachment *attach;
 	struct sg_table *sgt;
 	enum dma_data_direction dir;
@@ -58,6 +55,7 @@ struct iio_dmabuf_priv {
 
 struct iio_dma_fence {
 	struct dma_fence base;
+	spinlock_t lock; /* protects base */
 	struct iio_dmabuf_priv *priv;
 	struct work_struct work;
 };
@@ -1706,7 +1704,6 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 	if (!priv)
 		return -ENOMEM;
 
-	spin_lock_init(&priv->lock);
 	priv->context = dma_fence_context_alloc(1);
 
 	dmabuf = dma_buf_get(fd);
@@ -1896,6 +1893,8 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
 		goto err_attachment_put;
 	}
 
+	spin_lock_init(&fence->lock);
+
 	fence->priv = priv;
 
 	seqno = atomic_add_return(1, &priv->seqno);
@@ -1906,7 +1905,7 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
 	 * the dma_fence.
 	 */
 	dma_fence_init(&fence->base, &iio_buffer_dma_fence_ops,
-		       &priv->lock, priv->context, seqno);
+		       &fence->lock, priv->context, seqno);
 
 	ret = iio_dma_resv_lock(dmabuf, nonblock);
 	if (ret)
-- 
2.55.0


