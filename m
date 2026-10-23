Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.193.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789389;
	b=OnFrl8RUTt2B6BXKFkHbm7Ifpb3ggIHV09tBp1XIgwO/G3BN1QoaKmYTv5Fcmu3+E8Jj
	 vUsYhfsUUDOMx3onkgQwKFAuVKwU/gHfz9mK8tNXh2+rKJSr3kJorlh2vbrOwtkaXAUOe
	 Ead+vyKjL/zy7LE6SaCWCqo7MwgVSjl9a6juxHNeOTQAGAVUeSrNLJazZFYZma3StQqe/
	 GO8jOpnKF3h8aVWLm2F3poDCKjeYRIgNx5aMi/VMzGgcNqw7N97a9r8SZFM5tYhzLE9b7
	 kzjS5LEH4R87bG51uaWE+HSM05ak1asb/apAgA91Qot6+DgDrVpEhyI6pV2+M1V7ZUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789389;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=bwxaO9Hd9Usj2A2YXEjAtK+3AZbfX5QVOzXiNMsq08s=;
	b=iAvzZdceM/14d/JxGeHkTWo3Gex31M1LSe3OFyxMWHKvBlfR2uVtDIEI9TuvzjyerfSn
	 bajdMS3l/Wv2T8Npi1CWtx1wgGiP2NivTMxoXB0aR0CRy/A9I6M1iBdUbTPb8zuK+l5/g
	 JWNP+4Vj1Xt5dzzvgmtoPV4AFMIZkpx9tmQZBBuOBJ29BrPZKW5T48GFrBAy9GzfBa7ey
	 W1dqCKO8IhuqVEgIrOdSWxMzk4Gr5QpQDMWu7LBhzgDemxr3oY/NBwMnpuAFohLFD669N
	 MFc41UNCK/8HYNCnjyTSf2DfKLV7tG4hpk45mjZNuyqVZTfYfdqYQkre542kslNvaBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auroraos.dev;
	spf=pass smtp.mailfrom=auroraos.dev;
	arc=none smtp.remote-ip=95.181.193.9
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F655606A31A;
	Fri, 23 Oct 2026 21:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F655606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from pc.tailf8c421.ts.net (77.37.240.142) by
 exch16.corp.auroraos.dev (10.189.209.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sat, 24 Oct 2026 00:02:55 +0300
From: Georgiy Osokin <g.osokin@auroraos.dev>
To: Jens Wiklander <jenswi@kernel.org>
CC: Sumit Garg <sumit.garg@kernel.org>, <op-tee@lists.trustedfirmware.org>,
	<linux-kernel@vger.kernel.org>, Georgiy Osokin <g.osokin@auroraos.dev>,
	<stable@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] tee: shm: don't warn on an oversized page array in register_shm_helper()
Date: Sat, 24 Oct 2026 00:02:38 +0300
Message-ID: <20261023210238.551855-1-g.osokin@auroraos.dev>
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

register_shm_helper() sizes shm->pages from the length passed to
TEE_IOC_SHM_REGISTER and allocates it with kzalloc_objs(). A length above
2 GiB makes the array larger than the page allocator can serve in one
block (MAX_PAGE_ORDER), so it trips its order warning; on a panic_on_warn
kernel that is a panic.

The size comes from userspace and the request fails with -ENOMEM anyway,
so pass __GFP_NOWARN. kvzalloc_objs() would not help since kvmalloc
warns above INT_MAX as well.

Fixes: 033ddf12bcf5 ("tee: add register user memory")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
 drivers/tee/tee_shm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 6742b35..d539988 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -438,7 +438,8 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 		goto err_free_shm;
 	}
 
-	shm->pages = kzalloc_objs(*shm->pages, num_pages);
+	shm->pages = kzalloc_objs(*shm->pages, num_pages,
+				  GFP_KERNEL | __GFP_NOWARN);
 	if (!shm->pages) {
 		ret = ERR_PTR(-ENOMEM);
 		goto err_free_shm;

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.54.0

