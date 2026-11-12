Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494600;
	b=ZM8IgMuZxceVyseg8ZriwzuqO8wiZru1ekO7MCU/ml4vSRGb+wDnDOwRtGL4T6fUWniu
	 XFwAhT+lVtGsEctFyCBuOVPQt+wy2EQeKIUA8aha6ZXNJR55vkF69w3PALXhgwDwudxGm
	 A3eTOTN71SjfywulDTvD6+H+R9eHZzl7omMWSed4DtlotfbfjZD/vMHdU8p3tAK6jsf30
	 KpBrvC5upZ44XlizzZq0xmbEdjuUW/BhYu0OqGWibtRWKbQkvarKksQuN04RAEgoonXL5
	 rInvHeIKhJ1d6MoMvQBXSTV0xtKhFJlyQ9Dk7+j5617pC+Kuk71TmXj/Y9WF+eFcmfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494600;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=doRR2hlsDqY4KYCxE3inoPjG+grnCS2sG965WCAyZas=;
	b=yjc6affV0/Bscp2EwLy5cCufhngni8CUAnH9U62EEbxB58MiKqgsUkFf0wwj3mYpdqhK
	 4TyOCzkOxYCPtGP5WF15XLEui395s0X1bsq7vUIIlO9Xbqh006xWWnxkC+4BTtIrFpMEh
	 AE6K7J8fzrXXCvDIdibZ41UtpS3DkJ9grannRyfExmAKvR4/ngtAJSxjyfdFG3aZcLD5H
	 SyipghTN/ynLfjw+laUuPHZe0xK9K1VNAXNYi0J5W+e8+oSWcXtB6IijSoU8jgL3keRs0
	 dWbStvO1t2WJAZEBbaQ9+LbWTJXvM+ON6CikBvQ6sbAz63PyZuIe7AAtTq+uBBradSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=PCpUqHRW;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C60606A332
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C60606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=PCpUqHRW
Received: from macsyma.thunk.org (pool-173-48-111-191.bstnma.fios.verizon.net [173.48.111.191])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6ACEgZrS029468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 09:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794494561; bh=doRR2hlsDqY4KYCxE3inoPjG+grnCS2sG965WCAyZas=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PCpUqHRWzITexZeciyh8kmVbkihYGX8mwUkz4BDsbPPLX+qgXZSgK0siPFYDtsNvw
	 vhi19YCkVdpN2IOIuCQkUbTABBSJH34jKgUk1v7pcRSM1aF+AI/t36ClaWCrfW2JJN
	 FcvflnJ9GzeSyh+wHskHLh8VisHyED/GCv1zGigO8l7ebgLy4JiNG3DwOYnQyWrVta
	 EQI9zCjNPdNU2JePDhpFJerpbV/T9UDaDhfs+O06B95xIv8USzHrU41itNr13pVwFh
	 S4khQLaNAECVY8NIwKjwYoV0mGOMtac6jtKQmU3og6QNRrEW6ISyYhUHAEkjw/6H5q
	 +6t7Ei0rd0G3g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id CC8FE26E540E; Thu, 12 Nov 2026 09:42:35 -0500 (EST)
Date: Thu, 12 Nov 2026 09:42:35 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leon@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>,
        Bradley Morgan <brads@mainlining.org>, Sasha Levin <sashal@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v5 0/6] agents: add skills for Fixes tags, stable tags,
 similar bugs, and commit messages
Message-ID: <avXOSg4jOlzBY1r5@mit.edu>
References: <20261111225940.1573565-1-tytso@mit.edu>
 <9c5f5976-ebed-48f3-94ab-1121231af6e1@kernel.org>
 <avXCcPYM9VAP0JHf@mit.edu>
 <31a56051-bd63-4a39-9cad-2c9afcd98340@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a56051-bd63-4a39-9cad-2c9afcd98340@kernel.org>

On Thu, Nov 12, 2026 at 02:49:09PM -0500, Krzysztof Kozlowski wrote:
> 
> Specification is also documentation, just like for example specification
> for our ABI. It's also located in Documentation directory.

Source and header files can also contain documentation.  But we don't
put them in the Documentation directory because they do not contain
*exclusively* documentation.

If the complaint is that it is visible when we run "ls", one
compromise might be to put the skills in .agents/skills.  This is a
cross-harness standard which is supported by some code harneses
(Google Antigravity, Github Copilot, etc.).  Some harneses (including
Claude Code, Opencode) don't, but people who use these harneses can
solve it by installing their own symlink from .claude/skills,
.opencode/skills, etc. to the right place.

Cheers,

						- Ted
