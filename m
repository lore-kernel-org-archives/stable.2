Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096502;
	b=cZdV/GjnXV3Dc8xb5UIUYBWsPyYE20MNC/0KL7XvkHEH2+Wh7T4Vb4qRY+9xUzaU/UtU
	 uS665YZJE8RSuzu5ilkG4XHPO7f0vyrrdO2ZcVcQKBne7mRmkREmDq/p0yqRAW86862eN
	 dlR4PTUUXXQUVZDa6Zcb24EwH12+SJQ2r2lMxF1VEg28mH5gGV6eh1Ok96NGEnh9DsL/w
	 NdlsBgU9TxyfYTIaXzsVQ7OSpyNGj1BrRieENhEps2qRnS3W69X2PLKmIVGQxYauZDA5y
	 gDUMofehH73cM3aJeAA9TMFSXk3ce5iWy1LPaO7QEqiYHB2y09sPKWLw5Km8GpJ78dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096502;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ZGEipZ4iBR2zaM8nIfLYPQOtXWPI6XNJ5IhWI9P6vEU=;
	b=qyVOKuLQn4FAxGfmkMVfRMI2kBTrgrcrfaDEPHRjbwPVHq9oEyoaZDLOl/n1GDCHBk6P
	 KD6nRRMCX6zHuQD9cEczj+anUMy3rOLKgUUi3fdN5MKXehXVARlqdAPvLESmpl7MuX2oY
	 7FKoiXd15ZxWz4rz/3EBcRoSUhFp04otJLrCFkN3ITo0tAcKrIsk7gm7c5TAzsaAfl9As
	 nldm+haPK2cWFoNavl4uNwmvqEqcUzY4GxZWeH/QYpx7IaNrwhI2ncVdbVoMbHC1zFauP
	 YO7I+OQmPwesN2hUk7HcJBX3AqMdZVPMZgKxh/oWVyEDVJMOLBfJg1RH7bRFdVejSLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQRbLvoI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC1606A324;
	Thu, 19 Nov 2026 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQRbLvoI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653D81F000C4;
	Thu, 19 Nov 2026 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096502;
	bh=ZGEipZ4iBR2zaM8nIfLYPQOtXWPI6XNJ5IhWI9P6vEU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QQRbLvoIJinWyRQldOtBxVUdCVpyfbzWr90u5YSTrgn3k4N0dht0N6J6uzl7BuWP+
	 avKZHcSvJsw3LZlDI0YRqvZqG/htWdzznUrrOI4v0ft+ESHJTQB87CfthYhIh0OlYd
	 bG2KBnZ0ryNxjMo0A/CmNl2cCf3PLkS4A1NbzFGpTaJ0Cn1VIy1PzJhJQrgh3w54E8
	 EJQVu73lMMQQ/hB3pX8Jtel1vvmdiXQlEqCSLoaN5qupBXZx22PejDrynJUi2Q/8nT
	 SQ58ywjic2yLCM4xpxsP50+vTxvf1feT0vV3sftjwgoBcrPz4s65OKp44AncqKH+58
	 yvMXJtXXDYhRw==
Content-Type: multipart/mixed; boundary="===============0493837293160669566=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9a5a1487a4676381f4c3d98cb5a22f50e2f54d9d4ec7947891c889b64ac12693@mail.kernel.org>
In-Reply-To: <20261119133032.2015656-4-sst@poczta.fm>
References: <20261119133032.2015656-4-sst@poczta.fm>
Subject: Re: [PATCH v7 bpf 3/5] veth: use the frame mem type when running XDP on an xdp_frame
From: bot+bpf-ci@kernel.org
To: sst@poczta.fm,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,maciej.fijalkowski@intel.com,tianyi@cloudflare.com,tavip@google.com,toke@redhat.com,aleksander.lobakin@intel.com,ilias.apalodimas@linaro.org,lorenzo@kernel.org,magnus.karlsson@intel.com,ihor.solodrai@linux.dev,edumazet@kernel.org,pabeni@redhat.com,andrew+netdev@lunn.ch,horms@kernel.org,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,sst@poczta.fm,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 19 Nov 2026 13:54:58 +0000 (UTC)

--===============0493837293160669566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> veth: use the frame mem type when running XDP on an xdp_frame

TL;DR: Commit message only: the Fixes: tag (718a18a0c8a6) looks wrong, since
it only touches the skb path; the review suggests naming the commit that
introduced the stale rxq mem type problem.

> veth: use the frame mem type when running XDP on an xdp_frame
>
> veth_xdp_rcv_one() runs the XDP program on frames queued by
> ndo_xdp_xmit(), i.e. redirected to veth or sent back by the peer with
> XDP_TX. The xdp_buff points at rq->xdp_rxq, whose mem type is whatever
> the previous packet left there: the queue's MEM_TYPE_PAGE_SHARED, or
> the type of an earlier frame or skb. frame->mem_type is copied in only
> for XDP_TX and XDP_REDIRECT, after the program has run.
> bpf_xdp_adjust_tail() and bpf_xdp_pull_data() release whole frags with
> the rxq mem type.
[ ... ]
> Set the rxq mem type from the frame before running the program, as
> cpumap and devmap do, and drop the now redundant updates in the XDP_TX
> and XDP_REDIRECT paths.
[ ... ]
> Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>

Is this Fixes: tag pointing at the right commit?

718a18a0c8a6 only reworks the skb path (veth_xdp_rcv_skb() and
veth_convert_skb_to_xdp_buff()), and does not touch veth_xdp_rcv_one(),
which is the only function this patch changes.

The stale rxq mem type on the xdp_frame path comes from the
XDP_TX/XDP_REDIRECT-only "xdp->rxq->mem = frame->mem" assignments, which
predate that commit and were added by d1396004dd86 ("veth: Add XDP TX and
REDIRECT").

The stale type only becomes harmful once frag release uses the rxq mem type,
which happened in bf25146a5595 for bpf_xdp_adjust_tail() and in 4dce1a0d7cf3
for bpf_xdp_pull_data().

Could the tag be changed to name the commit that actually introduced the
problem?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44535627869
--===============0493837293160669566==--
