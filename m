Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648621;
	b=OGDuT8xP2y+RXTf9lZ99NCoeL28JMMRmETtbgOBw+YiQQi6SpB5LbkNdJgfHMJa8u7Eg
	 9RChlHTgAwxFQG7jxDUqwC82N1NHpToZ9ptcame5mHYzBHzyGaUnZjbi0phJQlkmH+fPj
	 ohCFHrXEr1s98eJPwxoKM27DTgqL6EVNMw1/MZbWLdjUCwLUvapuA2kxOIASwZjVckWzK
	 l+X+kboapKsgXpyQ+TsJY83f85M6g2FUsqh4VJPhEeRdLq49R7P61G+qbT8EQ3CkGvTn4
	 ZVSIgz3vahxwHYxgDaKPXXn2wk65yQRS7UCfhr58x3yPZ8PsANbTsqNP8twD1yq0Vpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648621;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=f6GXD02OB33NaAQyvTM59QBW0GDbPJIgHJ/b4w+UY/4=;
	b=0CVExl/GSgvBtB0byPDlkVlS5JrLkHfGyRyKTDX6nywqEpbOuXanVJSywL58h4BsR1kl
	 020RRwF0QX0Uw+kSjgBzBfvVdFFkbtV1cSvGeEot3vTN6JqsTullgguppwrrP3TNbSQmo
	 E7owOEmSTrQ5ykVgyQWaW/hJcbVWkpKEpssv3ernGzdZv55HVZ6Zx5mqsJ+d2NXmv7NIn
	 HYZBddEj5od7ikFyb11B1ODLEBRXinCDX/0IfFJ3IXcwUvuIH1+TCjxIllMD3/LjByh3h
	 iHOxhWgIdoBqDKuMtjeuflTVEuDhkhUDVB+BZKagLDtL+MsL8in7iik/xRgguPWPMVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bsbernd.com;
	spf=pass smtp.mailfrom=bsbernd.com;
	dkim=pass header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm2 header.b=cYXkxpP7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5E7g26Vf;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8A606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CD8A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm2 header.b=cYXkxpP7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5E7g26Vf
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A206A1D005B4
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:16:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 18:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795648618;
	 x=1795735018; bh=f6GXD02OB33NaAQyvTM59QBW0GDbPJIgHJ/b4w+UY/4=; b=
	cYXkxpP7wq+TjvZyIe0lKWW2/DdbsewBrgSbvf2HVOCD5Zix4sRzWeNfPQJ4pWvT
	I/WxujNBEfFXD1NOwa6T2RJEUaxov9mLdPC/OYQcpshqVOQDbZyPwFh7JGl/AFSu
	VV0Mqvq+Pd5bXVZtdEhVyLKdxXxQOpvAiwiFQjJFxU1MSZTroMedropcaxx9oUFB
	Kc0DKbYbWm+NACyBaLrH54eaZI5TbsfK6vMGO6Uj1EyMPbpYvGbuCAec0LdXbYcx
	mwU+vcvP22ciUPTyMWuy2aSUxz1DWuVGqPSz8rl0HIkDCglxA+XHY3nffF3UAEKH
	5vedEyCPeAHwY/c8WKpdGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795648618; x=
	1795735018; bh=f6GXD02OB33NaAQyvTM59QBW0GDbPJIgHJ/b4w+UY/4=; b=5
	E7g26VfxZsFvIc0jx5LyIM6/u7mlHYF8JjiIkabQMC/RjsJEjaz4RcHiDfdwj69Z
	SKZ7+IJHDxlDV2KFiUGZ1KWsjBTSC8qOPOuooV3Q4j8lzCifh+2uJnRAop8d3dwF
	l5HZkpltL1HyhIunIL91/1NOtFtW6FonrRDJq78F7XrSCGyANhDarUSBHq5eIhTc
	IcXb22T8zh3UE2WScEz4+iRwc33U9GNQTw8m+dYKLz8OBIuh7+VoXsEP08nehReJ
	CCyVb1m4dE6acAnoqoo2nEUGAPbswSguP7NGaV7xsyHMTuZ2v6sQSGsBx2HfwbAs
	oWcbhbar/oNRXpGV2MK6w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=bsbernd.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795648618; d=bsbernd.com;
	mf=PGJlcm5kQGJzYmVybmQuY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:irhLQT57lR1VqQXxgUXeQu4+AnMHHzQYn3o8W4G9LYbzQWQ
	pbC4P+AcG2N6+c/4Bv2+aqSAH1xzH6ccirysMdbJXl8p3894edSj5Ipv/nkxqj+A
	4HU4/DUPvll5v1b5qVSB87PtkuBtuP5Fj2+CG8qB54qqIHDggS2OnEhKNNMboxLk
	qZLJ9Qg/Q55zeTcY7r3lZAVLGEBYJwnCtzcCMmav1vrB9GgoEEafqctWkHICrfKb
	i64vdGui89HNvqfkFRSphT92JQODPUXuJcXPE9LobkiUbDmLDRG0QUOogo/l4/Rt
	gaAnN56xWggCGkS+tyzw5aTuZ2nP9zCOSpm5Igw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cbO5gqgHYCV9nHqmB2/wf8+i8RzheBPO1TgXcvsuW10=:uGzc65jZgxw5wCUyJj6XYCb3MkBfwzdzBsC3aXKGD5s=;
