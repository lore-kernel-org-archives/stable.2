Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662343D8128;
	Mon, 31 Aug 2026 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167201; cv=none; b=dxoHXT+TB0GxYsNDCfeKy6WmjcU2MZ+5EiXJYLl5kATBntotU+pgWpDPg78W1j3CS0vJJl6Ig5kn4fLBvh6D7TQvhE2W/jw5gR57G86LsOr+j+2cSqVB3ydXZMgMrRKw9cE8wtVHcND38SKkmNpReB1wHcMx0PkZJDAqoMf+FcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167201; c=relaxed/simple;
	bh=GAX8NvYclIU9SR155RvwyaH/WnywfnHt5/50dGI2S2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxYTpovpABTY42CeHrnJiQcfrx7+QnGnbMcrxiSQfQ2UUIDnY68d+rCIArAXBtHPI9AdYrWj+ltCq1lRAR/NDmrc73Y4UEkGusgwnvBiTVyvaXAzSbgsPDVI9nbzibnwjHaO0g31wrSHGLAILD5KxU1GiPrYgJKoaWG2xwGlqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RdD/Ygxj; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RdD/Ygxj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788167196; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=g0OnPD+ICl/hv1UqLXpM56z3XFaabfdZiSfMr4WXxBM=;
	b=RdD/YgxjdwGwp7+INSgmJ98cA+vvYxDTdJL5RdeyGAeisKgIUeUsfTiZgB+tCX5U7X4e8BrIS4O4ejNu3klNn6GBYz2ZC2bvTTCbrBWNpfg3IcpBegnMAESXyhiowBuWipkNUSaFpWYKQxJQ3zJ7KXwREpEZRWHvU+uY2YC91d4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X9wcDUk_1788167184;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9wcDUk_1788167184 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 17:06:34 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yuanhe Shu <xiangzao@linux.alibaba.com>,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	xin@zytor.com,
	luto@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	rdunlap@infradead.org,
	elver@google.com,
	andreyknvl@gmail.com,
	glider@google.com,
	gor@linux.ibm.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] stacktrace: Provide arch_in_irqentry_text() hook
Date: Mon, 31 Aug 2026 17:06:18 +0800
Message-ID: <20260831090623.2498707-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260827160615.c5cd19af1e4d9287d7870fb3@linux-foundation.org>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com> <20260827150022.1618235-2-xiangzao@linux.alibaba.com> <20260827160615.c5cd19af1e4d9287d7870fb3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 04:06:15PM -0700, Andrew Morton wrote:
> Good call.  I suggest that the same Fixes: be attached to this patch
> also, to help ensure that everything lands in the correct place.

Done in v2.

Thanks,
Yuanhe
