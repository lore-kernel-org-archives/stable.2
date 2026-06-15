Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD773BAD94
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563900; cv=none; b=g2FwdnlRtmdHGumbT+jQjnohbTE39hCT6jdchOWHHXba1+gUdLFpO8wjKwUOO8dWRcjIKHvC6RJFjDpxhzb19/0Eep+mwnStkg544PpRWK0hkK+4ond4HKt6f+okZIbJLLRZjpBglOrNo/0pjiECX3vhSOK55LiBidxtgPzXUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563900; c=relaxed/simple;
	bh=ujAjSm7BhxUMJVslQmleewg+/DVfcJZ1Gp/kz42YP3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAYY2tB2cQbt3AI7xE5oLDGRVPFA11icN1dO8P2fBb88h1HHdSDabRNVp50ouqUEZGQ7L2/euInCCyClxGHuWlUgYCojswvptaiuYrxArW9i5RJCF+lqQ2+IFl8ee0CoQLDBjGIEO4JXlmyDXXq/TbjSX+Mz6qsLIrY361gNVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJnI8+oY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJnI8+oY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cdae130cso19000695e9.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781563898; x=1782168698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaij0ssiVLSTJF7l7+mwMdVljWqS/GPd6aqJhzAQirw=;
        b=jJnI8+oYnPGKCz46aKZOuPWQYTSJIPRsolTSYqKCWQAgDyxI1SUBQmqFPHVks2+TpB
         4iXUTu4TTtWwNv9roSa/ClXgKgXKToEWTkT5BT1YsaXY0a0ggqk0Itry41UPBWBcZx0C
         j6EyCnwFF4AW2Picfnn1NUNOzYJyfPmMqXugAScEXFMIGSbi/W1/C78bkBUiTLVluXcf
         u3FhIRglS783WShkExW2P+uIZbMqLgPGCGcUvPcfBSc0F26elNnxjbXSnVXwPr7BoKts
         aM1OlsjHoXBbJqJG5ZNbuq1j4NVigLqHwX44DiwSdmYm6d8mC17tDemNvS19f5Gnx132
         n6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781563898; x=1782168698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaij0ssiVLSTJF7l7+mwMdVljWqS/GPd6aqJhzAQirw=;
        b=S6XIxs2wVyQMYUo3ueH3go7eRHkqWsh5deNhtDo4DAYlIzCFwf3YMW5t2albK8WdUB
         J7aozlf0g6e8IDdllOg3XCLRV7ra+qc283qB2oZ17rPDPTRUwMaFP2GWcAkuViWkdY8z
         16JeQiHITFrgz7fsEQ/S77sczgpz4F77B/t7QcudNL+JlzHZuN7pEqWSMG8TzNwcvvoQ
         mN76d5I0rQsAtp3cwFdogcRsfjkW3JCXRAc6Tq/CxD3dds1gyQvFs6vPO4yPkB+UJAMK
         1Tl+rw6aDmTVhQmGlNV2Nk8MsPrpzZ6QJrTz62KAEbbhPJhQlxctdcpvVacn4s3f0rkO
         xQKA==
X-Forwarded-Encrypted: i=1; AFNElJ+DoldPmpp6v2u1VPoF6sUDdfsmJupSCx5FSeKT/qvGGxW1Fw4VTknII74RM5VSywzJX9W64Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRldJWziaktdHxR99tNXvWk1cRXbJ1zdsPGC/MiJ68IBJA1fk
	DisRaq4OwWc7sUQxFPP3nLfcJpDK0NwQKo4dHKG5oHAdg1xg/bi4V/cl
