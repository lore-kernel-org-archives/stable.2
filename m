Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795230863;
	b=jX+YG9GBxdnFGIAvHE6QUF7jrbsxzl2zDL0LsnW1nREHbOCSKDpVUZ+6mLxM4ew4vsbp
	 gmQmbJf7VyhoyOsFOSj2sekFt0SFeKXt3yb7YvNgiJz/w4Yrm3jPybyqUTENTmagkwCt6
	 z/boc847tZrvgj7o/aWOS25M5rCGHCESGtM8oqLLE+AByUbnvJsFn2hDQ3QYlL8mEUg+j
	 qOynJ7MbL+A+p28C1c8T5H4pj3r5TxixwwuG/+ZckiTArwwbO+D7OAw5bJFhRV8UnloMl
	 uRKIkOyU+jqJfwnVTT5t4qiTPWYv9oEjhNJhp7tkemI/kbnh33ASFKoYIHomGaKEKsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230863;
	h=Received:DKIM-Signature:To:Cc:Subject:From:In-Reply-To:Message-ID:
	 References:Date:MIME-Version:Content-Type;
	bh=8d6Im6PTk3WGdL/i8PPRCcoHusMyMhbP1LsxiBFyWXo=;
	b=2J5r2CRaZP/dwKoZX+HCLAYoMxLasBfBlaYRiFJEqETK0eqrMrtIC6c0+TBieyjhJUMH
	 GBkCnzEhZuRgAi5u/MRppc3NITdGWuioKOTescIgPmUMEU5jMk2U966G31CmUSCjj/cP1
	 e97TMxa4C8aZK1gE2DaNCzaTgaPB8vvpDVuy90PsYPOXzlg/guejQVn26kvy0XABS33u8
	 NQQwS/GE285RHuH1RsTEXUI4cmUkmcetBkQ9HQhZD3foerGVXEsHjWWfutCOiCTQJTxif
	 6CS98iFoijWeYFu56j9jELAmahsr37RJ2dZSuyQ3dbiCE/qMWfPpG3mo8CAgfcmwPAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehfbIoDd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D606606A334;
	Sat, 21 Nov 2026 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehfbIoDd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6AC1F000C4;
	Sat, 21 Nov 2026 03:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795230862;
	bh=8d6Im6PTk3WGdL/i8PPRCcoHusMyMhbP1LsxiBFyWXo=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=ehfbIoDd/Tt1a6Oc+SweuGZuUfRJBIJAxV0FfDZs0/7tkEhZHMiKJ70zDIM6C+nxE
	 KG3jgsgdC1ZNPAAq2rMJkGpLEK3z1G0KQwdCfYrRbup5CZQ7FVugWRsPEPUEDtNMxu
	 vp7JA/WpIg+i8kYby1ZmG3ll/m/1YWUM4mE9jOY+xp59TccwCRNEw1lV51Gd5D/6oq
	 /Pkj0PVSr9I6Aklp9MRrqA5uORla3mVJWrb23Ir43uIPJtTa8XD5le9CcwavFB3c1P
	 QPpo4qKNihMJfHxwpQe7bN4mxHQQEOm5urYe1QDy3tNIkk74Fgdu+8uNndFlOJV8f2
	 VrZMtCbsooJIw==
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>,  Zakaria Belkadi
 <zakaria.belkadi@inria.fr>,  Caleb Sander Mateos
 <csander@purestorage.com>,  Jens Axboe <axboe@kernel.dk>,
  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org,  Kanchan
 Joshi <joshi.k@samsung.com>,  Anuj Gupta <anuj20.g@samsung.com>,
  florence.schadle@ssi.gouv.fr,  frederic.tronel@centralesupelec.fr,
  louis.rilling@irisa.fr,  stable@vger.kernel.org,  "Martin K. Petersen"
 <mkp@kernel.org>
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref
 tags are remapped
From: "Martin K. Petersen" <mkp@kernel.org>
In-Reply-To: <awB_xd60To4UawrJ@infradead.org>
Message-ID: <yq18q2mnb36.fsf@mail.kernel.org>
References: <awBnB-55HQ54C1x6@infradead.org>
	<20261120162257.498238-1-zakaria.belkadi@inria.fr>
	<awB8OODx0fCFGc5G@kbusch-mbp> <awB_xd60To4UawrJ@infradead.org>
Date: Fri, 20 Nov 2026 22:14:21 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain


Christoph,

> We could fine tune based on if we need remapping due to partitions, if
> we limited remapping to partitions, but I think Martin last time
> voiced an opinion that remapping could also be used to pass in
> arbitrary tags (which always felt a bit odd to me).

The application has no way of knowing what the first ref tag should be
except in cases where it is writing directly to a single block device.
Once the storage configuration involves multiple devices, or when
writing to a file, the concept of the user-visible ref tag being
LBA-based goes out the window. All the application knows is that it is
writing to block N of a given file.

That's why we then allow the application to pass in the seed value to
validate the PI against. Just like DIX and ILBRT/EILBRT, except this
particular translation happens at the application-kernel boundary.

-- 
Martin K. Petersen
