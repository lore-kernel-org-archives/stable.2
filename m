Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550221;
	b=OXQ01blZ8c0z/ek2ZS4flMjOeA9FWLCl00o/J0VNnXsegqwB145wTgFBsqLPXNtk587d
	 7uVootko1GeNI0aD4+Wzdv/QYn2MkOAvOF7H0vaKlwB4I94PPdqbWmXcHT/GajOtKja40
	 FBlNdqil14MFJlXQiD0ztDfMcTYprPPrfndpJuxiX9AM0jv4K7a5w6wNclDVwa3iMzAYO
	 Vumkq1/HLqhbBWl760RdCoVqihw0Q1DEAqnhapr1BcRFqTSFEiF36ezG1UNytYAuhGfzS
	 nXTEv3t/RrAF/9GEoO3uDeGZDrq2omTn9yw66Qgio1SuhUECb6IHGTX6N/zoZuVQong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=DyLQXoFb5OKmGBBAgGagIw0B2qCSjYuLu1JiC6Z9P4c=;
	b=e3kj0iqJy0njPtMnaa9/jxIAm51CAriXr2102+hB7d5V/K7A4AcfduQRUGzodgW+wSTX
	 3EudhZDk/pCtjfzEdWYrRKmOPMSMp+GXxAOBT42WPq/cKJRrgDLke51i6smavBrdvAmnk
	 NaZH/Q90j0oAyCgQ0Afc6LJDTWIPZ7Po4bJgY16pUaAkoo5j38+KoBWohKGmhpRqF5C4O
	 7yORuvCdAAzecmH6hpRV4u/hqxEyYEL2/bfwZTZ5XipaAvbM+l8SQkWqhUdlgK9ZQEaHk
	 E7nD3in6p/CK9chiCkkKkT9R3y7o2CSxIqy9gGJmRGKM3FKNheEDfBYJ/MLa6XCeGlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYRT7+Ks;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB2606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EB2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYRT7+Ks
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cddc250d815so1935564a12.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795550219; x=1796155019; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DyLQXoFb5OKmGBBAgGagIw0B2qCSjYuLu1JiC6Z9P4c=;
        b=yYRT7+KsTCfMP1Z6JJkiiY+Tx7vt6OOEiM0BE+JrIsU93M3/BVd5Z980hIyg91t11w
         vK0n5iiAigyd4V4XXv2JR0x/tMzGiaK3YowDF0dQ0IDYL43ieUIvjRjLom+Jye6zseH+
         jqftuLxHI0i0IrtzpQmGl/pr3/duH70cZQkyRHM0dWXI4G+hYyLnVL6FtR7xpVkivmu9
         HKHmGGIhLQKUaDLCh35BchU8HHYM0pa1DwM7Zrn3u82IrFH9d8KCxq6UdrguVf9Q9rjz
         TuPi/p7IyoqHNOKL8KomleJEUb1OQ7ZD04UMwFksRkGLQlCrtxeOEyiHVhV9ch1FUyiH
         +kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550219; x=1796155019;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DyLQXoFb5OKmGBBAgGagIw0B2qCSjYuLu1JiC6Z9P4c=;
        b=WKnoPPsZAo6HJFOp4EcBU2B63KW1rmTEpNzEkwIxS/mvP/wXWnPhKC/TTVJ646p+5z
         QSxfauKcwd+g8myI3O8omPMPP2ZeAnRbcjuEXiVCzsCsxxLJaI6heeZI5WoY63Isfmww
         Zb/+DKQ7896A/wKkHxHvMnp3pCU0+xpAawOxwqPvPiozQfcd3gR/Z6JsaUzW5oeLgSU2
         TOzQqfYH6EMM39JSJj58p+NVGRSirwNWQyBH0mUhJPMOM+D5IfLmXYI2AUjEWmF1qZl0
         wMH487GCjw7CBcwpmY9uEF4bjXWR/UScre7OAqJrmRFm3VJ1bj0A6D55sfySMXE4r+Pb
         9Afw==
