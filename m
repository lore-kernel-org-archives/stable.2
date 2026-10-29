Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297401;
	b=f9lyEVVRw8LhILJR62GWv8V+PXXaA2Dk3c9nkyzMt2g5AXzygVkZRoTV4yd143UfxPp7
	 3LlLmZ5aJfeeoFDc6SBImWLJ9/6IWp9ro5bkPdVgEni9y+EGeg2KFYuzBoTjCIluJ7GOD
	 IpNzHtcWGJ6za721VKRV/awYMM5QpF3RfR6uCRSgid7Dxj8l7e5bECPf5gjMTV9T9Q91b
	 J+ItRD4FwPUNLoZzZuWgh2K4P8y+w5CTI7/9mgXlzCsbuTKEyFOT4h6tywMRO0ZG77Zip
	 VYISHWpoyy9l2UE19qE6aKjx14G+JGQQ1YziZ4oSdI8/22GJ8NXElieelsFlf98koiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RlQUuYiz1FCtWrnI0FR4amz6PP3ZtOjRWsNP3c3RScw=;
	b=AHziYIx9/IuBWtnemuZhf2lVLRC+w7IBsIH03Nf9gnLpLFAUZI1QCjlxEdmAbM8/kH4G
	 O2uWvKWnhV9hl5RX88VCsd7DllrlfwO3VUDDFcIK3qIV2QV1/AoGJVn/sueeP+XjEu1p3
	 UoDpi+Cr9KClLm74PJX5uk5XBeVM1shD8ZTuqiEo9/gdEkfiu19Yy2tLhCaVPQByzZ5rI
	 WhcQ9BHqNp3yzzwQ9w2MkKzmLPHTp8rMjmQDF/kUYkhsjpeHNvXzb2U9wAUK3nIEOnef4
	 +9z25gz82it6C3n16nON9uz+GB1sx0dRvsM3NLD1SYRutYDUEOuYyfqL1985LhjesJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Xg4K3yuf;
	arc=none smtp.remote-ip=74.125.230.201
