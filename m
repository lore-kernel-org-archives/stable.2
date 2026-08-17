Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C63AC0FC
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001944; cv=none; b=NFF51HY018ACjYBezhi5EAPv8UKCpyNKWKUGYqT0JcAfvRnzA901un284Ah0/+XVrTYvfmTcdO/AH8y7NU8+p0XNcuAMvFMWd8XfvMetsYfwK5vIgSXwDfC/wjDJxAFrhStQWF+s7kaiTb36mZsLseG4W4AkvkoUfHkzfQDkmTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001944; c=relaxed/simple;
	bh=b1rVj1Guva+RSqdfoO0PWtAfhq6tn9ymEYDkIFEHGBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIR2IbQl/0h+n979gFEpShtV76mTFxO2/PrG9VdC9J0J41CYsc+8xjPxAeNvrdOolXX9kUJaoFVGqQL49Xq1s7Qmq8v3q6U+MVkEkqsoOHzFW4Be/2wYSIMdYsgXzAZOGuEUovRI6fwvvOv1A2/wq3gk/csfwVz0d5Ed/IcLqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKz4fHWF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKz4fHWF"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso4032720b3a.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001943; x=1787606743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1A2sgUy2ZoNqm8rYmI5BN5LT1SeJ4RxD4BMZkaHv9+s=;
        b=lKz4fHWFDb/dsuOSKl1oW+DHN5P0LN+/DAVMaH7H0FFkfUYSv74KoQc2ZHAcbFxxyb
         yc+v9hpi2I6NZvO5CmMN86nCdLva8+DRlxOkLoSUbHKORPtXJe/bWndY9nMvNEU7wkmJ
         WpeojviCZwP1TrmTF8FnuzsvgOspMX5Nv2tYO7x++O/mqghajKZFgflW/eS8bo4/1cBU
         XQ1oAuG6kHgZApizJkHhB6vYZcneEXjy6tWdtXf1bWHq40+gBuDevTxqbi6aLqn4+FSN
         gQNX3kgZrbaMD9P7x8EPL3y2c6Iq4WOSS082ztzXsplIUbdhUiRsFq6hU7E7jBqTBgwN
         pINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001943; x=1787606743;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1A2sgUy2ZoNqm8rYmI5BN5LT1SeJ4RxD4BMZkaHv9+s=;
        b=CNkhZh2Zr2yZRro+wpUD/W+erNq9BRsIRpU0VGhtU/39aJOy9Jqq3WitCH7/WD8AV2
         PQyco+/qScZ+7caHeS9UFU6YLSKkDN4rnHVBCn7BrYSz/ZmQIuD0+CA2PGakIQ/0f/Z8
         K/8pE/ZrOxZlGJJ/4JkS5gpGm41URWW56rCKT7F7klM4IUZT7sydlrP4ErsjYnt9DwH0
         Ib8gp3MwTTGqJ4OaHpkiYvgBum1jqJQKnDjmvddSDkfpMFE9c9XQEjb1oRLDKVs5n8at
         snIYsX+OKmNC9JjUhbZgZiU90Y2HQ0ZtEgfMy/WgckTKT2pLc04pHzSAUVgfYVtax+Fx
         Gq9w==
X-Forwarded-Encrypted: i=1; AHgh+Ros9VohXnKway8Mc1ssIVziifPN69PVbHTeIMGZGRYstap33y0IVPZ+CWYAFOglNNBVHPznusE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9uAcALiEIaLO7SgpMoRoW+uB4hPb0Kkp0rGIEo/3Hmwu2cBCY
	Fe8yxqlnfVFhlS6h8p9jZxPxn3eEFav9AWn8sG1Q3yC9VvbuTqwvZ/Qx
