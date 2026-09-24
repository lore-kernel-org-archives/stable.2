Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDE3B1035
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224054; cv=none; b=PeI6ksA2tp9294vfw4HdrxwJSGaRn200kBFsmcxDvdxOk0hz5tMlo/tbuvwamJ3EhFBP/+EBWWJmAkLsVS/UrdywpQ78Egczp2LJD2zs0fPP/huGAyGKgvMUG1lQrgy4Xn1hOeCIPWJWju3IOKHupm5zvs7+mYEafhWLz3jQZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224054; c=relaxed/simple;
	bh=u+ZdoPgS2w70wn1h+xA3nUtkpIPy4KipWT98fYKgD8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0wAysbiNw+QnPLkbPT4QxNP7ic8Zs9gHpqShiu7CkUttRdwmay2Hf2y0KKcpo+ZnrNPIn2gzFixg9zznk+S2L+BhdgRqS9F9YjsvYY42paIZDnJf4Fg+owZv0RcuQq91+tHC9oixk55wfpkSTPDrUkAaH7pfCquVwIBepj3/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eE1zSZm0; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE1zSZm0"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91a931f66so8491765ad.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224052; x=1790828852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Qbj8scDayv1KTbBmuI3ZgNqnI9QLykgXWbif/mQ/Os=;
        b=eE1zSZm095/N3AtbApl472pBykxsgEKQa6zYGoFM4WNwMqF3b6bo0BD+yFbANGS6z6
         g8vJKUwFDUDgUJGXTbWa/Sh1b9Yvmz647hPAR8OXedtg4KIVP6/ZVG+eM4V+ii60Yii9
         0cT4IIzxm7Owm8kTsuNs99XjaxZgaIt82zaaxvQlE7TfkhXONZ+vRlO5miQpetGI6LOm
         qJxZ2A/En/bhIFrjwdUy62dbrZOUtNxFtztbS3vhbsAjlXw1CJ0ET8fBx2BcxR/yPB4B
         t0yJqI/YZmvSCLMZXiNSKjNkvFD7p5ViqAwjrACtviq0R0jflpOwdW0DwSZh6ccKf1NT
         ZWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224052; x=1790828852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Qbj8scDayv1KTbBmuI3ZgNqnI9QLykgXWbif/mQ/Os=;
        b=esTGX+XEu+TMwpoOaKMPJ54HlndbQcmPzPc5cC4InGRdBmUY2ryXPo/iQOD5o3qn5y
         NJ9wClb6VuMA6sA8FtF54gdqLLVYDa96MZ5bZdMPhJ+Z4APFSitDB691RgjXRmPV5NiQ
         Phl0i3hPGrWmpu8Iqi/A9NKG6xmIXyTTrGgIGPseOI3mwpHZYsNZwff8oiC3q4AzJ8fC
         2wVL4MJhKwwE5vC8Dv+XhyLxI/heCctigCEnq0DhqycJaL8LY5Y4Fd/ax1fLQQwlUk1J
         PsJygJasPrZZvUpegzm/F+S9P7N6NAPsWNX8vgJhaYoOLYCy3ip+1+IKiKugiFH4F1XX
         C9RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJqPFsJr3IDUssKyF57k1n0aEmosL3UYELnjbViRvdj0HTn1rjE+ptcnhSwyBEdkTEnNtmPrc=@vger.kernel.org
X-Gm-Message-State: AFuF++kRGC9OyJ5GOBMYxGfRBUkV1EsQNk6i146GrN2l/wB3NXIyYw6X
	/1/6N6noAvJrVO/w46V1ugKSfpWPnFHe417bDYI3a0hSu5Xmz4zq10UI
X-Gm-Gg: AYBFou0z80Ddfu6Slp/sLRHQpD9QcTnKseFXvDnshKTvWrm2zvGMA+H5low+yoE4Q9H
	rNcgmVDhAVflw7Ge3IcSwE4KpsK7Z0Ui8tq1Wx5YOX0dlcMsbTy53JfsWpe41S81Lfa0LnZpeeN
	88WEyj+F2uAesvy83XOfKZ4XiJ7p1qIGJG5GvgafiPdpRKE9YCemUzmJYPjKuurY2ucNCiBpik8
	Jprgrm3pg4I/Hv6kJRjQ1y1HscinG1CEmi7TM5YV4zuI38yuUYU1Db+qUG6w9WIOjyZQu6d+0wW
	G/Mb+l1qKstdlr6ArJG9rTo7cWXP/3kCUI0xaEg3Dx6aeBfITI92i+FbYYhyi2kBNr54WGi438A
	uzby2fZg922x0C803RdyA8JAdUJkiU+ik6qDb+fVKyoXXf3z6z+L039m/cKjPM9+hm9LcWiWcLr
	o6S8Y87zXLetc+FjNCC2Lk62XKlhk4ntUo4CtA18VB1yDqByuy8vyYY28hV5pDjseWMuYATcylv
	J5a+/4W/Za4ek+tRQJoY6PkkNmrOb/iqChWOkNivBCYvqng0Llkb2C7wmT6wZt5kgOaMtEOIfIa
	iLp4fSHdqQ==
