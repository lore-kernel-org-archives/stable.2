Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A246D572;
	Fri, 11 Sep 2026 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129675; cv=none; b=ohzp022ZoSUrulzM515UBvWQc9NhvdG7ATVWtEoWFkq/ofRrYpzHytMyX9gYabd+A7asn8RRmKFqoYhK/XrT6aep9bDHIPMZJlKRuLu1F5yEs6cj6UPbqrSfwO6kEUtrWlHsihuEl1rjZqh1Vd+urRv2Ty9QYcQEqJSBByZioZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129675; c=relaxed/simple;
	bh=/JoWNlL+nQ0SYDHa+uKMdYNQU78oDwK4ffKWAt0iyx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6nFiehT2DQTXh4s6odWv9Lf/hPOE6X1ozn8oPjURvMVxnhMF50er/AWYcQygffWiSBAqrPv3KsWxR1mzBpBBtnRQfhOjMCxtLlAW6G2giXJFl9HQD2b/+ybjQSJYPDHSVweWss28yqIiWsFOQcY0v4eeIGdlvA7miF1Tqhrano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdjA7H5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdjA7H5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728BA1F000FF;
	Fri, 11 Sep 2026 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129674;
	bh=7pJTvovEIjrwVRJGOtnHTbbA0QaxF2m3Tjiosxi6CrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XdjA7H5jSrEhvGG923NQkXtin74+h3sjWaGoUXA6dMDZm8UUK2xJWBmDQvRwAi+jd
	 ypTJlc0Un94bUYTBF2HK7b3L88+BzOCc5btiVkf4WwrnbS+6S1Hc51kTCKaluE0I5b
	 i3Mx+a7YeTmzay5I62U5BnnvJ31lNZfSRL+szWgn+6xtbRG8Mv9otAcbTtyaFi0fz6
	 2gBuw8zdvPDeTEyh3GfAKhJuf31lLweyBNXjaa82peHVDVz68C6mQ0o+aZDOtOdCna
	 agQg35DMQvjYkfs4lFdM94kkXVC0CTZT/133bsfl5tqH5gdzpzeUhlWCURfaLEgIsQ
	 xJAYgDt4VcuZQ==
Date: Fri, 11 Sep 2026 13:27:50 +0100
From: Simon Horman <horms@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nfc: nci: validate CORE_CONN_CREATE response length
 before reading fields
Message-ID: <20260911122750.GF48209@horms.kernel.org>
References: <AS8P251MB00015EC8F8C2D4D9B536F94DC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB00015EC8F8C2D4D9B536F94DC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Mon, Sep 07, 2026 at 06:28:55AM +0000, Aamir Ahmed wrote:
> nci_core_conn_create_rsp_packet() casts skb->data to struct
> nci_core_conn_create_rsp and accesses its conn_id,
> max_ctrl_pkt_payload_len, and credits_cnt fields (offsets 1-3) when
> the status byte is NCI_STATUS_OK.  However, the NCI transport layer
> (nci_valid_size) only guarantees that the payload contains at least
> one byte.  A malformed response with plen=1 and status=0 passes this
> check, and the handler then reads three bytes past the valid payload,
> using uninitialised slab data to populate the connection info that is
> later used for NFC data exchange.
> 
> This can be triggered from userspace via the virtual_ncidev interface
> by injecting a short CORE_CONN_CREATE_RSP frame.
> 
> Add a length check for the full response structure before accessing
> any field beyond the status byte.
> 
> Fixes: 736bb9577407 ("NFC: nci: Support logical connections management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

This patch looks good to me but as noted collectively by Greg and Paolo
elsewhere:
1. Please include an Assisted-by tag
2. Please keep the number of patches in-flight to 15 or less

When you repost feel free to include:

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: changes-requested
