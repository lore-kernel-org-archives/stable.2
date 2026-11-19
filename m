Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104523;
	b=i5KSrkl2bSMFcHJrm2d6Bnvle2nM5L+1YVFYDvgGDhRAxwLP29omUkgN20qqRP7Puels
	 LxcSO3eKS0TPKZfSooDICMlhLE+Kx+2acZhjGW2wZ+3fuJNoIHJGxO02S9+XJY8nd4E9B
	 /YFBWRDOJAaY+XgGDCZiTsR7MJB49EW5InBOag43ZexPWbkZlehgIp9dm3LyNUB/N4YZt
	 l2ACow7Iy0V3kHuAixgKQXgdbnRomBKolRexiJhBu4qczuOnLJAmxzgl0kqFBLgRIwV7H
	 wZmS4WQtK172VDTeRN+Kq9jU0gnUrDEPUOgoaIG4ZdNzfMwWySMmBR5U47eJLYfEl7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104523;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mTY9bnZUOt9ThwvvKPosXBpIs6tF3ni53KBNNTm1a48=;
	b=TYf/wUoB468MFYybc7ISr5+jCFEwALCT5XuIe3QAGxLEqMKwLjHdJeFBLVyNUZLKOX27
	 ME+shQZ3uCz52Qty+FAWRP+C31+4fT1kiFTmhqMwUCZBAPoBQBepC5YL85KDAYxgwBPaq
	 dFMWG+Vz4VQMU/DQPQM5auvHUV12/C4/TxVuXdoDkXoUHGblhIkfhGK+LUdAQz/R5eBWT
	 xR7iAMisS1muD+GwsqU+IG4DluPi7QA5fPKrtNip/lS0iVH5b2xutBFpPLQSQnbKqfgrw
	 audpGc6G1HvIBNpH2JVtRW6SWOSFPHtXs+l+U+dHm4dJPn2xhCsHh+njuZFSpfqJT4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjSng88j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8660A2609;
	Thu, 19 Nov 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjSng88j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026611F000C5;
	Thu, 19 Nov 2026 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104523;
	bh=mTY9bnZUOt9ThwvvKPosXBpIs6tF3ni53KBNNTm1a48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjSng88jykUwE76mLql8L+qAgE77c6lqBLkbtuVoeD8R9yONvS0oQymxROZlgvFPe
	 Haqbbva3/kAoDuikA884Kfi4HvRNne06ECCRsJIFqv8uVcj5vCZbz1a4cY6KJglYPo
	 2qKmRyyx6IbZrcEvhqfF12gtjcgslzpAk2N+XCND9CO447ImoD0rD4V7vux0SQ060c
	 HUFEfjMHs9qwjsjf+fDLlgRXPe0nRtuvx/ttX/lNQl0kxFE+NktuuZsfxMi9Wq/dBF
	 HWkIK0M5lX1T0+vkyWlIBpSUwYGurSll4Vg+ZMrZeZxbzE0slL2egf6sy8VdBcorF7
	 51cXiiobDe3yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	=?utf-8?b?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Subject: Re: [PATCH 6.12.y] Backport request: 49b18315be4e ("bpf: Add NULL check for dynptr in bpf_verify_pkcs7_signature")
Date: Thu, 19 Nov 2026 11:08:11 -0500
Message-ID: <2026-11-19-1-daily-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAMcAce8eFDXx_BqjMPd-94uX5Hk4KNxkjPtRXW7wOvy_hWjAHA@mail.gmail.com>
References: <CAMcAce8eFDXx_BqjMPd-94uX5Hk4KNxkjPtRXW7wOvy_hWjAHA@mail.gmail.com>
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

> Please consider backporting upstream commit:
>
>   49b18315be4e590fae0fc39c87d46c87e9ec903c ("bpf: Add NULL check for
> dynptr in bpf_verify_pkcs7_signature")
>
> to linux-6.12.y.

Queued for 6.18, thanks.

On 6.12 bpf_verify_pkcs7_signature() lives in kernel/trace/bpf_trace.c, so
49b18315be4e ("bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature")
does not apply. Please send a [PATCH 6.12.y] backport if you want it there.

-- 
Thanks,
Sasha
