Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D42F12A1;
	Tue, 28 Jul 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252881; cv=none; b=CnteZpayrjvA6t9KXZX6+LUxTItBAb4rlPKPTQZRZ3aiRZLqP7OKwStvnUkVIv/B/x0+jX3Ouozxq2ZWar93oIlTS13d5lVXtBzS0bJWdbUg8+f+hCnz+lPgNo22yq5ALCrLLsNfGkT07T/gyVgQ8Yf3EsrZgD+mfNTx+zXV5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252881; c=relaxed/simple;
	bh=+dmfsBx8KL5cJo1YXtEhK4PIkDAP1a7rLzZ5WodllnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NikklEuJhWmbjqgGyyzqUjLUXF3UK1COnA/oBpYehlB5lYzNMeYKIwrNglxC32tmsbkE/Ozr3H/VHcErquLJFyv1skgy2FogOCC5GVy9qETz7SE4OuH3sFtEGYR0StM8QfqZbl/svFc8Nt8auEHYkGhdBC7oGTO6T9tnQ7fJ3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVGlk8x7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVGlk8x7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6484C1F000E9;
	Tue, 28 Jul 2026 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252880;
	bh=Q754b//iEMiI5iAASN9/4txs9Hqc2aR1Tcv2WF6WgwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lVGlk8x7mgJ68TQ0Jg5Rv4nsU1MNF43nbGiN7dgH2p825ConKtuzfozjCnAnYS7qI
	 sbDJcZw9H0VDXuBbhLhjy1gXEMZXyMG9dwvZUN+KeGgWqqycw2SN/FUrlZwWOg/zUZ
	 Prhe84mM+npu6TC3CWxoHt87y+2wNZvbUldItf7cvntP4XhrZ4oyJij5rTsIvjr5rZ
	 8/FPEOI+5dj+PAkI64GHTHb2aMwjCLgOx5A7mCkmWhQuE7Hf8KYtu5CFyWMUKHKLme
	 ec5tQTloQGLd6eN088gsiiVzctzcuYcgn1XI9CFEF6fsuGArIWQW5o8GAiS8itmUQR
	 zvxNt+kzlO/Aw==
Date: Tue, 28 Jul 2026 10:34:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: stable@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH v3] of/address: Fix NULL bus dereference in
 of_pci_range_parser_one()
Message-ID: <178525287796.2235178.8797217892783913753.robh@kernel.org>
References: <20260727-of-range-parser-null-bus-v3-1-be01b708a4ce@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-of-range-parser-null-bus-v3-1-be01b708a4ce@baylibre.com>


On Mon, 27 Jul 2026 10:36:59 +0200, Carlo Caione wrote:
> The bus matching rework made of_match_bus() return NULL for nodes with
> ranges/dma-ranges but no local #address-cells. parser_init() stored that
> NULL bus, and the range iterator later dereferenced it.
> 
> Reject such nodes in parser_init(), leaving an explicit empty
> iterator for callers that ignore the init return, and make
> of_dma_get_max_cpu_address() honour the init failure so a rejected node
> cannot clamp the DMA limit.
> 
> Fixes: 64ee3cf096ac ("of/address: Rework bus matching to avoid warnings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
> Changes in v3:
> - Drop the of_range_count() hunk in of_dma_get_max_cpu_address(): it
>   guarded a pre-existing corner, not this regression (Rob)
> - Link to v2: https://lore.kernel.org/r/20260706114731.57353-1-ccaione@baylibre.com
> 
> Changes in v2:
> - Validate na/pna/ns in parser_init() with OF_CHECK_COUNTS() /
>   OF_CHECK_ADDR_COUNT()
> - Link to v1: https://lore.kernel.org/r/20260706095651.48839-1-ccaione@baylibre.com
> ---
>  drivers/of/address.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 

Applied, thanks!

