Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F137F8C3;
	Tue, 23 Jun 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223128; cv=none; b=QPXrUjPYYTCsY3qq2/tyb0Due8t0VJJN0qUdM/PhmC9s7YmSrCVrnr0PsRxqj/1pEqQz18W60C39qiXNvvuqFfOS7icfrWeFvQt/sZZkDCd6aMXnFl312fBX/SfywIAwoFngXjR6oFKI4VrPedRj6VSqnhcUWJM1QZ1n5t56Yvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223128; c=relaxed/simple;
	bh=ev2VrbjCP3fdzkAcWElGwDW6j0kryEOXvcL+txeyncs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFjejdO3DB6mqSbWe6nL5lypkQ25qZGpfMrDMaeQ68LWOrt+AfMSZAkgulUniuYcgszisQnJpRTz4AGm3SdOxwq6gavXwUjvTEWW9WincrzvK4/vuqeNltgo6QRzxyVxnszy5eq9m8N+nkna5cs+amEAAqqgWciOgrKAW483Ud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfKOJ6+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfKOJ6+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637FE1F000E9;
	Tue, 23 Jun 2026 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782223127;
	bh=qPJB5FWFfqGea7PI1Ch17WntCkpS3wYF0Wfk6C5GHV0=;
	h=From:To:Cc:Subject:Date;
	b=XfKOJ6+DecxCNelskMTyAqIzRcKsZKS/J/idHWt196ogpNgr8yfmxTKB3WG5qk41u
	 4oNhZyKcT2ztSlGEzecagYQddoGB7qhQ4+zbvstJfIezdbx/qyNIr5s6kLpw74Ui/W
	 /R+ATITjJ1q5RD8XDtcoD5cGaplDWh/rjpQW856c2k+5e1PD0uGo0K2i8m0PwYP8qI
	 RTwnIic+YghWruvA0y+Cua8nYI5IYzR/TlosREefjUAlT3Gn4z7/62nnAAswSQ6nha
	 tH/7IQjycQ3RUrA1Uf2hNPz2k+26saBel+QBEOKKLD75Yoa2LRN7tKDeJ8NHFT6V02
	 UvpfoVk6UO/9g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm/damon/ops-common: handle extreme intervals in damon_hot_score()
Date: Tue, 23 Jun 2026 06:58:31 -0700
Message-ID: <20260623135834.67189-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three issues in damon_hot_score() that comes from wrong handling of
extreme (zero or too high) monitoring intervals user setup.

When the user sets sampling interval zero, damon_max_nr_accesses(),
which  is called from damon_hot_score(), causes a divide-by-zero.
Needless to say, it is a problem.

When the user sets the aggregation interval zero, the function returns
zero.  It is wrong, since the real maximum nr_acceses in the setup
should be one.  Worse yet, it can cause another divide-by-zero from its
caller, damon_hot_score(), since it uses damon_max_nr_accesses() return
value as a denominator.

When the user sets the aggregation interval very high, damon_hot_score()
could return a value out of [0, DAMOS_MAX_SCORE] range.  Since the
return value is used as an index to the regions_score_histogram array,
which is DAMOS_MAX_SCORE+1 size, it causes out of bounds array access.

The issues can be relatively easily reproduced like below.  The sysfs
write permission is required, though.

    # ./damo start --damos_action lru_prio --damos_quota_space 100M \
            --damos_quota_interval 1s
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/0/monitoring_attrs/intervals/sample_us
    # echo 0 > contexts/0/monitoring_attrs/intervals/aggr_us
    # echo commit > state
    # dmesg
    [...]
    [  131.329762] Oops: divide error: 0000 [#1] SMP NOPTI
    [...]
    [  131.336089] RIP: 0010:damon_hot_score+0x27/0xd0
    [...]

Fix the divide-by-zero intervals problems by explicitly handling the
zero intervals in damon_max_nr_accesses().  Fix the out-of-bound array
access by applying [0, DAMOS_MAX_SCORE] bounds before returning from
damon_hot_score().

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC v1.3
- RFC v1.3: https://lore.kernel.org/20260623011652.1354-1-sj@kernel.org
- Drop RFC again.
Changes from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260622141027.29145-1-sj@kernel.org
- Drop patch 2 and make patch 1 fixes all damon_hot_score() problems.
Changes from v1
- v1: https://lore.kernel.org/20260621154808.86431-1-sj@kernel.org
- Add out-of-bound array access bug fix as patch 2.
- Add the RFC tag again.
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260620171413.89555-1-sj@kernel.org
- Wordsmith commit message.
- Drop RFC tag.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260619205144.150664-1-sj@kernel.org
- Handle zero aggr_interval case.

 include/linux/damon.h | 8 ++++++--
 mm/damon/ops-common.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6f7edb3590ef9..888570f55b416 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1065,9 +1065,13 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
-	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
+	unsigned long sample_interval;
+	unsigned long max_nr_accesses;
+
+	sample_interval = attrs->sample_interval ? : 1;
+	max_nr_accesses = min(attrs->aggr_interval / sample_interval,
 			(unsigned long)UINT_MAX);
+	return max_nr_accesses ? : 1;
 }
 
 
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 5c93ef2bb8a97..d1842e2b00ef8 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -143,6 +143,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
 	 */
 	hotness = hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
+	hotness = max(min(hotness, DAMOS_MAX_SCORE), 0);
 
 	return hotness;
 }

base-commit: c12377ad97c98e0bee10870abf4ab1101a946b4c
-- 
2.47.3
