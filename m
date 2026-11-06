Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978596;
	b=v5Xecf7An6El3OTSZg3u5ZUbQEucSwqQeQvCV3Joe8gXVDRl8Ad89ZUPehgB9q2Eig1R
	 iGpTrOZptYjTijDObeSQia7tm/seXjM/TdSuyjbXmMVtrqRaZXf5vvTvAn3tIjWi3TVOF
	 pEouCT8xTFEorBvMhfKq+E3tkTSqV6e2ii8BYZdyxfAbZs6ALZhmxayDYRvSR3TTty9d7
	 xUlh37wvLCO2hRYvOljdmzqJ4zSlgdctopsZi3mdi/XjLidjrLT6T6guiS+4FlAxFQtK9
	 v3oWmJKoDyYIQHH3ZqlSLNhi02Mq/y4gqRd7Pqbhrbizj1HvhruLkJa8r15Abdfo49w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978596;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wEP4JuQU0P2yq8X2XSLRKG5Pf8+rQ+Lx8gGdmvn7s3Q=;
	b=pBF92Mv3fhIIHOIfkuCvKM9h+gCdUvU8FxwoI4yviAoAUR94DAcivGMYy6fC4uXPBPa9
	 DFq1QgRsg7lDqvkzqQzYgCtKnjL8ck0pEC+ubfAaw4AyhcMhhVMQ8GD78nyIZljh7fmmL
	 yzpTzJ52PhRsZBDPQKat92E87dACJdX9KMj2Gxgs6Ev82UgObkqUs9XWShA6aY8zNKrLG
	 d3RPcoN3Lw9+t8KW0PC9pwksEj62Gx9IjlLogvVEzllJDnAhFG5sHyrDy3I37h2/4RsI7
	 BLT/Pkaxo4Ep1OKFynqt5VgQRGGUeJQIyRmyvtusRSYEC+CqVQY2wAYGqxXyjdOcVNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZIdU5Uo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D7081606D807;
	Fri,  6 Nov 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZIdU5Uo
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 036431F0089F;
	Fri,  6 Nov 2026 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978595;
	bh=wEP4JuQU0P2yq8X2XSLRKG5Pf8+rQ+Lx8gGdmvn7s3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kZIdU5UoqQ0HkYNhJaloKpEHYfN92rDvF8TCDhkQ2ScGfiXlADW1/Ok08uDEpWAHn
	 q+GPUyE6kl4jwHnKZD7DW/pcq5sx10uMY/Ycx1FT1Og/yieL4BW6jLi1Zt9bUlBLqE
	 EFKBePbhVa1zBY5pohaMb3X3KAAt60u8qgkKceZM30FMWI7fnDDS6mqBhwm2d5XzCP
	 FHncPtPwT8cJQHZHe6/3ruQvgcUA2SFAxt/7Nwibzs9LVbc7XdQXQA1zr2D/h/tpGR
	 c9ZGIBs0OIqBu2pouY4Fa0KcqH4gO5QNHfERxGkr18dqXoPas1kUo7nm4qhu97x3Et
	 0G2XhYh++unnw==
Date: Fri, 6 Nov 2026 17:23:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ashley Lai <adlai@linux.vnet.ibm.com>,
	Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: ibmvtpm: check the response size against the buffer
 size
Message-ID: <au3w4NDX1Uqz-iqd@kernel.org>
References: <20261106014946.4128696-1-guozh23@xiaopeng.com>
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
In-Reply-To: <20261106014946.4128696-1-guozh23@xiaopeng.com>

On Fri, Nov 06, 2026 at 09:49:46AM +0800, Guo Zihao wrote:
> The send path validates the transfer size against the size of the
> RTCE buffer:
> 
> 	if (count > ibmvtpm->rtce_size) {
> 		dev_err(ibmvtpm->dev,
> 			"Invalid size in send: count=%zd, rtce_size=%d\n",
> 			count, ibmvtpm->rtce_size);
> 		return -EIO;
> 	}
> 
> The receive path has no such check: the response length is whatever
> the hypervisor reported in the completion CRQ, and it is only
> compared against the size the caller asked for before being used to
> copy and clear the RTCE buffer:
> 
> 	len = ibmvtpm->res_len;
> 
> 	if (count < len) {
> 		...
> 		return -EIO;
> 	}
> 
> 	spin_lock(&ibmvtpm->rtce_lock);
> 	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
> 	memset(ibmvtpm->rtce_buf, 0, len);
> 
> A response length larger than the RTCE buffer makes the memcpy read
> past the buffer and the memset clear past it.
> 
> Reject a response that does not fit in the RTCE buffer, mirroring
> the check the send path already performs.
> 
> Fixes: 132f76294744 ("drivers/char/tpm: Add new device driver to support IBM vTPM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
> ---

Ditto. I.e, I'm not sure if this is a bug fix or just better validation
for failing components.

Br, Jarkko
