Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762687;
	b=OdSaKKXUiGqVRz8O9UuJ0JflSpsXqkggjqyJ9njjj98UehcTW+hoD3+Ld4brbocqNPkT
	 NOTbXpaKfWgoqjsbTEy8UPyhYO88GXHpHye9N7YIkUnMVWuWetyh0sYNMyalJhh2nZOA+
	 q9qAGiRgj2zvY0NVK05UTxyNrv1TQmuP5MtJRSmywst8mqbKp6at1aUmBtSLE88rFrzcv
	 KD6wTdUoPglH0oOJ8/xPef2n9S3mi+AKDJtJhO0M6QFftSUWYwJkTiGzFric6A8gYYXxm
	 yrnkz3ZAtifkn0kq+R4EkAvzZMMm+5Z5NPvt6uBZVaUHFj36AXJ4W+9xiIjjuub9f2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rw/R6ybt1QcdjNXidw02ubcIKo06kOfp72MwTKAEG3k=;
	b=PeNjRcgRsaAhqcrq/dzOcHXNmMsZoCClvZ2lQ18NjukwUrr2Wj2vCanfts5b0Peh6p9U
	 0POVaSFgpvM65XnVhg9ZWAPa/jdnb4+skbG9baU3PdRz40pFEhGzuYyKmcM7GLki2zj1E
	 Mvmsi6Givj0DI2aWOll6mWpLwjTUcDTT2RrOMabX/15en/Ep5QxIWLpGBdp0JKBI5yjZ0
	 sw1tSrbjXYpDuGKHqTsqnIL50LubkoYpwcMSpLXo+Bqw1Cp4dA5s3+uRSSf1o94IV1z7H
	 Knq56qmHaqNsIDDcPDJtrXjZ6idqtyieGIAp9/GmEm7zInVLEitaLMful2CTE1ZyNww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COZN6MOj;
	arc=none smtp.remote-ip=74.125.227.202
