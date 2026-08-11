Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E043FA5FD
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430200; cv=none; b=SVpQmc1mudaLc6Wbisg6XhCvpgZsAXtgr2XOvWbRcSZUytDLnz4N8waL91IWVKhL90l69tsydeiFwB1PBoIxLUAFky0SJowrRM6lXK9rDhTpaQoNIjrLi0sNrXrFMd0MsOb6R0wqOWpWN9FJ78JKLdOkvlLO4+VnWhyXaIV0ihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430200; c=relaxed/simple;
	bh=WiWe6EeRf4CKyTN5zOVqt0QukfitrwYMX2wbt9T8FVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i4/v6PP7Z85dhSnqmWJsWVvZHrc3j2AHoWj60XXtJkgYFoWiGDHCcK06H0nySbRQpXa3S+CEjfVg0Yb1jsIuJYTbdboPnclkNIBvXVSSNwh3804ur6iBadX7nUuZEQ4CWgi0B1Erennu5Dr4HwKvn1FfG8+nRWdeNDmYTLU+C0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dgsTNnbx; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dgsTNnbx"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hK22B3Ls5z49x4;
	Tue, 11 Aug 2026 08:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1786430162;
	bh=WiWe6EeRf4CKyTN5zOVqt0QukfitrwYMX2wbt9T8FVA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dgsTNnbxIn2ku/rx3/jXiMXMMORZ8F/Rk7lNiVS9GP++h7gtbwdkXySv19HsDas4Q
	 BWCz3qoeeOOMRAJ3qd5cRNVJxcXAhw9923kFbyE2WzUIgbXSResC87c2sawNjLRWXX
	 UQ8JrEROYa3Z29n/Udbbgmw0umjkh4DUqF2IyMJwKuzq9y+jn35ZolVGsa2behSnw1
	 7+NGI7TuvHNGK3E/BIpKguwxgbkJ0zCc6DmIQA+i+S1PaavugOCNwtVsBjAFZXCBGt
	 qMDC/KgWTgmv2/uzSWczVvy5nCYFYhrkYq7DAzS3Yoh0PzjhFL+FQ9qZRlf6umqHpn
	 myRIYvhzPrEVQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hK22B2cWkz49Zw;
	Tue, 11 Aug 2026 08:36:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hK2290Mt8z8tcG;
	Tue, 11 Aug 2026 08:36:01 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 633C35F960;
	Tue, 11 Aug 2026 08:36:00 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <dd683c23-5a4a-48a8-a61b-83a2a6b26f01@leemhuis.info>
Date: Tue, 11 Aug 2026 08:35:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] incorrect backlight brightness on AMD in 7.1.6
To: Sergio Callegari <sergio.callegari@gmail.com>, stable@vger.kernel.org
References: <d614b8e6-7f95-4e0e-a4ee-436fb418d883@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <d614b8e6-7f95-4e0e-a4ee-436fb418d883@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178643016063.1427935.9646677141877688634@mxe9fb.netcup.net>
X-NC-CID: WFIovUcBLV3IsQiQQAdtchNoTzM4+RMk8vY1uREqoJYv98Ze6iw=

On 8/9/26 18:23, Sergio Callegari wrote:
> Control of backlight brightness regressed with 7.1.6, possibly due to
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> commit/?id=1191285ecb4233e5bf907da7e9394d7999055566 that may be incorrect.
> 
> On this kernel when you try to rise the brightness, it does so up to
> ~95% then it suddenly falls to the minimum brightness. Conversely 0%
> gives you one step above the minimum brightness.
FWIW, the upstream report is here:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5562

A stable specifc revert is discussed here:
https://lore.kernel.org/all/9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com/

Ciao, Throsten
