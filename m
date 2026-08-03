Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8833FE2F;
	Mon,  3 Aug 2026 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752320; cv=none; b=HcAm8Es9M6bnunmS8dUMIAFlxnr8JTTCyfk0JicrbEl5Kglg7LWXadOEpgN4Bd/ZXkxIfGAFjqZsyUeo6oyYqoGDNrg9Jf1FsUNrdyNpt8kB6brlIgv09MwgIk7vvw+xbnwkE50lEKuvbUa+zK+f8g0azfds8g18Ppc2F3m+o1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752320; c=relaxed/simple;
	bh=AuDxaPyqNWLx5/LkZ5wzqlrvIBRPuXaEU6S2k+SH3Vo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QTZ5Re5S8wK+2FUxjNrMWvBzaI3kDSyYWPqHeLDX1vvpY527DCbimdPZ1daVdHKlBzyLUMNThQCEld1gNPWCCbkyp9q95Rl4Ln1LILyyp0K4TQoZYTfkSm/22gDA/LKDW+caqhrjOhnc8X0TUsQl6b9DaP5i3EDSfayo9Ajkjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FJJoVLbc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMG/zUXc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FJJoVLbc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMG/zUXc"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 19EB7EC0123;
	Mon,  3 Aug 2026 06:18:37 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 03 Aug 2026 06:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785752316;
	 x=1785838716; bh=nJWAmiK/YDsLpcDRD19IyFBb+1QwODK59Xiam0oEnn4=; b=
	FJJoVLbc3ZmX5fpIePUqZeraQhsChe2tQkKJKpqTaB3balRKsl0fxra0VstKbvcX
	tIss4Qqe8zdjM+vh7DPcPDaqFCcCpIszYxE/UCeCfpJTesTjKbThDx8gCaj3oFYG
	CTWoT8kf8H6B9pDaxw2V0T/ST56EzpI6vqvU+PBqK2eSFZzUI8QXAIPu48t+XRRf
	6r5yUK6T7C+bpMBMb3KSwjMT41eurT5o+wbeOwG0fbCh73hIxLsKugJHfs4TvCOf
	tVsG1eHN/g2SoGF3nFa1A9hta6+oB1mpWimOg8tHHtuxVPcdrfP+q0X2bJb9ekHc
	iMMKJELywUlZ85NniZ1kvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785752316; x=
	1785838716; bh=nJWAmiK/YDsLpcDRD19IyFBb+1QwODK59Xiam0oEnn4=; b=J
	MG/zUXcsKk2cgo7pYFZaQPjDtlQzxxKCNrztauvrJdZ00jw+pOUDgVQMNbSf+/uP
	jOYvZsgXbs/1m/oDgcE282oweOHcRCdKLS6pHogTKc6f+mtiNZEcvB0jM4hH9+eF
	O72x3t+pc9+wBUGIWzjP7qap/C/dI+FLV5phBUc1Mx3e0bNNIKmQdTNQNrtSDwYm
	tfLUBOiET2tZw9wU8nPSnvjxisDsiqa91iWtJGu0Pb6MeAQgwwJvBbbyl9jdAV2b
	M+ngsE64ewbs1GBa+2JomlAqaDnaHf6wwEK7Fd8ENpkZX4yJdoPyCLGILElR0SVQ
	W0cWbwKznG7f5vod82Ndg==
X-ME-Sender: <xms:9Wpwam19vjPHpjWuBwec6tDmAashtMB3DS4VY2qZahyOGEf_NJx5Sw>
    <xme:9Wpwaj4p1i4WwDDy0EGNA1WYEEN9perFYPBRW1yGpo6-qdtjZnd4HP6lzRXSvHz2K
    hencEOQ_hkwqm08xQq5OII1-zcuVWxfAIgGRplpEteyX44QXYl44hvP>
