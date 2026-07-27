Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA13EC2EF;
	Mon, 27 Jul 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144182; cv=none; b=FMcLqa9h6jgCkCDj+vbITe/mnkn9LSoiXeVQ8hleRttBr6mj7OIwDvsASpeiaE8D+cQduAzcInyI2wuyqKpiM1TmoZKD/OlpDq3aP8d+QvY0FfYUNpxfXD71AiAj63yuAH/+GaO7aJH9Na4KjAxzlaH3HiC/CktbN7g7ohZGlIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144182; c=relaxed/simple;
	bh=Aq7Xx8RN0Aam4PcHl1ksNog+jw6pV/ux9vUMF4j1NDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLUUiUFg4BGswsLXOiCiLygxOzuSDJd6v/LoUHpc4Ba8dmNOw+401KIRYLgjOJK4NRtX9lMphzP+0SvCQ7CFC3Vv4VTvJha2LymkYnNLDv5CdRg2/aPqH63MAzg8psLGfmqvgDV6YrNdC3f6MQ3rYkQmc33BHAtKvwLQLsJ3unY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fwRDRBhP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fwRDRBhP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HMDpemX2Wma5wES+uuhA5G3MmPT3N+qWvRq6j+AtLLo=; b=fwRDRBhPm0SWfA97iztHBa523P
	vZwROc7sW+gj5arfzuC7l2ixLoV9aootpdfPzaHUfs8tUWvHL/U/bGgS0jMCcNBHRg1GJvW0/iX9p
	OGpYDUErOFIXdeea8WClybs8N3vhecrdaOVNWq2nUwbKznXydpk6pdp9x2MLV7EbAduDgCLz15hTC
	PDUn4fnkr5m2suFGkx5G2LzIrQ+zRkW2G+CV+/JbskxI2MGFWZNDoJtLjuvyDwoGp8KL2cgqCJrce
	WhUO56rN/96MeeHLkbQCoD384L4N+OqCOIuf+L6IcJiq5MeNRCbiBajM0PmrEolrrCO5f3I50wNcU
	F5AVWHAA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woHXg-006nCm-0s;
	Mon, 27 Jul 2026 09:22:36 +0000
Date: Mon, 27 Jul 2026 02:22:30 -0700
From: Breno Leitao <leitao@debian.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, 
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] mac802154: llsec: reject frames shorter than the
 authentication tag
Message-ID: <amcjRpwqwRH7wi9h@gmail.com>
References: <20260716193423.32498-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716193423.32498-1-doruk@0sec.ai>
X-Debian-User: leitao

On Thu, Jul 16, 2026 at 09:34:23PM +0200, Doruk Tan Ozturk wrote:
> llsec_do_decrypt_auth() computes the associated-data length for the
> AEAD request as
> 
> 	assoclen += datalen - authlen;
> 
> where datalen is the number of bytes after the MAC header and authlen
> (4, 8 or 16) is the length of the authentication tag. Nothing verifies
> that the frame actually carries at least authlen payload bytes. A
> secured frame whose payload is shorter than the tag makes
> datalen - authlen negative; assoclen is then passed to
> aead_request_set_ad() as an unsigned value close to 4 GiB, so
> crypto_aead_decrypt() walks far off the end of the scatterlist that
> only spans the real frame.
> 
> The frame is fully attacker-controlled and reaches this path from any
> IEEE 802.15.4 peer in radio range. Reject frames whose payload is
> shorter than the authentication tag before the subtraction.
> 
> Dynamically reproduced on a KASAN kernel as a general-protection-fault
> in the AEAD scatterwalk, and the fix confirmed.
> 
> Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Breno Leitao <leitao@debian.org>
