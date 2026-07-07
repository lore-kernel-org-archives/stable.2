Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025830D403
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453514; cv=none; b=S/ZA647pN+negDRah+ygBQtBSizzOQGT/Y95iiUtBv0gUpW+RwblLE82dwzYGDG40l+mleCERA1ERD2GWYuZNl+hONfyaeFImBrbtYrDf3JX3R3HTNzAwkqo71vvYDEq9Zqt0H08JwEEHjL9avqR71XyednUymBtIBKPs1+kGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453514; c=relaxed/simple;
	bh=vpfGcDaKn93kO0c0pBHut+lxXP6vFT8v6Ae7YDmYrQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6IWzhduaK2cS1T9rhJC3mb4JyAnz9d0aAC1Z+ka7yUbP1eug7075kvVN6qf1VsIGAe4JJAQj/K26O/xDiGUGqtzONxN++uEjGTGAbZox+cgzyjKZVNxfWVgFdIk0u519GRg06ji63gJ/shG2Sjwf+D6ccuTfAV3XaR7xaWHPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XA6YjNGE; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XA6YjNGE"
Message-ID: <bec46089-abc2-418e-9b27-34dd9f6d1dde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783453500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa9GDRjYxkf/DCTXoRTIYtmmpV/5FZvirgY/VRgV3Dg=;
	b=XA6YjNGECwbiVp7XCLdWtDjDiszb+KoKrNuUEq50kBFjzH2naO39dtx+ZXnoY5ekQOi+wi
	ysny/gl4qtDZCJXQg1arirNYR0APMwJfNeNmhiubvju/il8C96lBttCZNrRqO6B6fgASKn
	KHZ9HyHvDuGlXHGhf+ehkd0JX+6dyyU=
Date: Tue, 7 Jul 2026 12:44:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] resolve_btfids: preserve tag and parameter names when
 processing implicit args
To: Henrik Grimler <henrik@grimler.se>
Cc: Aelin Reidel <aelin@mainlining.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260620-resolve-btfids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org>
 <0606be50-1f21-438f-bf00-024f31b9eda8@linux.dev>
 <20260707075500.GA10854@localhost>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260707075500.GA10854@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/7/26 12:55 AM, Henrik Grimler wrote:
> Hi Ihor,
> 
> On Thu, Jun 25, 2026 at 10:26:27PM -0700, Ihor Solodrai wrote:
>> [...]
>>
>> However you have a stable reproducer, so your strdup() change probably
>> covers a real UAF bug somewhere else (in libbpf?).
>>
>> Let's track this down before coming up with a fix.
>>
>> What version/commit of libbpf are you using in your kernel tree?
> 
> I use the same build environment as Aelin and get the same issue with
> resolve_btfids from linux v7.1.1. System libbpf is at v1.7.0 [1] (but
> I guess this is not relevant? resolve_btfids is not linked against
> it).
> 
>> You could build resolve_btfids with ASAN, or run it with valgrind.
> 
> Valgrind reports some invalid reads, see log here:
> https://grimler.se/files/valgrind-resolve-btfids.txt
> 
> and if run under gdb I get:
> 
> ```
> $ gdb -ex r --args tools/bpf/resolve_btfids/resolve_btfids --fatal_warnings --verbose --btf .tmp_vmlinux1.BTF.1 .tmp_vmlinux1
> [ ... ]
> found kfunc tcp_reno_ssthresh in BTF_ID_FLAGS bpf_tcp_ca_check_kfunc_ids
> found kfunc tcp_reno_undo_cwnd in BTF_ID_FLAGS bpf_tcp_ca_check_kfunc_ids
> found kfunc tcp_slow_start in BTF_ID_FLAGS bpf_tcp_ca_check_kfunc_ids
> resolve_btfids: function bpf_list_push_back_impl already exists in BTF
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7f7aaa0 in memcpy (dest=0x7fffebb05a93, src=<optimized out>, n=5) at src/string/memcpy.c:23
> warning: 23     src/string/memcpy.c: No such file or directory
> (gdb) bt
> #0  0x00007ffff7f7aaa0 in memcpy (dest=0x7fffebb05a93, src=<optimized out>, n=5) at src/string/memcpy.c:23
> #1  0x000055555559865b in _ZL6memcpyPvU17pass_object_size0PKvU17pass_object_size0m (__od=0x7fffeb115c71, __os=0x7fffeb115c71, __n=5) at /usr/include/fortify/string.h:57
> #2  strset__add_str (set=0x7fffebb85fd0, s=s@entry=0x7fffeb115c71 <error: Cannot access memory at address 0x7fffeb115c71>) at strset.c:162
> #3  0x0000555555587b2c in btf__add_str (btf=btf@entry=0x7fffebb860a0, s=0x7fffeb115c71 <error: Cannot access memory at address 0x7fffeb115c71>) at btf.c:2109
> #4  0x00005555555898b1 in btf__add_func_param (btf=0x7fffebb860a0, name=0x7fffeb115c71 <error: Cannot access memory at address 0x7fffeb115c71>, type_id=11011) at btf.c:3108
> #5  0x000055555555de50 in process_kfunc_with_implicit_args (ctx=0x7fffffffd7d0, kfunc=0x7fffebb739a0) at main.c:1196
> #6  0x000055555555cc02 in btf2btf (obj=0x7fffffffd868) at main.c:1229
> #7  0x000055555555b869 in main (argc=1, argv=0x7fffffffec08) at main.c:1535
> ```
> 
>> If you can share a reproducer that's easy to run, that would be
>> great too.
> 
> I have uploaded .tmp_vmlinux1 and .tmp_vmlinux1.BTF.1 files (for an
> ARM kernel) that reproduce the issue here:
> 
> https://grimler.se/files/tmp_vmlinux1
> https://grimler.se/files/tmp_vmlinux1.BTF.1

