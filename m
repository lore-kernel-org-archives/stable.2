Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1571E0B9C;
	Fri, 26 Jun 2026 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483887; cv=none; b=RQyiHiYcH7CdVKeMxORSfIcAfbvbdqmLQCZhhTED3DsMwiReeslKop1Gzwi2Nhl6Ej0R44uDfFKzGRVEYFIRqJiMdl/OdyMfIWF7hLlseqJ4GNom8R4CGa4MkhZ5lqTJqEvBae+VYMHx8d6e/obQYa4+VPM4ELy5LEVJwqSdhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483887; c=relaxed/simple;
	bh=iaGbTeNWfDSFa3+5nTmAN7Uc2qeCXJC0fBuvx1TwUZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6NZgnwwbT5PqRd1UG4Tz5ldnPH6jRJTp12C7kqww42BwcP9ypG1zJBhY/84TFsqJlrt5/r1M/khZYuZvTgmZK41WoyunAF/0enJIYo2U/0i+n4Xbt/4Ogf7hMEFpEwiu4m7jGAkPkpOgYe61LVW8OBrPAb1TnDSRQ/idyjgLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz3tzz3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz3tzz3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55341F000E9;
	Fri, 26 Jun 2026 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782483886;
	bh=Mkn8U/T2t19BjplBUXcZxx6hDvkfAvfyMrjZYYRRg98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xz3tzz3jPpCkDfX+76Gw0MAXiQrOIZqVk8nCmB+5oaeaqXSW1x6rXmQBkN3XhkH6o
	 M1pz2TPeBYiX8GQ5Zqm2uDk+jRr/977sw1D2iGhk9U7olbJwdoJ78hLSuwQRDZ1ySv
	 IHvVAnou21cSc8nD7TMxjc6Tl58LRjfKHLAQhNu1FW1fDzE8vZZAadiQqTvi+muJ2N
	 6L4CuPptMO6HC7cbmdmV2oWpAjJYv2vCPeRVXjsGJNemieaK392oVYIHwauaMZ8yBs
	 qtcqrYWhc19ReP95hF5XkWqcQ6O3Euls8Xz3i4hu/OUQwCB0QhrTphMMlV+DF7XY3Z
	 J0O/YBizptvhw==
Date: Fri, 26 Jun 2026 08:24:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix dio->ref leak on integrity error in
 __blkdev_direct_IO()
Message-ID: <aj6LrNre8nPaP_p7@kbusch-mbp>
References: <20260625092106.47695-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625092106.47695-1-vulab@iscas.ac.cn>

On Thu, Jun 25, 2026 at 05:21:06PM +0800, Wentao Liang wrote:
> @@ -239,8 +239,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  		}
>  		if (iocb->ki_flags & IOCB_HAS_METADATA) {
>  			ret = bio_integrity_map_iter(bio, iocb->private);
> -			if (unlikely(ret))
> -				goto fail;
> +			if (unlikely(ret)) {
> +				bio->bi_status = errno_to_blk_status(ret);
> +				bio_endio(bio);
> +				break;
> +			}

I've submitted this same fix earlier:

  https://lore.kernel.org/linux-block/20260624170905.3972095-3-kbusch@meta.com/
