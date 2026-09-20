Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DCB446821
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928094; cv=none; b=XEh0WluhIwrsr5Qp80owJKiweq2S8tYBGKzaozaPq3mbX0riijp9gvfmz8KarVe+JHjSOCXc2oWSvgE1KXd+hZliRlXL40NUsXzw8154AW318KawwsXWBwIFdCY6yk8syKn9YjWaOAJ7wcKitPl2HxZHlMN+5qqVl9/kXhJpREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928094; c=relaxed/simple;
	bh=cV3/KTdgJHV1yXvxTsmHu1ui5225YBj21HYBCq0OBVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tb8sIX+oKyyizM55yqE8J9LeCHrEXg427C4XuVcpQr8ORHUOxoNND6WgKAJEn+7g5nIzXHfjNLiC0pRlmqYXmRHOZRKMb5O18hVbIw2n7CD7KzXWnhIb0ImIPkmBmHBVzGTJI2UlcJvGax0wJ/D1W84B8g4MDm+CbLotzNwu8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qA3grITs; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qA3grITs"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so20131785ad.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789928092; x=1790532892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvxOZBxhI8J+dHNpoi6XW2nKZBQAfr8LrdiH5o/MebE=;
        b=qA3grITsiqTK4qYFNqq7ra2/fPurIlercO8bH2WSUPd1ajvMKKKqmZo1KOZpEE7+dF
         qBr+XyyorNIXC/lbOGhoAizjg8JUlEEPslmvTVSMvNw05jAaNqcN8+LpLSVNLz0P94Nb
         oWSNvcRiY5X6VuocPR4dcJUIBNkrgBP55YXkVYtSfLZ8xNA+E4r8s34Jnv0lnlofMy5d
         rhilUTLXGOAcmzrlxX3FM3ZnzDFDjtFAxBblcFl8tsLYhSnkSWljPrV6wNOEFNM1fx+r
         C4x7Uh3wx7cyxtQekSfkc4cOB1RFFkiiwTr8syLiCEuVRTsPizNSUsed7BsKF8LEGMUX
         /Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789928092; x=1790532892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fvxOZBxhI8J+dHNpoi6XW2nKZBQAfr8LrdiH5o/MebE=;
        b=lEiu3/LSyr5O+0q2L4tteMYpcX5aTVoD9iRqmzlsTdd9Nc2XRt7gavnJHPEdr5I3cc
         xtQfJbkT+z1SNhB6eiC5EnDwHKjy40n7ls7BkU4314J5DwqQrjUlUAOqTghczZYl6odO
         3LZR9KDkQFvvRqGK0c/vLqrrgKFtipfLOryN12fTjgzJpy+jSz8UUyiwFgsXPeepaQrI
         ai39LmBPeiMG9FSRmE0zKz0wfBhv2aGbP/V5vojBT2eApFx4sKOsuBpT4ZIC0+uv/0Zr
         3xi93zc9AmyEdO+lVMuMI1OAyrlV0RvwIMbDs+WyJU00+LBFya8qooc8GcRztws29JSI
         L1Fg==
X-Forwarded-Encrypted: i=1; AKwUvBxlHuVKf7fO11GCMK2ZIVuN+UiJcWd42+AgpClRvDet0T1kT9VDsUfvBlfT09qXH1oJ92m1xU8=@vger.kernel.org
X-Gm-Message-State: AFuF++kBb/7dVjCr9VgiOunccDNCOPDlQp+UMmu8R9MDYBFPOguUQmVU
	mICbtTB/dgHwiziwac0QO/Hq+i5rMIXCUyNkFACUNg930H6ffd5hLWgr