Hi Henrik,

Thanks for the reproducer and the logs, very helpful.
The crash you hit is a real UAF that was recently fixed in libbpf:

    b23705e6afb6 ("libbpf: Fix UAF in strset__add_str()") [1]

strset__add_str() reallocs its buffer, then copies from a string that
may point into that same buffer (what btf__name_by_offset() returns)
dangling after the realloc.

I ran unpatched resolve_btfids under valgrind on your binaries,
toggling only b23705e6afb6.

Reverting b23705e6afb6:

    Invalid read of size 1
       at memmove
       by strset__add_str (strset.c:162)
       by btf__add_str (btf.c:2109)
       by btf__add_func_param (btf.c:3118)
       by process_kfunc_with_implicit_args (main.c:1196)
       by btf2btf (main.c:1229)
       by main (main.c:1535)
     Address 0x11dfb901 is 22,721 bytes inside a block of size 1,787,619 free'd
       at realloc
       by libbpf_add_mem (btf.c:224)
       by strset_add_str_mem (strset.c:106)
       by strset__add_str (strset.c:157)

      [...]

    ERROR SUMMARY: 5 errors from 2 contexts

With b23705e6afb6 there are no errors.

resolve_btfids statically links the in-tree tools/lib/bpf, so system
libbpf 1.7.0 is irrelevant, as you correctly noted. v7.1.1 predates
b23705e6afb6, which is why you are seeing the crash. It's been merged
into 7.2-rc1, so it will be in the 7.2 release.

I suggest you apply b23705e6afb6 for your build.

Let's drop this resolve_btfids patch, since the root cause has already been fixed.

Thank you!

[1] https://lore.kernel.org/bpf/20260523162722.2718940-1-cmllamas@google.com/

> 
> When resolve_btfids is compiled with musl and alpine's toolchain, then
> the following command segfaults roughly 50 % of the time:
> 
> tools/bpf/resolve_btfids/resolve_btfids --fatal_warnings --verbose --btf tmp_vmlinux1.BTF.1 tmp_vmlinux1
> 
> With a resolve_btfids compiled for glibc it does not segfault, but valgrind still reports invalid reads.
> 
>> Thanks!
> 
> [1] https://gitlab.alpinelinux.org/alpine/aports/-/blob/master/main/libbpf/APKBUILD#L3
> 
> Best regards,
> Henrik Grimler

