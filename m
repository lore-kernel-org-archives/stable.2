Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989635C1A6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791867632; cv=none; b=M4S8VVvLoen5ToKWIK8v3LbmwcJ21hQKbY7QPViqcHzHhOls/M2aJytQNpXfFzsySf5IGUUfV55wyV9o53ZVkFF11B2qpN/HvcWL3wGHJ0YtaUuHzuIHton14sQcCG6+00xtbdD0YIMphKguou0mRa8uePOCISvwvKbTLUHkjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791867632; c=relaxed/simple;
	bh=LdE0xymDLLhP6FyFsOtswIPlcVUTACJJ3icf151iCu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1tQnmsJVnyz3SompSFGvz4+yJctBuwUKQka6ikKL8Fkjw8G6fNBTPwVxuXzNi7+fpKlDopGnbfeBvm7ms7BECfho73OfBjsPMHPp0WLXuEnC8YtDf5uo/9AhYO6Hc2wHF/ElpvTMtnOziANgHQsNNj5DGheehUhldoE7YR9H7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=eag8rL17; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w0ouBNIB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="eag8rL17";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w0ouBNIB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A90331D0011D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:00:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 01:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791867629; x=1791954029; bh=6ytJmHD3Qx
	XFaO1zCqmFc2AaBnITHvr88LGMaQ4ENDo=; b=eag8rL17nQ9UA0APcrIic6/uYg
	0P0aBBgb1PDHCd9AJicriBpDblBboakOpyHLu46It2e8z6d1/Ox1p3VTZwOacbhy
	4jegFmfdI2jlIArowJwsHxXGVkCIG9Lua6HioGH6BZDaobRQO+RYWbE7dICszIHB
	AF2Q24yZWMYdsrWG+xs6u5ZuuFo4Wss3/gZIiWK1Lgc4nO7OcPXWaeV33KAr0Efz
	IlApYwiop70mCKuA9QG8pHdRstDchq1v63azl0rQK1CMw0HKo5ulabqzbTV8BJC0
	y6AflAMfy/j8PO3hywlcTwuOEONBQNpkyFtzx0r50eIHXfflqCJLCsnpW7Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791867629; x=1791954029; bh=6ytJmHD3QxXFaO1zCqmFc2AaBnITHvr88LG
	MaQ4ENDo=; b=w0ouBNIB3yj512V6kKlp7eojd/DDD2BFR0wvAWCygSRB9m1Jpdc
	LxfAah1fAMvZYMYgTaDsvRvcc36jxYKAtD6UJo5/rH+kKdvZZ4xaSq5aS4/uorhG
	cLMBgrRE2pq/TNLohoWJsczKJfio4mQvxtrITX3NfXvhrM9fyO0hN+osneDHmZ/x
	P0RZpnAXJTHfe1MO+ZOCtJns6pLTqf1zErKF0hvkSCExxXwJht/aFX5zy0dj5qi4
	uys0KgO/YfLOn877mgMcnx1qy1VMr/Vv0Xa+tT0emLhIo/jb/jGHCtzxSwXyb4UN
	nCjmuTRpo3XodgybTFqxEMyHFft+LC5NQzg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=tyhicks.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791867629; d=tyhicks.com;
	mf=PGNvZGVAdHloaWNrcy5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:khhY/dF29z7EOHEY7z4U23izaXEyrxUnWX4RbVryqFZTq3l
	p8nI2D0G30F3CiCU+Z2ZigdgccL51cVOEvknCqbahkpDykVp0XVh6bSd/HicAG4D
	3rzTkIyaw4i6XUTi56WgN5Krsx3t6hYkKMvYR4NPf0BMRDTdZ9W6SCQSxh9DgkzB
	QxnaS5odqEfMk34IgGIT/dwXVNM5lBjdWGY0NTqYymjfkZgisq5Hu500CbcEI8au
	vzOMu/Qpt6myXyJXIxz5Kjrn+686HfR3eN3a20aeAvCpSboCy9SDxEt+EFjMLHFX
	1tKCxp5QkjrLHDxI+vvpiITxYgVyHDcSSvQxNNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a4spjgoiUCy+Zyrkwu0Pu2oiBQZigTPC/TVWWKiQGK0=:LdE0xymDLLhP6FyFsOtswIPlcVUTACJJ3icf151iCu4=;
X-ME-Sender: <xms:7LrNagm1J0Mx9u10ZkDhBHodl9Qp4NLINQId6aIaAzDH6uRy9p8ryA>
    <xme:7LrNaiEvqPUzAd80uFhpQS8_s4so9Kp219WIQ2BKy3qY8jSrmHU5IMAV9XrKV8Rxt
    IiyPJV6VxQVzk9oVrVcFisuHSKY2_hQZhrFQd0UjWAnIiExTfxfi3hV>
