Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6293449B12;
	Tue, 21 Jul 2026 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594411; cv=none; b=GKJq9wl1O1NAO/Ih0G80JyMJzRPP1SL8Px2QgdBqS/ueV/5tJMR2LXj0LUpiT92ZeEr+UuPJ5jxQg6hVgaMky0L6L4hs475j+f7PL0oQ++3+w/YbyYegzCI6ZMHXEHoDB6J1EWWLtGqKfgXWcWKnXlHqo44FKKfCaA8K/LsbHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594411; c=relaxed/simple;
	bh=e7CMAz0uFt8gST5OpazkZOf2jQL9aJGSIf1SGEvk5Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwvDiYsifnt+C0UT6tFHVHA6X0AT3ztWHT8lA5ybYcsysxJ6uoM5Lo96qt6OsmaM9bF2BCJ1k84ADNa+5K4Dc8FTV/fnAueoxKtleWTTEibmaWtYE16cnbfY0OB2pOn7DjmH6TTuT1Jd1MO2uxb+aJsKn3TivOVyln60t9eEEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPSljNpe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPSljNpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0491F000E9;
	Tue, 21 Jul 2026 00:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594410;
	bh=vfHbiAWr0oMS7soPdDm45cDiqHqVjWGCo8r/UXUVgWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YPSljNpe/vabbbrUBwU0ZtrmuTg/Qk7bqbdjJvA6mA1CFKrz+5ORc3jqDphmQdYwP
	 tRjuMvOYrjOdy2OJX3BtCJNVRfDc691D4jiW1wnm0eAunqf3AUGsSDJrY9EHXb13Ag
	 G4fkBtdP+Atx1ZsTcJfjnA1raDVT1j76ELkooxpQ4Xpu7bzPrLVch2kDj5Y1Vb4w+g
	 KO9SC/HCznq681cA4FDV+6ENWn9OZ64kyXPO6V6Mgc4pScUZGZOV9R3GciAcK44ZEx
	 LbkKoOUlGzDCwuu475K0+TdS0QubE92XXiS+hyBbMfEufLO194FZLrNC4wrrNMlfrj
	 VrSu1TLhcFTjw==
Date: Mon, 20 Jul 2026 17:40:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Breitenberger <bre@breiti.cc>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, stable@vger.kernel.org, Markus
 Breitenberger <bre@keba.com>
Subject: Re: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on
 unchanged mode
Message-ID: <20260720174009.4a73cd84@kernel.org>
In-Reply-To: <20260706061954.94842-1-bre@breiti.cc>
References: <20260706061954.94842-1-bre@breiti.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 08:19:54 +0200 Markus Breitenberger wrote:
> intel_mac_finish() is registered as the phylink mac_finish() callback
> for the Elkhart Lake SGMII ports. phylink calls mac_finish() at the end
> of every major link reconfiguration, including the initial one during
> probe, before any interface mode has actually changed.

The netdev patch queue has overflown.
If these patches are still relevant you'll have to repost them.
