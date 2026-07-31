Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FBF368263
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481533; cv=none; b=ZygcTju09HkJLN0JrPj8Gp+xWygxmAp95+OCO12AOFVfhJYc90LSdCximN4IeXoUooVnD4Fc1gkJz1fQ/yKiP1Y12wbPxKKpEX9LOQ33BbH5XsElsYdp2xVf81owOvsGzF293VPIsCe0ssx5th37mni+6fVT7e7nT4EJh8eBtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481533; c=relaxed/simple;
	bh=q5UEPjHCTM3HJeezdrQHBgApF6M5fV7Fh+3R+qmBDNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDG5qums3HfwQ7z8jBPoJ2XIBfpNuQrWXAbOFlU3OedmmzxqtUXK9cqolBBo86Fls7EFyAIOl9slJdIbqwnuZ2iGtJS0hioZaMzzejq4OxdrjrzZtrttQweFxTRI23a7EkKZfCQ0I6bsBghQ2Z43CV5b/eDRGM/f2eiy4jlIrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=ynu04UYV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="ynu04UYV"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8486672f03cso850071b3a.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 00:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785481529; x=1786086329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yz1oRNcg19iVfX+eVJWelaG34L/oIKLecIITUvBw3oY=;
        b=ynu04UYV36bcpXgFNnAm7cnc4cagUawnHr4WtmAI0nh4Sbhdorvf65UnVDq5LOODii
         URC8pvbePcfFUwdhxYnE+uHBf3hcTxiUwKmffhl6dkwIKQveltFLPWtUPg5Cnm8FUZU7
         TExmRZzEn/lUsWOsr8XRHxlhU9U2M0EAErYvC22mMId5W39fqP2bDsMMs5mCqJiU0+YQ
         4X3vp5XTvP0Rg/p072uPzb67g5md+xPQRgx+SFZAaCoTeMLIK0nAo8MoW89gViFloh0R
         qtOqgUKRihJrJc+zGPiVTev18X973uYWLU5I1idaAulXi4BU33qGatUV4bgJyp3aXJzK
         t35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481529; x=1786086329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yz1oRNcg19iVfX+eVJWelaG34L/oIKLecIITUvBw3oY=;
        b=ICo1j2OM2GRFj2k5YaRE+kxqFm49uIRtxmb2pjYQHlMrY2RboORT9pGbMsEm1E9l4/
         XK6XIi/YOQ6oT7dhfQSXoURYMbdpd5R+m6T/05sQTeaoHGI7UzoFZHnkI+msEg0x6QXd
         T//czpKvQMpKDG2yeSw4TNZyE8y7FJoLB6XyLLiaIQKuof7cOW3gfiMywlkpYQbdxlas
         445WA2npmNEw+syq7zhVqi64hi11NxIQs8LohailBpcjLZSbcFHC3x1KvQYG9bOBNwwa
         XEhYac5Ii6ByI+be3tGKQUQy26sWmBXZpAOeBvZJXg3s3tn5+qUW4HLpxZ/JQvrNbrZl
         mjlQ==
X-Forwarded-Encrypted: i=1; AHgh+RperP1wtSTt/6gaEjkXyTwvGsKCrQvONL3njmLEedbmB44HOkv8+mtkv/84YRUO2kivP4JSyAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWWy/7NOVeggzI9aIP3Yoo++GRU5anEEDdi73nqqCjQx2t42QN
	fMH/G9BXqYHTW8S1dVhZvnNUfXq3Wf7f8BPl+RFq6u8I9P/gDnbDPAL2mlNtRn3VngY=
X-Gm-Gg: AR+sD12I1tPHEnFbgOISbMLkmUlxcyCOhwDhF4jz9PDFUBoaOV6B3Rg+XS17vVs3i6X
	V8mR/hWI+flpkH7PjTKY5qASBtlUOfP0R913r5QOIXWqHYR7yOGOBrfEgYADG+fmdSk08+o+oRw
	QFpxTKiZtWXj7avr0p74FktDn0FO9zlB6G2jfHHT5fiY3jwkOjb2if4SpyTqOtAMkYCf4kIcV2I
	hSWa+y+USPkfNuctmarQYwEPJthyhbq/S8ctnB56uMmXRnooWH2emOUovCjhveUvKT2Y+mgrWEk
	0u5R3AucshuoyyQ8Y46p6QkNEJRkM2H0X5Xtg7TKNXc2iWejsmWsEkwWbNbQ+IPuRzyzKnvcuGt
	0WU1Lyrjls8m/wdzCyPI6wxosyepyumv97vSgdD7NTQtumgrc/pdodb5SG7TAFG82KNBNThC43I
	u/QLAKx4otHXf0MI0KGBl1uAD4ZwzDl2QM5WhBmM4wplxuddDdnmd+cNrQ5u9PshOXaowV
