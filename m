Received: from 4.mo563.mail-out.ovh.net (4.mo563.mail-out.ovh.net [46.105.53.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0D3563EB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.53.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073750; cv=none; b=unc3OTRHjWcuBej36W6VIkDGiUTfrWjYhFJ9be5LPWZqZMdnxjgqUTa1M8XGKtYamgtIWZhRhHVIyYApEgU2cUJSDip+ejObzxw+Yqs9gLvht6w1eIJkaGLYQIBhQIGknzan+j8F8t/T/5uGEDiGnkOfUSz6OkpkNRApmAamtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073750; c=relaxed/simple;
	bh=SQqW3vRIkopO+wMee+p+HGuzJFeS+9zxJ92hnhTL4vE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Z9Nsw3eBRxM8FMiUO5BZMsl+2GWzhacUfibiqR3avoatHvMgIQSmWIP+OyKlB6agXRgUH9uN/z11Ke/yeCGEEwFuGg6boLVO9pcNcndfzq9jHhxwZ2vHtJB9G8Se7kjqzFDuPtElStQkKWTRXZKfFlyAL10tQBoRx4Phd7ye5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trinity-net.com; spf=pass smtp.mailfrom=trinity-net.com; dkim=pass (2048-bit key) header.d=trinity-net.com header.i=@trinity-net.com header.b=VaG/sPRT; arc=none smtp.client-ip=46.105.53.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trinity-net.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trinity-net.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trinity-net.com header.i=@trinity-net.com header.b="VaG/sPRT"
Received: from director6.derp.mail-out.ovh.net (director6.derp.mail-out.ovh.net [79.137.60.226])
	by mo563.mail-out.ovh.net (Postfix) with ESMTPS id 4hpwgX32ZXz5xBq;
	Tue, 22 Sep 2026 10:04:40 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net (director6.derp.mail-out.ovh.net. [127.0.0.1])
        by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <marmarek@invisiblethingslab.com>; Tue, 22 Sep 2026 10:04:40 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.96.120])
	by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hpwgX1hzLz46XY;
	Tue, 22 Sep 2026 10:04:40 +0000 (UTC)
Received: from mailstore7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.1.8.7])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTP id 47B7F3E1C79;
	Tue, 22 Sep 2026 10:04:39 +0000 (UTC)
Date: Tue, 22 Sep 2026 10:04:39 +0000 (UTC)
From: Support TRINITY <support@trinity-net.com>
To: Sasha Levin <sashal@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, 
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>, 
	regressions <regressions@lists.linux.dev>, 
	linux-acpi <linux-acpi@vger.kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>, 
	xen-devel <xen-devel@lists.xenproject.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Stable <stable@vger.kernel.org>
