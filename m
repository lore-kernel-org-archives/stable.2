Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714769;
	b=PQqPSuE+ocz530gCXffvan5LLvEbSvcXPuTZRdRhZDmQPGoyXbijFkli3ZUkscS4vIPi
	 n1/9MT2gRUi8gZdmJb3dDsRY5FZZ68moLUtoYiGEHOVCeLCBQdfdEsnCVauQ1RF7lwyTX
	 IPQkVav9HYE6StFIyDq4eMFtZSnpFEGrHKd3yCVTVgWNQBSNPw1yh2+BfvFwXZfxmzFJR
	 wcZETl5femhJN1PHlz1HvnGunaGcDLegVKExYsyr6LKi4gwp6OlZdsCzr/PkyzofjJDw2
	 T4fsGdJUMRUpcoEvsEdSvff24sUIC8kDBXhOI4c1YhwRyftlqmv0J4ARqMt6E8a5ozw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714769;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=vjKPx8Oct1fhU4GmmUv33pDO/iZO410ObJiapa+6LsY=;
	b=HylIQGfaNwSPxL7Qa+qhz3Av7EamaErhy+tbbSGQTDGuoKqYK2dteQI6F3wUtPTl/Tau
	 WBTlH8pOaFm6KubHIS+yPhuF84OCWNlGVFUegWyoWEMBHeD4fxKHpSymwl5nBl3crcoDt
	 ywWdu1raKpTS1hj+VgnU3jx/rB1UGbluXtlULOJqC+apBzG0o66pkM9D6+yygn9aH5lXy
	 6shhEmClwPJ10nJtIp/9S4tgmN8Hwe2ISbNJvxfj1ELfVQYrGdnL1/aembGBK0NIojXSJ
	 vWMLGMT5ngVA6HQ1gvNbYvFvAWOU32FHAIslXwlYwBb6bgSufpLVFr+Aivn6dosiZ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=p1DyyxhY;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32603606A31E;
	Thu, 26 Nov 2026 17:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32603606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=p1DyyxhY
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id AE6222002F;
	Thu, 26 Nov 2026 18:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1795714764;
	bh=vjKPx8Oct1fhU4GmmUv33pDO/iZO410ObJiapa+6LsY=; h=From:To:Subject;
	b=p1DyyxhY+A8szHG0kuJZ1T6qBOPiZnYBNsYTlSnQwjIT85yjA1xwZElY434wC+VHm
	 zjh1GSFaEAKNskWDME0lS2n5kH2vZlhQ4e+njbrssOfWmz9e/4dR62ZDvyWJ53XO2m
	 3nu88H8I0fTPTw5v4Rfa22J1Wr1PBMWYnBmGd0Mg/7QGw0+NLgHCGZCex+1uxt3JvI
	 29forau0ijMMWw6YtNPd3p7Iqulfz8flzMPc4rrMWr3wujMz+5xDSJnWyC+Vi6C1h7
	 /sliw18c7WHE9qrFDMwqa7BdIKaEeiCkgYBHZov5zdKI2CjGZVRdK+yUNZZz2xlag+
	 h2ELbeWLYtPDg==
Date: Thu, 26 Nov 2026 18:39:20 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	sungbyeongchan <tjdqudcks0424@naver.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc1 review
Message-ID: <20261126173920.GA180459@francesco-nb>
References: <20261125143822.072087159@linuxfoundation.org>
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
In-Reply-To: <20261125143822.072087159@linuxfoundation.org>

+Nishanth, Vignesh, Michael and sungbyeongchan

Hello Greg,

On Wed, Nov 25, 2026 at 03:22:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.66 release.
> There are 990 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Failure on various TI K3 boards (AM62, AM62P and AM69), during our CI/CD tests

[  477.440292] rtc-ds1307 0-0032: write error -110
[  478.374406] wm8904 1-001a: ASoC error (-110): at snd_soc_component_update_bits() on wm8904.1-001a for register: [0x00000043]
[  478.464258] rtc-ds1307 0-0032: read error -110
[  479.520264] rtc-ds1307 0-0032: write error -110
[  480.342404] wm8904 1-001a: ASoC error (-110): at snd_soc_component_update_bits() on wm8904.1-001a for register: [0x0000005a]
[  480.576282] rtc-ds1307 0-0032: read error -110
[  481.600274] rtc-ds1307 0-0032: write error -110
[  482.310409] wm8904 1-001a: ASoC error (-110): at snd_soc_component_update_bits() on wm8904.1-001a for register: [0x0000000e]
[  482.624288] rtc-ds1307 0-0032: read error -110
[  483.680291] rtc-ds1307 0-0032: write error -110
[  484.278402] wm8904 1-001a: ASoC error (-110): at soc_component_read_no_lock() on wm8904.1-001a for register: [0x0000004a]
[  484.320383] INFO: task kworker/1:5:66 blocked for more than 362 seconds.
[  484.330368]       Not tainted 6.18.66-rc2-8.1-devel #1
[  484.338741] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  484.350050] INFO: task weston-simple-e:783 blocked for more than 241 seconds.
[  484.360452]       Not tainted 6.18.66-rc2-8.1-devel #1

According to claude the issue is

commit e498eb93f961 ("virtio_ring: use shadow flags when detaching split descriptors")

and those commits should be dropped

  e498eb93f961 ("virtio_ring: use shadow flags when detaching split descriptors") [22944d517ff8]
  9dc6b944f16c ("virtio_ring: factor out split indirect detaching logic") [44b6e54e4a0a]
  4b7bf8d55032 ("virtio_ring: code cleanup in detach_buf_split") [032159f85f3f]

I am not able to do any test now or tomorrow, unfortunately. And the
above analysis is just claude. Might be correct, might be wrong.

Francesco

