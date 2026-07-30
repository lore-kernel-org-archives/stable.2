Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215D406261
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403345; cv=none; b=CWr9ixl6+3K0OLvawkhZSQQh0cvXj1+iFkAINKHpfBaLJGscHBMF0AvekMR+8SdrbNhdOkdPuFy7FMPSeOE/NvVRFyMMit/pLj00vJSSFatcZcTYFu2UYg3hQxBklXKzCAQ1TnGiPPjvx2MqjB32XpFwAoq8jniKjvN2vBpuFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403345; c=relaxed/simple;
	bh=+ZPUS+pWBIyobZk02S5SG+Jfpd9YvNmk6RAjNBVIEik=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Jcftg15ZkxqNf7FSDGvlhkOpDDmaUEHxSplJ4wMBY93ZUXp34lxnLfw76c0mH775nzPweKTVM3TRf+RjuPEUhTY0if+JFkvhoiPYR3+pT3dl53GiFqPQZGpspyqrvKzu9NnTUmugWmCdmIQ4Ho7CPjXfYMw1Srew7JkKw7ODNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/K24zff; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/K24zff"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7ff05e5d009so24227357b3.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785403343; x=1786008143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U/uGz8/en7PP3yUR7bLkaXn8KlTTvQzld3gW8RE4GTA=;
        b=X/K24zff6w60/fMyWEnDA1lOOZrMM42en6VUTpBPgQcE/0zDlv2XlL/u+4PCRbxoGL
         /N3U5K93b9iQ7Brn+X3D7s31AZUb/FS+1uBwMRH+8wJK9ozE3+r8dM0kqgkJFwfI5b4u
         amaoGBW3Wc6GG4DgHs1rW7FIFsAAMOjZUgIDVaLxJOqjojeHNoKhUqm/CrxIDA+udrhG
         M0wkNDSz73gc+gFjm/qIBAF9CAnFiJ1V5/B5cGuz4pIhv90SRzN3m8m5xaFBMb7XRiZr
         UDrMZBL5eFYfkeEu9f1ckapapaN5FA3DVfYiL0GeZjt0mWr7qSDCLKXqWoA2Qn5/kTl7
         f2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403343; x=1786008143;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/uGz8/en7PP3yUR7bLkaXn8KlTTvQzld3gW8RE4GTA=;
        b=iri+lQnQ3D8BUSxoRbdbQPoryz9d0uzAjG4vSzQP7uDQ7qCbyciCCHpnH5Wb+5MjQG
         fo5wdoInz+dWNFP2fuZHOpBGJRy26BpPjUaWMg20pJUkfG5KoeBQgpR5byzY3GOcMihM
         ksE56zI8qESFtipCQs1EH/gthtiMkrXq42nwp7lIBlyyeHROqwGqDe7J8bYGdI43GKgl
         gB8cP16ZOb5zHMTzLdNJ50bH0jV2ApemzPbdjYBGj7/FkxPoEe2IE38hzEet5niR7VRs
         MHoX8KrgUAy2T+NDQQfJ6H6ilYxjkgM1RZcflkNLrBwDftEYwDtbm/YRRQ98BMqQrZ3T
         ppWg==
X-Forwarded-Encrypted: i=1; AHgh+RrNt8OGQFcsbsUUtgUwST4ji6SfTVUgiR2Rvv01z9HgOlbJZWXBQAf9F+O/kRwca8gWeb2xfZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JdzVmVK/w/R1I2KPfTfkmtRbiZ/DMdt7X97crEJXUNjCRYFj
	p3g8x9VBWpUckfVHMkgTODpes1T//WV1XvuPR9SRHitLI+Z9CE8ZuUf8
X-Gm-Gg: AR+sD11/5QckiEjiDw81Ys6iF+z2KbT7XeYShBPh+zeBcXHDu9LrVtap6aEGzYq+KAg
	Jw16cWyxmmLbCJgizXokMWUeeVnVoFyB8f0zM3JIBRGpzpbWnl09BeFGTvbePRItOzq7dnX4Yhp
	t0aS/ll3nOOoSEdT/eu6wde163lQTuBV7EbVpyI/Me1LnwITW1krBPLr2Xt8cvd6T6ZWvmaHDPx
	fc25hehbmYVm/3PFg49DS9q3OLqKgV490H8Tqx6dWY9w50DM7XlSmVsbG+5B7HEt+l3Tpj/NHpK
	QXDNJYhHPBx5pLR84ApCTUIWRVOQmLjfrW6BB0neXG8bhRIWxfXGGT+nWNYgml/IlotmF9kDcY0
	X9cy0JuNGZVSXevrKr+PG48bEOqRoC4Zw4AgtZi7Ep24T9F/H8T2Rpb6zYGUJOMGldokK6hJoSF
	awNWRkTevcGbkKvtKwOoZMVY+d87z9c9155u7GR4U5dNsW9Qol/UULPelnMNwsDjylVwD8DM6Q5
	PNxkFtvOt741mYdR53OC8oFw7UzufNdqgJR
X-Received: by 2002:a05:690c:6d10:b0:81f:3dab:372f with SMTP id 00721157ae682-81fb88c616fmr11936857b3.12.1785403342691;
        Thu, 30 Jul 2026 02:22:22 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8acb5f0sm6856507b3.38.2026.07.30.02.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:22:21 -0700 (PDT)
Date: Thu, 30 Jul 2026 05:22:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org, 
 Qihang <q.h.hack.winter@gmail.com>
Message-ID: <willemdebruijn.kernel.f39af6152c60@gmail.com>
In-Reply-To: <20260730082925.93759-3-q.h.hack.winter@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
 <20260730082925.93759-3-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net v5 2/2] packet: use consistent hard_header_len in
 TX_RING send path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> tpacket_snd() reads dev->hard_header_len independently for skb
> allocation and header construction in tpacket_fill_skb(). Concurrent
> netdevice reconfiguration can therefore make the reserved headroom
> smaller than the amount later pushed, or make copylen - hard_header_len
> negative.
> 
> Snapshot hard_header_len once before processing ring frames and use it
> for the frame limit, headroom allocation, copy length, and skb
> construction. Pass the snapshot to tpacket_fill_skb().
> 
> The separate SOCK_DGRAM consistency problem between hard_header_len and
> header_ops->create is not addressed here.
> 
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
