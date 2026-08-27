Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155233E34B;
	Thu, 27 Aug 2026 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812398; cv=none; b=u8dbKd3qpFtng0srzD7KSOcNoyWN+A1FJt0a6zS5TeXrtZWwAqvKLmAdj63Gx6yL3S4qTlj89hrm/wfhvQMhBLodcRzhlqYUaAF1n7dRqCkB7yHOmN9mtny4xnmvh26Pd6oTJH0gy7dyHpyPsS/OZSQHUAyBFXYy3nui69es2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812398; c=relaxed/simple;
	bh=9BuPj2Q6nnqmomxr5ojIWuAlLQGEjeEupTUTB2nIRY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/EPDHMbJYBebLKTjXk5+hxXn3Bklt32EuLyFQh6B0jvciI3jIFvGr4vDZY/JxdzxUlhE0P+Rmo/ZJWzb2CjqZHghimTPhkrD/ou/AxroF8yotlByg0hHvzo53qHnUsK1A67roL2Ei52SY5t3MwDY6ToWX5sfKZOyFgSV49fBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nOvRnxZT; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nOvRnxZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wa
	CNnpILeDgl2UscKzIFsRiLjz7qOYqJMN3bvwNOKRo=; b=nOvRnxZT4C9KY3YSRH
	BD42IJCb+EwMyFMzMikH7+NlUVlX2O3fjSiUYSS2/jqo/l44LkgPPUqPBxIo5DX8
	/+CIyD9A+Gct6w4fD1g+/JKLxLGitPVdVti+RDnBSEIfYsrgwZfm3vkk7oqJoEZ9
	S3ovoYCYHZQ/hz5dec2t06kv0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3j4oG2o9q0hcgSQ--.17256S3;
	Thu, 27 Aug 2026 14:32:40 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v3 2/3] md/raid5: fix leak and use-after-free in resize_stripes error path
Date: Thu, 27 Aug 2026 14:32:34 +0800
Message-Id: <20260827063235.85375-2-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827063235.85375-1-ghuicao@163.com>
References: <20260827023803.36602-1-ghuicao@163.com>
 <20260827063235.85375-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3j4oG2o9q0hcgSQ--.17256S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCryUuryDCF1ktFW8CF13twb_yoW5Xw48pr
	W3KFs3Z3WUW3s3twnrCw48uF1fG3yvqFWrGFya9w4vvFs8Kr10yr1rKrWDWryjyrn3tay2
	qFZ0q395JF1vy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTD73UUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC4Ag3yWqP2giuVgAA3Z

From: Cao Guanghui <caoguanghui@kylinos.cn>

resize_stripes() has two issues in how conf->disks is replaced:

1. Memory leak: conf->disks is replaced with ndisks in Step 3, but
   pool_size is only updated at the end with "if (!err)".  If Step 4
   (allocating pages for new stripe slots) fails, pool_size retains the
   old value.  On teardown, free_conf() iterates only pool_size entries,
   leaking (newsize - pool_size) extra_page allocations.

2. Use-after-free: conf->disks is freed and replaced without holding
   mddev->lock, while raid5_status() (called from /proc/mdstat via
   md_seq_show) reads conf->disks[i].rdev under mddev->lock.  The
   freeing and replacement happen under reconfig_mutex and
   cache_size_mutex, which do not exclude mddev->lock holders.

Fix both by deferring the conf->disks replacement until after Step 4
succeeds, and performing the pointer swap under mddev->lock so that
concurrent readers in raid5_status() see either the old or new array,
never a freed one.  If Step 4 fails, ndisks is freed instead.

This also preserves the original retry behavior: pool_size is only
updated on full success, so check_reshape() correctly calls
resize_stripes() again on retry.

Fixes: ad01c9e3752f ("[PATCH] md: Allow stripes to be expanded in preparation for expanding an array")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---

Changes in v2:
  - Defer conf->disks replacement to after Step 4 instead of setting
    pool_size early, which would break reshape retry logic (Sashiko)
  - Add spinlock protection around the pointer swap to fix a concurrent
    use-after-free in raid5_status() (Sashiko)

 drivers/md/raid5.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2639,9 +2639,7 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 				if (ndisks[i].extra_page)
 					put_page(ndisks[i].extra_page);
 			kfree(ndisks);
-		} else {
-			kfree(conf->disks);
-			conf->disks = ndisks;
+			ndisks = NULL;
 		}
 	} else
 		err = -ENOMEM;
@@ -2685,8 +2683,20 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 	}
 	/* critical section pass, GFP_NOIO no longer needed */
 
-	if (!err)
+	if (!err && ndisks) {
+		struct disk_info *old_disks = conf->disks;
+
+		spin_lock_irq(&conf->mddev->lock);
+		conf->disks = ndisks;
+		spin_unlock_irq(&conf->mddev->lock);
+		kfree(old_disks);
 		conf->pool_size = newsize;
+	} else if (ndisks) {
+		for (i = conf->pool_size; i < newsize; i++)
+			if (ndisks[i].extra_page)
+				put_page(ndisks[i].extra_page);
+		kfree(ndisks);
+	}
 	mutex_unlock(&conf->cache_size_mutex);
 
 	return err;
-- 
2.34.1

