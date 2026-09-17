Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11CE4D5964
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646104; cv=none; b=m2PoEmN4aFtfEwZ9n1/QvNK2OJ6+K1yYsUf/buwznMjQuY7oqUVP9QeEpj9WaMUcgSdlvbihE+cDQnfqsC38JumjgYICJ+t0SYLI6/+V0r+3j3EG+fJ/3TJgJUCVAPPHqKeV8h5n+10YpCSYjvVa3iYMwfRpaSH6DySrv5NTXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646104; c=relaxed/simple;
	bh=bDsjIJlTaUSU+98HG36D0cIXIjCjR59ztlZKmhPyw1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVP4VB+7+mDwKHYBPVJuyg4UF2BojKeT/sLlVXjk/pbY2Gj7PgefhSsLGCjVXd71hI9LVrUu5AIHJSworAq1pmUmdDyR7yjIJ5NwnN4++NherOyT7Ge/M4nx48EKv6FIfQ66nSDD0z43JNZBTtJBNLlIRLCWVJC36GQXtcqsQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=FdWJVDo+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wy6zjV8/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FdWJVDo+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wy6zjV8/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E266A7A00FD;
	Thu, 17 Sep 2026 07:54:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 17 Sep 2026 07:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789646083; x=1789732483; bh=IPh2pPDq41
	QIGvv/WFM1GXBkYExMSyaZ/7cZxYuHXgg=; b=FdWJVDo+iy4tnCVcsRJiZVgv1g
	q3oK7tH7yC4axZ2Pae2Oubve78Les8bAZa2QI+RMtN/q98AbWy2IV1EWEtf6dvZN
	PuN68DHKRQc0o7+By2sEV6wwJkOVFh5VImx1jGzPpIpkJuetiQi0XBznq75h6UWm
	cUISPE1xB9YtX2xgvhJjUgoaesbHBYnPpmevzApFzH5LUDXnud8eytzjquu8KdN/
	s28fwlJaD/6Z7GlVVq15MpKXP1PPkgmGi/L3qUn4KkaRXnlMpabKk722zEbYSILz
	z6Fz4Qb2sprKZGfheUJbQjw2canqpKvi0pv19GEeRDiboeo6RugMc22VY++Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789646083; x=1789732483; bh=IPh2pPDq41QIGvv/WFM1GXBkYExMSyaZ/7c
	ZxYuHXgg=; b=wy6zjV8/tYHI1B4MY/0FnsbS2ACcY7NBAfp0ZQ361VCyjV2O+CA
	OzAKnwx3XeDqLHFDE/5KAMIrHMJ4uci9GWU7Ji3dOJcdq7SC24DmNEfInJR/PtgA
	oUZILFPZpV31K/7s0ra7VOkQlnciUXUk/6CiYQd5Q7cmoH2eZ0MUhOggbp2UufYC
	zXG88sGsBySrvholaBV0FVmkje6kyPqhZil5KqOG4ir1pHaaYrug0cbF/LQSqjQr
	VdF9wRy5KL2wVob9n1KLn2PgHJt/XGtpkYGDNEh2bMOEyEB7Ng55zcllzoAWx1TE
	SioBr9FclTrOq1/I92xB15ew2h3twZ26KBg==
X-ME-Sender: <xms:A9WrasVKQjGf6FiTVMfjvfUphewhrK-bMSKk45-ArOS6_6L29JruQg>
    <xme:A9Wraqnx68BL6Bs6XWjl28WdfjVHehmGGu-Xq3bZjECadmlDixHXjx9sSRm57aHdn
    TM7TWDf5ZUGJ-Dp2AchI6BlLGfQ2-mMIa4a3w4gCVX66mx39a0>
X-ME-Received: <xmr:A9WranBJnp3NZmTN9dIqvX19IX0TcxddQwCg8tJDEpPHfDf9yt3_qZTA_8U7>
X-ME-Proxy-Cause: dmFkZTEQ5oUVH/+6iniP7mPqMrhqRHb7JlTu/s/7qMJxqovoHjZ2vIv9mMD7xpVFV/Ohlo
    9WvUY5hXCSmPTix0/nTItiYgNjlgxMFYxNWFHZ8obVimyO9K2tCuPsmykHWaC8QA0NFfL9
    sNrzRn9TLuf+ijajzVmiNGkI5WO3mVsVZIoC67i+nEciXDsbCpd/XK7SSCDSP5clAvHSOh
    F5BAwoyNsocY0DNDfk6dM3lRZx9AtFtuEtuvj45lfUQiFPBV1qHMaZ3PFo323BZlxcsG2H
    mZQmyWn4qeB1PpiSCPxgmldbkn8/1kexYJG/i+0cdX+7MgBdzYXuwi0CGhZy9QKbSbxsg9
    2oS+L0NpRpT2TqL/WnlEMpcnwiWSpfkdfuAeEsJPdfuBNpKoM2rGpHSzZosaJW35AsjRUg
    1mEysqU7WJu9mvmQ1Q1JzFoSSxN4CHO/QF8ogsbwZClWvtHOsL0qFS+tLnH81BHMdCWARg
    SShhaM5hF/L0MtYdPQ8yzv83495McrgcIG/N7Hv1R0FvO2zU6014N/y/+VJ+HOjbqXGE/I
    8l7Sj8IfGwgJH8qqPM1Ih9LLr/KvnPrTTkxjKAtupl2LJA3X0zy3rRDlB93Ggsq9Hpu2/4
    8WsbmfhfzeCxGVG9BdYoyhhRjNlzVcKrSUSXA3aqIotNAufbXUhp8uRTyDxg
