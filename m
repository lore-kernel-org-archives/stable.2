Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B61C2AA;
	Fri, 31 Jul 2026 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459313; cv=none; b=mZKK4+remislNMbkiCSaApiYzHY3tEAeQ6el3biTmlEj1JE3DCqBs1FlcEnjVDIv5Y0Etjp3woIisbqzlIp9XMWY+VQO0+vV7IF0ux5Cm83wghfTThIn9oYFmWfMuFNxUK81/a1FVQyWIS+Sk3s2lyIITHHEkwJcy2rfNNgVG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459313; c=relaxed/simple;
	bh=DTCvfnSCjJcr5g8zDX8pj8ow1e4YKMPOiHSsFUvWQEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dp1cLAfgb+tomwmZbfSc/pDfzEOVp5Zi6aU+KEF8kLVRIJYcWh5F/55gi7Z26Lb22R+ivgSATzHAwzyguSmSxA52OLMVCqjCuhQs2RGMu7LJFvR1sHcdwNfiWZmVcDRGR+CpYTfj73H7MaPFkuoAWG2HU+Cvs3YAACH2jRAnPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oha4971v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oha4971v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F371F000E9;
	Fri, 31 Jul 2026 00:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459312;
	bh=19SaHaqRUXp3CdwgY04UlzXyYGFzXxA/w33NNKiRYX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Oha4971vnYRVE5RAXExZ8DpMn3BIALOj/idZ21oui5MYscf71udLeHYMjPChSVWO0
	 Xy5JU5V8RHmo2DYrSTqQLs3epf47+Tu7PxubMjzvYkyuZ43e/MaLAz7NdbzjNn3nnf
	 B/mLxakE98SPOM5mlXkPoDu6UZ/532nzbb2cF9s4xozzNVNtdXkfmXicnzBaeJ3ZL6
	 IPUrikwffoqT160LbH8VStb5jvDy10O14nlLr0ButON76zbeL1aSh8IL4ZPzNV8Yyk
	 yMz3AW6olQ8oOqVT5ssK1S26SzZm6dYGe1uj6Uzm9xhzJ1hEi10dKn9AzXYZBBK5re
	 wLYKPgk+Jxbgw==
Date: Thu, 30 Jul 2026 17:55:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexander Kappner <agk@godking.net>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: usb: ipheth: fix carrier_work UAF on
 disconnect
Message-ID: <20260730175510.2c180a06@kernel.org>
In-Reply-To: <20260724134250.34360-1-doruk@0sec.ai>
References: <20260724134250.34360-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 15:42:50 +0200 Doruk Tan Ozturk wrote:
> ipheth_sndbulk_callback() re-arms the carrier-check work on any non-zero
> URB status:
> 
> 	else
> 		schedule_delayed_work(&dev->carrier_work, 0);
> 
> ipheth_disconnect() drains that work via unregister_netdev() ->
> ipheth_close() -> cancel_delayed_work_sync(), and only then kills the URBs
> with ipheth_kill_urbs(). usb_kill_urb() completes any in-flight TX URB
> synchronously with -ENOENT, so ipheth_sndbulk_callback() runs after the
> drain and re-arms carrier_work. free_netdev() then frees the netdev
> whose private area embeds carrier_work, and the pending
> ipheth_carrier_check_work() dereferences the freed device, a
> use-after-free on unplug while a TX URB is in flight.
> 
> Drain carrier_work again after the URB source is stopped and before the
> netdev is freed.

Doesn't look very clean. Maybe we can check netif_running() before
scheduling? Or disable / enable the work.
-- 
pw-bot: cr
