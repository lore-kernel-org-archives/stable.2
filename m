Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608673E450D
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897452; cv=none; b=trGET1568vqPELFE9n+00gHqhCSgHEoGfKDKfOlSYJwLCF0JDNafK7TBMJkGwW2JctPZJNZD07qYcUkOIP+xjonC2HsyDc1Nj8FW3753GLecqkH5h/JXPrrJp1oj16xT8L4KV2W3LGwJYR7t6pLYG1APnp1jV+Zcw7mcKRHi+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897452; c=relaxed/simple;
	bh=WQqvvD/sQatAVKeDt7OzSCnSoyrrtfFbAK2i7nM2NgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK4CsRjHbrYJ62XXSoAlV0Xm9sqZUPyID6dZsxHF9SmA0YkAZApwzqwLGwk9/uUsUcuyJUW8JRF1mb6oMwctokuOXz9iQkjbSmqv1ZJuHC7pss1JjD5X7xks92mwSnk3DP5xpUxagtkXF4MdUCa7Udf8xp9AgH7KHVKE9C2Hqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+RKq1TF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+RKq1TF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso72592075e9.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790897449; x=1791502249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DMTt9X+tMN/0URvJisKt8BWrlZlLlxVbSwTrZVovw7s=;
        b=U+RKq1TFEccUu2VyRUAOyCu9xPrXC0uBIhgO5ZIiSiQ/MSF2z6VmUP5SRw2gstarWz
         1NI83Qkz9tDXHEDTk67oOUFp5bCASW4QsllcMAnvhjEgMppYrJqMx1pZ+ltRe3bzV2qh
         TKN4bGbf2LiAiwWiyeeNwPuJ32OP7QQsFvegOOLqPWg2oWtGkAS8ideA0NDTeTFAAJvZ
         jeHavgpurXxyPkaZD3fpbgcnlYTmpmm93G0AOmT44pIdPPxB3aK7+wPtGj7c03Nk1oiV
         2wcsePHywtb+63SXWHtQKtslB06SKmxcO85WNn1yPxWer3hCXSyUQ0zI44XOu8ncGjGb
         YXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897449; x=1791502249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMTt9X+tMN/0URvJisKt8BWrlZlLlxVbSwTrZVovw7s=;
        b=Krd9/sgOhxwbvGvEQHF9AiLItgeqDhCfkqu+5GdzeWvqO9cRAsPw7gwn5d+fLxd1Ub
         G/+vJzqBKJor+qAc6KER1GCbcV7FnDdJGZV9qb5qlKprPcXHr1wg5vNipHV8F9xpKrE3
         GMgt3V5G/7h2jlN/h+N2mPtl6V00S2t4ztdGgUqbFt81ixCrP24fDi4wM2LBowFVARmD
         SYTLsNkEzDxC7x5KUGOgc9ZAFNd6zdRHac+xxC/15Ro/vQaKXuhzNQZC0jJZPXpbKPgz
         p1QzPyFTIoVKnSpdPrvglmVnIGpafmAgOAC8lmM4BvYBySDV9hnv14jZtVSFsj6Mnu6w
         29OQ==
X-Forwarded-Encrypted: i=1; AKwUvBwf1RaOWQKFG8tSn1yVEileVUvjRFmBYb+4aD6yOG+IWdhqgu5Kct+2sLNxOmUm4OayJOBCvr8=@vger.kernel.org
X-Gm-Message-State: AFuF++nquBkjeG0EBVDFiQWP2z/V5PHyMUprEcXfM26cQQ+ckJoSGcaP
	Jo9iJ2jI6wZH6L3axTNPqDEYt41HwZxNEMU3MbjVQdgU2cxyddYqakQP
