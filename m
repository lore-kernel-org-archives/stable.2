Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393841F4176;
	Thu, 27 Aug 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841371; cv=none; b=bwFJuQSO7GN0+0g6ZhE0i2iHmWoLtv7FCrSJFOvsGjSFWkXou2H8JRYYqJxn/XlqMXDD1ERqKZfD+8CJWy72DjfEZi2iUN/YLxqQacBV8ZG7V87XMT1xCLYIY74glVRKt7RS1Ism1J+2Bk3a1PI6chfVW1K61W0zM3FUFeSn84M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841371; c=relaxed/simple;
	bh=AKl+NAC+89634QgQXxK+NJhvAys3ltLbZssJ1no5m5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muNzpfRw9vLM3pE2QEh5BecRnxS79gPxZkPUrBPmp+RjR/Z4AydzU1tUA9NbAWF7OatBHfOEpL6S53Fte+HEeP5MSlacy4EhM8J+HE5BQRj/YlII/xS5QDBpOGlHhhtC4dDSsj25RnisQaou2CHzEWOE2Anxq9297j/D2jN/cMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao11NCmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao11NCmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA7B1F000E9;
	Thu, 27 Aug 2026 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787841369;
	bh=q5NhC/q9VctHNSpRD8oRl6sHTPisUHptlK/yTa86FN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ao11NCmQ1FWHVBO16nywwtAPIpqoElF2Cb0XJ7Jjtn9JGmmoalxDrS/nrXIxPfNRV
	 Ht3QJgt6GC5JrYh9+41DwnUl3eEsirE2vBh7pNKdodqw1m0p2azHdM0Grxc3fEtyIX
	 Ff1tG8B12bPzVRNYTIElvy7JVdb0VQFYwm3u/VTfkWyxkLjf8AKsP5kCtkC3+2GN/n
	 kZDiVuD8GZPE6VTKJ5QP5Ls/Eii90urIWQBhRmCA2q1AmKENHlv3X7uJnN0hFk4JT/
	 cstMoJxrGRQfchU/CRqZgf30jSk26hVcEbVbQ87EqUJ2zg19G7PinJmPmHcgZ9vfZh
	 pgKlNDsGC3Kfg==
Date: Thu, 27 Aug 2026 09:36:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Shawn Guo <shawn.guo@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v6 01/10] of: fix out-of-bounds read in of_alias_scan()
 stem parser
Message-ID: <178784136621.3211641.12231843350175414585.robh@kernel.org>
References: <20260805-nh-of-alias-overlay-v6-0-74f21d440819@nexthop.ai>
 <20260805-nh-of-alias-overlay-v6-1-74f21d440819@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-nh-of-alias-overlay-v6-1-74f21d440819@nexthop.ai>


On Wed, 05 Aug 2026 13:31:00 -0700, Abdurrahman Hussain wrote:
> The stem parser tests isdigit(*(end - 1)) before checking end > start
> and so reads one byte before the property name when the name is empty
> or all digits. Check the bound first.
> 
> Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5 [Claude Code]
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
>  drivers/of/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

