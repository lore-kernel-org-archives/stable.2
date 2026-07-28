Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407013AD512;
	Tue, 28 Jul 2026 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238830; cv=none; b=Wr3WbP46Jft9gKc1gVnw6ebGdBgyMs1y/DCSdKO4d7O4TWPJHv11sqWhMxULgG/aVGe98MyRnzBk6FSkZjPA0DsHKplW7Za/zH9LjL+pA4rQVAesKreStkOVhsV9B9WPAnKdtECO+uiEmS1VM/IvwKqM8LcEytLLXHwcZo0t0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238830; c=relaxed/simple;
	bh=LkUFJXcbsgc54x1qygld0cnaTFyxgsYgS2gS8sOOmns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9HSjKv7miZrJNylWSHjq2tnmZe7yzFGic/9apCz7dYoP+qZLNDS5IPutY7ybttj3B2NtQ+s0/Fpl2YTzDhinAwqFmrRg/q8mPDdVJWXtEPaCf1Q5Fm9uOBJzio3gfMWgVY3OiIlK/YV5p8yNGkKcHHb+K1TrssLqxuxwMzDU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIie/SuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIie/SuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF39B1F00A3A;
	Tue, 28 Jul 2026 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238829;
	bh=LkUFJXcbsgc54x1qygld0cnaTFyxgsYgS2gS8sOOmns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BIie/SuEsolF2YIEmu2x8KXmHtzu/jAWrtq0q/mAX5I7sQhOl0R8HUNaaddPxuf24
	 rOL51/TBKM/FGgyO8ZLO2nYrrio80nu+BnIYLJt9+LiF+pV9k1yn7iykVYCnIiHvJx
	 r/j+DMHXXmm7k1iQhT3QF+O6E8nwAKNa9Nfl1J9JwRIaIT1AhwN+Q/PJEd3TTCSmCY
	 kLQL2eEYuxLLIsMDzqkJgKj6XcN2ZunPBJEbyUxoOiiPc5Qcie61nCBf+njV6HGM4F
	 vRH5OH2vi8CDN3iRKBWAVXs3gvFea+Y3nkjbMqTGBlbud3o3gCvRI2bwsrXHUJIOds
	 WscFVm8KRnLQQ==
Date: Tue, 28 Jul 2026 13:40:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sata: fix ata_scsi_lpm_supported() iteration
Message-ID: <amiVKXTt9lNVl15y@ryzen>
References: <20260728113841.727256-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728113841.727256-2-cassel@kernel.org>

On Tue, Jul 28, 2026 at 01:38:42PM +0200, Niklas Cassel wrote:
> The inner loop of ata_scsi_lpm_supported() user the wrong variable when

s/user/uses/
