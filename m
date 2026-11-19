Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104524;
	b=A47jtOTYBq1BkgNYFz/+M+BXU0z0/CnEcfZ76u61tfndGAkok3otVWsNxp40TMqwSwCL
	 jdxEnq2/+C+35F9D7bOk7fyElS+Z3orlP2We5zRcrIkYgd+roacoNCoS3rI2nrJnr1YVo
	 RQj444pZhk6buzwcaBClDy6DcmbRhl92rVkHfaINR1NqnyESYdjSVvCs0J+Xnjn9ZbzjP
	 PPz+qZHUdp9kqyTTKuCIwKO5E2cyPXH0vp5j7hNhPVol1rkgyjx/4u7v8WBDmF4/wEnAj
	 IFkNSG/CfN2NkrOEtitOAcjP9FAs1JF7mzitcRxzashiLfNB774DO7r7vS3Keygz1ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104524;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uq7izJWtg7qZlgBQZSDvD3OmuIbquVrvM90elFcDVv0=;
	b=NBbe+wLickIpT2zJKyY2bBBqDssMtPd5PT/o14ncB2wPa7JjCdazyyRc1w2l8WnbAui+
	 o+azoGlo/T02JeAeylkZcYJYhO+tyXV8YU0yHiemtNcs43kppM/HXNO4bQBV/a2Ju/xI/
	 BFWkBnbz6yvKwELa7CyZVOq1M1OO8tgZh1+kqjEgPJcFjPcupNzAKmuxj0E07VvXTPb8i
	 bj0cXzfoeic1EDY4zP6QMm79dXgrl5kaO+g5VMIUJs314kTQ/8/LNS8E6gCeAmwRzDj7C
	 S1itxzd6MfmkRvARVyHbmvPOf8+GeXk1ImKFZiSV26has1mn/PhMVBQOrGWzOtTFK6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKt2u+np;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807960A260B;
	Thu, 19 Nov 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKt2u+np
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2181F000C4;
	Thu, 19 Nov 2026 16:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104524;
	bh=uq7izJWtg7qZlgBQZSDvD3OmuIbquVrvM90elFcDVv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kKt2u+npLrU60TK9ECtoLBguwygBWdDwcGnZaErD/cGIRY8ZKKV/2gJ2L3H905ber
	 U3LFd4hsp41716XwlABfalq/6DlowKnj2TdS00V59PCwa2+2JeFwSWrdfLZ2FUBn8L
	 VizZaX2HnWF1eZhAnemPQ7r6zlvp6qo5OuebajjfNcgSWJ1rf6BtUxq1DJ0KN+gU5F
	 huyyCs6TpgLnQcCo40QTSWuCCEhCYBX3PC6/5R7APSPUSHP8GRqQThDkUYpRPx/gd4
	 /3SOTt4tAp9Zzt7AMOHe6gPaLDVXwI4WO77CRpZNkXj8OlIG1YmBae7jNmYvHjl9Ot
	 m4h/0A3fxuu6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	=?utf-8?b?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Subject: Re: [PATCH 6.12.y] Backport request: c83e2d970bae ("bpf: Add tracepoints with null-able arguments") and 6.12.y netfs_donate fix
Date: Thu, 19 Nov 2026 11:08:12 -0500
Message-ID: <2026-11-19-1-daily-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAMcAce8CPKNbO41hBv7MygO4kXZHkHogGgW7dN75qBjeFrsEjg@mail.gmail.com>
References: <CAMcAce8CPKNbO41hBv7MygO4kXZHkHogGgW7dN75qBjeFrsEjg@mail.gmail.com>
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

> In v6.12.118 (kernel/trace/bpf_trace.c:2365-2410), raw_tp_null_args[] is
> missing entries for nfsd_file_acquire (args 0, 3), nfs4_setup_sequence (arg 0),
> and btree_path_free (arg 2).

The diff edits kernel/trace/bpf_trace.c, but on 6.12 raw_tp_null_args[] lives
in kernel/bpf/btf.c, so this does not apply and the mail is not a usable patch.

Please send a proper [PATCH 6.12.y] backport of c83e2d970bae ("bpf: Add
tracepoints with null-able arguments"). The netfs_donate entry is stable-only
and would be a separate patch.

-- 
Thanks,
Sasha
