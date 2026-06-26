Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFD3A782A
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451607; cv=none; b=R1z8AQJPzAgQyTiH2lJ1DUIGJLRVWTh2muMgmMrAArqWG91LuOLz652xGTjQ0ucXTWcLqzV6vGjCeextvV8zt1j39GSOoe6s0E+k/MqXjIL2SiUmpcBaQ4YnyIoP01cd22lXUnyvstJf2DDDHCQG41pXHyNnfQQn7s6gEli4F1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451607; c=relaxed/simple;
	bh=wIMYBNzbCTYNJg6+riZWhR0KhzT2IVa3ptHVo9K6HF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCYmIbHICtMogDVQIENYummaBFkQmLFn2+7u9Hp7DqYY0ZuPLWV8WzFrFm1dK/qdzZRwmS5kwhsrU4IHJptDTx58Og3Ii6CmortvOGzg1x86nPz1163qGwFMOPHvC0ObBGkVE7NZjmSORr2Salh5pITkd98ADkLH7lBU4vRzJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jhMGRHxj; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jhMGRHxj"
Message-ID: <0606be50-1f21-438f-bf00-024f31b9eda8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782451593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f96tZgeTHGA1Dh6puxOPPKcEg2Gpr+GaxDxTbuHkptY=;
	b=jhMGRHxjwzss/eH0/NYvh90yIcjOq2DwneguhqofDolL1474zx0mY6/Dnfi22I4D3z/XNe
	fmCkET4bNeJv9B98ThCD1/WPqM/z4AOM2N0HlSrR2zepz8lrLrr8nth5C+8b9Ir2FogGfU
	VzpyGsYCSHT/1TMpYsk08yaZiRx3tiQ=
Date: Thu, 25 Jun 2026 22:26:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] resolve_btfids: preserve tag and parameter names when
 processing implicit args
