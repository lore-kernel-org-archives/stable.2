Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7842D757
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823222; cv=none; b=AbkDWS9/3lWDJF7XmyhEDL6gJlypSNH1RS37O5dsNFmmuMaMIEQdIoNBq9Zgw6oorvzhO+Aj0khDqxjgYorjH5viAg/SX1RHPYJZQ7qY3T7aIWtiam9V7Uep6SdmAKaopEf9/6de3hxB7rOQb7VqGVfKAuL56mYBVpsXOz9XT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823222; c=relaxed/simple;
	bh=bhw5HQum5LBc77L+uaVz9KeZmFDoZtELFU0hh93PpZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UePqsEM00Xk/y9sFiwGUvHF6YWL9BMsG4hzm15I3sCZxypXFuSdA/D2by2qkunFJ+1GEoTMoJb3U9h8mmaTCbYbspZhEkCzYZ1IA+5AssgaFz2yHPFv1Pza2ynKarC+spA389Wst1O6Qm/e13CZtgta9/V/TszQBj7nPJ8bEOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Svcu6AeY; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Svcu6AeY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787823167;
	bh=Y+Kru1Vav72Rp1qpCwtDrJ9oUoUQOkL7t6mqW3y7zMQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Svcu6AeY0wv8d4svGw5w5mZYL0Pu62oLDTHTuAiq4W/dMXNFk3H3TPC+HvG34fxQ8
	 Qi91GINdvm5/2+Q5Dy0UtJUG9a+wV8fmqFloKNphLQvW/uU7QR+3FwM2v1z70uDgqF
	 nC/MrKnLwEbxwSJZVVhqfFBiafpkZuGWx3rK4Gbg=
X-QQ-mid: esmtpgz15t1787823149tb9ef095d
X-QQ-Originating-IP: v20pb1HbGSmw93S0C7R2u7xtsGnMhb5m8XnkFiPXs5c=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 17:32:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3775252628204674573
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.18.47-rc1 01/10] Revert "selinux: require a class's permission values to cover its permission count"
Date: Thu, 27 Aug 2026 17:32:27 +0800
Message-Id: <20260827093227.4050399-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026082735-footbath-absolute-3048@gregkh>
References: <2026082735-footbath-absolute-3048@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MYMX4ImMNrKeFrVZJ8ZLQW2YVgFUGjDhc9bO2H8xFaGWOpvmlu/whJhs
	nKTcRUX3bJRRj4iYtnryNx1Ug4CwELp+jZg2tVzmGcd5q+jjyPoWQVLM1m06UTvnGT/0Ljs
	H5EN7XgqujskiQBVAraZ22xc6lLyGANS3QxEbcCmNJcToGgUcGstroVgEkjhUrvYZxA9eKY
	Zcvpx7I572Yh3P20lxiZuFmdRkhV1fModsyvMY9IffY66KGO6s0cmAW+xtQ7P+SPt6vASxz
	kmNFIp2wU4ddyhYqDwX7EW5jFFL06BhGdTaU2NRSdlcpnhHr4dNtrdi044GEjzcJSj9RKCQ
	VhbQYQ+S5MhZmDxzZNn/T6EDcvx8/NwSYatky2f4zM+APWwxq8ivlPgoSgMeiccr+ep/ve1
	7f0eL5xDUiPsstVx+EPjBFlKwgwHhCE8LtyiiuCx8UpJlyT1Ch8CWD0jSKxXtuRpdw5HboP
	EhXoBAy2a5uDUb4cA2jaw0TI00AKWnuteF4GwPAOjmUUeF3irw3p/ofZ4jcBi/2uFiKZpgk
	8Ougka8/9I7r+Z2soXdff9qK26VxEoIdEYcSgdgKrUoJA3cXqdhdh/gQ7/RpqWK5mpQB0LP
	JWXMl3mJJtDglugCKDaOh7EPq74ibzNhpJ6SAd6wX7gQdSEqKi7KqXgSXAM4Pa3lvPOK3Ow
	29rHaQjEMxORmbvVb3s2S+3IbFDfF9EZmaHBhlKDOMsoHbaGGSRU1qAh4B650tVEbxetXKg
	rmegOk5mVGZOkIztIEZCwvnjI4EMuTf5bKqq6sTxmuA0IGyS8wTR0DxThdXA0V9ZKYZ8Y2Z
	9zM/BNG0qF5kxWAHnjldsUoTYFL2JM0TOE/tMjs7mt3ntmGXVKfs+irviMlAAT+t1XdKsBi
	9YAMTV0m7nelrRyRFSF+9DY1KLOyRq570zMLohR/RPnarnbesjwvNZU0aaAuHXVJA1unHm5
	AoYJTw9j7A85rAtFU28+2A5Hx5xrtSmiP9KbKHMKh8ZtQnwlOgXOZXvIGmz3ayrl0AcqU+b
	VU0LXRMlIw4+8ylaK7f1jYndfAK/YGqY538hea22vJRkibQ9MIHi1Q2cWG+NCuBai+RoJx3
	chJrwRzBSB9tzNJ/HeOlX2hFt/2PLpjkP4aJQktwDY4tV+SOydM/8bqUMfexncToxYGUqNA
	7QOwu5Sf9ZcyOt7lTxxjDhSIQyyXqTymwouyhkCAe33yeAdodtJoUNRmfA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

