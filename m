Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793703520;
	b=26aFs+dzvL/bExvXP3lP971j/uk5RNwQcemi3VQVouVXpWMYwyh+WWpHkMoyw9fGBG8P
	 uhF1+/lUpZG9t7cFNsLblT1I/07I5yHbnFSWtzFFiQ9QpuFCrZJMt0lOZCvG6xsPQoVWT
	 feBDTz5QCFnCd6djYyeI65fBZIRo1JibLC0K7ZGAFuEU+chvf/v3afKDQKhMlzpngCqAM
	 1YGHrZvGIehq1rVkWIlHDxyko2SZulGisvS17SfecQhfIiT6+0RPim2AL5vjxf5V/0E01
	 QMtVk/TqPmfTke7xzGZu2xaiwG7Yi6PXQ1dFWTwj67bYzzxhGR5QQCroLCiZ0O/rixQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
	b=bYRDhIhSBoXk9rVt0v01vpDNo3lJrhM+mdVSW6lzSscZ/Nm66I7yUrn0J5m5AQDebrS4
	 CtNwWA6AByPC/W+/InritstdO5EZezq+Wv9XVQQsL4EmX5y4jiVDKP8GdqW8XjnKw91cL
	 chEmjXL1cHqKA25j79EhY9jhX88kG8u+weHFmSm49it+ON6ROOtQYTLihWea1vZaCRuKr
	 qIgk1zczrt4S9jzS4eusIqvL2zarHv85YeDdW+r9LB8xRDbm5M/vNCC34zF3v4Z07ulPd
	 dRjRsQfgON0xpGpc/a//DNEivrv1haLozi7EvFkssSZPvCRZFuXbcOwjXeuItHW42EQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rw9S2U+A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0D607009B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61A0D607009B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rw9S2U+A
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so2171727b3a.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793703519; cv=none;
        d=google.com; s=arc-20260327;
        b=V/Us6EDn3+DoPBtDW083bTQxaqAwOUSPqmUuclXOtLIf3vJBtgN5IT7vCdglGEfcHu
         2Dfjflpc91sIqaUNc+g6H/p7SEkT+bpoLMt/2QfpGemjjiM1vR7Y7lpLHDC1jEAeWat4
         Hw+X0NWr5hTHx0TbdrWqccIrmedDIL5rO1XxaUrLx3DU/bBeAwTT9WlIzUd1fFAptHjd
         3CINQVqdFJmrsn1cdZ1335EdWVhG/gwR5afh1v2dE+rOfnX1kGHZtitwDJY4QbbmRiyH
         QY0EU7BuO9j6yw7p/XOIeCVaDXkUKdfdl5mQNUrpv1dNWnjZTc9nlDiHQt6QZUdf78lH
         SB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
        fh=mrzFIgOP5+ndUkLqN30Kl/z1p7yW6VBmoZozb6438y0=;
        b=MLL4fTPd6UHqPCyqMdhM8FmIAV51zCPzIu/lgPccXC5stcbk6Yfe9I+hiVCpiqlJLS
         PoehRgCfQbhHZd5ZUXGcsg2JbuKUl/ZZtuGM2mZZqk9ClurDFPI4I06JOINEUNFv1AtE
         nIHHynjQeKL/C3i7/pF9ThkMPVU8d9MLdsAf4RFP1QywQ5xxQCKCJIJZPcJCoPy5Ws5R
         Gpv8Y8yRw6ALyNvdgTgYhXcQIuyes+5CFdzCzYhQa08St0/Fiai7K/6mTQJw4eGjLwXk
         gas6cgKOYXgzHQl/glKURf0Hqbh2mQm2rzBTxveNXwZM3N2DOtLiPvSUJ8e9y2vyQb7g
         e3wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793703519; x=1794308319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
        b=rw9S2U+AlSHzlzFau1E4CEO32us7ZWTI19zuQfIKoKUYkPQTPNp2mBVeYyNI1Peol3
         r4HPJvCt05Ad8bt0OdqRhZJU/2MGPm1UImx2c1pNBFQeVKjHRt2p0DJtO6VAI8QtPIgR
         JCd8J6qNyy2qXCpM/YHu8eZfiDculaeAAq1rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703519; x=1794308319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
        b=Ljy2z4+vxkQhj46dQl4D/hNsvdhFaZ+0wzHWGx0TFTl3w8q6gukuXr4uQMTQ/ATcwO
         TcAwC2v/GzjWtUaQDEc14oULw55l1dcWdbwvsdUFjW+qt9er59yVIaBurUSStm0GXfrw
         F4uES/GnSkty/HLqtzyBYh4TU8xLm+qtHU1dsV2vasv5kEVaC+09jtkc/mcqomtdNHER
         Mhy7xoc2tNJGo4h1zO8rOQAZGyrzHFDDvoEn7jsudIHxRtdZ7k43UD3Svl2ZBWv0pzEm
         RIFfBchON8jNsEOoQbTtjShu4J8m2VWpi2YWoxtAiunbo/K9Xg7lrbK/cJiw2++zQ3bM
         VT1g==
