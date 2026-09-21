Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE874B488E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004212; cv=pass; b=lyK4irCQn2GeiQSUWzOojI14H66rsxZ8Lg03lhuVgEVhkIXq76SFs4ajrbekxh5EMazwF9tFr79qxzYHompHniaWBoJRqzEzyTgRljIgtZjaD+NlCmEXfBV3G57Xrr8Ow1dAecOI3OGu4SD1ArWuf7/b0oDyaUfqBwGT9cAgKuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004212; c=relaxed/simple;
	bh=Qvro5yCQlNCOhITq/IgfziBeqn/uBwkhHPkGycI5TvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1Ix7rpkcFrW4/3E1OVKyXGfB70xwgq84USubEqhvsRpA12kmdHki0QRRwJWQbyiRT1diBKGRSnr1r8o27aX4abyFK3XmR1LHBvmcat/kBlJO2GdhztF1A4gXV0Ur267Vi3YABB8W1WTi5DqssLhhJwoeCULvLe4e2Q1d1OuBAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMIjwpvC; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMIjwpvC"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso3070776a91.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790004210; cv=none;
        d=google.com; s=arc-20260327;
        b=YaNX4jo06KswOBK482U7VtA8Jo1xF3QV2BTvv6zfdsugTrufJdCfdnggaHdAxZp1s/
         eKp39+QTSkNfgzmCVqoJrSwDBxM+Xq3YN0YYRKklDvHbJcwAX9XLF8DepeaJSS8NOPF7
         vWACrwMC5yVx8Mu31NSH3TMe/yvO5CqAYI6KGvX0BiK4K1QB9YILEfTj6+bhRRbPeNKv
         H5gs0iLBrpdYu9BKbtkrXP52JhEHaTnKJZR5npL2bomq0qzNQpvlOENUUzvYbcA1wOnB
         ttTNiNFK0BpGaxQPQ9PvKB9p7tGyYFL5N/4iaImKH9OUlpFdtoQ/B79riKD/JSGh/vhy
         Rv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=INq7XmDF4W6s4uqXjWWhutx+bhm3j3Ixyq53lQ+50kg=;
        fh=pvk47kJ0Z39TxREUDGxWuZ2hSvU7+cbh9gro835LK3w=;
        b=pYPtGC8erzTHd+Z3Wv0LiUGeUaXys2w0Nr/2jTuBiS9S6upMH2JOXwi2laetv0l0PG
         J39qg06y8RK8ug0dVDJ84s1gTMxfv/NgBZdhHAnBs8ynsfh8JxAtjF1nRLSxVpS8qRFB
         AOwhRhrU9jy15C/lP7l7l0TGa77f3CNMx2PrJsOaIygUVgEzOFIgDQA/vjqVw9c9XfJL
         a5f/SKZ/YM9n7UZmMHX0oOOMoO90y86psL7I+paW5AoCAWoOCn1RGLeCbD77RX7OZNSu
         TxI1K5igaw6rFfTQ4bmRowyhJLxzDWayel8hTTtioIYjr2paXmy74U62IacW/gk7d6uD
         mBFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004210; x=1790609010; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INq7XmDF4W6s4uqXjWWhutx+bhm3j3Ixyq53lQ+50kg=;
        b=RMIjwpvCSnEId6iLqqzpVweOuPEhmX1L+Tyr4Zz8O4OoKvZsfMUg9mCUiJbpa+uXBj
         N+gFFQ2TQIjV5LoHWXs+7fstuuvcCxCLBXFh7cnKrt5NfNsv3Ha4Fb8l5Id0PvqH/J4m
         ch761hTNk4r/QmVt+ht2v+JxUB3/GQftp52qqqMJnV+GyREll5VMIF+AMySfJuKaofbv
         NXQxD4VkvwCtzzUwCQoB0+In7Rhl8vJv9wKf85Lqash/c+SotgbIHx7KFaiIP9Ph8Jxv
         FrBPPYYNgsc4bVkj1pbGWtk2LzBoBd0B6xlMISvgZoq9NMcnR+FeTEbcHs6AG1rQROBv
         TXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004210; x=1790609010;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=INq7XmDF4W6s4uqXjWWhutx+bhm3j3Ixyq53lQ+50kg=;
        b=mlHX/bSwubvxFngsVpT11HkYg+ScTaMgHahcliLMnyI+2Q0grWPH85Nz18vcHmAPIi
         D5XQ+CdzlDz2TBXWUWeQcsVGnIwuw/Pt+47gAb2hEoDVN4uOjrpF/SrjY/GRt+Li2fSo
         SiEPUQmzUp9Bm5MEzZ5RqR+3AbBH2zMyCZoFOlH75h4SnkruRkM8A431iUyggPKoCHCj
         aXlzYN+xJs9pc7D5MhNORRt0wUPAyLpmiAcwqVIDQcMoIBWrqZ8Boa1uaaKEHF8ha8tZ
         Hq3rxilnyt4o01sYv/68HzDjW3xoC4fFTfoQBz0Bn4rHCMq1mfXZEbc4CasCx8Xd9C8d
         SGjA==
