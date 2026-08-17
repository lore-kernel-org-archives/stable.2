Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9F3B42D7
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949909; cv=none; b=ojjJwLGzg4e5ux+mXI2PEk/zZ3xkzgMwE/d+TTsjLvYnKusRhSuwtviOKW5gc+9MdY6trJLB8ls0meIRYsgo+5vI3noEGDa7CYbE2TrIuqRFIDgVCQ95GbxrgnbdOR0FyzQ35jp3OHU1HZJeF4Oh0mE5lT/LR3n4iUWRnss0pYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949909; c=relaxed/simple;
	bh=HLKQ79p3olN3bsdwYX34V1he+9DMMXG9cYCRoYajaQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlbOh1aVqUOMC4Jx9X7Egi7jqCGVP7XKbbOk3QJSfuiVaDJ3cDq183L2eP+jiLb39l8IWzllDXJhvZ3ns2FItcjpqSF5ZFEN6ej4QVebrZP6LN3Y61+m60som3vr7U6enzEOjnMwgSyBthtw+KFLeJ1c0IKgE/PleVPiPAUYvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D5F6B68D07; Mon, 17 Aug 2026 08:58:23 +0200 (CEST)
Date: Mon, 17 Aug 2026 08:58:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, security@kernel.org,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix NULL pointer dereference in
 nvmet_execute_identify_nslist()
Message-ID: <20260817065823.GD16255@lst.de>
References: <2026081423-enlarged-dribble-10bb@gregkh> <20260814190022.1531236-1-kumar.shivam43666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814190022.1531236-1-kumar.shivam43666@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

This was already fixed by Guixin Liu.

