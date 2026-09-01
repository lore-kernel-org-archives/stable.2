Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA639A054;
	Tue,  1 Sep 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265812; cv=none; b=cerEUlrePcvqaABKTkkLqAKDo3cU4SRjVlZPH5WoaBXvKH31AOBuVVjnbL7l5S/SJscAZ82bH62o+4XEh18P1lx5Q/nGLbM76ezCMhyeepeJEopXliBQmK9eQ7WLKR1z3kFNfmisp7Z50Z93lzmFHY0C84MtggFZZUqbIqHJDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265812; c=relaxed/simple;
	bh=q20S4u+eJPohIjmT3Hcu4vDZZtdWxa6WceYzGfJoNwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW5v7Bq99M9Zeg7u3YtSUVybhisFCRsS4X10PfYmZlnNMN+kz40RViLP/akRZmotQtIczXLLvskLFeyok4kHPw3ORr70rdxkBzxLawaoKtyfNwEysmzTNxEqCC1Ulue+5NsCyYmp43xWqOTrnKqyriTuZalmSf9E/imqPYo+xyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mY2tZVtu; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mY2tZVtu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788265806; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GzpxoTkTMcXH1CYeG1Jul0lNEtBB1Cmd3DrK0z9OqwU=;
	b=mY2tZVtumbnoADYoh+u/qgX86gVjmQld37Ka7xB7crBA3hzK4lgBr2wFpXl6CkdM7NiC3sgTmCw7etn6SyBIgj3VmNExNrYZD0IcvNTgME8hZGUqDNwtxDkKoBgv6UXEfozNxzmRYwgzGv/u8NHsOuVaX8jq2HPte06A/DlZpes=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XA8X4ol_1788265794;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0XA8X4ol_1788265794 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 20:30:04 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Dave Hansen <dave.hansen@intel.com>
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
	akpm@linux-foundation.org,
	rdunlap@infradead.org,
	elver@google.com,
	andreyknvl@gmail.com,
	glider@google.com,
	gor@linux.ibm.com,
	brads@mainlining.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] stacktrace: Provide arch_in_event_entry_text() hook
Date: Tue,  1 Sep 2026 20:29:49 +0800
Message-ID: <20260901122951.1077081-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <8c86db41-9270-42c5-b2db-133865d254f7@intel.com>
References: <20260831120221.2874445-1-xiangzao@linux.alibaba.com> <20260831120221.2874445-2-xiangzao@linux.alibaba.com> <8c86db41-9270-42c5-b2db-133865d254f7@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 31, 2026 at 07:01:52AM -0700, Dave Hansen wrote:
> As much as I love inflicting x86-isms on generic comments, I don't think
> this comment needs to talk about x86. I find the most useful generic
> definitions to be like an instruction manual for future arch/
> maintainers. Maybe something like:
[...]
> ... and then talk about why x86 needs it in the x86 definition.

Good point, v3 will do it that way.  The x86 definition already says why
the range is needed there and that it covers the ring 3 entry point, so I
will move the note about not being able to tell interrupt entry and
syscall entry apart into that comment as well.

Thanks,
Yuanhe
