Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B13B71C4;
	Mon,  3 Aug 2026 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747947; cv=none; b=DfFB5tbSJHtmhxLqi6EzqJAnjyHqiMODcyMG4HJjvV/JnXLXbDBztA1GGoAQKOEWgec2s4ny6t4jvXLPY8X5e3yqzf5JeHu68q9AFNdDRr7E/7cJr983zoIryIScTBoArWmrZE/AnCXbw5S0XfGUkEQjpcQ0ahkyDw9ksGthBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747947; c=relaxed/simple;
	bh=NnHtT+b3Qiye4Yp0uUBANizduTZCS8BbwpRtm/Y1De4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oBbUkbqptBWW/4qRbZE0AvP1mOsyOsa2hTs7XnAULW1oowYFcFDNGGKT8tu9XSD0DwE5cGVlBgs+Kqw+QWVv/wHBCmJtjpXA8hAwWDF65p0nLO9ibbAV1oztiSIQaR+tnvZWuNck2mwp7Wu4gWG2AFqM2/SatTtCPVXRaVgMNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=L0KnyfMq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GMj+2Fse; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="L0KnyfMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GMj+2Fse"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 42AE114000CC;
	Mon,  3 Aug 2026 05:05:38 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785747938;
	 x=1785834338; bh=NnHtT+b3Qiye4Yp0uUBANizduTZCS8BbwpRtm/Y1De4=; b=
	L0KnyfMqEanfuLJms+4Htc4y20xWQ8nXZXQymKtiQc4FnDncdS1/2nalkzg1kJGr
	GPy4CHOC3xieo49RvSZ73DufPtIB0+HRWi1nXrNuIkzsA6dt+kGUO7/+2mLrB7GK
	7EddNe49cXkbehL/shOutGkVJLdzVYS0jxxnJF02K4+yvDd0oj5grUYrLhXafBnX
	QGLwBd0qYWWIkJXqJ1N6QArWFBX0z0Aj6Fpl11Ucco6X3SR7iDPnhHtQ+Ry/Weg4
	+SdYcgq9cj2Sl/lYVtuavCU/MGniQzc+drKQ33UwQYWbY7ED45oxsqery4R/9Jh2
	gpylNd0D1dfZeg4Hv22W5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785747938; x=
	1785834338; bh=NnHtT+b3Qiye4Yp0uUBANizduTZCS8BbwpRtm/Y1De4=; b=G
	Mj+2FsePoKPkAlo6H29nlAncoexiuhfxd7uv1wGF0taBZOm6FobwEuQ55SzHSvd9
	R8fqCoM679LPDYR8mmUnTJ1O0DXoWZFs+6V1Kev5UrqleGloEI/Se5/JfL9CWk2X
	4/K4vPk/BNd6CmqW8qWiLJh2FUEFdEk6tnCa4916lSmDycyi8XuS4PogkXDLtYCa
	SLt5O6aN5dx8oH9CV2R9Np3RWn3wKTL4j9N14Knc8PpF9cJaJOup4FKPqInUVqVG
	1kfJafA/m6BtD4TmT0L3PCRSjz8amFgkA6DJuOl8CyTwZ66q2Vq7ZJckJcbxrlr/
	PBecWw1H1V/6CI6srSSSA==
X-ME-Sender: <xms:21lwapyNsTshWBY8FdqTU_ji8L7cPfPy3Rt0fZCykbfDizM0wiygWg>
    <xme:21lwakFHMp_8QCgwU-4z6ZppPva2mMhl6y-RFIBF9HOewzxjiRcmdQeMK7yJWJkgx
    bHNTzMHXgOm48A8wrCDXInRaMVJfhqOF6WCAriMKzGKqeXtWN3fUJM>
X-ME-Proxy-Cause: dmFkZTFzyMgTqu0jLIpbo2pKkb6HHBDTgg0uSi900V1ofKJ5LwtvHQE/955DGS70N4VIcS
    4A7QluVgyDmnJ+babjbGyQ4oTOWbds9YJS3vuXNkrNeNNhPZ9se7AF3h5NbsrHgpoSm1i/
    wFi+QQAhdVa8WIbsQIYw1irvqGYsdky6vE619SAaEdj9n+MD96sfCit3bIERdjcNB9Hb2P
    chUS0eYnCr2ZV0MQ0ASSsT9TkAtwtqfbwjvYGj5cPqEJTUN2sqF2aPvJIG69ZOilUa2L8B
    MzQEw6x94i9bYT7+29QJlDC4y4hakw/NcpPXkKqyax5MIG6Ivzt9dAmGa6Xv0o5IGBt1CK
    pTAw4R/doSiLhcivx8hrqonhMUsP2L9lCLZ7RoBzQ/pMVF7RsknTcqr49Lt5nst9czkm2M
    gppwaGVht1sORSBrUGSuD3nrotm89aXe1nJecGVBwCU7o5E81sNngYGcG5qlNbKStQX9yr
    pKNfxFH9KQ8xQ47sPVtVVPyxU2lgYDNIWzTl29Xj9vAFA3Y6F2yaVltPqVLwuJgt0XJcoG
    7W72lrocRGpK81Zhc8N06U8qYEo2RT4O4lKSc+Cs5id5jhTFSWDRon8Y6rI5aZSF5BO25i
    r8ktVf/yFIHNlWuqIe/cuZMNiCC1WYQpITBqOj+HP2ju2FPGUUTGaPELy3EQ
X-ME-Proxy: <xmx:3llwatDA3EUAYi7NPnEbont1T5KrUo5ea1BCuU7dOHS5y_2h_mF-DQ>
    <xmx:3llwaiCYZpnjemypq3XeOEZBenDyzK7Sp28NShLEyIEHVyTVskKRCQ>
    <xmx:3llwammQxROwO74-mNoHE5C-s2VDwi_zJHRUjlw9m06FzUTrzFzxLw>
    <xmx:3llwaqgeUyfG2gh1Z5yZTMIwkgEAjE6MDwVv0GFTXApmF4NSdZVzug>
    <xmx:4llwatvbkwAU_gfhIkt8O-hvvKrdmr0pvAMPCyt3lMPH3jIYecaE3gSp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6A40732A0060; Mon,  3 Aug 2026 05:05:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AP-oKdSeCNZ7
Date: Mon, 03 Aug 2026 11:05:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: moonafterrain@outlook.com, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Mackerras" <paulus@ozlabs.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Yuhao Jiang" <danisjiang@gmail.com>, stable@vger.kernel.org
Message-Id: <034d9118-b2b9-4521-88eb-3d88d805834b@app.fastmail.com>
In-Reply-To: <20260802-fixes-v1-1-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
 <20260802-fixes-v1-1-7368423440f4@outlook.com>
Subject: Re: [PATCH 1/6] powerpc/spufs: fix spu_context leak in coredump
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
>
> coredump_next_context() returns a spu_context with a reference taken by
> get_spu_context(), which the caller must drop.
> spufs_coredump_extra_notes_size() does so on all of its exits, but
> spufs_coredump_extra_notes_write() never calls put_spu_context(), so
> every context dumped through elf_coredump_extra_notes_write() leaks a
> reference, including on the success path.
>
> Fix by dropping the reference on each of the three exits of the loop,
> mirroring ..._size().
>
> Fixes: 38b407be172d ("powerpc/spufs: Rework fcheck() usage")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
