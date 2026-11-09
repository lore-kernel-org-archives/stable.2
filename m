Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196616;
	b=K8aDRwQSy05mdgVy83hx/a/7i/wai+sAOFfMWwJnawWn+AzClQxgmI+7/WjLa8GgBDmk
	 A3zAN73wNqGv3lGENuXHh68uM62dobPokdQ69wNxtqmdheW75Og8RfYq9czfxwxZ7YoDO
	 TIfgH6R+lJwrgvYaJGqiHLH5KsQsyq5wn4ljt+sd0dvAR02SMrfJVG83/hjURm7Q7JYNl
	 EUKi2yg3Q8ImE7bA1Fp8kq12EN6n8IQdHgDPpFbi0FEcQyWds8MNLOvqmRGEE+RQLihcM
	 b3h+K+c3oxnyII++JaClbiz/Z9JTRYXn03KxpZDTEJqu75ARD4jIjyjfzLcSPVOSwVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196616;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=IpoxAai+pl1QF/TuFGqG7saRnVQYdTl5R9HquRiLLjA=;
	b=xgSkbLQqvdkGVRm8Plc8EHIhlCZS7HwYStwP0UWs0XLjszC7acNZscayzldfGkiRsEC3
	 yQHKzjjsnrr6YP05ctfDg9tAwMUukyiCTG4CZ+6OLD4BoIxEW8Tw1HvSoDy5SZJbCZkPW
	 MhQNpca/8ZR7Xwo33VUxw0dTUQ1b1L65yl/VfU0XoGrLeitTGr0mucdIp0Y0JCav5udvK
	 TBggWk4halYc7UfDvLRkgTjWsowYfkDBsAqwfqvzmjX5+Hdg6m1m2wrclMmNngG4qiltF
	 dxmEKjLBOmiMzcHagrVf0jLVjaYhP+2YbqaaspMqmsern+A1YjBTrqhT/lksgDvRg/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=CFd8lFUg;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658FE606A31C;
	Mon,  9 Nov 2026 03:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 658FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=CFd8lFUg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IpoxAai+pl1QF/TuFGqG7saRnVQYdTl5R9HquRiLLjA=; b=CFd8lFUg6lfA9BwHYqZzMDZ46+
	/gGpSh/U3Yql7d+php4hyouKf1OXKFLzh+WFLBLHDu6Z4ZEf7Lb8XIAAWf8Vm5kq2aFG2QHnMColN
	5Nx1/mr3CJWCsffKhpN3aKW03QfOCMxRe05IX+jqcKoA6xOkV9NNpofpoIUcDGDJzn6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQGUi-00FBUi-Vg; Mon, 09 Nov 2026 04:56:32 +0100
Date: Mon, 9 Nov 2026 04:56:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Anthony Pighin <anthony.pighin@nokia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: mii: Accept link settings read back while
 the link is down
Message-ID: <910e9272-a85e-4a71-9980-43a1b5160356@lunn.ch>
References: <20261107210236.721901-1-anthony.pighin@nokia.com>
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
In-Reply-To: <20261107210236.721901-1-anthony.pighin@nokia.com>

On Sat, Nov 07, 2026 at 04:02:36PM -0500, Anthony Pighin wrote:
> Since commit f6f2e946aa4d ("net: mii: Fix the Speed display when the
> network cable is not connected"), mii_ethtool_get_link_ksettings()
> reports SPEED_UNKNOWN whenever the link is down.

mii.c is old deprecated code. So i would prefer not to change it.

I would say your first stop is to port the driver to phylink.

  Andrew