Received: from mail-pi2-f10.google.com (mail-pi2-f10.google.com [74.125.227.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8205606A327
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8205606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COZN6MOj
Received: by mail-pi2-f10.google.com with SMTP id 41be03b00d2f7-cdac0ac5f19so3800697a12.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 22:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795762686; x=1796367486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rw/R6ybt1QcdjNXidw02ubcIKo06kOfp72MwTKAEG3k=;
        b=COZN6MOjsPcFVoEeaiGgsF+/e6tTcTZQS9iRwunz8SIJCHdPJcBNTnk5TjH4KXx7DW
         w2SRIJzKtvud7uFtk7g5lKf2J8CIo7oPBvqwPyCrMMpHIJ9uhv4momkzYxzNwz7MRyYT
         XBqPOLxFU6An8CjL1rcCift2PtL4/F5xHSZs0wlA+WCFb/6BE42czIGVK6Zwmmoe7RoN
         SOaqabns2twyFyOdfjukt0TRzn1syR8rxe5ftrwweUoLbZpk0I3M+jQ2fDvnosfEIIb5
         pWdw0X3vITHsA2RM+PL2X4YTY1PrZT210gySkcP1W4Lx5DNEVpdcclcIbaKKZN8FpC6d
         Cqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795762686; x=1796367486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rw/R6ybt1QcdjNXidw02ubcIKo06kOfp72MwTKAEG3k=;
        b=1lvYTHeIrOyF+5A8gp/4+6CJqK/9xLCFXZGqtFBTzY2oAqh8MG2jeWKQlvUYlGxBC1
         LTKoGSwnWU7IiM5UzwKBHdh8wUBjVoGEx3vUDUR8YugQTK22ANGg02rpCWRvxnt8Q7uV
         ZR/T9BJc3cEnmBaPtTEoC8r4F0CMdllM32JCT08Md9wQ0Rpu93TC9CTCXeTAHWyX7HD/
         TRjRLWU8E3XZe2BVr+2KRvmrbPJ/dSAq4RerjhxuO2gx6gE5ZH9RZKbmQJ7x1Y2+bA+5
         5xel7ge93YOY/c1QgFmVf1ihHUcbOheO8vvdjjy/viTnWVAXJJTxIdZuVdFaL3E1oSJv
         cHZA==
X-Forwarded-Encrypted: i=1; AL+hErGrMCKrx/DxZ1ZNrTPFeOIcOaqWoEJqSvDBIO4e6eAJ4X0iltLzq1JW/KzMdtksqAG10xVmrVQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TRNm5ukKIB3q72ee497h0R+qiXf/YFwutsNqJv/nbUkLY52ov
	elHlb8xfBsS19gcPiFBcSngewmMhk3T773GeLSSFEI4z7L6SonzLewZk
X-Gm-Gg: AZFdTZd6EgYsIXMg8dL/R9IJP2WklfXJsKNdtu0ARIPIaUm9Vb56uwLlqmv4dpa606V
	nBgRoX++KyD+oiuCS4lPEqCexiAre9qzUYk4kS3KXWkFvIks2bKKelnOyWwQNBuTOmUxsqw0TrK
	ODfp8W2HJ7eKnaMdF3CYAIfoY72+Jka89uFMVzQDqxHnPt/4Kzoz7ARzA7vJtT/mLxqwVz1+iqn
	sf0MfntsBVIURG7S7R/EY2TMevCeTrcKCZA8KEPlVY86l41uRwDCF+G+CH4JpBULmOiRIdabslv
	WwsaZeiWO8XUx7OyhhVZUQho7OEegXG0qex6qpOBDYj2evuqK7qE5cPoH0IWvXQxK+UnOJf/mp6
	DumqtsGt1EeOdy5ixZMjrpJbxV4/L5hIWJBTG15LxsFWf/81y+iYM/ECLyTbJcks2RblZkywsdp
	Y5pknfrY/tDpE6i4es30iKb8A2P/qEul2Q1f3w2WT8VvKOdaJyDsIrdL07SBfvBcKeWUNStj4Ov
	zI3SAnh+AZj0q6Ys60Ax6WcYDpRN3vrkjUHC/ufkESUnmfdw+IpjhhUdfdTpZVq7dTnBmoptHuP
	P7QH6xdmUzAMYTJAg/3HU2PKm0NNZWMP9rzROdNIXpBTCUmoUxFQHXG+G+hkV9qVt1Q/hOc/jLM
	KXdON9CDWBpe2AaUM997uvg==
X-Received: by 2002:a05:6a00:10d3:b0:89f:6989:cb9b with SMTP id d2e1a72fcca58-8c87bfa1ebemr20969839b3a.27.1795762686230;
        Thu, 26 Nov 2026 22:58:06 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c228sm11839098b3a.10.2026.11.26.22.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 22:58:05 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net_sched: hfsc: clear el_node linkage in hfsc_reset_class()
Date: Fri, 27 Nov 2026 14:57:56 +0800
Message-ID: <20261127065756.2927925-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

hfsc_reset_qdisc() drops the eligible tree root, but hfsc_reset_class()
never resets the linkage state of cl->el_node.  A class that sits in the
eligible tree at reset time keeps a stale linked node while the tree is
gone.  This breaks the invariant that the linkage state of el_node
matches the membership, which hfsc_change_class() establishes for new
classes.

Two consumers trip over the stale node.  cl_in_el_or_vttree() reads it
as "class is in the tree", so hfsc_enqueue() never calls init_ed() for
the class again and the class is starved permanently.  eltree_remove()
later runs rb_erase() on the stale node against the reset root, which
splices a stale sibling back into q->eligible.rb_node and revives a
class the scheduler should have forgotten.

Clear the linkage state where the rest of the scheduling state is
reset.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: ac9fe7dd8e73 ("net_sched: hfsc: Address reentrant enqueue adding class to eltree twice")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/sched/sch_hfsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 284490fd6ca91..e64df06429239 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1491,6 +1491,10 @@ hfsc_reset_class(struct hfsc_class *cl)
 
 	cl->vt_tree = RB_ROOT;
 	cl->cf_tree = RB_ROOT;
+	/* hfsc_reset_qdisc() drops the eligible tree root; the
+	 * linkage state of el_node must match the membership.
+	 */
+	RB_CLEAR_NODE(&cl->el_node);
 	qdisc_reset(cl->qdisc);
 
 	if (cl->cl_flags & HFSC_RSC)
-- 
2.39.5

