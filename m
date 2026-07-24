Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771E3E3D89;
	Fri, 24 Jul 2026 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934212; cv=none; b=nTXXtlDVflSzBNcATUEU+dwufYGkfgVWdSuOahis5bihF+G6qqmpIpW4PKtZFBY+nTDpQyz7ArGHOu71o9CkWo2YmZjiXBa2eBV94LyB3aL/1l6OJQkkHH/y4miy4CfnT+3TWOVNx2wyuRc3ybTJvfJIZY11LFykiG5FpVQsW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934212; c=relaxed/simple;
	bh=K235PGz1TV2suU273LVxjERkF5UL4Y6QddW3H1ft85g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVL1EQ/3VZnGgGohSLjEOBkBeJpXMVEzrK67X8AEIwIPwZbY5CymVeR8YydRkOEMmo96DbR+zzp0MfBqBdT3VyG0Nr5cGEl7AzJMd0b/Rb7W5TF8HxESjnZav0u6NXr210upHjjNOmD8uMWBOPPhZ7GRdqK4A2rd2SrJooO8bSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/A2A8rK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/A2A8rK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F46F1F000E9;
	Fri, 24 Jul 2026 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784934209;
	bh=EdX9H3JPJnnkjBWbIR3HhbkVwKYDFZASpmCJ0KeC9ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A/A2A8rKKlbvHy/mF+2gYHmS/4kZlsQ7p820MhGkbpJOHzBmQuR9EVKjIkO/WOFfF
	 pUWaupWaKhqX4RI7dIZGNz0QQYHprjAEL+EfODfCmlil7QwDGhI+TMAIpSuzrjKadA
	 HHPOn2vMwG7RroqT8GMSO0G59apOsD/O7dLRVWYZTdJYJPwmxqihQNQi/Rtd7ckiU+
	 Sx7Q0RVxTqA8sWRqvC9K8s6gNDO5Ptgto7/Z/pqdJj1h3gdUz4QUVaykZB+Pa9b5GQ
	 xJunalsJtU3KbTed4YO6+obgL8AaPl2pvcBaf2SqYMPBDSJT5Fwk9ttpKHjXXzxBVj
	 KKu6BZM7ko3sQ==
Date: Sat, 25 Jul 2026 01:03:25 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Elie Morisse <syniurge@gmail.com>, 
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] i2c: amd-mp2: Unregister callback on adapter add failure
Message-ID: <amPuVQtcWaQhJTsQ@zenone.zhora.eu>
References: <20260721144147.31150-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721144147.31150-1-mhun512@gmail.com>

Hi Myeonghun,

On Tue, Jul 21, 2026 at 11:41:47PM +0900, Myeonghun Pak wrote:
> amd_mp2_register_cb() stores the platform I2C context in the MP2 PCI
> driver's callback table before the adapter is registered. If
> i2c_add_adapter() fails, probe returns and devres frees the context,
> but the PCI driver can still dereference the stale pointer from its IRQ
> and system-sleep callbacks.
> 
> Unregister the callback before returning the adapter registration error.
> 
> Fixes: 529766e0a011 ("i2c: Add drivers for the AMD PCIe MP2 I2C controller")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

merged to i2c/i2c-fixes.

Thanks,
Andi
