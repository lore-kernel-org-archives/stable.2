Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B43E2ACC;
	Mon,  3 Aug 2026 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749368; cv=none; b=UwpX4EOe8I02Oi82sh/n3cW0tvIUihTgDArhA/Lh5F0cpAdB6dqThb6UP43HqjK50o0ibNPufgdk9Z9uaDyCE8gsMsuHQLB9gbajh90NiBIdkyQffGz+/Irr1eUBqy13ryG2gwtsgm93Pykzkftr6Z8BTu56kAwYS45akor6ysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749368; c=relaxed/simple;
	bh=9YB8gJOBnh/PS9HjpC1FdOPXC2Noq9SrGEL4YuNc97w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tXeFZWuTgYUqODTJGARYLvaa5+wFacbAAJchmw1hCESHjpbD76PQHmgkM3Vp2Q+BIOtruvjc/yHthI4qaeSrXuUGgcfJFmYqqpcAb2XFIE8zm+s+WaIO5wX5uVHY3R3SlRLtjIMcd9G9Yx5JA42sVJHPmV40d6HJHA9iyI+EBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=g32kWAwK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9mBy7AQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="g32kWAwK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9mBy7AQ"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id B37EBEC0104;
	Mon,  3 Aug 2026 05:29:13 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785749353;
	 x=1785835753; bh=AGnXisagUBCMHvAduuViOBTJzbb63Ysphd1oJ9vmg04=; b=
	g32kWAwKv3/jrNjwnRo3QFIN+SytHY1SQFoqbL9x/u8i6lRYYOlFZfmXklYFpFcn
	TF/oK4jFFAdm06Gp9+vlCa5maHh0KbdHQm43D3P0avQ0+tmO1jHkuxY4/m5DAaEi
	BMvStwIK0ZZPEDTUblCkFeKwsOXrz38Zb997wSpu2YU4wobabJ/ynmqQWg+un6eV
	53G7cSo/HmBGJpK8CTfFo0IZEfqBdWcDw+naoK6NptNdeo6BleNSxdenbYYwjkWX
	p8B7TOmun8sn4mJ53vMsKa+KB4KW39Dx44hMeN3ahLbuggrScZrfLvi9aZdYYfOw
	VFg1QeuTrzlRB8xKkjVT4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785749353; x=
	1785835753; bh=AGnXisagUBCMHvAduuViOBTJzbb63Ysphd1oJ9vmg04=; b=F
	9mBy7AQjWoqTYAuYbjaZLEbvaLqEQBFsd/CzqrmFhgwbK9fVE76m3xtK2B+OiUvl
	JIYrhWZCh1SPDndLncOg6cGxaHOP9g02XGDqoRM8+kOLdqXEVS7hP0VXxljZa02e
	kS1A4LI3MR4QTnEF6OilOtuhyfRQe5BOACRLRWEk05A+oq1suelXsT5EtoDuRL7V
	6T4vi1OCI180sNpLnZlJmSY7qLANtEaoHEtqvrSU1beaUUydtebwQ4jl3LLRFDKs
	6sKHriAK6Kil53ctColZxHmQNGkg0uV5mdMgmgr3e6IRaUyoQjz6kOp1Sas4AgRL
	3MeKsLujq53rkAXoxz8jQ==
X-ME-Sender: <xms:Y19waiOjHpLH6Lar-Yne4IeJYtsFh0KrhLpYClAMj2qeH481bQrSwA>
    <xme:Y19wary7b1cDfHLRF-wKhXLeYhIxtW4MVS-UPtbWlsLQVyZV4Uby0MH39MnIcig16
    bDAKaLPZJqUc3-nYKrPPFjbd6IZcQ9NTdhAXghTb43ZUD1-5B1SG3hk>
X-ME-Proxy-Cause: dmFkZTEsQ496AxzIfrgxxv53J6djC4Sf7XufOkPyejVlYkMmqYS9URR7W5mXoTUD7kXDBI
    7tiwL4r1XYO13cy2wuOnYux54QQiHAiYU6xx4E5ZyO2/asDszkN0wTGrBSElwXapyx5iPE
    /7iiF8nD+Ue2OR0QIDetQfuc4c4WTVLlS0hXsoqtSIQzi/Rm4ntT9MHABEAkgSRQ0zcUzy
    4fjySDDF/KaG56e6OqF5CbUZS1sKAdr807hmPgr+jjtgdx1KjvZL1dJFamh201PZbgmpop
    fBRnF06RkixebunC3eOTJYYLZmdrrY06L2Uu+oJjM5QvsN5WfZ/1fFlb/mWbrsSRtUT/ah
    0sksg4yiMIiaieX/Xq82s0Al9qPWu6kUDDMPfbVHHzJu5j6r5tDDqLowpjzhokyqdpHeIp
    KJ6bypDQsnXAD7OLh8LELfZBXSIYNQQF59yCsfjJ2mhyQ2PSzjlHouHi4UTz8zm9/ADYuW
    jRwhU4WzgtGXgJOn5ziPAQUkl4z2COYGMQM+HOLEh2mdiP/YhaVbWEVE/PQ9ICSZpI9qMN
    CQ0A2k6hNlDKnYOuMK1buZoLcj1zmLcfHc+GLN3/VAakT7TFARv3Uk4MpKO6NgF8d9wSXs
    67EwYjvK5gA1xtX82oN6p3YoxSzBNVd8JxD/uBJsggp/F8biJqEgtsMcnCJg
X-ME-Proxy: <xmx:Zl9wau_n13F88MIMM4AcSfVeNl6BGs25iVkBDC9gGFHNIf47SlCmxw>
    <xmx:Zl9walMaEOskqNFTCE4b6s2yiDrG8uUhK-Op58_EwfMFomVFTG6oOw>
    <xmx:Zl9waiDS72RxTZRIDDVVV14XWbMkVJITlUWgigG7xUptZp9j4K1s2Q>
    <xmx:Zl9wapODD_RJyUWfxHAmqqR1xwn1a-CY2pQBUP5IokMi_a4FeY_i8w>
    <xmx:aV9wasqWNj5Ozaqo5gbcbcJtZFqS7tOvt1HuXpHia2PAcXQ_QOA79qgb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6477232A0060; Mon,  3 Aug 2026 05:29:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A94vFq1Dmk6Z
Date: Mon, 03 Aug 2026 11:28:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: moonafterrain@outlook.com, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Mackerras" <paulus@ozlabs.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Yuhao Jiang" <danisjiang@gmail.com>, stable@vger.kernel.org
Message-Id: <a1c11e04-a3df-4beb-84c8-f0e0443bb828@app.fastmail.com>
In-Reply-To: <20260802-fixes-v1-0-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
Subject: Re: [PATCH 0/6] powerpc/spufs: assorted fixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
>
> Patches 1-5 are tagged for stable. 6/6 is deliberately not: it changes the
> atomicity of multi-element mailbox transfers rather than just adding a
> check, so it seems better to let it soak in mainline first.
>
> Build-tested only. I have no Cell or PS3 hardware, so none of this has
> been exercised at runtime.

These are all reasonable fixes as far as I can tell, but I'm missing
information about why you care about spufs. If you used some atomated
tooling, please add some reference to what you used.

       Arnd
