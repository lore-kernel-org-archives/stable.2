Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458F488764;
	Mon, 12 Oct 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807915; cv=none; b=KREbBrehD+yB3FRQkuwy4wWtLLX8tu79swDgvdvUIPOyzG6hclmfENXVwLLOrfoeHkdcEPloVsLO5IgdRQBvtJ+lOsudl/At/zv14YWXY12g0ky4LRLMR044qDsmhwHOCCHMkQGU1zOAgTPNMrqWOML5Tinqk4FxNdnKkCGNZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807915; c=relaxed/simple;
	bh=wA/kf/hwAqR7yiDLnSmWMfZeCU4wWWpXRUG+A9qxyTw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sJCscvznF69vop2hnGPsaaJKXIaHOwpeu8kqI9yvcn/J0Kh0pZDISVmEPElrPMnzk/awqqWSh4frrr3oDhBB7aQOS9oJSbU0DbcPfxXsI4QZ9LaMfFiSIG687IG/mrW79B2fUWAV6gyqJXfh2QnnctCU/c3j3/wcLOV9CADv36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Mzihn0NR; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Mzihn0NR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791807910; x=1792067110;
	bh=33Rr2jc6Yaw+4r1bfP9ljbedg40nqueBD101VM9QjfM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Mzihn0NRCkhHhSovyRgdJ2RQKHbEN8fIMpAaJxFLCs2TuAxpv85qyrmjxudqzspgg
	 Ao03o0qhjqXYARa8se7k1c6Ra8/jdlYklri2WCwGR3P5piaf8g2LH0B3wQYkzjNvVR
	 aUrO7+nrVKDRmxlKS7yZYBreVFycz9w3uRGQ5XxcvzMK/f6Jb38sVEgzrUCAFETn/1
	 6ck18OEEBr/cjXY3SqQN9UCFOZppWWzlS0tmBQrn9222e3Mtm4QkNB2JngqidJdsrI
	 Pigh3kL6t8iiaceOCmju/vZEHhMd2blyz+wbl69SDC2HviZ5ezbtSdflii4fN1lZ9f
	 0i0tjO2W2Q4jg==
Date: Mon, 12 Oct 2026 12:25:05 +0000
To: Daniel J Blueman <daniel@quora.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
Message-ID: <179180790256.14163.6073243575138143895@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 6de720edf3f2538807677764b257c6a5110acbf6
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Sep 2026 12:14:43 +0800, Daniel J Blueman wrote:
> With this change, t_high_cnt 3 and clk_div 4 gave a tSCL of 375ns
> versus the previous default of 521ns, however the I2C spec has a
> minimum tSCL of 600ns.
>
> Restore tSCL to the spec with t_high_cnt 5 giving a 625ns tSCL,
> verified on Lenovo Yoga Slim 7x X1E-80100.

This fixes it on another Yoga Slim 7x (83ED).

I took a distribution build of 7.2.8 that works on this laptop and
replaced only i2c-qcom-geni.ko, built from the same tree:

  7.2.8 driver                   keyboard works
  7.2.9 driver                   keyboard and touchpad dead
  7.2.9 driver with this patch   keyboard, touchpad, touchscreen work

With the patch the keyboard takes the disk passphrase in the initramfs
again. The five I2C controllers in use run from the 32 MHz clock, as
they do without it, and the log has no error from geni_i2c or
i2c_hid_of. That is one boot.

Tested-by: Birk Skyum <birk.skyum@pm.me> # Lenovo Yoga Slim 7x

Thanks,
Birk

