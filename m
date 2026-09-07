Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8949483F;
	Mon,  7 Sep 2026 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780841; cv=none; b=Ro2yfNmJQdxniXyypjzPAaZqWRZoxIKr/sjNht1HWwnFXl4IG8y6pcOYIb2l6HuNvnfQkx3S9nR/Fgb73R2ahTrgGKM4OGH3EMipYMcHeR/WBW/axYbAHkRcIxdh2mBSvWR4HvnvL4RC0vcgNrFWny86/iqjDxs+EJPL7gYSE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780841; c=relaxed/simple;
	bh=J3mwjfOvFwlFFZ5FBtZS13WOIX8wOfOmNyn3gkWsGW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2fiQjrd/1ye0YqiV99HoJEDKMKvrVLfffBhoqbL5N5MtzY9ZeiPqmbonPTbOxeB24gOmEjYZx+NmgUXOoukwh1NSfl8TbgdzH6GFeA1Q7gSkLA0KKqeQTBX/D/wxdw69mKe8Y0n4yP0ivAg92PudcRvnHv35qd8u4rGxPDPxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl0YOblp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl0YOblp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8973B1F00A3A;
	Mon,  7 Sep 2026 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788780839;
	bh=CM175fJgwxjkupJXh7h6cfhnzpTQDOxY6k9XoEhziW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nl0YOblp+gW6a3ZvpTB175sVxHBOuLmIDEPU95nInWtux+15Scye7V4wz/tfp7671
	 W1HUPMt9cvf5jR1vWLC0YqCKyDIE/hx2IUr9v1E7B+pA6trBB/9ZSuLETK9JrNvzpD
	 ovAAX2bMAMdzUWruT+pZwfyr9lNkXZbIj/hCXvo9t7cZV8wieaDZdYhb+/RflUEZbQ
	 MBfU2ELB6rirS3HvIji6frA904FaSJWywH7OEnCcfniCtk5qnUCw57QqOEM1j7hlXW
	 1wIeFG32v4k1qQmot/Rg1Nyexb5lco7slOV0H6rhEpKYDwlDmJ7YbZ7mDcIKMgJ19X
	 GaGT02fV6BtJw==
Date: Mon, 7 Sep 2026 13:33:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, stable@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] ata: pata_legacy: remove documentation for removed
 module parameters
Message-ID: <ap6hIoGppETYr7ey@ryzen>
References: <20260607064053.195166-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607064053.195166-1-enelsonmoore@gmail.com>

On Sat, Jun 06, 2026 at 11:40:49PM -0700, Ethan Nelson-Moore wrote:
> Commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
> several module parameters from the pata_legacy driver, but neglected to
> remove their documentation. Remove it.
> 
> Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
> Cc: stable@vger.kernel.org # 7.0+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Acked-by: Niklas Cassel <cassel@kernel.org>

This patch was sent to linux-doc@vger.kernel.org and linux-ide was not
even added as CC, so I assume you want this to go via Jonathan's tree.


Kind regards,
Niklas