Received: from mail-qk2-f9.google.com (mail-qk2-f9.google.com [74.125.230.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526BD606A33D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 526BD606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Xg4K3yuf
Received: by mail-qk2-f9.google.com with SMTP id af79cd13be357-93f53f29dbfso108483385a.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1793297400; x=1793902200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RlQUuYiz1FCtWrnI0FR4amz6PP3ZtOjRWsNP3c3RScw=;
        b=Xg4K3yufJiDKy1nLDLDolUzOXCylFf4dVPixfUWzJM314JVKpNGNgsDXm9hRXOwgtg
         zcTePD+4YKcudndMWVHz7cYAc6e+Qa5LMgRlZpZToTAAW4paAre25wbbrngIJuDwxzHs
         Qce7jr+X5ZqZQWvavz4EzAePVpaRs8uVIjzCpV8jbKD5ge5+eiPq8VEAvddnI7PJHZfu
         9tgB2zK00oTffZsleRejkG0eIT0Zc7lpzsDTG+DPN00zDNIvECvIkYpdlgWemf4yJrN3
         Fm615h+K5RkaZg9p8NU10M4PP+NrwPAVwSKSwiIENJ9OYkHxTtdqbnztIiALdubjE6Yt
         dpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297400; x=1793902200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RlQUuYiz1FCtWrnI0FR4amz6PP3ZtOjRWsNP3c3RScw=;
        b=Bc8jSBIVxefrjQZaq+ioyYfJo6MrrvOY37uYsJ3Lg1tjKaeKVI8nTN2VxS2XsYd/6i
         qo3NwH+/79pnOCKVOgoUJ26lpZpcRBQZTmEElwBYH5g2VWfymNDjZk9l5kj3+0ecQA39
         GZS6ipGnvLIwnW0v95t0Bf7lODgbQoVQOaizRJ/73xQxMoiZujpmtQSYq1YIXq0ZRz5z
         szPhWO+gc2daD9VWuiuF09VLHNLUUDK+Wx60mvwy9UGuf/2zYmhNZxbbNo2Ymr7XF2PT
         awZt4CDMAPfn3pzJ/MV3QzZTvQ5EL8aNtWUODUs4gJ12Nj5QzXHAshmu3eXhEY/rgBlk
         cqRg==
X-Forwarded-Encrypted: i=1; AKwUvBwNcy0AF0ZQDJ+aqEX+jnsO95RrGWFFhgo3Ki+VBkzBfM0elNBTA0akm28hEBA/0evErUCslkE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIm3fQ2HhUZ72pS6NGoCbEb8pF2e4AfMH1OUemVkzqSdrDLWegG
	VmM03hclOGnVafu+bkMb0LKaBOFKhBR8bQkkWoFeW2mtpRyiPdpcDBl4FqejoALDY0s=
X-Gm-Gg: AYBFou1HSWCrodXbBVZgX3lo1m3tk0xE63J1E1jPMMYDcH7rRmA5c0QbsdVI4/+cfJF
	pKgvvPR88HN88Gwum0cj2evMMUjsat+g1HuvpGSjPT9/kfhis8112umYjzbTctbL96yC96L3DJ6
	QlGtOOXhZfcGnnUeWz2Oca6iuRxAfunAQiQoazftO4AH81Iy8Q6GvF1YRtKUHA9y6URkcL/a182
	1t2fFG+/Yh62Bo1D5NyZzt7DfuwDmg5Ii51YtuuM6MFWlXupNLcOXwl1oS+BCE+8dNr+PhVv2oO
	JozNdKUjW5zNWr7EDPgmPIyGx26T3nf/eKXKwYigwz6bTyBoKpgMh7NVN+Mo/Y/CgqdCvBFuDvC
	HjSmpgLV0qNB/eGRvbNmaxE6/AA3EF6ezLr8bOKpp0WxLQsGW8+83NbxTAWF5mZdN92jgZL6Aqf
	bXgqN1IhljEJq0dJ6JDKw/t0GqiEc9vbRxT/N6IDnU9ieBtUVMXHYDpz06oC70O7hTcjlLyYvdB
	MZ5I0Su164mozV7ZtS2U7K9qMMjK5luQERNSH3bZPBrzSNeoa+Fz8kFJRZBuJNO+Y0Vw/By++V9
	/Si+x1HXi96C/WT+Ixo6U+04nCwWIedmJ+aelhEHoNKgaHOkR3pSK12aLl93a2vCdcInq1Qk57X
	fZVWXatcqzvlrsPdZYeoYCz9lh8B0XjkXFrPx
X-Received: by 2002:a05:620a:a0cd:20b0:944:12d5:fd45 with SMTP id af79cd13be357-94412d5fd66mr399408385a.70.1793297400257;
        Thu, 29 Oct 2026 11:10:00 -0700 (PDT)
Received: from localhost ([2600:4040:2047:3600:64c0:68e:df43:40e2])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9442120c8d6sm6925185a.21.2026.10.29.11.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 11:09:59 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/sched: sch_qfq: prevent aggregate self-replacement
Date: Thu, 29 Oct 2026 14:09:57 -0400
Message-ID: <20261029180957.43015-1-david.lee@trailofbits.com>
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

From: Kyle Zeng <kylebot@openai.com>

qfq_change_class() snapshots the current aggregate settings while
holding the qdisc tree lock, but drops the lock before selecting the
destination aggregate. During that gap, qfq_enqueue() can move the
class to an aggregate matching the requested settings.

When qfq_change_class() resumes, qfq_find_agg() then returns cl->agg.
If it is a singleton, qfq_deact_rm_from_agg() frees the aggregate
before qfq_add_to_agg() immediately accesses the same pointer, causing
a use-after-free.

While holding the tree lock, skip the replacement when the destination
is already the current aggregate. Any estimator replacement has already
completed, so the class change can finish normally.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Link: https://lore.kernel.org/netdev/20260731140533.566493-1-david.lee@trailofbits.com/
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Add the net tree prefix to the subject.
- Restore attribution.
- Remove Assisted-by and add stable to Cc.

v1: https://lore.kernel.org/netdev/20260731140533.566493-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

 net/sched/sch_qfq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 6f3b7273c..e900890e9 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -517,11 +517,14 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		sch_tree_lock(sch);
 		qfq_init_agg(q, new_agg, lmax, weight);
 	}
+	if (existing && new_agg == cl->agg)
+		goto unlock;
 	if (existing)
 		qfq_deact_rm_from_agg(q, cl);
 	else
 		qdisc_class_hash_insert(&q->clhash, &cl->common);
 	qfq_add_to_agg(q, new_agg, cl);
+unlock:
 	sch_tree_unlock(sch);
 	qdisc_class_hash_grow(sch, &q->clhash);
 
-- 
2.53.0
