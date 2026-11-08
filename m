Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181512;
	b=j1dRl9tFcR69ix3eojAGEh0BA1776YjUI8FArXxVs+5/EBKJlGSSJG4mNfJrqCO5FjDv
	 S4gitcNEphlM31Up2f/D2TalCmbAKZjOYk5PqCKRrulpbT5fXdVyS3XfKzNfkwsDHO59K
	 lK6vCiry0h5SWq41ROvDYnsXPGW/RVsRqxDat5F6sH0wgpp7XqcpNIbhtzAM36GpNYYvn
	 Wy+qz9kA4yc1muizY5UWWr8gDzPHbCQRD7owR15ChkH5/DoTm7DgNaeamyZ7t3ciLV547
	 Gi9MF1vBkXf46yQ9Py0/UQjEXsiBv/9BRQPSPGJreYI11oQP4EwtA+6iCxdKtZ2/OGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181512;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=VikSRRRNpdKJE0WF6UFdQBJodvSbYqajLrXcSX/fVls=;
	b=R2QkvfkTaJkGxc8IFL2/juKnXjENeNUNzAPPwfYaoNVX7z4YWn6q5RrFYh0Pss5kBhlr
	 DbE7p1jvRvA8wPdfkKxGm2eEtvJdE9HfqtJOw9eafNE8Hvj4gihHYTxZku0kJzccy6Vdb
	 klfVn+YK/uBzh0yqM4tHpZvQOjM6LWwElVrV5ta8b1saJlw+gsly/LokJyeMr2it2HiaV
	 j26uhAvGZAFtk0MIlbeNavk8ypPDx91p8LfHSI1yTmllkkHKKLNYdmFZI7Q2aMFn/Tt5x
	 TquJFEm5GMKyWZgLJwHtJ+MDpjM3SPIwrVVihYI9m8TUjJPdkJkQIbO+O7yW+RsT/uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxtx.org;
	spf=pass smtp.mailfrom=linuxtx.org;
	dkim=pass header.d=linuxtx.org header.i=@linuxtx.org header.a=rsa-sha256 header.s=protonmail header.b="o0zIiT/t";
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214D606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 23:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1214D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linuxtx.org header.i=@linuxtx.org header.a=rsa-sha256 header.s=protonmail header.b=o0zIiT/t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxtx.org;
	s=protonmail; t=1794181507; x=1794440707;
	bh=VikSRRRNpdKJE0WF6UFdQBJodvSbYqajLrXcSX/fVls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=o0zIiT/tiBwjSHE7zGKqqHB6XIuIsQSY3I1aU6HJmdyW8KD1Czpcev33me2g9BD0E
	 zLGmcUOqUTrZiq11hrBzYbGQyqGDzGBF8321xmCfkla/nfwfpejz1zjb8df6nn2Wo0
	 dk278k1osBlJ/nxNCTdz8axmy2FkXaY8TVeiJ1ewVVVuDP7XZaJACASU4pl3zKqzle
	 i9cHBYY0/BCJyvK3M9Rr2iBPRi/VCvy9OhQA4NHTs66t6M1UZImjo74u5qkB1QsBQA
	 edMn3Fc2Sf3qerL/Vjru8HNGLYmofAWoZ3OjAcUiaGwiRMDjMJLCEm+o/IAF4D5xkT
	 XPZLlsFaMp8gw==
Date: Sun, 08 Nov 2026 23:44:58 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Justin Forbes <jmforbes@linuxtx.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/1257] 7.3.4-rc1 review
Message-ID: <l47r12UjQ37KpnSfiFLGWoj3CmSMXtXpMu6w_v110bmVBq_CvgmiSZcW-ORmp53F8G8U6dklhzsqXZEIV5O_BNubJnIl30AqXxpL7hiLqWg=@linuxtx.org>
In-Reply-To: <20261107134939.434104957@linuxfoundation.org>
References: <20261107134939.434104957@linuxfoundation.org>
Feedback-ID: 225434474:user:proton
X-Pm-Message-ID: af00ea36dc055098ae50b0bf4e714589887acbfd
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

On Saturday, November 7th, 2026 at 7:01 AM, Greg Kroah-Hartman <gregkh@linu=
xfoundation.org> wrote:

> This is the start of the stable review cycle for the 7.3.4 release.
> There are 1257 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> =09https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.4=
-rc1.gz
> or in the git tree and branch at:
> =09git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it linux-7.3.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

Tested rc1 (with the reverted problematic patch) against the Fedora build s=
ystem (aarch64, ppc64le, s390x,x86_64), and boot tested x86_64. No regressi=
ons noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
