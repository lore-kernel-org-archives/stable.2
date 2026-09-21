Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E072422E2E;
	Mon, 21 Sep 2026 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986838; cv=none; b=QMOLn43HsFrI4XhQVqCPaYJ5+zkMoPlhUDjBJyORV/I63LrBIGC+EcJRGhwODePkjsSFCBXCVfg501NnGAfMp2Ce9z+f3WN1zPTmnVr0x4JNTUrCUaFM+ugN0OdgOrXpvcY3KOIyoSBcq7DhTPjeF8sHGlB0a767CWwj+xhLaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986838; c=relaxed/simple;
	bh=7Alueihca6+GdMZBuGpCOI7T2VDkyYFR9xwljhBBdY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXxCJHIlP7kjVUVHZgfxeGpWmjpBzC2vsnlBnxi6jZHsMuuaMh8z7ouLy+WJfAFriahoeY8AVGnVa3IqMvy04+137rNDOqVjNsbzvL5c0dYbFP/3o6Z9ZKW0x/a4jmvjCvj7Ll4gtDCdrCSenwpuJj5jz+PIEbDu75mjL29PGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyQJl5Re; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyQJl5Re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF3C1F000FF;
	Mon, 21 Sep 2026 10:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986837;
	bh=Rztqd+MY24DPWdq7PhM6VuYGeRPhihwJZrVKB7CRiZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nyQJl5Re1+3/vrVGvcvtJebvFdXp67TCN9PDhVQ3+oTcIjJRodyOWM6QqsekG9KfC
	 rb++zJqZQfrvBR0jc4WgP5eDNbc0u8aGg3T6WeCRqZUqgw4VYWoUBTZyKk0wNW3Jzk
	 A35LFusrNPNo04SBIiMxeILF5FYuHx20JbjkzKgPXv5KxKkdHEdC9iz19JHF3cdhqn
	 Zc6Gh1S5S0Pv4GevjoCYbAFiDOHkCzKYR0PXXSUPi+E9nJiqzG/NXoxfh3ARh4ajVO
	 SSq5Go3hhdd9SrJXQHRdfsx1yUk0xjClmvDuf75YmOYtjorqxkBPTRydXs0s3qUEf7
	 vl+eDgmrjzS1g==
Date: Mon, 21 Sep 2026 11:33:52 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, sln@onemain.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Message-ID: <20260921103352.GG13925@horms.kernel.org>
References: <20260917111317.2148568-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917111317.2148568-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:13:17AM +0000, Wentao Liang wrote:
> ixgbe_ipsec_find_rx_state() returns the state with an extra reference,
> which is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and the
> reference is dropped on the floor.
> 
> Release it before returning.
> 
> Fixes: 92103199f10a3 ("ixgbe: process the Rx ipsec offload")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

