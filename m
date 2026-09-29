Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6451B4F0A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680801; cv=none; b=SMEVttFlZB08zCdXTaA/4HEK07eWYHOp+ILc6NooVw43McQ57F/ckrXl2r8M3+73/Pu/3gWDEoZv0dVDrClryo8uvQYBqzcdbEzMqdAlsbG0l+YHccVhKsXD+2+HPs+4tkwjrqIufECF/gengb6vIn0q/vTY2/7Wj/slMaQZyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680801; c=relaxed/simple;
	bh=QXnPW9zuf1wk0vzvtzvqX4qwENvSfup4DO5c4GS5l9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnxI5WCCTgCjjHLqT0PhCdroFbmDDANxhBcTaA0zAvCkoe5VcyT2dEI4HS5+xM1PiHrTe4nIRky/YNEFyCf/DX2XWkJmgeGqWFqFZM0A/SdgRqrOr2xPZw6KM4smxfAQzynXtWagL5FjRsp2iYqyYixy+gFlvXZlBdFvpnGc+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZQvaP3N/; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZQvaP3N/"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so3956395e9.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790680795; x=1791285595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1SIiwJ6lN+3ivAuXpT14YX4QEyi55uOiWiddkiKdWU=;
        b=ZQvaP3N/Vb/xcgdm+VmTYO0HuRKIRCeq4meesAVQwSdcGApx3feNW+jTTyQfWv/1Lx
         7snm9bIWQabS2/1D3eyFFateVJ92t+bSFkcnPyh3AzbaOhBBvtezlwSU3+VZceIyZrgX
         +68H1EBL//VdTu4V+ZnVyXHa15q5WTa7FNtwk6npkINZCkZ9aqc5ZDLJ9vaq0iNxKvfE
         sFWhk8MkLxaVftDq60sPaGT9EdahW24e2HtCfDu2M372oDpRtnMeGXWrH3lIJGun6Vtz
         +mSVpKI/6fiD/8oAd4o8bPQr26NYNb0Rz4TSaX/Qk0//5c17yKZ0rRKkV3t86zvg9ljX
         dLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790680795; x=1791285595;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1SIiwJ6lN+3ivAuXpT14YX4QEyi55uOiWiddkiKdWU=;
        b=O6LTBsfD9Hcs7kFyiWmTXoI/EyUAz00gVJuwZ3sW4OoDcCJSUxaSbtStGJhOS4ouhn
         ABaXJStQTt+n+tEXOTmm0KOeqv6/+u9HPLg9OyTM9Z4bXUWE0xxPeqJzLk9DFFHtpZ3h
         yuXBQBSKSDP/lAFvLNsllXgiuoANTKV/g7FPJrpxx0j2H+yRj7paAOYHEeXrMvWtsj/J
         j2Xg0BloigD9Vwa80DgGtzYI7s7y7WecsOfYw3ofRXzT1XU4XIHI+SOPtsPgX4l5VLoX
         bvi8ehCMk9W0MI8BQEwCyBujlUmNW6zcGSx91E+U2XaNmbbX1Xfqex3hYpHtxuK99gk7
         6SqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOZHt8GxUqQt8Fa7Azf1KXlv05AnTsGXpqWtxsM1cAxhH/cx4jAn0E5yLKeyQc0E4OHhOF94Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lzGdXNumFCXZcY0Iw5tmoeICdMUE+aR9kp4K5aHYDcRoMPWszk
	KaPNi7juPJH916S4XqNlQSZXofQZ87FqRUeftkTXi6oVWh8oIUIERIXK6LwbD+7+dLA=
