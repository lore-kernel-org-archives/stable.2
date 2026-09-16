Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFF409102;
	Wed, 16 Sep 2026 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586924; cv=none; b=KWj4GZqYgYnUkaMygrfC0BIoRzHPJ1t6Ln39FqipvQeSQ3Wur9Xf+piJo4V2OFWxnxmYxVYSydgPSmbiwEBKSCZxAL/xlrtxcBAUxtgbeNEIaJ1ERULw5YT1V3G9EprW8MoEAXHqpBIiCSDRwGZBJQL6JQXLnOuRQmvrn+/WQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586924; c=relaxed/simple;
	bh=IOSgwF0OKRpi0SEUAc731s21o4gpcTXCt0Ra66P1EOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UD9slpG/vCiK1VujDI8MtUCVsJP7jOaw0hOky1BgnXeQnx4a2YUoeaPm+f/l8qnTCDhBAFiOgDpps3JUSpKjrsuY/yrEZQIRuDQycGhcWRb/Nv3K6iE8gqjQwsx4vF1Es06LrPFG/tYnj+0hAvBrWCdKw/H1M4+2Z1jhZD8Cr/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGe462Zp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGe462Zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63A61F00899;
	Wed, 16 Sep 2026 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586906;
	bh=/WKMCM0css3RV7MedAnec6PHvNtVaDiv/v5Vsmrb4jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gGe462ZpomYv+56SvNJpv/jPjcs9apgqJznmzsW75w2ukk44pSHGU9HeWmXQlad4l
	 LoJfx8z5fMV7LiGI+9gSQkUKU5x8iVLSUBH1ZfiigO9GnZ2PjeAP4beksUEI53DUuG
	 dIjpqU11RSsC7g2Mu1E621s6889FCPguMFX2TR0t3NShdbSoaeMv8sq30Apvfg7n7H
	 GYpPd5ZUqdGxLFAM47V4boVQb8qzAzmBykZqLLjfk/rkKLuTxs3nJ7lR5Xg81QTx0R
	 SYgb9AFjWC6KmWWWxqwcY2yeZWwEaam4xvdPSbwdU2Ir0BnFkZTuvYFJ2z9CCXtkfy
	 HAeDYnOtXmTXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	chenyichong@uniontech.com,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Suraj Jitindar Singh <surajjs@amazon.com>
Subject: Re: [REGRESSION] 5.15.221 & 6.1.188: bpftool: redefinition of 'free_btf_vmlinux'
Date: Wed, 16 Sep 2026 15:27:52 -0400
Message-ID: <daily-reply-20260916-0002-re-bpftool-free-btf-vmlinux@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915235834.20559-1-surajjs@amazon.com>
References: <20260915235834.20559-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Building bpftool from the v6.1.188 and v5.15.221 stable tags fails with a
> duplicate function definition:
>
>   tools/bpf/bpftool/map.c: error: redefinition of 'free_btf_vmlinux'
>   note: previous definition of 'free_btf_vmlinux' was here

Queued for 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
