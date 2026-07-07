Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02C175A91
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410911; cv=none; b=E9Y9LhxBSiLaYV9FylwAEJ4n0X++1w0fRllMhuIQpf4PdSJ/B7BrHScgo7V636tqkVXQ5uKsUqyzS3w1iWIKqF0zZ7We0UqN1DmoFjbVbw8aOyUTNVvDJTgfnUkSUqU0shBLVok9zf65QvC267ZODFrVVyVmrHOXIgK6TaDBn64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410911; c=relaxed/simple;
	bh=/8OfFJPxd16gmKEv9BIH5kqe7oCrFM5n9xUnUc3AWyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWzWfVPFB/xL+i2Tnei8deckJahqFyBYS41FqBa4AZWktOzLmtVLcbhjwqfapXFpKo9KyG46aqyW8ndetE0UM0WCDqBOlQwtB+oWZaR2a/0CyJxJLzBHD1alThhuULeHGv5maasnqOaKnQlVPZAJbVYkHutfy9d6vYNue+VLALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=I2dbMFSb; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="I2dbMFSb"
Date: Tue, 7 Jul 2026 09:55:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1783410905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3ihn2xUU6xDos+/B+hJSXLBdz5rrV0eg6AHLWOipW0=;
	b=I2dbMFSboh/zQjVcz/+0GpOtr8DL1l6GXWecpImZ0A3ZPzP5y5z7NkVjft43M6ndqJgF0t
	b33rHS+BZTlPLJOd6N91qDYoTfPWRkkzeMesuZ2R0MQQNRGq8M6jEBeQBQPouNJRBB0GU0
	8Q0ndEIC1PKeG0SamAKSaO4Vw9w1YO0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Aelin Reidel <aelin@mainlining.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] resolve_btfids: preserve tag and parameter names when
 processing implicit args
Message-ID: <20260707075500.GA10854@localhost>
References: <20260620-resolve-btfids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org>
 <0606be50-1f21-438f-bf00-024f31b9eda8@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0606be50-1f21-438f-bf00-024f31b9eda8@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi Ihor,

On Thu, Jun 25, 2026 at 10:26:27PM -0700, Ihor Solodrai wrote:
> On 2026-06-19 3:49 p.m., Aelin Reidel wrote:
> > process_kfunc_with_implicit_args() obtains parameter names through
> > btf__name_by_offset() and passes them to btf__add_func_param() while
> > constructing a new function prototype. Tag names are processed in a
> > similar fashion.
> > 
> > The returned name pointer references memory owned by the BTF object.
> > btf__add_func_param(), btf__add_decl_tag(), etc. modify the same BTF and
> > may grow its internal storage, invalidating previously returned string
> > pointers.
> > 
> > This can result in btf__add_func_param(), btf__add_decl_tag(), etc.
> > dereferencing a stale pointer when copying the string, leading to crashes
> > in strset__add_str().
> > 
> > Duplicate the parameter name before calling btf__add_func_param() so it
> > remains valid across BTF updates.
> > 
> > Fixes: 9d199965990c ("resolve_btfids: Support for KF_IMPLICIT_ARGS")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aelin Reidel <aelin@mainlining.org>
> > ---
> > We were noticing resolve_btfids crashing almost all the time when
> > building our kernels with BTF debuginfo in postmarketOS. I'm not sure
> > why specificially our environment triggered this extremely reliably, but
> > I'm glad I was able to track down the issue. With the patch, I haven't
> > seen any further issues and our kernel builds are succeeding again.
> 
> Hi Aelin, thank you for the report and patch.
> 
> My first instinct was to dismiss the patch as over defensive, because
> libbpf gracefully handles reallocation of existing strings, and we
> don't add new strings here.
> 
> Take a look at strset_str_append() in libbpf (strset.c:131):
> 
> 	static long strset_str_append(struct strset *set, const char *s)
> 	{
> 		[...]
> 
> 		/*
> 		 * The set->strs_data might have reallocated and if 's' pointed
> 		 * to an internal string within the old buffer, then it became
> 		 * dangling and needs to be reconstructed before the copy.
> 		 */
> 		if (old_data && old_data != (uintptr_t)set->strs_data &&
> 		    old_s >= old_data && old_s < old_data + old_data_len)
> 			s = set->strs_data + (old_s - old_data);
> 
> 		memcpy(p, s, len);
> 
> 		return len;
> 	}
> 
> In process_kfunc_with_implicit_args() both tag_name and param_name are
> read *after* the first btf__add_func() / btf__add_func_proto() has
> made the BTF modifiable, so btf__name_by_offset() should return a
> pointer into btf->strs_set. I don't see where the bad pointer comes
> from.
> 
> However you have a stable reproducer, so your strdup() change probably
> covers a real UAF bug somewhere else (in libbpf?).
> 
> Let's track this down before coming up with a fix.
> 
> What version/commit of libbpf are you using in your kernel tree?

