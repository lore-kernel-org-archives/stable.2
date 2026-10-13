Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA6486420
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870680; cv=none; b=XT2VOBCSX/R06fxG8WzC0IKkczvZJA+kP3Yqbq5B34khv0anPKIkbgq88FKenCOneYtHLgqLgUVMErnquB1FzBfP1iU8ddUR1EfLtrnHyQ3EOdjTB5W/lvKHffvITxsQCsGl26m5+7JjEeXUZcRX9ZSKk7Tb708YNNkpy7JqHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870680; c=relaxed/simple;
	bh=gg5xzGeRZT9S/kztnXNypgtbGJjOd7cJmItCl+1bAEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn/KdZ8OmH9RbKBxZJppbSWisQevoNfuHbBqjPn0WzmgqOKK53jyooXvhD3WQ+qDWNDi6VeVQF0twPB3FnYe6mxCD5QkES7JlPH7nzVi+9kPeg0qeYYLnapw62omfO0LvbI0UL7XQvq1b4gGMDtNZ6MngI1gktLypF9eITv1il0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=RmANN8e0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KXp99qSu; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="RmANN8e0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KXp99qSu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A0AF1D000E7
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:51:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 01:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791870677; x=1791957077; bh=1qXQBI30vV
	mPspzTFI9qdidfZ+Xhv2BgqG1F062IFBw=; b=RmANN8e0LB0LfdowURdYceuzBq
	PrcgE+TrH0ZxfGTeYw6PllERaDdkwTj5vvbwD+C3Ez4NObhlOlBW9/C3bs5zU0kx
	Hqwz7HcPKUGCv8ZyYotnFF4J1nM00JY8hZEd+usxbu7eQu44Lnsva72QZDFMeVFo
	U5TCsg8asn8Iu7QRb0kqUPo0+gxQknkP9Z6kJ77YBZ20GNmwJJtbO+XQ6o5BWm8y
	1tMy76QUu0JtfWogalWfRVtnNvxY3iIKB62/JNui9QreQHBT4aqSa33aWRPdvDRn
	Qor4xxrK39r7pNoWV0vDU+bxbip+/qztNA2rcujAzi+Kvhuk9dWhGHynVkOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791870677; x=1791957077; bh=1qXQBI30vVmPspzTFI9qdidfZ+Xhv2BgqG1
	F062IFBw=; b=KXp99qSugQyGVk8uNM3ppTokLRcK9lqXo8ZY5Vn2RAF28T5XsCj
	J1RAyOPjrAhiuRY8cnFaHotz5NAkjalP/hB60tTeyMJ91AKPYr1EwwfG1ssr5udI
	0igBWBeti2qPPICgjU2beeG2v8mdVPBPLS//jDEUY7qG8shLWLqDa813WNciRXBW
	3O3yG78fU2A7n4B3drec5qUAai3RCmm9imr4VeAy23+Rg8K/qzebKo2mihETyE1H
	N+McND+n/L0D1Uqu1V+xjgMsGM/DdQ9lAj5YaDmk4y0rR0VoYgulYlcIo2M+L75h
	i8EtdUdHxW43iGBaPobq4MZbZaGxvxxOvtQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791870677; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:p37M6Xxec/y5I68AxI3stqpg9vwdd1XKEx/liuZOkGNfNC2
	gObl1vM5VHC5ouDrAY/F2L6dNAwPFoYxt4IbwYknWjWBdsxz4yDRIHQ5bUIEeMTs
	YxLdFqIuQmwCLBYxiLwYidwf/HU6s5N9pvNSSeWQUFyg9cSUFDwnQCAjRRdg2B/M
	GJM244mqbDX5PAOiJ30kgYnzGHzZexfc3w/BBcY8wgLM6FI8qq/zLsr5Zz4K+VKC
	j+5pWstYY2ebnRVidrr5wY2NvLts9cvFMo0WZFGaO4da3APVNwzX2+fwMQP0m6nb
	7H2agHhdDgDL/d2krCEv/GJ709LLs4xgcw3mDEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LlSHrOtzpz7B40CIzfmVVOc9bSw3n5JzWwSBVvHgLOg=:gg5xzGeRZT9S/kztnXNypgtbGJjOd7cJmItCl+1bAEw=;
X-ME-Sender: <xms:1cbNalyV4-wvUCBLSA486TaNnnG05IUb7Qt1Cv9OZc8QU68nhhV7Fw>
    <xme:1cbNao-BWMUFLaXcTeI7ATVX98bF3e4IY9gHLnRmY01WdqJ_nUXG_JNFxI0-7GhHV
    lSX-DJXdWthXBZ0loqKyJzDvJ_DP9_CvpH8_ArEEMFg2NbO1VY_zVkH>
