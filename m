Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC9218AB9;
	Tue,  4 Aug 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847029; cv=none; b=Dtfvg4rRPDSBIwZ6iFvu7ZDGFAXOcgUutPrr/1GJvhF7aXdXLfL1wec+slVOLYjyWYzLihhOyLGQrO4LztXnimzTqUMm3Jg74/R7RWZBrO3vetJneEcf4CLo8H/+lkxgCZHDt0DF9yHCW3mp1ffPFlhSc0pJMVMRf3b5rxNUL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847029; c=relaxed/simple;
	bh=XTbeljmmfukiimPbfaeWLblmeEISsxfbCz+AYuvfj3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoHWuHYyCoro5lwEhp6/H3VZtac9VThk7Cp5LuV/0cl4u05nr9a5DVJIerhAVXYx7CwpEt1m242ryJVdB+TPRVDEdDMsTH2X/RIe8NEaLmsv/Tqm0xRffqn42L7mFfXM/xUbiF5o9iIMtVUnYHcMtOQCBRNJGO1AQdTkyW3ZHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 762236732A; Tue,  4 Aug 2026 14:37:03 +0200 (CEST)
Date: Tue, 4 Aug 2026 14:37:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: raoxu <raoxu@uniontech.com>
Cc: dlemoal@kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] zloop: truncate finished zones to zone capacity
Message-ID: <20260804123703.GB6661@lst.de>
References: <78d0627b-e711-4ce2-84ac-6e501898407c@kernel.org> <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 04, 2026 at 10:34:03AM +0800, raoxu wrote:
> However, zloop_finish_zone() currently truncates the backing file to the
> zone size. For devices with a reduced zone capacity, finishing a zone
> therefore creates a backing file larger than the zone capacity. After the
> device is removed and later re-added, that zone file is rejected instead
> of being restored as a full zone.

Can you add a blktests test case for this?