X-Received: by 2002:a17:903:1103:b0:2dd:c100:4b77 with SMTP id d9443c01a7336-2df7dc5a6b3mr10889045ad.46.1790224052075;
        Wed, 23 Sep 2026 21:27:32 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a4997sm19710685ad.27.2026.09.23.21.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:27:31 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Chen Ridong <chenridong@huawei.com>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] cgroup/cpuset: return PERR_NOCPUS in remote_partition_enable() on subpartitions_cpus conflict
Date: Thu, 24 Sep 2026 04:27:27 +0000
Message-ID: <20260924042729.1908863-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924042729.1908863-1-benquike@gmail.com>
References: <20260924042729.1908863-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a remote partition is created underneath an existing local partition
via a non-partition (PRS_MEMBER) intermediate cgroup, update_prstate() sees
parent->partition_root_state == PRS_MEMBER and calls
remote_partition_enable().

Commit 86888c7bd117 ("cgroup/cpuset: Add warnings to catch inconsistency
in exclusive CPUs") replaced the cpumask_intersects(tmp->new_cpus,
subpartitions_cpus) error check in remote_partition_enable() with
WARN_ON_ONCE(). As a result, remote_partition_enable() emits a warning
and proceeds to enable the remote partition on CPUs that are already
owned by the ancestor local partition in subpartitions_cpus.

This can be reproduced on Linux 7.3.0-rc3 with:

  mkdir -p /tmp/cg1
  mount -t cgroup2 none /tmp/cg1
  echo "+cpuset" > /tmp/cg1/cgroup.subtree_control

  mkdir /tmp/cg1/A
  echo 1 > /tmp/cg1/A/cpuset.cpus
  echo 1 > /tmp/cg1/A/cpuset.cpus.exclusive
  echo root > /tmp/cg1/A/cpuset.cpus.partition
  echo "+cpuset" > /tmp/cg1/A/cgroup.subtree_control

  mkdir /tmp/cg1/A/B
  echo 1 > /tmp/cg1/A/B/cpuset.cpus
  echo 1 > /tmp/cg1/A/B/cpuset.cpus.exclusive
  echo "+cpuset" > /tmp/cg1/A/B/cgroup.subtree_control

  mkdir /tmp/cg1/A/B/D
  echo 1 > /tmp/cg1/A/B/D/cpuset.cpus
  echo 1 > /tmp/cg1/A/B/D/cpuset.cpus.exclusive
  echo root > /tmp/cg1/A/B/D/cpuset.cpus.partition

which triggers:

  WARNING: kernel/cgroup/cpuset.c:1594 at remote_partition_enable+0x1c1/0x300

and leaves both /tmp/cg1/A and /tmp/cg1/A/B/D as active root partitions
claiming exclusive CPU 1.

Fix this by returning PERR_NOCPUS when tmp->new_cpus intersects
subpartitions_cpus in remote_partition_enable(), matching the error code
used by remote_cpus_update() for the same subpartitions_cpus conflict, and
add a regression test case to
tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Tested in QEMU on Linux 7.3.0-rc3 using the reproducer above and
tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Fixes: 86888c7bd117 ("cgroup/cpuset: Add warnings to catch inconsistency in exclusive CPUs")
Suggested-by: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 kernel/cgroup/cpuset.c                            | 3 ++-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2538faac9aba..7381fa8502e7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1591,10 +1591,11 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 * above it or remote partition root underneath it is not allowed.
 	 */
 	compute_excpus(cs, tmp->new_cpus);
-	WARN_ON_ONCE(cpumask_intersects(tmp->new_cpus, subpartitions_cpus));
 	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
+	if (cpumask_intersects(tmp->new_cpus, subpartitions_cpus))
+		return PERR_NOCPUS;
 	if (((new_prs == PRS_ISOLATED) &&
 	     !isolated_cpus_can_update(tmp->new_cpus, NULL)) ||
 	    prstate_housekeeping_conflict(new_prs, tmp->new_cpus))
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 3f7e81709365..b732078bf319 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -298,6 +298,8 @@ TEST_MATRIX=(
 	" C0-4:X2-4 C1-4:X2-4:P2 C2-4:X4:P1 \
 				   .      .      .      X1      .    0 A1:0-1|A2:2-4|A3:2-4 \
 								       A1:P0|A2:P2|A3:P-1 2-4"
+	" CX1-3:P1 CX1-3  CX1-3    .      .      .      P1      .    0 A1:1-3|A2:1-3|A3:1-3 \
+								       A1:P1|A2:P0|A3:P-1"
 
 	# Remote partition offline tests
 	"   C0-3    C1-3  C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1|A2:1|A3:3 A1:P0|A3:P2 2-3"
-- 
2.49.0
