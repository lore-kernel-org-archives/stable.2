Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84501331EDD
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788016528; cv=none; b=PgPOuL1vYFmSGk0LpQDMkceMDur5DSUz2WLTfRvAZMi8/84PC1SRBUhW/aHNvt3Vf/VqH923MZzRIgbKkXdq5W6SGhMQf/nRkWTmk1l3yNbfYfZQPIut6+3RWrikoTehzUU0rPYywvAuTSBwHSy4YtSdlXdqZZr0s73O7k6ERuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788016528; c=relaxed/simple;
	bh=2g1jcR6uSj/fLbQ1ZfTuZpbVq4hnSBK93DtZe1wTTjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFlLxxFmd3fefrcnNLG4UhmpS6zzxJgaBGBbPGmHxxBsnImxRfw1zgTB0u+lMCeHLi5KJeq+stfOrDfCz+qfViJnBlHXx4kxQgVTqJpT5cD4spEsBTutV0pFEFjBOLA0wktLRsOFe3NEfi3jLw+KC7KxPBEplSuTLJVaa9o7cak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=b+kY+nOf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="b+kY+nOf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1979245a91.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788016526; x=1788621326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tTPBv+P5dDJ4eNQ72046GHeSjyxFhgiVslksovlmkwc=;
        b=b+kY+nOfElOO/fWTPDDuN7H+JailJNLDawMA5VRAlY6rFZpJOWLLpAY0+0eq0rAacm
         ASf3fEx/sBnde/+uI9sS+xS/PVwqlWBRzb/lY5jxZx4yyvGWu++f1HM7OYq9Dd7cbxHV
         Rg5yEZfK9VkRqwjktqWvXgJ1qaH8ixHvf+8K6kN7bCY60ck8UQWLUxRSy9ierlSd8aiU
         ltrmTmzSqf6gXtzPwGBTfEAQlwdJ5Fi7+WS8mM+WvRcIYWt98FbXhU5viD/SJTnARLMo
         AtmUbbJPKGrtfn+KmmRrIu0Zb7QVRzvvoKOtq1K+zQMj8piPqIvcckSnbCaHgOeoci4O
         WTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788016526; x=1788621326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tTPBv+P5dDJ4eNQ72046GHeSjyxFhgiVslksovlmkwc=;
        b=h4DHtpy+8YbzClg1V+SKr8Kx2ykhRxY58hthYyWLJF5Ffp4CxwUXbti8xvgxb2BmJ6
         N2UFDGNhmtdnmXx4/IQRpyTaNHh3lQLmQRzaXr+sJJWnMazokegJ9Wm1J5EKbGufHdtc
         6pAN4+JsAookGwD9cbqRgycgBhJ1JBxVoysyXpSUWyZNfTJqf8q57q6AhS34HDCYM81M
         w+G1YYg+2spdPpg+3MXyX1fiWjmF+vTxyYPhwk/PI6BWgv8A5EXyLjCGUxM7ERvbtDS3
         Uq2A0NWj4qEQSnxTOf9a7FlXtnTnQbU5b03Hg6SzmKVTGYibpnsn79bE+Dqz87UJBGlV
         50UQ==
X-Forwarded-Encrypted: i=1; AKwUvBxigWNs9K6DKrfSHJZ6cDicD/trnWegsGs4Sjt6V6j0m62CCrUmQgwsZGo3ZXRJjwPLYwoKYMY=@vger.kernel.org
X-Gm-Message-State: AFuF++ndPPCGjnSeJnHe/KH37gAG3jqirpmyraWXUJ2isczlqiiKD09J
	WUm9A0po1gZWOM6V+RY5YBbEyZ4dFmFvmgPMXnwrnSLd3CwAHZ9Ua2qE5AzIkhSO6aI=
X-Gm-Gg: AYBFou3PAaGQZOBCzIhLHQ3yO0E/R5PTgszwL+lpccCPJjyToysVTvd65w9TeV+UAiJ
	o0WEbTMY4O4bqEYk36uvwE5ONs9Efc4AZgU+nyVIqXhiLUcLoc5aVU0Tb4qNrBuzYLTEuDeIqy5
	xnARC0unPKORo8E9dBTDuHS+uYWZ20RbsXnx59I0Mr/ly4zSJJnUoKQZ+X55fCVuUhHARw6YRpo
	idK8/mmlfRYD9LW/o+hCKGuzaA2HzedZRVqy2uo586dHdsJZY+eJeOmTh+bahXMazQv7RyIBscz
	qcx/PDMebzoAqKkOCl/kivA+IvnWmSq+Qf8YD17zuL+CYBPm31LZTVeN3cS3jLZx9toYbSziS3g
	3XgRbjsCcjo6BvC70I4rT5AUzsY6gSSNJm145YbW5FT770jx4zBl1vs0AaQoRgi0vVIpb28wJ/s
	uZmlTvwbz67K9lnDnGiREaA+Tz+n82R8KbUzPaP6h2+w==
X-Received: by 2002:a17:90b:5443:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-396d0d4cf4emr24828890a91.1.1788016525770;
        Sat, 29 Aug 2026 08:15:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc58f3dsm7464280a91.16.2026.08.29.08.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 08:15:25 -0700 (PDT)
Date: Sat, 29 Aug 2026 08:15:24 -0700
From: Joe Damato <joe@dama.to>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] bnxt_en: Prevent queue stop with deferred completions
Message-ID: <apL3jDnQuMfifkj6@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20260827230233.94878-1-joe@dama.to>
 <CALs4sv1v7E_pxmdcNzxf8GyR7=-B26J5Z1YZ7fc4Y2Oc7Le8yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALs4sv1v7E_pxmdcNzxf8GyR7=-B26J5Z1YZ7fc4Y2Oc7Le8yg@mail.gmail.com>

On Sat, Aug 29, 2026 at 02:57:59PM +0530, Pavan Chebbi wrote:
> >         if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
> >                 netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
> >                                    bp->tx_wake_thresh);
> > -               return NETDEV_TX_BUSY;
> > +               goto tx_busy;
> >         }
> >
> >         /* BD backpressure alone cannot prevent overwriting in-flight
> > @@ -77,7 +77,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
> >          */
> >         if (!netif_txq_maybe_stop(txq, bnxt_inline_avail(txr),
> >                                   num_segs, num_segs))
> > -               return NETDEV_TX_BUSY;
> > +               goto tx_busy;
> >
> >         if (unlikely(tso_dma_map_init(&map, &pdev->dev, skb, hdr_len)))
> >                 goto drop;
> > @@ -235,4 +235,17 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
> >         dev_kfree_skb_any(skb);
> >         dev_core_stats_tx_dropped_inc(bp->dev);
> >         return NETDEV_TX_OK;
> > +
> > +tx_busy:
> > +       if (txr->kick_pending) {
> > +               u16 kick_prod = txr->kick_prod;
> > +               struct tx_bd *txbd0;
> > +
> > +               txbd0 = &txr->tx_desc_ring[TX_RING(bp, kick_prod)]
> > +                                         [TX_IDX(kick_prod)];
> > +               txbd0->tx_bd_len_flags_type &=
> > +                       cpu_to_le32(~TX_BD_FLAGS_NO_CMPL);
> 
> Should we not do a bnxt_txr_db_kick() also? It maybe a good idea to do
> it in success case also instead of bnxt_db_write..

When this function returns, the caller writes the doorbell, so we should be
good. 
