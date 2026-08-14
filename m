Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D43F7AB2;
	Fri, 14 Aug 2026 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691763; cv=none; b=I0UP/5PAgNr0bR/3o2T3g7jfrCcwQtkOwtGFTPu7LmLvRCppxE7NYAChK3Q3EQRNphCerKMWeYhuGiTyYCqNt4Hpq/oqKYbf9Nfj1QP6INudTDgXrjyXaeecWCjVGWQd9JojOHAuiYssIqwjY83EBaQtBpGUQP4VWqEVRiEpkmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691763; c=relaxed/simple;
	bh=1Mb2/oIQ9CzX6vlA6gt9znfYYn3xE5keKNRsc/iMpAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVjmitHOW0YP292NetwN1lNQSJ31g61qba1IEYu6NELTLk6aMYXWzas1o3Lh9f3GjCFB0GjyoqmiwG35dA7nrEJyk9d1kH2gwy+C0VQqBwufv1ShFCYMkrXa4kAn53Gq75aYJrxLDZjagoYzCmS9GctlbQmYyo5kwaxE5qLB69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=veiWjwlH; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="veiWjwlH"
Received: from francesco-nb (2-224-16-253.ip168.fastwebnet.it [2.224.16.253])
	by mail11.truemail.it (Postfix) with ESMTPA id BED5A1FC4F;
	Fri, 14 Aug 2026 09:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1786691754;
	bh=nJegQlhq+MewOGnUHRHewet7G68KbvwxdB/Y6qxCKYc=; h=From:To:Subject;
	b=veiWjwlHd6rzmgYHFb7ThT9a8HzK66BDVr5D8gAHGKvhPy1cQJSZknojCU4X11s0w
	 V6k37NA5zyflCR7xOa8JKjl1tDNnTvVcI4qL5s7YYD4lHVwQLZC/IoVtUIXgPqkF57
	 nF1cdCXBWI4xGFczPsbCPpVOYkeCvssCASUZvmGEFXmanDYEXYu4InlM+kAVcOnGuT
	 MmFrj4S56xI2sKfCRw2BaT/X9wcydhRaygKDv9zcyPdhh7x9YWi43p3tIWqVymbn0a
	 SwqAPh6I3u69i/2keYsfzceUMok+p8u/SKKMMl+yl9LX9ZnbIXyMwECdr9RiM0wTiO
	 a4bim8DWgE9dA==
Date: Fri, 14 Aug 2026 09:15:49 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Mendez, Judith" <jm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Moteen Shah <m-shah@ti.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Set MMC clock pins as
 OUTPUT
Message-ID: <20260814071549.GA5246@francesco-nb>
References: <20260813111238.56892-1-francesco@dolcini.it>
 <b4ed6b46-07c3-4ebf-9fc8-b9ae0dc03a51@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ed6b46-07c3-4ebf-9fc8-b9ae0dc03a51@ti.com>

On Thu, Aug 13, 2026 at 02:57:52PM -0500, Mendez, Judith wrote:
> Hi Francesco,
> 
> On 8/13/2026 6:12 AM, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > MMC clock pins must be configured as OUTPUT-only per TRM [0] with
> > receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
> > PIN_INPUT to PIN_OUTPUT to match documentation.
> > 
> > Link: https://www.ti.com/lit/pdf/spruiv7 Rev. C: Table 12-246. MMCSDi I/O Signals [0]
> > Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Assuming defaults are set.

We have

  AM62X_IOPAD(0x11c, PIN_INPUT, 0) /* (#N/A) MMC2_CLKB */

is this what you are referring to here and in the other discussion
thread?

Francesco

