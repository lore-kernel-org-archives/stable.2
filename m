Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C53603DB;
	Fri, 21 Aug 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355113; cv=none; b=j4NbqLsNwjA70YYhwi9PrAb2YH7wlsnrNmd1GuPVdJ5QknHYfdfLcmQuhY43Z5zNe7qraP9TITVa/24S4ktjfnOM8Qrlq7IeryR0PibI/QaYtV6yawJMjTqesxtwXDV7yYvpjfZWdu7b+u7i0U1aOZbnFNY241xhikuYpNyQv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355113; c=relaxed/simple;
	bh=j5UpYRHlqi7sh0mnbdgsDL/S7j546To1ben8m5Rsn0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMgunbKgq+lAAxF+9uWxkX8lCC8Z60sXrsYbwkT00MU1OOpS9TeI+NQWVmg66mDW79gp7qQu6ES3kMEahIxOAvVox5X3ckfAQpsRg7xtHRY1kU0Z7UCeGd+arA+dzCqUgGWlWYuuWUfPDZfbxnLH48AaVd1EIAyml0gP2jiEz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVdz7RXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVdz7RXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B8A1F000E9;
	Fri, 21 Aug 2026 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355111;
	bh=rCp/jY0222VSJZl4mUd75jNTGtXAjtUuGODwa389Jvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lVdz7RXmwiQxPdZ8EpKvdYh2XjQbhfGvMiNoylnXHdUp5+SMOfmIGPpOQXsg/s6OQ
	 xFWDueT4IHRgyucqkHqPnlIubMTFt0l/oq9d8ibunWANUwVO3Irr9JdC1WK0oLFEQo
	 h9tNuFkpjpIvwfnuD4UO9yxghLDkcu3F8q5DtGikMBjPvUI8huPeoydGar+TBfd4bR
	 dtkpJTh1vCmdq1+I554k1hJbfPycvx8xmMMG7EVsmErQQbBPAOyRHvLEtLTAwj07U2
	 EK/AhCwaoJGx0v8uWWcdsYLvsuTX5iAXdn2rvUPAe6sCUe0EPUvSldhRHvNHm//8yn
	 yULw49NT/Gd9w==
Date: Sat, 22 Aug 2026 00:31:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, shuaijie wang
 <wangshuaijie@awinic.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: aw96103: validate firmware data length
Message-ID: <20260822003146.4962e329@jic23-huawei>
In-Reply-To: <20260802192134.32a0349d@jic23-huawei>
References: <20260801193700.57457-1-acharyalaxman8848@gmail.com>
	<20260802192134.32a0349d@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 19:21:34 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun,  2 Aug 2026 01:22:00 +0545
> Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:
> 
> > The firmware parser reads a length from the binary header and then uses
> > it to walk six-byte register/value entries. A truncated firmware image
> > can make the parser read beyond the copied firmware buffer. A value
> > smaller than the four-byte count field also underflows, producing a very
> > large length.
> > 
> > Read the little-endian field with get_unaligned_le32(), as previously
> > proposed by David Lechner. Validate the header size, reject an
> > underflowed length, ensure the resulting payload is contained in the
> > firmware image, and require it to contain whole register/value entries.
> > 
> > Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
> > Link: https://lore.kernel.org/r/20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>  
> Looks fine to me, but I'll leave it on list a little while so others
> have time to take a look, ideally including Shuaijie Wang

Long enough - applied to the fixes-togreg branch of iio.git.

Note, I'll be rebasing on rc1 before sending this out so there is
still time for additional feedback.

Thanks,

Jonathan

> 
> Thanks
> 
> Jonathan
> 
> > ---
> >  drivers/iio/proximity/aw96103.c | 30 ++++++++++++++++++++++++------
> >  1 file changed, 24 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> > index 8fbb755dc..8352d51e5 100644
> > --- a/drivers/iio/proximity/aw96103.c
> > +++ b/drivers/iio/proximity/aw96103.c
> > @@ -24,6 +24,7 @@
> >  #define AW96103_BIN_VALID_DATA_OFFSET		64
> >  #define AW96103_BIN_DATA_LEN_OFFSET		16
> >  #define AW96103_BIN_DATA_REG_NUM_SIZE		4
> > +#define AW96103_BIN_REG_SIZE			6
> >  #define AW96103_BIN_CHIP_TYPE_SIZE		8
> >  #define AW96103_BIN_CHIP_TYPE_OFFSET		24
> >  
> > @@ -229,14 +230,27 @@ static const struct aw_chip_info aw_chip_info_tbl[] = {
> >  	},
> >  };
> >  
> > -static void aw96103_parsing_bin_file(struct aw_bin *bin)
> > +static int aw96103_parsing_bin_file(struct aw_bin *bin)
> >  {
> > +	u32 data_len;
> > +
> > +	if (bin->len < AW96103_BIN_VALID_DATA_OFFSET)
> > +		return -EINVAL;
> > +
> > +	data_len = get_unaligned_le32(bin->data + AW96103_BIN_DATA_LEN_OFFSET);
> > +	if (data_len < AW96103_BIN_DATA_REG_NUM_SIZE)
> > +		return -EINVAL;
> > +
> > +	bin->valid_data_len = data_len - AW96103_BIN_DATA_REG_NUM_SIZE;
> > +	if (bin->valid_data_len > bin->len - AW96103_BIN_VALID_DATA_OFFSET ||
> > +	    bin->valid_data_len % AW96103_BIN_REG_SIZE)
> > +		return -EINVAL;
> > +
> >  	bin->valid_data_addr = AW96103_BIN_VALID_DATA_OFFSET;
> > -	bin->valid_data_len =
> > -		*(unsigned int *)(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
> > -		AW96103_BIN_DATA_REG_NUM_SIZE;
> >  	memcpy(bin->chip_type, bin->data + AW96103_BIN_CHIP_TYPE_OFFSET,
> >  	       AW96103_BIN_CHIP_TYPE_SIZE);
> > +
> > +	return 0;
> >  }
> >  
> >  static const struct regmap_config aw96103_regmap_confg = {
> > @@ -500,7 +514,7 @@ static int aw96103_bin_valid_loaded(struct aw96103 *aw96103,
> >  	int ret;
> >  
> >  	for (i = 0; i < aw_bin_data_s->valid_data_len;
> > -	     i += 6, start_addr += 6) {
> > +	     i += AW96103_BIN_REG_SIZE, start_addr += AW96103_BIN_REG_SIZE) {
> >  		reg_addr = get_unaligned_le16(aw_bin_data_s->data + start_addr);
> >  		reg_data = get_unaligned_le32(aw_bin_data_s->data +
> >  					      start_addr + 2);
> > @@ -550,6 +564,8 @@ static int aw96103_para_loaded(struct aw96103 *aw96103)
> >  static int aw96103_cfg_all_loaded(const struct firmware *cont,
> >  				  struct aw96103 *aw96103)
> >  {
> > +	int ret;
> > +
> >  	if (!cont)
> >  		return -EINVAL;
> >  
> > @@ -561,7 +577,9 @@ static int aw96103_cfg_all_loaded(const struct firmware *cont,
> >  	aw_bin->len = cont->size;
> >  	memcpy(aw_bin->data, cont->data, cont->size);
> >  	release_firmware(cont);
> > -	aw96103_parsing_bin_file(aw_bin);
> > +	ret = aw96103_parsing_bin_file(aw_bin);
> > +	if (ret)
> > +		return ret;
> >  
> >  	return aw96103_bin_valid_loaded(aw96103, aw_bin);
> >  }  
> 
> 