X-Gm-Gg: AYBFou2AbXk7phJ9mMRSHYfpv9gOXT7hke1ZE7kG9CXrFdb0MT2slGBMrQZ/MNgHncu
	9DvZZ+g0ECdA33Ahoq0kFmjrbRLHcfmBOmpuEblKVshduOjgQmZ6oWMTnSzz5qAwnrdwLjLoTb8
	ozMg8SDFyo3dat0pSMvp6/xS75oIH++Krw7mili3HH+65dz4dpRydZP859Yvs03N2d6xJDRTl0Q
	/uBKxvn5MZPs7Bu7CsoKsjkqQtqXVMNcZyG56qwSsNHUh/1MXuatNmu13nJBQfe0cQJSOgTZX9L
	EvWCUMayzOrlpFNV7F+krhRsfQh+CWVnhe6r2zhWn9mYoB36IuoeBrH/5FZvh/ur8DRm+aSWFCk
	bnNHuueqx8kK+d6rgXJvsebzM3eXU5juqlhPj5GyBDr9H90c/PsjP51v1uvbGrjVOEpbVug8D+o
	0h5Kg1Z9fFAqXZX2LojBgeiaHlwukiMI1H1m5aTTFuBZzVTOYAczX5TwI+yMbgLVmAC27N09+K1
	qsEcF8GW6VF0U4x4QqlOmygL22Npl8aIx0=
X-Received: by 2002:a05:600c:37c6:b0:49e:6865:904e with SMTP id 5b1f17b1804b1-4a00d77037amr35244075e9.12.1790680794686;
        Tue, 29 Sep 2026 04:19:54 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d0ea071sm70193785e9.9.2026.09.29.04.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 04:19:54 -0700 (PDT)