X-ME-Received: <xmr:1cbNapL-rEU1UBucUsT8mzMpaPVSWNNRNL0QXGA8nq45Cn3TqX_hjw>
X-ME-Proxy-Cause: dmFkZTEsTU9xCyRnGNf2O8KrrukZOkB1AhEExVz7u+byF70IdbzsNBVuru8eCBPoF/6v2y
    5BIpfrWJ4X5izWt7wttIBlBtVYleHJ6XvCp8GsvUZ/ZYOaxrURTOG51Xu2dy+tTbw9WqL0
    1/zRxIP42tGJK5aG4UFIlHrzXCrQbQzXc7X1KWic/lfyPwM4dZRKsS0WI/zlboz+XMPGRN
    qZ+tnSPMkAslGrSDpRurEjK9C+7cKwQpVZDfNMxWXu8ASR8q2y4672YeZgvAewEB5b80j/
    qOJp4/TnBK5I0Pdyc8AYJS4jwR06nysZZ+RssSBQduMnCFXC4XzHe3skUXgl8sQYH2qGAU
    BIM3rMdsYQqIaFq92Mv0Z3XRXy08v/0nXIAnaKTh307HgCecO9SSg+6RmRSkZlp+VY5X24
    n7fVd6YjAgYh62DKMMp8Lw28FR/MjJ2SI1+TL14zlO7c96ibLayKUeQuz9XiLEOCaoIpYJ
    sj+S6KzNk9XrgAIXmYMFFUaEYIl9lBQHoBGljrtSx9jPTavRoLXb4i4ip+iBrCkJNHCKFE
    /3YbrJOKnyjlM6OPI+yNv5UTnBSXllsCXT8h/rrcSUD4eDo05wcP+g3LKSZ7LH7KA/KQiD
    ZDOaQHK+UqwViNOc5lNT6mB7aqOVxAwnrktJukBtnj/t8ALgfcAIg6CaLYYw
X-ME-Proxy: <xmx:1cbNauf_5EVimesWAMZw1FgIFmpfXyLC74k6ixeTc0VQfOkvrhRu2w>
    <xmx:1cbNao9O1CHAM0TrgskOElWaa36XmQwmtgukTm3HHTm2x0J6cfQsYw>
    <xmx:1cbNaroL_iIyS9hs4JNWRyFSlnelQdzQZiPdD6CXHgXe38cSk56HPw>
    <xmx:1cbNatCQNE5VFcBOF1lG8uFUMoooqNc1riOK_NKEMzRhWltD1Dk8uA>
    <xmx:1cbNakT2eN__AzSBhieLrCsvTqHH_niZ74PDvJ6u4GtxRMjpTbNMhxUW>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 01:51:16 -0400 (EDT)
Date: Tue, 13 Oct 2026 00:51:15 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+dc50906b100ac7a1c34d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: validate key payload size before using it as
 an auth_tok
Message-ID: <as3G00lXXQnXaMmj@elm>
References: <20261011061902.144716-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011061902.144716-1-ngocthang2710.1999@gmail.com>

On 2026-10-11 13:19:01, Nguyen Ngoc Thang wrote:
> ecryptfs_get_key_payload_data() casts the payload of a "user" or
> "encrypted" key straight to struct ecryptfs_auth_tok. The payload size is
> chosen by whoever added the key, so a payload shorter than the struct
> makes later accesses run past the allocation. For example, a 712-byte
> "user" key makes write_tag_3_packet() read the password signature beyond
> the end of the kmalloc-1k object:
> 
>   BUG: KASAN: slab-out-of-bounds in ecryptfs_from_hex+0x18c/0x1d0
>   Read of size 1
>    write_tag_3_packet+0x145/0x1430
>    ecryptfs_generate_key_packet_set+0x7ae/0x1880
>    ecryptfs_write_metadata+0x590/0x930
>    ecryptfs_create+0x393/0x550
> 
> Reject payloads smaller than struct ecryptfs_auth_tok with -EINVAL. The
> callers already propagate errors from this helper, so mounting with such
> a key now fails cleanly.
> 
> Reported-by: syzbot+dc50906b100ac7a1c34d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=dc50906b100ac7a1c34d
> Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Hello and thanks for the patch! I've already taken the user key payload
fix from another contributor and will take the session key encryption
key check from a separate contributor. You can find the links here:

 * https://lore.kernel.org/ecryptfs/20260917044558.41677-1-neganhat@gmail.com/
 * https://lore.kernel.org/ecryptfs/20261004123755.14642-1-adrianox@gmail.com/

> ---
> Notes (not for the commit log):
> syzbot reports "KASAN: slab-out-of-bounds Read in ecryptfs_from_hex". The
> reproducer adds a 712-byte "user" key whose description matches
> ecryptfs_sig=; the mount succeeds and the first create makes
> write_tag_3_packet() read the signature past the end of the kmalloc-1k
> object. Tested in QEMU with syzbot's KASAN config: base kernel hits the
> KASAN report, patched kernel fails the mount with -EINVAL. Fixes points at
> the initial ecryptfs commit since the history here is grafted; happy to
> retarget.
> 
>  fs/ecryptfs/ecryptfs_kernel.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index 58165928ed1e..863761b3847a 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -88,6 +88,9 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
>  	if (!payload)
>  		return ERR_PTR(-EKEYREVOKED);
>  
> +	if (payload->decrypted_datalen < sizeof(struct ecryptfs_auth_tok))
> +		return ERR_PTR(-EINVAL);

I think Adriano's check on payload_datalen is more accurate. I believe
your check would block legitimate encrypted-keys.

Tyler

> +
>  	return (struct ecryptfs_auth_tok *)payload->payload_data;
>  }
>  
> @@ -124,6 +127,9 @@ ecryptfs_get_key_payload_data(struct key *key)
>  	if (!ukp)
>  		return ERR_PTR(-EKEYREVOKED);
>  
> +	if (ukp->datalen < sizeof(struct ecryptfs_auth_tok))
> +		return ERR_PTR(-EINVAL);
> +
>  	return (struct ecryptfs_auth_tok *)ukp->data;
>  }
>  
> -- 
> 2.43.0
> 
