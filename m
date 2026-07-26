Received: from mx1.heh.ee (heh.ee [213.35.143.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33D3C0613;
	Sun, 26 Jul 2026 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.35.143.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097883; cv=none; b=Cn+aN3yim+eyhs9Udhom7fJ4IzTPs9Ck+M6S9Iyczh+F0aDzcd5v9LXf/NsYiWC8jKC9swtUUCrmmqczFBNA8zciKCzGvlYK1ITIJ83NzRQAahy7V1/D3dndfKzjLGL8fcE/coB+srM1w7escGidBb7Nh8G0d3jS31G4LqcC4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097883; c=relaxed/simple;
	bh=TfWJv0fgE715k2ZENzRy58oVW+9/qdgQZmOc3B+VXec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zbf5n8YyonNX69ta/Eb6fN2Oe5c3nqx+FswHRmTVqWHXBl7wASJ+jHl225qCCUm5hOIFLBAv/UZTGpRj/vas+Hg1fh40+U88rYzuMjWLgFesu3vJ+MychkJc5HXglJ141TgbHUxywWEfGiyX+HzcJBXd/ArJ2x6DgdYNVdeHplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ristioja.ee; spf=pass smtp.mailfrom=ristioja.ee; dkim=pass (1024-bit key) header.d=ristioja.ee header.i=@ristioja.ee header.b=NT6X7Pvx; arc=none smtp.client-ip=213.35.143.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ristioja.ee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ristioja.ee
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ristioja.ee header.i=@ristioja.ee header.b="NT6X7Pvx"
Received: by mx1.heh.ee (Hehee) id 31ACD11268D;
	Sun, 26 Jul 2026 23:21:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ristioja.ee; s=mail;
	t=1785097275; bh=TfWJv0fgE715k2ZENzRy58oVW+9/qdgQZmOc3B+VXec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NT6X7PvxY7JXG4AXQ9pue9GkhMp6ITjKClApNSIQSFh+wBj3/3nJVjFe7stxhZ8GG
	 QUo2oSvNsHWsIFVjYMmPIa798NrCnnl/k46LOllEuT6SgpWSUFeDVQHpY3NqJ0W4tJ
	 YkT1eBlUAe73VEKf/W65LBCXsRJM77RH903drfB8=
Message-ID: <925d5179-289a-4d1e-85a5-09cf0998bf88@ristioja.ee>
Date: Sun, 26 Jul 2026 23:22:14 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend] [regression] amdgpu carrizo: no display signal after
 modeset
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Salvatore Bonaccorso <carnil@debian.org>, Chris Park <chris.park@amd.com>,
 Matthew Stewart <matthew.stewart2@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 1139950@bugs.debian.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dianne Skoll <dianne@skoll.ca>
References: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
 <178198613176.3658222.16247101620976737948@eldamar.lan>
 <ajcLuO0YZCoPN7Xw@eldamar.lan> <e4f60b98-9bd8-491a-9703-a5a7a58a4ca0@amd.com>
 <82b5026d-2dcc-4dcd-9094-2ccf70057964@ristioja.ee>
 <6cf6be99-76c3-43b3-854f-96cae180318c@ristioja.ee>
 <20260622153449.453b493e@gato.skoll.ca>
 <ae5c29aa-3790-479a-bdfb-1b571eaab809@leemhuis.info>
Content-Language: et-EE
From: Jaak Ristioja <jaak@ristioja.ee>
Autocrypt: addr=jaak@ristioja.ee; keydata=
 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
In-Reply-To: <ae5c29aa-3790-479a-bdfb-1b571eaab809@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, I don't have any new updates on this yet. As suggested, I've 
reported the issue to the amdgpu maintainers here:

   https://gitlab.freedesktop.org/drm/amd/-/work_items/5531

Cheers,
Jaak
