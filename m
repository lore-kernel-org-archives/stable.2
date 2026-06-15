Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536431716E
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551193; cv=none; b=N6Lo7PgMvw+iQnTyBr44Bh5EIBwwgjMhVBQNKCKlYTZgaoJp8FDn4ypv+S9b8OsKNe1qMVpvpxLQ42WkPUAFzoSXJRaJhLzKY/YI3G7Mn0PQKGPjOxjQ8CCyGlAApjtw6Z/+a0lkhLphSHi9X3OfWkx6g8KE/AGufj7saSAU6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551193; c=relaxed/simple;
	bh=+ZOfGZ1by/uPHVPyspzXNtx+PYPMX2eGAfzJchhKm14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFxhIEv8M63krq/XT1SArSq6nIihhYU4V3rge046OedVBqaO9SngSpPrmUzQ11XOyGYG75LS8wB05A3qiaPbsRCSZiN7DZl35Cq9v4SQSm6FcVYXyBhb2SBOZRNNp5AZzxYaY587Sy03elUzuvVJRznQ0oKa4esY6lbp90GvLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nRNVHeji; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nRNVHeji"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 4565720B716A; Mon, 15 Jun 2026 12:19:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4565720B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781551164;
	bh=aKf6h5cUYFFHKVBv3a+IMLxZrckdPxgcuNeUPEqUFKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRNVHejiQ4uUl3nhUpvMuygjgABajhbjC/tSUQLBOKR4kAtMA5r8VbZ3kSBPYQC3N
	 G3eKE65J2oFVhzPebubYeeNDglFnTqKkHTvOklPGI9hTYRo36+A3LOEsVUrzPxSHj2
	 dslQRNGy+4VlslmrYtoIPc5EfelgqmY/g+5PjCQ8=
Date: Mon, 15 Jun 2026 15:19:24 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Leah Rumancik <leah.rumancik@gmail.com>, stable@vger.kernel.org,
	xfs-stable@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Message-ID: <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250322143418.216654-1-pchelkin@ispras.ru>
 <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260612233110.2-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612233110.2-1-sashal@kernel.org>

Cc: Carlos Maiolino <cem@kernel.org>

On Fri, Jun 12, 2026 at 08:20:34PM -0400, Sasha Levin wrote:
> On Wed, Jun 11, 2026 at 02:39:03PM -0400, Hamza Mahfooz wrote:
> > Any idea what happened to this series? It resolves an issue that I've
> > hit in a production environment FWIW.
> >
> > Series is:
> >
> > Tested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> Thanks for the nudge, and thanks Fedor for putting the backport together.
> 
> We generally don't take XFS backports without a maintainer signing off on them,
> so right now we're waiting for one to do so :)
> 
> --
> Thanks,
> Sasha
