Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630796;
	b=uto+9flxdLCLFJzHsmPrtYeYYdomjVMXqJYYSxwx7h2X504Q1GZQh8MOPjUo8oSi/O//
	 pXt7qrb7fAuYherkoaQhhXvgZZetsW0vb3uFKKbpkau4FcipPrKNr67daybmS+Avn0rx0
	 NqkOsa7MGBcleFP1imevHTN/wlQ7ZOwjCWVmj1gPrNnwWhPFsZ8s7GIhfNVgKleu4o9we
	 oiGgovryjclmIHYNKOFidzF5meSjzWIUZI7KRg7NSgCV1tmO3Hj8zwVPC5cIGf4/YwcaW
	 pyN152r9fX+g8owo9vDkDZg+HZqNUwZmX77NZ3aap8hzkP86I47c6/bV49Z+8bM+naA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CF7ShlzIhzwBW+s3yeojdJySM8gPCUgFHqUvtGr8dsI=;
	b=FiR9OXSNZdqtOs6IcL/LMYUn2l7/91DrRM/Sd0EdX0RPjMXxGqbG4VXLQyWWFShWef7g
	 p/vTPskXbgwi5IabO38RmROP2UfiTuNXpMeLT/5Dxgf5SAerC4BZO22ZIxinOM+BJWc1K
	 4qMFd5d0sjEW2o2kX8DwUlR8UpMLJvelnfSIkjSAGQtLh6eXSuiY24IpXdkS7KuFmFSyY
	 aWtY4Jn3q1/wjoflVvMrMv58w71Bix2CUdxRT+B/6QhPyh6m3wPVuX9MAQfmh3VkcCdiE
	 uw7XY8sc6yZAcSF94ndTSa+xeQuIvVi+mJjB8VyGc6+d+yG/IQ85fGaZUy7tWzfWCww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqJySAjz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCA6070C8F;
	Mon,  2 Nov 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqJySAjz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1361F00A17;
	Mon,  2 Nov 2026 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630796;
	bh=CF7ShlzIhzwBW+s3yeojdJySM8gPCUgFHqUvtGr8dsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TqJySAjzHxs1XsxoE6HX68+Lx9kxA0VsODxNDkN2aNx1ie4S+lOd/IUDbpnsK3xcJ
	 BuZEeEKcNnFOBhAO/zxqRTc0Q5PyIGNVV2bdypcqOq4Ff68Dr4tvz6MfmRNvlR2s3u
	 JTZQsnzeiLG6nWB1YqcjozpXGkG6f3FUkT+YqwfZ7pf3SaAxPOUYIkdJNzKDus9vD+
	 XEzTQ+oe3vQI217NaRmyTT9O9eFjA0IMO+EwS70ITn4fVk6szbaVdNDXfVxiP190yL
	 cYgwVNApXVOov1zQwkQvlYCneKUEh4r1eB6RloWpF4/aEkO3/yN7dGOvumW3npSz6k
	 oICrkeRJi708A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SJ Park <sj@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-hotfixes-unstable 2/3] mm/damon/tests/sysfs-kunit: fix leaked pid reference in add_targets test
Date: Mon,  2 Nov 2026 06:46:25 -0800
Message-ID: <20261102144627.88843-3-sj@kernel.org>
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

From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>

damon_sysfs_test_add_targets() creates its monitoring context with
damon_new_ctx(), which leaves ctx->ops zero-initialized.  Since
DAMON_OPS_VADDR is zero, damon_target_has_pid() returns true for the
context, and damon_sysfs_add_targets() therefore calls
damon_set_target_pid() for each target it adds.  That function grabs a
reference to the target's struct pid via find_get_pid().

The test then tears the context down with damon_destroy_ctx(), which
releases such a reference from ctx->ops.cleanup_target().  For the vaddr
operations set that callback is damon_va_cleanup_target(), and it is the
only place where the reference is put.  The test never selects an
operations set, though, so cleanup_target is NULL and both references --
one for each of the two damon_sysfs_add_targets() calls -- are leaked on
every run of the test.  Running the test with CONFIG_DEBUG_KMEMLEAK
enabled reports the leaked struct pid objects as unreferenced.

Fix this by selecting the vaddr operations set for the context before
adding the targets, mirroring what the sysfs interface does.
damon_select_ops() fails if the vaddr operations set is not registered,
in which case the test cannot exercise the pid handling and skips
itself.

Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
Cc: <stable@vger.kernel.org> # 6.7.x
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Signed-off-by: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261029075609.35661-1-xiaoleiwangxiaolei@gmail.com
- Add Cc: stable@.
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 mm/damon/tests/sysfs-kunit.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index 138a4b8d14e73..16373ba751dbc 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -79,6 +79,15 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 		kunit_skip(test, "ctx alloc fail");
 	}
 
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
+		damon_destroy_ctx(ctx);
+		kfree(sysfs_targets->targets_arr);
+		kfree(sysfs_targets);
+		kfree(sysfs_target->regions);
+		kfree(sysfs_target);
+		kunit_skip(test, "vaddr ops not registered");
+	}
+
 	damon_sysfs_add_targets(ctx, sysfs_targets);
 	KUNIT_EXPECT_EQ(test, 1u, nr_damon_targets(ctx));
 
-- 
2.47.3
