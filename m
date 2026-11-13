Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591075;
	b=ltltu65wGnv3kWYdhOvBR38YiJs1VWibQjJO1HBzlo/7Q+RPckXrJcrJ4C22xwPI3n5e
	 qlIj6/X7T2eh9PfWACZucL3hDdtjHD3arVf+cl6dz6eEry1Y1kgDW6w0KgsG51WWVlIQD
	 FGzSu5qHUENOETz7vfoKmx3XTPx2y2SXsjwV9o/mPx2kcEwsZ7U4lY52Ex8aswQJHU76G
	 g3EmQBQBtxIdGV2IQ7twwkym747GcoT3W4a8K865CsoS9150m2w5ZjCTAlZJg8HXJsFcC
	 ck9ujzMMRcmdrWgJ84WOZ9yEJyF9oFPAlvnQjQwDpRRPUa4WfN+2QIfYcttK0mfQpAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591075;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fax9dsDLfWgV2bx85EWAVzVfZQhzYfTnApIR7+ezcww=;
	b=0nG5Q54WBhPf4+O5fJnalW98q9vAnGbRja5ALz9kIO2Ckevy+ICD38O3X4YKzZ5+O9Ya
	 0kvou0VtRO7jZHzNn01TkG1ZOP/SU/kASnFWPt90S9ycY+6e2QKnBSeLEFp2j9qAB0d0E
	 /BD9Vv7pknsjJ0z1dGnZq4qQBqlChOpws8hrEkHwq9iuTJkWYEa7jfapaFdOesxBbH1P5
	 N9/Qo3YnuuuZ6QNNriIgizdAUJyj5JsQHKYNd4oApbdh+FMuoNo+9KDYUPvNkFxxPqtEA
	 rvxIP9ivDyomS3vHv/O5xS8SoGqoiWfxw2uJSgfrR931Ah41SUllubQKh/BzDyRQ1wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JY+usgkm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E6606B35A;
	Fri, 13 Nov 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JY+usgkm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA921F000C8;
	Fri, 13 Nov 2026 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591075;
	bh=fax9dsDLfWgV2bx85EWAVzVfZQhzYfTnApIR7+ezcww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JY+usgkmSJ0sLJLH9HT2wyqRGflYj1R+RXQP5D3LzHR+jL9CcljUGgCkmpaTx3moa
	 HBDKUOmI4viDo9VqgC1+9+1Ry1uXMTgorwmLISYIV6HZ0lPlHvU8di+kpWxmH/IbQy
	 1nuFj6FvQpSJlB8CMrPhgYyTc02FWQGXGylQrs01iTTyyOwOV4ya4t4BfN473YJtDD
	 HcKtuWZaXuLRDbWW+c7qbTf+jy1Wd/wArGqm4uX5Y2298Q7Vv2kVmFuQQ2umv7++LG
	 vOlLLMnNP9vJ9yrwNHLAum3yhv3JZ0rTRPtRoK3y9rOfJZ2y9p4WHTS45jARWBwrDL
	 XmO2ZvHEio1/A==
Date: Fri, 13 Nov 2026 17:31:11 +0000
From: Simon Horman <horms@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nfc: pn533: bounds-check the ATR_RES response before
 parsing it
Message-ID: <20261113173111.GX18859@horms.kernel.org>
References: <20261109110016.1511307-1-hj351016@gmail.com>
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
In-Reply-To: <20261109110016.1511307-1-hj351016@gmail.com>

On Mon, Nov 09, 2026 at 08:00:16PM +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> pn533_poll_dep_complete(), pn533_in_dep_link_up_complete() and
> pn533_activate_target_nfcdep() cast resp->data to the fixed ATR_RES
> header (struct pn533_cmd_jump_dep_response / pn533_cmd_activate_response)
> and, on a successful response, read nfcid3t[] and compute the general-
> bytes length as resp->len - sizeof(header). A short response leaves that
> read past the end of the skb data, an out-of-bounds read; the copied
> nfcid3t reaches userspace via nfc_targets_found() and netlink.
> 
> Only the success path needs the full fixed header: a no-peer/failure
> reply is just the status byte, and the existing failure handling (turn
> the radio off and re-arm polling, or print the error) must keep running
> for it. So validate resp->len >= sizeof(*rsp) after the status check, on
> the success path, in all three handlers, before nfcid3t and the general
> bytes are read.
> 
> Found by code review; not reproduced.
> 
> Fixes: 361f3cb7f9cf ("NFC: DEP link hook implementation for pn533")
> Fixes: 673088fb42d0 ("NFC: pn533: Send ATR_REQ directly for active device detection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
> Changes in v2 (thanks to the Sashiko AI review):
>  - move the length check to the SUCCESS path (after the status check), so
>    a no-peer/timeout reply (resp->len == 1) still takes the existing
>    "turn radio off, re-arm polling" / error path instead of returning
>    -EINVAL and stalling the poll loop
>  - also guard pn533_activate_target_nfcdep(), the third ATR_RES parser
>  - add Fixes: tags for the two commits that introduced the parsing
>  - drop the inaccurate claim that the other handlers already length-check
>    resp->len (only pn533_init_target_complete() does)

Reviewed-by: Simon Horman <horms@kernel.org>

