Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379852;
	b=VwE3PzfJaQuB10hoQYLNdWlmSUQZTjvGyuVqC7A6zAIK4RR/Gq7EB39JU1Rz1GO5HabM
	 r/ZvF2T0suR2AWRmol+lhAZOYPVDwTUqgrzd2ZxuZ+Yo4S7z30wh1i6vKFauLljcWMxeO
	 NEkZzDIEy7cTqB0au3j8S5AGPcm8AEfZQEr4F6bmCUQjSB+2t2v/+NlHPEZYH2I5QSqry
	 /WT/cnA53Cq0iTaz4pX0ZM9o0/o3Wk0pIhEzl7sxE32tdK5cpGvL2mGSVoUZh4NXc0qGS
	 TD/DNnTWPpuaBa9tHjAfC67Iqhit/tqxaTGb2SAXXyeSJKagr56ixbQF0bEvZq/ZqWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379852;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=QKbQ/ruVPJfxFXMkY7n2nO72I37QhMdT2FVadZTIHTI=;
	b=KDV5QOntqk1N6Li4GW0PnHXMcgU7kC1XvoAY3C63zvZfxG066xypL0saf5MOqwH7Wo/l
	 8v/8Ua++oONIV9M43BNa5JMikALZSm8MMkmDDRgiQTjvSWZPjqiDmav7KkVi7OV+zywD+
	 Czcym/F/y4uQdNUoo3uAJMo2H0MeFCRRBWaNf5GqsoOfrCnu1LaUL0tgatt4FVG0Be8+f
	 BHs5Y+yAT+HfCIu39rXO+UEAeS3Jb1zNW1Y1Wr2OnOWmLfxUQbYPbgBLdukxVdD/naWYc
	 tqLUCjOwMyzsWmDKppqOWX/hl8iDzwu4LP5/fdiQBf6wOSJH+rp7rjTWHYszUKvBO9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=qFuytspF;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C74E606A31A;
	Sun, 22 Nov 2026 20:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C74E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=qFuytspF
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80F1BA035D;
	Sun, 22 Nov 2026 21:37:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1795379848; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QKbQ/ruVPJfxFXMkY7n2nO72I37QhMdT2FVadZTIHTI=;
	b=qFuytspFxPUpX6GrAkKPVuaEtZasvNyYeXwbBa2EIqSZUcam1s1+xbV2rb32CWrwoBdtIS
	O8H9eKezIsDv8/IfzH0orjDIwMbutBycVnW2ZXRbQdoBg1TU6EEEjz48a/vE1OVqJ8RJSx
	T++URvx/NQYgDHrf7LPJVcyAS11UjHHm1g4IpnlPMAprMfuFB/0yuFWuEdvxAvVctmag0K
	yDL6/LncNKgq5vUCKxI/HArfzlv11d2S/bNBdZDQrEiSZLVql07ElV2vhX/6j90GxU8BKt
	xnymK0uc5/MoVhQZuZBd347dWYGayg0AdUpVBDC/yM8kmBB95A2sT1QsS3EAiA==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 21:37:24 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Anandu Padinhare <Anandu.Padinhare@electrifex.com>,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>,
 stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
In-Reply-To: <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
 <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de>
 <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
Message-ID: <9fbb80bfc0e58a531c1eb59127bd8059@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.11.2026 21:20, Sam Edwards wrote:
> [...]

>> After a successful retry, doesn't this leave the last received frame 
>> in
>> the ring until the next RX irq? Could the poll refill first?
> 
> Do you mean "first as well" or "first instead"? Because "instead" can

> [...]

> But, "first as well" sounds good to me: before entering the main loop,
> refill 1 buffer (if possible) just to ensure either the IRQ fires
> again immediately (if the FIFO is holding onto another packet for us),
> or the inaccessible ring slot is clean (if the FIFO is empty).

This (first as well).

BR
Nicolai
