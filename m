Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4163BB139
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281705; cv=none; b=UnXOjw7K239Eh5spBo1HKDbCzsydqwvKet2EPp6lVE/YF9skmegwKmWtlji+/OR9zOXcyyr+AHkUJab+hlCQz/wu0hsYP2rk+scJO2mIAIzK8DMTtFj23o8bDGzi7vJDCgDpI7BokIj4KtGi9E2oL+2E7KXDXoA7DjS6mSUmWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281705; c=relaxed/simple;
	bh=wBAOgIgAbvvxEQrsQYZ/dU77eCtLUyXszY1VQs6hoRk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ku/lNIM9EqNaSVgPC5eoBkN5MVkX/7wzs6CcQ6Y16ZSUuxfCB/zDND9lN6oHgGLcPT+uELtk3+7GvecM6hFsiCfjwU0DdJRz0A7svD7/0HxD8aEWkfCxqWIpvVrrzIygxxk7GgUjUSE/3inMWrYpXc0c0F3qFNpjSvn8p1BbHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikn+WLFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikn+WLFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658CF1F000E9;
	Tue, 28 Jul 2026 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785281703;
	bh=D6vNVY2kw/nlAr813AX7X5hte7wKl2wDO41oILCtu64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ikn+WLFyfCfViN6+BGa+CYSrWHumEFsqk0WHfxWGNiWsZeKbBZrubC0Er/GIC+EcT
	 UBbJ8uQUYEit0CnZt8pZqvPEdA5xsiSQgLVMVugowO9Alx3udUcOj3gYAnuIpgDAqq
	 NRWg8wk5lTwSrS3E6YMBzpgrqSTKQ8BjijroxUEEWEI7iLEC+exkmPIWWhSwgNxfy6
	 ggz9FAZVCgwCa7S/e0JBaF1vCjL0/wtmgyAgZdE6rS5fFqA2dSpbKyysNkHBeiZ79q
	 /4uGDYnAWn9Nddx+cf+22Ukk8CA2DNwIMtlEOrNLkd5Blte1DquRJ6UK8CRkFm6/Ju
	 K5jdG7GKL9Ncw==
Date: Wed, 29 Jul 2026 08:34:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y 1/3] bootconfig: do not put quotes on cmdline
 items unless necessary
Message-Id: <20260729083459.366013da57b7df11f5e8638e@kernel.org>
In-Reply-To: <20260728221750.745951-1-sashal@kernel.org>
References: <2026072113-skintight-barometer-812e@gregkh>
	<20260728221750.745951-1-sashal@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks Sasha for backporting the series!

These look good to me!

On Tue, 28 Jul 2026 18:17:48 -0400
Sasha Levin <sashal@kernel.org> wrote:

> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> [ Upstream commit 212f863fa8811c780abacc1d0404c573fdc0a2de ]
> 
> When trying to migrate to using bootconfig to embed the kernel's and
> PID1's command line with the kernel image itself, and so allowing changing
> that without modifying the bootloader, I noticed that /proc/cmdline
> changed from e.g.
> 
>   console=ttymxc0,115200n8 cma=128M quiet -- --log-level=notice
> 
> to
> 
>   console="ttymxc0,115200n8" cma="128M" quiet -- --log-level="notice"
> 
> The kernel parameters are parsed just fine, and the quotes are indeed
> stripped from the actual argv[] given to PID1.  However, the quoting
> doesn't really serve any purpose and looks excessive, and might confuse
> some (naive) userspace tool trying to parse /proc/cmdline.  So do not
> quote the value unless it contains whitespace.
> 
> Link: https://lkml.kernel.org/r/20240320101952.62135-1-linux@rasmusvillemoes.dk
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: dec4d8118c17 ("bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  init/main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 4e9c76a0e5a478..f9e98fb3a3e098 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -328,7 +328,7 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
>  {
>  	struct xbc_node *knode, *vnode;
>  	char *end = buf + size;
> -	const char *val;
> +	const char *val, *q;
>  	int ret;
>  
>  	xbc_node_for_each_key_value(root, knode, val) {
> @@ -346,8 +346,14 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
>  			continue;
>  		}
>  		xbc_array_for_each_value(vnode, val) {
> -			ret = snprintf(buf, rest(buf, end), "%s=\"%s\" ",
> -				       xbc_namebuf, val);
> +			/*
> +			 * For prettier and more readable /proc/cmdline, only
> +			 * quote the value when necessary, i.e. when it contains
> +			 * whitespace.
> +			 */
> +			q = strpbrk(val, " \t\r\n") ? "\"" : "";
> +			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
> +				       xbc_namebuf, q, val, q);
>  			if (ret < 0)
>  				return ret;
>  			buf += ret;
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
