Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320529;
	b=DCeC/vi59h3E3xAkueAGxZpEv2MZ9DJs/WIBz9NnJn6wNDJ7h7hjSDUwqYwfzrcO/abN
	 vnAc16pHydTOQiypgL+1J1NtU9qa3dP70GZNtYjYnih8F6J+LN90yqDFKupmgQ5b3rY8B
	 2Q2eya07Xy/eehkSn2qCW65DWu+RbKerkB00A3U7ODE5htVj5oMsa9IRmSSP80o/3JU8B
	 N4nzUsc2+BRvcyH1GyNUXkaejd2lmifZY0hpPrqn4p+awjM4EzWxiucupk7aftwmSmk1q
	 A3ZMoYuu5c3MpKZZXp41zrLc/HYW7GuBPOQffgkoT5GYS4EdtqqD1alUdZ0m1ZDro1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320529;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=MZmdFrQsotgCT0wSbD7pFt39rO/eJb/iqITxSt+oBTY=;
	b=zDKbbNv70BFkwuf62Zvf81i3ekE3YUdcYfTi+vHF4cJ8l0V0DMU+nkFwx211t4IHBIa8
	 +t4K1egTygR6cOco3Nc8ZkSO9i3F7gUVauQ8UtnI3KbxYypZVOSbK7DwkT+vnWXsoulJx
	 4CITlV/EnovYoh3h6esfAQ7xxffLU924V2ZyegJVVSbADTO86cRy3WzbrsIqeNKyJL9xx
	 Px5ULfAgqBIrVVOYZfPLTEOoKupi50I/erB0vXjwJeRf+oBjyO5E5RsxEeuRy9tmvujWw
	 2fjGgWV50wLijRdFCkK1YmUGS+4YJN7FGl2CastvmG00T4lGaTLGFDrGhwp28mNbZIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="r/QOaL1i";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92900606A32A;
	Tue, 10 Nov 2026 14:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92900606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=r/QOaL1i
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8F071477;
	Tue, 10 Nov 2026 06:22:04 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D605A3F632;
	Tue, 10 Nov 2026 06:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794320527; bh=qqmX+RQD8lVwnDNULp8bZFK/Y+sCe6EIbhF7PutAMtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/QOaL1i1N1G96BwQV4CtnQOUTUJaFS/2qu7/VQtLdLOjD0oCPtyV7uELp66l/22v
	 AjcibYeVw5kXy/30pgy9puKV8sa1YfJqWh1fkQVXLVU6MwlKXceVyhuGhWRVA1c3w6
	 wMIg23XbPsmXeXiTNzBFY/8rPTX92M5EAhKtwLWU=
Date: Tue, 10 Nov 2026 14:21:55 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>, imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>, linux-amarula@amarulasolutions.com,
	arm-scmi@vger.kernel.org, michael@amarulasolutions.com,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 1/2] clk: scmi: fix SSC spread conversion
Message-ID: <avMog5kzJpsiUhXn@pluto>
References: <20261104103620.4054694-1-dario.binacchi@amarulasolutions.com>
 <20261104103620.4054694-2-dario.binacchi@amarulasolutions.com>
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
In-Reply-To: <20261104103620.4054694-2-dario.binacchi@amarulasolutions.com>

On Wed, Nov 04, 2026 at 11:36:02AM +0100, Dario Binacchi wrote:
> The spread_bp field of struct clk_spread_spectrum holds the modulation
> depth in permyriad (1/100 of a percent), as documented in
> clk-provider.h and in the assigned-clock-sscs binding, while the i.MX
> SCMI OEM extension expects a value in tenths of a percent, as pointed
> out by Peng Fan.
> 
> The conversion divides spread_bp by 10000 instead of 10, as reported by
> Sashiko, so any valid configuration is truncated to 0 and the hardware
> is silently programmed with no spread at all.
> 
> Divide by 10 and fix the comment accordingly.
> 

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian
