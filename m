Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853036;
	b=Tw4VJXK5Cnhd/67uu2ZTUZVKvbenLmsRW/YfPK71CbJKpRBRo9agfUCp7aQ68bYB/OUu
	 To5YfnJxHpu7+hIYiJXcdSTtS+f/F6swbClZbCAgRkzOOejNlKiVAVB0EFFnCM0At5xO5
	 oNOkCpsgZmYcmfHclrj37Z2d5NrqM6A7WmjS5ckVhP0WAgzN38DnCFDxr8WcG0vbouxQp
	 OpIhkVbZKgrq/GCkh2QhTLkymVjv6M3u/qJRzXHpWA9ZcxWMUzohG9GTce5kwWbxjNK6i
	 CGA8a5bXNEREf6dJMdetUQmX+YDp2SF6n1oVgZDBWK48df52QiifBCe4OA+K3i1mJcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gdtJsINmNYNnzAIaY46IB+pxpQ6KX2atpqMRoNK0SJo=;
	b=UBhqNFUI4rV3FIkvkqc5GfzU6C/OiGql3HTol0IxkCKPx5TCMv/6kjQmamuC+iGBtlr5
	 Tsj5kqv+3uUXtn31APyQqvYJNlet30PZ5VCrKDC4tesFwEimkvlLxDpaEW15oejCuKCI7
	 3btsRqITe7bOTrDtoX6dOMOZQ0IpiIRvmuo9pzXa+023nhVoFOt0LOd4ecANRQdftUvXI
	 Ibe8EHpUhICdLkpBN9wJiA4NexnWJFUCxIzHqxgieak2EhHMh3MdxKwFx5pP+DHMdZ3zO
	 a9aSxn7ussgtvZnWFktYmzjNPUamf/iwQzwmQw5EU5cA1Ml184Ofqxr/ryXwbYrUzag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QPwa4qTd;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FCC606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6FCC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QPwa4qTd
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso1889311a91.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794853035; x=1795457835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gdtJsINmNYNnzAIaY46IB+pxpQ6KX2atpqMRoNK0SJo=;
        b=QPwa4qTdBndNoy/kjQcLNLm2Tb2ZEHmWraYHzX5ptvkL3AR2doTSDC+bf6oxQxJuWe
         oPGCuTjz3UUBxYytQuSu3dXROL3dQ6hS56GF2BJJ9arvRdG3/d0shpVlzcsWJRe/xstA
         C+oWJ+LydTHrxLpHS/dJNSH38vr29x+4o34q9Y/zbxPr3f/93pS+KJqp9U8VvCGKQsDo
         IwfYo/3l6Hg9c1oBlBp2t6OvdNsU8AkbEHgJiBgRc/9eNInfiLw0Aj6rughSxTxNmifg
         0Feq77hUK6aA9AQo2F2uYbQKungLiSsJL3c76iaHzxk47Owv5BoXPqtZ6OZYUjI91V+G
         lA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853035; x=1795457835;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gdtJsINmNYNnzAIaY46IB+pxpQ6KX2atpqMRoNK0SJo=;
        b=SCUWnMEYgVEKzw3fEua5nmJVE/Mh4MGSf0z42/MdSrlIm1cKcfbDU+Ur4IgHru8kz/
         b2LhPKedbTBA2FMHRuV0JY3KaDnzz2IE0LWxICsbk7cYiHgopycHEHC7T9UHkg3+15zM
         PWTk1rtwS1+1ONb8uF2qqr5y78dD1Qr9CvTk9ay5PJA0+IR7/tuNvCyjSOy+4lpX9Nvy
         Oc8QY1wTnpWC5Qq00q+mv6uDTTSAHOcvrAkWKU4khxbsTYeWD8qe60lqoQ6gQypOre+S
         DGFIbW+LD/Sg+sH09iEwlZkggJd6DIFQSq3KVS5SYk2pe1zzkU959hfRsJV8Rde9jgue
         DnRw==
X-Forwarded-Encrypted: i=1; AL+hErF0ZB2lIXZlIBuLFrP9bBh4XfU/KyhNou0aN8zLa/0DxiInQzu/l2UbTRIFKK809OqduNMTxpY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G6jexqShU9uRZLc+yk1JwV4HOGoG5idkoYB3VeVPKzaA1Jctk
	317/cnytYbEopj4DlDSYEWfvvVi9OQwXdS/2elzHlCVYqf6zqd6W4zoksR++k4witA==
