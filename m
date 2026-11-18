Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014332;
	b=WSDRHCOnn+4cv/Ro43YRjf7N70rJpCBlyTfeqbzDb5bP9XIpVhKjXED+YaZ/VYg4MPfa
	 d/lF+itjoqk2tiiFGESrLyfkj6rtS0nBZ6ebTtcH4Thd2lxUPWo8il6j7eUNMGNrigiQ7
	 aukkCV1yZ7fcMVKMwOc2ewxJcUD3OhxvIwdNIJCUQvCYsNe4WgKvcOSXXgoWKNIkE4Ahn
	 p9D140wtISsvH2UHtwtpVlW8O6mWPBtDHEpe9JwBDDgW5gJn8Hhe5ED+IrMC89wK8KqNZ
	 AaAQiKjQz5cS/27v5+5TeMmyAK8fVOTJiMt8G+U3XYNvvJnOI506GjheiHrjQ3cYnqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uHGZ+xOdJx3Zm8UTHiozAvdnroVoplilsdHtzudcbVI=;
	b=I+uPRrIzbSE/z3tejS5yg+x2wwFwKaLnVDbuUV+GnNDAh3CiNTpwJn8b/CQ+8T2hnA/V
	 yjPujRmGdn9rwvKgAISF2t19v5fz+xT5VevrzzUSDSh9+6sFfBHGCv9h48lf+U45QvtZf
	 sPJmcLTroaGutwjCkhkSb/j310hv7ikBXuQGHBsRgg99tyZYi8Uc9H+adl2nK7Sy6BdVm
	 fCISwBblYCTX53qVyLP9Uhy7HxOOfC63aUSdNp7qphqBPnlrK4AD0lJnbAQ1tcAztpRuo
	 yBitFmS/HH9mgx1npaOX4J7OFIGil/GmNdB9HINGiZHmIIGlwKkdRzCtPYNtGXU+SbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QXFVnjhG;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE52606A333
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEE52606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QXFVnjhG
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2efe591a1f6so5052435ad.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1795014331; x=1795619131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uHGZ+xOdJx3Zm8UTHiozAvdnroVoplilsdHtzudcbVI=;
        b=QXFVnjhGcWNcZVxAiqFpRMw2oMh2dieUZe7T/JOKGprkANq54ojUus6S8PyO67nOy9
         7UlTC39NR3W/6RA7E9c2wfG0J/51zw50s+bzNZQTCmKm6ZUmT/NgA+NdNMD2Ic1hJYi5
         0OlR6ykWIKzo5LTIh1NF+fqBL3e7M4NH30jvRTIhNCcBtmGbxmBLqqXFjFvyhLvrTw3s
         NeR7MtbWNK/lNqEVwgeZpoy/YIKH9C2rBf2lZ6NfRkjJbHNpTYBoQ6t2Mqu9aIHaaITS
         Wxop2OBj+7YXmP7hqs14tCALq2glB4GmongionzM4ZGaty18pR2LO4s5XD+nT2UwZK46
         9rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014331; x=1795619131;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uHGZ+xOdJx3Zm8UTHiozAvdnroVoplilsdHtzudcbVI=;
        b=gxnVw/INO2zB6MS+Ro/guW0+CBRNhUm+0E+n+GqQVTY20wCbIi+WJefC0YRj/S0F9a
         qqvOhYg7f4ihyRbkGfjKAkeZRKy8cyh+EHLGEdP8esmSpAS28oY/5Yfu/a/zAGEH3jxW
         LAK3D1pRh29EKX1hVYqjHJM1JYz478BQAL7bT3NhOga49ZD41/fWWPPx69J1T7ykqi8A
         75adVNr91U7y6RkNrhcYjFCbZoko1XRWOGGKf9xQ1gf8RHmZJX6HjHoNMlAI568QRDtI
         CsVu63I+/OmNQzow70Bur8ExGrA5+YeGr5IA5mgfVLg/WUniawlCk0cZFoKK288SPJZb
         GAhQ==
