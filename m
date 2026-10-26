Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.193.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027058;
	b=ghTj1+yBNJiOS5mfKcuvSXEykvJ4/ZIGKeK4VxfKXDvlX5VyJxiis3r+8AWjtXQcqTx3
	 DUA3Xw6wq6Y5dGjFISzA/V2QODn2K1qXGXr6PqPnzxv2MOG5PKouoQ5q0EukvWCk3zte6
	 WecW4T9noX5qLRp7upm/IWbY3no6nUxvbmdcp+o72T1CJ9B0egM+ygQJGrVqM46MLLuW/
	 SiJ8u1Bg6GpDqEHz6ZFYh4eseFHUEhJsoxrOHh8z/s7MEcpJIT2cEOcbRI0yprIyha8/L
	 jwOZTxJVOxcI+AtHODgAfTr2bGgFdvDfUgSocSdaZr2b5ptCTnPZHOCZfjH1tLBwH4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027058;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=ptF7i1CEWzxGvgH4A1Lf6emCPEcMA8fjlZ8zFfi/vgo=;
	b=3AnAHFsNBhjuETQOCiJQsyU1yWt6FsG2MzfLF7jBthmifjBU4z92ZfZ9Va1lWLcw0aBI
	 xwcAGqVdBO+G4WUV7hnQc54pkHw8FrgZ5AJ+b/F6t5SodP2pJ1Va/uRKHnCkyaPeVX14p
	 oYEJzNlvNZ7ryGYBM/3H3vlnlpx2SeR0PgCPnHNZlajU8YJjnSjrdtZ3Ux87PUVCbEMOC
	 jAY58HCGZmS5rB4KRtD6c+Af9XS0c64smnd+V1cCs12bMoIGs/bn99nuy4M3hdTa8p5gC
	 y9LNobQJyZ4UWYv5dnW++wH753dqBzD6q6iZP8Y6+4RkVmmx1AU4QU6Ty2bNE7x9Wsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auroraos.dev;
	spf=pass smtp.mailfrom=auroraos.dev;
	arc=none smtp.remote-ip=95.181.193.9
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91D606A31B;
	Mon, 26 Oct 2026 15:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D91D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from pc.tailf8c421.ts.net (77.37.240.142) by
 exch16.corp.auroraos.dev (10.189.209.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 26 Oct 2026 18:04:10 +0300
From: Georgiy Osokin <g.osokin@auroraos.dev>
To: Jens Wiklander <jenswi@kernel.org>
CC: Sumit Garg <sumit.garg@kernel.org>, <op-tee@lists.trustedfirmware.org>,
	<linux-kernel@vger.kernel.org>, Georgiy Osokin <g.osokin@auroraos.dev>,
	<stable@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] tee: shm: don't warn on oversized request in tee_dyn_shm_alloc_helper()
Date: Mon, 26 Oct 2026 18:03:45 +0300
Message-ID: <20261026150345.284404-1-g.osokin@auroraos.dev>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

tee_dyn_shm_alloc_helper() passes the size from TEE_IOC_SHM_ALLOC to
alloc_pages_exact(), which needs one physically contiguous block. A size
above 4 MiB (MAX_PAGE_ORDER with 4 KiB pages) is more than the page
allocator can serve, so it trips its order warning; on a panic_on_warn
kernel that is a panic.

The size comes from userspace and the request fails with -ENOMEM anyway,
so pass __GFP_NOWARN.

Fixes: abd135ba215c ("tee: optee: add optee-specific shared pool implementation")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
v2: Fixes now points to abd135ba215c, the commit that introduced the
    unchecked allocation; cf4441503e20 only moved the code.
v1: https://lore.kernel.org/all/20261026105209.161195-1-g.osokin@auroraos.dev/

 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daa4af1..8b117d6 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -352,7 +352,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 	 * and there's no need for any larger alignment.
 	 */
 	shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
-				       GFP_KERNEL | __GFP_ZERO);
+				       GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);
 	if (!shm->kaddr)
 		return -ENOMEM;

-- 
2.54.0

