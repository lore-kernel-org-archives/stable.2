Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C7383987
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112853; cv=none; b=YASxqA01oE92P4np2C4m1yNbOBEXysVf/cQtrQzygni1I2WaJAFpeJiMh4734zDBOZkkvWQrRpAwIKQMz1AbvoJQXDo2Wo9RYLrxvfc3TWTNDQRl+e1QyvTdKQImi0VqZQFNEUcg4SnqL0o84fNgZpVqA+jo4yQpJCsno6QXPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112853; c=relaxed/simple;
	bh=tJ6YIoKNUDojeg86gqnCuw1WTPa7k4m9/MpBN2CPG+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Doj4zaZSY61W7ky7dy7/2tC5eyybhjLz0MhRjQYX+tX94HY3jYQStjMyCQ80kLl5RZHQZKwTpwlP8+aZPgREiD5XQmUzCoBY5cg5ZModF/asVHAsL1xaFv6IuwElL+WcgL/v0n7z9ywnLM0siHNwBhEyNGxKc0hWLprzBdb0Vn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQbqc2jZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQbqc2jZ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb7926836eso2590389a12.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786112850; x=1786717650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dY6T8KLKe7c50VCzbw04TgHR78SFTtnFy4T2vHFIKTs=;
        b=BQbqc2jZvfZL+tgjDrZGUNXRoSQDjlvLCKTmrNYmIPTIzs7SEuIxMINYi/dNAPagrh
         qwP5jS/UsbQyPCf6ocQ6TtTEwHQDo+YGagEJxvO6r0vy+UWHBFxoLG1ivYmkMOL69wXo
         BUsr6yrzdc5VPdDxtzYOf9jwcep9cNibfMw26Z6U0ypmMcbvI/FTk7RVRIdQOafX9CMD
         g5iiiPTU5xtz+cwbQ69oC+sW9lXMmingA94DguRfi0Um5YH12uQxu2wFNhX4ZUilWUzE
         QK+aNFtgkqifGFgd/TMmJnanV/km9nDQmJeb7Bg3ZMJU/dpyrr2U+VeqRzyvwhBbzEgb
         gFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112850; x=1786717650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dY6T8KLKe7c50VCzbw04TgHR78SFTtnFy4T2vHFIKTs=;
        b=FTDBNLYKT35S764NcXJY+3tkDvdNno+pfuMvEWK+I/JTf94fTA2x33wPulKZB2bwEv
         ZyczkqouFQAdqO+z6DcXMkRaWrtb/lXfJTQeziE2iCQfoSfodl3PBkyzZ8X/5xj58en7
         hW9x6zMm6MJq9ED/42AgtMrvUzP2UL5UU+asWWcvZtBGkHnBVKV4AmmHk3n5nnPUtYuT
         +xQ+9w7cF3r41SQs/QaBE1O8VBjuP7qF86esHpsQPi0PH17svaxx3vKkoqCNYNEhxQsO
         N3H2do3iHVTfyftuJD1D7crpJB86o/AHP9dDYtcKkdEKw3SYwqNw/4yT50tnnGEwB1My
         r2Nw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3JKDd2DAhZcDzy1wlY1ygQ5O6Ww9VOuqwKDzU3hXEl56hNrP1DDEhcPLBz08VY6M1jabWVLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQyDPNV9ObkrY3TYeKvASL7dqMjQLuvXDbtjbQOuCKQd9jjuS
	CidUaF4IkQxIDFOakJIfR1Cst4pmQAyNlhNvzICZjT2Um1BrZGdowWR0
X-Gm-Gg: AR+sD12QbSGel3HEu/K+2WCD5qe/nGQcsqKwzJNV4RvJlM2LxnJO/fI9ic8d9S1IF4k
	qDDcoBF7fW8VsOk3/ZRGUWanRGFyPEAc/eYI8uP8IzT0POe2KUP802h4B/OSHDsmFH4wpOZbgyZ
	/g2orIR2DFUzllcOT7K5Z97d940GTuT4NqcOelQA1IcjxEWn1COULrx/+EkXGldgmRXiRVsF52T
	tUfjTE+KZWRiAgnNUkyG3ZowHkTXgve75tY3ctJKDVrpAh6xkCuMoA9Dr0UC/GqePp/zd6/lPCh
	Y/Bho7VYGwd3GFVUrBK1gh/HcwpqM6HOboXOaLE0kOQPpIkM91AgDsmWyS/XTIUiaafNHECRr4B
	/vfU0tAL0DBsPnLm0kSZ6eC6zNmFAliq8jZ/LQADUMqMFEliaymcokvqomxsutUYuPbXH3ZNRti
	roHfRvstdNDoWsKjKGW8EOXH//1OCM8Humc6uMl8lU4ipdDmBJKeGicBo=
