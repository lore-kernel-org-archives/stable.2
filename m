Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0337AA79;
	Thu,  8 Oct 2026 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791424650; cv=none; b=UE3lNM9wtAasSYHRuupE8tO1pC6chI6QjHQVVF2NCR5/dLOrWTF4FaZQ6zFFdGWLKRjU8qpnXMVNSiBzDQQy3n+0vZOLI5vArIEK6a0oV4jmor/1C6Uy2zsL8OMVXC0pu25E2GcxVfQfIsXrm6HzzdmP7+5o85Rv9zN4gHXvFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791424650; c=relaxed/simple;
	bh=bwDRfHmL+0pbMnJR1GsK7JFfccS9jDbWsMhcIV6pmxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzWLK7BxJptBrE7eQ4ERl0LHQw3R0GXwVUmaz/FQ0DjezckqttDZJmOL2MBH5fSo0Kmnz4aQsQkyoX6kVk4YwB8v+/zBmIfaMrbTUJ0W+i8kUJ/Bx2XMVkwAufEdxpg7+Vjz7s67Zr0zdEDj4Aa1K8m0PVNBqqOoASWC0Gq4758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWFzYyQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWFzYyQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783F11F000FF;
	Thu,  8 Oct 2026 01:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791424649;
	bh=cyaBNpcWG/sN/H/GV35qpL+l/NWPhdj0dPzl1NaiBHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NWFzYyQq8o/+WvrLyKjRlVhFoRbgI+Tjgo2xAmC4AOFqO1Ij/QPHRJlShg0cPpeyZ
	 B5bhOd4JOHQfv7j36CdlRIG1JZqABSJiety8It+M6BgRdZmbQv6J6tjjLfcO2xtrtX
	 9d7te4Xw8qOfZJ43JC7eC0I7oDI/h3KKkYcFQDC3QLlGUqr5bTWp/I6KGOiXWZGoyh
	 eiGZ1BtDKqB+CfBOQss+JTsaPIRFsF8/uOpaDiAdKjgszWUZ+bT4PdkysAcMpUeCpe
	 uXzsDH/Rp23D3H65GoWfLveDSb+9kvpJQX0fFwlqLQjqFB78FSM3Xy5mXNdz5nUyfK
	 8mqyyhzIebSUQ==
Date: Wed, 7 Oct 2026 18:57:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Ding Meng
 <meng.ding@siemens.com>, florian.bezdeka@siemens.com, p@1g4.org,
 tkusters@aweta.nl, jiayuan.chen@linux.dev, pulehui@huawei.com,
 vinicius.gomes@intel.com, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 bpf@vger.kernel.org, richardcochran@gmail.com, dima.ruinskiy@intel.com,
 stable@vger.kernel.org, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Piotr Kwapulinski
 <piotr.kwapulinski@intel.com>
Subject: Re: [PATCH net 1/6] igc: Fix RX HW timestamp reporting when
 NET_RX_BUSY_POLL is disabled
Message-ID: <20261007185727.68180ce3@kernel.org>
In-Reply-To: <20261001222443.3500206-2-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
	<20261001222443.3500206-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 15:24:34 -0700 Tony Nguyen wrote:
> When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
> from the NIC no longer works as expected, often resulting in incorrect
> or negative values such as "HW raw -121948.050407424".
> 
> This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
> SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
> fails to perform its driver lookup, and the igc driver's struct
> net_device_ops::ndo_get_tstamp is never invoked.
> 
> Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
> a field that the driver has not populated. This results in incorrect
> timestamps.
> 
> Fix this by populating the hwtstamp field with the correct timestamp
> in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
> The "igc_adapter" is passed to igc_construct_skb() to enable
> igc_ptp_rx_pktstamp() to access the necessary adapter details for
> adjusting the timestamp.

looks like a driver workaround for a generic problem
a better fix is likely needed here
