Received: from mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B952CCE6
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877041; cv=none; b=SRZOSblgp8AjeWEVpDDqQG+81f0pphY67H1KBmIR9nygTNi9NKZ1Q2laIxhNlzcDFQS3t1FCGxVMmxFriaIYLuuTld88kYft5Rua4dO/ISagem8z0vpDg1zPKHAbnCtBu3IBqmraQjqqNzJvYBq7m+RGmXwYPfJ7HI9dFyrb0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877041; c=relaxed/simple;
	bh=5qZRzE2q0bC/tB2+khGBe/7kTI+CJ+9jMEj2xjkmVhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC3NAASITLALVh+dY8KLwC2EocEl8fE86I4bewEmtTAyHdxnIsV5GR4zoT605phL2hFRhueKhTObr9HFl/KcnBLTyQheTjLjVS0cKLt3r+oitVFnEgFUXPzwRY1Wij9TmMWejeFGAzv3XKkrD9ktwvGmutMzLqnAnAO4IgmztOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q+kq4dPs; arc=none smtp.client-ip=95.215.58.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q+kq4dPs"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5qZRzE2q0bC/tB2+khGBe/7kTI+CJ+9jMEj2xjkmVhw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790877032; v=1; x=1791481832;
 b=q+kq4dPs7L12HtbGoBspJ2GlWa28bZM64sO4shCLczBr7UlM/nkF4byYEQCiAZkv6Ytce/1x
 FNbvuT5jfvX/WKFmrRWRnDjZC5wwHfIZCNIGyiNBnO9YpMenPL0yLHF0Tigjo1w4ayOCV/rGefq
 wOZT7/RFzvwrlHen3ooK/eHQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c97e4dad9acc5470;
	Thu, 01 Oct 2026 17:50:31 +0000
X-Mizu-Trace-ID: c97e4dad9acc5470
X-Migadu-Flow: FLOW_OUT
Message-ID: <9977c651-2e54-4f94-b971-e9929351a06e@linux.dev>
Date: Thu, 1 Oct 2026 10:50:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/rxe: bound the WQE opcode before indexing
 rxe_wr_opcode_info[]
To: Youngsung Ahn <ays511.kr@gmail.com>
Cc: linux-rdma@vger.kernel.org, stable@vger.kernel.org
References: <20260930180221.2497908-1-ays511.kr@gmail.com>
 <20261001152407.3259261-1-ays511.kr@gmail.com>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20261001152407.3259261-1-ays511.kr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/10/1 8:24, Youngsung Ahn 写道:
> wr_opcode_mask() indexes the global rxe_wr_opcode_info[] array with
> a caller-supplied opcode and no bounds check. For a user QP the WQE
> comes from an mmap'd SQ ring, so wqe->wr.opcode is an
> attacker-controlled __u32 read back by the requester
> (req_next_wqe() -> rxe_requester()); rxe_post_send() takes the
> qp->is_user branch and never runs validate_send_wr(), whose only
> opcode check is itself !wr_opcode_mask() (it indexes before it
> checks). rxe_wr_opcode_info[] has entries only up to IB_WR_REG_MR,
> so an out-of-range opcode reads out of bounds and the result is used
> as a mask and dereferenced; observed as a KASAN global-out-of-bounds
> "Read of size 4" and a wild-pointer oops.
> 
> Return a zero mask for an out-of-range opcode, matching how
> validate_send_wr() already treats a zero mask (an invalid WR), so no
> path indexes the array out of bounds.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Youngsung Ahn <ays511.kr@gmail.com>
> Assisted-by: LLM
> ---
> Notes (not part of the commit):
> Reproduced on a KASAN x86-64 build of 7.3-rc4 as uid 1000. Present unchanged
> in mainline 551c722f4080 (2026-09-29) and rdma for-next. Compile-tested
> (KASAN+RDMA_RXE), not runtime-tested. Per security-bugs.rst this is public and
> a reproducer can be shared on request. IB_WR_REG_MR is the highest index the
> array initializes; an ARRAY_SIZE(rxe_wr_opcode_info) bound would be equivalent
> but the array is extern to this header.

The function wr_opcode_mask() is used in the following three functions:
"
validate_send_wr()
req_retry()
req_next_wqe()
"

In validate_send_wr() and req_next_wqe(), if wr_opcode_mask() returns 0, 
it is relatively clear from the surrounding code how the invalid opcode 
is handled.

However, for req_retry(), it is less clear to me what the subsequent 
control flow is when wr_opcode_mask() returns 0. In particular, I would 
like to understand whether returning 0 for an out-of-range opcode is 
sufficient to safely handle the invalid WQE in this path.

You mentioned that you were able to reproduce the issue on your local 
host. Would you be able to share the reproducer with us? It would help 
us better understand the failure path and verify the fix, especially for 
the req_retry() case.

Also, please follow Leon's advice and send v2 as a standalone patch.

Thanks a lot.
Yanjun Zhu

> 
> v2: no code change. The irregular indentation in v1 was email mangling (HTML),
> not a coding-style problem -- as Willy Tarreau noted on the ODP thread; resent
> as plain text with tabs preserved via git send-email. Added Cc: stable, fixed
> the author/Signed-off-by match, and added Assisted-by: LLM.
> 
>   drivers/infiniband/sw/rxe/rxe_loc.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 64d636bf80fd..dcc0788db90a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -184,6 +184,9 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
> 
>   static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
>   {
> +	if (unlikely(opcode < 0 || opcode > IB_WR_REG_MR))
> +		return 0;
> +
>   	return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
>   }
> 
> --
> 2.43.0

