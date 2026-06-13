Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC133F8D4
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781325642; cv=none; b=Gkfxoglc+x2djd4aaLX9+wsNbYsKjsLtc+EkkVOwsFNU4uLvi6PcGSqXEZmvO/jqy8F8VY8XGphF6a/Xpmxv5nKw7HScaVIBmIHISH9UUoR0rlZ2euqUqfMto5NebIuH7YphTQsoTFsqpFolVuypz+wX8Q0yJyZjheh8jRGQqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781325642; c=relaxed/simple;
	bh=zRBTu1A0Be6ZKXrsy73gH2oh0g2kPc7iIlvK97Liljs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2+CH/LLD/CnMUzQLZi6Q/aluZ0cT8u5nwDHlaDzpycsKyGAaDTYqN7VPnfbB42ZWNq6JhOpA6SrwO4QWuc0LtqxcN4RlEUeX3/TbzWK0phts7SxBGjfKT6m3wosumk9o0p6R3RFb35+urnyCL/642HqEw5z7fetuv3Sdrwsxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=sHWbWL03; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="sHWbWL03"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A79D53F129
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 04:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781325631;
	bh=7D/U3m+0FGnBHJREEG6qJ7+tzxYRCsOc5bWJ6KTvx3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=sHWbWL03tP9MEVAf8ypKafyGm7oXcDjXKGu0+AcG/YX+33C814UAbJwZVfpGSlzA+
	 PyUnxIp7c+yJ81FMJGzxXpaBTvGbH+Z9BjBzZT9WfMkDHXMol0NWVZzb3DaS50+00s
	 PIqHcrm3GLNSj/ZCAKqD99VqYPBLnwzRhkxM8t0uRlUn5HGLxLgcIaiZGCU/qbfj7M
	 liSeRSxb1HkT4mj8riGCPYQ2I9uG2ZGEGRR9p657rZDTyQzsHrAY1o2qi3BQh+1nPU
	 loYNDiv7mAj0VMHs5KnX7mH0cbL9+8UojZsaH3fx+qZceulcF+ktzdJxnVMuzV5TL2
	 2UjYrCebFw1r0hK0YgMTsOaHR8tKQP1cx5oStEiIhTec8mrCYEiovx6a77SOujbRse
	 hAzkugT0XL1dfCz/ZQNS5MIS9T1QTdI24OOQtcJTRf2z2sE+5v3H/3Qkzjfx47XhPR
	 cWBlEls0dF62DVO7ocbdyaNijVH857onGm3JF+IcU8MBiHE2wmxXz+PQpRbS8OJ9eP
	 xKM+qCEKu2VNS4jXcCTO8jz9jB4fSyWjJTgYBAT6WhQ/IcX/9EEx1/sHDQGXAdaZHU
	 mw0lGt+o/q7esjuwAXA3B1Od1TvEChWzwmMEXcspKcNYNC4n9Y1XS7iGYsjEyQWCXy
	 SK/6hHAoXCqC0cpkWgUrcssQ=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d8719bae6so1446265a91.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 21:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781325630; x=1781930430;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D/U3m+0FGnBHJREEG6qJ7+tzxYRCsOc5bWJ6KTvx3c=;
        b=cv4JEGCACdIgb+Y1Gl9/ATxrrLZ3EWsyGrctCwgyC0OppWYtE3qjQ/4JBEyBsyAOCI
         2wuIpwKQjVwyqizDeGD/vf523N2jNhtv6gOt6D0C2l+4FZbL1B3cfXQoR33z/kfFICNS
         7bw8Yx62DrwWQwo3lclRQcC4fAxw2NRT32yE2Qu4ED02XtVWiktoqn5RTkJ36fuDumrw
         nk12AFNNEY8Z6rnrAKXAMyk9dbcjaKfXvtxsU8UwXx2zOrpmkAYhfY3+oGjVCEob/OqX
         n5zWA2rRBW/SL42tvjrZW0BTEu1dlVLCCAyy5YahOv3brlNi99DEXdV20JPcV7K0hCxv
         PgWA==
