Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D34DEC21;
	Mon, 28 Sep 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605914; cv=none; b=g3AS8E4J9+WT7O0coXDt7GnxhrpUzOCYPKwTzTWiCmceg4/R/tg/V6J2wcwyEjKqAPYMEWk2PvbSp3DEHDc2P/uyEX3x8ZbvABIpitGTp4D/VlWpGLp5VTPaky/Xbqh9INzrYYx5gb/r5obTeFkewbjzwQgFZt5fcyKqbcvBNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605914; c=relaxed/simple;
	bh=G5nhJFHOphxhLy5VEu+x6x3ZtsxPZ4gB+naoUcQxVH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NoMJ0IvxekbfIVkxB64oduMKdTsvxC5Yyk3qOSYZlvrAe1/vAIF2FIQ+sdoynVzNksLTPE8CxqqyuQxfdrvSiX/4SEDRWlBkjMcaR1D3GYFdVdfFHvK/X0uBIzGkLU0Gn7l6teFM8w8F8U0TgK2Pq9hZfCjoEnd7kd8XSTENIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from pc.omp.ru (77.37.240.142) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 28 Sep
 2026 17:31:36 +0300
From: Georgiy Osokin <g.osokin@auroraos.dev>
To: Jens Wiklander <jenswi@kernel.org>
CC: Sumit Garg <sumit.garg@kernel.org>, <op-tee@lists.trustedfirmware.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] tee: shm: reject zero-sized allocations in tee_dyn_shm_alloc_helper()
Date: Mon, 28 Sep 2026 17:31:13 +0300
Message-ID: <20260928143113.1700001-1-g.osokin@auroraos.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

tee_dyn_shm_alloc_helper() derives nr_pages from a caller-supplied size
and passes it to alloc_pages_exact() without checking it. For size == 0
nr_pages is 0, and alloc_pages_exact(0) calls get_order(0), which is
documented as undefined and returns BITS_PER_LONG - PAGE_SHIFT. The page
allocator then trips its order > MAX_PAGE_ORDER warning and fails the
allocation; on a panic_on_warn kernel that ends the boot.

This can be triggered by TEE_IOC_SHM_ALLOC with struct
tee_ioctl_shm_alloc_data where size is 0.

Reject a zero page count, as register_shm_helper() already does for the
register path.

Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
 drivers/tee/tee_shm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 6742b3579..daa4af1e0 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -343,6 +343,10 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 	unsigned int i;
 	int rc = 0;
 
+	/* get_order(0) is undefined and exceeds MAX_PAGE_ORDER. */
+	if (!nr_pages)
+		return -EINVAL;
+
 	/*
 	 * Ignore alignment since this is already going to be page aligned
 	 * and there's no need for any larger alignment.

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.54.0

