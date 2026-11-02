Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585033;
	b=Oq6Gl+AjasONbbBW8JOS+yg3jOPOvtskNrvWTj3wRNUQpYqwaUJzf4/ssPELDfqTZZR3
	 utc60YriVpQhfdIJKrM9/fO0Su/4DZ00CiL+K2/4WijeFcJ+ipJV9nlsmvDbMf8ROQ5UL
	 UaJ26awYQqzYj0/uG60UQb08cQHVMPh6hPUb2uhUb2nc5EQcD7jhp51EI/+j4RAKOHem7
	 xliZeVMZb/nvLDFqfhXEu54maRajbu+Uy+GDMa+XuasojJtV/4OANSrucSaB5HEeMdG64
	 +neqnC85CiQKk1uJviJnt4PMT8pTJErzaL88pIGzOMdI0EOdGCuO4y0K69mhX5F1Vyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=r4VI7UXXI4YmbL2jVA9MPaFqI9dJHWqNQnjA9+3Oft4=;
	b=Sh5uhyNqTu0VTXcCvrBf+aHUXCVhQX1bwZmM2U503P/mqG1RZtqweDr18F1RqqJo/ty8
	 wvqFKt5fneIxSRFkxp/mnmVqLXxN4WISplEu0bQlGSJf145VR/GFOJYxCz8ktyEGeN2G6
	 8/kBLTE2+ciEMj03Q0HjlTFDTIDVmcq8YSfz6kfJbTJUL9L43FPN/Zi2eDqbYEdRQhYzP
	 af/juciE13h4oyYHCOE5RRfA0LSd9lL/OJ9ST0OE+qJIZmOG8VsRUFkEWYGMPhnLWqmUo
	 qCD7IODjmoGi2tUN7flCYSGjda5Zop33A5zpMejw+tk/suSxVudjylp3cROxIX5OXRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ePWqom8;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DA606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C66DA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ePWqom8
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14fc585291cso1900878c88.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793585032; x=1794189832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r4VI7UXXI4YmbL2jVA9MPaFqI9dJHWqNQnjA9+3Oft4=;
        b=0ePWqom8FDl+tsRMj7rvdaHbjqPQB/Z2VqmvzrXZoHqOT1M9WQYZJeQ+Dul9gZP2Hy
         YB9XjQwfF6+uKHczmtREMhk5Z3xw1KTZndqGkH/+T2fGJslnVw1/rGUmKaYzIbu+3zZC
         oqo+WuSu4N1urQtVWqzPtyg/iCijkJNDzoaenXSx93C29rwC62gUNP4sh4QJPkg4D7q2
         FbINchDBv1X8CMY8fM69UiCFTNbWW4HiNGQvESJzvKI1tnyL+ZiHzb3/pN3yzbptPIOA
         LknFI8GXe9gmUwKd4ohlx+iwf1HvmQxIiAUb7JO6I+Nka68MJajO7znoTnn/gqZYbJcp
         w/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793585032; x=1794189832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4VI7UXXI4YmbL2jVA9MPaFqI9dJHWqNQnjA9+3Oft4=;
        b=vz1ZcCnOZWvPi/UyF09+8DfLPow/jodBc7H/6I9Wi7Um8npG4QEdQBdKcUgbJK0ZkQ
         pjcYvoi8QneUM+KFxdXmb+7gXyl6NvfTvC78I6yiiBMVcFBzk/FuYFNPAz294e4o2+vh
         K7ul0InpAJdfN793lD4v43k34gnEPKjAka11DdfxuMhV2cGhXbbn/Ef1fTnI53OoJ66e
         0uuPX6PShOduaUo7Gy/sacbp81G1cxnnDHRU9J1Lvn4CgQawFaKa4fEP0e49KWmj/rH4
         x16CqVt6Mkn+/vMNdktwpKErRIWoXjmdgvvKNvL0tx42KH0LdyAZ/WuQWciphXSjLAM0
         3Oyw==
X-Forwarded-Encrypted: i=1; AKwUvBwVIUs16NYqucrDnipfwOAk7Llch+J/RIihCckbtO9fC6U79d6Af4Ki+f7PzkAtqdhHTrQVmaU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ27QbaKpTLb1ljpJjpHU9nLJi7oaOrpCPWbLmTn7frBU0ljlOZ
	5bXJEI+O73g3Y3HRF5+0cH+B3kxNLVG9koo6IsuFfFcwDyrlnwGV2xfe
