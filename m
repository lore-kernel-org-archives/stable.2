Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826528;
	b=OjZA3hvo8dfb06IngpcHRxLbQoL8AwxSmc5NsoVnLGoRcAsAJFyYN5uFycNNqRdByc0X
	 JdDnUSUTkESDSfDYaM/IOxil9fKEIcpjirn/bzxNY6jO96ogO75mzOHbepCsXzNI73mG8
	 BlaVODgdzNqcXnnjRVbiwgWzaxRhsGEUNuG9XAaToJxiLEWOa44QgwcCAB+A1gVRZCBUq
	 faWKpyN74c8uCbyKzsWOLtGlOLm2hxCf8doT3+bdBTXaVdbBt2VFJdTrVzSe8925Tgj+H
	 CBmnsZt13wJrvQTSwzbqE+JtwAFoVjekzVnm4KearGad2njYrCwh1oMz92/Y2100POw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826528;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6PFd3kI83AuIA1Y6h+p+v4Y/1puo2Ts/ZISrLgCUH7s=;
	b=HM/f7MIBgTEnJ4LB9h6gKZVTiAaSVCT5CujABkCZJtAmMeIFg7VsKuB/u3D1XRs+GXPU
	 My+cJjl72nYs44AuqIIF4V9Vgr6aziYsOLTf3yL+mYyPPjVPry+Pv+hKmSB7lAMm6vT7x
	 QbAhobAYsjGyKm6UurgTEeOvLhOHRistlObGnJ31R9kNtpYBxGEq1C8YozaPLpzwdLazO
	 YHTXdpL/abMjYz9RtxhQHPLjmQzYLybUe466WpAxJbnvy9gwaXToidnHI/J0lHxJDzwl3
	 vfiAVFdPfi1Svs+x10N65jyEi5zz7mfUfeAGWfrxa8g7GVPgf2Ae8NTVr9b2qjjDo9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=VgiaAp6p;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F166070F1F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 21:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F166070F1F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=VgiaAp6p
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2B9A140E0497;
	Wed,  4 Nov 2026 21:08:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qFmQ2mC_Y4NG; Wed,  4 Nov 2026 21:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793826519; bh=6PFd3kI83AuIA1Y6h+p+v4Y/1puo2Ts/ZISrLgCUH7s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VgiaAp6p5G5W2EUwpiLcvxOlobm2N3zO1bgUldQpcI2bGKIciigWfmPd/6BL3bKIA
	 qroJNhSlwopS8lrCKH/EVrZR+XgvKrwBDyqN8/p7zbAnkPZlrU3ehUfzAdeYeXxeWS
	 3kBdXnmb6KwMk2sN9m2EmNSnEO5olXe5G2It3u1jvlDZngNoQV/lsI139QvwB3w/LB
	 Ldq2kr+oW8bvuLEJUN6znHnnFtuzojrbnamr3NZ33AVRollm+E82hGA0kWHZ/3iZ4Q
	 v87fqcIn0x5F+5P5wm1Bq7QlOCEAwwQCPBYvxRVptSXp33TjUkdo+MvokgFH14dVZ9
	 FozqRPjxM3+DkR7Z0zkKkn8wAVuUUzNLd9I+0VXxq/zWt6YAqIXeJG0axGH8dJ7CZe
	 IrHt6UFBPNzXKiCcr6794yrDK4W5JF0On1s4SCVzJ8ywhqyMFuBTSwWE2Y2lDoozl4
	 jPU6RwrhQemZb6PrDJtAfSfIZhaWK6NFe5zi93Cb+YKqEQTwcPEIXlz6YyMXJ7rhYa
	 iJqvAJrj9+2eM62UHGRHsCwgLn4KaD3Ro95OfYCFywaRy/knLbiY1qobzvbpYBUUVo
	 pqeGcWhnZk05AgPXa4IS/QJrZ5rNimtcjDIa8srl/MfbyYnoWCXMKT/8kkSH1z/XGx
	 vlwHo9Y9wptOx4y7VW+wtvYk=
Received: from ehlo.thunderbird.net (mobile-166-137-178-199.mycingular.net [166.137.178.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D21140E0184;
	Wed,  4 Nov 2026 21:08:35 +0000 (UTC)
Date: Wed, 04 Nov 2026 21:08:29 +0000
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>,
 "S Shaiju (AMD)" <sshaiju.lkml@gmail.com>
CC: stable@vger.kernel.org
Subject: Re: [PATCH 6.18] x86/bugs: Adapt SRSO mitigation to Zen6
User-Agent: K-9 Mail for Android
In-Reply-To: <2026110405-exporter-surfacing-9624@gregkh>
References: <20261103182143.27403-1-sshaiju.lkml@gmail.com> <2026110405-exporter-surfacing-9624@gregkh>
Message-ID: <A286426C-2D2B-4CC2-B113-7212B62CB03F@alien8.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 4, 2026 5:58:23 PM UTC, Greg KH <gregkh@linuxfoundation=2Eorg> =
wrote:
>On Tue, Nov 03, 2026 at 10:21:43AM -0800, S Shaiju (AMD) wrote:
>> From: "Borislav Petkov (AMD)" <bp@alien8=2Ede>
>>=20
>> commit ae1d2082d93bc04604dc08e9b7f9cdba5e0c28e6 upstream=2E
>>=20
>> Zen6 has BTB protection which isolates the different contexts
>> (user/kernel, guest/host) from one another=2E This makes the SafeRET
>> mitigation there unnecessary leaving the user/user and guest/guest
>> attack vectors open, whose protection is handled by the Spectre v2
>> mitigation setting to do IBPB on a context switch=2E
>>=20
>> Detect that setting and report it with a new mitigation string=2E
>>=20
>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>> Link: https://patch=2Emsgid=2Elink/20260822013231=2E1109255-1-bp@kernel=
=2Eorg
>> Signed-off-by: S Shaiju (AMD) <sshaiju=2Elkml@gmail=2Ecom>
>> ---
>>  arch/x86/include/asm/cpufeatures=2Eh |  1 +
>>  arch/x86/kernel/cpu/bugs=2Ec         | 18 ++++++++++++++++--
>>  arch/x86/kernel/cpu/scattered=2Ec    |  1 +
>>  3 files changed, 18 insertions(+), 2 deletions(-)
>
>You forgot to mention this needs to go to 7=2E3=2Ey too=2E
>
>Now queued up, thanks=2E
>
>greg k-h

Ah, thanks=2E You guys are opening and closing non-LTS branches waay to fa=
st for me :-)
--=20
Small device=2E Typos and formatting crap
