Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CDB4718E4
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928093; cv=none; b=JRyN7ORbnZOmQp6XzDOvuWxYXZ9i92xSfBq44Ct919b85Dx3NUjewaUEZ48Hj15vX6g3SOqamsiH/rkWtPyZw/V8CgbN3Ui8V7B/iJBQ+OXSFK5B6YIat6cH7GEG+I5RCOJ2MjRiQ4S25vObfFEzPiLP5myHzta74V8ILCY+iC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928093; c=relaxed/simple;
	bh=6e9PYLcx4cb/dyobaeVKbSLjYmejZQhCAXkUBmR+0NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+1+uUoIzRAuHpCo4UMgbo4gkoBgS0zUatW5Qvz1HaV2z0E4GpAFwcz3kD4TfK+OcacRX454gqCif4NweWiPECKnJn0sP3UorUZPtWlt5wM53v9ZmzHhuM5AsoAlPgr3NxrcKV7soSUbwhzSpfaFPp2YWPFADHnHmHX0N+Brpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehmszl29; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehmszl29"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddaa08c890so20566235ad.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789928091; x=1790532891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=78MZgf5P4Kpkmmf2WHQZAsRyEnedhA8FT/mxKha/EbY=;
        b=Ehmszl299AiMP6R6FtjdKNg2D8SMLMfgtThMR8Ou6Cq9duepUTSo217WKjnI4TeZlJ
         7GfmTyXpTd8Sd5ZBjO9785c0tXp8KUHMjkfzCAu8vVRwqRwxxPj1v1qafcxbKCIKCjC4
         lODOoJf0/kuo9neabiFcaVeUVT5MA1+9doKTEIvhdPLPSZiExKTRbomgVc7NPw/sUTGl
         j2kbV9jhcGDAzCjgRmlr3LPNTPfVxAkqMTRvaB8+CYwIqqwKmcKfc8QAlVB2ZDcJscHc
         GjbpHWxIsTYEgNZ3VNKHqCQMRGHFcPomU9FPDM8HHP8fTEcm6bBRaVehKz6xTI3vlbGC
         hqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789928091; x=1790532891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=78MZgf5P4Kpkmmf2WHQZAsRyEnedhA8FT/mxKha/EbY=;
        b=T6eiVRozH7qEN+nqGHOEe90nXuC05S8u6SWj7fEqXJtoMuiFgh9qso+nWCv6O9NEPs
         CnBGWZFe67qiRMkWzQUxsfe3bhDqaJqjXu/MzoKRRAC/EHcHN530dKgxQ4thaARkZWSb
         ZQHlpuxvbfN9guE48w4Nt1485WqthbVz1X3nzDy9vP3Xx8E0Q0NaQOSDergLWO0YsmHu
         6ebd9pJ3Kw88p3vegMLARQYsJW+RyRKGuylR7cr6lcvp0Tje8MrBkkDOQD/vib78hXb3
         FfKRixFK+QHBpZ7IcRK5bZtg7Y7ppiLl74DAq8/rRfTOeJsx5t/Lgn0Onz5rf/E8t5do
         pqxA==
X-Forwarded-Encrypted: i=1; AKwUvByIYdZxdLM1z6rTxwndhDcDf5PiloNsFGaKuYjGnOeFt896Z/HlHwvt0PWyJI0BouOwyoRa1E0=@vger.kernel.org
X-Gm-Message-State: AFuF++n+JeC2YzJYZGkdthz92rqBBIUWSjkNWQuJ3q9payAGswQJtj7W
	cJnDjM8CAMPjC/JBDQlGqjA0Og6SB6ljDqHiyTaQfUul9Orbvjb0xJVH