X-Gm-Gg: AYBFou0mTdEwsdJ5BYR+Hl2imYr5RCEf5xwHfrQ/bZyo6YSA7uG5cPeygdOvVFrbKSk
	9Hwb+DZxsTZoPnx97zsQJycSWHL9bSDP0IiN1XPrnpkUOVLeTlkuNHvO41z1ctsz1Hl6YZRgoS6
	wMnqiT7qOc9eGwq3m6Qa+8utOaFwBRmQPt82weaY3/343eYq6joPDl7JX05r8dPjxad4J//MzQs
	S5IiX2feBZg5C3iJzYFsEMfAB9M2RBO+4naT8fbgokCaYro0zp/LROn7NmuIg2qWoM0cR6TZUC6
	VOaq3922cnL1x97mFC49FdyloUzaNX9BDpbghl+UNSbySX7TzhCMPt8s7hqMrgUbGeq7+vsRNMO
	bgenXluBJsaCBx3PBER3tvJBgzsfqEOW46FkMYlykaPfp3uo6W6sH4SpWiox5zeF0oU4CAYTP1B
	P78YYuumZyNVg/glPzeFfiiKbEWDVfKxFLfVwMtp0U3SMi/40WbqeD2H+c4Q5M3KJwcPgOfnqkr
	BYC39MSipK3EPLDhqUnLsLNppgfexp7OVUcqmYW/P+9Ad3fVLCygFzRjQo8rc/Kd5rTqofaJ4dl
	N2YrV0MsxrhA1824JS9cB4kl
X-Received: by 2002:a05:7022:1402:b0:193:9568:b42a with SMTP id a92af1059eb24-1ac5c45fd35mr12531643c88.8.1793585031834;
        Sun, 01 Nov 2026 18:03:51 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm28456015c88.23.2026.11.01.18.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:03:51 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Sun, 01 Nov 2026 21:03:44 -0500
Subject: [PATCH RESEND v4 1/2] ext4: fix shrinker scan budget accounting in
 ext4_es_scan()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-fix-ext4-es-scan-nr-scanned-v4-1-1290a288f5ea@gmail.com>
References: <20261101-fix-ext4-es-scan-nr-scanned-v4-0-1290a288f5ea@gmail.com>
In-Reply-To: <20261101-fix-ext4-es-scan-nr-scanned-v4-0-1290a288f5ea@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, 
 Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>, 
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Zhang Yi <yi.zhang@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

do_shrink_slab() reads count_objects() once per invocation to derive
a one-shot scan budget, then calls scan_objects() repeatedly until
that budget is exhausted or scan_objects() returns SHRINK_STOP.
include/linux/shrinker.h documents that scan_objects() "should track
its actual progress" in sc->nr_scanned, so do_shrink_slab() can tell
when there is nothing left to examine and stop early.

ext4_es_scan() never updates sc->nr_scanned, so it defaults to the
full sc->nr_to_scan on every call. do_shrink_slab() therefore always
believes a full batch was examined, regardless of what __es_shrink()
actually did, and keeps calling scan_objects() until the budget
derived from the (possibly stale) percpu extent_status count is
drained, even after sbi->s_es_list has nothing left to examine.

Make __es_shrink() report the number of extent_status objects it
actually examined through a new nr_scanned output parameter, derived
from the existing per-extent nr_to_scan counter that
es_reclaim_extents() already decrements as it walks the tree. Have
ext4_es_scan() copy this into sc->nr_scanned, and return SHRINK_STOP
once it comes back zero. Key this off nr_scanned rather than
nr_shrunk: a batch that finds every extent still referenced
correctly ages them without freeing any, and that is real progress
nr_shrunk would miss.

nr_scanned can come back zero for more than a genuinely empty list:
es_stats_shk_cnt is a stale percpu count, an inode can be
momentarily skipped (precached, lock contended), or durably have
nothing shrinkable (i_es_shk_nr == 0) without es_reclaim_extents()
ever touching nr_to_scan. Treat all of these alike: not stopping
doesn't help the transient cases either, since do_shrink_slab()'s
budget only decrements by nr_scanned, so retrying forever at
nr_scanned == 0 never terminates.