I use the same build environment as Aelin and get the same issue with
resolve_btfids from linux v7.1.1. System libbpf is at v1.7.0 [1] (but
I guess this is not relevant? resolve_btfids is not linked against
it).

> You could build resolve_btfids with ASAN, or run it with valgrind.

Valgrind reports some invalid reads, see log here:
https://grimler.se/files/valgrind-resolve-btfids.txt

and if run under gdb I get:

```
$ gdb -ex r --args tools/bpf/resolve_btfids/resolve_btfids --fatal_warnings --verbose --btf .tmp_vmlinux1.BTF.1 .tmp_vmlinux1
[ ... ]
found kfunc tcp_reno_ssthresh in BTF_ID_FLAGS bpf_tcp_ca_check_kfunc_ids
found kfunc tcp_reno_undo_cwnd in BTF_ID_FLAGS bpf_tcp_ca_check_kfunc_ids
found kfunc tcp_slow_start in BTF_ID_FLAGS bpf_tcp_ca_check_kfunc_ids
resolve_btfids: function bpf_list_push_back_impl already exists in BTF

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7f7aaa0 in memcpy (dest=0x7fffebb05a93, src=<optimized out>, n=5) at src/string/memcpy.c:23
warning: 23     src/string/memcpy.c: No such file or directory
(gdb) bt
#0  0x00007ffff7f7aaa0 in memcpy (dest=0x7fffebb05a93, src=<optimized out>, n=5) at src/string/memcpy.c:23
#1  0x000055555559865b in _ZL6memcpyPvU17pass_object_size0PKvU17pass_object_size0m (__od=0x7fffeb115c71, __os=0x7fffeb115c71, __n=5) at /usr/include/fortify/string.h:57
#2  strset__add_str (set=0x7fffebb85fd0, s=s@entry=0x7fffeb115c71 <error: Cannot access memory at address 0x7fffeb115c71>) at strset.c:162
#3  0x0000555555587b2c in btf__add_str (btf=btf@entry=0x7fffebb860a0, s=0x7fffeb115c71 <error: Cannot access memory at address 0x7fffeb115c71>) at btf.c:2109
#4  0x00005555555898b1 in btf__add_func_param (btf=0x7fffebb860a0, name=0x7fffeb115c71 <error: Cannot access memory at address 0x7fffeb115c71>, type_id=11011) at btf.c:3108
#5  0x000055555555de50 in process_kfunc_with_implicit_args (ctx=0x7fffffffd7d0, kfunc=0x7fffebb739a0) at main.c:1196
#6  0x000055555555cc02 in btf2btf (obj=0x7fffffffd868) at main.c:1229
#7  0x000055555555b869 in main (argc=1, argv=0x7fffffffec08) at main.c:1535
```

> If you can share a reproducer that's easy to run, that would be
> great too.

I have uploaded .tmp_vmlinux1 and .tmp_vmlinux1.BTF.1 files (for an
ARM kernel) that reproduce the issue here:

https://grimler.se/files/tmp_vmlinux1
https://grimler.se/files/tmp_vmlinux1.BTF.1

When resolve_btfids is compiled with musl and alpine's toolchain, then
the following command segfaults roughly 50 % of the time:

tools/bpf/resolve_btfids/resolve_btfids --fatal_warnings --verbose --btf tmp_vmlinux1.BTF.1 tmp_vmlinux1

With a resolve_btfids compiled for glibc it does not segfault, but valgrind still reports invalid reads.

> Thanks!

[1] https://gitlab.alpinelinux.org/alpine/aports/-/blob/master/main/libbpf/APKBUILD#L3

Best regards,
Henrik Grimler
