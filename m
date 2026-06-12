Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A993DEAD7
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267978; cv=pass; b=sFyhUbrT7vVUc+TcK/81CwzGnHlWohXXdipRkJtqF8T9mZGaNa0WK7TmPsucZz6zCMvC6MgtyL/EfAxVtjTcomrpBHenZlfT9kxA5YytPMc1aAxImyPNbMMVr8Gv++kR7UU3EMwzf/+ZesrN40ANC1yANIZ6ShmF+DQKnwBV5zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267978; c=relaxed/simple;
	bh=r2fdDj0/BkEr+P6BAfJ9Q5rQxtdCtewNTe5fNz1w9g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtQV8uPNX9lvTLDIMXWdU4yEA6jmzpzYCJaSWNAY/aeeS1Z1ooBPFYp2klKBpSMEg77MowhEn+xqoYXM2bgTrIgMrl6kXV96A+JYhkIZm/YdBPmK6CRQ05CG31F+RXRt/UBi6ocvQdL88m5hsDLCGb5RpAvmswBQUtk9RuM62FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GZwGc796; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GZwGc796"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-396bed274b9so8840191fa.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 05:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781267974; cv=none;
        d=google.com; s=arc-20240605;
        b=YtbNlwEb+KNG2Cy3VD+hElDhLampoKNeLKK5tjNL+dG+g7vE8jmdHchUeK/6VLU/WS
         +LhhG77I3p3QCOKReZKH6lkQ5oJCdl9DGozoMAsDjnDiwa/9CjJsfFn8fDk5lAoz9R2/
         02g1vYwpC0Re5fFyx3b3EVa8PR1clyu/5vZua/2QC/QEcGjSFQiraKZIWGPgYz4l0wl8
         LxO5wlp7Ggx26cpii/9dAPmo7bXZ72iJEHal90TWnAEAtL/FSJHZD6tyrbIO+x69NiM2
         ZhngYmHIxdkJ4w3VSNuj5YYBqXOKR3TnQdXP3YMIoW/yIOXlYe2XUxYWGHl6VreBtpBq
         LNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=61AMVtU6oLpUm/BQhOmCZGzPwVVVsT8h8unaKjzD1K8=;
        fh=Gonx4mz0VdGbGwJonie7Psm/Q6m+N/OASBpOL/R7+nk=;
        b=VcqodDeMHNiU8m2VPVawYJ36nfOHRsgMmggn0tP3w3K/G6QLsEawW4KQkCULr16P3q
         Gt4IKnJCh3Dl2TbrdZCxAvDXnjbEbdji/5aQkJ10JlVghH1d9MRgeT9TcpasPSTlyu5z
         Ys464xsb6qBwZXsUihRzUjjRNxm7zir8+5tKMePDgsWVeeHY45emb+zJN2ULXX26JPOv
         bNcJC7HYTYYcotOvphI6PlstCb3luAY51U330IkFYvLhq1wc6Mmz8lSDoBtaamkbuZPR
         Iy2V6ZpuZ7yVVphk+0hKcAHXCmTNQQ3Q6KuA9JpVctGBVB/9lxEfp5nEDXdg3cqsICpg
         PKdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781267974; x=1781872774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61AMVtU6oLpUm/BQhOmCZGzPwVVVsT8h8unaKjzD1K8=;
        b=GZwGc796kBTTSrHCxNwRE8h17LBGwYvfZz5IR6p8c/J4XZnjOsJY8IiV0WDVke0WbU
         yHcEmzYVheUJBWlvzhJR20RAUXmFkNiBwm8h5zCp1El+HjhUYPnzRZUkWsxJ3HfbJZ3g
         5hb7o8byTLgMHT4umhcn1IlkEJb7sQZ68XmP4vd1fTTK16EcG3OpoH7oPt40S0NLzJaf
         NZPvIez9FNBZG+uvWHDqU2Knz/dPOQHizWqG6L962fbFA+NC3bQn42vP23pZnv4GJuHZ
         /s0aRwmRS8Y37EHmmWMZVOglUXV6+dQc5PE0moddTAMDuOLgpQOumNDcQClv3vViTjNj
         /peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781267974; x=1781872774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61AMVtU6oLpUm/BQhOmCZGzPwVVVsT8h8unaKjzD1K8=;
        b=FJRnCxth6mnzRHY21yn/dDtGvyYAY3u3lWZZJFWDEo913YAzoiY7g7x2vmKTgXmfQI
         VNnqpYxtKYnSKlqjwk3PLjSVaEp1Z6sSQM+cWJArbt0I7mTleiJIFYhvr87xydJMSGqV
         PNGfT0LVd6ajXhWe5P9lAR6uKKkO3oAzWdeMUwvnHysebKtAY/FxGLclolL9+FoNZNXb
         zwujB1qwR0+P3IQYOMvQJsLCCzIYWCKPWnm9miZGklR9/C1/7zKyg1UbR5XDDBsF6IAR
         JHX/wnQviJtP+wteIpEDexUr7jmSU/3c0q35MFmjUBDCR4+7qLpYl4vnp8wg/UNxDOhC
         ac6A==