Message-ID: <85435495.299101679.1790071479170.JavaMail.zimbra@trinity-net.com>
In-Reply-To: <2026-09-21-daily-reply-0001-re-acpi-cpuidle-xen-dom0-6-18@kernel.org>
References: <1909296988.289641012.1790015372050.JavaMail.zimbra@trinity-net.com> <2026-09-21-daily-reply-0001-re-acpi-cpuidle-xen-dom0-6-18@kernel.org>
Subject: Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks
 bare-metal Xen dom0 boot
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-User: support@trinity-net.com
Thread-Topic: ACPI processor/cpuidle change in 6.18.52 breaks bare-metal Xen dom0 boot
Thread-Index: K73oORQOTU57TlGFBhdBixjIo6r4Nw==
x-ovh-tracer-id: 5960514109192304155
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGW2IyZ/YhHU9dSERzRYRpzlG0d5PBjuMM0K21jz02Okjd/bCKxP1ZZRuOy/r/ltrGOr888QHzjvDzzQi0zj0e4dR+2bAR/+R5MiSycoysPZjrO4AkftF3W8vsz6sYndEZb11LXltTssTuH3cOm3NP7FMwSfLDM4TpFiRM0f8kwLKIjc1sjh1mq+V1a49WPCknOvHd+6HbFREV6QWabnMcF1iWJPn/XdJ0h2YIJrvYkDioxQiNhuucf8YCjEDugAeC6CDc9v8yBLGuRKHaDh9Y8a4rat0hJKtkf+jmC5RDEOsrwiNA929B7TyYqVi76j6YnQg/UkD3KxtM3T+NyePm/nl6lpqhjSrJb6CIlzOTm/ovxqvyM2s2w067weK8F5tLYlwMR2Q4VYJhw8iC7LtzUqXb2LH6+jU92iwCRleThQlUbC6Z0fWGXQfVKe4/w49zB011P8Ps0Iup2oL1EEdCa6P77NRQcwCybSn1jRzIEmGpOdnRHRv4ibhop54BmayavlnDMye4CjEtUYTGHMQHGopXIAm5faRbrlXNuaaotm+LIjnskpaFCxAyxdETDPsxHH6oU9AbDWl+48A9jqIizrN9dsRSHih4XBZTE8ST0EAJ+tO6BWBDGbkn26cy5ORq+weZ/21z56gDpsC6jogFYmRcUYq8kXsp3AQpEO5fC7g
DKIM-Signature: a=rsa-sha256; bh=SQqW3vRIkopO+wMee+p+HGuzJFeS+9zxJ92hnhTL4vE=;
 c=relaxed/relaxed; d=trinity-net.com; h=From; s=ovhmo-selector-1;
 t=1790071480; v=1;
 b=VaG/sPRT/5Wkmyg6O2UgpCTVF3vInOg+yIy0yxjvtzD+plqdz/3Jn8A2tgKtSc4LHHhFb9A2
 TaHW5/PY2TSRsydiH3xeLpmPt/o4ErSwqQ/dBL6rslyZnGDs5zfOTBKOuQx1dxeGg6+wTqHc6HH
 i4NejfDLPmyb8yaJHV2TSSmhLfJbbFTxt4DsXcO4PvvlJibEsebZPiZSZFWKWszTcZ/SFnE3on6
 5y2aKAVehynIDD4854CTMrOL+J7+kFigmlPlagWvJ92YgDZoMKz8t0xgKOL9me0y2n8zlWvMpG5
 6GLGQLBsnGp6ZFcqqQF64ERmSEuMxY8baALBB9axwHFtg==

I have now tested Linux 6.18.52 with commit:

0089ce1c056a ("ACPI: processor: Update cpuidle driver check in __acpi_proce=
ssor_start()") applied on the affected Alpine Xen dom0 bare-metal host.

Result: it boots successfully.

Xen dom0 comes up correctly, /proc/xen is mounted, xenstored starts, SSH
is reachable, and xl info, xl list, etc... work as expected.

So this confirms that 0089ce1c056a fixes the regression on this affected
Alpine system.

Thank you Rafael for identifying the missing stable dependency.

Regards,
Tony


-----Message original-----
De: Sasha Levin <sashal@kernel.org>
=C3=A0: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>; Marek Marczykowski-G=C3=B3recki <marma=
rek@invisiblethingslab.com>; regressions <regressions@lists.linux.dev>; lin=
ux-acpi <linux-acpi@vger.kernel.org>; linux-pm <linux-pm@vger.kernel.org>; =
xen-devel <xen-devel@lists.xenproject.org>; linux-kernel <linux-kernel@vger=
.kernel.org>; Stable <stable@vger.kernel.org>; Support TRINITY <support@tri=
nity-net.com>
Envoy=C3=A9: mardi 22 septembre 2026 04:23 CEST
Sujet : Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks ba=
re-metal Xen dom0 boot


> I will try testing 6.18.52 with commit 0089ce1c056a ("ACPI: processor:
> Update cpuidle driver check in __acpi_processor_start()") applied,
> instead of using my lifecycle revert.

Queued for 6.18, thanks.

Please still post the result of that test once you have it.

--=20
Thanks,
Sasha
