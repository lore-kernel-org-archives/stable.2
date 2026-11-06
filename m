Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977526;
	b=AMXp+GwAS1YgOt7SMZSIwNg1tKT7FqmtcalXraqSSJdQdOT47cO9/AKItpwuhT7yIavJ
	 eBq/zez9VuYdr8h3O27YZYvsjmQRjTI9eYyu232f2XA/NvqxiNKMPLNL0yDZGyAIuoycC
	 F7VOly/np+wfaJ/FwllFJfQe9sP2ndqBqxgINNlZlC2X5BT12nd9y8EVkcRSeUeb8tQfB
	 Lbh6A5SO41AHujLxweQegtL5sFa/REBG3QiUmyvFrR7qw/nBOFxxAvpxRWNklVhHxsn2Q
	 4rggP0/sLVAkJ2GCCzNiu61gO0SknLXgt3CSov+qzlrvgw9pTccxmzn2/P7tZtTgndg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977526;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=tWIw7GbbZmwRZyzRRDz9wqzLXFMD+qm3Vi2BTvOrqMQ=;
	b=q6gBTBcLtMm9TOGnXNI4Uw6KlajRYz3OUpSAJsRVMH7en8xyzMsjI3jBCqa7Xmq4/vP0
	 jcP5v/cmzaJSEGUsnRKIHBOGNMpGVgBnfGcoemLmP3J5d/1u/tlxm1Ud0ee5WVrZW4DZz
	 vPuKj0rAC+gwZquNcBfD0fkTtae+f/SYmK3Iq/jN1Fw0fxrXd9MAmHVSMBHUfaV4Yalf+
	 adwv0wdODetCOxKzkWCYcqMpNuSE1zTRlh4fpMMEcUNu0D6/aH6vFYES3o/TN0Wg2FOBL
	 kEz/sbHkOFg8GzMiAEOcYOnmlYfK2kDBkGy8uwB+aG9TejtMl/uPAciQdxMO4hzO9mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxtx.org;
	spf=pass smtp.mailfrom=linuxtx.org;
	arc=none smtp.remote-ip=185.70.43.23
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094D606A32D;
	Fri,  6 Nov 2026 15:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5094D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxtx.org;
	s=protonmail; t=1793977520; x=1794236720;
	bh=tWIw7GbbZmwRZyzRRDz9wqzLXFMD+qm3Vi2BTvOrqMQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DCiOmy+KeCLdEUAFGkNrrmfAN0ExNrQqMZe5BtEro0hVg4MqFiBFbYp067qVcRFFQ
	 RdN5IuP2VnNhRpREIkbok9nPnjTtwgRYsr6k9wEBE2KpxTRKS5a3U0IEZyDQuvRkV/
	 f9Px3DzcYdMWptLpdM8iVbRvnUWTeoTht2Rj1Um1fmAjVe39qQO7Yvu577QLUSICST
	 ygwPOxtQ56yDXA2vCPYzRjm4EIRITiQycRFOVQ1sDu9n48uIrGTTlu3QzCR2COalzF
	 XFZ/BF8LqoNKT3u7awPdHJ7fN4vEctONlSoHnJ5l9hTY/fMDIInlkotqqoV87AJnkO
	 AgvWzn0V+6C1w==
Date: Fri, 06 Nov 2026 15:05:15 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Justin Forbes <jmforbes@linuxtx.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
Message-ID: <fa6VXGlKXtuVlSLWkggGaz2OVaAuB8DLwX4RhY2VNnz_BS1U7Qn32A2ihaYdhplnk8dNpDG_4ZVV6Zs4WigyYBl-mEb1I-cmKlES5Bchomw=@linuxtx.org>
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>
References: <20261104211038.406938024@linuxfoundation.org>
Feedback-ID: 225434474:user:proton
X-Pm-Message-ID: f82d7f49348ffd00d56e54c3a72d3058a0984ed4
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





On Wednesday, November 4th, 2026 at 5:40 PM, Greg Kroah-Hartman <gregkh@lin=
uxfoundation.org> wrote:

> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 06 Nov 2026 21:07:23 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> =09https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.2=
-rc1.gz
> or in the git tree and branch at:
> =09git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it linux-7.3.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x, x86_64=
), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
