Received: from mout.freenet.de (mout.freenet.de [194.97.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDDC36215D;
	Fri, 14 Aug 2026 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.97.196.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728392; cv=none; b=Cdx+sl5MCkmJuXKEovqhhNzWCAOFuzMtAWPxm5w+2gEN/17h3WLq3IGTnHFpIDfAsJC5kD/13v3dkAEnoyH1k7DxinjD9tIheSZgTuqTgeObX9z4oCOjDHHSlI4AGdWnVDPo61A9KC23sxefv8cYnElxhkplbNQaI66fe7Eoz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728392; c=relaxed/simple;
	bh=YtFhO4iDM3Fr8be9sxCd5A9CUJ1M1tiKQxclcJt4U9A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GA5wyvG4+i4RMqVDjHtcoMz1nTTEL3VdKFIIG6IxCyXFUc/GWWLQPHpCnZOKNpslItr0oCdOHsJE8tcVeFbVOlYW2/lAsAWeBlkphckWzqXTqWJM73TC5BWhSBvPvOFbjjVSwYBRygSzMwy/YWM9XHLSzSMUtSoKql4zqCfZXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=Pn+s88AP; arc=none smtp.client-ip=194.97.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="Pn+s88AP"
Received: from [2001:748:400:2319::3] (helo=sub2.mail.fnrz.de)
	by mout1.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port 25) (Exim 4.98.2 #2)
	id 1wuvaZ-00000006Os3-2DHW;
	Fri, 14 Aug 2026 19:21:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=YtFhO4iDM3Fr8be9sxCd5A9CUJ1M1tiKQxclcJt4U9A=; b=Pn
	+s88APaW1iwO1hSKGyYK3+HE5B2FTl/Gtk0srMvNXMwMz2HR9EiIi4Bfukq/boOiprnH60jFwuBSW
	HJfeGKv2x0RcV5sm8tObqY3bWGrui2VzD9QQTLnwU/rxeOX8jCKRlXKZahQGVyZHuKfGi8yD7F7NZ
	E5H2wx9MV+tj/7defvPHUbSIlCrqjxHDTFM9cbiGs7gC4+zYdHHL/alDlVu1Vow06YmpXjqsYXNol
	XdW54GTrxQr/OljejTz9v595DkPB5Mn3dBnetPC34IJC1PQNLF/UCwpsg+Y2nQiGIYhrYTyVCY/G9
	BZ0rjiAuCo6cGFWnaEitPZLOXAub6nPQ==;
Authentication-Results: freenet.de;
	iprev=fail smtp.remote-ip=2a02:8071:a85:f020:6632:3c5d:647:2fcd;
	auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:6632:3c5d:647:2fcd] (port=51552 helo=[127.0.0.1])
	by sub2.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.98.2 #2)
	id 1wuvaZ-0000000F4hJ-1Xc8;
	Fri, 14 Aug 2026 19:21:03 +0200
Message-ID: <db97cf96-e7c8-437b-9069-0952c62b023a@freenet.de>
Date: Fri, 14 Aug 2026 19:20:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
Subject: "Fixes:" tags on commits with Cc: stable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-FN-MUUID: 1786728063D0FC1D4AA986O
X-Scan-TS: Fri, 14 Aug 2026 19:21:03 +0200

Hi,

regarding a recent fix for AMDGPU which was tagged with Cc: stable, Greg
wrote that the "Fixes:" tag in that commit was wrong from his point of
view: It referenced a commit which was not contained in the mainline
kernel, but only in the drm-next branch (for the next merge window). The
patch from the referenced commit had been cherry-picked for the mainline
kernel via the drm-fixes branch, so Greg argued that the "Fixes:" tag
should have referenced that commit because a reference to a non-mainline
commit doesn't work with the stable team's tooling, which was confirmed
by Sasha.

However, Alex mentioned that some time ago it was determined that the
"Fixes" tag should reference the original commit (drm-next is upstream
for drm-fixes I guess) so that you could follow the cherry-pick -x chain.

As far as I can tell, the documentation doesn't say explicitly what is
correct. Since this issue might be relevant for more people, I'm asking
for a clarification so that the issue can be avoided in the future. Most
likely the documentation should be made clear on this matter.

Regards,
Viktor