X-Gm-Gg: AYBFou1pDt6pkIwTYVMwQqNrqGKFfle+7EV/qzvFs5x6jIrRPQ9cacnCJjkEhUOQdHW
	FDA7cAdXcyinBFjnDu4IdbAke6QKH1Db/YHiDhBd5zhGGuPVKEYe1ixO98lFZLkfPLcJ5Kx8I+h
	qBE1CwPswVnQzUch8iFlMPXEkqnQjTaBp3Vt+sBOUKJ2SbI4dTpojXKvSxncGGzw3qRG1+Ec8MI
	rRhnv1ynclIdj5KSLPdKRhNOzB9ziJ8fBv6wGHOus9tSsJjXAMt/acs9t7eoebjpdxw6ubSCynh
	QLmIe/QHr3wiaL39DXrbFrGQ08LtEPG6jTYdNERgx13K20n0MwrqNRtzGtGGPm6FJY58+AtliVT
	P2DeuLIZb9wAqGbLMjwVsRmnl+E/dZlJDlzy7j5oh7BEtqXVWT0mvEruB1Xw86cVh67dGLRH7C4
	nzQZrqY06HTHMzy4Yj3FGVBpeNKntgcmWq50iecc/h/OryYyqCfaUev72ozsSIa3dl3JqJvCsjZ
	ezpBmrJu66np3fUe5tUjKFstGvlhwKE3t2fNgHPSzukYBRasdiBl5aQIqiuUw3DGf5+DQhEr04O
	RgoAfUPddUc=
X-Received: by 2002:a17:903:2349:b0:2dd:c100:b2c6 with SMTP id d9443c01a7336-2ddc100b360mr74276095ad.49.1789928091952;
        Sun, 20 Sep 2026 11:14:51 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179df35sm22087225ad.40.2026.09.20.11.14.51
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
Subject: [PATCH v3 2/3] cgroup/cpuset: prevent activating local partition over remote one
Date: Sun, 20 Sep 2026 18:14:48 +0000
Message-ID: <20260920181449.3122336-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920181449.3122336-1-benquike@gmail.com>
References: <aa90bb73-c2af-4d13-8f2a-0435aa528058@linux.dev>
 <20260920181449.3122336-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6da580ec656a ("cgroup/cpuset: Don't allow creation of local
partition over a remote one") added a check in update_prstate() to reject
creating a top-level local partition whose cs->exclusive_cpus intersects
subpartitions_cpus.

However, if a top-level cgroup A1 is first set to "root" with all CPUs
(CX0-7:P1, becoming "root invalid" because no CPUs would remain in
top_cpuset), has a child A1/A2 enabled as a remote partition on a subset
of those exclusive CPUs (CX2-3:P2), and A1 is then updated to a valid CPU
subset (CX1-3), update_exclusive_cpumask() / update_cpumask() calls
validate_partition() without going through update_prstate(). Because
validate_partition() does not check trialcs->exclusive_cpus against
subpartitions_cpus, A1 transitions from "root invalid" to a valid local
partition over the existing remote partition A1/A2 and triggers:

  WARNING: kernel/cgroup/cpuset.c:1943 at update_parent_effective_cpumask+0x189b/0x1fd0

Check trialcs->exclusive_cpus against subpartitions_cpus in
validate_partition() when !is_partition_valid(cs), and add a regression
test case to tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Tested in QEMU on Linux 7.3.0-rc3 using
tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Fixes: 6da580ec656a ("cgroup/cpuset: Don't allow creation of local partition over a remote one")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Split the validate_partition() fix (Fixes: 6da580ec656a) and the
  cpus_excl_conflict() fix (Fixes: 2a3602030d80) into separate patches.

 kernel/cgroup/cpuset.c                        | 4 ++++
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7381fa8502e7..7c5b4a8f1f3a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2415,6 +2415,10 @@ static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *tri
 	if (cpumask_empty(trialcs->effective_xcpus))
 		return PERR_INVCPUS;
 
+	if ((parent == &top_cpuset) && !is_partition_valid(cs) &&
+	    cpumask_intersects(trialcs->exclusive_cpus, subpartitions_cpus))
+		return PERR_REMOTE;
+
 	if (prstate_housekeeping_conflict(trialcs->partition_root_state,
 					  trialcs->effective_xcpus))
 		return PERR_HKEEPING;
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index b732078bf319..f4d1822d4e21 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -321,6 +321,8 @@ TEST_MATRIX=(
 	" C1-3:P2  X4:P2    .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
 	" C0-3:P2    .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0"
 	" C0-3:P2    .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
+	" CX0-7:P1 CX2-3:P2 .      .    CX1-3    .      .      .     0 A1:1|A2:2-3|XA2:2-3 \
+								       A1:P-1|A2:P2 2-3"
 
 	# Local partition invalidation tests
 	" C0-3:X1-3:P2 C1-3:X2-3:P2 C2-3:X3:P2 \
-- 
2.49.0
