Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE5348C7D;
	Thu, 24 Sep 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262174; cv=none; b=Yycvh7C+fuwV706q2CHi6t/l0xbJaCKbCnUkvTs7R7u8rvF23VFEa1F1ZyGiI4tr2rWNIYXkByDeX+hV/J8tgeJfMlkx05BIWal38ft33vBb+t1f2RD3D/eSFOOY4PC+gJ+uO1VbjcGYYf9wUs7BX06SW8fM8AnCURcklFC3RaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262174; c=relaxed/simple;
	bh=RQlfIYpPAEN1zJcQZWyebgw9TuDKsdVc5z23dfobmiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoagjEpSytx41n2RSRwbft81MyfLfm9Zq5vz0y9qbEtE/gMh90zUp07KW/cVwnSjnftqOZmUZYH988J/C4EQ3xLgRJ2NatMAtIrbRQ/BncD3SlabCiNnHZyclo+rFvDZCRZy4BqFUXsZG7PBMb47hG5WlY076YZMDJGyuemGsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dro734a0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dro734a0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6311F000FF;
	Thu, 24 Sep 2026 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262173;
	bh=2538lnaxgsTcMhHm0z8daJ22PEg2OxSYXE/TInrciQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dro734a02MjqUtAjrZp95s/ftOu10hkgiaWXwct6kZxS2llZVKw8kC4CgIZY9egCb
	 EHr2yzpkNJi1vKB3r2TkpaNq/XyYji47IJFHCpQVzStlFeZJYCoEb2RuG7525dMWnC
	 /b/D2E0u4zln/l2odDfVMF6sorr1zXFbiko1c2BSvj1aLDhyZp+vzVgnNAiRZc3zts
	 SarQUCgsE2E/g6AliivBdWz/8YqkSR0joQZpAgv0ILZtukPtMNQt3hKiCmWNzn9hZb
	 /MOEJStkC6im8fwAvvB0r80r6f0spZ2QEVEyt1/PL0Nu9O6dpQGHMlq5cMqw3OUVfs
	 SBCasT+Egk/Ow==
Date: Thu, 24 Sep 2026 08:02:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 richardcochran@gmail.com, ceggers@arri.de, arun.ramadoss@microchip.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: microchip: save the periodic output
 request
Message-ID: <20260924080252.2169c100@kernel.org>
In-Reply-To: <c1cde6b7-5883-4dbc-87e9-d7b86f727ba7@bootlin.com>
References: <20260917-fix-perout-v2-1-d8acf3eea6f7@bootlin.com>
	<178998077822.2160803.3867886756893254872@kernel.org>
	<635cfefd-c588-4b3f-bbc4-1cf11ef0a2c5@bootlin.com>
	<99bcc883-1cbb-46f9-9283-cd03e5efafe7@redhat.com>
	<c1cde6b7-5883-4dbc-87e9-d7b86f727ba7@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 08:51:19 +0200 Bastien Curutchet wrote:
> > Also if the issue you are observing on an older kernel is already fixed in
> > the vanilla tree, I suggest instead sending to stable the relevant change.
> >   
> The issue isn't fixed in the vanilla tree, it's only hidden by the fact 
> that the driver doesn't register the flags it supports in 
> .supported_perout_flags.
> And only the flag issue is hidden, the index still gets wrongly set to 0 
> on restart.

- net
- Fixes
+ net-next
+ better commit msg explaining the state of things

?