X-Forwarded-Encrypted: i=1; AKwUvBwrQteqaLfDUzUITKUTXdXcwIeSpz7NLlDhrpjMQWeCPndcVyNLKy22UPJiF1kKuPJFGOLtW90=@vger.kernel.org
X-Gm-Message-State: AFuF++nwad44b83nfmVWdePiZIgbdOyT3kw3GsBN4a/E37z7a/r4ZApP
	2J+CAecSm7xnHBrCZH2tOnYdXRMnbZXTQRASb1Q2K+yzqC+YGeWP+/r/G98EINsndV4TXsDhYKO
	/3O8zInitszAbOwi60pXib0FgtAq3Qqk=
X-Gm-Gg: AYBFou2oOyj3/LmMUAbo6DXPBz0QbGnyyNpCiT7CO7TBj5VlZ5n990lHqVAXhLpuaLt
	6xpg0x4WhGhjRJgk9ErY6Tyg2mPFdw7YzJsAKLu/yvupRurKTiklGhrIEuCR8A1m5i/Wsttgm2Q
	AR6QYESykYgWXnzPkO0Cby21DMg+M7UiJN75rckh8EYNTevjVDynu6MVmO1LM+3K3R5XRiuL7Vs
	by7Au3NdZYNUVtvqwyNxKJjFAiC+zbP6fJDIRTNv4aopQvIPWHa68dHtqt5J+2Q+iS9IUGRHBFI
	rUUrSKvMWPUv+dQHvmn2wI1YaVbnrHZUD/iSdGk3Je5+FBA7fiMcoZ9C+A==
X-Received: by 2002:a17:90a:d445:b0:3a0:2817:1fcf with SMTP id
 98e67ed59e1d1-3a0281720f7mr8496428a91.11.1790004210586; Mon, 21 Sep 2026
 08:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916022954.2690322-1-lgs201920130244@gmail.com> <178953744017.13037.8123570146284827976.b4-review@b4>
In-Reply-To: <178953744017.13037.8123570146284827976.b4-review@b4>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 23:23:16 +0800
X-Gm-Features: AcwNN1VTUBM-S9HR0eeeidh2kablCG-BVFJX7Z6YN2-YKoW6ujal7wVJmjF5B58
Message-ID: <CANUHTR_pjrYXHkMZH_QheAUr86=dJ4WFC+DNMgzUYsm+MsEXPg@mail.gmail.com>
Subject: Re: [PATCH] net: ena: fix PHC cleanup on probe failure
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: David Arinzon <darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sang-Heon Jeon <ekffu200098@gmail.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Dawei Feng <dawei.feng@seu.edu.cn>, Amit Bernstein <amitbern@amazon.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arthur,

Thanks for the review.

On Wed, 16 Sept 2026 at 13:44, Arthur Kiyanovski <akiyano@amazon.com> wrote:
>
> On Wed, 16 Sep 2026 10:29:54 +0800, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > index ea89619039d8..5f0864d16dd3 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > @@ -4122,6 +4122,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  err_device_destroy:
> >       ena_com_delete_host_info(ena_dev);
> >       ena_com_admin_destroy(ena_dev);
> > +     ena_phc_destroy(adapter);
> >  ena_devlink_destroy:
> >       ena_devlink_free(devlink);
> >  err_metrics_destroy:
>
> Thank you for the patch.
> It looks correct.
>
> Please resend this together with "net: ena: fix MMIO read buffer leak on
> probe failure" as one two-patch series - both insert a line into the same
> hunk, so they conflict with each other.
>
> --
> Arthur Kiyanovski <akiyano@amazon.com>

Sure, I'll resend both fixes as a two-patch series, with the PHC cleanup
as 1/2 and the MMIO read buffer cleanup as 2/2.

Thanks,
Guangshuo
