Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D963DFC6A;
	Thu, 10 Sep 2026 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034113; cv=none; b=LMMEGtjGdj4uIrpWJsR7gbWujpKOT7Mo3VMt7vQ02hWKFH+gWygJC3Q+l4cDPzmOAj6TsRNOmPG3GcQBRZkCLt6Z2VJg8KtAMNnxVOW+PKxY8mLO9LYNzWC2Mge20XH7qRuYoojqlR38WrfTUJFHI2K4ERMRr/QBf1ouJCdbJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034113; c=relaxed/simple;
	bh=/QXT0GdOQociyNbrz6gN+mtclJctW8VXaSpd6QYjp9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1wNouKH0raZ7Cubkv//u8reE2poCNlYfPJvH+QvLBYgTKrSQlnOhu7+g9Ltg3Q+V89knWSqAODEiJVMVQTxgBMcAdeJKtCmisUPWFjUuftELZtgnk/vgetc1hoUQu6foTtNwGDapXK8WDPEHG1E/utwqqaLesAgHYuluMgRw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLENdEUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLENdEUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF22A1F000FF;
	Thu, 10 Sep 2026 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789034111;
	bh=BmSSky3hyFy6mmE+3o3MyygF52Qy8I4FePOByatPPOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cLENdEUqL3bMbUXPeOqSP/TwD2Pio66YJdCuMrPrTfr2vwhfl+qUo8sjwGpnuZcNl
	 sXT8bkneDQpgljj6Gp6us5hlEpu2htkZyZxRYLw5GwOwnRuh/J+WmbfLqiNUrERTn/
	 tjqoYpZZBagbkXpiLdxeigF1FIY7IXLPDK/8JddJpsWdnx+TTKWKSDFVWRAc7LgAXF
	 z0FNbEkfvyiuFNtJTHAK31vPXN5354ExqIfjjF5cLTRGuiifhsLpi40VqbKrTf0sqs
	 jwOoSyjBjWLizbweneAAJ/ZX7/17ekcagqP00XwNosD7QaXTmJMSVcwFF4lJXCWODh
	 4ZEqSy8WjbGlw==
Date: Thu, 10 Sep 2026 10:55:08 +0100
From: Simon Horman <horms@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: David Heidelberg <david@ixit.cz>, linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nfc: digital: check DEP_REQ length before reading DID
 byte
Message-ID: <20260910095508.GS40544@horms.kernel.org>
References: <AS8P251MB000196084524EB27D62162B8C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB000196084524EB27D62162B8C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Mon, Sep 07, 2026 at 12:36:54AM +0100, Aamir Ahmed wrote:
> digital_tg_recv_dep_req() reads resp->data[3] when the DID bit is set
> in the PFB, but only sizeof(struct digital_dep_req_res) bytes (3) are
> guaranteed by the preceding length check.  A crafted DEP_REQ that is
> exactly 3 bytes long with the DID bit set causes an out-of-bounds read
> past the valid skb data.
> 
> This read can happen on every DEP_REQ from a malicious NFC initiator
> when the target device has a non-zero DID.  The stale byte is compared
> against ddev->did, so in practice the mismatch causes an -EIO return,
> but the read itself is undefined behavior and accesses data past the
> buffer.
> 
> Reorder the condition so that the length check (resp->len < size + 1)
> comes first and short-circuits before resp->data[size] is accessed.
> The existing fallthrough to the later "size > resp->len" check is
> preserved for the NAD case.
> 
> Fixes: 1c7a4c24fbfd ("NFC Digital: Add target NFC-DEP support")
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
