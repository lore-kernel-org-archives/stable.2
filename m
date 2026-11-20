Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191116;
	b=GcWvm9LVUfB8nW+WD8QpnK/9wum95qk8lpRMqZfZaZUlCwkCf/ogiyY6+Rh3O9T0ivXZ
	 4OreUmqJurIvv0Lhtmf8IUA7y0EL6RfF/mlOMTqeHwglZ2iaoAus8SB3iJjMgY3ssC6Kd
	 pU7qmA88MPWouFPqNCKwyhmG8EWj9oWlN28Vq4T0ooqQfp/PowB+XHtCnSMqyINvZykDy
	 ZU0qo/ZZDp26X9QmBeDuSp/ds0f4OKoJARQn3MhaMEvI/uqysMa6jt1Ziq5yoUFwxy3gX
	 3TVHIOLw/BbMLF0+qZKgrvnfH2v8Lwlq90/MxTC0lepWXcFhsd630OhCZg/1gNJyTvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191116;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XK6SzHRjFdKFRX9n4Xep6KhTJWiX/w49pRnxBPXNpAY=;
	b=MRxlhJTKmSnjaAgWkluQTlBTNT3Vx5BCdRpq673Z2Jl8G9NxOB+EJec1sKiqMeqAQmdc
	 CFi3+gzN2N0WZfoFMbfptPXclncEWJQSnGUI9XMsw2SgXMEr6gjNe4F2/Q2mVEJjLlw1V
	 2r3G3W1TVv/YFz1kJMbA2TxI1CNk36lBGCmEE6GxnIm3MIzpI0s7QjZgNoc4i3h9K2j1Y
	 cZTQ3nTAc88NZwNDVxjPJRrUnw5F8djOXePqWGlW2TKrm4gBMDsLLbpid6jBMd2PaUyH/
	 dxcWGbQzeCDKY5myjvQR6cq1meOk/cctZx9e7vUPpNqE4ZejsCclvxo/bv6w3twmxuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="FHdGbW/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE8D606A320;
	Fri, 20 Nov 2026 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FHdGbW/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C169E1F000C0;
	Fri, 20 Nov 2026 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795191115;
	bh=XK6SzHRjFdKFRX9n4Xep6KhTJWiX/w49pRnxBPXNpAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FHdGbW/xxg/wX2hzlJC6TU00c3hpCD2eVl1dTD/KyJ06XMk4wjOqgqVnPTyrOH5U8
	 dNsBwObP4r9Nh301gS8rZCJFcDN/0BbX00h3cWCpAhDRWM92svo//ODBaFzZ08hmJj
	 mh6G9bj6CkOt09jjLKIRidhOXxQwZkxbdppOn9XA=
Date: Fri, 20 Nov 2026 17:11:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Diogo Ivo <diogo.ivo.sx@renesas.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH mainline-linux 1/4] tty: serial: sh-sci: set the RSCI RX
 FIFO trigger to half the FIFO
Message-ID: <2026112012-aftermath-trench-f567@gregkh>
References: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
 <20261120-divo-ssgrlpcsrc-2996-rs485-v1-1-a989baae3559@renesas.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-1-a989baae3559@renesas.com>

On Fri, Nov 20, 2026 at 03:49:24PM +0000, Diogo Ivo wrote:
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> 
> The RSCI port types ask for a RX FIFO trigger equal to their FIFO size,
> which rsci_scif_set_rtrg() clamps to fifosize - 1. RDRF is raised once
> the FIFO holds at least RTRG bytes, so the receive interrupt arrives
> with a single byte of space left, causing overruns at 1152000 baud on
> RZ/T2H, and at 115200 baud on RZ/G3L.
> 
> Every other port with a FIFO triggers at half of it, SCIF at 8 of 16 and
> HSCIF at 64 of 128. The only exceptions are SCIFA and SCIFB which set it
> to 1 because they have no hardware FIFO timeout and a higher trigger
> would leave bytes in the FIFO.
> 
> Trigger at half the FIFO for RSCI as well, 8 of 16 for RSCI_PORT_SCIF16
> and 16 of 32 for the RSCI_PORT_SCIF32 types.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3a3ab10245b6 ("serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI")
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Fixes: 42eeed6d9f31 ("serial: sh-sci: Add support for RZ/G3E RSCI")
> Fixes: 8f18d3cbd920 ("serial: sh-sci: Add support for RZ/G3L RSCI")

So this patch is going to fail to apply to 6.18.y, which from this list
looks like you want it to apply to.  So please break it up into
one-patch-per-device to make it simpler for everyone involved.

thanks,

greg k-h
