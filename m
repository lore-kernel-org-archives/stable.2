Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8B39D6F6;
	Mon, 20 Jul 2026 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542588; cv=none; b=FTYge3dzLSBlP2xAlvGQWRTeLQjXyc4XVjY643uZbzIxdnc6PdoNP4/72Rq/VLQUJD3E8GMXqPCC7VIKHbKPqrZtiZuccfXvMKPDQYi/NkFXSbP2T1J70MSy4tf1dPci7o9X2zInqbP4XgVRc5cI8LSBnGZGBA0KS7qZlO3riKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542588; c=relaxed/simple;
	bh=ADieEAaK+o/Nq+SJZXlvHtDRxqqoa7X3zkOwV/cZgvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYWmW1jm60CtxqBTXq6YjfHttVrq8+jwegEyZbYG3zNeHwO7U0203kW785stFHmj3N6vhDHcN+THu5n+pPVSwn1f4HR9LqP1EEgaYrXvtfB9JggK1JO9zFJ927tXLFsSpbwiXYwjJk1CvZUEfnFfstxn0wW/B6//6JAk9aFE3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UChYx/C5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UChYx/C5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3561F000E9;
	Mon, 20 Jul 2026 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542583;
	bh=n/XiRnjoecUPvWsrdRPiHusws6HknDHs3oFMmApiOYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UChYx/C5FGO7HfNHbwR++D3PSCQSBZgFQLYcruzcCFCo2cFw7dqIAvJGQRiX6AdRG
	 +FSw7OTGCqZGI2/sZuIDXTIG3sirJJFW+qxR1jIx0+AhptddpnKhNrvMD7Tkq5WvSQ
	 c250jtbAXoDWVjHj1ieX8wUMoHNcuVchJVfLVSdUGl6bxidXxBSGTT8Yz80e3hHztW
	 WUnsuaZfhBzRUrf3ZTAc9x/q+TOMUZxq0rcKwgZh3lGg1LJ5MvqrMXKX7TlHtwmfiH
	 /mpK5yvcHNbrZf2y8p3V4Y7U5tje4okDFGTfSdio7i0xhZnEtZx0JLRsJAg6BsYEMb
	 JQfPeGcgHRwOA==
Date: Mon, 20 Jul 2026 11:16:20 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: fdp: bound the device-supplied read size in
 fdp_nci_i2c_read()
Message-ID: <20260720101620.GD19108@horms.kernel.org>
References: <20260711123641.32502-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711123641.32502-1-doruk@0sec.ai>

On Sat, Jul 11, 2026 at 02:36:41PM +0200, Doruk Tan Ozturk wrote:
> fdp_nci_i2c_read() reads a "length packet" from the FDP I2C controller and
> computes the size of the next I2C transfer from two device-supplied bytes:
> 
> 	phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
> 
> next_read_size is a u16 (up to 65535) and is never bounded. On the next
> loop iteration it is used directly as the length passed to
> 
> 	i2c_master_recv(client, tmp, len);
> 
> which reads into the fixed 261-byte stack buffer
> tmp[FDP_NCI_I2C_MAX_PAYLOAD]. A malicious or malfunctioning controller
> that reports a large length thus overflows the stack buffer -- the
> r != len check runs only after the read has already happened.
> 
> Reject a next-read size larger than the buffer and resynchronize.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis; the
> missing bound is evident from source. Compile-tested.
> 
> Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>  drivers/nfc/fdp/i2c.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
> index c1896a1d978c..581f85f0dfa8 100644
> --- a/drivers/nfc/fdp/i2c.c
> +++ b/drivers/nfc/fdp/i2c.c
> @@ -128,7 +128,7 @@ static const struct nfc_phy_ops i2c_phy_ops = {
>  
>  static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
>  {
> -	int r, len;
> +	int r = -EREMOTEIO, len;
>  	u8 tmp[FDP_NCI_I2C_MAX_PAYLOAD], lrc, k;
>  	u16 i;
>  	struct i2c_client *client = phy->i2c_dev;
> @@ -140,6 +140,13 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
>  
>  		len = phy->next_read_size;
>  
> +		if (len > FDP_NCI_I2C_MAX_PAYLOAD) {
> +			dev_dbg(&client->dev, "%s: read size %d too large\n",
> +				__func__, len);
> +			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;

I think it would be more robust to explicitly set r here.
Because it is assigned a little later in the loop, overriding
the default assignment made by the first hunk of this patch.

> +			goto flush;
> +		}
> +
>  		r = i2c_master_recv(client, tmp, len);
>  		if (r != len) {
>  			dev_dbg(&client->dev, "%s: i2c recv err: %d\n",
> -- 
> 2.43.0
> 
