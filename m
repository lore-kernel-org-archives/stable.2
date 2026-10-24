Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873821;
	b=gDNfd6vATdwaXermzk8DSfiJorgwCrQTqx0uA5jtR7v1UFe/yKngqRYIIy5CP8iEVUrr
	 7D3+lHacTTdu6NJMGr2dxtwnINU++QsIUg+pNMhC96iOWE+d9qvApfyFec6v4RsGSlq12
	 yE3H9gDgB1dgjF9hhQxm3U++Mp5rkbNpZnIH00ZtjYqCZBBnfxnX/FiDqKvSU+RSm/QIi
	 pzji5aydfu1F+SPGWF4u84oZaz7J1c9SBgjWkZ5YqBhlXtO6XjzCtVSBkIi0WoSORW9Hd
	 fQPNCZWC9uU7Uz5mKbj4EhM6v0xDtuZJpoZ3JwLFXS5Vm8NZOSHXFGxXPs0Lwsk/Oqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873821;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=927lNsR4JfrRM6StnTic6/mHC7Xbf7bJRocywi8MrQY=;
	b=UwEvh7T+79OJviWOaisF4nb/JCfNwkuPV2GC2fAkcNaHzwsmcdRHbdCfidkNxfV84ENa
	 Kx9UVWPyTvcWRU0M7TnQ5/saxiIy2I52UH6OHD+k+s1vv/ZW1zi6EaFBFa3/HXydECS63
	 fkRKK7ZwiG4Azb0SP+f2Rcmi1/buF6MdoWuEXs+9Cv66RTkOQt2bBBGEfUgAlN4t/R49Y
	 AgUt0CFJOPhxmOi8ROCS0BKz3JgHmyyTUWDik5PLtIqmj7fwebib7gn0WqBl0sjmzan1e
	 3uKH+qOo5QuGIT9ASC4XmzWrZ3/LkuRLBXmXqa2G5UZ+6aUYvoD8Z+rAK0czHLgNTnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxtx.org;
	spf=pass smtp.mailfrom=linuxtx.org;
	arc=none smtp.remote-ip=185.70.43.20
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21174606A320
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21174606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxtx.org;
	s=protonmail; t=1792873807; x=1793133007;
	bh=927lNsR4JfrRM6StnTic6/mHC7Xbf7bJRocywi8MrQY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N17d/IrYU+4aHZVioxr2rndn49L8MvhODWPzbRFe5mzfZBoIEqkne/LaU0Pgsj+ag
	 NeoOYIihHo9UtElQD/VcQa/k6AFXe9YrirmnUGM+gUPnIRoMELXK1tn1PzwG221EJV
	 OhiRUL0aVgFHU/avdsSeR1SMGtKkGC631gnjmWVSpUCSpgxdqQqqMnVFVkXLPr/hRn
	 qFwU1I6zGKVvFdZytoUwvW2CD3aWtt8JCXhMzJZzZQB+6oTfjEgeBhKMYKsZxgsgsx
	 Q0pApo5hvUgReMliVRQNHW6AFDgZVFMoKkeJdESJt177k9tTf7LkVZZRSNmvk3LEJs
	 CiqX57FTMqesA==
Date: Sat, 24 Oct 2026 20:30:02 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Justin Forbes <jmforbes@linuxtx.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.2 000/243] 7.2.13-rc2 review
Message-ID: <kPklqauDGec1Ky9bhwYavsbiIootLwLitPj_dGqt1dluwnevCz4O5He3Zyvv2TTOa13j0ViBuSRuyent7DXGTZS5BMrU-sYlVHNY7IL591I=@linuxtx.org>
In-Reply-To: <20261024064731.125251200@linuxfoundation.org>
References: <20261024064731.125251200@linuxfoundation.org>
Feedback-ID: 225434474:user:proton
X-Pm-Message-ID: 5d4c16cc7fef0c8f749acfbf93dc1c8557222f3d
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Saturday, October 24th, 2026 at 1:00 AM, Greg Kroah-Hartman <gregkh@linu=
xfoundation.org> wrote:

> This is the start of the stable review cycle for the 7.2.13 release.
> There are 243 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Mon, 26 Oct 2026 06:46:54 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> =09https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.1=
3-rc2.gz
> or in the git tree and branch at:
> =09git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it linux-7.2.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h


Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,x86_64)=
, and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

