Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967B22576E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612379; cv=pass; b=n/WJCQB2NP2s95Uw18faDJ+lzqqpkl3PPRfMzj5Vf4Qp1fufV+nfWFRklIavHdJUr31FAFJy32OpXLSHj7JAJX0BF/xVMYO13YDE/d+kTjSIE2VlJtcIbqqj+zNJFViu4fuVrm52ufO1Gb3LiMnzGE+tFld/WSCUA83mk3s3YI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612379; c=relaxed/simple;
	bh=3A9g2ap1KJjmKy6RC23Gem9WM7kWz38YTsj8k6bVAuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPlk8X0O3VhyroXVJn6mRkpNldmfZR/otDXWHU9HPNj/ti7HHB8U6ww7tUflsfpOLY5nA3CqfzILAyH2fxv2KXo92hfaC9/YpwENrpjIuv0zyZKHcf3QnthcJzF4xET0EAmMpSKRjTaEdaqkRp1T+Y/wy8HcUu9WogVWwbOGyiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnMXcp3M; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnMXcp3M"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac8774c8b4so190667a12.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612376; cv=none;
        d=google.com; s=arc-20260327;
        b=blm76Xh6aqih21zF99Wqndl1QLSsqNTiW+9hPiBYBOhZWkhnFfm0XIBNcZhzNAojaZ
         gLCGYAK2KcAFJB6TSepagauEEMsvo0IiHeDzpmCscQ4pIbp72TRWhtldpqGxr5wtfI4F
         GgwCcWHgwKX4hWwPx2GCiBGD3jasO8eYfhG0gjreKz2I17SAPJx6pQS152O/h6CkbfGc
         sCGPzlip+wIbZo1HhDigg1AmLpu/RlmhyQPHUXfg6mTLz5uoGQSkSzlnJ2Bc8tPv2Yrw
         OncXb/nPatFi510+1hnnD3ag/4RB1K5FThnVlNATmzRgsYy7y3SkBWRbQFKOHwSoWES+
         LpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jQvG4bGgPbdzu06KIy/TUBHX3mHhGBFPCHJQeqk8Ip4=;
        fh=p3yLmF5oOmPs66iK1Ko+6+WkAZcB1rV0D10ULYGDue0=;
        b=pSqQi5lI3T/Me1MgRk3jyyAWO3G0iw/3HTkoz6JyWYXxujwn4YJwxotYyFn1x09P0f
         dVForcOBqCxrDkTWQkTBpWrxFfEuAh8nN7H6+oNn2a5gCAUbmUUxIpNdTV/S6rIJaaWM
         EWsR3clqKmcvaJPHLjzqq2+mkW8bxIg6Zqr71yu0kTwilKuAC7fITK25BztYDC6iTFtd
         jfRbAj6Bdc+7+ZHZsJdLqTP0KWFm2n+XXvmkt4prYvxhiSCzW1ewaX3iNcE/R0Dd+4X/
         JZGiUEIEiGXkIg1DQ6A26/Q0JCiaaDsrjxeSxwOcQL7+niVGOYj+iw++PtNwNBR4yocX
         uqJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612376; x=1791217176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jQvG4bGgPbdzu06KIy/TUBHX3mHhGBFPCHJQeqk8Ip4=;
        b=DnMXcp3MhI/3b4oLTbsXNyifDzuvrkD2UCHcUitFvZ0x3VCS8IUhqQs8BmKj7OuG7O
         mFo6HnmYbslgTFt2C/QbNGFXL3lZlbmTwE310Q0Druz7SaoRlkFQCyoQj6q/wYiTRJWC
         za1X/II2V4etC9no0oA/j4bwozoI31ZxkbPsCuREgXC1taREHZfpbHUsEE0Ozhn0xdRY
         xbM8culW/8p72mA0oGODK3tumoW9O07c8zzk/ECIMlXEm3YDwvOhiBx+3OXSrYkb1k69
         aCKQ5TuO4PyVtHfI2Byb+lHNMwP3MAqThJxjDUCZ6KSmCAo/1ISvZu5JL2NV6daXFo5w
         NZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612376; x=1791217176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQvG4bGgPbdzu06KIy/TUBHX3mHhGBFPCHJQeqk8Ip4=;
        b=nwcdiYZaaydiFubJ6iac3Cb5iud6ULVTN35QhXiVg9g1U8jgqxYA+Mr9BHkNX93n9E
         jU8h/K/FatAcbqCz4ue859KGEMDqyKWdTVMVO05/hjK4OmCE7gP6PWEXXpZB63qxikCC
         DUsm08HfkbpuCNy0AqOPANr6GjLcib97u4J8ptZ2Ah+mFTzX5Ifgg/Z2vkhEvOjDX6t3
         rLJcpqyw904JLNgS0N2bxngazi3ZVGjXS6sVlvT0YavLmA/CRlveFZ/KOZi+/TCUgrlH
         OH5BCsl+G8Gd8yf/TL2t73wybVT3pOIc2Z2ao9Gf26MkPRSwZwx/70OU0sIpLVijG3th
         7mnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyVjjZwLX17lmD0rQqkNFDUyMQ+83Yzl3I6TLgJ4F+nIsElisHveqDEWhOLLvBe0NwET+zGXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMJwIM1vj0WHPV57WOBswobMzXTjtrnf6F11+XVGcF6UPH2OTB
	p5J+HZ+Z9xDfhwmZkS1tthCcxMo+/9DW5abfBAk1u8p3ctcc8mukPq/l/UaGJcqcwKwitXT6wZY
	h+JlML1IKl4S8fvAmwbfaxdrWA9WMkYE=