X-Received: by 2002:a05:6a00:990:b0:848:2f7a:2e57 with SMTP id d2e1a72fcca58-84ed722d703mr744876b3a.70.1785481529132;
        Fri, 31 Jul 2026 00:05:29 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm39233b3a.40.2026.07.31.00.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:05:28 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/3] net/smc: fix use-after-free of the LLC qentry in smc_llc_srv_add_link()
Date: Fri, 31 Jul 2026 16:05:07 +0900
Message-ID: <20260731070509.1818665-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
References: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_llc_srv_add_link() keeps add_llc pointing into the queue entry:

  add_llc = &qentry->msg.add_link;			smc_llc.c:1482
  ...
  smc_llc_save_add_link_info(link_new, add_llc);	smc_llc.c:1494
  smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);		smc_llc.c:1495
  ...
  u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
	(u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;	smc_llc.c:1504
  smc_llc_save_add_link_rkeys(link, link_new, llc_msg);	smc_llc.c:1506

smc_llc_flow_qentry_del() kfree()s the entry, so on a link without a shared
v2 receive buffer the pointer handed to smc_llc_save_add_link_rkeys() is
already freed.  Before the Fixes: commit that branch always used
lgr->wr_rx_buf_v2 and add_llc was not used after the free.

Detach the entry instead of freeing it there, and free it explicitly on
both exit paths.  The reject path has to detach as well, otherwise it would
be freed twice.

Fixes: 27ef6a9981fe ("net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to 1")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Reproduced on an unpatched tree over rxe, with KASAN, kasan_multi_shot and a
link forced to max_recv_sge == 1: the entry is freed and read by the same
call, and the freeing frame is smc_llc_srv_add_link() itself.

  BUG: KASAN: slab-use-after-free in smc_llc_save_add_link_rkeys+0x333/0x350
  Read of size 2 at addr ffff8880052194de by task kworker/0:1/11
  Workqueue: smc_hs_wq smc_listen_work
   smc_llc_save_add_link_rkeys+0x333/0x350
   smc_llc_srv_add_link+0xaa2/0x1e50
   smc_listen_work+0x489e/0x4d00
  Allocated by task 48:
   smc_llc_enqueue+0x72/0x560
   smc_wr_rx_tasklet_fn+0x474/0xa80
  Freed by task 11:
   kfree+0x121/0x380
   smc_llc_srv_add_link+0x9a8/0x1e50
   smc_listen_work+0x489e/0x4d00
  The buggy address is located 94 bytes inside of
   freed 96-byte region [ffff888005219480, ffff8880052194e0)

The offset is past the 72-byte queue entry because the out-of-bounds read
fixed by the next patch is on the same line; what this patch removes is the
free at smc_llc_srv_add_link+0x9a8 happening before the read at +0xaa2.

 net/smc/smc_llc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 954b2ff1815c..90746cd1e29a 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1481,7 +1481,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
 	}
 	add_llc = &qentry->msg.add_link;
 	if (add_llc->hd.flags & SMC_LLC_FLAG_ADD_LNK_REJ) {
-		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+		smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);
 		rc = -ENOLINK;
 		goto out_err;
 	}
@@ -1492,7 +1492,8 @@ int smc_llc_srv_add_link(struct smc_link *link,
 		lgr_new_t = SMC_LGR_ASYMMETRIC_PEER;
 	}
 	smc_llc_save_add_link_info(link_new, add_llc);
-	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+	/* add_llc still points into qentry, so only detach it here */
+	smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);
 
 	rc = smc_ib_ready_link(link_new);
 	if (rc)
@@ -1512,6 +1513,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
 	rc = smc_llc_srv_conf_link(link, link_new, lgr_new_t);
 	if (rc)
 		goto out_err;
+	kfree(qentry);
 	kfree(ini);
 	return 0;
 out_err:
@@ -1520,6 +1522,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
 		smcr_link_clear(link_new, false);
 	}
 out:
+	kfree(qentry);
 	kfree(ini);
 	if (send_req_add_link_resp)
 		smc_llc_send_req_add_link_response(req_qentry);
-- 
2.43.0