X-Gm-Gg: Acq92OGSxr0JV+HKX+vFKO+XO1XmUga0+4/S77DHym+iYzhFjLnHfjakc5hc7QmCpuV
	qDsjlk/RRkgXuZnOvP5REGKIcc08SyQDKvz3mySkT/foqcwO9bzWtIW70Njth7o9faU+q0mjZK3
	p/4uVATyFDU2vh5CVc9QbpoQKlZWPZBJpHA67Z6Pu2BCLTTAcbb3hE7Kj8G4xqZAUZvWLoHlrsc
	94ghjHn6dbhQeOX8avZmtE0sYoIoF+juLCyciUGbWIbbjlW6/+KqQO0OLaSycR28tn8DGHi+lJ2
	l2yKisWwgrLg81NhD+yT6tx1ENfvY20s8nL+P2fzkWqQb63pQV4gpzau2kALGx5oWh6dzsetuDM
	lUOZf5/NufRgij4LKVzUzMBmb/WB8XhlRvLYA1CmYjpWr8Pw4zEmNmwkrCiPSZSKCjiQpXsm6t0
	gRn2g74PKYJ8Vb6YBYHDYplE8rQQ3XRZRxSPa2xg21cl9b3vLuhNoJadeqPa7PKdErnXtck3tDU
	R0PfSakfNy8CZR74s9tHclgI1FvvOyGRFhr8RLMsXLcW0BAQJtFC2wpX0cKx8mOYi8Z/swouzD1
	OLR6gDYeKVaHDAxZl2mouZVmMU33KYbhXmh1j7cI9/0=
X-Received: by 2002:a05:600c:3b02:b0:492:2f3c:d0ed with SMTP id 5b1f17b1804b1-4922f3cd1a2mr28492865e9.30.1781563897718;
        Mon, 15 Jun 2026 15:51:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009a0d3db09e2f2ffb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9a0d:3db0:9e2f:2ffb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cd6c2sm38392917f8f.30.2026.06.15.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:51:36 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:51:34 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com,
	eddyz87@gmail.com, shung-hsi.yu@suse.com, stable@vger.kernel.org,
	mykolal@fb.com, tamird@kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6.y v3 0/4] bpf: linked scalar precision fixes
Message-ID: <ajCB9jXBzPyaDNSQ@mail.gmail.com>
References: <cover.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781194510.git.jt26wzz@gmail.com>

On Mon, Jun 15, 2026 at 12:58:37AM +0800, Zhenzhong Wu wrote:
> Hi,
> 
> This v3 targets 6.6.y and changes the backport strategy based on review
> feedback on v2.

[...]

> Relevant QEMU selftest results on 6.6.y with this backport:
> 
>   verifier_scalar_ids passed all 18 subtests, including the newly
>   backported linked-scalar precision tests and the related
>   check_ids_in_regsafe tests.

The first patch in this backport series is actually breaking the
"precise: test 1" selftest from test_verifier. You can see the full
error at [1]. I haven't yet checked if it's the test or the backport
that needs to be adjusted.

1: https://github.com/shunghsiyu/libbpf/actions/runs/27575831217/job/81523786835

> 
> Thanks to Shung-Hsi Yu for reviewing v2 and suggesting the upstream
> linked-scalar precision series as the preferred backport direction.
> 
> Eduard Zingerman (4):
>   bpf: Track equal scalars history on per-instruction level
>   bpf: Remove mark_precise_scalar_ids()
>   selftests/bpf: Tests for per-insn sync_linked_regs() precision
>     tracking
>   selftests/bpf: Update comments find_equal_scalars->sync_linked_regs
> 
>  include/linux/bpf_verifier.h                  |   4 +
>  kernel/bpf/verifier.c                         | 367 +++++++++++-------
>  .../selftests/bpf/progs/verifier_scalar_ids.c | 253 ++++++++----
>  .../selftests/bpf/progs/verifier_spill_fill.c |   4 +-
>  .../bpf/progs/verifier_subprog_precision.c    |   2 +-
>  .../testing/selftests/bpf/verifier/precise.c  |   2 +-
>  6 files changed, 417 insertions(+), 215 deletions(-)
> 
> 
> base-commit: 924b4a879cbb75aef37c160b955b92f6894b11a4
> -- 
> 2.43.0