X-Gm-Gg: AYBFou2MsoxotIZtUwo3VyFGfTplhhDNfrQMfkqsTxh02dnQMvwag0mCphk43B2q7ou
	5N/cB3rQuENjjvGLZ3l/C4ptuRrelBQ4G32RPbojYW0dgUOVtxQBF0ct0SJIA+6xHxyLAH/NUDk
	aRTj4bvnr+Lfs9T5u2RXHq7cDCi8FsYktHtsnbCR/LSv/OSNKgm+43J1E41p1j/f2nqvFEvFqb0
	AVLDpRMyIf953zPfZh/zwEjrJGsZpbCYIPojTJ7gjCgLLTEJLrmdFR+y0oJNFTeZ971AVg3TbDf
	C63NcYq5+q/tpF85ZxIR+slAOohC3jIxc0dblRP1OLpfok1g+NVsfjw930ssfScnaoE9SAspaDK
	wKuLvApD9nifOF5ifUtg0Lg==
X-Received: by 2002:a05:6402:2499:b0:6aa:e107:6110 with SMTP id
 4fb4d7f45d1cf-6aae1f1ed13mr8401975a12.1.1790612375470; Mon, 28 Sep 2026
 09:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927064036.3691962-1-nicoyip.dev@gmail.com> <DU4P189MB3750B9BEFE0E00F5D4A4D548C68D2@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DU4P189MB3750B9BEFE0E00F5D4A4D548C68D2@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 29 Sep 2026 00:19:24 +0800
X-Gm-Features: AclHuK-KsexhlYTzoGQ75pENZEy3A6R0mlRGjyq0G_Ek_LXGPOJndAF3IdORBo8
Message-ID: <CAAo+4rUEQGd0kJgMCXeJC3OorCYv120iJ0GyjaKgzKpyzNweBQ@mail.gmail.com>
Subject: Re: [PATCH net] tipc: hold a reference to nodes found by link name
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:17=E2=80=AFPM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>
> >Subject: [PATCH net] tipc: hold a reference to nodes found by link name
> >
> >tipc_node_find_by_name() returns a node after dropping its RCU read lock
> >without taking a reference. The LINK_SET, LINK_GET and LINK_RESET_STATS
> >handlers then lock and access the node, racing with timer-driven cleanup=
 of a
