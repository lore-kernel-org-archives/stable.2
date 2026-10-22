Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.61.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647864;
	b=I/MPfsbwbSLCD59qhesF+3/hofsE/c/PrpZX/TJ573Vb8QYrx589yIg0Dz5Glk9rPB9X
	 YZo887b4H83jQA/K6pIq2YDdfrj9FxV2e0BUuA0CJXAYMv0+E7zJ+tuw891+OirXQookW
	 XX52zUp2vCfSM02eO2FlM01HD3X73+FkAH99PnBLt0o0m3AY3jiPLkT/LESqjHCuCP2OM
	 uylpWGcVhBVic9A/ch4BsDKnmCFh9d+Ga9i82TcHefPsYBcHLxQoG2ScnajZlBkdEx9Sm
	 gryLIIGZ/hhnIYsMog2mAu9ptvJ28pP2TUpjUpuhDAvLn/V2ELOzNuuSlRIHbThrzYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647864;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=wXEpnQj+44A3Ir6DLH8K1Ec3z7dL/OqlHU/c2v9xjoI=;
	b=uMEW86BhwvNt7uHZ9o8ySlraj/PBbkA78NDsTHQteRaCAOrs7kOU2iHDBNqXQ+bHVSYd
	 RttFRLxU4X8OrsDmP3AVi6hs591w1728SpTJho7J5kF4lIOIZAaPvPbJQMW16SdjJVsPq
	 mohu91AwTdpyqPYhHZ5JyQyk9GWgKzEo85k+asucPIUrr+o3gjRZLYLI2C63JMHJ1BvLy
	 ObfIOjx5vOs/AYHFMW81ZICMPYvh380mpMOXYzc8ByESKw3h3WOU1y7H4ERrqCLvbUG1W
	 uTjj1odJi1d8FYYRKDk10+AOq3B8+TjGQzrtF0yWV45gUie1JDLeJ2fexGW4OX/duPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=cd0JgHop;
	arc=none smtp.remote-ip=188.68.61.103
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A67606A31A;
	Thu, 22 Oct 2026 05:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=cd0JgHop
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4j9FSQ1H73z8WX9;
	Thu, 22 Oct 2026 07:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792647814;
	bh=+Z9FVGptZarGaP7UlMILhNdXZpHtZZ5mSOY3Hk/ywts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cd0JgHop1pmlC0jozdAjvoCIIclJaVPC6HpPLXEJkFdxUR6FFf87TWiGYELuvj8nX
	 NAuVaoelFmg4fOvkHD/2bt9P7q/2Q30qOIlBybKkUgO6t/zRBMsNfEk6MTK5BrkwOJ
	 M7+VBByiCzY/TmIIjOwM/2bdg/Wb3xs9wpcUc7MzgPLfNZ6Z5nkw/jp0JT5EEE2aB2
	 iTS5YDX0PunCLmIAd15TC5moC2Wl0bqmhKcoxCdqTZ/QSX2C5uuFhgjJl6fSodacZU
	 Q7cx85lJzTaaVVDFOo/5UxkuVtAqK/YpAVqJSOwcpZJoyWiXmQEiHHIaQmQzAD5AVq
	 3P3CSU1+bCh3g==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4j9FSQ0Y2Wz8W8t;
	Thu, 22 Oct 2026 07:43:34 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j9FSP42qvz8svG;
	Thu, 22 Oct 2026 07:43:33 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 9BBDB5F8BD;
	Thu, 22 Oct 2026 07:43:26 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <16d56f7b-6295-4ac8-b0c9-8b490dd0d582@leemhuis.info>
Date: Thu, 22 Oct 2026 07:43:26 +0200
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
Subject: Re: [REGRESSION] i2c: qcom-geni: HID keyboard fails reset on x1e80100
 (Yoga Slim 7x) since 7.2.9
To: Saurav <thatsme.saurav@gmail.com>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 Praveen Talari <praveen.talari@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20261022033638.32460-1-thatsme.saurav@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20261022033638.32460-1-thatsme.saurav@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179264780717.786991.6323162390966845119@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 9BBDB5F8BD
X-NC-CID: USTv7n+OdDl6gBTYPyB5VZOiEv3wbKuxZ6dqVFBM8Apw6FYPRFc=

