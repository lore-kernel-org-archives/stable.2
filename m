Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6EA46A5ED;
	Fri,  2 Oct 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945940; cv=none; b=q/uAkDlLfcV2djyN6SbrP4m6D3FQUfv5w/zaUdft/5ilOIHobUWnbi5hZax2Y3Kc9kFDskFRJD4gwkVrgo9MXTR6nxu6Fp5g7977rS3zhvp+UhOYrp4jxEMZYNGRIN2C3AZwhBQIiBCDYbztKI5Ga79/7SrRuVdOIB5Q6rHWo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945940; c=relaxed/simple;
	bh=eDlED5ew6H8c4ZWJY0EHaZYMLLSwvyeX18XvQ6ajX1E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=u7qjyZdgCrc/0Fj33gVOjMuXgf2ClUR/NHm2nTCl0NaDlUFSOLKHbdlsU5Nl/3dycmIlXrx3MBWuzGiorxkvmscMNx6LUPLdhD3aWZoi0D0Xsd4HWlMvK1qpjwr3LP3MtuOqJpAKf3MX5CZO3+tx74f3kcIar97nt1/+PrtNOyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=NcKN2MyW; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="NcKN2MyW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TwORAxSGg+yvhJp2lHAg2JjKNw9fRngBXpq+v7zbc18=; b=NcKN2MyW5Oh3nt35oVAh/KwhVN
	WK4oGLSi/earH9N96D7rySm85FSGg60bAE3sSQ+8xUoskIzjQGCXPScyJHHdH2xglWoYpDYchIg8c
	erWxNUBbTpZLSlIsR3GNWjiVYMthHmUA1iCdlSYl7raN/mH3/9CYjxl9jup4rIBzGKjouLleUL9Kt
	Xx+7l5jmfm11BN0Nl7QzXLYi8SjTLiZnhLbSe4fLkh0PrFx58LVShxiaDnKJIZU7lVhoNz8GNVF6Z
	762R+fSKY+wMvnL993oo1N/TXKo78IcmPRc7bkxcV/DjSkkDIxQfTL4aVqRoSQQ0tnR/am74wkrot
	8WhV+qKg==;
Received: from [::1] (port=60642 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xCcqq-00000000dMA-1Zsr;
	Fri, 02 Oct 2026 14:58:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 14:58:56 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jon Maloy
 <jmaloy@redhat.com>
Subject: Re: [PATCH net] tipc: protect received keys from concurrent flush
In-Reply-To: <DU4P189MB375051910F8C241624FD6E93C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <DU4P189MB37502D602C60A78B58AFDDA1C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
 <df6d6c550f8e7ed7bad690ae9c581645@oss.cyber.gouv.fr>
 <DU4P189MB375051910F8C241624FD6E93C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <75be117cb8f1ee8fd19ceba4181b6ff6@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-02 14:50, Tung Quang Nguyen wrote:
>>>>  [   12.986077] BUG: KASAN: double-free in
>>>> tipc_crypto_key_flush+0x401/0x530
>>>>  [   12.987937] Free of addr ff11000002268080 by task peer/112
>>>>  ...
>>>>  [   12.991938]  kfree+0x163/0x430
>>>>  ...
>>>>  [   12.991983]  tipc_crypto_key_flush+0x401/0x530
>>>>  ...
>>>>  [   12.992152]  tipc_nl_node_flush_key+0x174/0x210
>>>> 
>>> Please update your changelog with decoded stack trace.
>> 
>> You mean the full trace including the parts I snipped?
> 
> A full stack trace would help me track back the calling flow. Of 
> course, your need to decode (e.g, +0x174/0x210 to line number etc.) the 
> stack trace using:
> linux/scripts/decode_stacktrace.sh

Thanks for this advice, I never used that but will tkae a look.

>>> Do you have a reproducer ?
>> 
>> Yes, I have.
> 
> Please share it to me. It could be good to run and observe if there is 
> another stack trace based on different conditions (other concurrencies 
> etc.)

No problem, I will do that shortly.

Regards,
Jérémy
