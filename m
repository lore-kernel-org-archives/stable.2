Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD249E12F;
	Mon, 21 Sep 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997395; cv=none; b=Lc/g6AvbniTN/u8EHeVCjjZUBFUjz5lzPEPHzMWAl+SsJY//O9MbO9t8HV9JoG34gMJ80QLXxVcakLuGAN64dbcwoorAVnMmTorNBEwNGb0OLnJMp9i3blLKaFTZgm0yK1U7zkOpHHPxA//Z2iiNZmI0H6h+agYXT/RNEBXzUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997395; c=relaxed/simple;
	bh=u6LARA2BHHrCOPC4emuepshoPChdUK1N82NLexkUVy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcosUBu+70qRC+bXgpH5xNTuJeRlx/JY0KWA7d5RYGpRVtP0/g5E526JqyJvzrEETOeaKKGLSFvKPiBjAT6y6R9iYiH3JVt0J0M++AWpSfa4ykf3oP0JonaAfZN7FasBPcKfcwudFH3OiXwtd99AxLW20AgO6H3jBjs/32MGbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG4nHD8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG4nHD8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002431F000FF;
	Mon, 21 Sep 2026 13:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789997394;
	bh=qo8YLb+8AMgGZ0Mty5fhrFkdYnAyoM7ODfWNEFzbmVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZG4nHD8qj7ADkpnqSCfe90NiIC8+DJin45KT3zSnT/h6pYILohTUeoHhbXsv+8Cxn
	 dAojYYm9snY9MihgG2ub6yoeUgnBQZhwbAPK1nVnCtOzrgwU/Zic/wHrCeHfEnLWSI
	 oeUiZG9I1kr9mRO2TVV+P2ah76+eWujRJ3NDwXNdx0TBLehzI14Dp6t6XkRLxgXdwb
	 UUBb921UWAB8V7KeHZCtzm8rbtzp85/GWZqIniPQCvDbNwhuXzplPCM7mhAnVqmLXu
	 Lc//QrVL0hNVilsWkRlnEt1s5cZfG8CzwPfxVKODxW+e8Hu5Vd5dRYln+wJYC/mXfq
	 bfK3zhY/RyfuA==
Date: Mon, 21 Sep 2026 14:29:49 +0100
From: Simon Horman <horms@kernel.org>
To: zjamg <ndaugoing@gmail.com>
Cc: David Heidelberg <david@ixit.cz>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] nfc: nci: do not process unexpected or invalid
 CORE_CONN_CREATE_RSP
Message-ID: <20260921132949.GQ13925@horms.kernel.org>
References: <20260918020412.82878-1-ndaugoing@gmail.com>
 <20260918020412.82878-2-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918020412.82878-2-ndaugoing@gmail.com>

On Fri, Sep 18, 2026 at 10:04:12AM +0800, zjamg wrote:
> From: Yuchao Zhang <ndaugoing@gmail.com>
> 
> When an NCI_OP_CORE_CONN_CREATE_RSP packet is received,
> nci_core_conn_create_rsp_packet() parses it and creates a logical
> connection entry in ndev->conn_info_list.
> 
> However, nci_core_conn_create_rsp_packet() suffers from several issues:
> 1. It does not verify that a connection creation command is currently
>    pending. An unsolicited or delayed CORE_CONN_CREATE_RSP packet
>    unconditionally creates a rogue connection and calls
>    nci_req_complete(), prematurely completing unrelated in-flight
>    requests.
> 2. It lacks bounds checking against sizeof(struct nci_core_conn_create_rsp)
>    for the packet payload, leading to potential out-of-bounds reads.
> 3. It does not validate rsp->conn_id. Dynamic logical connections
>    assigned by the NFCC must not use NCI_STATIC_RF_CONN_ID (0x00) or
>    collide with any existing connection ID.
> 4. It inserts the new connection at the head of ndev->conn_info_list
>    via list_add(). Because connection lookup (e.g. in nci_tx_work() and
>    nci_data_exchange_complete()) uses first-match semantics, prepending
>    allows a newly created connection with a duplicate ID to shadow the
>    static RF connection or earlier connections.
>    Furthermore, ndev->hci_dev->conn_info is mistakenly updated even
>    when the destination type is not NCI_DESTINATION_NFCEE because
>    cur_params.id and nfcee_id both default to 0.
> 
> Fix this by:
> - Adding an NCI_CONN_CREATE_PENDING flag in enum nci_flag to track
>   in-flight connection creation commands, and rejecting unsolicited or
>   delayed responses.
> - Adding packet length verification before reading payload fields.
> - Rejecting responses that allocate NCI_STATIC_RF_CONN_ID or duplicate
>   existing connection IDs.
> - Appending new connections with list_add_tail() instead of list_add().
> - Restricting ndev->hci_dev->conn_info assignment to NFCEE destination
>   types.
> 
> Fixes: 736bb9577407 ("NFC: nci: Support logical connections management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
> ---
>  include/net/nfc/nci_core.h |  1 +
>  net/nfc/nci/core.c         |  2 ++
>  net/nfc/nci/rsp.c          | 37 ++++++++++++++++++++++++++++++-------
>  3 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
> index 664d5058e66e..a4652ffc173d 100644
> --- a/include/net/nfc/nci_core.h
> +++ b/include/net/nfc/nci_core.h
> @@ -31,6 +31,7 @@ enum nci_flag {
>  	NCI_DATA_EXCHANGE,
>  	NCI_DATA_EXCHANGE_TO,
>  	NCI_UNREG,
> +	NCI_CONN_CREATE_PENDING,
>  };


Hi,

This patch seems to use a similar mechanism to another patch that
you recently posted

- [PATCH 1/1] nfc: nci: ignore unexpected CORE_RESET_NTF
  https://lore.kernel.org/netdev/20260918013337.82214-2-ndaugoing@gmail.com/

I forwarded an AI-generated review in response to that patch
and I am concerned that this patch has similar issues centred around:

* Use of a single-bit gate, in this case NCI_CONN_CREATE_PENDING, may
  match against a late-arriving packet for an earlier request
* Concurrency between a work queue handler and other execution paths


As this patch seems related to the one at the link above I would suggest
either concluding one first.  Or provided any updated versions in the form
of a patch-set that includes both patches.  And I would suggest the first
of those options would lead to a faster conclusion.

...
