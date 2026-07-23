Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A54968FA;
	Thu, 23 Jul 2026 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817700; cv=none; b=WrhW7xadrVlDW4N51Wh6tZGkQLKd+92/WgCMWsr66TnmZHJSnPuxbqePnidvuoo8GSV3O3EwsigLn7VQ3I+RUTRsvKC9gL9qE3W4Fi/RvQ5G8zVZCmHIF7qDel/Gxj4arg4BthZ9npRaDqGGB0VacVhcvq8f5CfhmqawrmGTeRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817700; c=relaxed/simple;
	bh=j+QEq85409rQ7lRDnWtihP/gGjaWsHj7KWMflwYdQy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLtVMNTutD6XMj4X1ysdcr3XzNHK4ULMS9NjtfsOu3WLuU2EGmmSawF8tQrD/IrPPDxkCgAye54ZdBj0rj84E81y6sVPe59mVqUiWkGdCKQEpWdAt87MaZt37Lvj/sgO9DDzG3Trmcw7WfYoe7CMCyJDROMdUh7SB18YDd2H9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=RYCtU8h9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="RYCtU8h9"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7B8781FD1F;
	Thu, 23 Jul 2026 16:41:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784817691;
	bh=KVj2va0chTwCQK/dZKOWdBgIGzwY05yBpepNzo5yI0I=; h=From:To:Subject;
	b=RYCtU8h9Vm4M2Qk0/YthSppOO+nP8DfuJl24V6p+U5Ue7Ik3DodAbAVrXqjKHwaWM
	 zwztND2JrA0feK7XLO1haVT1AfvbKRBw5oAf2R7cs/I/RJWsUI7+zFz5G9L07mkFmt
	 lSZS1WVbptC8qVmZoS51oiURc74pia9FhDHBDDJtsyZM68yvjNEVfaoRVOD40rTYHq
	 uU6LjGPSROEf4VbDX0jm2O9icOVhIPrVfgUCsBBXUyDCqJOBeank7ipX3i82ISTHSs
	 hecSgWFR+X6cDZOVOgDevfMr3Zrjhj4WzR8uepGZJ7sXDJXHLMSCcl9b4UnQmaFMfB
	 CA8IMxzghJpaw==
Date: Thu, 23 Jul 2026 16:41:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, briannorris@chromium.org,
	francesco@dolcini.it, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: validate action frame fixed fields
Message-ID: <20260723144127.GA234631@francesco-nb>
References: <20260723011013.76968-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723011013.76968-1-enderaoelyther@gmail.com>

On Thu, Jul 23, 2026 at 09:10:13AM +0800, Zhao Li wrote:
> mwifiex_process_mgmt_packet() accepts an rx_pkt_length as small as a
> four-address struct ieee80211_hdr plus the two-byte firmware length prefix.
> After stripping the prefix, mwifiex_parse_mgmt_packet() can receive a
> buffer equal to sizeof(struct ieee80211_hdr).
> 
> For action frames, the parser reads the category immediately after that
> header and, for a public action frame, reads the following action code
> without verifying that either field is present. A minimal frame therefore
> reads one or two bytes beyond the RX buffer.
> 
> Validate the header and require the category and public action-code fields
> before reading them. mwifiex parses the firmware four-address layout before
> removing addr4, so add ETH_ALEN to the standard
> IEEE80211_MIN_ACTION_SIZE() offsets.
> 
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Fixes: 72e5aa8d2a6d ("mwifiex: support for parsing TDLS discovery frames")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/66f148d83eb9f0970b9abbccc85d1b61244e54ad.camel@sipsolutions.net/
> Link: https://lore.kernel.org/all/20260708195911.84365-8-enderaoelyther@gmail.com/
> Assisted-by: Codex:gpt-5
> Assisted-by: Claude:opus-4.8
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
> Changes in v2:
>   - Add a local header check and express the action field sizes with
>     IEEE80211_MIN_ACTION_SIZE(), accounting for the firmware layout.
> 
>  drivers/net/wireless/marvell/mwifiex/util.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 7d3631d212236..4043590137391 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -313,13 +313,22 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
>  	u8 category, action_code, *addr2;
>  	struct ieee80211_hdr *ieee_hdr = (void *)payload;
>  
> +	if (len < sizeof(*ieee_hdr))
> +		return -1;
> +

I am confused, why is this check needed here, and not done in
mwifiex_process_mgmt_packet()? 


