Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297228725B
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133017; cv=none; b=HXGdnTGKH7d556YPmH7PBel5lnr2LLlEtpRULnpIvkBoB9TvaFqn84FlrR4vnIItL6Q1n54f5183qjL7CWSI9QrgBTaJfUzyPmfP/e+P2xiMoekiAyjP4f9JeIE6Nc2gyJVeOJ5lwwLXUdp43cvjTs8nVCbDU7vbLX9aSZhd8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133017; c=relaxed/simple;
	bh=1x+T/mS6bdtpjlSPVSbttWJFzhb3F64WNPwtHsKMUPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6jO2XFcrL2qyZFUR7/a5o5FPej+dQ89ZZAY2VaCu9gh7Mc7tfaB1upgvl6026SESb2MJU70bHFZh9JNvy6hdMNBf11OZ0mP8GRSb/S7HWuRB8HaHW0z03R5jrUYeMpNgXVX2m9KeBAlh5KWgbDK2a/oCn4LbEW0q4nlhkQimr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtkxERRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtkxERRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5411F000E9;
	Wed, 15 Jul 2026 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133016;
	bh=OAQSOcVMBUGL6QqeAd3VMJtirY48XrMjhI+/kyT8eBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XtkxERRGthKQzXfkVDFab6XWpP/7zfBN/dlVOga8OdgfEPsLOs8cfusce67shud8V
	 HU3n/+zR5Evs/b7Xs9lHxtFiZfErLNJK9GNhjR95BK8qHAKHwgNrEYhNR5U8HWHZez
	 HiCuJDfO5H45Qb5FXjSUFQ12we7flhZaQmkM/DmmRPF3zBxgA8NaD+cQK5/H+bwAx7
	 OjCtyVtFDi6pVw3JBoWPfm62zuX1B9cjhjKElj5hLqk2c914UMslWPUilqbozoms+h
	 f5ntS6tZEH8qD5ddOEklgI8uKMwrKWnt85xLoafm8fJ46o8hoIXUpcBelF7uChGyw5
	 K9J0AlnUV9Q4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Chuck Lever <cel@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Kirill Tkhai <tkhai@ya.ru>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Price <steven.price@arm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Vlastimil Babka <vbabka@suse.cz>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Alasdair Kergon <agk@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Anna Schumaker <anna@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bob Peterson <rpeterso@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Carlos Llamas <cmllamas@google.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Chao Yu <chao@kernel.org>,
	Chris Mason <clm@fb.com>,
	Coly Li <colyli@suse.de>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	David Sterba <dsterba@suse.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Huang Rui <ray.huang@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	Jason Wang <jasowang@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Juergen Gross <jgross@suse.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nadav Amit <namit@vmware.com>,
	Neil Brown <neilb@suse.de>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Olga Kornievskaia <kolga@netapp.com>,
	Richard Weinberger <richard@nod.at>,
	Rob Clark <robdclark@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sean Paul <sean@poorly.run>,
	Song Liu <song@kernel.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yue Hu <huyue2@coolpad.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
Date: Wed, 15 Jul 2026 12:30:05 -0400
Message-ID: <20260715163006.950613-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071318-kindling-retrial-f9b4@gregkh>
References: <2026071318-kindling-retrial-f9b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Qi Zheng <zhengqi.arch@bytedance.com>

[ Upstream commit 1dd49e58f966b1eecd935dc28458a8369ae94ad1 ]

debugfs_remove_recursive() will wait for debugfs_file_put() to return, so
the shrinker will not be freed when doing debugfs operations (such as
shrinker_debugfs_count_show() and shrinker_debugfs_scan_write()), so there
is no need to hold shrinker_rwsem during debugfs operations.

Link: https://lkml.kernel.org/r/20230911092517.64141-4-zhengqi.arch@bytedance.com
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Chuck Lever <cel@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Kirill Tkhai <tkhai@ya.ru>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Chris Mason <clm@fb.com>
Cc: Coly Li <colyli@suse.de>
Cc: Dai Ngo <Dai.Ngo@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nadav Amit <namit@vmware.com>
Cc: Neil Brown <neilb@suse.de>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Olga Kornievskaia <kolga@netapp.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Song Liu <song@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: b902890c62d2 ("mm/shrinker: do not hold RCU lock in shrinker_debugfs_count_show()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shrinker_debug.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 39c3491e28a3ef..b0d818eacbeb5d 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -49,17 +49,12 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	struct mem_cgroup *memcg;
 	unsigned long total;
 	bool memcg_aware;
-	int ret, nid;
+	int ret = 0, nid;
 
 	count_per_node = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
 	if (!count_per_node)
 		return -ENOMEM;
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
-		kfree(count_per_node);
-		return ret;
-	}
 	rcu_read_lock();
 
 	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
@@ -92,7 +87,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
 	rcu_read_unlock();
-	up_read(&shrinker_rwsem);
 
 	kfree(count_per_node);
 	return ret;
@@ -117,7 +111,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 	struct mem_cgroup *memcg = NULL;
 	int nid;
 	char kbuf[72];
-	ssize_t ret;
 
 	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
 	if (copy_from_user(kbuf, buf, read_len))
@@ -146,12 +139,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		return -EINVAL;
 	}
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
-		mem_cgroup_put(memcg);
-		return ret;
-	}
-
 	sc.nid = nid;
 	sc.memcg = memcg;
 	sc.nr_to_scan = nr_to_scan;
@@ -159,7 +146,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 
 	shrinker->scan_objects(shrinker, &sc);
 
-	up_read(&shrinker_rwsem);
 	mem_cgroup_put(memcg);
 
 	return size;
-- 
2.53.0

