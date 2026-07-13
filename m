Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E834DB74
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974848; cv=none; b=CsfuJnmmH0TejsM3WE3OZ8E8eWDlIGx3VOt8fYkY5lGZteihR5CeE6Ae81E26+1yyR3DHj4hWp6CJZwLjL2YSuuSJeeJPiUgl5k+MbQRkTDqo4hNavoSCvedkBRwSK9E7xu6B2SoyObJn9RPocuW2ZQChg4Qch75ljKVvG/sFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974848; c=relaxed/simple;
	bh=bIN1WVwlJsIk3XUFK6DVhfVx5Wq6A7sl0kQ0alXHYlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksMGp//zEwxz4T+9SSjigXwVaUso9e5zisQYx9vYMUN4ShT4JUpWftvcyeW7UKNCRDKq05NPPH6jd+zlBH1optGvT6rCa++qr4Svul1fIzsOBBJaKeHsT0Zt1ZEGprk2RmOJe+UEWQGKcGWOrkyFwLYvpVwo5G8ao9NcVDBS2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGx4t0sO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGx4t0sO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982F21F000E9;
	Mon, 13 Jul 2026 20:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783974847;
	bh=+gFjaJaBNq9lBRWf9QpaDh44lEpy7F8oLdWT0GazOIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OGx4t0sOyfjHCNVWtthCkVdxzn6CAY3nvonyNxBUPf3t7ofkwX5K6gR0biZbQnWpW
	 4oZR2pMFw2Flf+Opq6VvTIeKgEbDD7+Un5Ed8FzD76yKBiqpx3jSnt3tRfeHW5YMG8
	 MuPy/iWWcE19bmrq3OmB24C3iTQqZZrFhfpJcWRFm+es+R6ulLxwmM0KmNhWwY05yX
	 1YLjZv+pTfqlGhW0sRv320oeKV8uNm4fLrrHa1T+bmkYbQh9erHfNTVtbA+HaU5qXu
	 eLIAcy3qS8dAXQ970b3NlOSx4UV4y2OzVGjPNRaqMNF1QnGbfi8A67n3HK5QY6TNpv
	 v6fRmdiUREhIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	almaz.alexandrovich@paragon-software.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Sudheendra Sampath <giveback4fun@gmail.com>
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Change new sparse cluster processing
Date: Mon, 13 Jul 2026 16:34:01 -0400
Message-ID: <20260713131907.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713054907.1262553-1-giveback4fun@gmail.com>
References: <20260713054907.1262553-1-giveback4fun@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> @@ -687,25 +604,11 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
>  			 */
>  			for (; vcn < cend; vcn += clen) {
>  				err = attr_data_get_block(ni, vcn, cend - vcn,
> -							  &lcn, &clen, &new);
> +							  &lcn, &clen, &new, false);
>  				if (err)
>  					goto out;
>  				if (!new || vcn >= vcn_v)
>  					continue;

This hunk removes ntfs_sparse_cluster() but doesn't add upstream's replacement:
a first loop that allocates with zero=true up to cend_v (the valid_size
boundary), followed by the zero=false loop for the rest.

-- 
Thanks,
Sasha