X-ME-Proxy-Cause: dmFkZTEy4iNVFMTHvJ74Iz+PXArk4nRhmAi/Hp0/FiwaNzyHmcpp1vZqox0Qduh1Aw1rZx
    mx5wM+EexPoc0vymZaaiG1M+/Qw7te6Eu3V9UMu801YgfVuiUsOr9jFFcerRK1QjRtrBUZ
    WGs/2j+osW6O63m39fwq2j/LdnJ5MdBF7fY9ftcrV4rBHXNfIa9WlYQ86A6He5nmDi8BsL
    1QSOGBog2fWZ+ZWaAM6w+M0eCNeEB1WGJUZRAO1XsUVhYnDjnPJOFkOpPAetduTjkaK4kj
    u3ZiPSAcPOvW4T0yY1QGgeymVrRjJUEwRP/XmbWeIXPlB6Tbh0qlfJozdXa7L6yvdatBTo
    e9Oywkh7tbKzDSRX3yf/Qufzgub+05DU3o7OacGkoSMv1efWWDHTvZ1NlwJA33vUQBpOwm
    4c9gUCezKoR5OkaJoYIRyzwh9OMWFl1fNv1xBdK2CWWpXwLkpraacAHYHl76RUpyMRdNzf
    tOT1k7POJXvKny6sS9R0DG0mGoag/23sHHaUz7QTb/ydBXiDsApCAtxzk/8/zej4ZHVlfW
    KZLhC8ozJ4XQiHGWroMPvOP0PnN7nwrP0dAoyqaI5KCa5tCOWmmgJaTUWI3e0oy8+T2tzd
    E5xj+c+oPN+VRG4RUn2Kb+zWriDLtr1m8R6Wz0wjp6Zw/dY2HQvjMVeDDv4g
X-ME-Proxy: <xmx:-GpwasmI9vRR6VIlVdkp0ki_F2a0204oAEjv9xjZmNj8bdibj14hNg>
    <xmx:-GpwaiVzlpjCbgba7UiyAait9jH3ufl8lLpWo6ecs0tGLV4rkU6LNA>
    <xmx:-GpwaopPiPiwQFCPdeI788R5uuKkVzoxsDvBcc8kLgksOzU4XBNVng>
    <xmx:-GpwarUlYla0FBqcd9_POc3vCw0ypgAEJExxPjbGjfMoqcB2kKqWdA>
    <xmx:_GpwaoQUoQHGFoVnnHhYLp9XS_DG7jCMJETbU-y_kBfGx7V9YTYGNcNm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E204F32A0061; Mon,  3 Aug 2026 06:18:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A94vFq1Dmk6Z
Date: Mon, 03 Aug 2026 12:18:09 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Mackerras" <paulus@ozlabs.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Yuhao Jiang" <danisjiang@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-Id: <8391ed30-d739-49b2-ae8c-d31f01343841@app.fastmail.com>
In-Reply-To: <9E49BF8D-34E4-449A-A24A-AACCF6215DAF@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
 <a1c11e04-a3df-4beb-84c8-f0e0443bb828@app.fastmail.com>
 <9E49BF8D-34E4-449A-A24A-AACCF6215DAF@outlook.com>
Subject: Re: [PATCH 0/6] powerpc/spufs: assorted fixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 3, 2026, at 11:59, Junrui Luo wrote:
> On Mon, Aug 03, 2026 at 11:28:46AM +0200, Arnd Bergmann wrote:
>> On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
>> >
>> > Patches 1-5 are tagged for stable. 6/6 is deliberately not: it changes the
>> > atomicity of multi-element mailbox transfers rather than just adding a
>> > check, so it seems better to let it soak in mainline first.
>> >
>> > Build-tested only. I have no Cell or PS3 hardware, so none of this has
>> > been exercised at runtime.
>> 
>> These are all reasonable fixes as far as I can tell, but I'm missing
>> information about why you care about spufs. If you used some atomated
>> tooling, please add some reference to what you used.
>
> We're working on a paper on LLM-assisted vulnerability research. spufs
> was just picked at random as one of the modules to look at. The tooling
> is an agent we developed ourselves. Should we add an Assisted-by tag in
> v2?

Yes, I think that would help.

      Arnd
