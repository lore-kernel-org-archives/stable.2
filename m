Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9B18FDDE;
	Sat,  6 Jun 2026 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712239; cv=none; b=P8HdVL2AzggLIkBGWe+gKGLILmA6mYL3SJqFvYVfgcixqlvdVKwLsx3hAIzD8MT5QDwZPxeUpFTjsvsDdkzfi5qUh0Va1z215Lt24bj5KU2MYyQ/fWZu/SHJg2I8gwEiRlTFrkDQIsImx7X463xG4hK+fkwOcLmA9e9vB5Yh0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712239; c=relaxed/simple;
	bh=4PYcPlBuopRQJ/M7A1ZOntsm/pQ6Pdl6RGzjAAczD3c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RJRoYsyJhtoxSoKhWnfK/0TxsaL+AsKJK39BQYvduOomf4nwUVxQBHaL51H0W7SfpD4QgfO2Mkj+24lkeoz8HA1p4rOkK3u7s4hxrOipmHkgveod/EmAcB0ehCMqWOr1axJz0NkNFY0I9yJ4OtinoRprwpUy6JVHdGM9sGyvht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3DWM4Nd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3DWM4Nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74B31F00893;
	Sat,  6 Jun 2026 02:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780712237;
	bh=ztGn2nlySXSFbh8NnrJd3rQnSeLfdguQBF//iLPQjnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T3DWM4NdDiExnvViBz3etB+xH2qubwa4eatNE71v8bDi1elQFi1GZJo9hqG9XqHy7
	 NylGpFn3v3RQSch+RUQJC7IeZ3tWn0nStceGwquUpksdPHROq4Y9mYP6N8Eme6/9OA
	 yWXdJJJEvDR1+vIjOGPx6QpMU46p+cibPlT3QBuz9d3Mxc1etdJW2FMQPudTyna7Eg
	 XkFNM5oO/IXBU4NVWUEHtS1IyxJmS5rTOyQSBdKNTeSpslUvUjrghEuESHHMw8wtYh
	 7wzgtQWyQ9z6Af2cKPfAyucRSjCtfZ1MYJk2ylYLlQO8DGJBGgzb6ft8Au2jwVgfqR
	 tp0A/nfZvGvMg==
Date: Sat, 6 Jun 2026 11:17:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sami Cclvanen
 <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Eva Kurchatova
 <eva.kurchatova@virtuozzo.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cfi: Include uaccess.h for get_kernel_nofault()
Message-Id: <20260606111712.c004ecfb4a590a20b4ccb909@kernel.org>
In-Reply-To: <20260604-tracing-fix-cfi-h-build-error-v1-1-b27015390901@kernel.org>
References: <20260604-tracing-fix-cfi-h-build-error-v1-1-b27015390901@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Jun 2026 17:33:21 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> After commit 0652a3daa787 ("tracing: Fix CFI violation in probestub
> being called by tprobes"), there are many build errors when building
> ARCH=arm multi_v7_defconfig + CONFIG_CFI=y like:
> 
>   In file included from drivers/base/devres.c:17:
>   In file included from drivers/base/trace.h:16:
>   In file included from include/linux/tracepoint.h:23:
>   include/linux/cfi.h:44:6: error: call to undeclared function 'get_kernel_nofault'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      44 |         if (get_kernel_nofault(hash, func - cfi_get_offset()))
>         |             ^
>   1 error generated.
> 
> get_kernel_nofault() is called in the generic version of
> cfi_get_func_hash() but nothing ensures uaccess.h is always included for
> a proper expansion and prototype. Include uaccess.h in cfi.h to clear up
> the errors.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0652a3daa787 ("tracing: Fix CFI violation in probestub being called by tprobes")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Oops, good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  include/linux/cfi.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/cfi.h b/include/linux/cfi.h
> index 1fd22ea6eba4..0f220d29225c 100644
> --- a/include/linux/cfi.h
> +++ b/include/linux/cfi.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/module.h>
> +#include <linux/uaccess.h>
>  #include <asm/cfi.h>
>  
>  #ifdef CONFIG_CFI
> 
> ---
> base-commit: 0652a3daa78723f955b1ebeb621665ce72bec53e
> change-id: 20260604-tracing-fix-cfi-h-build-error-36c2becf7d15
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