X-Gm-Gg: AR+sD12zsre3Cer0sY/5nYM/9FQNOS+mlAJFSh3sqGZ60gvVowBv5Q+rgy2Rj7ZYi73
	vYQB6oaecCo+VftujHuPx3xr1IzuhbeHB1vld/rU5cmgd1pJfHEQX5GQ+MIB+E6HNCD+ldI+oBy
	yULRoLUMvPrW/tC5JFXxM8eJbO6tybv1eAWjnPWNcWnleSUetRkRF7If06a+/pFO3doEEDfuzhl
	L/Fuu70y2st5z1WxeJjIyI/AjdaJYb4IS2+KxFZ6xGsIgNCUKifYN4k5d/iAAbg9QGbA9sC1LRd
	F4ibIPUgUTP66J0jo7y6NBgT14e5e+xfg4+Za1xRMo6VVzntOE+YWrYSz+cfFIWU+8x5aG6Kc5D
	pphkILIsblwz2N/buoH3Cvue/toMJGECzzAT6rIEHYF7kg8F3AE4AbhQ9AEewyaKtEWzm8SRadk
	Nt7vNjVuZRRKveQmIlK9n39SrVin8e5CapM1emEig1YK2zkZLz2bx0VgUc6T2Cexlz8OjLBvNXl
	xrkaImm37Cq+WT0a2c=
X-Received: by 2002:a05:6a00:4ac1:b0:847:9aa8:d3bb with SMTP id d2e1a72fcca58-84fde15f1a9mr26256278b3a.12.1787001942525;
        Mon, 17 Aug 2026 14:25:42 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c00d77fsm1284767a12.21.2026.08.17.14.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:25:42 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:25:37 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, ncardwell@google.com,
	kuniyu@google.com, horms@kernel.org, willemb@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net 3/3] tcp: do not inherit out_of_order_queue from
 parent
Message-ID: <aoN8UYf5as4IWCon@v4bel>
References: <20260817090319.3897799-1-imv4bel@gmail.com>
 <20260817090319.3897799-4-imv4bel@gmail.com>
 <75320acf-e9be-4eb2-b52e-f344969f235d@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75320acf-e9be-4eb2-b52e-f344969f235d@linux.dev>

On Mon, Aug 17, 2026 at 08:27:32PM +0800, Jiayuan Chen wrote:
> 
> On 8/17/26 5:03 PM, Hyunwoo Kim wrote:
> > A child gets a copy of the parent's out_of_order_queue, which can be non
> > empty when/if parent morphs from listener to active session. Parent and
> > child then point at the same rbtree.
> > 
> > The parent is no longer a listener, so inet_csk_reqsk_queue_add() forgets
> > the child immediately, and tcp_disconnect() frees the skbs the parent
> > still owns. The parent's own root and ooo_last_skb are left alone, so it
> > keeps using those skbs. That is a use-after-free, and the parent frees
> > them a second time when it closes.
> > 
> > We need to make sure this can not happen, by initializing the queue after
> > socket cloning.
> > 
> > Very similar to commit 8b485ce69876 ("tcp: do not inherit fastopen_req
> > from parent")
> > 
> > Fixes: 9f5afeae5152 ("tcp: use an RB tree for ooo receive queue")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >   net/ipv4/tcp_minisocks.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > index 6ab3e3a0b43173..d13813d50947dd 100644
> > --- a/net/ipv4/tcp_minisocks.c
> > +++ b/net/ipv4/tcp_minisocks.c
> > @@ -591,6 +591,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
> >   	newtp->total_retrans = req->num_retrans;
> >   	tcp_init_xmit_timers(newsk);
> > +	newtp->out_of_order_queue = RB_ROOT;
> 
> 
> Does tcp_rtx_queue suffer from the same issue?

No, sk_clone() already clears it:

	sock_copy(newsk, sk);
	[...]
	newsk->sk_send_head	= NULL;    // tcp_rtx_queue

I also checked this at runtime, and the child's rtx queue was always
empty even when the parent's was not.


Best regards,
Hyunwoo Kim