> >down peer. Generic netlink serialization does not exclude the node timer=
.
> >
> >The following interleaving can leave a handler using a freed node:
> >
> >  CPU 0: find the node under RCU and release the node read lock
> >  CPU 1: tipc_node_timeout() clears the links and unlinks the down node
> >  CPU 1: drop the list and timer references, queuing tipc_node_free()
> >  CPU 0: leave the RCU read-side critical section
> >  CPU 1: complete the grace period and free the node
> >  CPU 0: acquire the node lock through the stale pointer
> >
> >LINK_SET also uses the node's media address after releasing the node loc=
k,
> >when passing queued packets to tipc_bearer_xmit().
> >
> >KASAN reported:
> >
> >  BUG: KASAN: slab-use-after-free in _raw_read_lock_bh+0x1d/0x40
> >  Write of size 4 at addr ffff888112723808 by task poc/87
> >  Call Trace:
> >   _raw_read_lock_bh+0x1d/0x40
> >   tipc_nl_node_set_link+0x30e/0x680
> >   genl_family_rcv_msg_doit+0x1e0/0x2c0
> >   genl_rcv_msg+0x419/0x6d0
> >   netlink_rcv_skb+0x11f/0x350
> >  Allocated by task 28:
> >   tipc_node_create+0x9c1/0x1fa0
> >   tipc_node_check_dest+0x121/0x11e0
> >   tipc_disc_rcv+0xdbf/0x1430
> >  Freed by task 87:
> >   kfree+0x149/0x330
> >   rcu_core+0x50a/0x1850
> >  Last potentially related work creation:
> >   __call_rcu_common.constprop.0+0x71/0xa10
> >   tipc_node_timeout+0xb1b/0xe70
> >
>
> Can you update your changelog with decoded stack trace ?
> With decoded stack trace, It helps me understand how your reproducer trig=
gers the issue.

The partial decoded stack trace is attached on the changelog on v2.
https://lore.kernel.org/netdev/179061216640.31693.424352671155791136@kernel=
.org/T/#t
I will send you the full KASAN report as well as the reproduction
method in a separate private email.

> >Acquire a reference to the selected node with kref_get_unless_zero() bef=
ore
> >leaving RCU, returning NULL if the node has already been released.
> >Release that reference on every caller exit after the last node access, =
including
> >transmission in LINK_SET. Keep the existing link lookup order and lockin=
g so
> >concurrent link removal still takes the existing error paths.
> >
> >Fixes: 6a939f365bdb ("tipc: Auto removal of peer down node instance")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> >---
> > net/tipc/node.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> >diff --git a/net/tipc/node.c b/net/tipc/node.c index
> >bd91378b7540..2726bee3bb40 100644
> >--- a/net/tipc/node.c
> >+++ b/net/tipc/node.c
> >@@ -2424,6 +2424,8 @@ static struct tipc_node
> >*tipc_node_find_by_name(struct net *net,
> >               if (found_node)
> >                       break;
> >       }
> >+      if (found_node && !kref_get_unless_zero(&found_node->kref))
> >+              found_node =3D NULL;
>

> This checking is not optimal.
> Try this:
>
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index bd91378b7540..3e61e9106dd7 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -2421,8 +2421,11 @@ static struct tipc_node *tipc_node_find_by_name(st=
ruct net *net,
>                         }
>                 }
>                 tipc_node_read_unlock(n);
> -               if (found_node)
> +               if (found_node) {
> +                       if (!kref_get_unless_zero(&found_node->kref))
> +                               found_node =3D NULL;
>                         break;
> +               }
>         }
>         rcu_read_unlock();
>
> >       rcu_read_unlock();
> >
> >       return found_node;
> >@@ -2507,6 +2509,7 @@ int tipc_nl_node_set_link(struct sk_buff *skb, str=
uct
> >genl_info *info)
> >       tipc_node_read_unlock(node);
> >       tipc_bearer_xmit(net, bearer_id, &xmitq, &node-
> >>links[bearer_id].maddr,
> >                        NULL);
> >+      tipc_node_put(node);
> >       return res;
> > }
> >
> >@@ -2558,12 +2561,14 @@ int tipc_nl_node_get_link(struct sk_buff *skb,
> >struct genl_info *info)
> >               link =3D node->links[bearer_id].link;
> >               if (!link) {
> >                       tipc_node_read_unlock(node);
> >+                      tipc_node_put(node);
> >                       err =3D -EINVAL;
> >                       goto err_free;
> >               }
> >
> >               err =3D __tipc_nl_add_link(net, &msg, link, 0);
> >               tipc_node_read_unlock(node);
> >+              tipc_node_put(node);
> >               if (err)
> >                       goto err_free;
> >       }
> >@@ -2634,11 +2639,13 @@ int tipc_nl_node_reset_link_stats(struct sk_buff
> >*skb, struct genl_info *info)
> >       if (!link) {
> >               spin_unlock_bh(&le->lock);
> >               tipc_node_read_unlock(node);
> >+              tipc_node_put(node);
> >               return -EINVAL;
> >       }
> >       tipc_link_reset_stats(link);
> >       spin_unlock_bh(&le->lock);
> >       tipc_node_read_unlock(node);
> >+      tipc_node_put(node);
> >       return 0;
> > }
> >
> >--
> >2.43.0
>

The adjustment has been adapted in v2.
