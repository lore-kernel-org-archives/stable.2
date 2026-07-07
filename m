Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E99630B50F
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435679; cv=none; b=Dg6NbuB5m4OwpGyeq98VFsVbXjpw2X+cux1vXGO8N3mcOTIoEduZ7JnA3OvOm+JL0emJS8MwBd3TcCMQtNRQtnDKBCkbm4EcrWjOmFgSR3Dg36aJSC4hWlzaM2ABqNfkS1wKKotPKY9NI7ptdIiWyNvD/hBZDoA7dyGgWjieRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435679; c=relaxed/simple;
	bh=+z+gxYFlPtHgHZIMkVwjSgyTxL0CHmGy1/FkcqoL/Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0oHZsOcfyYOer0QpGo6JIfGSDXqRVpriCr8/Flu27K/YFYcyH7Hv9mgVY4o93HGvLx9dNy278tTGPfMM5qwCxeG1vszy4juzBBxNSJ0lqsR8u+XYx2ANk8TT3fDYWg5w0aftbmDs0NnLDhWJjw/YlhLwdDZ7j1aaPtmDHaGECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSva5tMs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zi9Axg6n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSva5tMs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zi9Axg6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783435677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WrZMujM7glJ2AgSACwXIbeDVc0Wnvusn0xlE1OdCrOs=;
	b=LSva5tMswR4ANEDDCN7g32oxEYhns4uCkXpyNdxwfdCtouERlk+KnnVSBFU8DQRlF5i/W8
	U0v+ScJDxaRKbpzk2dXUqOfzCAax7Rn84kvzirVU9GMBGiZDvhpQ6F/TW5n/ncZY1zhDPP
	IrrHnzT688RtZl5aSKRg1Z6RiluU0po=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-pIVAVYD0N_qd_HxrVg-CEQ-1; Tue, 07 Jul 2026 10:47:56 -0400
X-MC-Unique: pIVAVYD0N_qd_HxrVg-CEQ-1
X-Mimecast-MFC-AGG-ID: pIVAVYD0N_qd_HxrVg-CEQ_1783435675
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6a344ad4390so1795023eaf.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783435675; x=1784040475; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WrZMujM7glJ2AgSACwXIbeDVc0Wnvusn0xlE1OdCrOs=;
        b=Zi9Axg6nM5qeDyZY06ChBoJhNu3obf72iuJStftMMbn+SZdzQiWKZ8yFt8RC1OCqi7
         h6jPI+iepiCOMforykMW9fQIK7U2awRev2PsnJKyEO0yG1+FEEklHYYK+/KZtJip/wOb
         IDvJaDgNWNbW+gwOGlUaxAFOFiyCudmMaFXpVXgJJfUVmcXzQ336yBQ8NvhEnvjhBN4C
         BRN/5YIs605n4MHTRc0dWNsMzQOfXIC3nbwaPRK4I374gs/EtcxHdbWB145F0yV9BprR
         DAICHl5/FJGiX/YN/mW+rhSxGlQyxDxGhnps1mpDetHRMOFkIV1sktqTxsJM1/J//Yhg
         g2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435675; x=1784040475;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WrZMujM7glJ2AgSACwXIbeDVc0Wnvusn0xlE1OdCrOs=;
        b=QHyFeluGyiaiP/2SGyIglWs0g+Ea7AlaQagEwQyhse7UB/0HLVH6Mnhp0BCFBubnlT
         MvWB7nvcgEVNNBfhcxkYr19YCDR97gkjrXGMYupUh6exTmrall4UZtt/M3wPjp96ZYiH
         vp0whA6fbhsNAljqstLzjadkSvsuprW24dqKP1K0oPrYyOAduc/sDJyMyD57fv2iySER
         rF3rr5+OtI1nUjaCRrW58WEm4Dd5Ctl58Er84B83FaamK+KQYI0CNB7Eu/AyRJSSFu9e
         wGaWPK9fj7LEhvI0viZ1+1fLrzZeVhmdm7yG+QFopYuEU+HQRih9JnYCI9xXM8icpb6Y
         yuUw==
X-Forwarded-Encrypted: i=1; AFNElJ8SEGqmooMWgVMhUwCayqn6V/NINxQuueC1YfbPiFPsuERA3AmCXcRHhVjtP+bnonkL4k7caCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/6F1hnvFwv4/OM+VlEvopoPqMY6UPbcEt4lrzb3MwSvhHbvU
	9lDRaQs4L24e7vj0Xy+RVD9YfOCvOzp0w6TFFhNfY2xI1oFS6ur1nr4cNZvtMAdIHLyP38DQCoq
	aixfC1/Yib0knK8FyhFLvvqo+XIwaAdIS7p5aimZcqNdUYQq8bAgMGgzINg==
X-Gm-Gg: AfdE7cmNaB0Ha8zmZekml1Ky76hVfn0kZviIzS+1Bry0bAtSo3uPAA9P1O8lIMNc+VZ
	E4uh8VV8/CqFx8NrS1eoz8pV18VPDS6iSfh/j6MEAgq9sS/ALtH6gpRHyDej6A0RMvfkBhgV7eZ
	uwgQnrFktMn2Hisvis2aB3pB93zJMqZnbwQdbhyqRIm4yH/iIGm9ski1R8d/mm3YmNNFS+TqE5X
	AB5cHru1On7MuxfxwuYtjL69AolHTJc/SzzmQHoikOHHpN5yJjenjc/3tb99T53TioDdVqQtELR
	8IZnhhBqPa/FJPY57gORxk+i70wd0ivCKScvy8QKNU7ZU/LMpWoQCGJNZDKz2zKUXStlIndwy43
	YizPWYXE6
X-Received: by 2002:a05:6820:818b:b0:6a1:87cb:c34e with SMTP id 006d021491bc7-6a3555125fdmr3682675eaf.72.1783435674706;
        Tue, 07 Jul 2026 07:47:54 -0700 (PDT)
X-Received: by 2002:a05:6820:818b:b0:6a1:87cb:c34e with SMTP id 006d021491bc7-6a3555125fdmr3682515eaf.72.1783435669460;
        Tue, 07 Jul 2026 07:47:49 -0700 (PDT)
Received: from redhat.com ([2600:382:850a:55b4:731e:b0d4:e0cc:410])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a30ff8e0a0sm11018754eaf.3.2026.07.07.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:47:48 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:47:44 -0400
From: Brian Masney <bmasney@redhat.com>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	stable@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH v2 3/6] clk: mediatek: mt7622: fix memory leak on module
 removal
Message-ID: <ak0RkDJr1FO0BCoV@redhat.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
 <20260707074839.240676-4-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707074839.240676-4-akkun11.open@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Tue, Jul 07, 2026 at 04:48:32PM +0900, Akari Tsuyukusa wrote:
> clk-mt7622-apmixedsys.c and clk-mt7622-infracfg.c do not call
> platform_set_drvdata() during their driver probe callback,
> but their remove callback calls platform_get_drvdata().
> This results in platform_get_drvdata() returning NULL,
> which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
> This leaves clk_data unreleased, causing a memory leak.
> 
> Fix this by calling platform_set_drvdata() during probe.
> 
> Fixes: c50e2ea6507b ("clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build")
> Fixes: 838b86331c5e ("clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