X-ME-Sender: <xms:amwHa1DgNTav2K216AzSwWqgECREtwhdfXnecVj8eM6BLBp3kLoHKQ>
    <xme:amwHa9nBhfjO64HyO2UjmmNgZ5cxi1L5NCul7ALUFaHeN0ErvX8GZy9sPYnaBDPUE
    6F6KYmfylAJ4uhrqtOYfVBS26FkU0wYPCL7ah0BAVbYm0Zo27025g>
X-ME-Received: <xmr:amwHawfbAlM4lh8QVxaNujZKZXNE8kxwCllWYIWWSODA0MvFKSi8Eq1CNkXpKskFWgDG6BlaeBuevroVfZH0NoQFGPvkW7lfIEZm7NaUN1ATYAgx6w>
X-ME-Proxy-Cause: dmFkZTFNyrJAJO5NbnfvBDoFub4JKkZfjv1RWUY2SHBdloUNm0SAEkFyppoIwdnzwEnuKn
    5dJT1qE06KCGiTMXGw1qVcyKD0nqRs5n4rB/7fqYvnhJMTT5fpkdLYeGTkfsje0A58Ssup
    Mewp1bTE4hH6TQHVbtPDL82QK0ioDc8olDTchmQsKEHTNNdLz/d1eqv+7cN2jXI4YGiMX2
    jU4ECoz+3hB00+3XTOoCEE1v7ZjlmeE57atsAPQskFd52ZATiPTGpgSBoun61tTU/xLep9
    FcthcMHi59At9IOOM+Il28/gnzS6I2lxDNImq29O3vQ/v/omAq6ZXsgRbTY3X8n+la1TLf
    8kIDJ5H7VenkfqZta+Vy8gAsCwJlz8Bi4/+npmFhFLgKfVnNy3/OOdaScJ9ucPqoYBsWNX
    wZPLuW+QFbgI3AadXyq0ju4PFOLvVmlQ27c5VhIYIBrHURNLXmiFzyLGxvIFnWzRiRRlUK
    7J+0SpsaY054cpsZZwfHMUzHGT3CI3hXr5g3IZ57H9BqrCYozOXUlW4Jp/MEkIQrPeReO8
    iS8SahnFPBYlaCRyDiBaaZXDYPmLk/q1pUOA3unMj2S03zUdvRMHcpSdXaU5VT6j7tXs75
    +Wo4kn7X7oqh5AROQzoTBxQtlyusonv5KAYlUhWlovx7LLvRbjL1cmHajO7w
X-ME-Proxy: <xmx:amwHaxSH3HPwCm7FdcThgrGDT9Stklubc8Et_ZUeZtneV6yFPJdl7g>
    <xmx:amwHa3s5Puim8oLQlnObGIjyMmpB_dVaqqG9X51Vvk0gEjwuV_sFrg>
    <xmx:amwHaycZcOYf40uo4QN40hHKrysIDsGVWd2L4Ed4FOH6KNPZ50j0xw>
    <xmx:amwHaxZOhv6yQLUNRK5nHczOEHok7EnCinlyH4Z0m3L0pnLds97PuQ>
    <xmx:amwHa9lML8jDqbPvKStmNwp-tTw5MOrNp5-rNdyO_4EwTcLfKfRm44aE>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 18:16:57 -0500 (EST)