X-Gm-Gg: AZFdTZdZtB99jn21qCSOfwsaUxmaie6EaIpK60R+/J8ydhrD1KntRhaNTJEVr1QYY8D
	Mv6MfZtlNoc+/+tZjyAhROxx0u9st67En0Ecxpfz2g+5qJAgYAIinQ097IAp8WqlMKL924tbUId
	zf8Kd/Jlj2eaCgyP9xeIlN4XGuCYkcXa5nzzeB8xaK/4M64GFnLkMwYMaACU5KVLUjf/JZx77DM
	kk3fvxT5alfGsfDG+yWvNWVKspI6+2O59Vld8/bHH+NlqqPOISajmR7wBkbrlcXXdsVd17uLny6
	Eq4Em4C2Fyxd21WmXRgpeJH5GXU6ZPgF4HHmX8Jpv1/tQn+g4Htio7LpqISmmtKXPImUurqWDVb
	tHQ5GR59+zq0NaM1SenzTShPqRLnZrhtHLxONSAflWepjqWfQ5vDhR5rLFHtWC3IJ96eAqRk5H0
	K/QZCxn5GeT6MglolnrkRE8CMbM8eJUddAGRiQrA3kzdBnSBlDT6Oo3J+B567Kg64uub+ZJ07NB
	5XqEr0E1WrNo4EOS1SVQ7TLKzSmPFNy7SLh0BW8RxA3CHmMd7BeG7QXdX3RCkNKEu3Cy58MmcP4
	miiELurRvkrHsDRhaXS/DRGKfKObIltzb4sc7CIMeWlDgQr8G2Okk4DSCHAWa3/MKSynSMse/Hy
	VhEasRkmv+TT4m5ZS28PnDfirM0EvBBtByUFAuYA8F1VfpoBoY7xqTmWgPA4p2EcwMp22wTWM1g
	VoJPwb9LlpJKbjk5zWXy3ZzuhkTxAmaaz8xt7Hbiy+kuNOoGqbxu82YTg=
X-Received: by 2002:a17:90b:28cf:b0:3ac:8dfe:8ec9 with SMTP id 98e67ed59e1d1-3b1b0b47416mr9375279a91.47.1794853034181;
        Mon, 16 Nov 2026 10:17:14 -0800 (PST)
Received: from google.com ([2a00:79e0:2e87:6:9050:473d:cdf:7c63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac70ea45sm272890a91.17.2026.11.16.10.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:17:12 -0800 (PST)
Date: Mon, 16 Nov 2026 10:17:07 -0800
From: Nick Desaulniers <ndesaulniers@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2] qca_spi: Avoid unsequenced accesses to jiffies in
 qcaspi_netdev_tx_timeout()
Message-ID: <avtIOfLOG3x0TRey@google.com>
References: <20261115-qca_spi-wunsequenced-v2-1-8cf32f12d546@kernel.org>
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
In-Reply-To: <20261115-qca_spi-wunsequenced-v2-1-8cf32f12d546@kernel.org>

On Sun, Nov 15, 2026 at 09:45:22PM -0700, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in
> qcaspi_netdev_tx_timeout(), which can break the build with
> CONFIG_WERROR=y / W=e:
> 
>   drivers/net/ethernet/qualcomm/qca_spi.c:805:16: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>     805 |                     jiffies, jiffies - dev_trans_start(dev));
>         |                     ~~~~~~~  ^
> 
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
> 
> Printing jiffies on its own is not that useful for debugging transmit
> timeouts, so get rid of it to clear up the warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2197

Just hit a handful of these last week; thanks for getting issues filed
per (I thought it was just one instance; having one issue per makes its
clearer this is flagging a few more cases. Thanks for sending fixes for
these, too).

> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> Changes in v2:
> - Eliminate printing jiffies entirely rather than using a local variable
>   (Stefan)
> - Link to v1: https://patch.msgid.link/20261114-qca_spi-wunsequenced-v1-1-6b219b906db7@kernel.org
> ---
>  drivers/net/ethernet/qualcomm/qca_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
> index 38a779f4b866..249b4b549a12 100644
> --- a/drivers/net/ethernet/qualcomm/qca_spi.c
> +++ b/drivers/net/ethernet/qualcomm/qca_spi.c
> @@ -801,8 +801,8 @@ qcaspi_netdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  {
>  	struct qcaspi *qca = netdev_priv(dev);
>  
> -	netdev_info(qca->net_dev, "Transmit timeout at %ld, latency %ld\n",
> -		    jiffies, jiffies - dev_trans_start(dev));
> +	netdev_info(qca->net_dev, "Transmit timeout, latency %ld\n",
> +		    jiffies - dev_trans_start(dev));
>  	qca->net_dev->stats.tx_errors++;
>  	/* Trigger tx queue flush and QCA7000 reset */
>  	set_bit(SPI_RESET, &qca->flags);
> 
> ---
> base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
> change-id: 20261114-qca_spi-wunsequenced-a81e54616844
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 