Tested by fallocate(2)-ing 10000 4K files (to populate the shrinker
with reclaimable unwritten extents without also exercising the
extent_status "referenced" second-chance path, which needs a
separate two-pass accounting of its own) and triggering
"echo 2 > /proc/sys/vm/drop_caches", while tracing the
ext4_es_shrink* tracepoints:

                      total scan_objects()   calls with
                      calls                  nr_shrunk == 0
  before this patch   429                    189 (44%)
  after this patch    239                      1 (0.4%)

Fixes: 1ab6c4997e04 ("fs: convert fs shrinkers to new scan/count API")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents_status.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 6e4a191e82191..b8821b93693a9 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -184,7 +184,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			      struct extent_status *prealloc);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
-		       struct ext4_inode_info *locked_ei);
+		       struct ext4_inode_info *locked_ei, int *nr_scanned);
 static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			    ext4_lblk_t len,
 			    struct pending_reservation **prealloc);
@@ -1670,7 +1670,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 }
 
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
-		       struct ext4_inode_info *locked_ei)
+		       struct ext4_inode_info *locked_ei, int *nr_scanned)
 {
 	struct ext4_inode_info *ei;
 	struct ext4_es_stats *es_stats;
@@ -1679,6 +1679,7 @@ static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 	int nr_to_walk;
 	int nr_shrunk = 0;
 	int retried = 0, nr_skipped = 0;
+	int orig_nr_to_scan = nr_to_scan;
 
 	es_stats = &sbi->s_es_stats;
 	start_time = ktime_get();
@@ -1738,6 +1739,8 @@ static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 		nr_shrunk = es_reclaim_extents(locked_ei, &nr_to_scan);
 
 out:
+	*nr_scanned = orig_nr_to_scan - nr_to_scan;
+
 	scan_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
 	if (likely(es_stats->es_stats_scan_time))
 		es_stats->es_stats_scan_time = (scan_time +
@@ -1774,15 +1777,36 @@ static unsigned long ext4_es_scan(struct shrinker *shrink,
 {
 	struct ext4_sb_info *sbi = shrink->private_data;
 	int nr_to_scan = sc->nr_to_scan;
-	int ret, nr_shrunk;
+	int ret, nr_shrunk, nr_scanned;
 
 	ret = percpu_counter_read_positive(&sbi->s_es_stats.es_stats_shk_cnt);
 	trace_ext4_es_shrink_scan_enter(sbi->s_sb, nr_to_scan, ret);
 
-	nr_shrunk = __es_shrink(sbi, nr_to_scan, NULL);
+	nr_shrunk = __es_shrink(sbi, nr_to_scan, NULL, &nr_scanned);
+	sc->nr_scanned = nr_scanned;
 
 	ret = percpu_counter_read_positive(&sbi->s_es_stats.es_stats_shk_cnt);
 	trace_ext4_es_shrink_scan_exit(sbi->s_sb, nr_shrunk, ret);
+
+	/*
+	 * Key SHRINK_STOP off nr_scanned (extents actually examined), not
+	 * nr_shrunk (extents actually freed): a batch that finds every
+	 * extent still referenced correctly ages them without freeing
+	 * any, and that is real progress nr_shrunk would miss.
+	 *
+	 * nr_scanned can come back 0 for more than a genuinely empty
+	 * sbi->s_es_list: es_stats_shk_cnt is a stale percpu count, an
+	 * inode can be momentarily skipped (precached, lock contended),
+	 * or durably have nothing shrinkable (i_es_shk_nr == 0) without
+	 * es_reclaim_extents() ever touching nr_to_scan. Treat all of
+	 * these alike: not stopping doesn't help the transient cases
+	 * either, since do_shrink_slab()'s budget only decrements by
+	 * nr_scanned, so retrying forever at nr_scanned == 0 never
+	 * terminates.
+	 */
+	if (nr_scanned == 0)
+		return SHRINK_STOP;
+
 	return nr_shrunk;
 }
 

-- 
2.43.0