> On Thu, Aug 27, 2026 at 05:07:59PM +0800, Wentao Guan wrote:
> > Sorry for prev email title is garbaged...
> > 
> > > Why?  And this is not a real git id in the linux-stable tree.
> > in stable-rc git tree.
> > 
> > > 
> > > Do you want me to just drop all of the selinux patches from the 6.18.y
> > > queue right now before I do the release?  I'll be glad to do so, but I
> > > need to know why.
> > 
> > fair,
> > 
> > What happened in my side is Github Copliot review point out the issue:
> > "This validation runs after symtab_insert(), so the table already owns key
> > and perdatum. On an out-of-range value, the bad path frees both while leaving
> > dangling pointers in the hash table, and rc is still 0, so malformed policy
> > data is accepted and later accesses can use freed memory.
> > Validate the value before inserting it and return -EINVAL."
> 
> I have no idea what that means at all as I can't parse LLM output well.
> 
> > In continues review, there LLM point out the mainline don`t had the issuse,
> > for correct sequence is that git log --oneline
> > (v6.18.46-1) selinux: require a class's permission values to cover its permission count
> > selinux: reject a class permission count below its inherited common
> > selinux: reject a permission value exceeding the class permission count
> > selinux: more strict policy parsing
> > selinux: use u16 for security classes
> > Revert "selinux: reject a class permission count below its inherited common"
> > Revert "selinux: reject a permission value exceeding the class permission count"
> > (tag: v6.18.46, stable-gh/linux-6.18.y) Linux 6.18.46
> > 
> > This instead of Sasha`s series:
> > 2026-08-24 22:00 ` [PATCH 6.18.y 1/3] selinux: use u16 for security classes Sasha Levin
> > 2026-08-24 22:00   ` [PATCH 6.18.y 2/3] selinux: more strict policy parsing Sasha Levin
> > 2026-08-24 22:00   ` [PATCH 6.18.y 3/3] selinux: require a class's permission values to cover its permission count Sasha Levin
> 
> Ok, I'll drop these for now, and wait for your backports.
> 
> But note, I'll drop this for 6.18 and older, so I need backports for ALL
> of those branches.

for 6.18.y:
1. https://lore.kernel.org/stable/20260825100338.4039846-1-guanwentao@uniontech.com/
2 .https://lore.kernel.org/stable/20260825100338.4039846-2-guanwentao@uniontech.com/
3 .https://lore.kernel.org/stable/20260825100338.4039846-3-guanwentao@uniontech.com/
4 .https://lore.kernel.org/stable/20260825100338.4039846-4-guanwentao@uniontech.com/
5 .https://lore.kernel.org/stable/20260825100338.4039846-5-guanwentao@uniontech.com/
6 .https://lore.kernel.org/stable/20260825100338.4039846-6-guanwentao@uniontech.com/
7 .https://lore.kernel.org/stable/20260825100338.4039846-7-guanwentao@uniontech.com/

for 7.1.y:
1. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/
2. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/
3. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/
4. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/
5. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/

There only different between 6.18.y and 7.1.y are 6.18 revert which applied not
cleanly:
62be2361da29505d3183da854f1c98d2e208e852
9f721b5d9e1d956ffe965bc09375989eb51881fd
and next reapplied in next series cleanly.

BRs
Wentao Guan

