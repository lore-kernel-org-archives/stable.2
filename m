Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743270;
	b=u9q0AKUFo5mXmmseoirAT2wwf5kWwlHIyvsMovyM+29H7g3PShu9myptD+VQAEWhhEh6
	 EZCJDI1zXcMXsoH6RG6gPBkNOonZStM8F9mEzRr+dnjpJ/F3CQyjYrQ1MWVb4hfNVtYJ4
	 Kj4a/7850VppK76kcQJKVKnRCXPVNtxFf/vHDK4u8IaJk0XeIOSy7Rc27RAPwdOGAb7j7
	 R58AGFXTcr5owFeoJ127XMc27DZmVFQbZiFWdmKOgUIVRXwmwzKrXQ2jFr4N7au5d2uhh
	 Dx8GhNoX6+/7yenUvB+e/t2W2PQVI5CIRrwHfRYKOFJCf07OHzQbymwc3PZ9tjECltg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743270;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type:Content-Transfer-Encoding;
	bh=lI724t7k9EPrebnQ2BhOfSZtdqpTgQ4IuGkGe8WYslo=;
	b=QvjfaVAuEBolsTu5RcyrQFpwAVXxmBGfwpQH3FCw1cke9Y/uFPpeQQO9evX9FQuFnWIQ
	 JgTh7WyyR3YHxZg0EAOGNtQZQtdJSTw3KToVkcmWSccF8skaKwo7jUPJm6LihMuA4Oppn
	 5FiR3cVcn+EX0VJ/F9opKMagH3li0b96lgSG11a+qyEBd0g925LY/HM6Z8jNOmkgEl3li
	 q9Q70zWqOcMazjJK0BgySxrIN0otbzRo50FsbzNILuQn95DOeYQ5pIQFAkwNc24k9kqm1
	 lSg//5LHFw+0MNmRyhz3IVhR9cL4NG7WKcqfc/6Zg9olZuRPSFL5yJk66rQKQJlUfeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=gDm3tTyB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="S/OWFhYp";
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84A606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 11:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E84A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=gDm3tTyB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=S/OWFhYp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 58B6E7A00B3
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 06:47:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 15 Nov 2026 06:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794743267;
	 x=1794829667; bh=lI724t7k9EPrebnQ2BhOfSZtdqpTgQ4IuGkGe8WYslo=; b=
	gDm3tTyBbcDh0QKRW9E5Qj5qfMAZnQ5n2y/ybvgnDdUYAfpuxHjg5+CfK9YdqkuL
	x7tgrJiwedQSzqAff6pi2xjJ17zaKU8nVeTJdjNFb7sGviy/U0+cfGGjAWMbSctf
	YFo/9RG+5TsIEW+2NYXdZlUsrhQkUbYzuddYFQsqIn3RfwjmQ8dwUGOgi+Up4f0d
	46ZY5Kw2PRbGwGFoHAVTk8PPyPl/Tx6ys9CXDCTnhiTgGOjkY9QJrEUg7zQy46jm
	mYaR4AVhVctI6Pkveh3vnrqnyKDP55qgMTpbYGs7KYFdk8NC0ztp299d9q1/4L89
	W7MCIUSN1q4s8Z57bjAJGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794743267; x=
	1794829667; bh=lI724t7k9EPrebnQ2BhOfSZtdqpTgQ4IuGkGe8WYslo=; b=S
	/OWFhYpQLipal5EkNqqp6aygm4kg41dJjOK8gxDsZ1ozFsE/KRQfOJAL/+Eo/UXi
	TOdTFD0uKJMTFWV7qDVCcEYIJ2PkKy1cie5XTmvUFDYi2u+pUquu7n9ABsleIiFw
	7RoZha90u+gi5c2cl8FV0qhZQN8Z8boyYy4HnT17sE8ASSA4do7X1fp/xVpphRD0
	8FNirkxHZmV0yzhwOnNAkTkP+kKr1xZ8dyEavm8v/2YExVR1OmZ/qE+XwVgA8aF5
	OgRlhPp6EF7y955DJhIeRDQ/9DAJeSQT1/kN05Fsiqz3mHNous3OeQNMviOhmXPy
	7eC0vGa5mjqd5yVuSbsgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794743267; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CQONjW4LZjBTb0PyZ9jMkTc2wm0ZJlJbXC9wJb8dIXTxCbH
	zjPS1xLwKHLEN27r6sJzZ6a9laGdyoU37sxxALKTC4wjDul/YeSX5olFfbBSAdAI
	WqW/sd9GMPfK4UhccJWGQeeW499pAHc2VyRFXPmKCLD8bb8+8lI9ay1by11PZ3ik
	yagwX4ep+qiUU/kf/yllv+iohoWCFll5G+E8NENEdM5vOTN9+26IC0hV2OME6B4y
	auGi+t+jR0dJowWssPa4BXx8Qwq0nwH7ytXGIZlT4u9Q1Z8iBXn6sts2J6/C8WqF
	PQ6+fRXsP4f+epN3M5c2KzU4UHASaWwRVKRjZ2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:D0f4AVjtNwMxTvq2SdaVeL5yib32Ay9IkIlmEIaNsUw=:vdKxAE3gCrExJAQbL7PzlMgK3RhoD6xitvL41p2jKbM=;
