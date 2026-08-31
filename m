Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E03E0724;
	Mon, 31 Aug 2026 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175791; cv=none; b=YyAw+mZCPoLh+Q0LCAxpFL/w+DWFMn+cZ0btYbExQMMEQIjtsboynAxyHimJl4AHkIT/abELt9K74hXp7HZqLwFLQI3AQumlt/uBMnc49QjLeUACrLC9+HFUPsWmfni4NISr35kzB5QOwoTp4paX6luZDgNKPSDTeUDuQ79cE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175791; c=relaxed/simple;
	bh=GJN1vin2Q31ZX7bgHFJMqlVFTKyfMQAah3yY8sPY5gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK7dqx1jvrpWXya977wAcCAUZpAtp1+3rRstnISEKZfPRlhUcglLJ4peCxFc7SFLsWkXvovLMCgad0goiPZ/hSeKMPULAh8kZgkeKJ+q3yZCh4Yw3jammoAcZkzF5tWj4Y4PMgwEHlaMgx001LSI02Ba/Y3md/oGYpIDRj+mfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kezbLR17; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kezbLR17"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788175786; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hF3lulElYH2Xmnb1Do1uy6IJVUDuVg8vAbpB3aVXlW0=;
	b=kezbLR17WbNyyJFA6NQ0D16Z5XKJNfGEEN1z5h/BNBSVL67miZu2e9IDSh0fUd1n/IbDdZXq4X6bRh8faLYFZVy///IdX62WnA3t/+SxMqMOZnpS9Ecnu0qOnFc3vPJtk6IAZ4lVIumF41wSR152PCZ3TWeC4DYDhE8GdIY3gb0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X9xxq-m_1788175767;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9xxq-m_1788175767 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 19:29:45 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yuanhe Shu <xiangzao@linux.alibaba.com>,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	xin@zytor.com,
	luto@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	akpm@linux-foundation.org,
	rdunlap@infradead.org,
	elver@google.com,
	andreyknvl@gmail.com,
	glider@google.com,
	gor@linux.ibm.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/fred: Fix stack depot filtering of FRED event stacks
Date: Mon, 31 Aug 2026 19:29:24 +0800
Message-ID: <20260831112926.2810979-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2efff83b-6c33-4453-9eb6-5cbda8f6380e@zytor.com>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com> <20260827150022.1618235-3-xiangzao@linux.alibaba.com> <2efff83b-6c33-4453-9eb6-5cbda8f6380e@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 02:26:05PM -0700, H. Peter Anvin wrote:
> This all makes sense to me.

Thanks for the review.

> I would in fact like to see the IDT-only code isolated so it can be poisoned
> if not used. The FRED code probably should be as well, although it is also
> used by KVM -- and potentially by other auxiliary users in the future -- so it
> might not make as much sense there.

For the IDT side the bounds at least exist already:
__irqentry_text_start..__irqentry_text_end wraps nothing but the
asm/idtentry.h expansion.  It is not page aligned and shares pages with
the neighbouring entry code, though, so overwriting it in place is one
thing and unmapping it another.

You are right about the FRED side: the range added here covers
asm_fred_entry_from_kvm() as well, so it cannot be poisoned wholesale even
on non-FRED hardware.  Either way that is separate from this fix.

Thanks,
Yuanhe
