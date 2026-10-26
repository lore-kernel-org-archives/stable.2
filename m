Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.193.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011972;
	b=iZBpkP3j9PCEAnlXUdMRV5qKgMl35zjRRBmuBnlNPEJazsv5o4qGZ8KI0+7+8ym4ezcs
	 ViKjjtw/FRcmZhwQgNs69ZPqvbW3g6zBk3yoCSlWHoUIaWIX2/mBOKKqbbUuitIjdqgBy
	 O8ZtllQRlkUyOz3a4uFxHoKXNG9qewjD3bidDWTy4UGHrHcz/9QVc6UuyheRAReGcC8np
	 r+bGnydQz8gqM6/s3NpPwQS5xk4nhTQn0qO/0LhDvAJ/N98+ZWn31I75mxJaYb48Nekz7
	 O0Zuozm6Kgu5oBfqfNSDbQDmjn6/qOY4W7UI1G0DEoGeV0sLC+b2py5pQn9ITczy0pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011972;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=kSMzToYsCAgqZi/ri2lG9WsSMD7as+L4qrs9dYsIbP8=;
	b=LSRtBE5h5GZPc+wjBy4UsVOVL2APrR6FccHnX/Vos8de+X1hgETBX3LG8LDrFYlFDekO
	 VQg4HXYLL9L8B1YFUvylvO+2Vl6OBgnSDAg3TWbR8J1h5wWHvysMpwj+/eZYjsJyY6omd
	 suNbAbzwQh7v97Zqo+q+fJEfg6WQ67TbNM8fJ7Y0XCf71glRZ2TpXyV969VV0cOJGn9m2
	 XUIY5mXVCr8T+Kh1Bkj1hg8se9xtpMjmjrUsj/OgBL7Qw79uCAHelO1z7DuL1tvrld9wO
	 4uzFEISXKy31h61lnJ/oAYWB9E6TPq5eGTAJaq9ilzgZH1fCipaDsLGs//l2CtpJ2mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auroraos.dev;
	spf=pass smtp.mailfrom=auroraos.dev;
	arc=none smtp.remote-ip=95.181.193.9
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D11606A31F;
	Mon, 26 Oct 2026 10:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D11606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from pc.tailf8c421.ts.net (77.37.240.142) by
 exch16.corp.auroraos.dev (10.189.209.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 26 Oct 2026 13:52:39 +0300
From: Georgiy Osokin <g.osokin@auroraos.dev>
To: Jens Wiklander <jenswi@kernel.org>
CC: Sumit Garg <sumit.garg@kernel.org>, <op-tee@lists.trustedfirmware.org>,
	<linux-kernel@vger.kernel.org>, Georgiy Osokin <g.osokin@auroraos.dev>,
	<stable@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] tee: shm: don't warn on oversized request in tee_dyn_shm_alloc_helper()
Date: Mon, 26 Oct 2026 13:52:09 +0300
Message-ID: <20261026105209.161195-1-g.osokin@auroraos.dev>
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

Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
---
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

