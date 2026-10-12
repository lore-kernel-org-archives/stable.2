Received: from mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085838E5EF
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770378; cv=none; b=ENf6kPmD7p00yk1s5RT5yY2rakIXrM60dy1ZUyn2GA5M+lXLGBpGjIjSfrJTSZSRQ9Zz6shzTnHabEEr3aXvMnGV5JKcQ6oCqM0pHRKYDTE7XPmuZHXDMfEq++krWYDy75bD7O68oq0vR5479/3UKVslOMzDwgw2jld4Ei38Kdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770378; c=relaxed/simple;
	bh=moBHlWf8jgOs/rYSsRmHzU2nJBmQG8lbqQxc+Xan938=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFdqDr/ch9jZ+kZxC3+wcRn2+SGgSCo15zVL5kH7UAhRhvfOgbgUU6dmdX6JbMUrB7w1R8nywYwnqs1jKsTDw25lgNKn3UWoqXCJL7+thjFgxvyOyjS8KQOYE3SSQ4RKuWY9YUYTU1ty4RmvxP7g/VOpIXG1tvLEMdcmVpa4y2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D4tnk9S6; arc=none smtp.client-ip=95.215.58.62
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D4tnk9S6"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=moBHlWf8jgOs/rYSsRmHzU2nJBmQG8lbqQxc+Xan938=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791770375; v=1; x=1792375175;
 b=D4tnk9S6wtHb6mDP/quLnO0cCahq120jKBiAAaR0yD/g5GVM2DejYzLPz0delcFFnUnXp8Zh
 dcKtqCzsJ76ozUA5xawJ+be8Wo3NGNSSkVMd8Wxear9pDleXsokAf3LWVieSBK34ypsIE09I+W1
 WyH++gLMseLHFJ8luyCF+1SU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 967f2161ab6b936c;
	Mon, 12 Oct 2026 01:59:34 +0000
X-Mizu-Trace-ID: 967f2161ab6b936c
X-Migadu-Flow: FLOW_OUT
Message-ID: <06f54345-4ca6-455f-9519-138e0b6db24b@linux.dev>
Date: Mon, 12 Oct 2026 09:59:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, sockmap: Fix UAF when map user reference is
 revived
To: Jan-Gerd Tenberge <janten@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 jakub@cloudflare.com, edumazet@kernel.org, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, yonghong.song@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261008095656.92793-1-janten@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261008095656.92793-1-janten@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/8/26 5:56 PM, Jan-Gerd Tenberge wrote:
> bpf_map_put_uref() invokes map_release_uref after usercnt reaches zero,
> before bpf_map_put() drops the map reference. BPF_MAP_GET_FD_BY_ID can
> find the map during that callback and raise usercnt again.
>
> The sockmap and sockhash release callbacks unconditionally drop programs
> without taking sockmap_mutex. A concurrent attach through the revived fd
> can therefore publish a new program before the stale callback drops it.
>
> For a bpf_link attachment, this leaves plink set while pprog is NULL, so
> link release warns and leaves the attachment slot unusable. The callback
> can also drop the program between sock_map_prog_update() and the later
> bpf_prog_inc(). If the program fd is closed concurrently, this removes
> the last reference and schedules an RCU free. The subsequent increment
> then resurrects a zero reference and leaves link->prog pointing to memory
> that will be freed. A KASAN reproducer triggers a slab-use-after-free when
> reading information from that link.
>
> Triggering the race requires CAP_SYS_ADMIN in the initial user namespace,
> because reviving the map uses BPF_MAP_GET_FD_BY_ID. A deterministic KASAN
> reproducer is available privately on request. It was used to verify the
> UAF before this change and its absence afterwards.
>
> Serialize the release callbacks with program updates using sockmap_mutex
> and recheck usercnt under the mutex. If the map was revived, leave its
> programs intact. Move the map user-reference put in link release outside
> the mutex to avoid recursively taking sockmap_mutex when it drops the last
> user reference.
>
> Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb progs")
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan-Gerd Tenberge <janten@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>   net/core/sock_map.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 38df84284328..32ccf4ca3c76 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -26,7 +26,8 @@ struct bpf_stab {
>   
>   /* This mutex is used to
>    *  - protect race between prog/link attach/detach and link prog update, and
> - *  - protect race between releasing and accessing map in bpf_link.
> + *  - protect race between releasing and accessing map in bpf_link, and
> + *  - protect race between map user-reference release and prog/link updates.
>    * A single global mutex lock is used since it is expected contention is low.
>    */
>   static DEFINE_MUTEX(sockmap_mutex);
> @@ -372,7 +373,10 @@ static void sock_map_free(struct bpf_map *map)
>   
>   static void sock_map_release_progs(struct bpf_map *map)
>   {
> -	psock_progs_drop(&container_of(map, struct bpf_stab, map)->progs);
> +	mutex_lock(&sockmap_mutex);
> +	if (!atomic64_read(&map->usercnt))
> +		psock_progs_drop(&container_of(map, struct bpf_stab, map)->progs);
> +	mutex_unlock(&sockmap_mutex);
>   }
>   
>   static struct sock *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
> @@ -1226,7 +1230,10 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
>   
>   static void sock_hash_release_progs(struct bpf_map *map)
>   {
> -	psock_progs_drop(&container_of(map, struct bpf_shtab, map)->progs);
> +	mutex_lock(&sockmap_mutex);
> +	if (!atomic64_read(&map->usercnt))
> +		psock_progs_drop(&container_of(map, struct bpf_shtab, map)->progs);
> +	mutex_unlock(&sockmap_mutex);
>   }
>   
>   BPF_CALL_4(bpf_sock_hash_update, struct bpf_sock_ops_kern *, sops,
> @@ -1743,6 +1750,7 @@ struct sockmap_link {
>   static void sock_map_link_release(struct bpf_link *link)
>   {
>   	struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
> +	struct bpf_map *map = NULL;
>   
>   	mutex_lock(&sockmap_mutex);
>   	if (!sockmap_link->map)
> @@ -1751,10 +1759,12 @@ static void sock_map_link_release(struct bpf_link *link)
>   	WARN_ON_ONCE(sock_map_prog_update(sockmap_link->map, NULL, link->prog, link,
>   					  link->attach_type));
>   
> -	bpf_map_put_with_uref(sockmap_link->map);
> +	map = sockmap_link->map;
>   	sockmap_link->map = NULL;
>   out:
>   	mutex_unlock(&sockmap_mutex);
> +	if (map)
> +		bpf_map_put_with_uref(map);
>   }
>   
>   static int sock_map_link_detach(struct bpf_link *link)
>
> base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
