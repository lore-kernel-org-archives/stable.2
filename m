Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.13.135.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795342641;
	b=kw1X4HlvhN1ooiP0OTOutfuqoQOQNbuecTHysZtCcHn8Occ261BPLOGpJyhdaKd1NvfZ
	 J/bO2A2tPQAP3r3WrJ6Hkz4pbGWqwGDcQdgICI2liUZ+Ad548xXP/EnRM7YFHHQjqpSo2
	 NGeHhLQWxWvTGYAMCqljGoGyeWm5gGKW7fwG7+YSaFkiLPzI9OZRBOfei540eTNrj7mS+
	 pfplZyMU8IjC3L8J0tjF1BKWbC9SO6vAOL0wQvW76lmB8OEwOaWJfqljPWTh5UObqj7g9
	 Fah4B0EJOREk8CdhmW1ecFV2pBqismlNauiaQe/DUOjP4W5jryF5GrW38Bo2u2D8RGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795342641;
	h=DMARC-Filter:DKIM-Signature:X-KAS-Sym:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Bar;
	bh=0rJsQvHhynQ32F2u5eNosZ1E229Ap94jONkhrNGuFzE=;
	b=Ob9QRAXPiNWpswn9DZ6zduCiFJaCokhq+Krr6p2MHu95GNtF6KoSKi3WVluhq++ldahr
	 N57G0SXrfo2/ZHHce6PfXiKpcEAhatxrRxt7jU1B64OLOy8AIu4TNDpJ52gFRVPDRMcOR
	 XTrTLqlVmhLsnPPXMF9j2T+lrS4Opq+IQlHbJANzhOtspfmo9dzCBFViigLLDZtbELuNB
	 SI1szhJrNZOV2ELsOSaCcXh9kuxBCeGhG3rh/Ek74YDGvN0GTb4xhTonQpgodxpapv/iu
	 fyIuwmVQIN/CzRBiBU5agQEgs/gooTYYdJhT9oDq8r5M437hH08yyGFMz1w1n4WsleA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tsv-stahl-riesa.de;
	spf=pass smtp.mailfrom=tsv-stahl-riesa.de;
	dkim=pass header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=dRVOGmpp;
	arc=none smtp.remote-ip=85.13.135.14
