Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D635F60B;
	Fri, 29 May 2026 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096114; cv=none; b=FdMuXqMvM0pe3CilvXsiyoo4DEp8JDxjzCtdAu9OhpyIKtXtVbH9hgPGuqYfId8iWXDP0bE7OzzbUWNWQ2XcylZC+/efBPv1yDKfxlJsyeLZRN6/Ml9YJz+rV5AIlEMWp2+ntbXRCT8+MUBUzWGKNby510bm0t0dNI2pNFZ5BQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096114; c=relaxed/simple;
	bh=eX7WTaZKJayd6U7mlHytWgAtaoC+4htedxWcA00LuVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwdxWrxe6X5R9yuLEheL4OjEBkvOhbGc7oP/Yct7//Le9PfNushLN15K8LOwSKiSFdA6P4RhapL7+mfc4YPBc9JqAtpuhx6S2b0ZR5fcPH5Um2+JECtm2Jn9LDnWUJBoog4Mf7I79MnJ3TNIn2ACIUWU+cmnMDmWyNq9X+pvVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1oi1wMQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1oi1wMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ADF1F00893;
	Fri, 29 May 2026 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096113;
	bh=pTri8BUQcNx5FytxVSCnFtx7e/4115rb7iA5Ei7gVqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1oi1wMQkhT+5vUe3xl/z/OPr9v3cjkS70bSLcTudM9itZzRgDbd5Xhi0g39+e2ul
	 5HDAtlwbq9jHySwBVJNNh1W0au5zdHczxKW6dDBOIGeCq48+NrFR1o/aB0/ZS46xbl
	 oG/lsfsTQqCt5HqNnSUoeuF3CVSGqGhY5gd06ATDRl/tZ39w8rY/MfChJPiJQvmh39
	 CRYnqufiox9SKzhelNYg/uArcaDKShGZcTRXMOjiYZxP8PaXcDKW+lhJJwXv7NjaNb
	 iDeu6nItp/AOevw0OOCIbc6QUUcBz0HxdpY/D9J8x6V5kD5xWYaCGfNsZuz8vbdwxq
	 dKgAQbVfsCRfg==
Date: Fri, 29 May 2026 17:08:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <ahocb8YRtqh5rHo-@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
 <ahiHIEhsV2zuG5vH@kbusch-mbp>
 <DS0PR19MB76965BF9FB57EA3ED8BD4586FD162@DS0PR19MB7696.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB76965BF9FB57EA3ED8BD4586FD162@DS0PR19MB7696.namprd19.prod.outlook.com>

On Fri, May 29, 2026 at 01:32:22AM +0000, Achkinazi, Igor wrote:
> Keith Busch wrote:
> > I double checked the sequences here, and yes, I think the
> > synchronize_srcu's already in place ensure every caller sees the EOD
> > error before it could fail the bio_queue_enter(), so this looks like it
> > happens to be sufficient. I'm okay with it.
> 
> Thanks Keith! May I add your Reviewed-by?

Sure, though I was considering just adding it the nvme tree. I'm giving
a few days to see if there are any other comments.