Message-ID: <af756676-5bbd-4624-acf6-c2eb65ecd132@bsbernd.com>
Date: Thu, 26 Nov 2026 00:16:55 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fuse: make readdir requests big enough for the
 largest dirent
To: Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: fuse-devel@lists.linux.dev, stable@vger.kernel.org
References: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
 <20261125-work-fuse-readdir-v1-1-44312add01a8@kernel.org>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20261125-work-fuse-readdir-v1-1-44312add01a8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/26 11:26, Christian Brauner wrote:
> Since commit 27992ef80770 ("fuse: Increase FUSE_NAME_MAX to PATH_MAX")
> a dirent can be larger than a page. But the readdir request can still be
> a single page, for a small getdents() buffer or when alloc_pages_bulk()
> didn't give us more. The server can't fit the dirent and sends an empty
> reply which we take as end of directory. So the long name and all
> entries after it silently disappear.
> 
> Make the request big enough for the largest dirent the server may send.
> 
> Fixes: 27992ef80770 ("fuse: Increase FUSE_NAME_MAX to PATH_MAX")
> Fixes: 4dd6f6d3085a ("fuse: back uncached readdir buffers with pages")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fuse/readdir.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 1f6cf565477f7..a75baed673a76 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -333,17 +333,23 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
>  	return 0;
>  }
>  
> -static struct page **fuse_readdir_alloc_buf(struct fuse_args_pages *ap, size_t *bufsize)
> +static struct page **fuse_readdir_alloc_buf(struct fuse_args_pages *ap, size_t *bufsize,
> +					    size_t minsize)
>  {
>  	unsigned int i, nr_alloc, nr_pages = DIV_ROUND_UP(*bufsize, PAGE_SIZE);
> +	unsigned int nr_min = DIV_ROUND_UP(minsize, PAGE_SIZE);
>  	struct page **pages = kzalloc_objs(*pages, nr_pages);
>  
>  	if (!pages)
>  		return NULL;
>  
>  	nr_alloc = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
> -	if (!nr_alloc)
> -		goto free_array;
> +	/* The bulk allocator may stop early, but the largest entry must fit. */
> +	for (; nr_alloc < nr_min; nr_alloc++) {
> +		pages[nr_alloc] = alloc_page(GFP_KERNEL);
> +		if (!pages[nr_alloc])
> +			goto release_pages;
> +	}
>  
>  	if (nr_alloc < nr_pages) {
>  		nr_pages = nr_alloc;
> @@ -364,8 +370,7 @@ static struct page **fuse_readdir_alloc_buf(struct fuse_args_pages *ap, size_t *
>  	return pages;
>  
>  release_pages:
> -	release_pages(pages, nr_pages);
> -free_array:
> +	release_pages(pages, nr_alloc);
>  	kfree(pages);
>  	return NULL;
>  }
> @@ -380,10 +385,13 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>  	struct fuse_io_args ia = {};
>  	struct fuse_args_pages *ap = &ia.ap;
>  	void *buf;
> -	size_t bufsize = clamp((unsigned int) ctx->count, PAGE_SIZE, fc->max_pages << PAGE_SHIFT);
> +	/* Room for the largest entry the server may send, a direntplus. */
> +	size_t minsize = max(PAGE_SIZE,
> +			     FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET_DIRENTPLUS + fc->name_max));
> +	size_t bufsize = clamp((unsigned int) ctx->count, minsize, fc->max_pages << PAGE_SHIFT);
>  	u64 attr_version = 0, evict_ctr = 0;
>  	bool locked;
> -	struct page **pages = fuse_readdir_alloc_buf(ap, &bufsize);
> +	struct page **pages = fuse_readdir_alloc_buf(ap, &bufsize, minsize);
>  
>  	if (!pages)
>  		return -ENOMEM;
> 

Ooops, sorry about this. There was no good reason to have more than
name_max > 3072 for the DDN use case - I should have used that :/


Reviewed-by: Bernd Schubert <bernd@bsbernd.com>




