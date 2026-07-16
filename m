Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490583F88BE;
	Thu, 16 Jul 2026 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196607; cv=none; b=mRxahqXHpI/twRa0w59NHc2AXzfDR1LHeYCVB0f0fWrdceOLn+sIZCv+ri/0+WsZomcWJ7ZvgByPXmEpDBTBMkGAzud4l3UQq47T2Yb0oV5S2ERQAB4QcsTgD3ztfFAzM7kgWW1Ju3T6jGwKZymDPk3PZY2F2vvC0XN2128X6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196607; c=relaxed/simple;
	bh=6dI4LrN2rac5vpS0VtXLhxk9jhVaPdOUsppC7PwadeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYXmSxs+alXIHEydzt3WddShnoB4CIeAW0eLn/69R2LoRa+5CvvMW2mRpHCfeuWLC8cFVB44xRwrhxVJ5GpC6guLZUELo29rhxVIumDLFoqS6qoVYokjfsYc/4AcGZmdbGCTdMhhGKgTK1hIQOU+eA96g4jmy1fkMFiEEdjW2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/rLm2Nr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/rLm2Nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3EA1F000E9;
	Thu, 16 Jul 2026 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784196604;
	bh=Ho3qOuPHccaSzVJZUIKFsHF2ay53CDEw45Om5Sv7AfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b/rLm2Nry19Iru8u98b7gJZGZLxrzKj13pA6YlqPDZ6tiOuxU9+oP1TvVMSrOpNKc
	 6X0LBueKg6wVaAjEcffZgZvhuEc2v+PNGL/Fe4s6NzPNEH75Dmz5yabBtyX5tHuJfO
	 cmsebPE/wwzTTeLswd6Yewx1ErUwkvtoDDNa9az+3xTfJwRB7Kltai7cUV3AZ2soS3
	 PHUSz+t8FLr4h94Bwp6GDti5YtLkqBplnnkMqZvrQERyMwY4xvoAlnWwq9oy0WwjUn
	 NSIPlH8cQQZ5WYqt35gfV+iFa6d3GT03tOMx6l4cxk2+3K5I0hfwSFqjsk7N6jysbL
	 +d32iAAS8nxwQ==
Date: Thu, 16 Jul 2026 11:09:59 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	phoebe.buckheister@itwm.fraunhofer.de, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: llsec: reject frames shorter than the
 authentication tag
Message-ID: <20260716100959.GH95246@horms.kernel.org>
References: <20260709131246.44517-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709131246.44517-1-doruk@0sec.ai>

On Thu, Jul 09, 2026 at 03:12:46PM +0200, Doruk Tan Ozturk wrote:
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
> Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Simon Horman <horms@kernel.org>

