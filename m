Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D455403AE6;
	Wed, 22 Jul 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702256; cv=none; b=ZWJknxuB9v976/zdH7l5Ku89738Lq6gF3P3BXbnwTCPgjZRoImYFaz+wouleYWULmFBgYLlz1wurAbcmtwb0dxpYZGiPQLf8fy2GeOGF5nvVkO2F99CUCb6/7SzVMHCkq6COHCYyAgwNPr/O9HcnIPJkABqogPWc4igdyMj77q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702256; c=relaxed/simple;
	bh=mGAepXNXclMJ9Z2J1FsOocFJ/s7MvEJ9C7mHq0wpRw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1sOegIGvzTUME/aJJc63U+gZ82YF1PfC0ea55NYSvE2MQQDSVznIwXgFPXr7zCMyMtWUEpg3M0OWEyynu1bay/Z4bhx18tcZOuKBuaT6VjEVJij1TGcV3zeA97aHuUzB8+gTEg0SQ7u8rYrA6Q6LbeRaHFjYYuU7gzPRwA0EdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=j3GbrlDH; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="j3GbrlDH"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id D1A651FD24;
	Wed, 22 Jul 2026 08:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784702253;
	bh=3n0L9dOfWAd6n0psYH8PsfWfVM7aGzLh0Rt1BS6r6W8=; h=From:To:Subject;
	b=j3GbrlDHmFzo/WV+JFwrKEV7+9jBtE8Nw1O8myAivpRGxVOyb4sE0WEIeCE+H9Giw
	 sMVoz4qDwxzcbkczL8Nu0Si4cKfRenI3L2gjHxKxATQjDa7HH5hpCowJRe0paD8KyO
	 DSRZAQu9FbL7umuF23CILMkfB2rEvrUUcWqu37hdTy3RmSwfuHCCGxCCmF2dFsZWAh
	 iJ7l+24jGUV9K/PpYA7hXqOddRlvL/ICc4AwG1jKntSnxlvZzDP9bybAD9c5IDBTmk
	 5ONVKRMpCsXxaYRPMkcTrHRM9dp4zCrv6h9YxKA67Xi3CWLxXMR/2ubFDt13bo7tZU
	 uEtwLLdMjs5SA==
Date: Wed, 22 Jul 2026 08:37:29 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 0000/1276] 6.12.97-rc1 review
Message-ID: <20260722063729.GA27550@francesco-nb>
References: <20260721152446.065700225@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721152446.065700225@linuxfoundation.org>

On Tue, Jul 21, 2026 at 05:07:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.97 release.
> There are 1276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

