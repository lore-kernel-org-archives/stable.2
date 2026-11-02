Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584606;
	b=llXqfNvpMUBIJJjHHu2rQjlo23dH6d5uniZk097RPAeBkFKOhyd0sGyPLNCOz2WbKMN/
	 jJqTv0csfb3EntRafb7uJ/5mijDEtMz9nzVwAjuxTbQpCC9M1nE7Fbts+dojxgQH6ewF2
	 G3NreSW9AxsIexlWLYHJJp+G1RId3szKCywUeYVu8Q03uxtR0rTZTaiApzwuKIdrTtehA
	 q4jrIBfBky9Qbok4thF8cm235W2U6Pgmvc4N7qmB/QemksWduE7Eghxx/JiDNG5yndJ6s
	 fYNuZ/mDP7BZOT8NP/g/1wjvZ5IXHzpMitef3xDZs77OGexnqDSrpILDd+2s9j9IvtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584606;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0ZsByk/ZJvDZM0D6OTRlx2ROiNL3TXd4513hn09OUlE=;
	b=exUO6k9hbnxUKlprv7rNQaeJz9XNysU/NYKsHs3aC3CvO6qg3FCsBXvuoLtqtFe/AJx0
	 WoFv2GQePjBjhm6FhJGaITizZVteRQIL6P2MPkUGvHAotdG2FXHGb65M67dWz0ptPxQGY
	 AvLE6NuYft/bNXa8ZTidA641ejhYQ0IktKcSWz1S1iiFF6OnGy1wRGhcApGSvgqvItnqQ
	 7mxQw1USuj6Bsigdki15z2ffz8qDQ/fCtHwu8ecU9bPpX4BkBtHxvMfa3vxzrVjkZGNhH
	 insBQKA7+mu/vNAEx6Xh7ZcXfWgrIlw8nmExz06LuOZQVPUv0tmC3INLY4KnCLq71Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3fv1KoO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A3606A324;
	Mon,  2 Nov 2026 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3fv1KoO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0B1F000C1;
	Mon,  2 Nov 2026 01:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793584605;
	bh=0ZsByk/ZJvDZM0D6OTRlx2ROiNL3TXd4513hn09OUlE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=B3fv1KoOC5Oy3t6N1R6tSXDEqk0yIOuoGCfOg6mtvRQF4/w2KZulY7lXYGB4eykbN
	 lFUcP9ORWfhzd4EpAUxmwfvZEZoUC9n/yxdFjofD8c1S6YAKfvN1UJqyev+Mzas9HV
	 GD9Lfh+X13BKrGjsEfAOWSSX+vPwEeinm4hHoOrSn30XzAiV4kY3Prrz68muzSfDQA
	 bJVZOu9/Eq9ZJv3wVyqXdzh2vvdaJp5T35bn6IpKoJ0BNyFxQOnH1aLfGz0ZCxAIMx
	 uUyikVSa+NcNci18d6ILj9MPZVddynvoNOIQnLi57wwe6y2FpsGhfsrZPCyFBg3Zzp
	 nVbgiMoAV8rFA==
Message-ID: <a096053d-3f01-42aa-a933-50145abb874d@kernel.org>
Date: Mon, 2 Nov 2026 09:56:41 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, lihongbo22@huawei.com, sandeen@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 zhanxusheng@xiaomi.com,
 syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: free the quota file name that remount drops
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, jaegeuk@kernel.org
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
 <20261030072423.197883-2-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261030072423.197883-2-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 15:24, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Remounting with an empty journalled quota option such as "usrjquota="
> clears the name, but f2fs_apply_quota_options() overwrites the old
> string without freeing it, so every such remount leaks it.
> 
> Free it after a grace period, as f2fs_show_options() may still be
> reading it.
> 
> Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")

BTW, shouldn't it be:

Fixes: ff11d8701b77 ("f2fs: fix to allow removing qf_name")

Thanks,

> Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> Tested in QEMU with KASAN and kmemleak, remounting with "usrjquota="
> and "usrjquota=f2fs" in a loop while reading /proc/mounts: nothing is
> reported.  A plain kfree() here trips KASAN in f2fs_show_options().
> 
>   fs/f2fs/super.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 510df7998c18..d86ab25fbcc5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1646,7 +1646,7 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
>   	struct f2fs_fs_context *ctx = fc->fs_private;
>   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>   	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
> -	char *qname;
> +	char *qname, *old;
>   	int i;
>   
>   	if (quota_feature)
> @@ -1662,7 +1662,10 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
>   					GFP_KERNEL | __GFP_NOFAIL);
>   			set_opt(sbi, QUOTA);
>   		}
> -		F2FS_OPTION(sbi).s_qf_names[i] = qname;
> +		old = F2FS_OPTION(sbi).s_qf_names[i];
> +		/* Pairs with READ_ONCE() in f2fs_show_quota_options() */
> +		smp_store_release(&F2FS_OPTION(sbi).s_qf_names[i], qname);
> +		kfree_rcu_mightsleep(old);
>   	}
>   
>   	if (ctx->spec_mask & F2FS_SPEC_jqfmt)

