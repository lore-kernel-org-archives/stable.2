Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794039089;
	b=wp/tPqzv566n9PjBXs2tU4grBojJXHE0guZVyjFNfBIS26+tvdnz27TTh+aW1ADREvsT
	 TKveFzqWurAnunLfhvptVZe5JF6TGbO3C/U4BektwZ5ltHD8sZx6rWKZAVdPcw/4Pe0Ws
	 Y9oPcU8jPT9BVnsqmbM3aHbMJhFH5DYswlF3YOguwi9zsAIb/8zBSu/CbCsCmCeH7r3xP
	 M85dVHuC4hclbbIjaxCB4siz2zFbBBFDB1XRg4DGo6LbabixOogeBvSlU4vG7uYOqtznG
	 hS9JY28lQ2Aj4tu8f1/166DFL5ugS+oOLtlUGHXnEQ4OyC29dUCMYLfRD8czctxV77w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Mhkve0AREgIHZlQo7Mk2vGGc3A9EkMtvF/OVPHAgmwA=;
	b=2ePfa+vMd44mLE5QMy3PTovS8i+NKhxjq9z4gkSxhh+VPbmmwQ+Bas9ebGE3llV0g4m6
	 6THfIJD6exh9CnfLTnALBbukwXlXfFEEPI0KwtAmpQEN5k3wHv0K/96RPzxYkv62d50ZS
	 r17msmD8m3alT+M1MBO//UA54WV8eqH21hu5TNY/Az3whi8eFVjh20TlHa28KMqV6Z76B
	 buCb8tuybF1VPsRVUMGvA2QJ+bwq+oowY/GthIuU4x4zYN5mi0tNpe0Ks/Rc/hAUz97TD
	 cSd4NzaU8U3b2ZjXwivIxnjMPGxG3bPcF98fyZyfRPIPUOd/KKHBMkqRnN8XhoSeZkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=i+BZEnQe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698A606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 08:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C698A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=i+BZEnQe
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b566cf56c1so1480708a12.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 00:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794039087; cv=none;
        d=google.com; s=arc-20260327;
        b=bNdm3pxX7qOULYAgumH9fl7PZ2mVE68oubb79UUpxeILpW2YlgxCDHqVpnjiKO10q7
         GEQ4gDK0AoOjmBgI3w/TWwTtWc8IzwPbpqkwYEMDbJMV2FyqGExvzpLXLBzJJZh7wjHd
         PtHqTHTATbM9g3EzN5WKu4iSaqjO0dz7/x4GF4JohUN/7gOpqC7iAQAD8NOb9BKDAcWQ
         ibGzTadZd6XnIuhAx6P6/s/F1WOGAO5yPmBiZlncdbmNdqmgKpOJA1ws7omOKZiof/KZ
         +brdMFUUv8OsribclqdtKWSLxk14AAWkMPHN41LtxtTF/92yFxYy0iZXZARu5qLQ89FA
         5YUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mhkve0AREgIHZlQo7Mk2vGGc3A9EkMtvF/OVPHAgmwA=;
        fh=oVis4dUFk/3u6zHBsP7UV04xSVk/Y/+1kXMuJHoT/k8=;
        b=Ykq/P4tpMqm83uVCPq985fmRRTGycS44LIAehkUwxqYrbhUNtqWFyMcBdd8CSqr4gb
         f+MRgspWBOW+0HQXwJkL6legLfgkAPd5BMMCwqzj5tNugVO/S5Qf4iq74E0BME/E35BW
         PhFhZbCeHL+JEAuOZEcgBFCfxYgmMIANn57r0/fZrRzlk/pMyteqBNMmp7wSIZAY9Gno
         3uQShOyW3Zm37WCaZnwdtDk1cZ3yML9lsGhnCz0ZbJ5S7FdsKFfAeUKxhFfPTL3HY6hz
         cs/DIFYDgPeEpAHk7UmRm/50mM72nTwJQ+ceYVpgXw6Bb3BjZC+C9YTtkbl+Z+gx63Hz
         7hNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1794039087; x=1794643887; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mhkve0AREgIHZlQo7Mk2vGGc3A9EkMtvF/OVPHAgmwA=;
        b=i+BZEnQeLfpuxDV52EIGZHIqys/+bL20VEt/gQlf8jFl3tVdIjfxBnbW4Yz98IZC3X
         khkTl5z0XoW0v25+ivaKgtTIWS9Wj6EcHJJKE8Znm71tI7Ba9JXgz6b3rhJ4PJ0mCAkw
         +DT1GZzhLOpu9xarDzNFWNKHO1eRmQ1LX3aXdIbUIaqqpXB7dVsTDjnidjzHhw1aO+qp
         uJbV3LAbEmVTIAku1aquJe2IpjOF7js7fvbO4PzkBJLiz1D84rTkUfRSIaTjV0hBu+ck
         d2bPfhhnPDcegpKZVE32oynF4bAJyd04a4GxDxaQjrW67/urIOiozVNyfrPntZFfMw+9
         De/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794039087; x=1794643887;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mhkve0AREgIHZlQo7Mk2vGGc3A9EkMtvF/OVPHAgmwA=;
        b=vQ01Gr8PYWF3seZf3fN/ZAShIeZHLDTgTWGoz3X1LwNSvlxlrWuKCOqcqJZhPA1q/Y
         4e7/mJBX+7oQSGfnpFzr+xoBIGfZLP2zXb+QmNLgdSUHCeSA61Sl82FGJlUyZnygscwG
         LRLpq7dh3YB1+w0TdKVXJq6BOt0w/K/nAa7JBAGW7lrHMfPubryq7pMvbiAYf/TBkz10
         hLUU514eVIlS6ZIJ09g6AspJScd7FHpEQlg3/G/pUryCb+gABvS90bsOuxx4KRojXvU+
         xfn73BrASudHZtt8XiLPh022v0z/4FZ4FKPhfJqlnujHjXCQoiryGIr2oFZNe5GOoSq+
         g2Uw==
