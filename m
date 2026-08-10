Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF721C84A0
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786328630; cv=none; b=rTmYUKPo2rpqrQhhYCo2pdDqoD+ySDeA7svt4YJf+YbUjKaFoXbzmKoJitJj7iLy/jJTx+PB5x5px7+szKd6/4FYdIb53zqFdEgJfnNiq1vQ9W3bq4trZmSwFkZrHcCcLY0l+JlAsH/cJZJEoahPca/LA1QPGz2BfabZPrk+ecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786328630; c=relaxed/simple;
	bh=brIXrSHMNh+w2+wqvBdY6ZLq52aicUd2kThuQ+xFW+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e91bFPiZCs5HUv2oo/TUa0hMgF+fLGynYG2MfF6TYu9UaEwUMqkn1kO/YhrRxpkzVNeJc59EBN3mdwFceDseVgZNpmL6q0mG1YrNe9e2NWS1K7Fv8DXnnuRFHvdwvIABQ+X0QbcRJpjaenMJfOm//G9B/+iyPK+H5JSYXfa3SN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukle3woU; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukle3woU"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso727450a12.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 19:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786328628; x=1786933428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8/Xu6Bl9nz3vhT2oV8jvDAfGpBWDs2/HnpOEeUYYe8=;
        b=Ukle3woUorjutusatcUOV+w/so4QfCzhHs1JAVMuDNrk/XsRMDs1glmFRHrONcXSQ/
         K1E4iT65wsrW/ErPgFxHim02hn9FN2u1JTwBxGBnjUzy4stsbgZvg3MIoUnK6bWmUcIX
         cmU8BJzWEaOA8Z7PZsKXU53M4MYCstFV4ztc1z/pmUX59KOU8AI0MQjrcxWuop2z0qkM
         4wtUcDmQePfEokOmb7cr4QSx7TxXwKKD4eQEMLBdxuagCHRD0pdysbeszR/EeiRlxC/a
         RJTy6wZ1huV6fWy7bTUAjSwB9Vv4Ke12ObvApLXUq52+EIFXZvf9PNit+CHdxmd++/p2
         MLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786328628; x=1786933428;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8/Xu6Bl9nz3vhT2oV8jvDAfGpBWDs2/HnpOEeUYYe8=;
        b=nFgF8jNHuKuTiAnB2TR7Jzviwi7MJP313eFDtBsIBRHf2QFVFF69x3RAskKD8rHhgW
         dWL99t6gWZw+BTfniz+qnLVtqkR4RI+ALfm37d2qFMYAho92zIURhcOzOxBrQLk2WWdp
         QbICbDOKKiPx1jniejOY/KpHzdpvB9Y60IU2syqBKkQpOxOxW/fJZh/ycFXjD4qpR1Gv
         tiO/BvEimA6P62Ei5kLx3HqRqzxHiTto7Cv5K2836tipHiHZ2TaRKGQFk5KRtadJM6lZ
         2//fwEop6ylDSUNif5BOxyXXfVu25uFUYdDxKWbYzlsuUIq6cKCvg2k1KRjkI7l31s6q
         VcvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdEGPOACsMCYQUeFpmXzCq1zexUJYqykt4VhYw/xiAgtmM0vl5LsDkFhrrORFTlJPgXF70LBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAi61NJap/NYlQ044UYXE7TmIHi3UneJO7l0Grl2gM9vXaXVD
	lL425NyZVgnxdoitf44tW5OrivGRcD+injB8VP+cjjtoziYjFT6qil+c
X-Gm-Gg: AR+sD13NHz/xGf+U0iaSEhb5qSsFfdzJdqgNZNTai1H1ewWyJFnhV+iyZ186eS7R56P
	IH+IVetRx4Sntik7jFsNw0d00Y2StB3rK2lCbPTup6HJ6RAVfsT6UEj6l6Mz06aHEBcANbz2cnu
	j8iDtAR2qowZC6/i4POZRp3FVAkMapT+5mVxoZ0oVBeEuDN83TH6YEWUn+q0aQw0YccA1RN1jfC
	PofJsW2RVYhk+nlV2ZZ7bKBWM/8A46fu+mg0NU2u8mbv5DiKaQWsbXS7+MSLrwbD1h1IjKKDjwX
	p/nxr2JEnCAXasSuCGiK4kmpvCbgyfdNJDZEIkyKUuytha/oft9JF3uhSeoCPvmceQQf5ZJvZbn
	/5TjpVNAvRrsJALPXy6yjrfyvThvoIsKoQ4cPrqkyK/TrJDYZ7p6BLLmlrLh3cz9CfS8eRccafh
	EQlAcrz0K+ZTsv32iVMPFyAdg0SQHF8XUiH3mUhLNAKDostAnL12ma0DQ=
X-Received: by 2002:a05:6a00:ad5:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-84f2e021ff5mr41007248b3a.3.1786328627675;
        Sun, 09 Aug 2026 19:23:47 -0700 (PDT)
Received: from fedora ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a58bd4bsm3074067b3a.56.2026.08.09.19.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 19:23:46 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:23:35 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com, skhawaja@google.com,
	stable@vger.kernel.org, sdf.kernel@gmail.com,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/4] net: hsr: shrink seqnr_lock to sequence counter
 updates
Message-ID: <ank2JxDbOpX_wr5f@fedora>
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-3-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809121455.1745-3-xiexinet@gmail.com>

