Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF5470136
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928095; cv=none; b=s8jzfbry5hqyr5ag9Jzv4pKeigEWQy75tSyyunQ9LauhDchgLFVpRle/2FOJIVeqcqzOHtX0c7hWdBELCy11r5G8Odz3tPQA8fXmmSkiJHR4rbzvC7mgjCxdmUMbsY8nqaBjogcx4Kc8MHz0c4FRn/J4F4ayaOAUi38mxccCNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928095; c=relaxed/simple;
	bh=ljrqpukr3NP5yrDjkb+Jpb6Ys4RNZtVj2TiTWC404Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRXeynKQ0COragSR1BriID8U3qxmpQHo/qhOPXUAWiN2BxVdaAmaReJRVnZ/lKWe90kxQK9Cnm/tKrVZ0gssQDhkLWZ0SHCIuJqlFTeWy+hNOTHnE4/YgwcNuIeoAitTv2eWqKTP+YF5RQ1CPagFxBOZPwxoME/xX+/vflESNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0tG/0/1; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0tG/0/1"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db22383fe8so14039835ad.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789928093; x=1790532893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIGxyqhgDCJxQrUSlOVUsvnBCPzikecf8ZgHQx68EUQ=;
        b=s0tG/0/10XJx/mcuXgliPlt13qzin7Ife58BuWPaA8GnB7oHnfF2uQ0khztArpRVGN
         m/pvCDSQs2O3UygsCyyPCucGMYS6o6laGb/UmOyfNiuTHaFkriExNuCYT3bIm0PUyrO5
         CANDNEAzWsUaXAlceZn31C/hnzvGUF5cdrImyQXU8bQN9LsdHQGNI8arPKnfuD6sLmZw
         cJyRg8eEoPICrdsD1d9/R0mX7PhaFDXqupWQ5lBHoorOvj0GOrdGebydMvmqJdrKOA50
         M+mealyN4BAZYqkv6vKMrsHZJk7Fn8U6bxF//Ai+goL8YVSCO+KhyJGw/dt3KwGZPc8w
         5iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789928093; x=1790532893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIGxyqhgDCJxQrUSlOVUsvnBCPzikecf8ZgHQx68EUQ=;
        b=VaDMa1ecEFT5NmZKMZ1k5z1lrWR3I4R61bSTqHoYft93F8o7tDQub8ThehD9l0DrVv
         o5UU6oypc0lM6RNOqnZMdSbq7j37IV6J6alr8KJlu9ixyuhcLEBD8nDzBT1TCaYZpaFX
         6JvVh1V7FCCQ6jPJuyf7aZxzdXC5MsUBIbHZgWlbDBzWUhX617GAZ2TsP1bW+8IxyXGZ
         NWTChcDHcM2IqVTd/t4RYRgHl6rWLogJwIn3tuK07wKNSemx8rqQn5569yxRqqU9EcKv
         DttmLOHNJkIU9Uy3S+6J4nAtSDAWpC5ylKE72Lqga7DIxAGO8LfjMmmJwb5EsvAo8UQT
         Pg7w==
X-Forwarded-Encrypted: i=1; AKwUvBzu48RjvBVwze+N0i3CLE1y9GFj8nrhyZyvTgoc4kYYLSYsRBRe/pQhQ/a360MzzXLL1Pr2b4o=@vger.kernel.org
X-Gm-Message-State: AFuF++nJu64p+nkRseL8NNc3DoGgCCdcfQpzP1Cz50QV+UuA2zV0Z8As
	WzQ/f/0GaW5U9cwQS11MV/ESfNVQceMIR6eXOjuPLOFZMTMYPDXTJK1w