X-Forwarded-Encrypted: i=1; AFNElJ+0kSkvpAdKt/IHAM/YmB2t2qoo6Dr7SOjh77aLOIBbpykdomwf0wMVr2akPrrEEURL32ckDFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFlBfjpcBRkrzFaAGSBbOT0JC28l07XeoBkenHvjheAmIzGKq
	vw7LeRDyjLMZHbauKCGPpjrmWWu8m8gL2+4TdOS0U0yRJRudVPiAChwvro9B794xMPIzRTAh6sA
	KhzYalwFHjJo+cT5FPz7f4s08WolKSQfKNXON9ssNICTSIQKu1qZBsBAjip2PwoQ7mqJWJMW5QA
	==
X-Gm-Gg: Acq92OHGSyWyIATSV85OlCTfxVkpG3ZL4vFhA4dZZ2O5VaNUXIgAmTQYby6zJ/NuxXt
	3FRhZWi1EIJnUIaTPHO6O7RGt0Xwi/TZIE0Zmkej6ftMPB4ZfluXS/kdHnXW643cjn3ioOnZO+f
	FOK9vTRa/az5UQYLhgG6Gnz60BnZf7lxa6pkRQFIJ02XAI5IPd+tYFc9q/+FczzAK5wHip4ynJG
	44HUyFG+l45w4Rub67v8DiPZnLx594/rK+lkgfGjsTyLWo5TkQI7hva2X4N+9xAP/JfnJgE8/rJ
	s1VuEyPKQIp39qUrxcn3+L6KB6VIoe5xzKe/i93SiuSej7+mEBM0j+gtcIfLKEQ80edPNSTjV/Q
	rpA9XjPClINyPx5YgOvOCUISaUdZ4mlDfWJGJ
X-Received: by 2002:a17:90b:3a81:b0:36d:633a:e7e5 with SMTP id 98e67ed59e1d1-37c2bc5d64bmr2065407a91.3.1781325629882;
        Fri, 12 Jun 2026 21:40:29 -0700 (PDT)
X-Received: by 2002:a17:90b:3a81:b0:36d:633a:e7e5 with SMTP id 98e67ed59e1d1-37c2bc5d64bmr2065385a91.3.1781325629470;
        Fri, 12 Jun 2026 21:40:29 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c8665186828sm3051436a12.21.2026.06.12.21.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 21:40:28 -0700 (PDT)
Message-ID: <847161f0-7c76-4765-bd2d-dbdda242e2a8@canonical.com>
Date: Fri, 12 Jun 2026 21:40:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Fix string overrun due to missing
 termination
