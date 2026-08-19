Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A240B481241
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153291; cv=none; b=YiOOwl7n8iPn/s0NvT8s3ige3Nh829gx/BEfF1+xrSOftgzzjD+tngnWt6Rid/ktmWphXMEetS6rJoJ2e5+laxKverTm84DN0b1W1JzAMh0bVybRUUbTgV9iZBd2APkxbi6kArfXtxtYizISSf6Xl/o9TjaLYM40iYid0hCflNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153291; c=relaxed/simple;
	bh=xf869Ir6xzy85BoPj0YomLdvYtgla7eQT/1UGeREOqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx+DlDiHzWCT6U4ik4Ri0MeSQ5rd2uKc8YqlZqO70kokUQZx4BuaqOY64szkOo7K+ZqIZpKgLPpl7QCgpERjl2hAcQlUvTsPUV9ZdXKyvMcI6cw8h6Xi1tdpik01AnU+a0twJ/RpQqYZGYzClQ7xM5fj46Kre79A4MK4ri5M02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTRMWj+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTRMWj+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8946C1F000E9;
	Wed, 19 Aug 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153290;
	bh=xf869Ir6xzy85BoPj0YomLdvYtgla7eQT/1UGeREOqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DTRMWj+JvfKr+0W/2aIbf6vFKQ3T2gtQ+ahLpUW1bMzo7stuVSVeoTPATG5TGqxAA
	 VD9J8sByu0ibyB7n5jHseFpUm85DMHY42E57EvkcT88dgyNInyEfL6e4tAAT19ZBsH
	 /g3hbG2lhxHeXl6SfGrbqLIIY7aAJZ7SKoPxGY6/DJSKrx7Hhl7/7poMstU/MCSdVm
	 RXJ0InrVh8nS42wwgId+HiyFPalTfK+WfQ8bzG0ktGZDoVh3zv1JDzk9tuDtbTxXRz
	 VyU0EDdCX3KhN4FquH0iebu1YIcY90LI3KIEmplVTigkII0s+DUGjN8uC0qyPDBy60
	 nBqkZSFf1Gm+A==
Date: Wed, 19 Aug 2026 09:28:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aoXLiFruG5s1nKch@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoMkX_davK7TWlaj@ryzen>

On Mon, Aug 17, 2026 at 05:10:23PM +0200, Niklas Cassel wrote:
> It seems like Keith did prefer your patch, but as you said, your patch does
> not avoid a NULL pointer dereference in nvme_auth_free().

But you're replacing a NULL pointer dereference to a derefence to freed
memory. That should be fixed too, and I'm just saying checking a pointer
for NULL before dereferencing it is more clear than checking if a list
is empty.