X-Forwarded-Encrypted: i=1; AL+hErGX8TgJOHeZHDGyC7vl0p0ud2Q+X8dx4HSIb+dnn3OfOAyg7IfGxuUMDmmQSYt0GBgSjeXB6v0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/B1GwHHdo31g2xChuE/pzoec66tQzNu69zjAT1ueMQNUqAIlWv
	RkDV4heIV+hPXjhqHwE6jN3BJ2Iw5dXR/FDt3pGUpdNQQq/zmpBgYiWh7ckOpsp9rQJVxa2QLhY
	MVMGWXsPfhaeDJKtmHg4i9OoapFzfxWy5dFHgJgscfw==
X-Gm-Gg: AYBFou3xsgvVX5qlMn7LwrzGCi6+Fbz5D3tN1B76CfjI9Wuy1+w30eEEEdp0Cy43qLH
	Q8BwSM6D6r0UnTqdVQAEE6rRUpa2VDVRs4d4+DKi19q4q3S8X+uWpPmRyCVx61JPd2jfulZFw38
	JosZbB/zI+X414GugHG2Sapdyt/uugLHlqMmyFOpE8JERoEt2kU3QMnP7UarJC8TmuOAavITvlY
	3kwlfUdBsr56FFv0UMo7SHcP9cM1/YC4cnO+xdGGYDF36u82PwAo7w8GDfMKxpIGY5HYmrWP3nN
	J+VVGiBvbUqN2zqAvSzeJJ83z4a4KovneZCbDdfqxxBHS/pw9ex4FZ1tvsEj7VJ2/4pTqy0uKmt
	vzXlatTrhYc1KUm9hJTr/oM+wr8JdWOulC8E=
