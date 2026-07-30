Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E015369D57
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404003; cv=none; b=rCxJDrP6szXrEGQY84flmsUb944BKYUwhHk/PEDkeSpaW6N5kLAySvuxYcPVyVXpbRjjG45WSxCQoG3PgEdT/YJi0hNQQ44ZhRjNk1WNOU/awoGkLKDVZan9Mm+zVcSmXpv5xOSD8QkS05/T8uEqUfzcsNrQKjpCxzXNOrhi09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404003; c=relaxed/simple;
	bh=iYMHnvH0OKGCDdTGrzlI3yhg9p5eCKTm9i6oNiNLpdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVVcQ//bxidnR/ucx+jT8rSKTXyStus4pbpqA5RkuLSGQ3dkfOTdnokE+KDqwZtpnvfHKcCWwri6iJn2VTDErcutIaRYqu372nncZ4eoVUl+fs8o9yt5Uwr79AosENp1pcnBGUyYIWLSNzZT1C7DskBDNZj48rmBEjiN9PAAGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV2SQfnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV2SQfnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ABF1F00A3A
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785404002;
	bh=Gwcd753fWtAnlelFtxkponYfNiVbGFQihpYN8RGz7/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YV2SQfnkPi6irvwjs+pOtcroloDKSb143fkoSCOg6z9dPw3qOhgjnY/dGvVQHhGiF
	 KFoSHm8qMrIisiHc0ce+faONel1+7Kjuxqj9XroP3UQ/GVel/lZteKWZs8Nx1eZ9RJ
	 UW5XzVj6R8awhVdr2QTvCazgQ2e2NZWw/x03w0qv8clpJoarFBtuUUlBzaclv/XkdO
	 WZSNiqaWqisoPfPrL6jL/IHz1pWBsgEyA772pN/US4owzZbwSPQ5LQDB8HmVT5Apze
	 Q01wtJuWOZrfHHcq16kR2AtewkCLdNRb/AIaavT4iSPbYk01L0/3ousdgsSRPJNl56
	 SQ4ruZ3eXggeA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2405142e87.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:33:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqJrzSlvOSamvu+KSGgODn+fkD2cWnSTUNUtZt7DUdh1ByJ1AbPPvqcTic/JwPBpNhM99mulCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqoKEbZJcmB65nzfXXx/18/gJE9Kr1W1JSdCPsBwCaJtrwd+E
	7yBiOBhna6OD9cpDCEc7Haj2nUuWnpS1m6EOjodLQF1jOhJSR4GT/82UayeM1QE3/l2sTgCFVLJ
	FIX2Ak+hWND1XFFB3KWTX78jhkl0taFg=
X-Received: by 2002:a05:6512:1384:b0:5ae:b24c:7723 with SMTP id
 2adb3069b0e04-5b2db34f426mr409984e87.17.1785404000537; Thu, 30 Jul 2026
 02:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cafd8af9-c6e9-4bf2-b496-23e796fbc9a6@linux.dev>
In-Reply-To: <cafd8af9-c6e9-4bf2-b496-23e796fbc9a6@linux.dev>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 30 Jul 2026 11:33:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hWDKHXO5d-rgp_TMiS48fHY-cTxf5r5rGg2eBNpNtVig@mail.gmail.com>
X-Gm-Features: AUfX_mxpk7wOb3Rn1IIPdkmSayC3zS-sp0NaL-oKcv7EWugBomcUesiy2CrmkiA
Message-ID: <CAJZ5v0hWDKHXO5d-rgp_TMiS48fHY-cTxf5r5rGg2eBNpNtVig@mail.gmail.com>
Subject: Re: [REGRESSION] thermal: per-zone hwmon names break Steam Deck fan control
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: regressions@lists.linux.dev, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, 
	linux-hwmon@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2026 at 10:50=E2=80=AFPM Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> Hello,
>
> After upgrading my Steam Deck OLED to a 7.2-rc kernel, the userspace fan =
control daemon that I use stopped working. I bisected the regression to d63=
23469bcfb ("thermal: hwmon: Register a hwmon device for each thermal zone")=
.
>
> Before this commit, the ACPI thermal-zone hwmon name was acpitz, while af=
ter the change it is now acpitz_0.
>
> The device profiles for fan control rely on the exact `acpitz` hwmon nami=
ng like the below code snippet:
>
> devices:
>   - hwmon_name: acpitz
>     nice_name: CPU
>     max_temp: 90
>     temp_hysteresis: 0
>     sensor_name: temp1
>
> So now, the profile fails to load with:
>
> fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
> fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
> fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
> fancontrol.py[40528]: Traceback (most recent call last):
> fancontrol.py[40528]:   File "/usr/share/jupiter-fan-control/fancontrol.p=
y", line 606, in <module>
> fancontrol.py[40528]:     raise FileNotFoundError("Failed to load hwmons =
after 10 attempts.")
> fancontrol.py[40528]: FileNotFoundError: Failed to load hwmons after 10 a=
ttempts.
>
> Because initialization fails, the daemon never enters its fan-control loo=
p or writes the requested fan target.
>
> This change was also backported to Linux 7.1.5 as commit 996957016bc1, so=
 the regression is present there as well and has led to a userspace ABI reg=
ression. I can look at accommodating the change on the userspace side, but =
it still seemed worth reporting as a kernel regression.
>
> Thanks,
> Matt
>
> #regzbot introduced: d6323469bcfbda91f0aa89b7b39ad45fe822ca5d

Thanks for the report!

I think that commit d6323469bcfb will need to be reverted.