X-ME-Sender: <xms:45v5auZMHpPE8QETAnYHGOcbs0flnlISMj5gVRCyNOzJ-uGAw6r4Qg>
    <xme:45v5avrnfZcYo4QkS6uDyB_Hux8RckKVzWy1Nuev6JQZPXZowBmdfk0dpTANNKLct
    HU5x6uQFUey0sK6DNq85V4F5cQY2CE9RUJE2aEuYJX3GhamKnJ_QOI>
X-ME-Received: <xmr:45v5aiSlzDz1BqYRSVpdlCjyvD8JFpf6XNNu5kzZ-kaVpzOM7JedGx8EN0HkYVXvlpPuGmkXGF9oZdiJraliHROC>
X-ME-Proxy-Cause: dmFkZTFO+5jNL0/l2J1HUjaU6NRdwp+L8DRzrx3jXz44XNU7TirSz+thrk/dabj/RqQVzj
    hAdcvy/STO6NVRNIUaCR1vNG3Spt1bnbI2chYs/ysz5F86QM83uvQY0R5y4IIvxJdSoEfl
    XdoUtYUHYggScqytctF//z2qA7a5VscFIeFAqpuAwdEu//ilH7L0Skyl28SAq/FDVXRz3J
    9kbPLSl5lC1893sLsEWqW05kAzxI8JUWR4jeTPzCzGyLfhQYL9oKt6CQqQ+1kDgVvhnP/F
    HIGYZWeW9S6auvimv6C7mtH4wl2ZNFRfFTnNGeMaM/FyMJ4F/ahBYKwblxYzBZaaRfXMI+
    SaLhillDBzaKYH3dB6QRTfqZn3NHQCGPj3p9xOxlMEa51gnzGkqmeTA9QOPNuounUIJSDz
    mjwBWVGzdcoc9CgHqmvo1h2Hy+bqHsNvOJYShOJxWxhgwRTCtrvnbLHsBV0zyE7saQqrOv
    rwKebbIRMimWk8yHp0NkC8/eAG65D7bB0mRlMj5nfHZD87tUDD++Y7q3iZpBZkSma5a2cO
    mMjiVqv0RunbA9GVv34smtkbNXpT8Mjwqpes6DTtmXBPWju3A7sma7p9t36mueOvF2cC4o
    5h0s4DABDAYmH2UwEVxOgu+JcLEXsmR7wBZuxAuInPpoPZ4QDwl7GNwW2olg
X-ME-Proxy: <xmx:45v5ajp7lSvEhbnRPhdpLfBev0Q4xwf__MY8bOWrTfrR-5gy5Ne7Qw>
    <xmx:45v5as2unpCs-vDRVojYAf7WLhSndv0kbLNnb8oQwF-q6OFGEir3QA>
    <xmx:45v5ai4Gysx03hQol3q_b4WAVIlFFy6SlXFvfQAv_IazeKWD-xDcmw>
    <xmx:45v5agQvSxIdRu3ptSBD8L2z9hCtK3MTb0M-EoDDVavlqyh6oPR83w>
    <xmx:45v5apYrVDeQQ195k8Yv1qju_Y2MLip1JM0cJ5TzAeP0QYb9WzvWGbot>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Nov 2026 06:47:44 -0500 (EST)
Date: Sun, 15 Nov 2026 20:47:41 +0900 (JST)
Message-Id: <20261115.204741.1750241782166111925.tomo@flapping.org>
To: netdev-bot+sashiko@kernel.org
Cc: johan@kernel.org, fujita.tomonori@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, stable@vger.kernel.org,
 hfdevel@gmx.net
Subject: Re: [PATCH net] net: tn40xx: fix swnode use-after-free on probe
 failure
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <179452098811.2199510.15081106290449010908@kernel.org>
References: <20261110100051.2567443-1-johan@kernel.org>
	<179452098811.2199510.15081106290449010908@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 22:03:08 +0000
netdev-bot+sashiko@kernel.org wrote:

>> --- a/drivers/net/ethernet/tehuti/tn40_mdio.c
>> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
>> @@ -157,7 +157,6 @@ void tn40_swnodes_cleanup(struct tn40_priv *priv)
>>  {
>>  	/* cleanup of swnodes is only needed for AQR105-based cards */
>>  	if (priv->pdev->device == PCI_DEVICE_ID_TEHUTI_TN9510) {
>> -		fwnode_handle_put(dev_fwnode(&priv->mdio->dev));
> 
> [Severity: High]
> Is this put really stray? It seems to balance the reference that the MDIO
> core takes on the bus fwnode when the bus is registered:

I think Sashiko's analysis is correct:

- The fwnode_handle_put() in tn40_swnodes_cleanup() drops the
  reference taken by fwnode_handle_get() in __mdiobus_register().

- tn40_swnodes_cleanup() calls device_remove_software_node(), which
  sets bus->dev.fwnode to NULL. So the fwnode_handle_put() in
  mdiobus_release() does nothing for this bus.
