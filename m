Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774192;
	b=0k48Imdi8PDVXy++bVmCPtatm19HV4XTN85dFBU8I+iUtgqPksxqt+8kjafPPRwrmFdX
	 jfprP9ZrQ6rrx/hN/WRARUh6ftR23dfV0slg/V2GbVjohwfe6pfg1eOQr+2foXTdiTVNv
	 mu1XOX3jjqJB2837p3fsvUTmmdJQJuYeOTE93Qen4ECrau7v0BYv+sGSCODRK9UET7Vf8
	 N4CDc+MxTwjRNcIMPMfJ8AifTH9mwUnzSvVCpZmgDwuIkPBFxzaev/hPzg4xbOP1r9OQP
	 Hjue8g/4TaAkOiCvHlQ5Q6gFOS7qhXfOhLRNh5+rpqK7bWEDrn0Cy8iORpxod3boyfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774192;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=d138w3OU+zMBOYeUvyha4apYKhCdiLkp01rdwAdMxgM=;
	b=Vv0+NjTsfeKPY2cwy2rEcVBSLWEtHEc3YJDkIyw6urUCq3iRpq7qsPcPid0o8Z7DI2Tv
	 oFurZXGQ/NqV+4lEIraacA4ANSJf/LA5DaU7pd6Bfen3WK0pfnMApwJsjmiJIEN2WxpOn
	 oY7XgAjWkPKURkKBPmlGFOxDzGzWVjH/ojWDaRE1dFxqR+mkMONWfrxleSPRH8TCLnZYW
	 IxES/jC+OmV1n2xGs2DzdBZHmeqFOTb+lCvRxZs5a5O/s2pULmDnB6oxxVP3T9QpD9OJQ
	 tTcQK+DE+BfzDXYgKJcOaBg0hCLKI1nZySzBPvn08M1/xuuKSSnMzqVvnZCKWkYkjeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jXgcHfcy;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C928606A336
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C928606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jXgcHfcy
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795774189; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=d138w3OU+zMBOYeUvyha4apYKhCdiLkp01rdwAdMxgM=;
	b=jXgcHfcyTsP1VHGhlcLQ1zCdck6rlhZlgbps8UrfIdVcFGaW2TE4/EvEnFgMGxSGNqUgNSU/MTSu8FsQGuXpC50zp61FxjhEnuIezzBDxYs6ntie7i/YKp6ftbkQ7Ek/vrWBI+vI6E+M+8JwSywAU5ZpJvSrUqMG8o22QOk1hVo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0XFXjgHP_1795774188;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0XFXjgHP_1795774188 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 18:09:48 +0800
Date: Fri, 27 Nov 2026 18:09:47 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [linux-6.6.y] please pick "31d90deb653a SUNRPC: Don't retry using
 the same source port if connection failed"
Message-ID: <awlW6x7u9T8bfG0i@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
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

Hi Stable team,

Can you please pick the following upstream patch to linux-6.6 ?

31d90deb653a5c34d8d648b8a1b459b929be1a73,
SUNRPC: Don't retry using the same source port if connection failed

We have encountered the bug in our production, and confirmed this patch
fixes it. And the patch apply clean on Linux 6.6.

Best regards,
Dust