X-Gm-Gg: AYBFou10kE7Nff5H33D9edIufyKoZhANBpm0ksAUA2pSdS5zPzFTwUK5RnLvwUYsGAV
	cmzq/h0clHhOoU50yDchywIlfhmK1M+no2J9odf8UawmlxZrmvGplW1Zxrg/Qt0L3Xs8qDDUXyp
	RpYkbwpRgvwgtg2O2Ey3cg2gUDcaGSN7zXx50RemyzrTFuL/JW7LGb4cvgP1k/DvYMz0Rw3CYMA
	Rn4sJ60Jk+GA7NFsRCaE9hmsaZBOaO0nXSC10lFEiGkHZJfe0895snizfGtpku9e/HD22BIkEIx
	NjY0Wsd9EH8iab2r5l4UH8R95CjQbuYgxfibzTnU4uELg1ox12S9SaFoGeevgMiqR7LdG70oRAX
	lnfuxCiz3iiutIpyqHIgOq0dDtgvzQGqM+VwufQjTAGfY/CUIFWkqMsBwhvdQf4kbfTdQFZUSuC
	zlP75wEXOkao+auSACek2q1fos4nW5vV2gyuFaJowcfzz1rr67l96NE8z14sEixf0gXx/PjIZ8H
	SbzcJms71M9hHza9GS6G7Wd0f2JeVHmdhH8DhM8Q/ABfTcDIc2MnMGb343Fx0uABdE6bn58sXkN
	tajgUI0K6/Vp9jz7+cbf
X-Received: by 2002:a17:902:f610:b0:2dd:c100:7cc2 with SMTP id d9443c01a7336-2ddc1007e37mr70989615ad.62.1789928091439;
        Sun, 20 Sep 2026 11:14:51 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179df35sm22087225ad.40.2026.09.20.11.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:14:51 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Guopeng Zhang <guopeng.zhang@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>
Cc: Michal Koutny <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 1/3] cgroup/cpuset: return PERR_NOCPUS in remote_partition_enable()
Date: Sun, 20 Sep 2026 18:14:47 +0000
Message-ID: <20260920181449.3122336-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <aa90bb73-c2af-4d13-8f2a-0435aa528058@linux.dev>
References: <aa90bb73-c2af-4d13-8f2a-0435aa528058@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6da580ec656a ("cgroup/cpuset: Don't allow creation of local
partition over a remote one") updated update_prstate() to prevent creating
a top-level local partition whose exclusive CPUs conflict with an existing
remote partition.

However, if a top-level local partition A1 is created on CPUs 1-3, has a
non-partition member child A1/A2 with cpuset.cpus.exclusive = 1-3, and a
grandchild A1/A2/A3 is then enabled as a partition root on 1-3,
update_prstate() sees !is_partition_valid(parent) (since A1/A2 is a member)
and calls remote_partition_enable(). Because remote_partition_enable() does
not check whether tmp->new_cpus intersects subpartitions_cpus, A1/A2/A3 is
enabled as a remote partition on CPUs already owned by A1, triggering:

  WARNING: kernel/cgroup/cpuset.c:1594 at update_prstate+0xbef/0xd70

Return PERR_NOCPUS in remote_partition_enable() when tmp->new_cpus
intersects subpartitions_cpus, matching the error code used by
remote_cpus_update() for subpartitions_cpus conflicts, and add a
corresponding regression test case to
tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Tested in QEMU on Linux 7.3.0-rc3 using
tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Fixes: 6da580ec656a ("cgroup/cpuset: Don't allow creation of local partition over a remote one")
Suggested-by: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Split the series into 3 patches (one per logical change and Fixes: tag).

 kernel/cgroup/cpuset.c                        | 4 +++-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c8ab89cfbe3d..7381fa8502e7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1678,8 +1678,10 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 * Callers must have validated that effective_xcpus is not empty.
 	 */
 	spin_lock_irq(&callback_lock);
-	if (cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus)) {
+	if (cpumask_intersects(tmp->new_cpus, subpartitions_cpus) ||
+	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus)) {
 		spin_unlock_irq(&callback_lock);
+		if (cpumask_intersects(tmp->new_cpus, subpartitions_cpus))
+			return PERR_NOCPUS;
 		return PERR_HKEEPING;
 	}
 
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a1f42ef64bc1..b732078bf319 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -298,6 +298,8 @@ TEST_MATRIX=(
 	" C0-4:X2-4 C1-4:X2-4:P2 C2-4:X4:P1 \
 				   .      .      .      X1      .    0 A1:0-1|A2:2-4|A3:2-4 \
 								       A1:P0|A2:P2|A3:P-1 2-4"
+	" CX1-3:P1 CX1-3  CX1-3    .      .      .      P1     .     0 A1:1-3|A2:1-3|A3:1-3 \
+								       A1:P1|A2:P0|A3:P-1"
 
 	# Remote partition offline tests
 	"   C0-3    C1-3  C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1|A2:1|A3:3 A1:P0|A3:P2 2-3"
-- 
2.49.0
