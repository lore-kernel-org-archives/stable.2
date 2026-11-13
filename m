Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558862;
	b=V+oEAqwqUW2crlm6+2C9XXtgyL1WjbkgkeaESsSUnSXRiE9ZHxOCsAcj9SpJO6v5FItH
	 opGq6TPoNCq82xVndq5AT0GNKCd7mvqEE293pnEhEWtlz7pZ4kHFJH0IF+3VbkRR30qES
	 7p86olbPW42i8n6j129TElgzH4S4Gj/kHmdFPMGQf8QI9ZtE16Xb5FxLglteBO2HMEaYQ
	 xvPtjHQ//aBF4hlWACELsBX8+bBAABQN4ArcOMP5UuSD7z4l31aNKwfdhvFaF+kWdISuE
	 /xAftbCa8KAgm5iZzZj5thIGc4J06j5x74n84ZvXB/hJp/OHe3QfsmifQFb1KJmpXpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558862;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tNwo0+xZaS6cVFmIR9CG6CfkYLZ3ajE6VJv5v7VOxls=;
	b=cJ/6yNo08yIVEejId1Oz4F3PYFuZD2WLFGhLq547G+DA64m296Ae31NAfCS8Cmog/ESU
	 BkRA6x7QvPf4/eS5IbYhghrINZhI4KGcrIMTZy9wzn1vzc/kVfIE0IjDVZCom/MFF1JTa
	 9H11QDKOGo48UQwPd/lPpPZN1gA5xqSGZbLlP8YdKtegjidJwSx5zCGY1HlkIsajBD4zi
	 DnSZTUO+iQrOqa1uvKe+wluIprYdRT0FH77RSW+u7kc9OMQlQ8gaWmtacvoIB1TkV91bq
	 C6qpPTOqN3uX523YjwVhTkL3IHYI9wKBM5P8FPCHlDweqZ8WaKvRokqOCwWGXjSAN7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzTB6CP6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 679B8606A8BB;
	Fri, 13 Nov 2026 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IzTB6CP6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 85EFF1F000CF;
	Fri, 13 Nov 2026 08:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558862;
	bh=tNwo0+xZaS6cVFmIR9CG6CfkYLZ3ajE6VJv5v7VOxls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IzTB6CP6nK5PBAwYpVl4QFtTiOTSIeWIHSTDbkxalqax5QOamAuUg76l93LJIOzDP
	 fC2tuQ2rqGu5GXKNqZELKqUrKXYk0H0dTLa/HTeCGJAnITNYIHyxYVGqcsDb3eLuAc
	 AeBmrZF9C9LZHwRLgKfXq5785itj1OzSCj1gKacN95WKR220KvuSu0rb65OPtpIBur
	 CU5m4fMkrbTBkFl1QSr6ZxT3iGpBdHO/BniG97S3P362I1JG1nwkOkAJs7swbzp++H
	 dc3ndkHbL22Fi+eY9ygRbxk2DMFbc8manzOLdJV3HYO7mwxD0iHV54rpAthegLzTu1
	 FEN7pkt+tUgDg==
Date: Fri, 13 Nov 2026 09:34:13 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 5/5] gpio: cdev: don't overwrite the whole flags field
 when configuring lines
Message-ID: <zjsqztz4seaqxf6owd4qz4hztqvlb23fwcw35yhpzwjgwaudnn@eraewultu4b5>
References: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>
 <20261110-gpio-desc-flags-atomic-v3-5-2f463bce8086@oss.qualcomm.com>
 <20261113031943.GA39484@rigel>
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
In-Reply-To: <20261113031943.GA39484@rigel>

On Fri, Nov 13, 2026 at 11:19:43AM +0800, Kent Gibson wrote:
> On Tue, Nov 10, 2026 at 02:47:05PM +0100, Bartosz Golaszewski wrote:
> > linehandle_flags_to_desc_flags() and
> > gpio_v2_line_config_flags_to_desc_flags() read the flags word with
> > READ_ONCE(), modify the local copy and write it back with WRITE_ONCE().
> > 
> > The per-request config_mutex does not exclude sysfs, the irq core or
> > drivers touching the same descriptor, so bits they set or clear
> > concurrently can be lost.
> > 
> > Build the mask of bits owned by the line configuration and their new
> > values locally and apply them with gpiod_update_flags(). The whole
> > group changes in a single atomic step.
> > 
> > While at it: rename the functions whose semantics changed from
> > "conversion" to "flags update" accordingly.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: b7adfb6076ff ("gpio: cdev: update flags at once when reconfiguring from user-space")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > ---
> 
> Reviewed-by: Kent Gibson <warthog618@gmail.com>
> 
> for the series.
>

If it's for the series, would you mind leaving the tag under the cover
letter so that b4 can pick it up automatically?

Thanks,
Bartosz
