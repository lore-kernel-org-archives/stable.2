Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918D37EFFB
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704912; cv=none; b=bezkE/Nki+8sSIAwsarLuDn9QRneEY8BtI1j20ARUh1DWMPU5bXC+i22pAo/MeldmsPVQQviB0nW3ZYlusk9PAgjFneHOmwV6UPnXCEjgXgsRzrCMOESV23rXTb7rHNX9eN1+KzlBwc0ecSYGOsbnK5r/gY7w+NVJJ0XE1gvjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704912; c=relaxed/simple;
	bh=v47biJGyTwUO9XfglPqg0Q9AVwt+InUiI+FjvQHeaQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSbl/o8xMBIG7QByhUXfxPo0T5K5Nc0HexwRzShmgG0hm2Ubro7RyseQDpg1HphgfoTerjvnNGPEYHrIa/ILwvM65ePV9N+mbLyU149S9CRMlrN9kfHmNwkqdgGhkCo39Gm6ac2mFVG9YELx1IJovnK20mXKUmDEB55tCHxWf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxPYem6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxPYem6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9733A1F0089C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704911;
	bh=wA+/krenvKND0SGdUag51BtUkhIYeOVKdVDCo9ZLgfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cxPYem6Bk3XVbfkpa31I3zey/VHrPC4VUUeHhHgYHnwjogGBpHcLnQJqLe2QOYrC/
	 w23IZUODm2QracyrsZB6aLAXeKVUOv2pNmuj4yuwtOyir5O8wkStZi+KnCn2rtEBlm
	 dIVCxi6Arrfcp/Xog8IsoIJhB7WO3kMvfjpGgd51rqjR6fsQ3cyCl1nQL+fcoCvkvb
	 dfO7PQoDB/fcltcIwekIPmdw0jiYw02zJzMYLCWdHLOEnOJdsqXiGwB6t5NEvm4cm/
	 Jfye8W1DWkI3OJlbZ8iHmMa1ynEygcZlhTE5scPi3+ChNDa8swa4GS6jLKaipIzxz5
	 SS/Gzhrwl3iwA==
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d817a94755so815740eaf.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:01:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByKGU4tBIIzgL5S8e0Z3NifMfgwo+mQfhZAkhQ6P6wBX63Kshu2Jua+wB/sHhpuaNr5IbtQhxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nTi/9Zw/MjUAspUOaJwLaS8Fo23wjjdZwyo2WFLDxtJpn+AdAh
	uouNv+peAupOJKLm7KY7jxI+1eiViMnxTPJAcuQsVZLMrkZClIVc4nhwarqTivYQlxDfLYkbI42
	s1Lkm7DO+3VakH51LcH9Ll4PsOSw4lYE=
X-Received: by 2002:a4a:ee14:0:b0:6b9:c226:ffca with SMTP id
 006d021491bc7-6dc72543b43mr97892eaf.6.1790704910709; Tue, 29 Sep 2026
 11:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929170444.218093-1-parri.andrea@gmail.com>
In-Reply-To: <20260929170444.218093-1-parri.andrea@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 29 Sep 2026 20:01:39 +0200
X-Gmail-Original-Message-ID: <CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=PPSK6Q5f6w@mail.gmail.com>
X-Gm-Features: AclHuK8d3O29vRQFC3ZWh-9zIhRSdBaWP-QlEB2WBkOrMqu2AG_jOc393I2UFS4
Message-ID: <CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=PPSK6Q5f6w@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: wait for RCU readers in rtnl_link_unregister()
To: Andrea Parri <parri.andrea@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 7:05=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> rtnl_link_ops_get() finds ops on link_ops under rcu_read_lock() and only
> then takes ops->srcu. rtnl_link_unregister() unlinks ops, then calls
> synchronize_srcu() and cleanup_srcu_struct() without first waiting for
> RCU readers. A reader that found ops before list_del_rcu() and has not ye=
t
> taken ops->srcu is not waited for.
>
> Such a reader then locks a cleaned-up srcu_struct and keeps using ops
> after the module that owns it is gone. rtnl_newlink() and
> rtnl_dump_ifinfo() both look up ops without RTNL, the latter for any
> user that dumps links filtered by kind.
>
> With delays added between the lookup and srcu_read_lock() in
> rtnl_link_ops_get(), and before rtnl_link_ops_put() in
> rtnl_dump_ifinfo(), running "ip link show type dummy" alongside
> "rmmod dummy" on a KASAN kernel gives:
>
>   BUG: KASAN: vmalloc-out-of-bounds in __srcu_read_unlock+0x57/0x70
>   Read of size 8 at addr ffffffffc02ff318 by task ip/147
>   Call Trace:
>    __srcu_read_unlock+0x57/0x70
>    rtnl_dump_ifinfo.cold+0x30/0x3b
>    rtnl_dumpit+0x7a/0x1b0
>    netlink_dump+0x486/0x11b0
>    __netlink_dump_start+0x661/0x910
>    rtnetlink_rcv_msg+0x611/0x9e0
>    netlink_rcv_skb+0x126/0x380
>    netlink_unicast+0x605/0x830
>    netlink_sendmsg+0x6d0/0xbb0
>    __sys_sendto+0x335/0x3a0
>
> Call synchronize_rcu() before synchronize_srcu(), as
> rtnl_af_unregister() already does. This should be enough because
> rtnl_link_ops_get() is the only RCU walker of link_ops, and it takes
> ops->srcu before rcu_read_unlock(), so every reader that found ops is
> covered by synchronize_srcu() once the RCU grace period ends. The extra
> grace period only costs time at module unload.
>
> Readers and the writer were serialized by RTNL until link_ops got its
> own mutex, which is why the missing RCU wait did not matter before.
>
> Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  net/core/rtnetlink.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index be9d1625bac31..abcd2c4ea2178 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -707,6 +707,7 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
>         list_del_rcu(&ops->list);
>         mutex_unlock(&link_ops_mutex);
>

Patch looks good, but I would probably add a comment here, because all
these barriers without comments
are a pain.

/* Wait for rtnl_link_ops_get() readers that found ops but have not
yet taken ops->srcu. */
> +       synchronize_rcu();

Adding comments for the other barriers in a future followup would be awesom=
e.

>         synchronize_srcu(&ops->srcu);
>         cleanup_srcu_struct(&ops->srcu);

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