X-Gm-Gg: AYBFou3DckLIRTkAlmgxqE9JKSY4GVspnPnqN9DOV32ilH4F10yAxhT+vi7xHLiMgMh
	OY+UIuTXU3mFpnHdhLe3jY+ahkmVbVw1HUFKiiVHgvbkqOCShiE1wfzd5ykrrOeq6O9NHl57ssz
	d/nGL1l6tFZyqORZuSMUdDGTgBWw8yThzaA4IREokias438ZY7/wGgTGELkURQloWLI4g/edatj
	x7uoQLnGdhq8ZBVi1bVoLrQNg1+5v8Ut9EgIhFzG3mZox0iy5kxQjMG2Jt0lmnAXDhhDOsF9BUi
	liKBFQGR12M4iCynoJ4648Fny208ZBFmJN9QDVFSSOEnNaxVaRCLQY5AYF2psD0bwDXtrmjePhJ
	7/Hhu0Zra/L0Q2WH49A1SOD41S6qgmHm6etZ8g7EdNVlhVlQudkSO55PD3syluZmGt+yCjPgCek
	T4QUZG9cNUYrJDPg674AcpuZXCAmzWU2lRug/9zxRKhS/HpVX7PrMjNbRSbv2NO2x7I64VXK/fA
	PxwgNvXaj3yA071cHkYqpoEQrxKYp+DTJhqTh6fR6nxhVrh9EUSm7ERi8U8okBvcvFEV9MAvhAf
	634NEUayQ6dmHleYVddEEL/TwJp6+3xZ0KdzuEYrS2w9HHbjPR4NNq6/KTTXlXFHuVhvbyFfkJF
	iz86zSWLl72I=
X-Received: by 2002:a05:600c:3501:b0:49d:2562:d670 with SMTP id 5b1f17b1804b1-4a02757ab71mr17738425e9.14.1790897448522;
        Thu, 01 Oct 2026 16:30:48 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-b3ca-3a01-3deb-81e4-0dc4-fbe8.310.pool.telefonica.de. [2a02:3100:b3ca:3a01:3deb:81e4:dc4:fbe8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm11717875e9.4.2026.10.01.16.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 16:30:47 -0700 (PDT)
Date: Fri, 2 Oct 2026 01:30:45 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <ar7sTVun7mF-4nl6@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
 <20261001074819.gQ3w8q6P@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001074819.gQ3w8q6P@linutronix.de>

On Thu, Oct 01, 2026 at 09:48:19AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-09-30 21:21:02 [+0200], Karl Mehltretter wrote:
> > netpoll_send_skb() calls __netpoll_send_skb() with hard interrupts
> > disabled. When direct transmission cannot complete, the latter queues
> > the skb with skb_queue_tail(). The sk_buff_head lock may sleep on
> > PREEMPT_RT:
> > 
> >   BUG: sleeping function called from invalid context
> >   in_atomic(): 0, irqs_disabled(): 1, non_block: 0
> >   rt_spin_lock
> >   skb_queue_tail
> >   netpoll_send_skb
> 
> How is this possible? netpoll is only used by netconsole right? And this
> is CON_NBCON so it only prints threaded. What is the missing piece?
> 

The call is from the NBCON printer thread, but netpoll_send_skb()
explicitly disables hard interrupts around __netpoll_send_skb():

        local_irq_save(flags);
        ret = __netpoll_send_skb(np, skb);
        local_irq_restore(flags);

When direct transmission cannot complete, __netpoll_send_skb() calls
skb_queue_tail() before interrupts are restored. Its spinlock can sleep
on PREEMPT_RT despite the caller being a thread.

The deferred skb is later handled by queue_process(), a workqueue
callback. Its requeue path has the same IRQ-disabled locking:

        local_irq_save(flags);
        [...]
        HARD_TX_LOCK(dev, txq, smp_processor_id());
        if (netif_xmit_frozen_or_stopped(txq) ||
            !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
                skb_queue_head(&npinfo->txq, skb);
                HARD_TX_UNLOCK(dev, txq);
                local_irq_restore(flags);
                [...]
        }

Thanks,
Karl
