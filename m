Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6D3BCD05
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748210; cv=none; b=EGXFT7OSLeV9KJZ0y/08wIkIaKJFMiQkyZQn38AVnFoMjCVHi6Hy0UC4fZ143hXFndotezI5f5TU0syDhDoQ/MSoSdqtUADkdcvyrRG8MQXZ2/a9TaojVEb4C8dfSDvDfADIoDdteFB65JKj/0ECdYKoVcxRYLRArO/P1oK753c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748210; c=relaxed/simple;
	bh=zm0r4glsNOxJ03wZrKAIgQ+b1zHrFGL4ar6++8AFGQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8dkIEKxyXNCmEn9S+feNmzJqftNFAbFmcZkduhF06IPlH/kFZY4x+QZ3dW7OfXurjoLcsgTosjq1KvywD3ct7DlKPIXwT8ZUOZ1vzREro+0a/iAAWSHAnxOfodeKfZSVvE+Q3zYvxqpv/mllH1ricqM6y/+YEVMZeF+JtJ8Ffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBpoVkrw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBpoVkrw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so9506685e9.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785748206; x=1786353006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6DhqIpmeojaXcrJr0s+5N7z4n/wdaspZafaywldTd8c=;
        b=cBpoVkrwHvcCnEzUtQc+Xe8EeEFerXwBXfhWf1jAnNIt8l9azEenGsqjEsV/GA6wnc
         yasG/3uwbJa/Ub2p5ftM63sYXy67ELIve4pwdi26py6N2VXui/AHJhM2nxphVWLN37MI
         6tS+ngEhhWvm1aPskAoGOslnWgdR68LREM+IZy0PXMgGDj5joc5QGRLmMkLnXxmZ+7uK
         b2tPfkJ4E5PV+QEGPayI+AMM9otq3UzqsYa/WgPMUhQowlIMhQeCT8FTfBNPt4uuur0C
         lbSHTakgyluCt7YMkuH7RFLXNwBnhdk/4leHGJ5pI63pxeyoJu3JOq0T7ccOpGXXRlG2
         CmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785748206; x=1786353006;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DhqIpmeojaXcrJr0s+5N7z4n/wdaspZafaywldTd8c=;
        b=BOfDyzIUlzEsmmDpyVvAi71qsYFJuBJIjhSO+uDPCE2dZCluVuY94vMOMZOOaVQG10
         nJsXvHFZuClElW/voQ/gYILf78lEIeP3z1Y7vu7gNTilIeTmlbbxuk3Lnf3GSdhoPDa1
         bo5XZCLkHi9Osk4rzB/2Na28W4FGRzQ321o/vQcwDmyVagtOZMh7Rm8udWZ9tpolLiDv
         Ahhvi2ddZPvyshi5cSZmGLvKnkDxtE3ndGyszA+WeznUcvly2Jp68AQbYY7EEF7B2HAn
         YsZguoqaMCwev7uN6Mamfc2DzFR1MibmAr+eBnpTI4p4Z7YmjT+oAkLQzxNEQs7j99hJ
         AT0A==
X-Forwarded-Encrypted: i=1; AHgh+RpOh+AE6kRfHCx8X6bLukriXHbAAfUvNAYF9xcP8rLdlm/oIxkUf8faa3cP5rXrakPBZq/PQbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPyKZzGo9mkAVw4yRFPvTL2Cqb0TsB8qTU1PxcXhdi/d9k+t1
	AKcqz8BUT1JG/cMCLYZ9PzMVZFqSysZ1wrqE1OWA/5ULrY43l7RbKlUV