To: Daniel J Blueman <daniel@quora.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Thorsten Blum <thorsten.blum@linux.dev>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260327115833.7572-1-daniel@quora.org>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260327115833.7572-1-daniel@quora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 04:58, Daniel J Blueman wrote:
> When booting Ubuntu 26.04 with Linux 7.0-rc4 on an ARM64 Qualcomm
> Snapdragon X1 we see a string buffer overrun:
> 
> BUG: KASAN: slab-out-of-bounds in aa_dfa_match (security/apparmor/match.c:535)
> Read of size 1 at addr ffff0008901cc000 by task snap-update-ns/2120
> 
> CPU: 5 UID: 60578 PID: 2120 Comm: snap-update-ns Not tainted 7.0.0-rc4+ #22 PREEMPTLAZY
> Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN60WW 09/11/2025
> Call trace:
> show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
> dump_stack_lvl (lib/dump_stack.c:122)
> print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
> kasan_report (mm/kasan/report.c:597)
> __asan_report_load1_noabort (mm/kasan/report_generic.c:378)
> aa_dfa_match (security/apparmor/match.c:535)
> match_mnt_path_str (security/apparmor/mount.c:244 security/apparmor/mount.c:336)
> match_mnt (security/apparmor/mount.c:371)
> aa_bind_mount (security/apparmor/mount.c:447 (discriminator 4))
> apparmor_sb_mount (security/apparmor/lsm.c:719 (discriminator 1))
> security_sb_mount (security/security.c:1062 (discriminator 31))
> path_mount (fs/namespace.c:4101)
> __arm64_sys_mount (fs/namespace.c:4172 fs/namespace.c:4361 fs/namespace.c:4338 fs/namespace.c:4338)
> invoke_syscall.constprop.0 (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
> el0_svc_common.constprop.0 (./include/linux/thread_info.h:142 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
> do_el0_svc (arch/arm64/kernel/syscall.c:152)
> el0_svc (arch/arm64/kernel/entry-common.c:80 arch/arm64/kernel/entry-common.c:725)
> el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:744)
> el0t_64_sync (arch/arm64/kernel/entry.S:596)
> 
> Allocated by task 2120:
> kasan_save_stack (mm/kasan/common.c:58)
> kasan_save_track (./arch/arm64/include/asm/current.h:19 mm/kasan/common.c:70 mm/kasan/common.c:79)
> kasan_save_alloc_info (mm/kasan/generic.c:571)
> __kasan_kmalloc (mm/kasan/common.c:419)
> __kmalloc_noprof (./include/linux/kasan.h:263 mm/slub.c:5260 mm/slub.c:5272)
> aa_get_buffer (security/apparmor/lsm.c:2201)
> aa_bind_mount (security/apparmor/mount.c:442)
> apparmor_sb_mount (security/apparmor/lsm.c:719 (discriminator 1))
> security_sb_mount (security/security.c:1062 (discriminator 31))
> path_mount (fs/namespace.c:4101)
> __arm64_sys_mount (fs/namespace.c:4172 fs/namespace.c:4361 fs/namespace.c:4338 fs/namespace.c:4338)
> invoke_syscall.constprop.0 (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
> el0_svc_common.constprop.0 (./include/linux/thread_info.h:142 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
> do_el0_svc (arch/arm64/kernel/syscall.c:152)
> el0_svc (arch/arm64/kernel/entry-common.c:80 arch/arm64/kernel/entry-common.c:725)
> el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:744)
> el0t_64_sync (arch/arm64/kernel/entry.S:596)
> 
> The buggy address belongs to the object at ffff0008901ca000
> which belongs to the cache kmalloc-rnd-06-8k of size 8192
> The buggy address is located 0 bytes to the right of
> allocated 8192-byte region [ffff0008901ca000, ffff0008901cc000)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9101c8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:-1 pincount:0
> flags: 0x8000000000000040(head|zone=2)
> page_type: f5(slab)
> raw: 8000000000000040 ffff000800016c40 fffffdffe2d14e10 ffff000800015c70
> raw: 0000000000000000 0000000800010001 00000000f5000000 0000000000000000
> head: 8000000000000040 ffff000800016c40 fffffdffe2d14e10 ffff000800015c70
> head: 0000000000000000 0000000800010001 00000000f5000000 0000000000000000
> head: 8000000000000003 fffffdffe2407201 fffffdffffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
> ffff0008901cbf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff0008901cbf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff0008901cc000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ^
> ffff0008901cc080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff0008901cc100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> 
> This was introduced by previous incorrect conversion from strcpy(). Fix it
> by adding the missing terminator.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Fixes: 93d4dbdc8da0 ("apparmor: Replace deprecated strcpy in d_namespace_path")

sorry for the lateness of my reply, my email wasn't working when I pulled this
in for 7.1

just for the record

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/path.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/path.c b/security/apparmor/path.c
> index 65a0ca5cc1bd..2494e8101538 100644
> --- a/security/apparmor/path.c
> +++ b/security/apparmor/path.c
> @@ -164,14 +164,16 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
>   	}
>   
>   out:
> -	/* Append "/" to directory paths, except for root "/" which
> -	 * already ends in a slash.
> +	/* Append "/" to directory paths and reterminate string, except for
> +	 * root "/" which already ends in a slash.
>   	 */
>   	if (!error && isdir) {
>   		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
>   
> -		if (!is_root)
> +		if (!is_root) {
>   			buf[aa_g_path_max - 2] = '/';
> +			buf[aa_g_path_max - 1] = '\0';
> +		}
>   	}
>   
>   	return error;