X-Forwarded-Encrypted: i=1; AL+hErFJf85YVdoSEzzJgHzF+y6/2O3HKsHHQ55LKk6eLrh1DJ7UKRz7mpLmLYpCsKllSyZY9drlS9M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RcIADn5xzNB0+W7J4bSYCDjPptFJ7d90viSWVDUsgTr39fx7J
	9RwKMSYYeZ3/bSHjqJq09xfcZJR/NcqQNdL4kSAUF2E1uVuqh9jCmuD9
X-Gm-Gg: AZFdTZfUoQyiLGSkdZNIiwi8VkDp/JqQCs6QClcsmy4PdZVVNt6ncui4FMAgtXqnRfj
	rxgNTvqkGSMYwzHI9RdBJOnA6wOlB7Qkkt1Zy6XMvimMP6LAqoVGFCev1ybahPsHpBQdhts/vH7
	BMp7t876OlsDLvCBmSuWUEEuMVxhm4bT5Ls3JEKr4gTT7XfC1HwYgYSkEyNzQmR37ywu8El8TyX
	/YirS84iaEqlzjGyItQ8wQkSss3yfFzziEBOhLOGngH+Ow7gNOZAGtceelVenj0QJHmVq/7rgp7
	iFmbhMEOHdDj6x3szVsy4Nh0/Sv6+i4rqUoeptd4rLlEQ21Kcc4QjaAo10LccVXjgWaZQMpBfGn
	GCFLmh2AnybufmNmKe0KoZQg9jv5n2atV28W6m+Tf7bT35QGEPbaW9kvrQZsSyj7BknMGA7etbm
	jgYL0sjrNrcdzuR74qOnWv4JcUnQsxzeG65ewZ0O2kwqQts8cGrV2mzVKIfjtUU2nP2zG09yAa1
	ENjT4XaG8umR14IzfiqJqqSomEJMoAyUymrXDT+ggFCJRwZZ6cGR2iURjtHnGyzMIyLP42hGIIp
	0sTxvI06F+8scziYsp9h5Q8Ho5dkVPL00HRPu3sfLNe9bDNk4o0CP8eYPUXhAlSBMW17R9tNSIE
	FjdKzPf1MO10NXYpZUzgBwQYnxMF2M698T1utjH9tBDkpsVxtSVA8zxs=
X-Received: by 2002:a17:90a:c10e:b0:3b3:d086:9c5d with SMTP id 98e67ed59e1d1-3b41c8dc810mr15654481a91.12.1795550219302;
        Tue, 24 Nov 2026 11:56:59 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm23891314a91.8.2026.11.24.11.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:56:58 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 19:56:58 +0000
Message-Id: <DN3PFJ14HKX6.1W8QEBXWGFTHH@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>
Cc: "Jiri Pirko" <jiri@resnulli.us>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Willem de
 Bruijn" <willemb@google.com>, "Simon Horman" <horms@kernel.org>, "Victor
 Nogueira" <victor@mojatatu.com>, "Po Liu" <Po.Liu@nxp.com>,
 <stable@vger.kernel.org>,
 <syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com>, "shaos"
 <shawnq1@163.com>
Subject: Re: [PATCH net v4 1/3] net/sched: act_gate: bound the cycle time
 and start time arithmetic
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <ACT-WEXM.v4.r0.20261124074514-1@mojatatu.com>
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com> <ACT-WEXM.v4.r0.20261124074514-1@mojatatu.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 06:12 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Conditions to recreate the bug:
> CONFIG_NET_ACT_GATE=y, and CAP_NET_ADMIN in the initial user namespace:
> tc_ctl_action() tests netlink_capable(), which checks init_user_ns, so a
> user namespace of its own does not help.  iproute2 parses cycle-time as

Well ...
after "unshare -Urn" an unprivileged user can add a dummy device, clsact
and a matchall filter with this gate action.

That check covers RTM_NEWACTION only.
RTM_NEWTFILTER creates the action too:

  rtnetlink_rcv_msg()            netlink_net_capable(CAP_NET_ADMIN)
    tc_new_tfilter()             no check
      mall_change()
        tcf_exts_validate_ex()
          tcf_action_init()
            tcf_gate_init()

Acked-by: Alexei Starovoitov <ast@kernel.org>
