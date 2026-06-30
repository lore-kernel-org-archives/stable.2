Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67C21CC51;
	Tue, 30 Jun 2026 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860329; cv=none; b=HVfPa5ZfeS6oHubyBlQ760E5HSRTLUymde3WUOagDhCDrMTzBfugt9F/FDrKFCYtxLjELB905TMeL3j9qYByR+2SuDWiMvWx3cH3vRHyWSwwTFz3F+2vh59hfmFblb8uP0zRr0wFNI84QGQB/QBtSlD4HPeD5THnS8+Oms125yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860329; c=relaxed/simple;
	bh=aq9jJsGvYEawxXGAy0iuy6oK59s02bFHbdyTTS22zLs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OnS3jfucg5Exo/3vMgfbNkD15RU8e/F7PxQR4tLZZSWOMrzrtCpEtoG5d3uyxsU+OLdqZsUyjk/TSFuxzzzKbkHJCQpVhxm7D6lDAJSFgXJ8fZzLjEFGST/jj2eeQqGerseRbQDVFT4kRiQ2R7t4QEgP6T9RZMyUdbo/WIbl5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5f/0Kqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5f/0Kqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD7A1F000E9;
	Tue, 30 Jun 2026 22:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860327;
	bh=LzgO/WtP3CHsUyiGKcx7YHKu/av/Fuaej/8zHHRDb7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P5f/0Kqj6lvAulhzPauZEJUAACK0UeYeG67JPeOoa7qkcO1dP7Myuuhm4UNucWKW2
	 9wyUc/pJrFwZNZJK4e3fwBHIyN2qhib0otVdORx2OTuX8JypEzFW1zSdHGvaI+e3kG
	 F0D9X3WwbFvOQwBCsqfAWFWi53X9n/FbXJQND2VazLnhy63w8RJB9CqUz+PmL0q2c3
	 Xsuj2OJn52BohKAcEmdS4AwsoicttbXsbDSbdnBo+tTB6zm879yreGjfM+nn3INXaF
	 vVm/pKAas7BfW29vrOIlstDTbcSg2QmhyRtaxg/QthsnkKzETOb4VMGdzoPa+jbWiV
	 SxcxGhczVzkkg==
Date: Wed, 1 Jul 2026 07:58:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] lib/bootconfig: fix undefined behavior involving
 NULL pointer arithmetic
Message-Id: <20260701075843.a308d7dadf327eda4015236b@kernel.org>
In-Reply-To: <20260630174746.14795-1-include@grrlz.net>
References: <20260630174746.14795-1-include@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 17:47:46 +0000
Bradley Morgan <include@grrlz.net> wrote:

> When xbc_snprint_cmdline() is called during the size-probing phase
> (with buf = NULL and size = 0), the function computes the end pointer
> as 'buf + size' (NULL + 0) and repeatedly advances 'buf' via 'buf += ret'.
> 
> Under the C standard, performing pointer arithmetic on a NULL pointer is
> undefined behavior. While harmless inside the kernel, this code is also
> compiled into the userspace host tool 'tools/bootconfig', where host
> compilers with UBSan or FORTIFY_SOURCE enabled abort the build when they
> detect NULL pointer arithmetic.
> 
> Fix this by guarding the pointer arithmetic so 'buf' is only advanced when
> non-NULL, and track the running written length in a separate 'len' counter
> for the return value (which cannot be recovered from pointer math when
> 'buf' is NULL). The rest() helper and snprintf call sites are unchanged.
> 
> Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
> Cc: stable@vger.kernel.org
> Assisted-by: GLM:glm-5.2
> Signed-off-by: Bradley Morgan <include@grrlz.net>

Thanks for the fix!
Let me pick this to bootconfig/fixes.

Thank you,

> ---
>  lib/bootconfig.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> Changes since v1:
> - Got the big guns out! :) (see Assisted-by).
> - Addressed review from Masami Hiramatsu and Breno Leitao.
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index f445b7703fdd..c913259c80ce 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -427,8 +427,9 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
>  int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
>  {
>  	struct xbc_node *knode, *vnode;
> -	char *end = buf + size;
> +	char *end = buf ? buf + size : NULL;
>  	const char *val, *q;
> +	size_t len = 0;
>  	int ret;
>  
>  	xbc_node_for_each_key_value(root, knode, val) {
> @@ -442,7 +443,9 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
>  			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
>  			if (ret < 0)
>  				return ret;
> -			buf += ret;
> +			len += ret;
> +			if (buf)
> +				buf += ret;
>  			continue;
>  		}
>  		xbc_array_for_each_value(vnode, val) {
> @@ -456,11 +459,13 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
>  				       xbc_namebuf, q, val, q);
>  			if (ret < 0)
>  				return ret;
> -			buf += ret;
> +			len += ret;
> +			if (buf)
> +				buf += ret;
>  		}
>  	}
>  
> -	return buf - (end - size);
> +	return len;
>  }
>  #undef rest
>  
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