To: Aelin Reidel <aelin@mainlining.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260620-resolve-btfids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260620-resolve-btfids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026-06-19 3:49 p.m., Aelin Reidel wrote:
> process_kfunc_with_implicit_args() obtains parameter names through
> btf__name_by_offset() and passes them to btf__add_func_param() while
> constructing a new function prototype. Tag names are processed in a
> similar fashion.
> 
> The returned name pointer references memory owned by the BTF object.
> btf__add_func_param(), btf__add_decl_tag(), etc. modify the same BTF and
> may grow its internal storage, invalidating previously returned string
> pointers.
> 
> This can result in btf__add_func_param(), btf__add_decl_tag(), etc.
> dereferencing a stale pointer when copying the string, leading to crashes
> in strset__add_str().
> 
> Duplicate the parameter name before calling btf__add_func_param() so it
> remains valid across BTF updates.
> 
> Fixes: 9d199965990c ("resolve_btfids: Support for KF_IMPLICIT_ARGS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aelin Reidel <aelin@mainlining.org>
> ---
> We were noticing resolve_btfids crashing almost all the time when
> building our kernels with BTF debuginfo in postmarketOS. I'm not sure
> why specificially our environment triggered this extremely reliably, but
> I'm glad I was able to track down the issue. With the patch, I haven't
> seen any further issues and our kernel builds are succeeding again.

Hi Aelin, thank you for the report and patch.

My first instinct was to dismiss the patch as over defensive, because
libbpf gracefully handles reallocation of existing strings, and we
don't add new strings here.

Take a look at strset_str_append() in libbpf (strset.c:131):

	static long strset_str_append(struct strset *set, const char *s)
	{
		[...]

		/*
		 * The set->strs_data might have reallocated and if 's' pointed
		 * to an internal string within the old buffer, then it became
		 * dangling and needs to be reconstructed before the copy.
		 */
		if (old_data && old_data != (uintptr_t)set->strs_data &&
		    old_s >= old_data && old_s < old_data + old_data_len)
			s = set->strs_data + (old_s - old_data);

		memcpy(p, s, len);

		return len;
	}

In process_kfunc_with_implicit_args() both tag_name and param_name are
read *after* the first btf__add_func() / btf__add_func_proto() has
made the BTF modifiable, so btf__name_by_offset() should return a
pointer into btf->strs_set. I don't see where the bad pointer comes
from.

However you have a stable reproducer, so your strdup() change probably
covers a real UAF bug somewhere else (in libbpf?).

Let's track this down before coming up with a fix.

What version/commit of libbpf are you using in your kernel tree?

You could build resolve_btfids with ASAN, or run it with valgrind.

If you can share a reproducer that's easy to run, that would be
great too.

Thanks!

> ---
> Changes in v2:
> - Apply the same fix to tag_name and adjust the commit message
>    accordingly
> - Fix the remaining use-after-free in the error handling path
> - Link to v1: https://patch.msgid.link/20260619-resolve-btfids-implicit-args-use-after-free-v1-1-2af87d4704c8@mainlining.org
> 
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Andrii Nakryiko <andrii@kernel.org>
> To: Eduard Zingerman <eddyz87@gmail.com>
> To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> To: Martin KaFai Lau <martin.lau@linux.dev>
> To: Song Liu <song@kernel.org>
> To: Yonghong Song <yonghong.song@linux.dev>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Emil Tsalapatis <emil@etsalapatis.com>
> To: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   tools/bpf/resolve_btfids/main.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index f8a91fa7584f..94b89e9c942e 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -1113,6 +1113,7 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
>   {
>   	s32 idx, new_proto_id, new_func_id, proto_id;
>   	const char *param_name, *tag_name;
> +	char *tmp_param_name, *tmp_tag_name;
>   	const struct btf_param *params;
>   	enum btf_func_linkage linkage;
>   	char tmp_name[KSYM_NAME_LEN];
> @@ -1163,18 +1164,22 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
>   		if (strcmp(tag_name, "bpf_kfunc") == 0)
>   			continue;
>   
> +		tmp_tag_name = strdup(tag_name);
>   		idx = btf_decl_tag(t)->component_idx;
>   
>   		if (btf_kflag(t))
> -			err = btf__add_decl_attr(btf, tag_name, new_func_id, idx);
> +			err = btf__add_decl_attr(btf, tmp_tag_name, new_func_id, idx);
>   		else
> -			err = btf__add_decl_tag(btf, tag_name, new_func_id, idx);
> +			err = btf__add_decl_tag(btf, tmp_tag_name, new_func_id, idx);
>   
>   		if (err < 0) {
>   			pr_err("ERROR: resolve_btfids: failed to add decl tag %s for %s\n",
> -			       tag_name, tmp_name);
> +			       tmp_tag_name, tmp_name);
> +			free(tmp_tag_name);
>   			return -EINVAL;
>   		}
> +
> +		free(tmp_tag_name);
>   	}
>   
>   add_new_proto:
> @@ -1193,12 +1198,17 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
>   		if (is_kf_implicit_arg(btf, &params[i]))
>   			break;
>   		param_name = btf__name_by_offset(btf, params[i].name_off);
> -		err = btf__add_func_param(btf, param_name, params[i].type);
> +		tmp_param_name = strdup(param_name);
> +		if (!tmp_param_name)
> +			return -ENOMEM;
> +		err = btf__add_func_param(btf, tmp_param_name, params[i].type);
>   		if (err < 0) {
>   			pr_err("ERROR: resolve_btfids: failed to add param %s for %s\n",
> -			       param_name, kfunc->name);
> +			       tmp_param_name, kfunc->name);
> +			free(tmp_param_name);
>   			return err;
>   		}
> +		free(tmp_param_name);
>   		t = (struct btf_type *)btf__type_by_id(btf, proto_id);
>   	}
>   
> 
> ---
> base-commit: 598c7067dd8b65b93f3ccada47e9014a13137f1b
> change-id: 20260619-resolve-btfids-implicit-args-use-after-free-16fc2939529e
> 
> Best regards,
> --
> Aelin Reidel <aelin@mainlining.org>
> 

