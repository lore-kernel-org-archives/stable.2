Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29930F543
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569594; cv=none; b=duwVFwq2WHOAF741YdhUWWGP/8RbQD2St4tJ2bxYtVvdIQqZTSasyOcy21aJQd2cjVi2HjQhYCah+pA9sFYH41vRHPPBDuyRhEEQasu31nntQYxplrZmSFzmTInB7HPWog00dP5Lk8WbsiZAkU+UV3+EfT3y9p1v7tpwvQH1nAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569594; c=relaxed/simple;
	bh=B9uLmeH+dnuzw2PxWVBIv1M4LcX/W288sHORUODHjuc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nwENlGIaUKp4rGfpjW7Sbq1j6W+rHf1g2EMkIa4P2qgGEG05nBwjjj9JXT2JZkskTf0tk4jDYkvn6uXy6aaspzFhLjkkDTH7jtUHMdM90JJYyiVlPDXdeEKn8KRg6I2YIrXgG6Wp5ESySkQiPeTqdghZMRsLV6FOM0FgQdQvVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGG4ceYq; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGG4ceYq"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-74ab6c88052so542802137.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 17:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788569591; x=1789174391; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yQpYgwKoD9pOq28LUV92Xbch9437/dA12rcderVjKds=;
        b=NGG4ceYqrRtNGjxk9nTPd99fQ4JUxxzaRQTwTnMG0mnOBAULt0S7TMEyy1KvGQFXw4
         WwJJUZlcURp6NlQcqvWc4Ihyc3JPCVN7LNZmVR72ZH7dQGRMj8W1zdGYZlC+pK+OvNxE
         BF0ZcO1VmOUAtfEZH1mzPQTGsbe0Dn/wcxMv6fNcXg0VGMBFK1jhP05j0zPLabbXRpxI
         GztQOFW5MZVS2kOepgJUSGD4Qk1zvAg26oO4DCFBReCleuABAxGn7DJzWwGP2RTT3ZBA
         KUgHEck+zFNOf3KAy7lf6ykw6auLicSaI6yYYOfWcsfevbpGiY4+4jxCUrGDOWy2pCWn
         2OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788569591; x=1789174391;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQpYgwKoD9pOq28LUV92Xbch9437/dA12rcderVjKds=;
        b=aCrH1foJHkGNxRrwXpYP2KDaORJ530XyMzqBroMA/V6K8DvDP1WnAm9dX/ZytrWUd5
         DPhHY2qM/OuceXXrXM8EET60M/vBRIPyyJHi9tZ/CqlZAReoc1P1i1o53PIxszN7JV4J
         yhURJNZVLa5PiYwlaE4/mEnexl7ni5zyOJQji2fkfoF+6k2CGLas5U4ICvfHLjRVpHMo
         +83aLelwwOVHl3Mx4/sH4RvxGAx+1nG1Lw+FfcOhPpOuRnhF/NG6VgEBjugy9rKFtqwH
         U7iDEFTce3JhhPMblxpGbORgWOe090foBedNjt0/s0c5WC7X2Yx31g+a2v4M1KMzGUip
         q5AQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLstufZsiCW02aqOluk90SV6OQC2t/8StNPHC4IxFu5QBvyV5A2RZBZlqS7GoA33d1CGDybCc=@vger.kernel.org
X-Gm-Message-State: AFuF++m7iNhh4tmopRP/reYunOSlfurJtPQwTzIpicsTA8YNc77PwQ6p
	VLIfzEBEy9elLpuB5qVvTpXM0Gw6vBvl+YpkuZk+fIiEZdND+62AhUfQ
X-Gm-Gg: AYBFou0+88h/ASgyIKm5WqKnvIVfuZGTIwhmiwjynua2HD593gquxLiglgeGn8tSbea
	LVWPQD1Gaza480gtrO6daUtv6N0ZS847/0caDwYlKxcSPigrQklP2wJ/+k+CV8/vdTpWIYXDqd3
	Q5ZfotMmiL/ndImR60r7Ljha94Nn00kUK7jl0S3LyJiEABkmsDpwTmP87Kp1dDTf3+ZCb2/Ypka
	BUoZWRZGPwHYc4XW3t4y3vjE8saZ8EQjrUmuvFo7JvtXFKwD0zT3OEZyJsz5xOFVLQiRXaT7byd
	tIqtaLVSpvDY8STy3sznm0NlNdQsxwY10DCKs4+wjKg/HOf/Fa1B48KoS87aDZLKeWKXk2k2bD8
	wc3VXHrjHCI1ijiDpoK3EUsnTRxjBJrWus23wyzYTc46+Dfas9eDPPdQpG1ZLWln0xrym7NY1NJ
	Dm6PJF4Zqgn/Ol2Vw7zEpFCIUOz7WLrzp8EMj6HJAMOFFvrZk=
