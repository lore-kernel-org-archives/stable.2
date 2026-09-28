Received: from mail-ed2-f22.google.com (mail-ed2-f22.google.com [74.125.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0264EB870
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612959; cv=pass; b=mcdJUVBprzjnAko5934f0Fj6W5ygTnDPUzbNnVHFFPGCdYbNlV5WyGV1Qrbi133LlF2qHvUMD4sCcqWi9CEZ7WmmHmWKNr+F7sagqwBWZo+mMZNnZ5858qcQYq3uTKCDbEo9N3bMyzi49rWO+wqNPYhZmSEOYJuy9S8i6AGYtiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612959; c=relaxed/simple;
	bh=5ZpDSiHzrTaSbkIF2sxZryRiGeETjGD1f2Aqdfapuh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TP98BjCRiRSNxgu5obVZ+J6CCnrD3HeN781ZSK1l+unS8c7iwubSqdMoZivq/LGJAy1Nd+9UIv0UBlzgKolCy5UQ1AKBRFMYrvO2vIXbpLamwi/umVX4GeKlog+K5Kqubo+oas3U4qZnTmJgzjAxjmdiYjV2gqhU7FbvNEYPEOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXXRejpe; arc=pass smtp.client-ip=74.125.228.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXXRejpe"
Received: by mail-ed2-f22.google.com with SMTP id 4fb4d7f45d1cf-6aaf2ab41bbso403536a12.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612956; cv=none;
        d=google.com; s=arc-20260327;
        b=QB/5YmEWBGhT8ZNiMUpCqa44EscowKvnVaN1QJ6pWlaaZokeLxN9YVuFE4OROCkzf7
         o7oZWTMxIK+eAndvhxzGB47pW93QobZvCcnJ5Kboy6Oc/IJJsm/c6ytmWYw4DmnTchEv
         ckXhHS30ZOKIef23ngh5JbiPIH7NHIgm1XQWgnKi7A4pNH123rFnX2jY1JvMGsd8ffaP
         /tIkxzF5Mv3SI2MZ+/LZ9W6MeGcMqVUu0U9ItOcdQxXxF/hVymV9C1IOjWzZRZYFwed9
         bXleo+RqWbuOAnG3pRZKm2N+i0POtdlM9S1ZblWB8MorregqgkrSNIitkgOP8oMbD83I
         L3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7u/ahGnkjID4qDxOKcLNpzkE3Z5UyJkWp4xOghr9HIQ=;
        fh=BFcZlx6+AyaFg9ESGpgcwlv6RwZtsnU9LOeodgnSkLE=;
        b=UB0j8jjN5Gegjwzfl5ySLFOR5FThCglWkXN9bN6utl6nVm+7MyR4JYgF8766/Yp9c7
         W4QBJjTz38QilR8FCNyPQjkRLGL3Cb/rSBEjCK8r7UjxVJdEz7MucRqmwgOGHPOCRhq9
         xJP6qxWXGCihVmWINHFc1Kq9PUjMbpQctbLyG6NStUdXSC7Ekr35S7r76VOT/gzkuedc
         xnYIh2ItHdZDo8HAFAcdORCJjAZ5VCUCZrddWpKs5X8jXU6yF4Zh8eU8goiI2et4zJqu
         +jtK2mBoc4saVXSuy+8Enq82tawCW3rDUu/jn6yKnJnqfBfkAx7sNF8X27xFNfPjqwm9
         0QRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612956; x=1791217756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7u/ahGnkjID4qDxOKcLNpzkE3Z5UyJkWp4xOghr9HIQ=;
        b=fXXRejpeGUC+lY85LXuepgy4Kaz4eLdKAPBbj7y99OsDAho9h+j2hFkf82620ml7Xq
         JmqAbYlqJA2aDtwLeI9Ed5O8KwKS3piBsRH5qJhcGS61RYJnskfUUjzyBYi9QMbHOP+P
         j/OvSCd4Y+/RMx9sywI44JfdFh5zM/SYepG+88+IB14PUt9dT/3N5qkCCWX4d9tIEtW4
         79h4ACH33bPfuG0A7/IRsn8Je0v5wjsEh0m5lk7WJYipnEFXPEpdH1Ii3t7nERVuSfHE
         8pAA4YITA5cV9QVNCkaau4WWwg6ysDPW1QglxWvscMEWck/kDEJfrCV402q5CiBcSnhc
         pjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612956; x=1791217756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7u/ahGnkjID4qDxOKcLNpzkE3Z5UyJkWp4xOghr9HIQ=;
        b=AcXZh90ia/bp9C+Y9xiC6Jl4TaWAnvNlwfN/iTIKil4ZuZtHWAyhdT9xt5LX2YmecH
         dWoNlqOb7CYPwlWTZ2kEMKLyC+Q5dGhxMIXz/qqNr398fjnEz/0HAGK6nhUsXL0K8k+9
         etDzueFyScxeyLn7aYCw59kynxAmf4ZbJvEIvxW1XcE1KdwjDKl4t6VUxDHikj12ar3k
         iLOQtHxzhpV6bNfYRutdZWsNbHt2pA/qz8HqxCEb66VRpwxJmmt+qwQuBsn1NbIC3DYk
         sLjvLPH5OdK+Zv/fIkXc9eXgSuV1LuD2ENs6wKTcgODqcKN/2S5GQrXA914g2FV9NzKN
         kidA==
X-Forwarded-Encrypted: i=1; AKwUvBwJDKvw3JidyFW28yZVxbSq1/jdwvDR/EZMxYeEPVNh2mkc+zR01xR4PubysJkFGlKz6Yv4XGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwC8bXUrbRb4tgbzFjU2MKY+ppcfK7TJzide4ZhAd6KCg4tWdy
	D7W7sm/HQy4OHHiCFvCM+jsq3UC2k3lwXu5A4HRJoH2tTvVzPJAAS9w/w7WAu1co4BjuQ/kLBfj
	Y1jdQyExDT1AO1KmW6z9c5H1YJFXSfWc=
X-Gm-Gg: AYBFou0rI/NVMNtoe9RqJH5qITZ7nCO2PAZ17vT12+0hEL19EOPwc93giFx/j6afK3j
	7t5th9tc/74Men+EtCNPupJq1geND0tG9b2RarDMJrc2oHgrZIucrTeLV492An9h/jXb9mkgdTU
	UyZWMT/e6yiOLtwu/CiiOmTHC7pX8KNiRfFn/K+20szdHnbnqeqHipE6FcXv0zFFZZgsbiHPta6
	D+1+YIhdfmccK7eJrIodWw0GAS6BopktCYnhnFesktxrw1/qcnGuxx+6A4kH05EQ6azcV8G90F6
	pywhqP9uc3yURo24eV2El4fel5YKVnAEyLgE2wkHOaEj7xsrwXjHcNGbrLhnQjPA/CsKS/5+E8E
	m9prDRZDyptY=
X-Received: by 2002:a05:6402:84c:b0:6aa:a78a:6a05 with SMTP id
 4fb4d7f45d1cf-6aae1a75d8amr9224034a12.0.1790612955949; Mon, 28 Sep 2026
 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927071051.3693368-1-nicoyip.dev@gmail.com> <20260928123411.GA440063@shredder>
In-Reply-To: <20260928123411.GA440063@shredder>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 29 Sep 2026 00:29:04 +0800
X-Gm-Features: AclHuK9xxQE8kN3osXvIimBgpn5r9tT9LreAd5Hk603-O6WYi3sMJEJIxrsqcoo
Message-ID: <CAAo+4rU5h6Nr2Biq4WrpfCA4f_OfNabg-D=Pv3Rigu3amZdx3Q@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: Fix device use-after-free in ip_skb_dst_mtu()
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, John Heffner <jheffner@psc.edu>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:34=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Sun, Sep 27, 2026 at 03:10:51PM +0800, Chengfeng Ye wrote:
> > When a socket ignores the path MTU, ip_skb_dst_mtu() reads the device
> > MTU without RCU protection. The multicast and broadcast output path
> > through ip_mc_output() can reach this helper without an RCU read lock.
> > Netfilter releases its internal read lock before calling
> > ip_finish_output().
> >
> > A sender can load dst->dev and then be preempted before reading dev->mt=
u.
> > Concurrent device unregistration replaces dst->dev with blackhole_netde=
v
> > and drops the old device reference. After the grace period and remainin=
g
> > references drain, the device can be freed before the sender resumes and
> > reads its MTU, causing a use-after-free.
> >
> > KASAN reported:
> >
> >   BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x634/0x740
> >   Read of size 4 at addr ffff88810921c038 by task poc/98
> >   Call Trace:
> >    ip_skb_dst_mtu+0x634/0x740
> >    __ip_finish_output.part.0+0x22/0x2c0
> >    ip_mc_output+0x287/0x930
> >    ip_send_skb+0x11d/0x150
> >    udp_send_skb+0x63e/0xdf0
> >    udp_sendmsg+0x1235/0x1da0
> >    __sys_sendto+0x32c/0x3a0
> >
> >   Allocated by task 97:
> >    __kvmalloc_node_noprof+0x1d4/0x620
> >    alloc_netdev_mqs+0x81/0x12c0
> >    rtnl_create_link+0xaa3/0xe30
> >    rtnl_newlink+0xabc/0x1f70
> >
> >   Freed by task 99:
> >    kfree+0x131/0x3c0
> >    device_release+0xc8/0x240
> >    kobject_put+0x14d/0x280
> >    netdev_run_todo+0x4cb/0xc70
> >    rtnl_dellink+0x362/0xa90
> >
> > Protect the device lookup and MTU read with RCU and use dst_dev_rcu() t=
o
> > access the device pointer. Keep the MTU limit and headroom calculation
> > unchanged.
>
> This still leaves other potential UAFs in the ip_mc_output() path.
> Better to fix it by adding an RCU read-side critical section in
> ip_mc_output() in a similar fashion to its unicast counterpart. See
> commit 1dbf1d590d10 ("net: Add locking to protect skb->dev access in
> ip_output"). You can blame 4a6ce2b6f2ec ("net: introduce a new function
> dst_dev_put()").

Thanks for the reviews. The v2 patch has just been sent by applying
the method of 1dbf1d590d10 to ip_mc_output().

Best regards,
Chengfeng