X-Forwarded-Encrypted: i=1; AKwUvByQV350NfF3sk+6hN0H37Ry74rupFE6KwqqiqL1StFurvvZBgDnMdWbxNTB/W0LYcVlIdpfCzs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BDPMBPI2lW8oMKr9hZoI6hsTWIHYTqUeybseNbvGzUBNt035K
	BdZANtFrPaFcP7SpBF6VBWMFmzm22OofDiUicKz/iYuFDWWxgApN7a65Y3HJ04lpOTzSsE5BnvS
	xqvuDG4UDiDJyqOvDq3diVAAB7mjWdykjlS8X4QN9
X-Gm-Gg: AYBFou2BtJJKJ41cnhQ4qcSwiSUbgjDtNpLJla/hvOU0rkIiei+/POQ9KmUG86MFl2o
	+nCQyO/8t/SK97hCxt7aY47UJfPkFoWcDe/Om1aU73+04/mT12h2O57stIo3UZg35tso72eMNz9
	2FOGxtL4Ol0Ub1H8IDTH1UvUPQu2Ycba88T48NxDldR2k9+j5BVP4F7bWLpnHX1oK2LqCDmCVeq
	TkhDwnOhSaRY1Ye+C/3Yk5CaawEqUlba5kE77eeeXVv1By/aEGawn0P48FXuYUbutvMNVX25oQT
	WHMqO3RmScIIRwESq64AkYkPz2Nvctri5iYCr7b0xcU8Qw48SS7fiCpEPGqRhn1XgGlEZm/admZ
	8Z6HflNffg13yecjCHDYDjSxegd5L9GHCS4hJOBKyhOthtdnC94D0uV7L8luWciHUE4fRmZVu4X
	aZcnQzueQI0EHdGpk=
X-Received: by 2002:a05:6a00:600d:b0:892:e080:4ed8 with SMTP id
 d2e1a72fcca58-8a9bd7dc8bfmr10230820b3a.47.1793703518719; Tue, 03 Nov 2026
 02:58:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-MD1X.v6.r0.20261029162633-1@mojatatu.com> <20261103105015.GE865646@horms.kernel.org>
In-Reply-To: <20261103105015.GE865646@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Nov 2026 05:58:27 -0500
X-Gm-Features: AclHuK_L3JcYv2zsBzLTiCwrbJ18-SV_6t1OLvaKXCNLVHQqk_NRsSESvoMnaDM
Message-ID: <CAM0EoM=-bcqRyCoFxNy1W5e0xNierigGe6qbPQ-MCiwqrgj6UQ@mail.gmail.com>
Subject: Re: [PATCH net v6] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:50=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> Hi Jamal,
>
> I think this one looks good to be merged.
>
> NIPA-Sashiko did of course have something to say [1].
> I don't think it should block progress.
> But maybe it is follow-up material.
>

It is pointing to documentation that is certainly followup material.
Let me review the other sashiko reviews (pun intended).

cheers,
jamal
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v6.r0.=
20261029162633-1%40mojatatu.com
>
> ...
