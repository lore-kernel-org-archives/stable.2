Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5DC35E950;
	Thu, 15 Oct 2026 05:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043032; cv=none; b=EoNFAAuuvZM72jn+MZYGXzk8C/gctE9MMXxASvMLUqGGlMU1sh3Slsyny2vorWqIOTtXr8zSbIs+vhhKb4mX/Tx6iT5qAKNZ3m8G69w7qg3SiEqKbbB7RXZWUlSK4Jn6lGkjRbnqmu7OyZcnGTy9fvrRgntqs+SR5kdvvAQB/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043032; c=relaxed/simple;
	bh=RnO3/KZGRGJcu3Gx14xvyDOlkIQz+nhbTC93l3/DnS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpVFbf68tj1BfJeJUwhIOsXHEAzj7XBcGit5JfMM8I8DAqhpw2r2I7VSpIxDm2zm8aDWiQLjyn15ZS3fNRpBLBt7jc9FpFlSFps4zvo7dalBQYDacXTNvOnXR++No4dj2f92LPi72l7l1zkCnrnaXwulNsN7sT5nbr6ArhmVmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv4HV5s0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv4HV5s0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592A71F000C6;
	Thu, 15 Oct 2026 05:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792043031;
	bh=3Xc4fbfcs8RwBM8xl2SryUACJZ3NPzYor1FzEZEyz4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dv4HV5s0m2VhbaC4xnceHpkQxOy7y9gDSJzklIctQ6MwimFZXf22ZYPfSRHwIFJUM
	 kEANmmE4quO5PH6QT2yEr1Y/0dTQv8NY8Bu/6Oo4/4oPnqmAHfi9JVUKucX4PFrRuK
	 Zami16fnibMYO3o24KOkQJd1vPKy2iu+8kQY0cwJWYobwOBJohm1Uo4cuOgNijqMpH
	 cTlyWl2OKr1tp5b/OahYU+r1mjzsXR+qbcU53C8NBg5Y24HPp9hciMqn/lolx7ZQTR
	 71ohA9SvqUq6ihB0NaQie/WR3NhH5+GDywSzemynxAfFcTPSRc+VP1rZMpG2L8LLS7
	 eVz8TcbQuJnHA==
Date: Thu, 15 Oct 2026 11:13:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Artem Dinaburg <artem@trailofbits.com>
Cc: stable@vger.kernel.org, dlemoal@kernel.org, kwilczynski@kernel.org, 
	kishon@kernel.org, frank.li@kernel.org, bhelgaas@google.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [6.12.y] Please apply one upstream fix
Message-ID: <atBnuPOa68f21L6C@debian>
References: <20261014190815.23455-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014190815.23455-1-artem@trailofbits.com>

On Wed, Oct 14, 2026 at 03:08:15PM -0400, Artem Dinaburg wrote:
> Hi,
> 
> Please consider applying the following upstream commit to 6.12.y. It
> applies cleanly to 6.12.112 and is already in 6.18.y and 7.2.y.
> 

Please explain why you want this commit to be backported to stable kernels.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