X-Received: by 2002:a05:6102:e0c:b0:778:721:53db with SMTP id ada2fe7eead31-78a4a4ca11amr2875243137.0.1788569591521;
        Fri, 04 Sep 2026 17:53:11 -0700 (PDT)
Received: from localhost ([2800:40:44:f1f5:f400:4c49:91c1:9905])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47ae301fsm2932476137.7.2026.09.04.17.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 17:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 21:53:07 -0300
Message-Id: <DL6Z05M2G2LP.2OVU37WYH5R3U@gmail.com>
Cc: <kuurtb@gmail.com>, <ilpo.jarvinen@linux.intel.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: alienware-wmi-wmax: Do not enable G-Mode
 for Dell G-series
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Lewis Clement" <lewis@lewisclement.nl>,
 <platform-driver-x86@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260902074053.59910-1-lewis@lewisclement.nl>
In-Reply-To: <20260902074053.59910-1-lewis@lewisclement.nl>

On Wed Sep 2, 2026 at 4:40 AM -03, Lewis Clement wrote:
> The alienware-wmi-wmax driver auto-engages EC G-Mode (Game Shift) for
> Dell G-series laptops when the platform profile is set to "performance".
> On models like the Dell G5 SE 5505, this pins both fans at 100% (~5400 RP=
M)
> permanently on every boot.

Hmmm... This seems like you are trying to fix a userspace problem by
patching the driver. What is preventing you from just not selecting the
"performance" profile if you don't like the fans spinning at 100%? With
this patch you are promoting balanced-performance to performance so you
*could* just do that in userspace right? I'm pretty sure Tuned can do
it.

I actually do agree that fans at 100% can be annoying, but that is
subjective. In Windows pressing the "G-Mode" button selects the maximum
performance profile and ramps up fans to 100% too; this driver tries to
mimic that behavior.

>
> Fix this by:
> 1. Setting generic_quirks (gmode=3Dfalse) for G-series DMI entries so
>    selecting "performance" no longer toggles G-Mode.

You are removing the G-Mode profile for every G-Series laptop. As I
said earlier, some users may like it and some may not at all so it
qualifies as a regression, which would not be acceptable.

> 2. In awcc_platform_profile_probe(), mapping PLATFORM_PROFILE_PERFORMANCE
>    to balanced-performance when no dedicated performance profile exists,
>    keeping the option available with sane fan behavior.

This is a completely different change that would require a different
patch. I'm not exactly against it because of how PPD usually does
things.

Do you know if the AWCC app in Windows does this? Does it map
"performance" to the balanced-performance mode? Not that we have to
follow everything Windows does but it can be a starting point.

>
> This mirrors commit e2468dc70074 ("Revert "platform/x86:
> alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1"").

This does not mirror that commit. That commit revers G-Mode because it
has less performance than the plain "performance" mode. Does this happen
in your case?

>
> Fixes: 202a86120590 ("platform/x86: alienware-wmi-wmax: Extend support to=
 more laptops")

Not a fix.

> Tested-by: Lewis Clement <lewis@lewisclement.nl>
> Signed-off-by: Lewis Clement <lewis@lewisclement.nl>
> ---
> Tested on a Dell G5 SE 5505 (Ryzen 4600H/4800H + RX 5600M, BIOS 1.24.0),
> kernel 7.1.10 (module built out-of-tree against the running kernel):
>
> - Before: fans pinned at ~5400 RPM on every cold boot with
>   profile=3Dperformance; cleared only by suspend/resume.
> - After: fans normal (~2400 RPM, scaling with temperature) with
>   profile=3Dperformance; survives cold reboot; "performance" remains in
>   /sys/firmware/acpi/platform_profile_choices.
> - Also validated the intermediate gmode=3Dfalse-only variant (option
>   disappears -> tuned-ppd write rejected as EOPNOTSUPP), which confirmed
>   G-Mode was the only fan-pinning path.
>
> Cc: platform-driver-x86@vger.kernel.org

You dropped this Cc.

> Cc: Kurt Borja <kuurtb@gmail.com>
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org # 6.15+

[...]

Can you email me the acpidump for this model? I want to check what
profiles are reported by the firmware.

--=20
Thanks,
 ~ Kurt
