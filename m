Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755457;
	b=pOqv06xbX1HLiBPPU8gMU8mDVfNv+2poJEvyQMEfKhUEJ8qmq3aMQ4tDkP3q0Nwyxu+V
	 8EPzbIq3/3GpW90kDq0pIx9oD+BK3SN7X3UnUR45+uAd7mWHd8uQeAMtuAObCU8MflJ5E
	 L8p+Nt4GCSQqE2ugc1D4i1D8iCRWQJ3Hc8l8QQIEInWJJPaaAm5KOTm6SeB2J1ZV+HDVD
	 9avMb0AFfYnnKbv5FwtmjuqhefHFDRPf5KJ2pSfT6xgvMCJ0yN+j6sNjQ/QvGRwHSq1Px
	 GrjiwkOBh2TuMbddXLN4s2Tb/K/Q3M/lAIM+hkWcTIOE55yjDpBSy4m+ifTKoIjT/HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=XU8v5l3j1NJaqJxqv+9h3ZaBWo1SvrTb91gs/U4dLXE=;
	b=0W/M9Fx+nCjK6t1cYGvhSCjOFF5Y7m7Z+XaAcvM7Ii3vHExW3F1/huMZ+gt8YdMyezXo
	 wKKAXBI7zYjvsu63opNr5/gAo5eHfT8V1gVatQUXr6dlww4jiff6GFn7yBOsnm/VgZPAp
	 WnIiaWr7gxEVFZqK71qG9IBaQLuZterCJ3gklhfNh9Xwfw5sy+XXsWyuskn/DHznAjj17
	 N/ml7paghbhUcOFEJn/KW8iedR1ZpmdmjDciilFdJSqyKAQc7P+3LZOgS1IWDys+ebIVI
	 kduU5dsA1GeeKPaZOHB6h0F8rtUsuFsTMU2UQEOa4WRUDT0tfxSVGklN6lr32YFhrVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=waAzsuNI;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18B606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 01:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB18B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=waAzsuNI
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35829219da8so1449981eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 17:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755456; x=1794360256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XU8v5l3j1NJaqJxqv+9h3ZaBWo1SvrTb91gs/U4dLXE=;
        b=waAzsuNIow2jqOdqdB7euB21RrbldHH85o2R1JoeadLJjWkhIdBgr2T3S0zCyYh4q9
         a+WKgiuJavwofUwI0WvHi9B+q8oLHpL1XmYsJFxXUrwbKC2emI46itAKD5wma1Rf+rbQ
         dYNjrUvjb8y4UIdUuxn3q8B4cfoNAnonCAZgPG7FJ8Bk26biQcSKNQ7lQt9V1JoyZpNU
         +OJHQYhnh0ORNvGca7doJCPdddBk9WZqdEYyvgF5rXHU/MAuJaBDUi6lTczXlek/bxHO
         AS3LboUF73MSBysnsrrSkZ6FjSvCevLi8ODTOuAwTh3lyNAJqegbzBCFv/aE81Y3Zau9
         vgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755456; x=1794360256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XU8v5l3j1NJaqJxqv+9h3ZaBWo1SvrTb91gs/U4dLXE=;
        b=e0csXHFVMP55xNNa9SohmgGhpqIFQBrluObWz4UZob/tfvChxtuXppp4EqRMxDUQ0A
         FhPz7mj1FrEz1gGuW/krlCi9GIsWdfWFXv6RQf5INNkMXi3GGuLD2+TGp+mddNQQCYxG
         02mzpqJ2LJvIenY+3I8b/BQ1XspWRfNfEo5YT6kahT/atUPFW+NqeWN9wYdA30j33MQO
         2Hf5019ysvkxCcS/y6GtqJ4iRhHAW9skh/CK2BJF4PrLjPFCh9cJ1HtM0M1qoYckodM4
         NHfwCt5vYBruxyz4hgIEVeIausHtyZVHNeEpWnhrPBm/KUyz7/kVEI8RQ7zlFxA/uf2E
         YWkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEh8RCWY99hGzdQWbKNnfAPqutQh4QTNElF8iq1GYoudjCe9nyEO1+1h0kqeYNuZ+79UfL1uY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/87mPO04IQTTFx12eQwyP8cdLzZ2E80jX3Lv8VuX9P0j2+5Bt9
	P5a9PAElLPHDfcuMaallQOcBUxU1Uu5c+SKBrItJV/mD6I6zqm7dBEiy
X-Gm-Gg: AYBFou30f/oVnSE+O8pWxaGc4M/E+XvLI/7oJgwNAUUAy92N8Vjo3yn/c1o6TonsxgH
	CeeowHwOei2IORpQXrUeIwuGJn/bz8X1tF78C0nSBAPCv0fK4XWXb6IlSJbhwCfNcNBJK41AVdQ
	aBbn4GqGxoofKoA3GB1BuK3wYbA7BIIQVkObzhelvwCS//PRn1dPb5a3LT0Z0fPOaXDfFDKDa/i
	yJwPnVobBu3sBE36e4IveIvxp4nLuM9DpUbDy/aut+LbRH4ethMCdCU/I9YcbldFQKFex+uMZhw
	K3I5JJq8RK3AhC5ONUMtKJSzj5fCUxt5kHLS9LOHg7MT2B9+7A4tFLHXuv6cBAEUWSVeiNaRBc1
	d+A7f5S1AgVH5lz10M3EjTqNHdkYGbT3xOMnJZ16/9+kQRDaAx/jPK7JASHtIj8AAp95/I4Ylg6
	HShAiRqJlLthaGy++65KNtBIQP4fm9+OHnL496nZ6n0EFN0nfj3ofF6rppGvZW7LFkDBKzqbn2h
	mvDDoVfAjL3ecE584G9uAA9F+QGfG/cHiHHCZ9wv0cyb+JoUivjq63fPryv7VxM41O3dDictqcL
	tKN+JTJ3y3wnrl8ye4GQc586iVgUTIGvCK/hag7xl0CnaWc=
X-Received: by 2002:a05:693c:41ce:20b0:359:27e6:b684 with SMTP id 5a478bee46e88-36a2fd486a2mr25765748eec.3.1793755455764;
        Tue, 03 Nov 2026 17:24:15 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a54ccsm2373254eec.4.2026.11.03.17.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:14 -0800 (PST)
Date: Wed, 4 Nov 2026 10:24:10 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
	sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
Message-ID: <auqJOj7RVCWn7Ucl@v4bel>
References: <20261029214219.1035176-1-imv4bel@gmail.com>
 <20261029214219.1035176-3-imv4bel@gmail.com>
 <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>

On Tue, Nov 03, 2026 at 03:49:40PM +0100, Eric Dumazet wrote:
> Le jeu. 29 oct. 2026 à 22:42, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> >
> > Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > of refcount_t"), default builds implemented refcount_inc_not_zero() using
> > atomic_add_unless(), which provided full memory ordering on success. The
> > commit removed that ordering on weakly ordered architectures, allowing
> > accesses after a successful reference acquisition to be reordered before
> > it.
> >
> > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> > lookups and in inet_twsk_purge(), where the socket is validated again
> > after taking a reference.
> >
> > bpf_sk_assign() can receive a socket pointer obtained through BTF
> > without a reference. Use acquire ordering when it takes its own reference
> > for a refcounted socket.
> >
> > Use refcount_set_release() when setting refcounts in the SYN cookie,
> > TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
> > TIME_WAIT smp_wmb(), which separately orders the refcount store before
> > ehash publication.
> >
> > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> > Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> 
> Lack of links to prior versions is rather annoying.

Is the cover letter alone insufficient?

Should the changelog be in each patch?