Received: from dd13108.kasserver.com (dd13108.kasserver.com [85.13.135.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F029606A330;
	Sun, 22 Nov 2026 10:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F029606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=dRVOGmpp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsv-stahl-riesa.de;
	s=kas202608160020; t=1795342639;
	bh=0rJsQvHhynQ32F2u5eNosZ1E229Ap94jONkhrNGuFzE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=dRVOGmppY1OJalTNCBIso6otognif5xYLHvzTpSCutwEGxqT+FFhsl35gZTOdOWLn
	 /Ia6izJRACzzALywnuwmSZS94viM1DipDU07tn6f89XcxpkzwoMAvyj3zjv09lFJGn
	 Yk3efFldRaUNwQ+9GR3ogr0DqFCmYWhXYcKYKy7y3eKF2NMk17yBmw+ww+TVBlmE54
	 zJBiPye1UsgEDvqn1g/aPAxSrzCVVstlExYJc7RdAfM1QpzKTV5XpA0GvvKLvvqmG1
	 7fOjjY2IsjQVXPDiZfY7XltdI4w/ddJ5p0EcLkvu+KA45JAK+128rtdW7ZTUnq54hs
	 w2cOZbPurLHMA==
X-KAS-Sym: v3:f51bdf72230551df:qJ5uOu2tDOwck04l6ZZT5ZgS9yYs6RwmRLkVQ2e11W2Qg
	xi4Fjh2AYzKKX2gAyElm3p0uCqidYfZPAU5b1CzV46YKHzkqvcvF9ccxgCloMJKvslloO6MCVfr
	6QdObSfYmUNWJ/0ucr8ReMwDqZqTusb+gYriedhqiF3fS0N72iVo5FfV8U+j8sjgdQrvg+UEGp/
	pMFOz7n2SOuS/Di7sMFu5a52da6xM7KbRWb1W+CP2vGKw25C/j+ejlSDMMtN0jrrQDY3+AOavU4
	QcErcPgCm854wBnsoLaG1yVxs1QYz+HjGQnrwyrtb2YfxTOOrtB2rQBg75sAG60ujUMzYTiA==:
	VGCLRkyDvrsnEsRDHwxg+n4U3Tpg20TwGZAxbODxpHCAdrvXt7okBvewFd6oE6MMOQ+ZcpWzaRr
	qEe7qcqRzNd6LBlnTBpkTeFzxJcRGrshoCRdvva0O8PgmjmKuFSAGUVMmpjRgDeHolwphzSD8Xl
	jWxrdhaiOAFCvnZIv/e0DtmpLWslZvpUrD2DKB+FvvZ6u+7JLfBTbNz4583f91vNmdDWUdUilQi
	8jb9fEdc8UMTqWmvN52+odE3YVzc5UnbUOw9kggDq/dCSkkCCiYhBJ8hhE0hUnkXMaBRzH4fk6O
	aBOdyXriplVIYXB9xd2Atb0spEYjWNwpSZ46JV07Xs5g7lQGaVz9NU6hTcBNrrNNp+JlLBlDEgJ
	vDrCf1tb1Bfv4D+5WACKYW1DKUEr+vvcagk0uEC/hdE/cgSBsvJTdyZqcF8u5kMLxV/1eZR+VWz
	X5DgnTTLyHif6m2ICmXc7j8cTgoMnBqUqDuS2qZMSxelD99Ub2cZtTuHusPdcJKfRvyI+gv5VRt
	o5nPa6Te1xjDokFTE1EaeQrw60vZdjt0QgUK6GfWMa816AtUaZnhj1VpboeHO8RCLhaAkBcmm8U
	UsgrsQ91JN5Dmy3/QzuPSUMloUk8GOZ6V9s=
Received: from [192.168.2.174] (dslb-188-098-197-218.188.098.pools.vodafone-ip.de [188.98.197.218])
	by dd13108.kasserver.com (Postfix) with ESMTPSA id D318178203EB;
	Sun, 22 Nov 2026 11:17:18 +0100 (CET)
Message-ID: <464daeab-4306-41d5-b013-9a0813ac412e@tsv-stahl-riesa.de>
Date: Sun, 22 Nov 2026 11:17:18 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Tegra114: Fix CPU DFLL voltages
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Prashant Gaikwad
 <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
Content-Language: en-US
From: Patrick Fischer <admin@tsv-stahl-riesa.de>
In-Reply-To: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ----

Am 29.10.26 um 10:32 schrieb Patrick Fischer via B4 Relay:
> Since the Tegra114 CPU DFLL got its CVB tables in v6.18, it computes
> the CPU OPP voltages from tegra_sku_info.cpu_speedo_value and the step
> of the vdd_cpu regulator. On a Tegra Note 7 (Tegra114, TPS65913) every
> CPU OPP from 306 MHz to 1810.5 MHz ends up at 1000 mV, and the DFLL
> never changes vdd_cpu: it stays at the 1.10 V left by the bootloader,
> and the CPU runs at about 1.34 GHz whatever cpufreq requests. Three
> bugs cause this:
> 
> 1. Since 2014 the speedo code reads the Tegra114 speedo fuses at offsets
>    that are 0x100 too large.
> 2. It never stores the CPU and SoC speedo values in tegra_sku_info, so
>    the DFLL computes with speedo 0, which overflows in
>    round_cvb_voltage().
> 3. The DFLL takes the voltage step from regulator_get_linear_step(),
>    which is 0 for the Palmas SMPS. Every OPP is rounded to 0 and so
>    clamped to the minimum, and the I2C LUT holds a single selector.
> 
> On its own, patch 3 fixes the Xiaomi Mi Pad (Tegra124 with Palmas). On
> Tegra114, which includes the TF701T, it needs patches 1 and 2: with
> speedo 0 every OPP would still overflow to 1000 mV. That is why the
> three patches go together, all with Cc: stable.
> 
> Since patch 3 is only useful on Tegra114 together with patches 1 and 2,
> it would be easiest to take all three through the Tegra tree.
> 
> The Tegra Note 7 device tree is not in mainline yet; I used
> Svyatoslav's tegratab series on top of v7.3, with these patches
> applied. Results on a P1640 (Tegra114 A02, SKU 5, CPU speedo ID 1):
> 
> - The fuse values match what the vendor kernel prints for this device:
>   CPU speedo 1742, SoC speedo 1156, CPU and SoC process 1 (before:
>   SoC process 0).
> - CPU OPPs: 1000 mV up to 1122 MHz, then 1040, 1070, 1110, 1150, 1180,
>   1220 and 1270 mV at 1810.5 MHz, as computed from the CVB table.
>   Before: all 1000 mV.
> - The DFLL LUT holds selectors 0x38 to 0x53 (1000 mV to 1270 mV)
>   instead of a single selector 0.
> - The DFLL rate follows cpufreq within 2% from 306 MHz to 1708.5 MHz,
>   with vdd_cpu between 1020 mV and 1260 mV. At 1810.5 MHz it stays at
>   about 1.74 GHz at the end of the LUT (1270 mV). Before: about
>   1.34 GHz at any request.
> - At 1122 MHz under load on four cores for 480 s the CPU stays at
>   52 degC with 3.15 W from the battery, compared to 73 degC and 4.48 W
>   before.
> - No errors in a memory test with 25 passes, in three 600 s load runs
>   with cpufreq limits of 1428, 1606.5 and 1810.5 MHz (throttled to
>   about 1.0 to 1.2 GHz by a board thermal zone), and in 316 s at
>   1810.5 MHz with that trip raised (DFLL at about 1.73 GHz, 1270 mV, closed
>   loop throughout, stopped by the test at 98 degC).
> 
> Svyatoslav measured the CPU OPPs on an Asus TF701T (CPU speedo ID 2):
> without the series all of them are at 1000 mV; with it they are
> 1000 mV up to 1122 MHz, then 1020, 1050, 1090, 1120, 1150, 1190, 1240
> and 1290 mV at 1912.5 MHz. The speedo IDs come from the SKU and do not
> change, so the core, EMC and GPU OPPs stay the same, which he confirmed
> on the TF701T.
> 
> Tool use (see Documentation/process/generated-content.rst): the patches,
> their changelogs and this cover letter were prepared with an LLM coding
> assistant (Claude Code). It compared the fuse offsets with the vendor
> kernel, read the fuse words on the device, traced the zero voltage step
> through the DFLL code, wrote the code changes and drafted the texts from
> my measurements and instructions. I reviewed the changes and ran all
> tests on the device.
> 
> ---
> Patrick Fischer (3):
>       soc/tegra: fuse: Fix Tegra114 speedo fuse offsets
>       soc/tegra: fuse: Store Tegra114 CPU and SoC speedo values
>       clk: tegra: dfll: Get the voltage step of range-based regulators
> 
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 26 ++++++++++++++++++++++++++
>  drivers/soc/tegra/fuse/speedo-tegra114.c   | 16 ++++++++++++----
>  2 files changed, 38 insertions(+), 4 deletions(-)
> ---
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> change-id: 20261026-upstream-speedo-t114-3567735d5a2c
> 
> Best regards,
> --  
> Patrick Fischer <admin@tsv-stahl-riesa.de>

Hi Thierry, Jon,

gentle ping on patches 1/3 and 2/3. 3/3 is already queued in clk-next.
1/3 and 2/3 have Reviewed-by from Mikko and Tested-by from Mikko
(Dalmore) and Svyatoslav, and they still apply cleanly to 7.4-rc3 and
to your fixes branch. They should land in the same release as 3/3,
since the DFLL change alone does not help Tegra114 while the speedo
values are still read from the wrong fuse offsets. Could they go in
through your fixes branch?

Thanks,
Patrick
