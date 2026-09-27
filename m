Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114B3C108E;
	Sun, 27 Sep 2026 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790496737; cv=none; b=dfe75tppn5u8fWAzQLP0CNZL5wcqyYvW7uerfGDYp0tKZtbXAsT5r5bKZ0jQ7Rxb44K+92PVjU7VQOrRITm+S9MeTxR6IcwPPEyP0WfbCdBIP5d/QBKR6UAF2mpyEO4mglc4VwWd8NM/LNDRWj18ZQ+fRE3HNKUPG+5pBKZSRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790496737; c=relaxed/simple;
	bh=HFjQqs1qUlb5jUYPLvjlzmH+l4FMVxII5Mkvsjb1geg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhgRAjREPO6Y7NRlJ1HfbvKE+X57+3ONTrmBjCfDUshs377F2UNbjrAoof5uk7Qj7RWB2aTCHCZnsw/gdLLYB7nPf9AHg8zxp5q3sclo8iyAv8fFZH9ENarAmnUNlNC6q3jDi99JGqiziiIpN1KfN5/d1M0Vd6LvAUbd/kZW2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HTp2pM3y; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HTp2pM3y"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hsxxM24mPz6Jr9;
	Sun, 27 Sep 2026 10:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1790496727;
	bh=HFjQqs1qUlb5jUYPLvjlzmH+l4FMVxII5Mkvsjb1geg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HTp2pM3yGps1DzctLYKb2geTD1okMCfIvwUQqe5/a01SjzD4Dlw1DEkBikoSIumf0
	 ksHJcCxqIvnurWqLIt7j3ZbuN7XdCEwoKJgFFYftPBnYYiNXoIg8gHbE6jsAKtHcfH
	 wkKJ6wWq+bHX3curcBLW3eKDjNZfsdejS8uNa060uwtyq47afr5nbIyRkfC067UZnw
	 t/ZVHjkge6J/VKN+lJE+CBExcxEiyQxUt2HFKRs8QCaHNHxdu3NGTgwZK6VAQOnMqF
	 HIOkA+0BwhwQq4lBipPJl6z6q0nWYGosw5qkykVC9RAImsW2/CFbqNxCwUX/jnNjla
	 LWbWhDE3d384w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hsxxM1NgWz4xsg;
	Sun, 27 Sep 2026 10:12:07 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hsxxL5gccz8svk;
	Sun, 27 Sep 2026 10:12:06 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 220295F94C;
	Sun, 27 Sep 2026 10:12:06 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b37bba19-22db-4097-925a-192dcf9a49b7@leemhuis.info>
Date: Sun, 27 Sep 2026 10:12:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Bluetooth: ASUS USB-BT540 (0b05:1bef) fails after
 BTUSB_REALTEK quirk
To: Niko <unknown@niemelat.fi>, linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <be59323c-d616-4ce9-b886-e1a7be1a7b7e@niemelat.fi>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <be59323c-d616-4ce9-b886-e1a7be1a7b7e@niemelat.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179049672644.3690133.11772297743812531246@mxe9fb.netcup.net>
X-NC-CID: oPA8YS2oaqPINzkjgaiPsmDXKpssukyVvLrDG8NbGzu8vGZdSoM=

On 9/26/26 10:49, Niko wrote:
> 
> I would like to report a regression affecting an ASUS USB-BT540 Bluetooth
> adapter (USB ID 0b05:1bef).
> 
> The regression appears to be caused by commit:
> 
> 980084de4d9b25193398d89a1c0430ba3501b683
> Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
> 
> which adds BTUSB_REALTEK | BTUSB_WIDEBAND_SPEECH for this USB ID.
> [...]
>   Raspberry Pi kernel: 6.18.50+rpt-rpi-v8
From reading
https://lore.kernel.org/all/daily-reply-0016-re-btusb-rtl8761cuv-regression@kernel.org/
I suspect that latest upstream fixed this already. Please report back if
not. Ciao, Thorsten

