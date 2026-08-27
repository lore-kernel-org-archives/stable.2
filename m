Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D133D4E4;
	Thu, 27 Aug 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812387; cv=none; b=JHOPtmqjg/fSYqjD3mZh86qkYkMWFRTIVJl3NeyJpr82j86VanpGNi74Ih+UXaYCg7hm3eKIRHjw+wu69j5fsXAWNut8ZRtghTJ1UWNrLtQyoFBbonrKJ7ijb/SQ/remaSOXYNmy+7QkTulPSbauYgUXcNpDuUdodGmwi5RK7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812387; c=relaxed/simple;
	bh=MA3d8yx99/oI/XrFQeidGagaRQUqS6Knz4H7ID2Ta6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s50abko+w/u4SRrjG8D5DV3cx1aNnUN7rlfxWZc2fbfVBy3/Lh3jB0Tk3C5fBOYzNfKgeOVcQpa5eeWxcJejFOV74kqkYiD8v+sUpFV3ia0ZvkmBwFr0OR10TDRcQlktQhEZRYdukeoRKrvZ4zAd1ZcpRd6LRLbfOXSdZd6idP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XxsKsDyd; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XxsKsDyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vN
	st5f3zQ5YkfDCFfmcvsU0g8V4x7Ap9CwheNFRxF+c=; b=XxsKsDydGODahuliZj
	qT4rGRDisu9Iuq1MLNf8TPW9JI3yWqwDD7KRHF8MhewHghvN+iiRaEfDp4Jo+HfW
	udsH38AXUVIHtLeFZp4Q0fCe2Nei7wY/s55690wX8ugGtW7lVS5eyVQe/XP0MVvF
	9uEyEfxCwD0/1uvRx8xBKrtxE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3j4oG2o9q0hcgSQ--.17256S4;
	Thu, 27 Aug 2026 14:32:41 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v3 3/3] md/raid5: fix NULL pointer dereference in raid5_free_percpu
Date: Thu, 27 Aug 2026 14:32:35 +0800
Message-Id: <20260827063235.85375-3-ghuicao@163.com>
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
X-CM-TRANSID:_____wD3j4oG2o9q0hcgSQ--.17256S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury7Kr1xuFWrZw1fKF48WFg_yoW8CF4kpw
	4DGr4Yg3s5Aan5KasFvw4UuF15XanrGrW8Aas3Ww4FvFs8ZrnFywsxZFW8WFy8AFZaqayx
	t3s8XrnxJa1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO4SrUUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC+wo3yWqP2gqtgQAA3W

From: Cao Guanghui <caoguanghui@kylinos.cn>

If cpuhp_state_add_instance() fails in raid5_alloc_percpu() (e.g., the
startup callback raid456_cpu_up_prepare fails due to an allocation
failure), conf->node is never added to the cpuhp instance list and
its pprev remains NULL (from kzalloc initialization).

When setup_conf() then jumps to abort, free_conf() calls
raid5_free_percpu(), which checks conf->percpu (non-NULL, since it was
allocated before the cpuhp failure) and proceeds to call
cpuhp_state_remove_instance().  This calls hlist_del() on the unhashed
node, which dereferences node->pprev (NULL), causing a kernel panic.

Guard the removal with hlist_unhashed_lockless() so that the cpuhp
instance is only removed if it was actually added.  The lockless variant
uses READ_ONCE() for the pprev read, which is safe here because the
actual removal is synchronized by cpuhp_state_mutex inside
cpuhp_state_remove_instance().

Fixes: 29c6d1bbd7a2 ("md/raid5: Convert to hotplug state machine")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---

Changes in v2:
  - Use hlist_unhashed_lockless() instead of hlist_unhashed() to avoid
    a KCSAN data race warning when another array is concurrently added
    to the same cpuhp instance list (Sashiko)

 drivers/md/raid5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7539,7 +7539,8 @@ static void raid5_free_percpu(struct r5conf *conf)
 {
 	if (!conf->percpu)
 		return;
 
-	cpuhp_state_remove_instance(CPUHP_MD_RAID5_PREPARE, &conf->node);
+	if (!hlist_unhashed_lockless(&conf->node))
+		cpuhp_state_remove_instance(CPUHP_MD_RAID5_PREPARE, &conf->node);
 	free_percpu(conf->percpu);
 }
-- 
2.34.1

