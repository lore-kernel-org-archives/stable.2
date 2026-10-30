Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793335612;
	b=0vlWcaw+ybRUhwwtluYF4ok1r7GhhERK7LTaoBlYqC+GBM+F652rpVshX3L/mICLF7ki
	 9N5aML9nn2FUWhkn3VGjBkRKjuE1+pwNdN/Wnw/zr/+O67AnoOZNmiC4cz/6aRKSYVEw5
	 SqJYzy9ATIh5pAqzWzSQ/uSpC4pgAw4I80GWkPEJwk/AJdcMdXPjNC9WgANrdIntDurdg
	 WFMv+dne+LJ1nTOI0IyO6gW14qvHL914ytu+W3IRX9uVBuaLjRGORVvmWlO6avE7qRC1W
	 anVfA2pW1nxMf38R3EXNDAjATpum1USblv6yuj9ngVM2w4vh6cRODZsb7clF4fCrcOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793335612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DZp5otDluq4NV2cKmLa7Nu+U3zJLkg4HxbRo5oi+i0M=;
	b=5Blh0pUyckYWX15sXTqNxyleeR9uKlBF6bExx1xwl12hoIIJcQE7qsg+B9a/hcIRfCtA
	 ebVtH5vAhqeyKdJK5DO0SqgTVgkCmE+4otsZLKqabNiAAmH+YO19xeRJ+IAcM1UrcyB+Z
	 ev3ndGthN9lZS8W0/gNqxQwQicFMYgX3/+fFnUxSBZSGHjTfLzlLkbEAaH7KhL3AHe7Kt
	 1ZAusxfvzYraLwMNfYTbZfmsF7sSMlAcRgKluHCPq7ZKdM9f3/1GwRpqxRzW7ArRGpiTL
	 B3i5V/Ur81Pxl5cc9Ra4oQ/2f7OCMBfvUo9MZhOtsoCqTxw44b8PrdQJXQi0BE6dIEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZiFfe4M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4D606A31A;
	Fri, 30 Oct 2026 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZiFfe4M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4731F000C1;
	Fri, 30 Oct 2026 04:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793335611;
	bh=DZp5otDluq4NV2cKmLa7Nu+U3zJLkg4HxbRo5oi+i0M=;
	h=From:To:Cc:Subject:Date;
	b=MZiFfe4MaqqgRmB0M8Sok3Bxfg3CbjxRydYTFp7y5XUzPe6DLkiZJUwTknZefJSPr
	 saZ96LltFBZ124M/oaiB6gcCOLBs4HUO8MYUPaTLrIB3kko2dfCuC0gjv/BITeMs5A
	 YuKUu69lrKKDpVxInh/TNuYHDscjoLNibIOKlLJU/pK5o7IZu816Jv4IUGx77+a3lT
	 YMG+qNzOlzINkS7X3PdbZntrmEkkObPHfsWatqZd8MSd+BNcQhokZBWcWIReTo0RSL
	 RtSh0qwJfgt89xutqRh6vxGG86kdvQDqg7CaQZ4AUT97K+EIM7K+1YGlzEkQPymJ/W
	 4E8AZY78E4LZQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] selftests/damon/sysfs_memcg_path_leak: define ksft_skip
Date: Thu, 29 Oct 2026 21:46:42 -0700
Message-ID: <20261030044643.157105-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
Signed-off-by: SJ Park <sj@kernel.org>
---
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

base-commit: 20b1ca206f8a664a16ad3006262c63b5d37b1ecc
-- 
2.47.3