X-ME-Received: <xmr:7LrNag6To64Mn8-KYkAzl5ByfHffQbY325jAgAwNHjo5_0lsc1N89Q>
X-ME-Proxy-Cause: dmFkZTEn+yWHwxafRD/i2Vu8vELSZ1/iKjbNbXn0i7w9Im0HrUqudqVifejFm9Qp+sAbJC
    +XvdV9pmwM/vTEQ7i2TdcQ+4rwzNabERTdWqfJ/DUqPouY0vrWoQbnXKWKG5YyTHWaSA3j
    mcTXaffJFOnVtuZv4Q5riWYpbXYgAncPUxnENp3KKMXgVc+CCPZa7kjYgzU0t060AK/iix
    yo9fYxCNR8vLQxfo6gdZbRoqMOiP8VV/NhNLVYX7HTsKCXD8tDgU7DHBBxFd4sT0GW5npM
    SrZm97EtwOXxNZtMsvbSW3ibj6AinD5sgojUwpyugEaNQ76bEgJpfM21KRbxvDm5RbpFWB
    ISMXB0vp6PsLLVh6c4YtsGmmHnvL57kgQPUu3LX8oKjRuJ3YFNParlJfedjMf1Z88Qox5l
    rhMV44IhQ8lZfLVstEAjgWDMnBa1CJOK9IQEpr7+2CcgjxqXRPrEJoahVF5G57xZsiMMiC
    wBDCoH4XbxyxL5UB+g9P8rz7hZMeUULGZlgvOerT2RBp7iktIKAgvR/ZLFltWG4xHEZxlH
    JW7RyCxEud1Y5OtiAlheTdOauYLhpwF1f7IJZ8cSJf622pKbPzBmYQsqbymbDYDiPU/bpZ
    WQFlVTkIgMkMk3RrVphGmJZv0/u5fUcZxAZu+byp3H8KsZXHOCG1Je8odcSQ
X-ME-Proxy: <xmx:7LrNaimfW5UlM5a3IfvRFyeShFNpgotYPrplnHJW7_bHylQ5h7o2Cg>
    <xmx:7LrNatpugnhZfQh-DPh7MVBlKBHn_NBYNbDHylhPLFYgmrltvii-Cg>
    <xmx:7LrNaptuZg4MfcOGgX_51Nmsoj3wy1zcuEwv8BsM-gBvhAJbwJO4Rg>
    <xmx:7LrNaqG1uv2gUVrqI-BaR41fxf8A8iqrYkv3kS2ybR3YJoAM2lzTEg>
    <xmx:7brNaiZODYEMrVUKdXpMV8f7bxIpZY0CAVQihktsRgvST68IKTQiWrNh>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 01:00:28 -0400 (EDT)
Date: Tue, 13 Oct 2026 00:00:26 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com,
	Nguyen Duy Nhat Anh <neganhat@gmail.com>
Subject: Re: [PATCH v2] ecryptfs: validate auth tok payload size
Message-ID: <as266is_fT232oMM@elm>
References: <20261004123755.14642-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004123755.14642-1-adrianox@gmail.com>

On 2026-10-04 09:37:55, Adriano Cordova wrote:
> Validate that a key payload is large enough to hold a struct
> ecryptfs_auth_tok, and that the password token's
> session_key_encryption_key_bytes fits within
> session_key_encryption_key[], before the payload is dereferenced.

Hi Adriano - Thank you for the fixes!

> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
> Reported-by: Nguyen Duy Nhat Anh <neganhat@gmail.com>
> Tested-by: syzbot+03c68e42ce4b33f7ce9b@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=03c68e42ce4b33f7ce9b

Change this tag from `Link:` to `Closes:`, please.

> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> Changes in v2:
> - Add Reported-by tag.
> 
>  fs/ecryptfs/ecryptfs_kernel.h | 6 ++++++
>  fs/ecryptfs/keystore.c        | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index 58165928ed1e..4315c18ba1cd 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -88,6 +88,9 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
>  	if (!payload)
>  		return ERR_PTR(-EKEYREVOKED);
>  
> +	if (payload->payload_datalen < sizeof(struct ecryptfs_auth_tok))
> +		return ERR_PTR(-EINVAL);
> +

This change should be in its own patch with the following Fixes tag:

  Fixes: 1252cc3b232e ("eCryptfs: added support for the encrypted key type")

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

Nguyen Duy Nhat Anh submitted this fix prior to your v1 so it is best if
I take that initial patch. Please drop this change.

>  	return (struct ecryptfs_auth_tok *)ukp->data;
>  }
>  
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 51651314b7a6..7f2dbc81fcbc 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -477,6 +477,13 @@ ecryptfs_verify_auth_tok_from_key(struct key *auth_tok_key,
>  		rc = -EINVAL;
>  		goto out;
>  	}
> +	if ((*auth_tok)->token_type == ECRYPTFS_PASSWORD
> +	    && (*auth_tok)->token.password.session_key_encryption_key_bytes
> +	       > ECRYPTFS_MAX_KEY_BYTES) {
> +		printk(KERN_ERR "Invalid password auth_tok sKEK size\n");
> +		rc = -EINVAL;
> +		goto out;
> +	}

This change should be in its own patch with the following Fixes tag:

  Fixes: 9c79f34f7ee7 ("eCryptfs: Filename Encryption: Tag 70 packets")  

Thanks again!

Tyler

>  out:
>  	return rc;
>  }
> -- 
> 2.51.0
> 
