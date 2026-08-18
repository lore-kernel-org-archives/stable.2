Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B62DC331
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093689; cv=none; b=C8xuMi0wvBxU/bu8nuGTHBW3O6Hld5vlyBkjGXwMfHvbzn2KHRRaGaDHY/LcAxNmOEwetAJ69n8xj2s8zxjnSYMr1qPX0H+tehKemWN8VGb552+JNB0k1oC3ryUZub93gBIRuixjgXX2HXbkTKl8fRcyTV9qL2qpuewb7NeyqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093689; c=relaxed/simple;
	bh=6btL7nZ0S1u/4+3eC7ZeMGV5W3QJ8MpeIZr6Im2drno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELKf3nhEvFsTFlcoN4+e/5H1Kt976keeq07pCf6yvQiAVqtQyKsdnkoa/uFNz1JAtAPea6uV61aGj8sQY1Mqpur9LNEymtW4BhQZrFHh67DyVdQzKiUpAsuF+dP63VgD1MWSBrQRuyPn+O8TscpTpzk5omacFb63OkTAIo7RwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=mspdUP8d; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="mspdUP8d"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca12086c06eso255494a12.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787093688; x=1787698488; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gz2RTF0eU9/58HpSEWg5xF4pRvWmWGVnJVKoAZtXolU=;
        b=mspdUP8dZc83P9DZiYQ7upxxaZdVnc+P5O+l5UCWTaEELuOuMQzI1CTG3sNrjZCiYr
         W5TwWA2/UT5a/fusKi7s+9X5MYiG6/avhCq10bsBMqjhxD1oggxx1tXyxtNdNAhC0QKE
         lKw/WhIGCGYXXMrlHdJ4UTkWG2G8YGZ84ANw2qc8SFwj/s72EVyi1hQio+cXlnKecp0u
         JjL2knFzEwI6Xr5uRRM616wg9e4i9r9HaHyadA4Okt8P4MDomTrSA6zzoTB1pSUf9kpQ
         Zvp1IvkkwvVeZusut031Ign0Vd8p+JwXqRxGBoCcRLVZ3DCCCL00GTiXAlh03bkNjE4C
         5voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787093688; x=1787698488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gz2RTF0eU9/58HpSEWg5xF4pRvWmWGVnJVKoAZtXolU=;
        b=qEm0M5/jMreG+rtItp0RcV4F4F0HKIlEw8cV2FB4XpNoFR2GfXiB1hrnI8VwGVN2j8
         7iRPtCzzza1CztvNRqTa5Jve0naJTI6n2i3/O6HJYEK+8h8yrRmL7TAGmJyO/vj281Sy
         3RdmHI7p7Vi2Hoh6mwjA1UHEoU03js9NT3p/I5hWGtCu4mcZIzsHs0LXIr+m6co06Wl6
         4o/OyoFDofJ7QOGAY4QKrcMfdjxL4yWkv0KiP9T5x9pibeAt27D6mHr/JKi/sRL8m6+U
         6UMAGZliZbQ2ex7HT87euTxMiC2vvgiqeg1iRTsf9LpHwIqoFg0LPciBBJ389wYvL/Uj
         Maxw==
X-Forwarded-Encrypted: i=1; AHgh+Rqw9+pIz6HQQ9rCilWoP9nxTbFPMFayxEN1mI+E9W6hYSllJGMtPYR+VdOvdh08FmbgxlijUKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyL9MKjxSMniit4TODcVEVHfHMkyOhnr3Y0QEsFGdaHgrjj0/i
	d0TIKZcQHEyxeqC7zV9EahZf5S3VjJRsYDEtuD6ds5up7diwlVh8uRhHFeTJu4gitfo=
X-Gm-Gg: AR+sD13OH1eTBCK5NEQ1icAgD2QMB8SsttIQ4mD/uYHPKzu+2c9Scc+/YSlE7YcpATu
	NxWggFzaj64CgBwVoH04QPHYit6bQbxEZdMofXLk0yLuHthPg/ZSiY1EcRw1FAPFB1i4NKUIMHK
	AxyDmYUB40R5ku9kAkKAw5bwytEy3zfkIpcfYUgKILw7wG/knNyYoIdBM5lhTJOc4RQ4S9i0btd
	l85HyCcQm5eXSAWz/xbrNGYYNYWdYTfjmeH3I6e18ha7O4i/qhfv1QbrjMuVMlvFFQQkPhJU5XK
	OTWA9Ie+LOHNAJ3iLKWJGxUrWUWZI85f4pjkD6BaCvhpR6M0LIEEdLgTgKsvoroFilYjQh8qqmq
	cY4ACJcoVs9kH8dj2C5wYWMMeOAyeQJ/skONoWkzqUamPg/vT93igrdKoJuIfqpAbNnPcAwbhQl
	n46gEabr1sDaybSmLtERdTgfXNPbBv7xEQK0m9uFTx8A==
X-Received: by 2002:a17:90b:2241:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-39581228dbdmr396372a91.16.1787093687536;
        Tue, 18 Aug 2026 15:54:47 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fbbe817sm102834a91.2.2026.08.18.15.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:54:46 -0700 (PDT)
Date: Tue, 18 Aug 2026 15:54:46 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: bnxt: ring the doorbell when SW USO exits early
Message-ID: <aoTittBOp+bv1aTz@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20260818211540.2991183-1-joe@dama.to>
 <CACKFLikEOu--B+q88X0pQsHQ0MuLM2onJKWnGGetSptgEpLrsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikEOu--B+q88X0pQsHQ0MuLM2onJKWnGGetSptgEpLrsw@mail.gmail.com>

On Tue, Aug 18, 2026 at 03:36:42PM -0700, Michael Chan wrote:
> On Tue, Aug 18, 2026 at 2:15 PM Joe Damato <joe@dama.to> wrote:

[...]

> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > index f317f60414e8..3c58b1d94ac9 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > @@ -223,9 +223,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
> >         netdev_tx_sent_queue(txq, skb->len);
> >
> >         WRITE_ONCE(txr->tx_prod, prod);
> > -       /* Sync BDs before doorbell */
> > -       wmb();
> > -       bnxt_db_write(bp, &txr->tx_db, prod);
> > +       bnxt_txr_db_kick(bp, txr, prod);
> 
> The patch looks good to me.  But a slightly simpler approach is to
> just set txr->kick_pending here.  Upon return, the new logic above
> will always ring the doorbell for the success case.  By doing this, we
> don't need to export bnxt_txr_db_kick().

Ah, right. Sorry I missed that; I was rushing too quickly to get this
out :)

I'll send a v2 tomorrow that simplfies the patch as you suggested. Thanks.
