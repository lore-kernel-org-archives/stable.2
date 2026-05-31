Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6BD320A34
	for <stable@vger.kernel.org>; Sun, 31 May 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780231333; cv=none; b=AAs22ha0K9/XP6IrLPspaZW3+A3BL/1hSnul7EvdL/aznjGI4FpmCUFn3sBx6LY55B0nXmKUDT14AlXaeKGj4E4Gp5rRFZvfYrphSWWfdM6chKIHwVNvuPhV6+graUdb1BGgAqzspUMi+C85bm3c3GdkL66PQxC2L/gHnW2bacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780231333; c=relaxed/simple;
	bh=pS+k3CeeXU1/L2vUay196gVe1o2FqBsuIBkN9x/+JAI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=PB7+oXZ7e425x2XKK7+kccQ1zwfNwcqzgaBaQBsgEb0NVVFkGmKXiFeA4EEk1/DRet28N9M15woOJZNRbtiCddbloss0jdUD1XU9ffxdhCqwmM3N9gU0Lf0ckP4n3Cfx5mAsEYbO0K/Hz4Dc4qnrWV29lnG8IoflNfEyZmIv78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=A45h48hc; arc=none smtp.client-ip=217.74.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="A45h48hc"
Received: from Stacjonarny (62-133-144-026.dynamicip.ostnet.pl [62.133.144.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Sun, 31 May 2026 14:42:08 +0200 (CEST)
From: "Artur Chlebek" <achlebek@poczta.fm>
To: "'Greg KH'" <gregkh@linuxfoundation.org>
Cc: <amd-gfx@lists.freedesktop.org>,
	<regressions@lists.linux.dev>,
	<stable@vger.kernel.org>
References: <002901dcf0eb$9472e210$bd58a630$@poczta.fm> <2026053159-unread-disagree-0da7@gregkh> 
In-Reply-To: 
Subject: RE: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression
Date: Sun, 31 May 2026 14:42:08 +0200
Message-ID: <003901dcf0fa$e5315ce0$af9416a0$@poczta.fm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFDUGtZMJYvTWCxG+Cy9+QRqeP05ADRSPyrAmjEVgO3QYPi8A==
Content-Language: pl
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1780231329; bh=aQxHIfR0Wt2sOg4MkPcCIB7mzg9EaFBUOuncs0GU2l8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=A45h48hc9sRiVQUTQ1VwRafd6Kuh75w372Llu0owqL1tHlxHvBoPGF3ABeRgTDaQj
	 UAjPvLnzO92AaNvUPDEZR3UtD0WsE6ldC4G12fRMAB2zF9sqZ70PjOdSbEyKhGokyt
	 4IQOnNA9Bdnn21V/HKtRYH1ElCe5K3jlGmOrXvhk=

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>
Sent: Sunday, May 31, 2026 1:43 PM
To: Artur Chlebek <achlebek@poczta.fm>
Cc: amd-gfx@lists.freedesktop.org; regressions@lists.linux.dev;
stable@vger.kernel.org
Subject: Re: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression

On Sun, May 31, 2026 at 12:52:30PM +0200, Artur Chlebek wrote:
>> Hi, I have 5x fps drop on amdgpu Radeon 260X 1GB between kernel 7.0.9 
>> and
>> 7.0.10 or 7.1rc
>> 
>> Original sparse mail got flagged as spam so let me elaborate:
>> Newest vanilla Fedora with Plasma, Gigabyte GA-H97-D3H, looked into 
>> things like clocks, PM, ASPM, tried flags, GTTSIZE, .dc=0 - all seems 
>> fine nothing helps.
> 
> Can you use 'git bisect' to find the offending commit?
> 
> thanks,
> 
> greg k-h

I'm sorry I'm not familiar with git at all, and very new to Linux. I can do
some local tests if led by hand...

PS: I can confirm that 7.0.9-205 is 25fps in Unigine Heaven, and 7.0.10-200
(or 7.1 since beginning of rc availability) is 3-5fps.

