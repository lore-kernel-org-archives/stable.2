Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E8414421
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116962; cv=none; b=pdJ16ghF91p5PRrUG+nhKi+6qEDQWxd2NW+7yZZocySOfm8B0n5aABKL6sofLPc/ULuU4eL8yOgtEztTlRXo3+szx32huiUB6+1IlojI94cbn4LpQvGROJcvqYURSjspR5qI8R20G8CGFr0jpDBq5iiNPGHWEJcgzgSsml8F1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116962; c=relaxed/simple;
	bh=tjCJ1OLd4bESmRn4ltE+OeVIx/6AdbNp7qosZGyVn/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hdk22mDr9BVWmT8TI9xr5hmPdozdp1z4vk9vGYGQoruqtGlil57CfSiaig/Pz9QlyQR2a3cGlFd3aREO3fd2IUXQdoC9QJhaLBQzlEN2RoATJym9Yig2ZLB7y8C8Dz5+XR4Z1BDTSbqN2tCSEXAhshoybAXzlNnVG8YjVW3QtTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hHogZNps; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hHogZNps"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3a7bf792424so339032a91.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 05:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791116960; x=1791721760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPmsD6wMbwGyIjjK6id1o7siDpKmgW9pQeTfa7Jr/0s=;
        b=FL4fyqpXLozuPpg/5/AYGIe3qFucPxoNXdLahUpnSTqStbzl+NlNoEZ9mXdAei3Kvs
         W/5lQhv/GX44Ho0M/qcGFRyUr94v4bnKvSaywrKKjawgqRtn4zMDvb04e1x2Q72ufOmB
         dqpjSdtEQKXfQnSUJ8ZjbxWafx/8o4zVkvCFWRqZj/YFJ7SHPEktxB9A+52QtHcRGjRt
         5ON9E4wjg2OF3UcjifcIcvH+ijqjMkVR1gprTu/gXEXsSrSRIEf2QK1Vweh5BbkvnWrK
         TPY+iqXRCIFxnKtTSyIElSpf/AHA2ydmyatwJ0ga0OzWHn54jfKBfTdsYGdvSvEX9owa
         rxJA==
X-Forwarded-Encrypted: i=1; AKwUvBzV1iMPaRnC7AssfT1bCPzpQH8f/3eZAj3xx6FTsY6RAlY4PeDO5yAsERw61RdUgs6sFGO6ahU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKm7eF+evcd9qZ1Je9wuTcyxyMaEocxgJtJX6h8krgD/fEUzldo
	hFGKyUEJWEIKwTYG5h+uBALecPBviGACMQr0nu0AV9LmDdIj1TNZMsxOPisn2SA996Jn4VYzKVR
	dxPEssZw6F815AyGoIG+sWGlfn//rjvxT9+iFqQPBhUiMDxeiaLezWh+iq2ibQwPL+0j92ElxBm
	RPURUshO9uvMsNHNF78qqicBo6pwwbxFH3pHI31U3uDXF8+487SWjDYcxXSSBMUnNimdPqks1Z8
	/JWkt7PxYidzptAtQ==
X-Gm-Gg: AYBFou26BsMGkDWz+AR5RtKP06APC91P6zQHQPzj2OVC6IU3yKDMkG3v8hcrpdx67UC
	1yM0Hf48+9NTdSHRvNX6gOnVTxJAXa3YFYDT2vG/IhWb//CnmiTnGtllCnxDFuO0gImyvw9XJxz
	IRY1m/lQAe5QmSMIff8NdL8w4irpruJ9T93vAc2f3naNjtqL2ib21aU+gmq/UOTd3MHt0GqUT8l
	W3LsD59KP6Za/QaZuZTZxwTXZkATTykRCR5MlXRndd+i+iAoISJL/MpxxkJx2ouLq+owXXhHhfc
	MXDvQVI+Qxro07S+GAPcYslH1dwNKmQagVjylWiCFrEU1P1M7/nNHSbSwrnFGGJDxhx9VwGXop+
	LX4Or3fnZfAWeqRQBsw2xWcmmrobbpi8N3+B3bE0ykbiEBzopp4nFwroohwOKTwWdwDEvSFFk/h
	ngSkLzWd8blMsKtjiZL9CKIBAZuaDlKCmvNWHYQOLjIA==
X-Received: by 2002:a17:90b:4e8b:b0:3a0:8133:69a4 with SMTP id 98e67ed59e1d1-3a7872b248bmr3554411a91.26.1791116960111;
        Sun, 04 Oct 2026 05:29:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a78e473003sm2702006a91.5.2026.10.04.05.29.18
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 05:29:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-34d62bb27a1so4499488eec.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791116957; x=1791721757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPmsD6wMbwGyIjjK6id1o7siDpKmgW9pQeTfa7Jr/0s=;
        b=hHogZNpskqlnr34YBNtaxLKJ4cuv7qhnkZjmKyeTzaVQAA5uffU69nPrAmMK8I2El0
         ip97LBzb4gQDSBEpEizY9kiaf1QCWgmg3eJ5WbGdhNF3gpfzjrdhpGrVf1wGxh6pb9Fm
         Rn5dHyj9SBe2O/zVEvFtSFtrBMmHTrRmsCkdo=
X-Forwarded-Encrypted: i=1; AKwUvBwmLmlpB2utpkPgxA7P99zqKGznNt/PC4Iva1jEN8kzFoX/EEHZgfqwL85izg+pipuEqazXXrI=@vger.kernel.org
X-Received: by 2002:a05:7022:7e8a:b0:143:298f:33b8 with SMTP id a92af1059eb24-151c4c11b5amr10031764c88.44.1791116956806;
        Sun, 04 Oct 2026 05:29:16 -0700 (PDT)
