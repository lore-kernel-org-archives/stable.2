Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765564;
	b=x/Il5ZbQvvyQwb4XhANBl6FKzJVNcA9UrLH41Aqnfid44lSCj3R5rlJ9x2YJnUty3PqP
	 AFAL2Y9MNtR/XfH4Pcbpy9MXHlzDGdqhAXDsd+ByeZH1sVY091FTbLdNizQOhIDUs0HCM
	 P8X6CBzjPgyaddSF3btUti9ChUAuqsF//LvKowihDLOlfFkaUpPG2GTHdyMNvndPsuiyN
	 GU2QkBaaofBGI0gv5UmJsZG46JncPzuMJaR+B9+mMyqgT2mln0CIM8tTiWkwf5kHgGpgO
	 K7RPYxO92Fvw37AeWfmVrmCr76+HxHu1/uad7BmLRMwKkFf5bhmbfTHqqMk0T9hNGIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765564;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=60/T6+akL3zw9Tl0SMa78bohTXbd4Uco2RW4UlB8Nmw=;
	b=QFlq1L2uPXQ+zttZDCchlJ/1LgfVedGQOPZVdac7t8FccGADbiC2knXksWq9oYi5Ord2
	 nEbQxvTcIWOGiYQiKGwH+nB6jlKb71Gku2bJ7rawFFUi4tFLTR4E8j7PHB45BS+5BDiX8
	 cd2Xuvqsl6Zx6wrhIRm/RbnioPhjKu+Fxadu43sv4artF4huO6s+F2mYfKh675wwzKlQ4
	 hBrGMpdiQKh/dSEAHPlupZxLR9QaNRTmNF88lG05eRCQyfxao/e9QOKXhJS4njh/WomML
	 2ncEXs8+b5oCwT/njX0w9mBig5NmKSDMv5SRIiFMIKax2Vf8UtvqLCkjnMiWt0iDUQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=lkg1fSGQ;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B74606A31C;
	Fri, 27 Nov 2026 07:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12B74606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=lkg1fSGQ
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0E74D14C2D6;
	Fri, 27 Nov 2026 08:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795765562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60/T6+akL3zw9Tl0SMa78bohTXbd4Uco2RW4UlB8Nmw=;
	b=lkg1fSGQaEiD11F4o2d9A1BE98P1ZnmYkxDCY8+bC07INXVVo2YYFxWTctLVs7n9I52aDn
	Q03YL8QypxcVOoKseUmqC3HAcDbPZBF7PHL6T/oEPEQ33KTQKRo5BIGfDonMPXNCZVa8bf
	vWY7uJUJr65c7zTK9/eXhqEjgePZl8vfFn0K3CSzeAR8oHtBHNX/JjpRp99CGgCcbfsf7V
	kroHlVSUnLtlbE38bWTwpM2PMZ7oeRfa1yOFcEr/EWj+4zCIDTsI+B9RR81AnZgBfj5wxB
	RKVTBJYZnODzqB5UN4A6rvG8aPbzAeCvGHyw/vp8rLudQWVjcM9JcJhCWE9CFA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9d6bf9f9;
	Fri, 27 Nov 2026 07:45:56 +0000 (UTC)
Date: Fri, 27 Nov 2026 16:45:41 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Edward Adam Davis <eadavis@qq.com>, Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org,
	"W. John White" <whitewj-debian-bugreport@outlook.com>,
	=?utf-8?B?UMOpdGVyIELDoXRvcmk=?= <batori.peter@gmail.com>,
	Mael Bras <mael.bras.ext@idnow.io>, tycho673 <tycho673@gmail.com>,
	hanta <hantahrabal@disroot.org>, skiwithme <skiwithme@optimum.net>,
	Suvam Sen <suvamsen2004@gmail.com>, Celimar <celimarj@gmail.com>
Subject: Re: [regression 6.1.y] 967473b1e8bb ("Bluetooth: L2CAP: Fix
 slab-use-after-free Read in l2cap_send_cmd") causes backtraces and
 non-working bluetooth
Message-ID: <awk1JT1VMzHDecib@codewreck.org>
References: <179567271700.947722.15185762256491350563@eldamar.lan>
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
Content-Disposition: inline
In-Reply-To: <179567271700.947722.15185762256491350563@eldamar.lan>

Salvatore Bonaccorso wrote on Thu, Nov 26, 2026 at 07:06:59AM +0100:
> [   40.687744] list_del corruption, ffff8a27c10efe80->prev is LIST_POISON2 (dead000000000122)
> [   40.687829] kernel BUG at lib/list_debug.c:56!
> [   40.687865] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   40.687900] CPU: 2 PID: 893 Comm: bluetoothd Kdump: loaded Tainted: G           I        6.1.0-55-amd64 #1  Debian 6.1.192-1
> [   40.687960] Hardware name: /NUC6i7KYB, BIOS KYSKLi70.86A.0051.2018.0110.1800 01/10/2018
> [   40.688002] RIP: 0010:__list_del_entry_valid.cold+0x4b/0x6f
> [   40.688574] Call Trace:
> [   40.688594]  <TASK>
> [   40.688614]  hci_chan_del+0x18/0x90 [bluetooth]


This might be fixed by commit ab4eedb790ca ("Bluetooth: L2CAP: Fix
corrupted list in hci_chan_del") ?

Ah, now I see it even has
>  Fixes: b4f82f9ed43a ("Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd")
and you're reporting about this very commit, so there's little doubt..!

That commit got backported to 6.12 but not 6.1, there's a merge conflict
but it's not too hard to resolve, I'll send the patch since I've done
the work.
(As far as I can see it's not queued at this point, sorry if someone
else has also been doing the same)

-- 
Dominique Martinet | Asmadeus