X-Received: by 2002:a05:6402:2815:b0:6b3:f891:c2d4 with SMTP id
 4fb4d7f45d1cf-6b597806627mr3457069a12.29.1794039087024; Sat, 07 Nov 2026
 00:11:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101102720.702600-1-jure.rebernik@luxonis.com> <20261106131828.2844d23e@kernel.org>
In-Reply-To: <20261106131828.2844d23e@kernel.org>
From: Jure Rebernik <jure.rebernik@luxonis.com>
Date: Sat, 7 Nov 2026 09:11:16 +0100
X-Gm-Features: AclHuK9iN-4C02LmAAJuI1W1GyctSZGv-_z96k80CwTx7Gbtw0_eVmMh2EFhTYM
Message-ID: <CAD9jT+qH_XkV3vJV1OYGHqsQ0ThwK=HC+X1CCMv=kcojCx5zOA@mail.gmail.com>
Subject: Re: [PATCH net] r8169: enable the RxOverflow interrupt again
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
	Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 13:18:28 -0800 Jakub Kicinski wrote:
> Not really following the explanation, TBH.
> In general "ring empty" IRQs are discouraged because the host is likely
> overloaded, so having the NIC force the NAPI is not helpful. But sounds
> like you say there's some sort of a race?

Yes, sorry, the description was not clear. The interrupt is not there to
force NAPI. On the RTL8125B the receiver stays stopped after it runs out
of descriptors until RxOverflow is cleared in IntrStatus, even after
NAPI has emptied the ring. The sequence, as I understand it:

 1. The ring fills. The chip completes the last frames (RxOK), then sets
    RxOverflow and stops receiving.
 2. rtl8169_interrupt() read IntrStatus before RxOverflow was set, so it
    clears only RxOK.
 3. NAPI empties the ring and unmasks the interrupts.
 4. The stopped receiver raises no new RxOK, and RxOverflow is not an
    interrupt source, so nothing clears it. Reception stays stopped
    until a TX completion makes the handler clear all status bits.

What I measured is the stopped state (IntrMask 0x2f, IntrStatus 0x50,
NAPI idle, all descriptors owned by the NIC), and that writing only
RxOverflow to IntrStatus restarts reception with nothing transmitted.
The order of steps 1 and 2 is my inference.

So the fix only needs RxOverflow cleared once the ring is empty. I see
two ways, both tested on an RTL8125B with v7.2.6:

a) v1 with your suggestion, RxOverflow in the unconditional init of
   tp->irq_mask, so the handler clears it.

b) No "ring empty" interrupt. Clear RxOverflow in rtl8169_poll() right
   before unmasking:

        if (work_done < budget && napi_complete_done(napi, work_done)) {
                rtl_ack_events(tp, RxOverflow);
                rtl_irq_enable(tp);
        }

For each, a test build switched between the old and the new behaviour
on the same boot, in blocks of 5 to 10 runs of 30 s with UDP at
800 Mbit/s inbound, about 2.14 million datagrams per run. Totals over
all runs of each kind:

              runs that lost    datagrams     datagrams
              >1000 datagrams   sent, total   lost, total
   (a) old    5 of 76           162865429      411511 (0.25%)
       new    0 of 76           162861980         489 (0.0003%)
   (b) old    9 of 75           160722174     1041366 (0.65%)
       new    0 of 75           160721463         846 (0.0005%)

The small loss left with (a) and (b), 489 and 846 datagrams in total and
at most 61 and 184 in a single run, matches the NIC's rx_missed counter
over the same runs, 492 and 846. So the NIC dropped those frames, while
the RX ring was briefly full. I used the upstream ring size (256
entries) on purpose for these tests. Our tree also raises the ring to
1024 entries (not part of this patch), and with that and the v1 change
the same test lost no datagrams in 20 runs on two boards.

Which one would you prefer? I'll send v2 accordingly.

> LLMs point out that you're adding the same bit on both sides so just
> add it in the unconditional init of tp->irq_mask above

Agreed, v2 of (a) does that.

-- Jure Rebernik
