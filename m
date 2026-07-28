Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632D384CD1;
	Tue, 28 Jul 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221005; cv=none; b=Zj85+YXOqhg6KwwRg3I3NnKwesuFArSsQb1yu/X45EL6CT456LCnLhvWyd/bmMslwkjvtwhVwNKKnlSzuc16jsKlSJZBe1VjfkLdWUhKDeXswc342SQiH72GknPqKjrsmFfYFDGqFK8E9tFsDSQPbVNTKc0PjxCkm4BHKeGqqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221005; c=relaxed/simple;
	bh=SyGJQ1Tmvt/L8U49L9OxyTsQWtrcq38DgGguOtojIdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ksLjV0dp14ojm3HtV6OMuwUVnqnMvE+XVKERvjlCz+dCHZUqTbKYfr9PslBpNU+BxDRKvnKXK0lf8/Iq7XrifYF+DMCnUr7joJQ0w62nGZksrPT+/baI80WajT5N/3VDAq86Kf5yhWcnwbKMsC4eRfCOQS7x7492GzDlQ/EklkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9850b6528a4f11f1aa26b74ffac11d73-20260728
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ce76e696-2a00-4fe3-8fac-efb58d86e92e,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:ce76e696-2a00-4fe3-8fac-efb58d86e92e,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:e27a0970d3f4aea3af0e022dcaaf2c15,BulkI
	D:2607281443112AECDF3G,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9850b6528a4f11f1aa26b74ffac11d73-20260728
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1101668530; Tue, 28 Jul 2026 14:43:08 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	stefanha@redhat.com,
	mst@redhat.com,
	will@kernel.org,
	ralf@mandelbit.com,
	viro@zeniv.linux.org.uk,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: datagram: fix integer overflow in zerocopy_sg_from_iter
Date: Tue, 28 Jul 2026 14:42:35 +0800
Message-Id: <20260728064235.337877-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zerocopy_sg_from_iter() computes the copy length as:

  copy = min_t(int, skb_headlen(skb), iov_iter_count(from));

iov_iter_count() returns size_t.  When it exceeds INT_MAX (e.g. via
io_uring provided buffers), the int cast wraps negative, wins the min()
comparison, and the negative copy propagates into
skb_copy_datagram_from_iter(), which can trigger WARN_ON or corrupt
data.

Use min_t(size_t, ...) so the comparison is done in the correct type.
The result is always <= skb_headlen(skb), which fits in int.

Fixes: 3a654f975bf9 ("new helpers: skb_copy_datagram_from_iter() and zerocopy_sg_from_iter()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 net/core/datagram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index c285c6465923..fd8e17d25a3d 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -783,7 +783,7 @@ EXPORT_SYMBOL(__zerocopy_sg_from_iter);
  */
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
 {
-	int copy = min_t(int, skb_headlen(skb), iov_iter_count(from));
+	int copy = min_t(size_t, skb_headlen(skb), iov_iter_count(from));
 
 	/* copy up to skb headlen */
 	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
-- 
2.25.1

