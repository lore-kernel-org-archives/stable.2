Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BDC3BE154;
	Mon, 21 Sep 2026 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986473; cv=none; b=p17aqVzg7OX9SHxc8vPBT1PaNjOsU5fBTyIA87Rg3xD5jQsdXcEqdwzoUtn4YgPGjmD7Z4rHTJi2ZUjfU5+CRhMv4AqEECiFeSjCQlXQT5gQX6O4Gn7un/vxGMr/b6DXULfIT1xqAcntefy3pZFISMj1GKr2ljSQTCUgjsg0z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986473; c=relaxed/simple;
	bh=lvF4VxgNAmL/DMFBMxt8O+5PK4dRU10yStkYLKahp90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVRQQ1y5qk5uQ/TfhXBKRTjqUuce2MdTa2tu84mUS6BhZApRuKWoq01G0eIxMj0j0J8PHW+f5D+3iQf5Ew+3qpKIcDR1CD/u7KVwGZXokjgvUAyT509Sj4vkg5TCn0D+PRJ5flCMDWR4rWhICH00wEQ55NCBjDFBexL7qbzaFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFsBIXG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFsBIXG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3530B1F000FF;
	Mon, 21 Sep 2026 10:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986472;
	bh=sxsN+TlIHJHvv76mHxiqyAMvaRfMC/jRNv1GbodqDrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jFsBIXG59yHL609zVg4O8dOdX+CqyvC+dkS1GYYKr1rLXoScCbL8Jsg4PljAiCfBi
	 Olm51+2DzGkw8dgol8S7N50xd34uKWXyftyW0Nz1I0pM+dlpP756NIuvDyBDzlHoeH
	 si9P3I+vz2zRwbL3cp31isHDvjfPgXAmZ67fdES3F6O4c4sigO64mE2CscZYc9irmp
	 FaQjT6tv4j+t/IWxs+Vi6tS8/In5Mm2QXS1SesnVDFj4ULQvFDWJTOkg5dh0VweGaM
	 v54P5cTee+6fLhDW7MA0GqQNnHK8cW6ralwHHJOi8ppgz97PQ1NXUceZpE/RCsOTY4
	 vUicYfdthva4Q==
Date: Mon, 21 Sep 2026 11:27:47 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Yisen.Zhuang@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, shenjian15@huawei.com,
	yankejian@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: hisilicon: hns_dsaf_mac: fix mdio device leak in
 hns_mac_register_phy()
Message-ID: <20260921102747.GF13925@horms.kernel.org>
References: <20260917110828.2148390-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917110828.2148390-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:08:28AM +0000, Wentao Liang wrote:
> hns_dsaf_find_platform_device() returns the mdio platform device with its
> reference count incremented. hns_mac_register_phy() never drops that
> reference, so the mdio device can not be released.
> 
> Release the reference on both the deferred probe and the normal path.
> 
> Fixes: 1d1afa2ebf82 ("net: hns: register phy device in each mac initial sequence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>
