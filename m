Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C634D93B;
	Fri,  2 Oct 2026 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930837; cv=none; b=hHoYih6D8TsMEnXrmDooHnFOfQaWfDTcEdZzXwb0FiZpI7SyarWh5ANyj57pEet22LQOOdB8MtSegGfxHdOYfr/zZ5jXK4rF305sgF0YDe5QFcfb/6Qmyz1az+iw7f4axJjzjKOdRv4VUO7TwJ1IwEl+Tt8tCG602gQtToXtIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930837; c=relaxed/simple;
	bh=hVOz908t2cZmy6VXUZQImpY0IKZJsG7Xkb3godpcYcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btisw+jdT8gEIWTjvA0bAEilar+BT6xLWMiq3xPOd4eM4RJ036qG9YUSMD02UWELH4fHBOxH4jKiwIqM5hdHVTkJHnuM5GMdFvd79RwrDuPw/dSPCAJoVVjbRg307CXu/PpjibXq2f8XzueGaNA6IdXv7LM1ZQ/E9KghwVIh0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMhtfK1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMhtfK1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C68C1F000FF;
	Fri,  2 Oct 2026 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790930829;
	bh=Wc5kj5a4BpJ0OUjNppS6cd6+ts5TUkYQzcs344JsTqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lMhtfK1ED4A4i355voFk8eOvtLT3sE5nZaPhTYZ1+1VeqtKW9pwjFNn34QjGkHY+I
	 SwV8A0CYITISTzI1rmXrXYqcW/MsCUXrVi2VJKV3xV8qwbN54knexwFut04tG06CQy
	 Tew8GUcxBywV04lQ2V5OVnpk9hyujljNm+TGJhM+iDT15Ot89xjcBY8JGA/1outZgR
	 X4c/z4y4igSCBJn6YZBzeBD/R8A9DxmJuRknbFbhZriAEdqX9S9jxaJ81o3RmfK1rO
	 CbQQ+bcmUaehpFykSMdRv4qTsitcE+6PdelzDD40iAWbLmFBEQNmospVWIqDC1OKX/
	 XTYxVqH7crF6A==
Message-ID: <09730dfc-b748-45f7-b740-33c95a102dc1@kernel.org>
Date: Fri, 2 Oct 2026 11:47:04 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i3c: renesas: Fix MDYAD(x) field length
To: Diogo Ivo <diogo.ivo.sx@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-v1-1-2250225e6d20@renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-v1-1-2250225e6d20@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/26 18:10, Diogo Ivo wrote:
> Fix the length of the MDYAD(x) macro to be 7 bits as it represents an
> I3C address, which is 7 bits. The length of this field was confirmed on
> the documentation of the RZ/G3{E,L,S} SoCs.
> 
> Fixes: d028219a9f148 ("i3c: master: Add basic driver for the Renesas I3C controller")
> Cc:stable@vger.kernel.org
> Signed-off-by: Diogo Ivo<diogo.ivo.sx@renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