X-Received: by 2002:a05:6a00:1705:b0:82f:38df:681c with SMTP id d2e1a72fcca58-84f2e0228e1mr21662231b3a.6.1786112849746;
        Fri, 07 Aug 2026 07:27:29 -0700 (PDT)
Received: from fedora ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm1125866b3a.43.2026.08.07.07.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:27:28 -0700 (PDT)
Date: Fri, 7 Aug 2026 22:27:19 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com, skhawaja@google.com,
	stable@vger.kernel.org, sdf.kernel@gmail.com
Subject: Re: [PATCH net v4 2/4] net: hsr: shrink seqnr_lock to sequence
 counter updates
Message-ID: <anXrR6-2UVYF1iZa@fedora>
References: <20260803222211.877-1-xiexinet@gmail.com>
 <20260803222211.877-3-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803222211.877-3-xiexinet@gmail.com>

Hi Xie Xin,
On Tue, Aug 04, 2026 at 12:22:09AM +0200, Xin Xie wrote:
> hsr->seqnr_lock is currently held across entire hsr_forward_skb()
> calls: master TX (hsr_dev_xmit()), interlink RX (hsr_handle_frame()),
> and both supervision frame builders hold it while frames are built,
> classified, duplicated and forwarded on every port. The only state
> that actually needs the lock is the sequence counters themselves
> (hsr->sequence_nr / hsr->sup_sequence_nr).
> 
> Shrink the locking to the individual counter updates:
> handle_std_frame() now takes the lock around its sequence number
> allocation (replacing the lockdep assertion), the master TX and
> interlink RX paths drop their outer lock, and the supervision
> builders release the lock right after updating their counter instead
> of holding it across frame construction and forwarding.
> 
> Statistics: the outer seqnr_lock also incidentally serialized the
> tx_packets/tx_bytes/tx_dropped updates in hsr_forward_skb(), which are
> reachable from the concurrently callable master-TX, supervision and
> interlink-RX paths. Those updates now use DEV_STATS_INC()/
> DEV_STATS_ADD(), the atomic legacy-stat helpers, so narrowing the lock
> does not turn them into lossy plain read-modify-writes.
> 
> Ordering: with IFF_NO_QUEUE and dev->lltx, hsr_dev_xmit() is
> concurrently callable, and this change removes the old
> allocation-through-forward ordering guarantee there: master-TX frames
> may now be emitted out of sequence-allocation order. On the current
> tree this is safe because duplicate discard tracks individual
> sequence numbers in sparse bitmaps (commit aae9d6b616b5 ("hsr:
> Implement more robust duplicate discard for HSR") and
> commit 415e6367512b ("hsr: Implement more robust duplicate discard
> for PRP")) rather than requiring monotonic arrival. Sequence numbers
> remain unique and monotonically allocated per counter.
> 
> This is a latency/critical-section prerequisite for unfolding GSO
> super-packets at the forward entry (not a functional prerequisite):
> the segmentation work should not extend the global sequence lock's
> critical section. Patch 3 depends on this change; their automatic
> stable selection is limited to 7.0 and newer, where sparse-bitmap
> duplicate discard accepts out-of-order arrival. Older stable branches
> require an adapted backport.
> 
> History of the lock being narrowed: it was introduced by
> commit 06afd2c31d33 ("hsr: Synchronize sending frames to have always
> incremented outgoing seq nr.") and briefly removed by
> commit b3c9e65eb227 ("net: hsr: remove seqnr_lock") in net. Merge
> commit 46ae4d0a4897 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> reverted that removal because
> commit 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames
> received via interlink port.") in net-next had already superseded it
> by adding locking for the interlink RX path. All sequence counter
> updates remain protected; only the forwarding work moves out of the
> critical section.
> 
> Cc: <stable@vger.kernel.org> # 7.0.x
> Signed-off-by: Xin Xie <xiexinet@gmail.com>

Maybe use a shorter commit description.

[ ... ]
> @@ -746,8 +747,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
>  	 * So check and increment stats for master port only here.
>  	 */
>  	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
> -		port->dev->stats.tx_packets++;
> -		port->dev->stats.tx_bytes += skb->len;
> +		DEV_STATS_INC(port->dev, tx_packets);
> +		DEV_STATS_ADD(port->dev, tx_bytes, skb->len);

Note: Avoid these macros in fast path, prefer per-cpu or per-queue counters.

And the counters in hsr_deliver_master() also need to protected. Especially
multicast.

Thanks
Hangbin
