Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441F46AEDB;
	Tue, 30 Jun 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835549; cv=none; b=RB6OzxiT9gWc83tokUlIZetCLgF0u03S/YLvW6207AUmC2IK98zEv+aH7UtQfVR0W4AXP7XZRa6ZIaLWklLkFfgQGNlegaDOrjqMG5w83GLjr86ZQoNcqetCPs7sw8mBkDmaG+qoDaYVUHKAm2h63UPMboXFnXENxANtX0R/OBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835549; c=relaxed/simple;
	bh=GRs8WjcQhEYPcY1IkD3TxIAylDmbtFFFSwtcXiK+ZfU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=sgY9wBa91kPhbT1PTKPSGCH1Za9aSrhsWndEVe+Ktc8gfCgsELCoPjszoTLVOWAx5kcyiBD5LchOZUiN8/S6IewfwXoJ9EvZkvy28Hz7RoESrM2OffEq6RlV+jhm48zXGHo5WYjZ3r4koY1e8MhgHKo8ne8Afn2muEXOrm3FMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox1lSUs8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox1lSUs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F352A1F000E9;
	Tue, 30 Jun 2026 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782835547;
	bh=GRs8WjcQhEYPcY1IkD3TxIAylDmbtFFFSwtcXiK+ZfU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Ox1lSUs8APxIsUyMFvQd0DXXHeogkAi4cBq7Nizl0YA0oJsHLXSZrXSDjaUxbf1J7
	 VFdM3rKwRi7eEN9eli1d/LEEGUB/m01MbJEtntsSfXM3plXu7HfFSxaBX6Kaw5eKDC
	 zhRTylalba619x60GkyfjhkL21ZLJRsTAnvKZe137Ed4OVHcBkyEk6wfR2YqOg+JCW
	 9AyXSMhByZlMFpix4KMGX12NfZXZmy1KNndWd0gUt18ZCZYYhve92toImNVQKaDAHX
	 08kQELCc79R8VkaNWXTzXpIFb7diJSou5D9IfOTxeFVu1xTL/EpLnPVKdxS3I2Wlkd
	 /DOnQRMPtcXtQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 18:05:42 +0200
Message-Id: <DJMIGDHFYCIA.271V0T10TID2J@kernel.org>
Subject: Re: [PATCH v2 1/4] Revert "nouveau/gsp: fix suspend/resume
 regression on r570 firmware"
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Timur Tabi"
 <ttabi@nvidia.com>, "Dave Airlie" <airlied@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Ben Skeggs" <bskeggs@nvidia.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "David
 Airlie" <airlied@gmail.com>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Mel Henning"
 <mhenning@darkrefraction.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Lyude Paul"
 <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260629224350.2870201-1-lyude@redhat.com>
 <20260629224350.2870201-2-lyude@redhat.com>
 <akOuPQ37-zxIJWWH@ashevche-desk.local>
In-Reply-To: <akOuPQ37-zxIJWWH@ashevche-desk.local>

On Tue Jun 30, 2026 at 1:53 PM CEST, Andy Shevchenko wrote:
> On Mon, Jun 29, 2026 at 06:42:33PM -0400, Lyude Paul wrote:
>> This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.
>>=20
>> It turns out this looked like the right fix on some systems, but it's no=
t -
>> as this causes runtime PM to actually fail on many a laptop.
>>=20
>> [I have set the fixes to an older commit then the one that is reverted
>> here, because when applied with the other patches in this series, this
>> appears to /fully/ fix runtime PM in addition to the regression]
>
> No need to have this in the commit message, move it to the comment block.=
..
>
>> Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
>
> I'm not sure, actually, that this is a correct approach. You can't revert
> something that never appeared (in time range between 53dac0623853 and
> 8302d0afeaec). Have you consulted with the stable kernel process document=
ation
> and/or respective maintainers?

I think it should be as simple as picking

Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 fi=
rmware")
Cc: <stable@vger.kernel.org> # v6.19+

for this commit and keep patches 2, 3 and 4 as they are.

The commit message of this revert can then explain that the commit that was
attempted to fix with this revert, i.e. commit 53dac0623853 ("drm/nouveau/g=
sp:
add support for 570.144") is fixed with a different, subsequent approach.

This seems correct, as reverting a bad fix does not claim to solve the orig=
inal
problem.

Thanks,
Danilo