Message-ID: <b9ed1785-33b7-4ff1-9a3e-99e28dbb7a2c@suse.com>
Date: Tue, 29 Sep 2026 13:19:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: validate sh_name for SHT_NULL sections
To: liuc63 <liuc63@xiaopeng.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260905110813.150411-1-liuc63@xiaopeng.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260905110813.150411-1-liuc63@xiaopeng.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/26 1:08 PM, liuc63 wrote:
> From: Liu Chao <liuc63@xiaopeng.com>
> 
> elf_validity_cache_secstrings() checks that every section name offset is
> inside the section name table, but skips headers of type SHT_NULL, since
> ELF leaves their field values undefined.
> 
> However, the section lookup helpers do not check sh_type. This is
> find_any_unique_sec(), which load_module() uses to locate ".modinfo":
> 
> 	for (i = 1; i < info->hdr->e_shnum; i++) {
> 		if (strcmp(info->secstrings + info->sechdrs[i].sh_name,
> 			   name) == 0) {
> 
> find_any_sec() and module_enforce_rwx_sections() read sh_name the same
> way, the latter from index 0. find_sec() is only shielded by its
> SHF_ALLOC test, which a crafted module can satisfy.
> 
> ELF also permits SHT_NULL entries above index 0. A module that carries
> one with a large sh_name passes validation and then reads out of bounds:
> 
>   BUG: unable to handle page fault for address: ffffc9004052f988
>   Oops: 0000 [#1] SMP KASAN PTI
>   CPU: 0 UID: 0 PID: 261 Comm: insmod Not tainted 6.18.0-rc7 #2
>   RIP: 0010:strcmp+0xc/0x40
>   Call Trace:
>    ? find_any_unique_sec+0x89/0xf0
>    load_module+0x516/0x3d30
>    init_module_from_file+0xf5/0x180
>    __x64_sys_finit_module+0x91/0x100
> 
> The read happens in elf_validity_cache_copy(), before the blacklist check
> in early_mod_check().
> 
> Bounds check sh_name for every section header. The name table is already
> known to be non-empty, so the sh_name of 0 that ELF requires at index 0
> still passes, and a name offset that points outside the name table is
> malformed regardless of section type. Neither an Ubuntu 20.04 x86_64
> build (GCC 9.4, 6025 modules) nor an aarch64 vendor build (GCC 13.2, 127
> modules) has a header with an out-of-bounds sh_name, or any SHT_NULL
> header above index 0.
> 
> Link: https://lore.kernel.org/linux-modules/20260708013301.C4D4A1F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
> The same report lists two more SHT_NULL gaps, both from
> elf_validity_cache_sechdrs skipping offset and size validation:
> move_module will memcpy such a section, and elf_validity_cache_index_mod
> rejects SHT_NOBITS but not SHT_NULL. Sending this one on its own first,
> happy to respin all three as a series if you would rather have them
> together.
> 
> The Oops line says KASAN, but the access faults rather than producing a
> KASAN report, because lib/string.o is built with KASAN_SANITIZE disabled.
> 
> No Fixes tag. 3c5700aeabd8 ("module: Factor out
> elf_validity_cache_secstrings") is where the exemption was added, but the
> problem predates it: before that commit sh_name was only checked for
> SHF_ALLOC sections and the ".modinfo" strcmp() ran ahead of the check, so
> find_any_sec() could already walk off the end. Same conclusion as
> 9a5ff4568932 ("module: validate string table section types"), which went
> in with Cc: stable and no Fixes tag. checkpatch complains about that
> combination.
> 
> The scan behind that last paragraph applies exactly the predicate this
> patch introduces, sh_name >= strhdr->sh_size, to every section header
> from index 0. On the x86_64 host it covered 17546 modules across three
> kernel trees (5.15.0-181, 5.15.0-190, 5.4.0-182), all built by GCC 9.4.0;
> those trees are the same toolchain recompiling much the same driver set,
> so the changelog quotes one tree rather than the total. The aarch64 side
> is a 5.10 vendor kernel built with Arm GNU Toolchain 13.2. Both are GNU
> toolchains - no clang-built module set was available to me.
> 
> Reproducer, needs root and an unsigned module on a kernel without
> CONFIG_MODULE_SIG_FORCE. Build any minimal module, then append a
> SHT_NULL section header with an out-of-bounds sh_name:
> 
>   python3 - <<'EOF'
>   import struct
>   SHDR = 0x40
>   data = bytearray(open('dummy.ko', 'rb').read())
>   shoff = struct.unpack_from('<Q', data, 0x28)[0]
>   shnum = struct.unpack_from('<H', data, 0x3c)[0]
>   old = bytes(data[shoff:shoff + shnum * SHDR])
>   evil = bytearray(SHDR)
>   struct.pack_into('<I', evil, 0, 0x40000000)
>   data += b'\0' * ((8 - len(data) % 8) % 8)
>   new_shoff = len(data)
>   data += old + bytes(evil)
>   struct.pack_into('<Q', data, 0x28, new_shoff)
>   struct.pack_into('<H', data, 0x3c, shnum + 1)
>   open('evil.ko', 'wb').write(data)
>   EOF
> 
>   insmod evil.ko
> 
>  kernel/module/main.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..7d5943cd6543 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2060,9 +2060,6 @@ static int elf_validity_cache_secstrings(struct load_info *info)
>  
>  	for (i = 0; i < info->hdr->e_shnum; i++) {
>  		shdr = &info->sechdrs[i];
> -		/* SHT_NULL means sh_name has an undefined value */
> -		if (shdr->sh_type == SHT_NULL)
> -			continue;
>  		if (shdr->sh_name >= strhdr->sh_size) {
>  			pr_err("Invalid ELF section name in module (section %u type %u)\n",
>  			       i, shdr->sh_type);

The ELF specification [1] says:

| SHT_NULL
|
|     This value marks the section header as inactive; it does not have an
|     associated section. Other members of the section header have
|     undefined values.

The patch may cause the module loader to read undefined values if the
section has type SHT_NULL.

I think the module loader should handle SHT_NULL properly by skipping
such sections during all processing. Alternatively, it could reject any
module with an SHT_NULL section other than the one at index 0.

[1] https://gabi.xinuos.com/v42/elf/03-sheader.html#section-type

-- 
Thanks,
Petr
