Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9764334C4
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583077; cv=none; b=QWLuCUAmhdWuvHTtYgcDu3TcvFGL1Ob/SEeWnBR67euTQnRywpvUjXpPwHvWx91qq/aOV7chEo+NRejgzJ0YJSN1r6gd322b3i+VcN3JsBtJdoStevVU+pbiJ0lkkJzdpBvynxzc9bPsOkgx+ONwLAEp3TKrUuhU8MbfVSr0JeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583077; c=relaxed/simple;
	bh=uw3PemJoWLmDD2Q5S4K4vpD1Q3NYpGFLLIXFxU6ZYms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHx2PgwzF9ftH1Y2bMIhCcDYUJJu4SP9R6dSAuKT/M43o8iNdC/kTN9AnAH2N9p2d79HvGKjyjpHBDG/mEteY435ytD0nq43CJPRRwu2k8g62+gNu01HM7VOPXdG0+9IfiqKQtVgg/Q4V5SQg0FCA6G2yTi5iVmCFlkbxzS5Qro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=MSzF3H9X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jfFZf7mu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="MSzF3H9X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jfFZf7mu"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8AE1F140013D
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:57:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 09 Oct 2026 17:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791583071;
	 x=1791669471; bh=j3pmpMKIksdiFb408Pu2EBX9DRrS9ls+nKH/cQmC9Mo=; b=
	MSzF3H9XS1iduwGuOP8FCFXWbpF51BG64Mrva4SiUwJx78tZx9I+bCsbeDYbGrP3
	H6w6p37exgI8GG65MMZQPWHaeNwYo5AiQ5dWuJOQxa0JrU0ThTQWXos3DiC8sHzQ
	RyAFBfZmZ3rw6u1s4Lzg9jlfr8tyi1q/IF28gHZtSAERJNBTVp6kpXNjZ99Tde9k
	fyC84xn2UQ4rT6HNz+L/1XRbnKXebwpV0oyo0bWbioJpwg42apJyMiLVMU9Lpycs
	PaoXoXUiQfzSlHAoxQLySkya1+wHbqnNwGirU2kVcsfA/fWSuV4FwbxPJ/tmCOes
	64iWzMs3sT6UpSowuXotXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791583071; x=
	1791669471; bh=j3pmpMKIksdiFb408Pu2EBX9DRrS9ls+nKH/cQmC9Mo=; b=j
	fFZf7mu4bCYBsKNjujYebQiZhx2nbYh+6nBPZpGtoY9Gp21UG9joy0NNLgTgnAUh
	H7mtBrbHDF7txAP1xL+Ds7oRDrkSy5dz991RpTKkxeK2A5ZUUBvr/tt4vPFTOZvW
	cQ5HW2/Ns9H0a1y+pgC4nUN6aYkDsiwhN9RFUabzhho/crQrrCu/E632kOElzL5C
	UutXxuwjACR4DvbsPTFHJl5PC6dP9u3D1S27xFB86JUrgqxbFWg+jQQMqmbXDD7D
	FiBRRQQ1Npl9KC6bZqEvvVbshRKL0oKfE7mZNx/dZSe0IT2MCqdOBiI6mzRXPIWX
	jkzcIj31n79mK3Mkj/tzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791583071; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TSi36qiSxk5yxzl958oDcb8dEpPLNJB8ASPlDOA7WPo0aQb
	Lf6T7tPCojO9ka0crToNvq5KGi5cda8H8HQEkgPH1t/o/6V2v3lFgCxbolLnJhdc
	Yz6Vt4j+93X4HwSfchShazJzFFkKMaSp/FZt0DAvtKutS4fvZzQ2pRmsEVGAHBcM
	MsKT+U3I3kwGvzq1EeU2UI6E8y0gqX1lOgxK0Y7kzWp+682Y9BeVePzdHx8x8ebZ
	C3S/ltdTySys+MgxADkdMtJnsFTqwRbuO0ApCUywgCc9AG5QVhFd7MO5Z1U5byMy
	G6Zs7+D0mFm/FdYM/xvyiyHL2N7y2LTUvSzyC8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AWqkiazxtFqG15b2E9WajbXFF5zERmDjJy9/oqy5/rY=:uw3PemJoWLmDD2Q5S4K4vpD1Q3NYpGFLLIXFxU6ZYms=;
X-ME-Sender: <xms:XmPJakHYzZOnKz8vhgy4kjZocmSETOE-nHfrA4O5S1n9XLBNVsiukg>
    <xme:XmPJapCygQzL46YLpc0f8R2JCY-NBT2fPQfZikxxAqwZYN4L94vimJxKBngRhJvSR
    RcY2o0BdGg3iXGbXQLWoW2QzDfRUZ8ndTezeSau2SoXP4LxxqIZ1R8>