On Sun, Aug 09, 2026 at 02:14:52PM +0200, Xin Xie wrote:
> Commit 06afd2c31d33 ("hsr: Synchronize sending frames to have always
> incremented outgoing seq nr.") and commit 430d67bdcb04 ("net: hsr: Use
> the seqnr lock for frames received via interlink port.") hold
> seqnr_lock across the whole forwarding path. Transmitting while
> holding the lock can create lock-dependency issues when HSR devices
> are stacked with other net devices, up to a real deadlock (see
> Reported-by/Closes).
> 
> Since commit aae9d6b616b5 ("hsr: Implement more robust duplicate
> discard for HSR"), duplicate discard is order-independent (sparse
> bitmaps), so only the sequence counter updates need serialization.
> Limit seqnr_lock to the counter updates in handle_std_frame(); the
> master TX path (hsr_dev_xmit()) and the interlink RX path
> (hsr_handle_frame()) drop their outer lock, and the supervision frame
> builders release it right after their counter update.
> 
> Concurrent forwarding may emit frames out of allocation order, which
> sparse-bitmap discard tolerates. The master/interlink tx statistics are
> no longer serialized; consistent per-cpu/per-queue statistics for all
> HSR paths are handled in a separate series.
> 
> Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
> Fixes: 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received via interlink port.")
> Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
> Cc: <stable@vger.kernel.org> # aae9d6b616b5: hsr: Implement more robust duplicate discard for HSR
> Signed-off-by: Xin Xie <xiexinet@gmail.com>
> ---
>  net/hsr/hsr_device.c  | 15 ++++-----------
>  net/hsr/hsr_forward.c |  3 ++-
>  net/hsr/hsr_slave.c   | 11 +----------
>  3 files changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 5555b71ab19b..3fd1762d8916 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -232,9 +232,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  		skb->dev = master->dev;
>  		skb_reset_mac_header(skb);
>  		skb_reset_mac_len(skb);
> -		spin_lock_bh(&hsr->seqnr_lock);
>  		hsr_forward_skb(skb, master);
> -		spin_unlock_bh(&hsr->seqnr_lock);
>  	} else {
>  		dev_core_stats_tx_dropped_inc(dev);
>  		dev_kfree_skb_any(skb);
> @@ -335,6 +333,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
>  		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
>  		hsr->sequence_nr++;
>  	}
> +	spin_unlock_bh(&hsr->seqnr_lock);
>  
>  	hsr_stag->tlv.HSR_TLV_type = type;
>  	/* HSRv0 has 6 unused bytes after the MAC */
> @@ -356,14 +355,10 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
>  		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
>  	}
>  
> -	if (skb_put_padto(skb, ETH_ZLEN)) {
> -		spin_unlock_bh(&hsr->seqnr_lock);
> +	if (skb_put_padto(skb, ETH_ZLEN))
>  		return;
> -	}
>  
>  	hsr_forward_skb(skb, port);
> -	spin_unlock_bh(&hsr->seqnr_lock);
> -	return;
>  }
>  
>  static void send_prp_supervision_frame(struct hsr_port *master,
> @@ -390,6 +385,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
>  	spin_lock_bh(&hsr->seqnr_lock);
>  	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
>  	hsr->sup_sequence_nr++;
> +	spin_unlock_bh(&hsr->seqnr_lock);
>  	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
>  	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
>  
> @@ -397,13 +393,10 @@ static void send_prp_supervision_frame(struct hsr_port *master,
>  	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
>  	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
>  
> -	if (skb_put_padto(skb, ETH_ZLEN)) {
> -		spin_unlock_bh(&hsr->seqnr_lock);
> +	if (skb_put_padto(skb, ETH_ZLEN))
>  		return;
> -	}
>  
>  	hsr_forward_skb(skb, master);
> -	spin_unlock_bh(&hsr->seqnr_lock);
>  }
>  
>  /* Announce (supervision frame) timer function
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 0774981a65c1..8e4158a9b57c 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -621,9 +621,10 @@ static void handle_std_frame(struct sk_buff *skb,
>  	if (port->type == HSR_PT_MASTER ||
>  	    port->type == HSR_PT_INTERLINK) {
>  		/* Sequence nr for the master/interlink node */
> -		lockdep_assert_held(&hsr->seqnr_lock);
> +		spin_lock_bh(&hsr->seqnr_lock);
>  		frame->sequence_nr = hsr->sequence_nr;
>  		hsr->sequence_nr++;
> +		spin_unlock_bh(&hsr->seqnr_lock);
>  	}
>  }
>  
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index bb2182a169a3..8b96eafe15b3 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -73,16 +73,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
>  	}
>  	skb_reset_mac_len(skb);
>  
> -	/* Only the frames received over the interlink port will assign a
> -	 * sequence number and require synchronisation vs other sender.
> -	 */
> -	if (port->type == HSR_PT_INTERLINK) {
> -		spin_lock_bh(&hsr->seqnr_lock);
> -		hsr_forward_skb(skb, port);
> -		spin_unlock_bh(&hsr->seqnr_lock);
> -	} else {
> -		hsr_forward_skb(skb, port);
> -	}
> +	hsr_forward_skb(skb, port);
>  
>  finish_consume:
>  	return RX_HANDLER_CONSUMED;
> -- 
> 2.43.0
> 

Thanks for the fix.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