X-ME-Proxy: <xmx:A9WrapjiVwalJUrwEdNLWAHNsuDfoAD5exGLFtFbETU4Qc1qXIavjw>
    <xmx:A9Wrakxb49-T-lW_BPAUYAXUWC-ZX3vAf1SEUIggkzsjvMT-q4RR6g>
    <xmx:A9Wraq0HmNxlXppAPM4wxOhuQnL5HJgQoojnku8OBE2y-wEHR6yfUw>
    <xmx:A9Wrap-HOiT2_gbwXIZ0qw8H9OVGf6AnI2A323L6yo-I9viue0TjrA>
    <xmx:A9WrauPLkq_cJzTewf5Bk0_DxH2Mt4y9hD68T9TFsD4fzH5rL0mDGCmJ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 07:54:42 -0400 (EDT)
Date: Thu, 17 Sep 2026 12:51:34 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.12.y 2/2] svcrdma: Clear sc_cm_id when ADDR_CHANGE
 replacement fails
Message-ID: <2026091730-footsore-facecloth-ed76@gregkh>
References: <2026090326-unclamped-ecosphere-df9a@gregkh>
 <20260909003624.747050-1-sashal@kernel.org>
 <20260909003624.747050-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909003624.747050-2-sashal@kernel.org>

On Tue, Sep 08, 2026 at 08:36:24PM -0400, Sasha Levin wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> [ Upstream commit 01500306e1d50de7ca7a2cdcdfa28ac0523eb747 ]
> 
> When svc_rdma_listen_handler() handles RDMA_CM_EVENT_ADDR_CHANGE,
> it creates a replacement listener cm_id and returns 1, telling
> the CM core to destroy the old one. If the replacement allocation
> fails, sc_cm_id still points at the old cm_id that the CM core is
> about to destroy. Any subsequent dereference of sc_cm_id --
> such as svc_rdma_detach()'s rdma_disconnect() call -- is a
> use-after-free.
> 
> NULL sc_cm_id on the failure path and guard svc_rdma_detach()'s
> rdma_disconnect() call against NULL so that the listener can
> be torn down safely when the server shuts down.
> 
> Fixes: d1b586e75ec6 ("svcrdma: Handle ADDR_CHANGE CM event properly")
> Cc: stable@vger.kernel.org
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-5-1b09bd87b6cd@oracle.com
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> [ added the missing sc_cm_id NULL guard to the existing __svc_rdma_free() cleanup worker. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index c8d994272f6f0..aa02c47ae5734 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -311,6 +311,7 @@ static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
>  		if (IS_ERR(listen_id)) {
>  			pr_err("Listener dead, address change failed for device %s\n",
>  				cma_id->device->name);
> +			cma_xprt->sc_cm_id = NULL;
>  		} else
>  			cma_xprt->sc_cm_id = listen_id;
>  		return 1;
> @@ -610,14 +611,20 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
>  	struct svcxprt_rdma *rdma =
>  		container_of(xprt, struct svcxprt_rdma, sc_xprt);
>  
> -	rdma_disconnect(rdma->sc_cm_id);
> +	if (rdma->sc_cm_id)
> +		rdma_disconnect(rdma->sc_cm_id);
>  }
>  
>  static void __svc_rdma_free(struct work_struct *work)
>  {
>  	struct svcxprt_rdma *rdma =
>  		container_of(work, struct svcxprt_rdma, sc_work);
> -	struct ib_device *device = rdma->sc_cm_id->device;
> +	struct ib_device *device;
> +
> +	if (!rdma->sc_cm_id)
> +		goto out_free;
> +
> +	device = rdma->sc_cm_id->device;
>  
>  	/* This blocks until the Completion Queues are empty */
>  	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
> @@ -648,6 +655,7 @@ static void __svc_rdma_free(struct work_struct *work)
>  
>  	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
>  		rpcrdma_rn_unregister(device, &rdma->sc_rn);
> +out_free:
>  	kfree(rdma);
>  }
>  
> -- 
> 2.53.0
> 
> 

does not apply :(
