Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C01F3BAC
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787619557; cv=none; b=LWw5fukvfqZVZ6s32Zc/1muqjhk75KghcMUW29AUPiS+n8XsIA5j3Ee1O37mdAEQZiEodxRNjbUkPXQZ/DG4BC59pWDS7FcAzI2L2stAR+8lc/hVi5AE0lX39IiLBA8u2G3xMfdynOn/fVrqrG0CWqHxPsOPvxHzVRqwoK3TtrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787619557; c=relaxed/simple;
	bh=IBy30wUi9gzFj/uveVCvXOgnWB27lI4IPHYkxHE+2K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekxfix17nFMI3XgeyVxFWKMVpPu3sK+bjtAWp8yZvfmcvZyPUzRW4rGz8sAS2bNZ/P3OMUugai1OCcPUnmdt8B5Pqw7HivMe2G51wIeGJSdtpAY3WjSVvSJcaznj+LQ8qBBX0LxmxCD7dE+BUWWt6gtUkNvQBCBIgog72pLtEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXzMSRdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXzMSRdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58831F000E9;
	Tue, 25 Aug 2026 00:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787619556;
	bh=sF6qC2tATd5bpUhpJzb3ip99Px/YMCDFCjqpY5PEkp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iXzMSRdQZPivtTQznxDUbQarJOpfFFEuD9jRfEaOlO+7dy69hOUSIcyU7yzY2MhWU
	 k7G5SxB2eVFSepG8UnXkOcPXypF+gmRot0Zx/dkYNHphH7wYn+xC0iRy5tNpeRO6it
	 +rjHv/1ApvN0BDCB/Usy55dvxD+bLVkpLxFLO4BeZOIh9bKZJIQDmmaqo8y5VyruAf
	 yz189/6VY4FJpaOgSOmr/Eyysp4H5rzZGMiXdwTNjnHn75XhJcAuaG7RT9SBR2Ziyo
	 tPttE4wB074B6uyjz498IJFHzQT8zHzNBSfw4e86VG9vR6EVq8cJ7V1nxwsWEpFm65
	 4YjBBstwgsBPA==
Date: Mon, 24 Aug 2026 18:59:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: Greg KH <greg@kroah.com>, security@kernel.org, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix out-of-bounds write when receiving an
 over-long PDU
Message-ID: <aozo4lBg1fhoojdP@kbusch-mbp>
References: <2026081459-handoff-wildly-eeb5@gregkh>
 <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814194811.1581041-1-kumar.shivam43666@gmail.com>

On Fri, Aug 14, 2026 at 03:48:11PM -0400, Shivam Kumar wrote:
> nvmet_tcp_try_recv_pdu() reads a PDU header into the fixed 128-byte
> queue->pdu union, then computes the remaining payload length as
> 
> 	queue->left = hdr->hlen - queue->offset + hdgst;
> 
> and reads that many more bytes into &queue->pdu + queue->offset, without
> ever bounding the result against sizeof(queue->pdu).
> 
> A struct nvme_tcp_icreq_pdu is itself 128 bytes, exactly the size of the
> union. Once a header digest has been negotiated (hdgst = 4), a second
> ICReq passes the hlen == nvmet_tcp_pdu_size() check but yields
> queue->left = 128 - 8 + 4 = 124, so bytes 8..132 are written into the
> 128-byte buffer -- 4 bytes past its end, over queue->hdr_digest and
> queue->data_digest. Those bytes are attacker-controlled (an ICReq
> carries no digest), and the duplicate ICReq is only rejected later,
> after the overflow. A remote unauthenticated host can thus corrupt
> kernel memory adjacent to the receive buffer.
> 
> Reject any PDU whose declared length would read past the end of
> queue->pdu before the second recv.

Thanks, applied to nvme-7.3.