X-Gm-Gg: AYBFou35eChtsTxMDov/vUz3Y3clAvXCbNPOy8AIcFcnVmYS+qtfXjzAkAvXt10H2vm
	Ph0+2E3kLFf9zplYjZe/m8aA3Yx1hLb84NXbZPPMkFE+DW2EGguHfNmfYuu5MDYhaT+LzTWcmDa
	yCKzfys0Ax9z/vHcCQrapIDDRkGfd37e4kQ5Y7dG3a7YP2Z0cDec2SKmjffNPohpwCpy0fZRpjD
	noeGhsd9KYrlvaZimR+QsB6h9nRgWlGwqd5rn+HZnHLeS25ICp5sKSxNnsuB9tnJ8+Wo1L2iycI
	kYgG3Vkl6n+idur0HnLBpkO/ce5n/esVetRCxlGU0+BmvuKtTchYP8tt/3zzFdDOuc/OtmcaKxJ
	Ptr9/yabasrZcXL0ksB6bRprCihIRHms48/Z8DO0+/HUik0P33t0g6WlzGUhQX9DQ4Dp1//2llz
	mBmwzbpgAbt5LWK/nh00vVeRnDimsXx1mJQzpQYLpsTS5U3qReRJlEOOMB/QYoStKvvFBowRF4+
	XQsPflsiVSrletClJiWAKoD/U5hSWsE/ZLNasOsqXS4o499+Atfc0/7D0+sLP6Q0jN6nI+6N+qT
	rIYBhwRU5g==
X-Received: by 2002:a17:903:1a26:b0:2dd:89b1:7fdb with SMTP id d9443c01a7336-2ddb1aeea09mr127586005ad.9.1789928092709;
        Sun, 20 Sep 2026 11:14:52 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179df35sm22087225ad.40.2026.09.20.11.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:14:52 -0700 (PDT)
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
Subject: [PATCH v3 3/3] cgroup/cpuset: check sibling effective_xcpus in cpus_excl_conflict()
Date: Sun, 20 Sep 2026 18:14:49 +0000
Message-ID: <20260920181449.3122336-3-benquike@gmail.com>
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

In cpus_excl_conflict(), when a valid local partition A1 uses implicit
exclusive CPUs (cpuset.cpus set without cpuset.cpus.exclusive, so
sibling->exclusive_cpus is empty while sibling->effective_xcpus is
populated), a sibling cgroup B1 can still set cpuset.cpus.exclusive on
the same CPUs because cpus_excl_conflict() only checks
sibling->exclusive_cpus.

Fall back to sibling->effective_xcpus in cpus_excl_conflict() when
sibling->exclusive_cpus is empty, and add a regression test case to
tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Tested in QEMU on Linux 7.3.0-rc3 using
tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Fixes: 2a3602030d80 ("cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Split out from the validate_partition() fix into patch 3/3 and add the
  Fixes tag for commit 2a3602030d80, as pointed out by Guopeng Zhang.

 kernel/cgroup/cpuset.c                        | 5 ++++-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7c5b4a8f1f3a..f46a51f07938 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -713,7 +713,10 @@ static inline bool cpus_excl_conflict(struct cpuset *trial, struct cpuset *sibli
 		return true;
 
 	/* Exclusive_cpus cannot intersect */
-	return cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus);
+	return cpumask_intersects(trial->exclusive_cpus,
+				  cpumask_empty(sibling->exclusive_cpus)
+				  ? sibling->effective_xcpus
+				  : sibling->exclusive_cpus);
 }
 
 static inline bool mems_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index f4d1822d4e21..f62155cf6162 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -445,6 +445,7 @@ TEST_MATRIX=(
 
 	# Changes to cpuset.cpus.exclusive that violate exclusivity rule is rejected
 	"   C0-3     .      .    C4-5   X0-3     .      .     X3-5   1 A1:0-3|B1:4-5"
+	"  C0-3:P1   .      .    C4-5     .      .      .     X3-5   1 A1:0-3|B1:4-5 A1:P1|B1:P0"
 
 	# cpuset.cpus.exclusive cannot be set to a superset of sibling's cpuset.cpus
 	"   C0-3     .      .    C4-5   X3-5     .      .      .     1 A1:0-3|B1:4-5"
-- 
2.49.0