X-Gm-Gg: AR+sD13HDkRVHjtjCtxd7KAAiiO9lU0sltQ+qNRPqsFpdtfKg5nX4pjcznShfBIE+Du
	wEw1TmuHlTMEkWeBhk09jayMYRpzyexpk97oFfcUlncEF6rpQjlr9jLY3MTeYDNw6/fTRZQOHfA
	UOu4NTKfF9d3g3EETSRXy5EKLTL47+rOuQcrYgkbOAeZfLbLCLqHVXZlYdUp6jBl6aIdhCtLDvz
	ZvtXpJXKAjKypAGaVDxdbCQGcf8eDnRpUCDoq8cIxql1SvbA4uhIFs2ZI0hDLwsW/E9mjZeLp8R
	ZBKKhu/clbdQRtjUIjjG5pXhdyPem2tFtJg9JhsQisj1QIxA4HsefaLw5933MOfKiyv0y56sfAl
	cPnWXsFh/tRpGlG3tBLqRCmmtZIv7j3WN9mG0038ncsa/R6biG7aIQHph/zz8Xr4ixIR+l3GVBI
	3h4Pv3Va5it3szkcytD/Hnli1qIMqVwJesFvoiPxeWwsjFaw2w2V5h5CEI2pVXNCnA0vQajLb9t
	mNeXAtWtLU=
X-Received: by 2002:a05:600c:c3c1:10b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-4980c672b1cmr152028655e9.10.1785748206047;
        Mon, 03 Aug 2026 02:10:06 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:cc3:6030:fb19:4ff1:d885:5a22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dd0asm209549375e9.14.2026.08.03.02.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:10:05 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Jie Luo <jie.luo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Brian Masney <bmasney@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks enabled
Date: Mon,  3 Aug 2026 11:10:03 +0200
Message-ID: <20260803091003.15285-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aeeeebf9-dbd4-4f57-847a-5f495b3236a2@oss.qualcomm.com>
References: <20260730191353.557494-1-kuncy7@gmail.com> <aeeeebf9-dbd4-4f57-847a-5f495b3236a2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/3/2026 Jie Luo wrote:
> The CMN PLL AHB/SYS clocks will remain enabled as long as a downstream
> consumer of the CMN PLL clocks is active — this behaviour was confirmed
> experimentally on the IPQ9574 platform as example.

That is exactly the mechanism - and it is exactly what IPQ5018 does not
have. On IPQ9574 the nsscc node consumes the CMN PLL outputs in DT:

  ipq9574.dtsi:
    nsscc: clock-controller@39b00000 {
        clocks = <&xo_board_clk>,
                 <&cmn_pll NSS_1200MHZ_CLK>,
                 <&cmn_pll PPE_353MHZ_CLK>, ...

so the device link holds the supplier active, which is what your
insmod/devmem experiment shows.

On IPQ5018 there is no such consumer: nothing in ipq5018.dtsi references
any cmn_pll output clock - the only occurrences of the phandle are the
provider node itself and its own assigned-clocks. The actual users of
the CMN outputs on this SoC (the internal GE PHY and the uniphy blocks)
take them directly in hardware, with no DT linkage, so no device link
ever holds the provider active. A few ms after probe the autosuspend
gates the AHB/SYS clocks, and the box dies on the next bus access -
which is the measured behaviour the patch description quotes.

So I would frame the patch as: keep the usage count elevated on SoCs
where the hardware consumes the CMN outputs behind Linux's back. If the
preferred long-term shape is instead to describe those consumers in DT
(or to make the clock ops take runtime PM references of their own), I am
happy to help test either on IPQ5018 hardware - but until one of those
exists, this one-liner is what makes the SoC boot reliably, which is why
I kept it minimal and Cc'd stable.

> The CMN_PLL_LOCKED bit offset and behavior are consistent across all
> IPQ platforms — the same register layout applies to IPQ5018.

Understood - but then there may be something else wrong on this SoC,
because the measurement is unambiguous: on IPQ5018 the bit at offset
0x64 bit 8 never asserts. Every clk_cmn_pll_set_rate() call runs
regmap_read_poll_timeout() to the full 100 ms timeout, including for the
very configuration the bootloader programmed and the board demonstrably
runs on (ethernet and wifi clocks all functional). The -ETIMEDOUT is
then swallowed because clk_change_rate() ignores the .set_rate return
value, so nothing is ever logged. If the layout is the same, is there
anything that gates lock detection on this SoC (analog block state,
reference selection, a status-enable bit) that the bootloader may leave
in a different state than the driver expects? I can run any register
dump or experiment on the board that would help pin it down.

Thanks for looking at this, and thanks Mieczyslaw for the review.

Stanislaw
