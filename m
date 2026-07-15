Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949935DA43;
	Wed, 15 Jul 2026 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133306; cv=none; b=Aa0eZyhmsJmA8YTj/Av1wblUArneKeflqCYLP+HvJVmjDoFpDpLEclieVExTsBWQeqf3UpACnd/+YcSDGqbK7a4iBeecjIi+WfLC/Yd6dikFVvaWspbk8b+m9AY9+CXnxPIceDupjqwH7AroyjPRczPu1VKg9XOvFgCIYqQk2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133306; c=relaxed/simple;
	bh=8bqmPG4IEM3bcUy0+Pz8nomt5fYXodsqpb0p2yu3P0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK2j2h922DI/orA8TRV7JimupPse690e3kkoACIAzeppljIuAvH9y069SznxfyBnsf8VDoe9BMqBMNMpmQ5Zb53X4LcUrrpt9pYWxIlzw8PwKD02+EzzZfz4jD56cXldk+GnCj6CQV9Aul6n8wLNzfkPIoUVcczglFRk0+d8CZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=whFCOvtJ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="whFCOvtJ"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 7542E1F8BF;
	Wed, 15 Jul 2026 18:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784133302;
	bh=mLy+AxIZdAZSn5ruUCN8ovCQjC731IjigUxz+gP0av4=; h=From:To:Subject;
	b=whFCOvtJW4AcfTVTzpHIVQBG6qPD4UOrwU7h35w7pl3uZTUvRPheBCcQ8h4+CuJY0
	 8ghAa1D8IY2as0EHX15rDIqhcevNa5E42msQ1ySyoI2/CjPd1Lp4a5zH6FBshAvtrJ
	 ECZd3D0kdPyCnpnUYXnmmWFRgktipGvZAVbK05Xq8Wb/df2kUXUaI0VznqyQZXwyTG
	 cmUhOwHJ9llunZsAmpCaw9Qc+G1RDerRJdrpMFGYUn1vh5Q1sQ+dqb+jhje0716X3T
	 Ev0Atfp6peFHX/TkKevO+F7LUiuDWQnHAhy7J3BSR9dJzlEzmxup4aMymLzq7wmDlT
	 vadzH/V2xHD9g==
Date: Wed, 15 Jul 2026 18:34:58 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: validate HT/VHT capability and operation
 IE lengths
Message-ID: <20260715163458.GA149147@francesco-nb>
References: <20260715144021.GE56330@francesco-nb>
 <20260715162800.1922-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715162800.1922-1-doruk@0sec.ai>

On Wed, Jul 15, 2026 at 06:28:00PM +0200, Doruk Tan Ozturk wrote:
> > why break and not return -EINVAL? (this in general, not only on this
> > specific one).
> 
> To skip the one malformed optional element and keep parsing the rest of the
> beacon, like the FH/DS/CF/IBSS cases just above in the same loop. Happy to
> switch to -EINVAL if you'd rather reject the whole BSS.

maybe I am missing something, but I see return -EINVAL; when the packet
is malformed. see for example

		case WLAN_EID_VENDOR_SPECIFIC:
			vendor_ie = (struct ieee_types_vendor_specific *)
					current_ptr;

			/* 802.11 requires at least 3-byte OUI. */
			if (element_len < sizeof(vendor_ie->vend_hdr.oui.oui))
				return -EINVAL;


My advise would be to do the same we are already doing, and unless I am
wrong, it means that we skip the whole frame if a corruption is
detected.

Francesco


