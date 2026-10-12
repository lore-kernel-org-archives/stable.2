Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F402472F8A;
	Mon, 12 Oct 2026 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806436; cv=none; b=lC5OUkckJK9xBx0IilPxNNb8n2dO6l062Oc1dw/kaifZTp3H746rahWiE/FTTPO90d5BsgFukLfIc3KLuXvQjGnLrRp6xZuEvQJkJzlqZzYCyjS7Q8iksTtQDEAOYg2CWCXuRPklaEukU5/Gn6jPaW5wqVCvsC2PBetO9OQrJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806436; c=relaxed/simple;
	bh=Ae2ZjzGNlM4lWRm1C6i6dSpH6G87tY47/A3zWod4WHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9DcQaSXkNDt+CV9uT4u9dLsdSn7O3KWJXP3DdK3RegC0qSK/S/pV4f+UhBjxiovltJH4ed7z7aiq7Zfp/JcLK0fvJCAXOetaaAHt5KGg/IC4+mBdlkA5QOc9LLFHSEzJzHcy1bZ9Y6SXH6mTyhuEJYVzPDAdmjIzkks1dOv7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=cDrEUo2j; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="cDrEUo2j"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j3GHs50ptz8F1x;
	Mon, 12 Oct 2026 14:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791806425;
	bh=Ae2ZjzGNlM4lWRm1C6i6dSpH6G87tY47/A3zWod4WHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cDrEUo2j3IxbVu6TeDnYr0vMZbDntCIK5H9kTDgnHOvVZ1hAIIhPAs6ZTZZgF+WUi
	 1Egi/SUSJUonekvYWlzsutFU60HYVPQTEM6W5JtWr4O2t+hiw370VcBpzZ3drm25Op
	 aCwuKMr02GDST9EoAt0UiKDD2opW83+ELhnce7v+d0+FIPVh39j7SaVNreWKZ1Vz2p
	 /GfZ6cCPITpEhEDjoHV7THCPN9EShj+C5SQGiSHtPR1yitO9T2QI3X9n7njKX461ec
	 z2ddN+3n1mEDiaKlNc1u8at0OWmPwO1loWbN3wFp/JAZ7MY3mZIq6paq36wnXJVLpE
	 eMEE0HSMFjEOw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j3GHs4JHPz4yKF;
	Mon, 12 Oct 2026 14:00:25 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j3GHr5XSjz8sb7;
	Mon, 12 Oct 2026 14:00:24 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 37AA25F9CD;
	Mon, 12 Oct 2026 14:00:19 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <24ce058a-28b5-4499-9ded-eec9544b80ec@leemhuis.info>
Date: Mon, 12 Oct 2026 14:00:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore working
 on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests firmware)
To: Sasha Levin <sashal@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Brangs <erik.brangs@gmx.de>, benh@debian.org
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, 1149377@bugs.debian.org,
 Salvatore Bonaccorso <carnil@debian.org>
References: <179104011040.2214689.5921682013387867802@eldamar.lan>
 <2026-10-04-1-daily-reply-0007-bt540-asus-firmware@kernel.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <2026-10-04-1-daily-reply-0007-bt540-asus-firmware@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179180641969.3230912.6735187317545536749@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 37AA25F9CD
X-NC-CID: iuK12so8o57zdtSXLt85csAaeGMWaGcO8B82m4r4y/4IcN4Z/VE=

On 10/4/26 18:29, Sasha Levin wrote:
>> In Debian Erik Brangs reported that after the update from 6.12.107 to
>> 6.12.111, specifically with the backport of 980084de4d9b ("Bluetooth:
>> btusb: Add ASUS USB-BT540 for Realtek 8761CU") Bluetooth is not
>> anymore working, the full report is found at
>> https://bugs.debian.org/1149377 .
>>
>> | [   38.138881] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761cu_fw not found
> 
> The stable code matches mainline. The failure is a missing firmware file:
> rtl_bt/rtl8761cu_fw.bin has been in linux-firmware only since 20251111,
> and Debian trixie's firmware-realtek 20250410-2 does not have it.
> 
> Marcel, Luiz: could you, or Christoph Zwerschke as the author of the ID
> commit, send an upstream revert, or a fallback to ROM firmware when
> rtl8761cu_fw.bin is missing? Stable will take it for 7.2, 6.18 and 6.12
> through the normal Cc: stable route once it is in mainline.

Hmmm, that was a week (granted: with the LPC) ago and nothing happened.
Anyone working on this?

If not: Should we revert 980084de4d9b and its backports? Or only the
backports to older stable series?

Strictly speaking it should be the former due to our policies wrt to
firmware -- but I guess most users of a more recent kernels also have a
newer firmware, so I wonder if reverting the change might do more harm
then good now.

Ciao, Thorsten

