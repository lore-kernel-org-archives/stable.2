Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699935;
	b=OAqPe1VvcFeRp7rttdDC5l5rcOE1Z+aLfoFd9Zar+1vT4YpDYomqCqHzhRcQLGBxh8+R
	 PKxLaYqyDejH4nRWnHSc2ySfYaVlDbOqzuN14AonGrYfMLxYsjvp3zIiKpBzih6dkmwT4
	 c+VTpOgbtRe1ylVhTrEkCqWRTifmG1HH26LCxAhsMmNeOvg23zhCrJOQcrftFnryJ+wq3
	 Xqm6g+d8JYFNXJow1jX04bl+Hc+7aPig77iP5nA0iZ1WmiXiJ872eP0iK6X7N8URdVDtp
	 YAn+2hSjH577YmlNAskHaWovCztiXrznEOMuaNvgQULx5DO7JdXJ8HsHuNfIQ9QpTgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699935;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=ssR/hjz/6yhhPpZuRzYq/H19RXW10E80/skGI58LykE=;
	b=wu1d8dYPUK/vOz5wFNfXVUJTJtALnaehVeY3ca/5E9EuzoiEn0oKXpcJkGXDtc/iETeG
	 NJ9IXwQyzfO4H997YnriUIT3rC7GCt2RXDsAFGY/LWV+yAO6sOyXLeBAFYN4sLAlUbT2o
	 vRuK09g2xDEc4PIyZZvhD7t/jJK7/GC0EtoJviYvERBnJrBuVS6PfEIY7WJdCJC0fMn44
	 kfOsQWqkWLwSjXC1MUMNx+7cDjCewHXeN1SCuyWz9KPrUltqzlRYA+ljoPF72dhmeFXNU
	 W0+xZslm6PQilq7z48tVHyolI5TL2q4D2cJvcf/rRMppyAE8hDGGRnWiWFOFQwjm6WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NPIic3MB;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0CD6082BC1;
	Tue,  3 Nov 2026 09:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB0CD6082BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NPIic3MB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ssR/hjz/6yhhPpZuRzYq/H19RXW10E80/skGI58LykE=; b=NPIic3MBA9mbrDcFQ5XPBBsEn3
	i2b55a2Z6Wj6ammnrBaOqZBOtBTNt0h2x9iZB776w0AstQ0FKFFzNKPoyjB1/YxccJQ+EdgWBYp7M
	b1EYh7obeU8KVC4ZxZPJo6XsQx/zd6qk3H4jiy6GtIgfnc+8bEzFEj4jaT/fxSdtcaKerPz19itas
	CBvuxZXRtNL96ZhbBO+1bAs2bdBfVMyCKbjKJDNPWdR8bE00HgAwuH0SAkQ1qmitO2z9NE6ODXwSu
	+UWQ+oVvOYX+Tk2xObIJlBjPkAb6GbvfUeQV3M0OGnDO48uktyjbvHTkuXgo5cPld6EWei9MbEOKV
	+QKgROXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBI5-00000001rcA-13yk;
	Tue, 03 Nov 2026 09:58:53 +0000
Date: Tue, 3 Nov 2026 01:58:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, yuyufen@huawei.com,
	bob.liu@oracle.com, yebin@huaweicloud.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: keep flush error across tag iterator reference
 drops
Message-ID: <aumwXVXRiqqV-IS7@infradead.org>
References: <20261020190426.1073318-1-nirmoyd@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020190426.1073318-1-nirmoyd@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good.  Bu I guess Jens already picked up the AI-Version of
this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=67c43ceaa29e9b904216651697adf20445b219fc

Sorry for not catchign yours earlier.

On Tue, Oct 20, 2026 at 12:04:26PM -0700, Nirmoy Das wrote:
> Reproduced on v7.3 in an x86 QEMU guest with scsi_debug, failing every
> SYNCHRONIZE CACHE through its debugfs error injection while 16
> processes read /sys/block/sda/inflight:
> 
>   modprobe scsi_debug dev_size_mb=64 ndelay=100000
>   echo "2 1 0x35 0x00 0x00 0x02 0x04 0x44 0x00" > \
>       /sys/kernel/debug/scsi_debug/<h:c:t:l>/error
> 
> fsync() returned 0 for 35 of 18000 calls on /dev/sda and for 46 of 18000
> calls on a file on ext4 without a journal, over six runs. With this
> change every call failed.

Can you add this to blktests?

