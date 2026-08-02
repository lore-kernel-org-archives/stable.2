Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7F2264C7;
	Sun,  2 Aug 2026 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785694900; cv=none; b=Pd5V4GNa7KrdyHQ+9UL4viujztDZ5E1M2FYLsIKiZu/DvgUKvk6C+8YvUWln66YM+YVEZrlqDs600a+8n1Iwkvm0407psRj5V41pzAos0gncwULuLSCHoZ7SHh9CUPjleX099TwPEUTFTfX+OfnkbrlYnyPcOBTAga0Aob1as58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785694900; c=relaxed/simple;
	bh=hPkBZ27HYMyLAEw2FJZJtqjWp2w6rYlCI/CvQM3Vu04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFFkxRgBw0P83VQVnxuQJyg6c28Pu1aLrunNLSyXIs0hH9bfz7OyR6gOxsLsiGlHhbgZI8te5ey8Nu0ch3fVjAAPeSDUb4/eEWuUliNE8KO52Ir7CDefXgMU+b0ksq5euoFPAkhM8ljYtPBjhdFPiUNYvOhnsZM3RfQ8It49W1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKWVNDUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKWVNDUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591461F000E9;
	Sun,  2 Aug 2026 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785694898;
	bh=5CPWfFeyUhmK9l6Bga30vy6fwbQtui3iKRb3sQay5v0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MKWVNDUeyRtW12tXN2MfEw5tz03VzWB8PqrI6WlLJr+EQfGn2p+i2UXpjEPr2GYk+
	 DG0JAjGBv4m1ofhJgVHQmQXXIIehf8cg5Mqhp47/GfGkcz0kxV6QRR1MrZr8dYhM41
	 qtAFABFzkQcTfiIjfYnAu4+3T/dL35pJbcxlYmKsGhWaNYHhlxqKXPYVsyQdqum/CP
	 By1WfUk5eOdnyUvzT1j+k6yw5aYf7PR6XbLXa+LOHRkS0/PZGVKJC7zpD8weDL5SwB
	 CMg9otpW/tYv2f3zzdrstFBgqw+cIfyXmuuqBL5j9hW0IKf+8kJ6QtLn2vl+mZ9Jl5
	 1G5DjgjaAkhLg==
Date: Sun, 2 Aug 2026 19:21:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, shuaijie wang
 <wangshuaijie@awinic.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: aw96103: validate firmware data length
Message-ID: <20260802192134.32a0349d@jic23-huawei>
In-Reply-To: <20260801193700.57457-1-acharyalaxman8848@gmail.com>
References: <20260801193700.57457-1-acharyalaxman8848@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 01:22:00 +0545
Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:

> The firmware parser reads a length from the binary header and then uses
> it to walk six-byte register/value entries. A truncated firmware image
> can make the parser read beyond the copied firmware buffer. A value
> smaller than the four-byte count field also underflows, producing a very
> large length.
> 
> Read the little-endian field with get_unaligned_le32(), as previously
> proposed by David Lechner. Validate the header size, reject an
> underflowed length, ensure the resulting payload is contained in the
> firmware image, and require it to contain whole register/value entries.
> 
> Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
> Link: https://lore.kernel.org/r/20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Looks fine to me, but I'll leave it on list a little while so others
have time to take a look, ideally including Shuaijie Wang

Thanks

Jonathan

> ---
>  drivers/iio/proximity/aw96103.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> index 8fbb755dc..8352d51e5 100644
> --- a/drivers/iio/proximity/aw96103.c
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -24,6 +24,7 @@
>  #define AW96103_BIN_VALID_DATA_OFFSET		64
>  #define AW96103_BIN_DATA_LEN_OFFSET		16
>  #define AW96103_BIN_DATA_REG_NUM_SIZE		4
> +#define AW96103_BIN_REG_SIZE			6
>  #define AW96103_BIN_CHIP_TYPE_SIZE		8
>  #define AW96103_BIN_CHIP_TYPE_OFFSET		24
>  
> @@ -229,14 +230,27 @@ static const struct aw_chip_info aw_chip_info_tbl[] = {
>  	},
>  };
>  
> -static void aw96103_parsing_bin_file(struct aw_bin *bin)
> +static int aw96103_parsing_bin_file(struct aw_bin *bin)
>  {
> +	u32 data_len;
> +
> +	if (bin->len < AW96103_BIN_VALID_DATA_OFFSET)
> +		return -EINVAL;
> +
> +	data_len = get_unaligned_le32(bin->data + AW96103_BIN_DATA_LEN_OFFSET);
> +	if (data_len < AW96103_BIN_DATA_REG_NUM_SIZE)
> +		return -EINVAL;
> +
> +	bin->valid_data_len = data_len - AW96103_BIN_DATA_REG_NUM_SIZE;
> +	if (bin->valid_data_len > bin->len - AW96103_BIN_VALID_DATA_OFFSET ||
> +	    bin->valid_data_len % AW96103_BIN_REG_SIZE)
> +		return -EINVAL;
> +
>  	bin->valid_data_addr = AW96103_BIN_VALID_DATA_OFFSET;
> -	bin->valid_data_len =
> -		*(unsigned int *)(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
> -		AW96103_BIN_DATA_REG_NUM_SIZE;
>  	memcpy(bin->chip_type, bin->data + AW96103_BIN_CHIP_TYPE_OFFSET,
>  	       AW96103_BIN_CHIP_TYPE_SIZE);
> +
> +	return 0;
>  }
>  
>  static const struct regmap_config aw96103_regmap_confg = {
> @@ -500,7 +514,7 @@ static int aw96103_bin_valid_loaded(struct aw96103 *aw96103,
>  	int ret;
>  
>  	for (i = 0; i < aw_bin_data_s->valid_data_len;
> -	     i += 6, start_addr += 6) {
> +	     i += AW96103_BIN_REG_SIZE, start_addr += AW96103_BIN_REG_SIZE) {
>  		reg_addr = get_unaligned_le16(aw_bin_data_s->data + start_addr);
>  		reg_data = get_unaligned_le32(aw_bin_data_s->data +
>  					      start_addr + 2);
> @@ -550,6 +564,8 @@ static int aw96103_para_loaded(struct aw96103 *aw96103)
>  static int aw96103_cfg_all_loaded(const struct firmware *cont,
>  				  struct aw96103 *aw96103)
>  {
> +	int ret;
> +
>  	if (!cont)
>  		return -EINVAL;
>  
> @@ -561,7 +577,9 @@ static int aw96103_cfg_all_loaded(const struct firmware *cont,
>  	aw_bin->len = cont->size;
>  	memcpy(aw_bin->data, cont->data, cont->size);
>  	release_firmware(cont);
> -	aw96103_parsing_bin_file(aw_bin);
> +	ret = aw96103_parsing_bin_file(aw_bin);
> +	if (ret)
> +		return ret;
>  
>  	return aw96103_bin_valid_loaded(aw96103, aw_bin);
>  }

