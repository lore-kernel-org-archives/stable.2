Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4C3859CE;
	Thu,  6 Aug 2026 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991460; cv=none; b=d+h3Q9Q9KZ5ghgz7X8D2HWfFqby35GZ1JRm8mAmMoRDEvY2eKz+kKjK/aW9JJXfPL1VR92uu9AP3yubNeVgJRK4ywQf+ae8rCgZ1q2k6r2CTpLIlB2impVDPMiHmHwaijj1mA8hgXcahXriUNz8BjQYQT0+R8C0Ox1QdArd1hs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991460; c=relaxed/simple;
	bh=gVQBKoxGSO0YkH2XRkRcFP3WS4eqj3Fe+QYCYXlhd9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHSAJjdIoCW5Jc1IJQ4X6V5Fu4J+mjzpiKNTDtyzGQ6vyKfPg9Nc+rWE/kdZ/p5hIYZwOKzGt8hV94Gx0e9tNhjzpVmggn4EQ3ohkK6WZzX3O4W4OAPyMz5QtMox0WiI/giLFkrr8154bqQKgRAJuXcAaQSwpJRZdxl3whmLcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rxqnkAAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rxqnkAAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3001F000E9;
	Thu,  6 Aug 2026 04:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785991459;
	bh=DTh4nrwOYIYSpu2E4XlGkIvQdllPBqNRakQbXmAjF3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rxqnkAAdnqjfIjNDvutNESHCm4f0/6EGcZ4PMZZ+TOARPiSpZfSdZgPNS6rnYZOl1
	 ePc03tz4NmuGI0ek46xRzomvZhmEDIOtaHDXZJVnfsv7o2icsrUtFiJjTqZMMhmgTi
	 Yzda6GWStFvXex2PQEihfePUGuVcOz0JMonfSgVs=
Date: Thu, 6 Aug 2026 06:44:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Arbab Haider <arbabhaider649@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yun Zhou <yun.zhou@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Arbab Haider <arbabhaider6494@gmail.com>
Subject: Re: [PATCH 7.0.y 1/5] net: mvneta: re-enable percpu interrupt on
 resume
Message-ID: <2026080615-overlaid-clerk-13f3@gregkh>
References: <20260805164000.stable-0008@kernel.org>
 <20260805183803.118565-1-arbabhaider649@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805183803.118565-1-arbabhaider649@gmail.com>

On Wed, Aug 05, 2026 at 11:38:03PM +0500, Arbab Haider wrote:
> From: Arbab Haider <arbabhaider6494@gmail.com>
> 
> Hi Sasha,
> 
> Yes, it is. My mistake. 7.0.y went end-of-life with 7.0.14
> (2026-06-27), and I overlooked that when preparing the series.
> 
> For context: these five patches are backports of mainline fixes
> that I carry in a private 7.0.14 tree used on embedded boards that
> are not moving off the 7.0 series in the near term. I sent them
> to stable intending to add them to the stable queue, but an EOL
> branch is the wrong target. Please drop them.

Please note that as of right now, the 7.0.14 kernel currently has:
	Total Vulnerable CVE's in 7.0.14 : 387

which might not be good for your embedded systems :)

thanks,

greg k-h
