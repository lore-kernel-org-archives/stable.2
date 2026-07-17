Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8D346E55;
	Fri, 17 Jul 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275549; cv=none; b=rMHLzz6ENcxwj+f7kvNOEytLb9o1FQcdrgth9G17I2MHrCihKaS0ONIPUxIwweu79MB9Fs41XM13xu1hgj8mCkemv23kI9F2mA2lGm1xBmG6Sst+9YZE1mTJh2jZM1KdpPhk/wluZf+C8XQbL7JNEVGkxuSo7SyDuCH+rQuwVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275549; c=relaxed/simple;
	bh=WUYI7873/7p7398lJM8uEipYVBDobCyWOfNN5wilXHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIJeNNZc7K05r4qQpjm2yuT7bb1lYA0v2LHD8NlltgkbcJtJ5NZN8z4jg+zXB8zb9dGXNLfSkoDl7YN+WVwNxDb1Qp22iI5113EElwTPPDZFcgNCuylFxSNseoftG/2xP8K/1RcjC9r0k4KUXNZWcx6mydI692fiMRN5XFVc/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tJYfOtIn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tJYfOtIn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2ldB1QimwkHy+7qBFVXqF6nsMvg3QMUrl4YqPwF9byM=; b=tJYfOtInD5XPdKbAxU+3ZpYVzT
	zpQDseqzrBvUqzOqemJ5xR8cdoOWh3IOrh4SRPM2FofmO0G7t1x0w+Y/tYvNegXeSrMPmkYrybQmN
	NsPZ5t9O5SLViv4mN8epdhMbED86zFKQRnLAcRp5QnJ2Ejb+TtjZO5jSB3ttjS6T/khB6pgHCIPbQ
	jz8Sr3a2NEnJMyNKgjFuQ8GlLt7p2L+y3svwaAYmFhDqbzcDswo7wFmYXc8qro4CktaVbuNA4cdiM
	BtPZJ8tCpldWTJ0fhBLDeRA8O14yPQiY4PjRtlPjI+JKUKyw5OI/vX/FgsalB3eFhgs/YZN0WCJp5
	OU29ySIw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkdZR-004SCd-0p;
	Fri, 17 Jul 2026 08:05:21 +0000
Date: Fri, 17 Jul 2026 01:05:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, 
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] mac802154: llsec: reject frames shorter than the
 authentication tag
Message-ID: <alniMI0L968UYhkq@gmail.com>
References: <20260709131246.44517-1-doruk@0sec.ai>
 <20260716193106.30607-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716193106.30607-1-doruk@0sec.ai>
X-Debian-User: leitao

On Thu, Jul 16, 2026 at 09:31:06PM +0200, Doruk Tan Ozturk wrote:
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

Reviwed-by: Breno Leitao <leitao@debian.org>
