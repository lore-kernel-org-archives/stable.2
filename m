Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671CF349CF3;
	Mon, 22 Jun 2026 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.161.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157359; cv=none; b=kQOahO1YCSN9/Kbynr60kkz/7MyqZHZW2A/mZA5bMdlXJghU0d4TJk3Lm5Hwe28/6rl+5cKX48f0lSUmNQwBduAUoZEhjiXEDy6EN3h/aPGT6+MEZyzjTvUWAbm9QFc+Pjh0aQujrq6ObnspgNlRWoiaQrWtwJFxcYr0dAUm7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157359; c=relaxed/simple;
	bh=Gqmlrrq9mhIFv9cRCQnxY4sJmrmjVZkJ2+FRbTrSEuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOVLufULNelNFw1ZffdBQYqdFvwDnt77arizB88JUDsGmMrC5NLuAn7qs9gZI/v7gaj5gBd6yaBQIKcn0olnjRXhLCR6cLxQ68sXEyDwIusYS7o3YC9V9XlWpz8QqxMUqO/dWcQj6L2y789U7Iw/tgEgizD0YEVV9V2YUgyBoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca; spf=pass smtp.mailfrom=skoll.ca; dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b=aKi3naqD; arc=none smtp.client-ip=144.217.161.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skoll.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b="aKi3naqD"
Received: from pi4.skoll.ca ([192.168.84.18])
	by dianne.skoll.ca (8.18.1/8.18.1/Debian-6) with ESMTPS id 65MJYotZ452560
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 15:34:50 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
	by pi4.skoll.ca (Postfix) with ESMTPS id 4gkdgs6PrZzdZSgV;
	Mon, 22 Jun 2026 15:34:49 -0400 (EDT)
Date: Mon, 22 Jun 2026 15:34:49 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: Jaak Ristioja <jaak@ristioja.ee>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
        Salvatore Bonaccorso
 <carnil@debian.org>,
        Chris Park <chris.park@amd.com>,
        Matthew Stewart
 <matthew.stewart2@amd.com>,
        Dan Wheeler <daniel.wheeler@amd.com>,
        Alex
 Deucher <alexander.deucher@amd.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Harry Wentland <harry.wentland@amd.com>, Leo
 Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        1139950@bugs.debian.org, regressions@lists.linux.dev,
        stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [resend] [regression] amdgpu carrizo: no display signal after
 modeset
Message-ID: <20260622153449.453b493e@gato.skoll.ca>
In-Reply-To: <6cf6be99-76c3-43b3-854f-96cae180318c@ristioja.ee>
References: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
	<178198613176.3658222.16247101620976737948@eldamar.lan>
	<ajcLuO0YZCoPN7Xw@eldamar.lan>
	<e4f60b98-9bd8-491a-9703-a5a7a58a4ca0@amd.com>
	<82b5026d-2dcc-4dcd-9094-2ccf70057964@ristioja.ee>
	<6cf6be99-76c3-43b3-854f-96cae180318c@ristioja.ee>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skoll.ca; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=canit2;
	 bh=4YKCsCv6Dg8q+CHcKvgFdReQSfbL8ScgwMWEpw1J2Gw=; b=aKi3naqDtIW0
	rwnLRqwlTtUGB4KeoXWWFDyebgVE337PqtNWO9EJIEE7N3rBKvbl07mgLFaN2pEk
	MTX0mEwjvYSYbSjDJIKITwAMbbedhvmtJgEDnplHQVqk8MkovLY1PT/9JT7S2KrI
	BFZRskstywzSZzeyhJZ/4zNlEwy9WVzDXafBpASbPBT3jY4k6Z5D0IsvjfkRvwOO
	VrADqTpLA4BohSmK0rAIr58C+YbIqdnJXqCL8Jhh7qBjwtMiL7KNvZiMgUGsSR/N
	OtAWnWImdP52ZKKt+iSTK1rAB2KGWNoTzG1IBoDPWNphJrDMSevFAemwEQP76zJ1
	B5/Mk5ITQA==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.20 on 192.168.83.18
X-Spam-Score: undef - relay 192.168.84.18 marked with skip_spam_scan
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20260622 / 01huHyO29

On Mon, 22 Jun 2026 20:46:44 +0300
Jaak Ristioja <jaak@ristioja.ee> wrote:

> Reverting commit fee50077656 ("drm/amd/display: Bump the HDMI clock to 
> 340MHz") on top of v7.1.1 appears to resolve the issue, as I am now able 
> to get a picture.

Unfortunately, reverting that commit will *break* it for me with my Dasung
E-Ink monitor. :(

If it's not possible to detect what the maximum HDMI clock should be, perhaps
a module parameter specifying the HDMI version could be implemented?  Or
a parameter to specify the maximum HDMI clock directly?

Regards,

Dianne.
