Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AFB313E3F
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051644; cv=none; b=dIqdV84J8f5Q/ANf3YqOWkKwBRErEycnknT2oLG4m3WhGKRoeIm5XSit2MAz7+rw22a/U9AtNwImwdo1D/LKpyKyWr0fV2+W2YQzeIblKCXrqjp8VujPjnAtYtR1b3YPeuU9MtYm66z/ao1Z9lPqoxdxkNI2RdcmtMHWW4cZjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051644; c=relaxed/simple;
	bh=VGGzqv+ChY/7GJW7+efT1k8912oIHVmxhGhaiwfsxno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5R1+HExj7RP8WKrnP47qFFtG336CKMDp3rDaLenkmnHg5Yd/8EFwcjmuCL4XzFwrX3NKEsz/84BF+Hv46PmoBMift5srMdFlfGYVDZrF4LT6Wr/OGdnDUCBJ/f+FqfK1s35bc/dN6lf2GdzwepU1mwdTwqC1OOuyItRTuvmKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SitKjRch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SitKjRch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87301F00ACA;
	Fri,  3 Jul 2026 04:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051634;
	bh=edyh5A3PDIoxlNhPtrl9DOe7oJOErCP9W/lKFC8hCZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SitKjRchdAzUMpvC3w5DGHa2ct8ltjr7MO6s774g8ZfBYYatHZOikb8zpZdTn6lXy
	 0E8XYWLaAKP//B8I8s0ObH4vZYxM4ljB3clLN2x2XoEdM/in5bFRsuNkPVePYuKQke
	 jf66M37GP6jy76I5GIBTkTXDMOfCl8SgZW3zVIgFErfbkz0DO1QpBmqc8OSIZ1C5FC
	 XOI2/URLfvDznSBZM6Cnd22+iS78aaes8u7Pm08mIkbUvise7WZS75XsyXBAbw5Aoa
	 ACmymvbcIPGUEf4FxPovxc7SgYXeyfKLjgbSDQicUfiZS1KSQtOskxNLrDP93NthNr
	 AShBZqfXRmT/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.18 6.12 1/1] bpf, arm64: Reject out-of-range B.cond targets
Date: Fri,  3 Jul 2026 00:07:01 -0400
Message-ID: <stable-reply-bpf-arm64-bcond-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702080757.98071-1-shung-hsi.yu@suse.com>
References: <20260702080757.98071-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 04:07:56PM +0800, Shung-Hsi Yu wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
>
> commit 48d83d94930eb4db4c93d2de44838b9455cff626 upstream.
>
> aarch64_insn_gen_cond_branch_imm() calls label_imm_common() to
> compute a 19-bit signed byte offset for a conditional branch,
> but unlike its siblings aarch64_insn_gen_branch_imm() and
> aarch64_insn_gen_comp_branch_imm(), it does not check whether
> label_imm_common() returned its out-of-range sentinel (range)
> before feeding the value to aarch64_insn_encode_immediate().

Queued up for 6.18.y and 6.12.y, thanks!

-- 
Thanks,
Sasha
