Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287A23451BA;
	Fri, 26 Jun 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479546; cv=none; b=JRlENI8ZzT7beE0mqF9GeJi1nJK4ADt9gLMkzbmwnqQ5LLdsJBkfftl0WR6vXaWCmzBajE+K5t1cGOXl0NOUP0LwmxCMF8rzgzWXr9lEMBNQ6oGC4TkyVv1B5euojgsXrNetmLjlehMgP/rkiZcUVXpE6XK3iWZI8w00fsp3R4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479546; c=relaxed/simple;
	bh=El7ljjvJGr1HqoJrofdonp+8lty8t9RNSoJ5hU7xio8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cnn42nfCnoMUGjUwMBGtrpG4YyzXzfmIrvT2XEMowc0GlKjMsdxcMV3KYEHUw7D9SIHxiO+4SHbClJVAETH7pl2PUOJfR6e729SZ+gHhgoTw2KMHvf1j08UkPBFrCnMUXgJNRwWRRsYwtWacAqNtosfIQBWrfhnGVv5/iZa8F5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu0B/cxc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu0B/cxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA111F000E9;
	Fri, 26 Jun 2026 13:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782479544;
	bh=71vtmVhslalYTJCiK2ZMD+FwpigN1t96VDd1vQForsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gu0B/cxcaRIbKq8Y5QLqbAvRWey9gOdCEGwxan9NXkgXZfniYGmRAy811d4kKWL8N
	 7wVC1qQJEkTu5xtMDUL1hHqXQ9huJAIf+hd4TsKMELg6CnWFsKNl1mzmg4mtHL1WJf
	 MXwtkk5UMykxIAam1Wf2RY43Rj472AgyNKhj/pR17UEIOHK144e3hU1TS4tSEoONkV
	 +IRnL2WHFYmqMUqLaQ3rkKf7us4BATnOZMB5l0oASGwzynPF806nMtacP839SsHd9T
	 zPcpXNwQBpOBfxnsqNehTY37rrRmCpPPbOocsiwn6jVrug8wqNsyycc6+CVs3Z8bPm
	 rxvvYzbT0BK6w==
Date: Fri, 26 Jun 2026 14:12:19 +0100
From: Simon Horman <horms@kernel.org>
To: Samuel Page <sam@bynar.io>
Cc: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: nci: fix uninit-value in
 nci_core_init_rsp_packet()
Message-ID: <20260626131219.GD1286967@horms.kernel.org>
References: <20260624224455.999374-1-sam@bynar.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624224455.999374-1-sam@bynar.io>

On Wed, Jun 24, 2026 at 11:44:55PM +0100, Samuel Page wrote:
> The CORE_INIT_RSP handlers walk the response using length fields taken
> from the packet itself, without checking they stay within skb->len:
> 
>  - v1 computes
> 	rsp_2 = skb->data + 6 + rsp_1->num_supported_rf_interfaces;
>    from the on-wire (unclamped) interface count and then dereferences
>    rsp_2, and memcpy()s the advertised interfaces - both can run past the
>    received data;
>  - v2 walks supported_rf_interfaces[], advancing the cursor by an
>    in-packet rf_extension_cnt with no bound.
> 
> A short CORE_INIT_RSP therefore makes the parser read past the packet
> (into the uninitialised tail of the RX skb); the values are stored into
> struct nci_dev and consumed while bringing the device up:
> 
>   BUG: KMSAN: uninit-value in nci_dev_up+0x10f3/0x1720
>    nci_dev_up+0x10f3/0x1720
>    nfc_dev_up+0x187/0x380
>    nfc_genl_dev_up+0xdc/0x1a0
>    genl_rcv_msg+0x5d4/0x9e0
>    netlink_rcv_skb+0x28f/0x530
>   Uninit was stored to memory at:
>    nci_rsp_packet+0x68f/0x2310
>    nci_rx_work+0x25f/0x5d0
>   Uninit was created at:
>    __alloc_skb+0x540/0xd40
>    virtual_ncidev_write+0x65/0x210
> 
> Validate the response length before parsing or storing the
> variable-length parts, rejecting truncated responses with
> NCI_STATUS_SYNTAX_ERROR.  In v1 the check is done before
> num_supported_rf_interfaces is stored into ndev, so a truncated response
> cannot leave ndev->num_supported_rf_interfaces holding the unclamped
> on-wire count, which nci_init_complete_req() would otherwise use as a
> bound for the fixed-size supported_rf_interfaces[] array.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
> Cc: stable@vger.kernel.org
> Tested-by: syzbot@syzkaller.appspotmail.com
> Assisted-by: Bynario AI
> Signed-off-by: Samuel Page <sam@bynar.io>
> ---
> v2: validate the response length before storing num_supported_rf_interfaces
>     into @ndev.  In v1 the unclamped on-wire count was stored first and the
>     length check returned early on a truncated response, leaving
>     ndev->num_supported_rf_interfaces > NCI_MAX_SUPPORTED_RF_INTERFACES; a
>     subsequent CORE_INIT completion then walked it in nci_init_complete_req(),
>     which the syzbot CI run on v1 flagged as a UBSAN array-index-out-of-bounds.
>     https://ci.syzbot.org/series/2a9a8657-37a3-4dce-8cb5-2035027791dd
>     v1: https://lore.kernel.org/all/20260623222402.175798-1-sam@bynar.io

Reviewed-by: Simon Horman <horms@kernel.org>

