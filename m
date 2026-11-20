Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186585;
	b=ZMBrR1+yx9ssP6k0NZDsiV3s58seHolMGmuVwqux6+gUgYMyBQNI4RuOrJ+L6pnaXE/m
	 yvYhG3cqQIO3zkAuKtErxllQXRlY2WFl99njdnaMTratFO8irRABeH4iMxIcK0rgKviS0
	 70F0I5o9SuSrwqvCAPqVfGZOdryLRiR72LKFkMH3EgM0qQbmrXskw4J3mIuvQJkh1e7gZ
	 qbjtCdQRgo5E28khIuMn0QyHawf62jBiEHewWWEJqXe/bdFtSIQDfaoTuhG60h8HLK2eH
	 kOzTsJ7Ec/ei0ezoY0lolScnr5jyiMSgOt75rfjtuI0KqhY96kX2J3YG3FkMsyLIhJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186585;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PWKebnPhYTe7KzCAKOSl8Elm/eTqQgSBeFkRBsOny2A=;
	b=Ke8BVBh2LRbBca1GlTZ0zTxkLuiUpg0+7ZDrZL3xiIl/y433KJIi3wJOEBaiiRSxwqw9
	 fjjB9HUHI8bz/P7fr5RIE5byb/SBFQcPlCMtAb+EUxhnj4LXu54vf/64SpmBqHw12TXH1
	 VD85YRbNntvimuWWGMgBNgylerki6AyLHpN5DJapcAGBV2GRqUKn7qhRXDA4Ri+cd9pTi
	 3sa7QXvKNVBa471MZh9pXP1uYExFXUlzP4rK/kvHrR20+H9+jPMpv7HP8pAUoEvSrfIwf
	 LvuZYVMDi8Ld5UnCwWgVBgFeZp8MdWLi1Hlc9Cp7kE8PooZ+oM3tWMnnF/bH/OYoEHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABaR2U6X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F56606A320;
	Fri, 20 Nov 2026 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABaR2U6X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F131F000D0;
	Fri, 20 Nov 2026 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795186584;
	bh=PWKebnPhYTe7KzCAKOSl8Elm/eTqQgSBeFkRBsOny2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ABaR2U6XU3qBiGFaz7Vss7/pLuWY9shaUpksePUvALcd6KGSrUpKzirLV6eZiTfga
	 9Kujk/5CMP/6A9yxhdyF9xH0a4l/lwfTM+Y8HivYgu2/EfX3x+h+ZdzK9v3IPRT8BR
	 9DrJpRjwGxlvsDtLrre0VcM6NpANPOKXXl2XdYAtoySa4c5N73UNCUxIExdaM/7PO6
	 1153TMTA2oEOo36M3aiU1asZ4pJTwjpoDLhbdpdHZ/47BxYgRbATR42cbjDCYX7MCr
	 5diFO3rZr7S9tw9PAGerAbnBGIUKCPyMoCEEcNSCrRRj7XLJjo37cKo8F5nekt9wse
	 LCuLxxx+lYaXg==
Message-ID: <ab82b578-8630-4ee6-abc4-50c0c6aab7b0@kernel.org>
Date: Fri, 20 Nov 2026 15:56:19 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: musb: fix use-after-free in musb_remove()
To: Johan Hovold <johan@kernel.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
References: <20261120-usb-uaf-fix-v2-1-cc3cb2a38ad5@kernel.org>
 <awBebBuAg2w6ZitD@hovoldconsulting.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <awBebBuAg2w6ZitD@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20-Nov-26 15:51, Johan Hovold wrote:
> On Fri, Nov 20, 2026 at 03:23:14PM +0100, Joshua Crofts wrote:
>> Currently in musb_remove(), musb_platform_exit() drops the PHY refcount
>> before usb_phy_shutdown() is called, causing a use-after-free bug.
> 
> This is too strongly worded. There is a potential for a use-after-free
> here but it's extremely unlikely to ever be an issue in practice as the
> phy driver would need to be unloaded by root while they are already
> unbinding the host controller.
> 
> Why would root want to do that to themselves?
Okay, if I add the word potentially then it's not too strong.

-- 
Kind regards,
Joshua Crofts