X-ME-Received: <xmr:XmPJaqlo24Y0ORJR972l5GXg2vKhiXPkOCOdtEaKFcsmzT2x__XJYISTFJOnFQ>
X-ME-Proxy-Cause: dmFkZTEBgVX12DrHYNHbImzvqEE57WFgRDDNntR3ubtngcIpiE8EUtJ/Ttf9i8E7LI1oAd
    BrcGtHJ+CRW40a0l0o7+eT568zOzj8l31jEoJmNFpduqHlkTCl2IskCl2+RWXnSTXT+yag
    MdBFeqS1BEohtwAH4nG1lP2TvMk0X5JybWj9UYqap0ydP/x6YDecyHzBbuUf74JCy86LQc
    6aAkDsK/RneU1llBvY52EeWgYixaDeDMZKdJtLcro/iQmYlp2ABHIptuJqdelCUGTT3anQ
    mYbTdSLJ669Lf/9GvRWtF6X8RP6Mgp6QzsuvwJzXlsmU725DnfRsrPGl+dCPWGkHHFdqJu
    BKaqVrNKTthRyjguWw+twBMz9UvGBdZoCfZ6vXUnHX+45EN3A1p6i1s7GCjGUu1HUvEaZ0
    inN7PHXEB2tj3BrPI2o9KoI8m1+JGxDPz8Fv4+yz7x8xsOoBw9yuCX66sUVJS8uX9P0o8R
    H7j4sKSocb8TKtFtJCm9uhlkoeLj28etf6P4YUke5qOZSuGV2JmrGa02Iaa5XhYyp5BbWf
    D7/HxZZXul2RPAkLV28MWzRV4m23BACC6Pbgq3rhomUyro+yl3vNq0S50wYl4Dc2o19O1S
    ZC6bdQOOYuvV9tZceHkEsBcZW+AD0o3EzQgy1m/blySgsNh2WJmHVoKL2myQ
X-ME-Proxy: <xmx:XmPJavM9XfGnqsGbUKmV1XvSWs-OXj9VDO45VrnTv2phB5UuV5ZT2A>
    <xmx:XmPJav8pYjndMWCrhdfZgBzRgAsXcy1HMOtl4HYg1J4f44-NKZYHAw>
    <xmx:XmPJapFkWw3F2ilOmnFOJiiwVyTxojdu6VO-xaKljfRiv5COnC-oEg>
    <xmx:XmPJamgoYgLApqqh_OfP_9IG37X-beCm7UILbP9p0WTrJ8RW5FQmVA>
    <xmx:X2PJahHxtgG1yPB4eVbcErBjUrqnBFvcS6kBbFl_LeCIUpIvkApblej6>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 17:57:50 -0400 (EDT)
Date: Fri, 9 Oct 2026 15:57:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Seongjun Hong <hsj0512@snu.ac.kr>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] vfio/mlx5: Fix boundary check in set_report_output()
Message-ID: <20261009155748.4145f575@shazbot.org>
In-Reply-To: <20261005-vfio-mlx5-fix-boundary-check-v2-1-75599d2f4497@snu.ac.kr>
References: <20261005-vfio-mlx5-fix-boundary-check-v2-1-75599d2f4497@snu.ac.kr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 Oct 2026 16:16:29 +0000
Seongjun Hong <hsj0512@snu.ac.kr> wrote:

> Use > instead of >= on boundary check of recv_buf to avoid the bug which
> the full message in the last slot of recv_buf is ignored even though the
> received data size does not overflow the recv_buf.
> 
> Fixes: 9c7c5430bca3 ("vfio/mlx5: Align the page tracking max message size with the device capability")
> Cc: stable@vger.kernel.org
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
> ---
> Changes in v2:
> - Drop the max_msg_size readability change. Keep only the fix.
> - Add Cc: stable@vger.kernel.org.
> - Link to v1: https://lore.kernel.org/r/20261004-vfio-mlx5-fix-boundary-check-v1-1-1d3b8e55e23f@snu.ac.kr
> ---
>  drivers/vfio/pci/mlx5/cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
> index 5fe0621b5fbd..04180035a7fe 100644
> --- a/drivers/vfio/pci/mlx5/cmd.c
> +++ b/drivers/vfio/pci/mlx5/cmd.c
> @@ -1644,7 +1644,7 @@ set_report_output(u32 size, int index, struct mlx5_vhca_qp *qp,
>  	int i;
>  
>  	buf_offset = index * qp->max_msg_size;
> -	if (WARN_ON(buf_offset + size >= qp->recv_buf.npages * PAGE_SIZE ||
> +	if (WARN_ON(buf_offset + size > qp->recv_buf.npages * PAGE_SIZE ||
>  		    (nent > qp->max_msg_size / entry_size)))
>  		return;
>  
> 
> ---
> base-commit: 6addb4f385570ebc11c4eb499a4f1c149f313e84
> change-id: 20261004-vfio-mlx5-fix-boundary-check-4839d6aecbe2
> 
> Best regards,

Applied to vfio next branch for v7.4.  Thanks,

Alex
