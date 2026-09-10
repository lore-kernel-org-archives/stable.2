Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DAE4BFE68;
	Thu, 10 Sep 2026 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000467; cv=none; b=O+zId+TXFAgXZV7QMGq9aQe3dXKuQzCZ/FQx1KCdw44a1YbqpcyayqnNaufM9R3QXL4qXD3WS6ULfRAiI9PLkHbE2ruNjKh5qv+1BnzKuBcp/BZTXswI8tlSuLB5cvvy1m3FD1LZfX9HDfSsWtnVTSR4hZdNHFjhZ3RK3ZW1dt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000467; c=relaxed/simple;
	bh=nfI70XfbB8Tg08XHW1UBeBZaszVmOJvGajs6CmBmAVM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PUMxIE3w02AEQtLOtlGon98TQ0W9pe70k84KgjU9fzON4nH8o6E9/3TmrBEPfENTAIPFK+r9rbDEJj2QnyxVT0vPN5h1WRdWHgeaMOwmrCPMgNIQk0HrplzubhdV8uK67ybrcxvJ1+RMdrkyT3dWprywmZNHAlKAYNZSJDF9gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAEoLplI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAEoLplI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989391F000FF;
	Thu, 10 Sep 2026 00:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789000466;
	bh=QD05iClpjTuKrQBi/AfupCRZI4bkgKtjfdTZMjzNS6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bAEoLplI6y5a5YG488KxlFSq8y3bnNNaWrNO+UktuWu85Zm8O8EIf2kDMpR+mzoyS
	 FBzVw2YCkYh8LNWKoG/i4OikOXrEooIAZCjdwfSJ7Oi8juik+n/WdpXEs37nsuJYYq
	 jp6UASYnabRrCOgOGgxFjEh0PVMkarAKBNdLRWkjc6hZQtqcp4h0xwLHFkbENvllyV
	 MBWattOSdZhBCr1EmBbBMIzW6aJ1Fws4nZ2ZiDLbCSOrHsEXHjYNeuC7nRMJjSFNO7
	 mFP+30rhKB40Gbdy8vrppitnchfBspDkNB61bWdj+/40PaMQaQ/MYHUG3b835Px4vv
	 4kKYa/fxkc9Fw==
Date: Thu, 10 Sep 2026 09:34:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Sang-Heon Jeon <ekffu200098@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Fix integer overflow in size check
Message-Id: <20260910093422.e24e680b0506c16af51b2bbd@kernel.org>
In-Reply-To: <178900024679.183840.10345859264677533824.stgit@devnote2>
References: <178900024679.183840.10345859264677533824.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 09:30:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Sashiko reported that on 32-bit systems, if the size in the bootconfig
> footer is corrupted such that adding BOOTCONFIG_FOOTER_SIZE wraps
> around (for instance, if size is 0xFFFFFFFF), the size check in
> load_xbc_from_initrd() can be bypassed:
> 
>     if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
>         pr_err("bootconfig size is too big\n");
>         return -E2BIG;
>     }
> 
> This would lead to load_xbc_fd() being called with a negative size,
> resulting in an undersized allocation, heap overflow on read, and
> out-of-bounds write on the terminating null byte.
> 
> Avoid the integer overflow by checking whether size is greater than
> stat.st_size - BOOTCONFIG_FOOTER_SIZE. Since stat.st_size is already
> verified to be at least BOOTCONFIG_FOOTER_SIZE earlier in the function,
> this subtraction will never underflow.
> 
> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260909161113.16C691F00A3A@smtp.kernel.org/
> Assisted-by: Antigravity:gemini-3.8-flash

OOps, I forgot to add:

Cc: stable@vger.kernel.org

Thanks,

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  tools/bootconfig/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 7dc9fff9b637..b380ad6777fa 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -218,7 +218,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
>  	csum = le32toh(csum);
>  
>  	/* Wrong size error  */
> -	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
> +	if (size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {
>  		pr_err("bootconfig size is too big\n");
>  		return -E2BIG;
>  	}
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
