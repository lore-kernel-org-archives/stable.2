Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01942F6577;
	Mon,  5 Oct 2026 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225167; cv=none; b=LDbWuZ3piNluZunxqfH6nUtX1i8a2CRNlQgBILaqReNigHMU/+uvVYeETfFGnMFBmXJ7eTYIGPanpxihtNv/JZ17kkxiG7kfFyt8ZZbg6oOKlKfDVU5vZiidkADVlL7ALWQtoZGHMUpWdCZLAczozB0419dcE4Ke+rOSz+8N7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225167; c=relaxed/simple;
	bh=+hBrr0HkYXHqeOCPgkwRw3lfcZcNYw+0URKhBsQ+Jas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlHTswyiRR7L3sMvpSZXMcbkaNwr5shdASia2DSWJ5ciCJ+gKd/QQru/jpRSSTc4svJ/wGobvz91o0O4puf3j51Rd4WhBFXsw8Ej6Q1tQzzM07qnDY6vGeRCKXLbqRLMvEwuiEUUZaVnlrsDjMgOfMql6U6tcmzg76R70IuVmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=TsrNtnyW; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xmuQWDLd; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="TsrNtnyW";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="xmuQWDLd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791225158;
	bh=+hBrr0HkYXHqeOCPgkwRw3lfcZcNYw+0URKhBsQ+Jas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TsrNtnyWAmofhalYsFpLr34B9iLk7tg8lTxiN5GGC4t/q2R7TufOk3Em4EtNigaK5
	 jCLkWEZftrM3sRrMQApiKEgGLqAt8jbYEo8EEbIGJe2JVwDgroMJ+TC2gQzm/1dyOc
	 FBEK8dhTw+U0ndv37NSccYQYds91Atj29SKA3gjswHabsZH6dQyc+Al0PY3b39OO5Q
	 sFEKxEYPfhs4yfb4YLqTyCqSmwu1nmUSkBRnEX0fTwl4ZNXbAx2JWcpDrQ97jS3Aew
	 310nhLuvlq28anV70bqJr/M3UWZ0xiKMcnR2DdaKSdJILiM319sySo/U+XyerukqBG
	 9q9Yvtfdpq8Zw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2F8B24857E; Mon,  5 Oct 2026 18:32:38 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791225156;
	bh=+hBrr0HkYXHqeOCPgkwRw3lfcZcNYw+0URKhBsQ+Jas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xmuQWDLdyfF1lK2GDEk70Zm45U4yQHlevj8aODZgK/B7GrP5cXXR2xx1d37HAXn5U
	 fey6KD6xI35GwG82lLBKvHP6+Eqg2JTzzMcV99g9pzNjO/S0eB8uiy1MdfBiB9W/jd
	 D8v+ENdaL9twEExrtu05K132n7NDA8fAUs71RjXZAWDX6Za9jlXfoKRUM8kcy5MCw2
	 MS3D4K/2fNKf5T9bFEIs88ijlfdqbNLFBZaTQkx64fmKVO5BdlOEif9UISUZ/WYJ2a
	 FppHJXaCyCuadaESF6zi7YW7mOD2kEg4az1Ls0Y/2OZhtH9KsSqawg1jO6CiogC1Cx
	 SuYmqeEMDGAJg==
Received: from [192.168.2.51] (p5dd1ed09.dip0.t-ipconnect.de [93.209.237.9])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id CB80248356;
	Mon,  5 Oct 2026 18:32:35 +0000 (UTC)
Message-ID: <ee122a12-eae8-40a6-bad9-086228ae76f2@birger-koblitz.de>
Date: Mon, 5 Oct 2026 20:32:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
To: Linmao Li <lilinmao@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Chih Kai Hsu <hsu.chih.kai@realtek.com>, nic_swsd@realtek.com,
 Xiangqian Zhang <zhangxiangqian@kylinos.cn>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20261005105249.1281648-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linmao,

On 05/10/2026 12:52 pm, Linmao Li wrote:
> r8152 detects carrier from PLA_PHYSTATUS without reading BMSR, so
> BMSR_LSTATUS can still be latched low when the carrier comes up.
> Since commit f6f2e946aa4d ("net: mii: Fix the Speed display when the
> network cable is not connected"), the first speed query after link up
> can then report SPEED_UNKNOWN, leaving NetworkManager at 0 Mb/s until
> the next carrier change.
> 
> Use BMSR_LSTATUS in set_carrier() and rtl8152_runtime_resume(), so the
> driver consumes the latched link down itself. If the first read still
> reports link down, the next link-up notification triggers another read
> and brings the carrier up.
> 
> Tested on an RTL8153B with a 6.6-based kernel. In 5 rebinds and 6 cable
> replugs, the first read returned LSTATUS=0, a second link-up
> notification came about 32 ms later, the second read returned
> LSTATUS=1 and the carrier went up; NetworkManager reported 1000 Mb/s.
> Runtime suspend/resume with the link up did not change the carrier.

I have been trying to reproduce the issue with the following adapter:
driver: r8152
version: 7.1.8+deb13-amd64
firmware-version: rtl8153a-4 v2 02/07/20

But I am not able to do so. Both after a link-up after a plugin event 
and after a system resume, ethtool always reports that the correct link 
speed and state. Could you explain, what you actually do, exactly? Or is 
the wrong link information only there for 32ms and I am just too slow?

Birger

