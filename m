Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630797;
	b=CMxZrLgMUuxvW03c70A1lpAa3+F0oN1fIda+TT+BjAVmcPVkejiLcHN4GbzIQ5keoHJz
	 pU4eBBgLfn3qTF8PLo/2HXW0bYiOBHWFvc/RhoDv34qlsz/lrSkhwWiFwgptbzRhc8m3z
	 AjhKjGe/ugmKq3Zb8+uOtNokluJ8YZh8dmlmnCDPMIzngisDXiirfOdytMF1IZl8k9zK6
	 jnJigMFi9QEKrgy0RUGUJzT/0Za3RoRBfhXnI0k87aETSDjT+5b73d3CvxY+tov247czc
	 qaG8IdsK8nebB9qwe5Ai0u3bX/JcWgcEcHpW9OckCl2YHrdXFwybLS+TUt4fFlxRw9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630797;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nxdFwnzJ2ILCyC6+9MxA+NGU4Ptz9IG819jn1r5qFOg=;
	b=ibQZU3VD7wzWA3vRewQhjSsMCO/zGeO3i4Dx9N2vbseMouKo2mPBRGzgmZKO1nrBtzzy
	 Uyv8zLrPFHSAXLt2lwWUR0s6FgM0+OI57HwsifqSc1TPE9IcXF8bM3MVRe3HIqr9vFPDt
	 pY05T9W+RUgDTFFB65YShMmipT70Rz/Tm/I7fs0+OS+A8Pr89NjjSPI81/iSwkhfYmMqh
	 4FLEpO/QmmaCF/Ltt8QYMej7Yuxels0sxtt+YDECDU12oxCYUTd3TNADWlNq3GMEapXCt
	 pd8TxESCi8Aou5Ih2Acwq+4Q2i5RgqyMsxetWXd23uT5fI0Y43f5DcW6cdBQyUU55cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXj3RDV8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB86070D8E;
	Mon,  2 Nov 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXj3RDV8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2F51F00A16;
	Mon,  2 Nov 2026 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630796;
	bh=nxdFwnzJ2ILCyC6+9MxA+NGU4Ptz9IG819jn1r5qFOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MXj3RDV81dKUrDy0quCLVlKxNcw//TUhE3A/qQuHALE5D3lK87wijaCmLzlKvZotw
	 gwP4tPkl40dLdllRhvDfmwVkKLIcm+mbGXHry37PS0045N5i7TUAXL3XUOS3PKZllY
	 V4UBulTRfGU9FwjHk8elo62wgWxbWtsxDtRnvEKVOQ1AkeeNGyqYM3V14MRiPUbm7/
	 vmHfK/LjaAYxvbQV/pbbcQM7AEy+Y2QqyhKdJK9jAzR3RR3Xceh09PFAOR1GaWKOIU
	 jxeNqSp4ghTFEyR6KgwX3dn+evqDC3eN7iZpIkwxm8mx/flTmwFTHIRa5j42KfLJH0
	 gbv6tdlElgm8g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH mm-hotfixes-unstable 3/3] selftests/damon/sysfs_memcg_path_leak: define ksft_skip
Date: Mon,  2 Nov 2026 06:46:26 -0800
Message-ID: <20261102144627.88843-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102144627.88843-1-sj@kernel.org>
References: <20261102144627.88843-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_memcg_path_leak test uses $ksft_skip without defining it.  As a
result, the test is marked as passed while it was skipped, like below.

    $ ./sysfs_memcg_path_leak.sh
    Run as root
    $ echo $?
    0

Users who run the test could therefore wrongly believe the test was run
and passed while it was skipped.

Define the value at the beginning of the test.  After this patch, the
exit code reflects the skip.

    $ ./sysfs_memcg_path_leak.sh
    Run as root
    $ echo $?
    4

Fixes: dfa3cf0bc018 ("selftets/damon: add a test for memcg_path leak")
Cc: <stable@vger.kernel.org> # 6.17.x
Closes: https://sashiko.dev/#/bug/linux-a0456336-0608-4fec-ac22-0ee61d1d6a91
Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC
- RFC: https://lore.kernel.org/20261030044643.157105-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.

 tools/testing/selftests/damon/sysfs_memcg_path_leak.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
index 34c37129c49fe..d407dddb879ec 100755
--- a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
+++ b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 if [ $EUID -ne 0 ]
 then
 	echo "Run as root"
-- 
2.47.3
