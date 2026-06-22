Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7DA2BFC7B;
	Mon, 22 Jun 2026 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127917; cv=none; b=J1M0f1B/PHxtWc+VU9unozFTTTAAYQCgdK5xwKTLhkuYoJJ9L4dwZJWyWc39kSKNX1TcrDIDptzrgHP2drOyKqr2GYg5AxSKap+kDo6Ccv8yvGrHz/4irx23rgMH0NxaZrgBDaneX2dMx5OLkg2ejIAqYAT1TCHPTcidPWn+D24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127917; c=relaxed/simple;
	bh=oD3ux3nXHs7bcD475xb8S4K/F+nq06uYV+drw4mNhSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXFIPcLDBKsvcPHAdOL67mFzMhwGBFbl6xiPlzPWzr7M3vw1z5YDfTKkHX5P12xcE2aqRtRMAOaLJ62TNGyh8rEVhFZ+Q5hdLb2YTE0xYQ6YKatbS2TuHvyWmsZd+0XVAHK7w5qGlOawWJz6qmAYwsyI/HI6P8AHZzEsGQ4nVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmuNVBxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmuNVBxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3981F000E9;
	Mon, 22 Jun 2026 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782127916;
	bh=WFITMWHSz2eYvV5r4SK7tu5mdoIuGO+WsB8vHZ8ZQnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CmuNVBxudCGKY4ayoLonnCJUHGXSeEww3VsN+ldoqalAWYEDkT/J1I0eDXp7fo1v8
	 PNTjklMpg2/9hz0cerhH9zjvHJQbbenAyyR+lScm9wTKBB8tRY/ZWSzqi0kfS66SbV
	 M+ORRpYtjbrO3w5BWCmaSd3Pf6W4YwxZllS2Hj4ROigs+x+PjSWT3vGWtUUJngkgVg
	 jyGu3ozFNNEJRqeqe3ylCEaJVkQaeeGiFTXh7wP5JRGuc6GKUF3ok9Js+U/8qCDlQ8
	 Doku8cMKnKPZ9Lrlxoqyfo/AqrS0Jd7acY2GnVrQJZeO8+jrOL5gNZDAOtkx/Z9ulH
	 qCqMDTlL24qAQ==
Message-ID: <8c681e59-30aa-4a66-a5cd-9cccf8e338ff@kernel.org>
Date: Mon, 22 Jun 2026 20:31:54 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
To: Alvin Lim <alvinwylim@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260621100844.1224301-1-alvinwylim@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/26 19:08, Alvin Lim wrote:
> The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
> support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
> can be handed DMA addresses above 4 GB - it silently corrupts data in
> transit. Reads return different, wrong data on each access. SMART is clean,
> there are no SATA link resets and no MCE is raised, so the corruption is
> invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
> or, on Ceph, mass scrub errors across multiple independent filesystems at
> once - i.e. host-level, not filesystem-level.
> 
> This is the same failure mode already quirked for other controllers that
> falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
> force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
> ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
> The ASM1166 currently maps to plain board_ahci with no DMA limit.

Have you tried the same quirk, limiting DMA to 43-bits ? It is very likely that
this adapter bug is the same as the 1061.

-- 
Damien Le Moal
Western Digital Research
