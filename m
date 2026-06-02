Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD7314D35
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390245; cv=none; b=i/D52HBrHME4zPcUa0D8fKSxRlw1LcJnDEHQqmFEuvEuaYeCeGkXsRhz5AgCWEVe7k40PAwxAYqtxfNKlCn0w97FkhwCrT33cZe/SBfvH1SNSMvirhOM+IIPB2w5HhhNWkFZWJwz1Zf9/b2NfVmGJZ7hfUG+2gAPgcdlZrG0DLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390245; c=relaxed/simple;
	bh=d/Jmmkccq6m64xYLP8DHcAGOpIuwTZpCZ+GgDYFhE74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1UwVcwiQjBOqraFc345z77ATjQfHG31ayU2QzZuu4n8zDS4GCxzRCt7s2UcHrp2OZPrQBVQ45Ejh8NE969OYHWRZq59tCgwDu/IA4Ndm3kreSmEw3pdF+34NCe/Ao3QViUWwA4NwSWZnBzgCBAI21Fifhhj2aVf2yeriHECnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajNcqyed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajNcqyed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57C91F00893;
	Tue,  2 Jun 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390244;
	bh=gs1YDxQOs1/Jv+Rm3Tfht7T6bHIW93ex5vfitXcPBJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ajNcqyeduhLNBBjc1kNn7nqKrnT+ceffr01bUkCPXfrEZTnjFhs6JRv7ipjntw7XA
	 tc8XoAhzqZfkj2KkyEW4uZPDqchmV3kr1531burJPNB+Tl9N+DbXHBrp0h9MY2YcEU
	 OnmuPrsNkf/bZHIwyWoYDXXlVzpPErSgjKDfn8G4JNp9dwC3I9DYKJILA+Ja/UI/lZ
	 q8XbrVVhcjCduJoD5CZjmt1zpAPy6MNY7UNuqgAfHuG8UdQz/aN7GQk1DfZD+LtoI1
	 c9O6XuwAYnT3P15qiEezFUicXj4hzMHbM4ALnPQrVxIXj5wvFv57kO9FF3DKJ4xXgT
	 TWxsVtVFTw38Q==
Date: Tue, 2 Jun 2026 09:50:38 +0100
From: Keith Busch <kbusch@kernel.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: security@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: nvmet: pre-auth heap OOB read in DH-HMAC-CHAP authentication
 (data->hl unchecked in nvmet_auth_reply)
Message-ID: <ah6ZXmX1anVLrr76@kbusch-mbp>
References: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>

On Mon, Jun 01, 2026 at 08:32:37PM -0700, Jeremy Erazo wrote:
>   @@ -119,6 +120,16 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
>                     __func__, ctrl->cntlid, req->sq->qid,
>                     data->hl, data->cvalid, dhvlen);
> 
>   +        /* Confirm the transferred length actually contains the
>   +         * rval payload the message body advertises. The host
>   +         * response is hl bytes; with cvalid set, hl more bytes
>   +         * of challenge follow; with dhvlen set, dhvlen more
>   +         * bytes of DH value follow.
>   +         */
>   +        if (tl < sizeof(*data) + data->hl +
>   +                 (data->cvalid ? data->hl : 0) + dhvlen)
>   +                return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
>   +

I think the fix should change the ternary condition from data->cvalid to
(data->cvalid || dhvlen):

  if (tl < sizeof(*data) + data->hl +
           ((data->cvalid || dhvlen) ? data->hl : 0) + dhvlen)
          return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;

But this is a bit of an eye-sore, so let's make this easier to read by
lifting the ternary computation outside the 'if' section and store the
result in a temporary variable.
