Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE52D2496;
	Tue, 30 Jun 2026 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860779; cv=none; b=kCj4dvCoMh+lg0t1xLQCnJQFsMmP/l4EONaWqy6yOWEMypKdRnEQGiGIjHOIPGe5WdtihIwGnanEBufYwp6h3vg6jtcFZ9faOAn7BWn8lz3NqM6fxhOBVRsRbMhSMuAcEheFZhDBu9vSF+nLzIQizphS0SsWUSzkll2l6m+KCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860779; c=relaxed/simple;
	bh=L0YdNEn01usZ5HFVBmt/SJpuNkxX/zV7tbw6fpz1UlQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BW1xsXVMWOfnr8VXO/V9gO3vJamx/HxwKOGZWuZNV2YUaONuzDdS7XBM1vIaMCLesmG2kCkTVO5FnYWfwSRHjWFovnVBAcgOI9YmlrkKN+YsGp3e2lZ5J50zZ4in/ci0o5ANMJKNozO+dOh2ufN28po8BA/HKK9lpJvhxU9M/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc/ghFFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc/ghFFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6881F000E9;
	Tue, 30 Jun 2026 23:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860778;
	bh=n1UCvvhGUs9c34ulNz3yl2igsM3qXoph0EPgLkRotzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kc/ghFFUqWWQhABkIJ3FNrCqd/8xhHOorvN7bevAdNneaLBNBLr0JTVmxDI5ZNoIC
	 exbw5RQKXLCsnu1Qy96lWYje8VuGlHmuBb/kHZsJVsUCiIVkhHgNgaOl5YsqPuMgUp
	 G/rQnBtlhczB6zdFhZZh5WtkV/cn/sdxy4NZn1MAzbcKXDjPk+uuLqvoci6CqRVl4Q
	 x5yhQR49DGTzHxIKeZYqdwHOO+ZM5EjbtpeNQ8Sk2fs1tzoHbd/aaDx3774lroD/u3
	 uLpsCA6UH1xTdruFE06PN2UWU9zYxJN11mVtPcRNMxbVCCBtK+fAgcm1K2gb1VP5Ep
	 ohI6Kk4/tBJwg==
Date: Wed, 1 Jul 2026 08:06:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] lib/bootconfig: fix undefined behavior involving
 NULL pointer arithmetic
Message-Id: <20260701080614.96639cb0bfb97eb70e1d6177@kernel.org>
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

Oops, Breno already did it.

https://lore.kernel.org/all/20260626-bootconfig_using_tools-v7-1-24ab72139c29@debian.org/

Let me drop this patch since it makes a conflict with Breno patch.

Thanks, 

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
