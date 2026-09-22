Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2040539774;
	Tue, 22 Sep 2026 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075338; cv=none; b=OxErr+vDBTqDAenKhusAzbGWpZ02kDe3kO+FPln7gkjcslDziVLGRtGylBMatWNs9gzlw83Z0Mx1hZMhX4RQfluzcxEE6YOoOsrqU+goLbkr2Y5hvD3gZi8yQ8+sgzjCmVWOa7m8H/0aiCYH++KEB+IgK+gRtdwEq9Hq5eTa3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075338; c=relaxed/simple;
	bh=9HJlPMXZt1Oe7sRztWY6mkw2AEFppgWFpyodapDPlmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNCS8ZZMPRT6yfS+9NKcS/hWL5Lq9F958UgL7Q/n8J0smE4N5WVMqA/hfNdj/pLQ2Pk21L6sscpEZyXwDRiQnh30TNJni2ZJfkexpW9vmhrC/ZG+oArI86eDvo4DLVkcmJ5XPSU076eFmM9YtottmWzRqA0vbjBGPKxzL7CEn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C68WpyvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C68WpyvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389C61F000FF;
	Tue, 22 Sep 2026 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790075337;
	bh=lVyM4uSRQe4zagUkjvqSwMHe9bzVnEvtY2U1tg6ZCW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C68WpyvLLExwx6r+W9Xaf/fqB5P65iaOFCppaaVkylizbXj4VLETX+f4C0DSEM6cU
	 RR+Mwr3B/eUK1CE6DaJwXOLxJPoIXMSHqaFhYJfRyY9FW6LQnJfVSMN6tMVajkqXaK
	 2RGUrqAFWSfxUGmj0LgNyKjYsGzlsDG+2/vMjJ9EpQTfWROszOfMpuRODql+09OyLu
	 nGD8FGKzh7b0oSxHrt4apTqsb9G+jdAZkCs8Rpw9KYn10X9UMFfBfRR2cTUHBwylnw
	 6JpUvrkvFw+ohR03TDz6qsjE+DLo2uw2cFOYHtJUzUNM4x5zhZ6QxMvZUR+BQu+q5i
	 jRHNMvMmuO7HA==
Date: Tue, 22 Sep 2026 12:08:52 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: davem@davemloft.net, david+nfc@ixit.cz, edumazet@google.com,
	kuba@kernel.org, linma@zju.edu.cn, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
	pabeni@redhat.com, stable@vger.kernel.org,
	Ren Wei <weir@nebusec.ai>
Subject: Re: [PATCH] nfc: llcp: Fix local use-after-free in
 nfc_llcp_general_bytes()
Message-ID: <20260922110852.GC13925@horms.kernel.org>
References: <20260917163836.2162706-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917163836.2162706-1-vulab@iscas.ac.cn>

+ Ren Wei

On Thu, Sep 17, 2026 at 04:38:36PM +0000, Wentao Liang wrote:
> nfc_llcp_general_bytes() drops the reference on the llcp local structure
> with nfc_llcp_local_put() and then still reads local->gb for the return
> value. If that was the last reference, the local structure is freed and
> the read happens on freed memory.
> 
> Capture the pointer to the general bytes before dropping the reference
> so the local structure is no longer used after the put.
> 
> Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

I believe this duplicates a more comprehensive approach by Ren Wei:
- [PATCH 1/1] nfc: llcp: Pass caller buffer to nfc_llcp_general_bytes to fix UAF and memory leaks
  https://lore.kernel.org/all/006437e618b55acc0df69d94255244a490b11461.1786029423.git.rakukuip@gmail.com/

Please check prior work before posting patches.

> ---
>  net/nfc/llcp_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index db5bc6a878dd..d0f17fbacfee 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -638,6 +638,7 @@ static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
>  u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
>  {
>  	struct nfc_llcp_local *local;
> +	u8 *gb;
>  
>  	local = nfc_llcp_find_local(dev);
>  	if (local == NULL) {
> @@ -648,10 +649,11 @@ u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
>  	nfc_llcp_build_gb(local);
>  
>  	*general_bytes_len = local->gb_len;
> +	gb = local->gb;
>  
>  	nfc_llcp_local_put(local);
>  
> -	return local->gb;
> +	return gb;
>  }
>  
>  int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
> -- 
> 2.34.1
> 