X-Forwarded-Encrypted: i=1; AL+hErEDVvSIAXV04jb9yDKP79ZT8hRjRRVRTtUSvuL5ypMtJQyc12UyY67C4Mu3B6pNzFEn+9xMG1o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/j729jp43kyMM52uVbPbq1h6C1/0ZZJa2/0QPHkJZ7IXlqA3tZ
	80uPbg4TltqP9i4k0lDShvwikSqAvkaoxL9cle9R5e37IQcULzDnAsaWGZU5nIZmYbw=
X-Gm-Gg: AZFdTZcKolOOZERG5A6criTB0C8/RpM+jJvkbvmmoWCC5c498Aqo7trViqRylmLdts6
	WLSAzLKiYaZpAYQ8/wXeVB9QEC4FsCnZOOvpw3PmQxa+y+S0J6DXh3UYoLWmBl9Rfqtb7MfgTTL
	YMrxwDcslVlY1mRPwdG0EQm3Uh/j5mYczK95cblUouGUxBL9V/GBndOKY21QRxzjaen07B/3Y0h
	DKeu16f31DeAupNI/SB4EO8YSkt1+F2rnIFtcgp5yOY+PRXTyYcoa+c3+nU9yRTX6zoI2qvcpGa
	b31d3pW01QAN68f0xLdzYbAjkN2p3qrn41+1os4czquBTbZTTT45mvHR/ECpIqp6Zo57+msb6f/
	kXLL4r073cVFyG6zMFGXVm6i7pi8BXxvM5qhDYSKp8ZDKsJXqyD4wk+1Bn1Ewpk6sFUpMFmkBjC
	+cLiIEq4BDDCg6d4haU0gutmyyHiO3wy1GyuJwDkpTG0tT9k+p7HpeTBamCp9wYlmgtGoNWjeks
	DcZJVaFhBzx95nx//jgkYqIhIrUDKlmSEVe5bvn/1Ai5rGtQfRnzK4o7/T9XSxE8fEj3Ofie6n5
	3V55kOlzNrgSfZOHP3FWrWYO2ctrwekvLaU3DC122UbtmiMpdZW1zRiieSWneyJ4
X-Received: by 2002:a17:902:ce10:b0:2ed:2104:9a6f with SMTP id d9443c01a7336-2eff73f1e64mr28760675ad.22.1795014330948;
        Wed, 18 Nov 2026 07:05:30 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6115f28sm15446135ad.19.2026.11.18.07.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:05:30 -0800 (PST)
Date: Wed, 18 Nov 2026 07:05:29 -0800
From: Joe Damato <joe@dama.to>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] igb: link queues to NAPIs under RTNL after
 runtime resume
Message-ID: <av2+uVOytr5BDs5P@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Antonio Quartulli <antonio@mandelbit.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261116153041.3002666-1-antonio@mandelbit.com>
 <20261116153041.3002666-3-antonio@mandelbit.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116153041.3002666-3-antonio@mandelbit.com>

On Mon, Nov 16, 2026 at 04:30:38PM +0100, Antonio Quartulli wrote:
> __igb_open() links queues to NAPIs with netif_queue_set_napi(), which
> requires RTNL, but RTNL isn't held when resuming from runtime suspend:
> this triggers "RTNL: assertion failed".
> 
> Don't link them in __igb_open() when resuming: do it right away on
> system resume (RTNL held) and from a work item taking RTNL on runtime
> resume. The links can't be kept across a suspend, because
> __igb_shutdown() frees the q_vectors. These are only freed under RTNL
> with __IGB_DOWN set, so the work item checks __IGB_DOWN under RTNL.
> 
> Tested with the 82576 emulated by QEMU.
> 
> Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
> Cc: stable@vger.kernel.org # 6.16+
> Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
> v2: no code changes; mention the tested hardware.
> 
> Note: igc may have the same issue: __igc_open() also links queues to NAPIs
> (igc_set_queue_napi()) on the RTNL-less runtime resume path. We didn't
> have igc hardware to test a fix with, so no igc patch is sent for now.

I have an igc I can test on if you want to send me the script you used to test
this. Feel free to message me off list if you like.

>  drivers/net/ethernet/intel/igb/igb.h      |  1 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 38 +++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
