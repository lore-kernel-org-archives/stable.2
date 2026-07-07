Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64954252A2;
	Tue,  7 Jul 2026 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434675; cv=none; b=Ceza+/xZZ5tZlSmdNJE3fqrMTVM9BEESMAa+azHn3kkOOX7kdVW9qwz7l2pKM358BmdogygszkFoTGQKSzZY0WRHtJMsTNZyMWJSnyZ7SuCrP3t8oGdyuLEDgZvfi7aJH31/SCuJfmlVIRSPvA61uIhA0Fch5bNOvGx2em0OCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434675; c=relaxed/simple;
	bh=xLVQRIygJAF0+r/kQ4mO3IaymdnrpddqCGWjhZmBe2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaW+i7K9w9165CElB6mOTX4gwlOMr1ufokyaQk7Z7kObCbuISZwve2NDiDn3kR0aQHaWWoqqLe/SA1Y36NaX4B4Vu3Q4Ht53Xwf9x4uOSM3/qfqeY63C49zBQj7Ua4+1mS8T4jsD8fXSLGMUbMUm0DRn7UNRT9IatwIvi6LeAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FmPPgbhe; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FmPPgbhe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783434662; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=0pfHhjKxWnCHHqsUGc9OvKP9mug23MNVxOz2WJ7PpuE=;
	b=FmPPgbhejgFFbNgTe+5KcQju0p7uwJUeSlRwZEIAVAnrrBUh/O96/BR28NBwJqUjY/T5G3JmoxGqQxQZBWL1xMN+MQO0C/JrBNbx+o1nU8e6YyXPHSd2u8edVegg22e3Dzly7SEC0nnuZ1muk6dh6GtHc4h+mWjmuURDdW+KDvM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6e2kUt_1783434660;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X6e2kUt_1783434660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 22:31:01 +0800
Date: Tue, 7 Jul 2026 22:31:00 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Federico Kirschbaum <federico.kirschbaum@xbow.com>
Subject: Re: [PATCH net] dibs: loopback: validate offset and size in
 move_data()
Message-ID: <ak0NpKUDkvrkuSOm@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260707074318.1448662-1-dust.li@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707074318.1448662-1-dust.li@linux.alibaba.com>

On 2026-07-07 15:43:18, Dust Li wrote:
>The loopback move_data() performs a memcpy into the registered DMB
>without checking whether offset + size exceeds the DMB length.  Unlike
>real ISM hardware, which enforces memory region bounds natively, the
>software loopback has no such protection.
>
>A peer-supplied out-of-bounds offset or oversized write would result in
>an OOB write past the allocated kernel buffer.  Add an explicit bounds
>check before the memcpy to reject such requests with -EINVAL.
>
>Fixes: f7a22071dbf3("net/smc: implement DMB-related operations of loopback-ism")
>Cc: stable@vger.kernel.org
>Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>

Reported-by: Baul Lee <baul.lee@xbow.com>

Best regards,
Dust

>Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
>---
> drivers/dibs/dibs_loopback.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
>index ec3b48cb0e87..0f2e09311152 100644
>--- a/drivers/dibs/dibs_loopback.c
>+++ b/drivers/dibs/dibs_loopback.c
>@@ -254,6 +254,11 @@ static int dibs_lo_move_data(struct dibs_dev *dibs, u64 dmb_tok,
> 		read_unlock_bh(&ldev->dmb_ht_lock);
> 		return -EINVAL;
> 	}
>+	if ((u64)offset + size > rmb_node->len) {
>+		read_unlock_bh(&ldev->dmb_ht_lock);
>+		return -EINVAL;
>+	}
>+
> 	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
> 	sba_idx = rmb_node->sba_idx;
> 	read_unlock_bh(&ldev->dmb_ht_lock);
>-- 
>2.43.7
