Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172995;
	b=GaltkeaBr6QFMTK/OJ5kX5FXABvmSkvAQDeeqBrgQIkN2yejJCxwNC8CloRB12w8F+SW
	 JCDTDdkLoLAZrWxBWUhzPo+RmzNUzrdnqTMajip/1jMEpxkKvVB+wmB4GC0/qHqZx1emY
	 wa9SjjxPUkPfE+D+2WUwKSjA5sItL82DKwPg/0gUfwds1FYYSMRZEIPBaUrSv4SzqSE2i
	 EbHxZo3X9BEqsT2seI9AJOdTo/lQH+So8aFGHfmVnTRunKwCZ+zWNUKrkbvQUTLVZfYMD
	 y9IjS08Nvhi9DPU/HN8g1EdRBWTSr5isj3s7I5+/CMFtX5b/2JAdlc9bWT1+y54bphQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172995;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=w9myFnwj5zB1QE7elWWV13KgJsaU9TxgOrmcx9HYe1I=;
	b=5EDPYEF7WuGc6PoNUx7rY6siuSVxgHOEmn6wYGTCpzzf42Cio4Rh5/BoEHunpqEB3PpJ
	 STPQtao/6PgUEfkPs23TCvYr5YERx3t3phFu91Urz9EihyW8Cv25voZd7D2ukENOfeuYP
	 yc92y5QIzG/U2xmF2rbvwBNTISfjGc47/ZFi+2te1Ohnnryz3IUrfSO5D89gpXjRYyl+U
	 gCJ/QX0rkUbRHgUVCS0+PmQpC7W2rPz8KVjA5Hg82LU5QE91hFUwZxEYPJHBNhq7WuuK8
	 LlRACAU3ppQ2jRgArIrWoY+Wbdo2NAHNKfCKBA8SLofTZxkTj1hAfLg4XQpF91aGxiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K0DICIEk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E1606A325;
	Fri, 20 Nov 2026 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K0DICIEk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875FA1F000D3;
	Fri, 20 Nov 2026 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795172995;
	bh=w9myFnwj5zB1QE7elWWV13KgJsaU9TxgOrmcx9HYe1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K0DICIEk4a8jSFRZWbz47M8Blj4HRTjqjY1my6J5SSUCLsVWuJJZuBr7wHBt70U3t
	 lkAuXx/Xpsx1vw20mg/B3RUFWRhK2FZfcGyn0Iiwmbd3ypLBJOr0MFqVKcZDBLVUKI
	 o7+3CQF/XX3dOZ4YPL9vxL/qNSHRApZAWZfRGA70=
Date: Fri, 20 Nov 2026 12:09:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-usb@vger.kernel.org, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: gadget: f_tcm: reject a short write data-out
 transfer
Message-ID: <2026112028-starless-aching-bdfd@gregkh>
References: <20261013043951.2534225-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013043951.2534225-1-yhlee@isslab.korea.ac.kr>

On Tue, Oct 13, 2026 at 01:39:51PM +0900, Yehyeong Lee wrote:
> usbg_data_write_cmpl() copies se_cmd->data_length bytes out of the bounce
> buffer into the command's scatter-gather list without checking how much the
> host actually sent.  A BOT host can declare a larger OUT transfer than it
> delivers and end the data stage with a short packet: req->actual is then
> shorter than req->length, but the completion handler still commits the full
> declared length.  The tail past req->actual is whatever was already in the
> kmalloc'd bounce buffer, which is not zeroed, so uninitialised kernel heap
> is written to the backing store and can be read back by the host.
> 
> Fail the command when req->actual does not match req->length instead of
> committing the stale tail.  The short packet means the host has already
> ended the OUT stage, so mark the command and report the residue in the CSW
> without re-arming ep_out to drain data that will never arrive, the way
> f_mass_storage treats a short_packet_received.
> 
> A short 8192/4096 WRITE then commits nothing to the backing store instead
> of 4096 bytes of stale heap, and the CSW reports a residue of 8192 with no
> OUT drain queued.
> 
> Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
> v4:
> - Keep cmd->data_len so the CSW still reports the untransferred length as
>   the residue.  v2/v3 cleared it, which reported a residue of 0 and told
>   the host the whole transfer had been accepted.  Skip the ep_out drain
>   with a command flag instead, matching f_mass_storage.
>   v3: https://lore.kernel.org/linux-usb/20261013015416.2503787-1-yhlee@isslab.korea.ac.kr/
>   v2: https://lore.kernel.org/linux-usb/20261013005854.2470384-1-yhlee@isslab.korea.ac.kr/
>   v1: https://lore.kernel.org/linux-usb/20261012154422.2436134-1-yhlee@isslab.korea.ac.kr/
> 
>  drivers/usb/gadget/function/f_tcm.c | 14 +++++++++++---
>  drivers/usb/gadget/function/tcm.h   |  1 +
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
> index 9e6d4f39900a2..d686fbcf36f72 100644
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -120,7 +120,8 @@ static void bot_send_bad_status(struct usbg_cmd *cmd)
>  
>  	csw->Residue = cpu_to_le32(cmd->data_len);
>  
> -	if (cmd->data_len) {
> +	/* a short data-out already ended the phase; draining it would hang */
> +	if (cmd->data_len && !(cmd->flags & USBG_CMD_OUT_SHORT)) {
>  		if (cmd->is_read) {
>  			ep = fu->ep_in;
>  			req = fu->bot_req_in;
> @@ -1090,8 +1091,15 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
>  		return;
>  	}
>  
> -	if (req->status) {
> -		pr_err("%s() state %d transfer failed\n", __func__, cmd->state);
> +	/* a short data-out left the buffer unwritten; don't commit stale data */
> +	if (req->status || req->actual != req->length) {
> +		struct usb_gadget *gadget = fuas_to_gadget(cmd->fu);
> +
> +		if (!req->status)
> +			cmd->flags |= USBG_CMD_OUT_SHORT;
> +
> +		dev_err_ratelimited(&gadget->dev, "%s() state %d transfer failed\n",
> +				    __func__, cmd->state);

Why is this needed?  And __func__ is never needed for dev_() calls.

thanks,

greg k-h
