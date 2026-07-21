Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF271FE44A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638928; cv=none; b=uVJFssxQySk1OY1zmE7U8DZHK6iNlPpHPloxqqUm5Dn7hy8J+HIjoVUbs0GdqOWrMz3heQ2eNuhYnPsK9sO0zBnsMepKrVDoZG4WN8YLnx0ZxElLruiLAAt+zrEPrgPkYZp2wuBorH0oiOp7aQtKblBHlMieyTvwCew/EldA+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638928; c=relaxed/simple;
	bh=8cxeUmsLqWn5ksRQqaltbtwLEarx5okZXtUf5BpvWSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGrs5vmR7/ZQBHXnHCv5qS5jifx5A2kE0Bd+RMmHSATIDkR5MOZsiTSnPIfJoSOhiHXKbqkQoqwM+vNR3n1rMfUvhknDciye5csJO1McBhXqBiKBTN507cEsIrU88y+z6nIU23YkIGMwiS+TVMzmkEyGzpRcPEgObXjPrGi1BRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G9+1xiWG; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G9+1xiWG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784638922; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+qOaQW9i1QXxF3K4z8UDWs5WqUYxLGWa3CPPl9/xS9Q=;
	b=G9+1xiWGU0P+oVRKcwNy0gaR53jpYlPfKUH25He2YjgeKclceA1kul54p8MMedSwVz5w5/3FRg356wgDqT4tU6nSw7u+YcwQcsIWDy3JnRJoxBNQCpc1Ilu7+P2f3ievU2i2jTNKmqJImdYAR/qxHFp1cDbNbvUhhb0YmFvKjeM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X7aCvF7_1784638921;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X7aCvF7_1784638921 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jul 2026 21:02:01 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: Dust Li <dust.li@linux.alibaba.com>,
	Federico Kirschbaum <federico.kirschbaum@xbow.com>,
	Baul Lee <baul.lee@xbow.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12.y] dibs: loopback: validate offset and size in move_data()
Date: Tue, 21 Jul 2026 21:01:49 +0800
Message-ID: <20260721130149.3828003-1-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2026072130-tadpole-coauthor-d48e@gregkh>
References: <2026072130-tadpole-coauthor-d48e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 78237e3c0720fcc6eb9b87e90fd70f63eeca886f upstream.

The loopback move_data() performs a memcpy into the registered DMB
without checking whether offset + size exceeds the DMB length.  Unlike
real ISM hardware, which enforces memory region bounds natively, the
software loopback has no such protection.

A peer-supplied out-of-bounds offset or oversized write would result in
an OOB write past the allocated kernel buffer.  Add an explicit bounds
check before the memcpy to reject such requests with -EINVAL.

Fixes: f7a22071dbf3 ("net/smc: implement DMB-related operations of loopback-ism")
Cc: stable@vger.kernel.org
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Link: https://patch.msgid.link/20260707074318.1448662-1-dust.li@linux.alibaba.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 78237e3c0720fcc6eb9b87e90fd70f63eeca886f)
[backport for smc_loopback instead of dibs_loopback]
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 85f0b7853b17..0bf9e4075f03 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -245,6 +245,11 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 		read_unlock_bh(&ldev->dmb_ht_lock);
 		return -EINVAL;
 	}
+	if ((u64)offset + size > rmb_node->len) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+
 	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
 	read_unlock_bh(&ldev->dmb_ht_lock);
 
-- 
2.43.7