X-Forwarded-Encrypted: i=1; AFNElJ82JLgGW1mGiyKp4VbSZITbmtU7Y0psT3hUnSG2SfMKvH9M5Qq/ZoA09i2rX+iTbCakrYnUNiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rUgP45UBfw4NHvy/oDcvO+i84h/3eUXzmH9u5qmrYnM6pe3z
	Epuy5YvLI/fwGMhTNyw/AiRJx1hbffIcEnc3ahG0gHiSJPTaZf36SFcWOfQSZYjKM99Z4zd8WyA
	lAFUHyBYyO62QvbJvrsvdktua+imzkzCnOxhtB0FUHA==
X-Gm-Gg: Acq92OGf9cxE7ZEGowatT/djw164dtDGl5JFNQNMPa1eef+sfuH8mO0cuIpYQTI/uXf
	xaYnZ4SXASmSKz19R6RHktnEzxfgms6rER9w08HOhTySRJDIwVve1yvOhLuu0f7n64zzKbm8O8z
	jXpAWZZJHoyXIvShab9HMiLMtK2O5PNCBulvnsMm57lYFscF1SCyJRPAbZMWqN8Ay6bTWIrRNOp
	wgaoHkdb80OmdNnNuT2pyKfYZ6YtLoKaYvdblIyS7MwKkr8BNhct/PJquDs0hQ3j/Ag/sFzmDPX
	i3zsmEzw8c0La7rPJtkyyw8XKAxbzFXPvW+TlFfXiHxC6I3vNvveEd1Sv5qutJokJ7dg
X-Received: by 2002:ac2:5632:0:b0:5aa:6c57:32c6 with SMTP id
 2adb3069b0e04-5ad2db1e479mr635970e87.17.1781267973946; Fri, 12 Jun 2026
 05:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-master-v1-1-70cde5c6fdc9@gmail.com>
In-Reply-To: <20260612-master-v1-1-70cde5c6fdc9@gmail.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 12 Jun 2026 14:39:22 +0200
X-Gm-Features: AVVi8Cf1ZgRl8fAik84-gu83jr0ddYKJixeZyFQ48Kd-1UN8I2bJVg8YEnHSUZI
Message-ID: <CAJpMwyiOcvz1XoVpdEZ6h1zdizkKBmsfnrnnb3LGziNv51q1KA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in rdma_write_sg
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Danil Kipnis <danil.kipnis@cloud.ionos.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 7:18=E2=80=AFPM Zhenhao Wan <whi4ed0g@gmail.com> wr=
ote:
>
> When the server answers an RTRS READ, rdma_write_sg() builds the source
> scatter/gather entry for the IB_WR_RDMA_WRITE that returns data to the
> peer. Its length is taken directly from the wire descriptor:
>
>   plist->length =3D le32_to_cpu(id->rd_msg->desc[0].len);
>
> rd_msg points into the chunk buffer that the remote peer filled via
> RDMA-WRITE-WITH-IMM (rtrs_srv_rdma_done() -> process_io_req() ->
> process_read()), so desc[0].len is attacker-controlled and, before this
> change, was only rejected when zero. The source address is the fixed
> chunk start (dma_addr[msg_id]) and the source lkey is the PD-wide
> local_dma_lkey, which is not tied to the chunk's MR mapping, so the verbs
> layer does not constrain the transfer length to max_chunk_size. msg_id
> and off are bounded against queue_depth and max_chunk_size in
> rtrs_srv_rdma_done(), but desc[0].len is a separate field that was not
> checked against the chunk size.
>
> A peer that advertises desc[0].len larger than max_chunk_size can make
> the posted RDMA write read past the chunk's mapped region. The resulting
> behaviour depends on the IOMMU configuration: with no IOMMU or in
> passthrough mode the read may extend into memory adjacent to the chunk
> and be returned to the peer, which can disclose host memory; with a
> translating IOMMU the out-of-range access is expected to fault and abort
> the connection. In either case the transfer exceeds what the protocol
> permits and is driven by a remote peer.
>
> Reject a descriptor length above max_chunk_size, mirroring the existing
> off >=3D max_chunk_size bound in rtrs_srv_rdma_done(). Legitimate clients
> do not exceed it: the client sets desc[0].len to its MR length, which is
> capped at the negotiated max_io_size (max_chunk_size - MAX_HDR_SIZE).
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>

Looks good.
Reviewed and tested.

Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/=
ulp/rtrs/rtrs-srv.c
> index 6482ad859bd1..f81e122a3ccb 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -225,8 +225,9 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
>         /* WR will fail with length error
>          * if this is 0
>          */
> -       if (plist->length =3D=3D 0) {
> -               rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
> +       if (plist->length =3D=3D 0 || plist->length > max_chunk_size) {
> +               rtrs_err(s, "Invalid RDMA-Write sg list length %u\n",
> +                        plist->length);
>                 return -EINVAL;
>         }
>
>
> ---
> base-commit: a48671671df5158a0b8e564cd509e04a090a941b
> change-id: 20260612-master-7cbc156da1f8
>
> Best regards,
> --
> Zhenhao Wan <whi4ed0g@gmail.com>
>