X-Received: by 2002:a05:7022:7e8a:b0:143:298f:33b8 with SMTP id a92af1059eb24-151c4c11b5amr10031715c88.44.1791116956147;
        Sun, 04 Oct 2026 05:29:16 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35126f01924sm4803605eec.0.2026.10.04.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 05:29:15 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll context
Date: Sun,  4 Oct 2026 05:29:10 -0700
Message-ID: <20261004122910.1392318-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930185417.61865-1-kmehltretter@gmail.com>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Wed, 30 Sep 2026 20:54:17 +0200, Karl Mehltretter wrote:
> With the default fcmode=0, netpoll calls ndo_start_xmit() with hard
> interrupts disabled and reaches brcmf_sdio_bus_txdata() directly. The
> function takes txq_lock with spin_lock_bh(), and the queue helper takes
> the embedded sk_buff_head lock. These locks may sleep on PREEMPT_RT.
> On non-RT, spin_unlock_bh() can run pending networking softirqs before
> netpoll releases the transmit lock, causing a recursive transmit
> deadlock.
> 
> Use spin_trylock() for IRQ-disabled calls and enqueue with the unlocked
> skb helper while holding txq_lock. On PREEMPT_RT, reject hard IRQ and NMI
> callers, where rt-spinlocks cannot be acquired. If the lock is busy or
> the queue is full, return through the existing drop path. Do not evict an
> older packet from this context. Suppress the queue-full printk because
> netconsole can recursively enter this path.
> 
> The flow-control callback takes another spinlock, so defer it when an
> IRQ-disabled enqueue reaches TXHI. The data worker rechecks the bus state
> and queue length under txq_lock before stopping the queue. Existing TXLOW
> handling wakes the queue after it drains.
> 
> This fixes the direct SDIO transmit path used by fcmode=0. Modes 1 and 2
> take the FWS lock first and need a separate change.
> 
> Fixes: ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

[...]

> @@ -2796,8 +2797,53 @@ static bool brcmf_sdio_prec_enq(struct pktq *q, struct sk_buff *pkt, int prec)
>  	return p != NULL;
>  }
>  
> +/*
> + * The caller holds txq_lock with hard IRQs disabled. Avoid the skb queue
> + * lock, which may sleep on PREEMPT_RT.
> + */
> +static bool brcmf_sdio_prec_enq_irqoff(struct pktq *q, struct sk_buff *pkt,
> +				       int prec)
> +{
> +	struct sk_buff_head *list = &q->q[prec].skblist;
> +
> +	if (pktq_pfull(q, prec) || pktq_full(q))
> +		return false;
> +
> +	__skb_queue_tail(list, pkt);
> +	q->len++;
> +	if (q->hi_prec < prec)
> +		q->hi_prec = prec;
> +
> +	return true;
> +}

Looking at brcmf_sdio_prec_enq(), it performs essentially the same check on
its fast path (!pktq_pfull(q, prec) && !pktq_full(q)) before calling
brcmu_pktq_penq(), and only falls back to packet eviction when the queue is
full.

Since bus->txq_lock is always held by the caller, using the unlocked
__skb_queue_tail() is safe in both contexts (the embedded skblist spinlock
in brcmu_pktq_penq() has always been redundant in sdio.c).

Is there an opportunity to reuse/refactor brcmf_sdio_prec_enq() rather than
adding a separate brcmf_sdio_prec_enq_irqoff() helper? For example, passing
a can_evict parameter:

static bool brcmf_sdio_prec_enq(struct pktq *q, struct sk_buff *pkt, int prec,
				bool can_evict)
{
	struct sk_buff_head *list = &q->q[prec].skblist;
	struct sk_buff *p;
	int eprec = -1;

	/* Fast case, precedence queue is not full and we are also not
	 * exceeding total queue length
	 */
	if (!pktq_pfull(q, prec) && !pktq_full(q))
		goto enq;

	if (!can_evict)
		return false;

	/* Determine precedence from which to evict packet, if any */
	if (pktq_pfull(q, prec)) {
		eprec = prec;
	} else if (pktq_full(q)) {
		p = brcmu_pktq_peek_tail(q, &eprec);
		if (eprec > prec)
			return false;
	}

	/* Evict if needed */
	if (eprec >= 0) {
		/* Detect queueing to unconfigured precedence */
		if (eprec == prec)
			return false;	/* refuse newer (incoming) packet */
		/* Evict packet according to discard policy */
		p = brcmu_pktq_pdeq_tail(q, eprec);
		if (p == NULL)
			brcmf_err("brcmu_pktq_pdeq_tail() failed\n");
		brcmu_pkt_buf_free_skb(p);
	}

enq:
	__skb_queue_tail(list, pkt);
	q->len++;
	if (q->hi_prec < prec)
		q->hi_prec = prec;

	return true;
}

Then in brcmf_sdio_bus_txdata():

	if (!brcmf_sdio_prec_enq(&bus->txq, pkt, prec, !irq_off)) {
		skb_pull(pkt, bus->tx_hdrlen);
		if (!irq_off)
			brcmf_err("out of bus->txq !!!\n");
		ret = -ENOSR;
	} else {
		ret = 0;
	}

That keeps the queuing logic in one place, eliminates the duplicate helper,
and simplifies the caller.

Regards,
Arend
