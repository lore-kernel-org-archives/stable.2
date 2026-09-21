Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082123C73D1;
	Mon, 21 Sep 2026 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986905; cv=none; b=ehnekjSZox1+8Q+QU8ynsCLuR7xt5XycPpKzA8189h3BTOSi0xJWhmjJLy4l3RbPnZ+CxthNJinSHAr6k1L+icUxfNvHb+BQOcl+aoCrhMQ+ZLAigNgzL59qxYNlnYYgnMi34ay7KxOcUG7RZ4sOb+zk7RJjWflA8qTsAXXjDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986905; c=relaxed/simple;
	bh=7Mw5cMRdr8Ht7K+Gj1NHTwOgdX0VMqSfD972zxwuBVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHC9J831DGkdxCJjc9Nzet0n6PrOwjXJsL1yHczHTBuxaI76dvX+t196KhZkxDjmwyuYlFgCygk66WUuudSBTQXhnWGHtZHr+7mhK1KcekDFS4yavWLWbXafQoX8wM1NHM3LfpwS4mPsLJf5l0FA7vUw+NVB94aEfXhkTqTcRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmJq15PT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmJq15PT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE911F00893;
	Mon, 21 Sep 2026 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986903;
	bh=I30Ewh0A4iIJlrqKf0LygIu6KmBp+u8wLYMgm6eVSf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LmJq15PTOZlTn6Qnbcley78JQ41EEFMIeZrLieQnmKzWABl0titF4b56Tb2S3xQLu
	 yvzopubsppUb8WR6TWuZT6NAb/hicyeVuKo0Npu26qokDJLuhD1KQkSliaLd6H+nLV
	 m6Ouaw17Xi1OVJHb4zdvLAFlTC3Sw1E6Dp2U26NsT+Pv/JnBXbICNzU6JtOMAeDee/
	 cDAy0qmuEKRIG6tEAvwKy8aF4gr1Zms9B2NboRL6/fjunxXEoIDQCRfT38otg90Xyx
	 WMCk8/h9Gh5hkt2Sflgc9Sq/QvfeJQc9+CdhVVGMhbkQ8vsY8FWyImaYgiMuvTM3E/
	 LdOjdSp7YLzcQ==
Date: Mon, 21 Sep 2026 11:34:59 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, sln@onemain.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Message-ID: <20260921103459.GH13925@horms.kernel.org>
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917111418.2148632-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:14:18AM +0000, Wentao Liang wrote:
> ixgbevf_ipsec_find_rx_state() returns the state with an extra reference,
> which is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and the
> reference is dropped on the floor.
> 
> Release it before returning.
> 
> Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

