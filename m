Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292793DB636;
	Mon, 31 Aug 2026 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178003; cv=none; b=tJ8IcFhQiu75iVBhCGqSpoKXaddzC+Cn2FKb+HhdEAFY8UYP1S1EuxCnGCLw9tR88NXcR/rJ/Sl9p0POinwE+PhUCt3Y4GmgVivKX96Hotz8sAGoJOnpCVl5I4CJxz+tTOYkAIKewkIjT5pNiDVupZppNIVxdyd22CsqryiwdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178003; c=relaxed/simple;
	bh=GuvEKbf4Qy08uSgtUp7unEXY1axa9ewR8UYqFES8Jek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mS8KrpKbwnl9CX3HyOECI7rqBzhjpDKDp04dxpd+TvmElpLtMa5YTSmmPlMsUw92TdSPqzotc3BhF5f4k4fFWKlmBmZGic352SKvhKchaA5gX5gRj5rT9klVuygbyjKBZo1raUwNjeFy9qMf9nisnJxuKQxLBabBaN15mZYlitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h7ZS3DR5; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h7ZS3DR5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788177999; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=u1vNRdi/HerwDRN/wJ8Zby10irxW5ckOXfmngwQBF2s=;
	b=h7ZS3DR5gGERFtkgazr0r7yLENqOteX2FZUdAhpt/vxrRMZSCm8umK/I9SQJeS7U4wORa6j0wxV2w4Wy8Egyib3VtX6/q/W7J40+yEPWJJNx3W9i2xBUNBr3UtAdzEwuocLecIRsg8lXK5jQ+VedNegM7VIYVZkrEc51Zr6kV78=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X9y..9b_1788177985;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9y..9b_1788177985 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 20:06:37 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Bradley Morgan <brads@mainlining.org>
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
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] stacktrace: Provide arch_in_irqentry_text() hook
Date: Mon, 31 Aug 2026 20:06:19 +0800
Message-ID: <20260831120621.2882700-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <58EF0ADB-E7CC-4A15-B124-B5A870281D55@mainlining.org>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com> <20260827150022.1618235-2-xiangzao@linux.alibaba.com> <58EF0ADB-E7CC-4A15-B124-B5A870281D55@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 06:04:48PM +0100, Bradley Morgan wrote:
> LGTM, thanks
>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>

Thanks for reviewing v1.  I dropped the tag in v2 since the patch changed
materially: Peter asked for the #ifndef macro override pattern instead of
a Kconfig symbol, so the hook and its fallback now sit next to their only
user in kernel/stacktrace.c and x86 defines the macro in <asm/sections.h>.
The helper and the hook are also renamed to in_event_entry_text() and
arch_in_event_entry_text().  Please have another look if you get the
chance:

  https://lore.kernel.org/r/20260831120221.2874445-1-xiangzao@linux.alibaba.com

Thanks,
Yuanhe