On 10/22/26 05:36, Saurav wrote:
> Since 7.2.9, the internal keyboard on the Lenovo Yoga Slim 7x
> (x1e80100) no longer works. 7.2.8 is fine. 7.2.11 still ships the
> same i2c-qcom-geni.c as 7.2.9, so I expect it is affected too.
> 
> The keyboard is a HID-over-I2C device on i2c0 (i2c@b80000, 400 kHz),
> address 0x3a, VID:PID 048D:8987, IRQ tlmm 67. On 7.2.9 it fails with:
> 
>   i2c_hid_of 1-003a: device did not ack reset within 1000 ms

Searching for this error msg on lore found a change that fixes such an
error on Lenovo Yoga Slim 7x Gen 11: 39e8e085710a2d ("HID: i2c-hid: add
reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard")

Could you try if it helps? The stable team plans to pick this up for
6.18 already, so your feedback might speed things up (and get this into
7.2 before it's EOL, too):

https://lore.kernel.org/all/20261019135441.1420968-216-sashal@kernel.org/

Ciao, Thorsten
> The touchpad on the same bus (0x2c, hid-descr-addr 0x20) keeps
> working. A USB keyboard works as normal.
> 
> If I build 7.2.9 with drivers/i2c/busses/i2c-qcom-geni.c taken from
> 7.2.8 and change nothing else, the keyboard works again. So the
> regression is in that file.
> 
> Five commits touched that file between v7.2.8 and v7.2.9:
> 
>   82339215fc00 i2c: qcom-geni: release DMA channels on probe error
>                (upstream 268aacb2e2a5)
>   139efdb3ee6e i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
>                (upstream cb97bf3d4f91)
>   6c3420d6ba34 i2c: qcom-geni: Store of_device_id data in driver private struct
>                (upstream 692e0c84db5f, Stable-dep-of cb97bf3d4f91)
>   4edab037132b i2c: qcom-geni: Move resource initialization to separate function
>                (upstream ed4b34033db2, Stable-dep-of cb97bf3d4f91)
>   fb54df3645d8 i2c: qcom-geni: Isolate serial engine setup
>                (upstream d8d3bb127ad1, Stable-dep-of cb97bf3d4f91)
> 
> I have not bisected within this series. My main suspect is
> cb97bf3d4f91.
> 
> #regzbot introduced: cb97bf3d4f91
> 
> 7.2.8 always wrote 0 to SE_GENI_CLK_SEL in qcom_geni_i2c_conf().
> With cb97bf3d4f91, geni_i2c_clk_map_idx() uses
> geni_se_clk_freq_match() to find the index for 32 MHz or 19.2 MHz,
> stores it in clk_idx, and qcom_geni_i2c_conf() writes that index to
> SE_GENI_CLK_SEL.
> 
> On x1e80100 the QUP SE clocks are registered as DFS RCGs
> (gcc_dfs_clocks[] in gcc-x1e80100.c). geni_se_clk_tbl_get() builds
> its table from clk_round_rate(), so the table comes out in ascending
> rate order. I suspect that index does not always match the hardware
> DFS perf level that firmware set up on this machine, where index 0
> happened to be correct. If so, the engine runs from a different
> source clock than the SCL counters were computed for. I have not
> confirmed this yet. So far I have only shown that the 7.2.8 file
> fixes it.
> 
> I have not tested mainline yet.
> 
> System:
>   Machine:  Lenovo Yoga Slim 7 14Q8X9 (83ED)
>   SoC:      Snapdragon X Elite, x1e80100
>   BIOS:     NHCN62WW
>   DT:       x1e80100-lenovo-yoga-slim7x.dtb (in-tree)
>   Kernel:   gentoo-sources 7.2.9 (genpatches do not touch this driver)
>   Good:     7.2.8
>   Bad:      7.2.9
> 
> I can test patches or run more debugging if useful.
> 
> Thanks,
> Saurav
> 
> --
> Drafted by Claude.

