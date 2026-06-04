Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1693B8D5C;
	Thu,  4 Jun 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556673; cv=none; b=AM+V37L4cdcEmaUQkgp4xtI8QWGaLmr1GFCS/KFmTN5Ly8fzdC+J1NgpTBsmE0RE6A24pZMy75oYgfaJINoyhiqPRsYY2sAjAsNRYDgm1WJwPnLSm28bMxiM8nMmHlk7fbjLYWRgJYSEYwzhLjJ3srzZz5dwjZAgNbUhe+tlfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556673; c=relaxed/simple;
	bh=yywu8ZxTRtIH1pOnd1WALrDXQCMv0OTT03m35HlcjAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P8rz1ZLSloKyKo41QzfR7O2mlWMU03v8pVU2dshb1D4sQZUupJ8HriC/WfLLch6MrZpynws4GevA2/2l0L7DBKZbLjNi1XfRnXzGihXRT1Qtq8grEGKU9AVitvsxesEIdgvtIs5vvr7iCOZSqEy4Aj9umR3d3W+6vC+5LlnGYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NNOsg0iJ; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NNOsg0iJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780556658;
	bh=P57iD2S9EPfRAP36gj0JdTbFwtXxilaoUSFYn5CFF2o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NNOsg0iJWo8zMQ06kcpPsnFGMsZw2Z+b2uN1+w9qHDateWfQY9qQqxeJ5rpkybcpX
	 qe2f+H0mTDTzyJGknNlcX/ZFKU9rs5CL8lsdW9ai0T7kN29CfImD5qZe+MiFYOB5eL
	 n6RSewXLjdhkIYFMFmG3RJUeEMd6XdrUbqlg14+8=
X-QQ-mid: zesmtpsz4t1780556654tb32bb824
X-QQ-Originating-IP: PPa2v+lkVt/vNsQ6iSmnuR6BrhfKhuX7ejWkLBDo3GQ=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jun 2026 15:03:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6328800719262846295
EX-QQ-RecipientCnt: 13
From: ZhaoJinming <zhaojinming@uniontech.com>
To: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH net] net: airoha: Add NULL check for of_reserved_mem_lookup() in airoha_qdma_init_hfwd_queues()
Date: Thu,  4 Jun 2026 15:03:52 +0800
Message-Id: <20260604070352.2603077-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N0mS+7D7RQfjnescUnQL6LLlhipBV6toT1YvXzbhTDKTucpfLuyjWHph
	CsZjaMgAT5Y7V1nIKAdtyBntQtyLlPdORxe3RYI8d71cNfSXjZxgBi0CyJ0KyB7aNNjIm6G
	JdRRgKuT3Ts6/Vbz0/tXHtTEmGtaGaui9Nb1yHz5ThdHf/jC47iEb5I9NQmKM8zAm0q3X6p
	6Jvn04qF+/7VFjlV6CmkexoJRw6K7li/Hes5BycD69RkLAfssbJ3czGvA204XwJRksU/Fip
	ok4h4F+tH9cWD4Gm9CJ55lzxMZt9dgxdHxZX9lLJ4gl5+utaYIeyD009mfozXz4+AHOSkoF
	pTY4cOw7PuZsRt1GVGWGX9szwVVL+9lGS/0aoioxCXgl0bQ/iDDW0YpXfUCl3P3ct8hUguI
	HDHwWKMTkkZB2piOJ/aEXldaEOdISHTLCP92t9NFs1ilVZJacq+XhzjqYB30aGwXOp3y/yr
	FNjIpKzUpWZhjyK5WD05C2sLnigdX+BOrixr8QTHkUvq/QAJGnxnW05lYVydffwhj/NgO5j
	9FnEZzamTSxhMZzm9FitFlMPnpGGiajXubw1lUjxrrdviu6jW07KpPR3P9nehbSE85Ex1Zl
	ar/Hgw8k+fEIZqZXPInIBjhLLomNNBLjGt0xdQ2z8xs7cWLyYH15P2eQsW8VspKjbNimepT
	B4wZ/MlN/dwknA8tpcMpCqhP9brKbCvjuj0Ey/f4efv0fxN9mG3jT0I4n7Y+aFXVaZ7GWpu
	Pr48Lram0lz0RvgVc7LP7PAbNjGAY0m9IJBHd3ywS4Rzmftk/c0pVm0C6cVpuSFRHM/dwyn
	/5MjYwp2fI8TBgryB+/QfCY3ue3IAWxBvKSaYKIyfCyJcbkmrYW6ouIuTaIXYz3QBPBqMXj
	700IsAYrN1yk+K2sDIMYDQhE38NB4gJ+G5hipL2OoHbpdWhebWrcMl4TK5H3eY/zECXQKEE
	DWDi6r26+TQTiKWPAENMQvo8E//6elCWSEJEnShkD4PIpG+8jHRy3FK9xfV4B8Wk8ZFwOnw
	ZwfjAQF292JNyaZPCS
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

of_reserved_mem_lookup() may return NULL if the reserved memory region
referenced by the "memory-region" phandle is not found in the reserved
memory table (e.g. due to a misconfigured DTS or a removed
memory-region node).  The current code dereferences the returned
pointer without checking for NULL, leading to a kernel NULL pointer
dereference at the following lines:

    dma_addr = rmem->base;                          // line 1156
    num_desc = div_u64(rmem->size, buf_size);       // line 1160

Add a NULL check after of_reserved_mem_lookup() and return -ENODEV if
the lookup fails, which is consistent with the existing error handling
for of_parse_phandle() failure in the same code block.

Fixes: 3a1ce9e3d01b ("net: airoha: Add the capability to allocate hwfd buffers via reserved-memory")
Cc: stable@vger.kernel.org
Signed-off-by: ZhaoJinming<zhaojinming@uniontech.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index cecd66251dba..2444d3275a81 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1153,6 +1153,9 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 
 		rmem = of_reserved_mem_lookup(np);
 		of_node_put(np);
+		if (!rmem)
+			return -ENODEV;
+
 		dma_addr = rmem->base;
 		/* Compute the number of hw descriptors according to the
 		 * reserved memory size and the payload buffer size
-- 
2.25.1
