Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A51DDC33;
	Tue,  7 Jul 2026 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410221; cv=none; b=jxLkhAdSVR3W/DKD+iHxakom8BeaYAQXe1TGACIj+efwDBPHETktS940plq9yvSr3/IIcESkMcBxJ6m0vj42j/yi/Xn+BQhXIIa+u8qugNqgpR+FybojqAXhqNjUXRnBWJt3fhMt3MvI1QvsAEi8WUHxnxdJt0qZCvjDqb/XloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410221; c=relaxed/simple;
	bh=Tq7f3dBw7B0XZ8CQiEjr2kIIxRHlm6nXnq/qlYatUAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eeyPR7X+OLZrEa32PU612ATDZ02JaeVwK0fOKbDCLPCSk4xInm8LysF08pOxhwVSpdqFl83dk29yO4NfozlGZk8QQB2VozpY8PvzMZl+lkzPBU240Unc2gbZW8AId8Rx2GXYLLepkq7KYGGMzvWrKTMaLErJRFSuDz+CjagEf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KdvrD9gO; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KdvrD9gO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783410215; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9sAlq48HMkccx+ANNwb6G66ZwEKXr9UowhQxsFx6mVM=;
	b=KdvrD9gO8rz/TGNf+gkgfFxWWSwMd3TT3xwT4QJd1sRtRr5MELgJ8BA2uUfT6YsL4EjBz/olzB/OjnudgEJ09dXGhz5X26YJO0MEWUTOZm2kveznX4HWReWpzjTWeyjuRRbG9SOxlivGsiLCxyfcfVH+zZqnjJYT79hhSC5scuc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6cS8Z4_1783410214;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X6cS8Z4_1783410214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 15:43:35 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Federico Kirschbaum <federico.kirschbaum@xbow.com>
Subject: [PATCH net] dibs: loopback: validate offset and size in move_data()
Date: Tue,  7 Jul 2026 15:43:18 +0800
Message-ID: <20260707074318.1448662-1-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loopback move_data() performs a memcpy into the registered DMB
without checking whether offset + size exceeds the DMB length.  Unlike
real ISM hardware, which enforces memory region bounds natively, the
software loopback has no such protection.

A peer-supplied out-of-bounds offset or oversized write would result in
an OOB write past the allocated kernel buffer.  Add an explicit bounds
check before the memcpy to reject such requests with -EINVAL.

Fixes: f7a22071dbf3("net/smc: implement DMB-related operations of loopback-ism")
Cc: stable@vger.kernel.org
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 drivers/dibs/dibs_loopback.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index ec3b48cb0e87..0f2e09311152 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -254,6 +254,11 @@ static int dibs_lo_move_data(struct dibs_dev *dibs, u64 dmb_tok,
 		read_unlock_bh(&ldev->dmb_ht_lock);
 		return -EINVAL;
 	}
+	if ((u64)offset + size > rmb_node->len) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+
 	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
 	sba_idx = rmb_node->sba_idx;
 	read_unlock_bh(&ldev->dmb_ht_lock);
-- 
2.43.7

