Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B11E9B37;
	Sat, 13 Jun 2026 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336642; cv=none; b=dTpYKP5FkzXNGsYmvUYSpYlXTUKarxP39PQh0Jo2AXpOd+VJZO0pPrEx0EOWVqmtK8XYJNFi2fXXgFwj8UmIsrT72ZCoVnGTaK2hFY7M8cDZhFLtvkLXeYHvCIQJRVh3GM8v3XniBb7bKsnc3661cwq1fG3e0YyXU2tx1GOTndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336642; c=relaxed/simple;
	bh=/Wv/Qw38Spvb+Jys/ia/Dz/8lFD5VO+SWkDcgwG4nbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7Pgz8HOP4YzIknXKpz0qIj3pNyOgzqKCYaQfw5wZ0l84zZL2msF5XtYks1ed7On3kC14Rp4phY4OyzGOgIV2FpbCshgcLlze3/9wFuZLYAsj6BegZIi2eTnQdBjRqRj4eoVBd/IDMqj4/qQEi7hCechevMd5P5g9d0GZQbyCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcZPyTHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcZPyTHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3851F000E9;
	Sat, 13 Jun 2026 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781336641;
	bh=3NsskWgW6psgqXL08E8Akl+nuU0t9vihaNowzoV2S7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IcZPyTHjLMr4UkN9WcAWL/Zu6fX3szK/9T6UKdEn9yp7caLv9iBQNB6p4BSRveyo/
	 +WKUP/6N7J2KhAOJPI+EjecpH8vhJHmfQkW840xg90A01vGHzNXmdxOAu4e8yiZjMM
	 a3+LrYEgekceA70rtdTj8SNZYEqMkfpEiBMmx6OhkLyrTWSRRsONEKxyM6Kl9QWmMX
	 mVyCHB95oRkCYXvl094TDRcBhMJ2OcwPROIDVYVangEa9yN8uQbVVpDdlz8s7eg9TO
	 Ne7mP6njO0bkMLSBQQvyuTA5UaJghuoERtFNzuNCjBWwGXSck8i3N571lwfJO5oUDS
	 yEiJZBTiPcOAw==
Date: Sat, 13 Jun 2026 08:43:56 +0100
From: Simon Horman <horms@kernel.org>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: David Heidelberg <david+nfc@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: validate packet length when parsing NCI
 2.x RF interfaces
Message-ID: <20260613074356.GB712698@horms.kernel.org>
References: <20260611162718.2301552-1-yzjaurora@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611162718.2301552-1-yzjaurora@gmail.com>

On Thu, Jun 11, 2026 at 09:27:16AM -0700, Zijing Yin wrote:
> nci_core_init_rsp_packet_v2() parses the variable-length list of
> supported RF interfaces carried in an NCI 2.x CORE_INIT_RSP without ever
> validating the controller-supplied lengths against the size of the
> received packet.
> 
> Each list entry is a (RF interface, RF extension count, RF extensions[])
> tuple. The loop walks the list using the per-entry extension count
> (rf_extension_cnt, up to 255) taken straight from the packet, so a
> malformed CORE_INIT_RSP can advance the read pointer far past the end of
> the skb data buffer. The stored interface count is clamped to
> NCI_MAX_SUPPORTED_RF_INTERFACES so the write side is bounded, but the
> read side runs off the end of the buffer.
> 
> A malformed CORE_INIT_RSP from the controller, also reachable from user
> space through the virtual NCI device (CONFIG_NFC_VIRTUAL_NCI) once the
> device has entered NCI 2.x mode, therefore makes the parser read past the
> end of the response buffer while walking the interface list, copying the
> out-of-bounds bytes into ndev->supported_rf_interfaces[].
> 
> Reject responses shorter than the fixed part of the structure, and make
> sure each interface entry and its extension bytes lie within the received
> packet before dereferencing them. A truncated or malformed list is
> treated as a syntax error, which fails the CORE_INIT request instead of
> reading out of bounds.
> 
> Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI-generated review of this patch available on sashiko.dev
However, I believe that the issue flagged there can be considered in the
context of possible follow-up rather than effecting the progress of this
patch.

