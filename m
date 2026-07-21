Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C853367B91;
	Tue, 21 Jul 2026 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635166; cv=none; b=Jfcsq/0Setm94JqRYJtbOo0xKCE2OMm5bve/9jEWdBagzXjzicas4Nm9SqkMmasZZD4/lNZrKmMQmQlNwgTirL284EGq4ynvD9GOtw4EfjV9ZhBZ3o8cBrbaANBoT/kqFBNlaGLpr2zXct5+rMjoJZMaEuVESZoDvjkjIEqIHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635166; c=relaxed/simple;
	bh=Fg/Ynd45QyZ2Qi9Cszk1RMGXp9tDULgSi8RfIBTnXKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQb+VOP7lwTm4+EWDU+q5zWT81AsSXvRCjrIGzBw4F3qNaZXRYYvQrkSgbGAPZTCkjnRnnxEsbjEsYrcLB4i0oOBujLuek0uA/9R8U9Ed3dWJ//Rm1EjdIP0jRYbaFQaOWowjEhln0iYDb7Qw7c4XYZvab7/WjaUba5Sb+uNXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYkQRZtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYkQRZtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E511F000E9;
	Tue, 21 Jul 2026 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635164;
	bh=BkBqQeZsu4p5xalY28N6H1RbwRy6i2XBb+MX5uI0fsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aYkQRZtKJpV/raQruiEsjYECc85zx4lZfk6s9SiRSLQLW24Qvl/8WmIeOT9p5qnep
	 cDDAHEX4Nldfmq8M6KC4zYg7AvuVHhYKvgtm27+A2fureIEUb8dNttjqIbeOizdWuY
	 3TWkFSYlcmQavdGRC23mOPucFs9+4UEKQzhG2GN4ApfnHiiQNRVHkMpcREzIP2UC7r
	 WKSXP95OQZLAVwV7Mqv5BLSLstqitEwSD6k9ATyvnn1BUTzhntmQsli1yWWarI/KS6
	 PUkFYZ10/vNDaWgkN36CDsx8q8ccFa3kCB0QU+JtMPjFEho01+/8/8YHkO7RqXCFJl
	 ZSYIJ+QZ909EQ==
Message-ID: <5bc46ddf-f4b6-4f96-b97a-25339a5c7fef@kernel.org>
Date: Tue, 21 Jul 2026 13:59:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: fix unsigned loop counter wrap in
 transfer_args_to_stack()
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-mm@kvack.org, stable@vger.kernel.org
References: <20260721-hochachtung-staumauer-pigmente-15d71f7d7d04@brauner>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260721-hochachtung-staumauer-pigmente-15d71f7d7d04@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 12:08, Christian Brauner wrote:
> The stop value is derived from bprm->p >> PAGE_SHIFT. The index variable
> is an unsigned long. If bprm->p drops below PAGE_SIZE and stop becomes
> zero the loop condition index >= stop is always true.
> 
> After the index == 0 iteration the decrement wraps to ULONG_MAX and
> bprm->page[ULONG_MAX] reads sizeof(void *) bytes in front of the array.
> The pointer has wrapped to -1. That garbage pointer is then passed to
> kmap_local_page() and PAGE_SIZE bytes are copied from wherever that
> lands into the stack of the process being created. And the loop doesn't
> terminate either...
> 
> Getting there only requires bprm->p < PAGE_SIZE. On !MMU
> bprm_set_stack_limit() and bprm_hit_stack_limit() are empty. So the only
> constraint on how far bprm->p is pushed down is valid_arg_len(), i.e.
> that each individual string still fits in what is left.
> 
> bprm->p starts at PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *) so a
> single argument or environment string of a little over 31 pages leaves
> it in the first page:
> 
>   Oops - load access fault [#1]
>   CPU: 0 UID: 0 PID: 1 Comm: victim Not tainted 7.2.0-rc4 #1
>   epc : __memcpy+0xd4/0xf8
>    ra : transfer_args_to_stack+0xaa/0xae
>    s4 : ffffffffffffffff   s2 : 0000000000000000
>    a1 : ffffffdc98000000   a2 : 0000000000001000
>   status: 0000000a00001880 badaddr: ffffffdc98000000 cause: 0000000000000005
>   [<801a5324>] __memcpy+0xd4/0xf8
>   [<800d5f6a>] load_flat_binary+0x43a/0x65e
>   [<800a2de4>] bprm_execve+0x1d4/0x316
>   [<800a351a>] do_execveat_common+0x12e/0x138
>   [<800a3d44>] __riscv_sys_execve+0x38/0x4e
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> This is an arcane bug but we should still fix it.
> 
> Count down from MAX_ARG_PAGES so the loop ends when index reaches stop,
> stop == 0 included. The iterations performed are unchanged for every
> other value of stop.
> 
> Only CONFIG_MMU=n builds are affected, transfer_args_to_stack() is used
> by binfmt_flat and binfmt_elf_fdpic on nommu only.
> 
> The loop predates git history. commit 7e7ec6a93434
> ("elf_fdpic_transfer_args_to_stack(): make it generic") only moved it
> from binfmt_elf_fdpic.c into fs/exec.c and narrowed the copy to the used
> part of the first page. The condition and the decrement are unchanged
> from 2.6.12-rc2.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index d5993cedc829..c7b8f2d6366c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -740,7 +740,7 @@ int transfer_args_to_stack(struct linux_binprm *bprm,
>  	stop = bprm->p >> PAGE_SHIFT;
>  	sp = *sp_location;
>  
> -	for (index = MAX_ARG_PAGES - 1; index >= stop; index--) {
> +	for (index = MAX_ARG_PAGES; index-- > stop; ) {
>  		unsigned int offset = index == stop ? bprm->p & ~PAGE_MASK : 0;
>  		char *src = kmap_local_page(bprm->page[index]) + offset;
>  		sp -= PAGE_SIZE - offset;

LGTM, however, using signed variable would make that easier to understand.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>


-- 
Cheers,

David
