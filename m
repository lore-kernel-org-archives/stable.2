Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96FD4C33DC;
	Thu, 17 Sep 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647536; cv=none; b=myAAhB0jdR43UYyb1iskgVZwARWxdAGz6ErriB4D5DGPggtCYkxYDsR28umc/a3QLNHesOR/ETzJ2DLXVshZTc5hviKEOHgoJbnslrjoil1RxHZLYjDkVtolnib8eY/GtlL99XD8vliMfJqLni0dxktCnk8ByEK5vQkzhOtBaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647536; c=relaxed/simple;
	bh=0t8h+BhsPnywveReelml/OAF6d1eEcG7X6M0qNN81Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgyotNBdtCM9bgEQ6lr/hFhU8/j4V0opETdPWEZL7gNqFXRO0RgtKoUJ94QNw8ge6Ow0LX1DUeZxitMNQ9i53nQV7e47zuLaoNPat7nl/LGs/FdfcLKe7cz3+GoLGMns33dXS0xZ6Goze362w7vB0/V/mLMBey47Noa7gxY6qoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=BN4b26LO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sUlSZn5J; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BN4b26LO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sUlSZn5J"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD20B7A00E6;
	Thu, 17 Sep 2026 08:18:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 17 Sep 2026 08:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789647517; x=1789733917; bh=LAjOOeUKDR
	jXDJfarVM52blXGmzDeXnQH6eVQCc2rsE=; b=BN4b26LO70252BaFgO504zkUSI
	DVP1fYGA3+9y0UggPypMZXGktMzycctvDtgEzc6tw+gIUC5m0BdmhO0Xalt9YT2X
	WpHkn4PwyPDtI8it+Pk+mbVfNVDlCng2JxGnrlyA+8QQrVHAET3sMcou+GxU5Gn3
	jG8xtqKgCL9rUz+HfqnsuYFIj2OCoknBMM1hXkbZHArz6gUulDxzM5OovQd0WtBd
	Po8OapaPlVaeIaIadNUefwqBN7BvmHvirLe1QDNBT6rZo4TJCH/cErhoQbAA12pq
	XCxqGV2glpD76X6O5GtMQjeRSADU8tiXledjTbZk5qy/zri54fl0Swwzfx5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789647517; x=1789733917; bh=LAjOOeUKDRjXDJfarVM52blXGmzDeXnQH6e
	VQCc2rsE=; b=sUlSZn5JnFHhz6zFk21+WuXMpccVyM/UBXdoxuWah1BpoeMjUCh
	KbJYm2gZ++m6PWhWBOpK+H8vspHM06liVi28+0uc1EdMZZI1SMqNqbnk8sKuVOSB
	Wrf/hP0CdbphCFU+kaW8d+FiJh620BJplWWH9/ujVotWfqRB49avAoIqe3HwMIW+
	YzNd3p6HAbTpQOA0od2OK+bYQGCejbWCSSJs/oBrsDJ5vOxb0krpZP78CizsbYac
	5F4yc1sAum1BAkxU2I7HcMFRNeZmwbg68vWuaehX7AK4S0OK7Zq2Stfez4z+lAFV
	1oIQccRE+L2sj+dvm15tTO/Cl4EbmZp4fbw==
X-ME-Sender: <xms:ndqraip6SfvQr-qlRp8jjeWMePOUAjLgYQgfzdoPtk5JlJkvCQM3gg>
    <xme:ndqrah9xlKpdmnwz2V5JqHAfi6gUTmK_10ZW1GGJAUB345Ae7Vmgul2CgP_7el00M
    ry_vdyNQ2MWeaOnvIcOsaLn49GYV8N6Te-TUY08GQGJpgv2ldo>
X-ME-Received: <xmr:ndqrar0ImcQPcgKgDrJ7MXBVcUMlfzQ8NjeQT89s4jvf8DJAsdZE1wDKXQl4>
X-ME-Proxy-Cause: dmFkZTGDah2Jb2jRQUEZgifNQBU+Lq0R5v+Bsd3VBbPUnA5QmfBTz4OmpdLw1ZSbpbr7SL
    GHKNubWbjK/vPT3lS2J8HH527dFzsLxUmPIbQA53cCSDUqAk8YxEmraC6d8XWycovJ8jfD
    3z6yfiwssT8G6xX3H1ILu799QeMMr2K+qwCasY03y3hppJfLI4T5c5GY60EY/MpAznL5PS
    JPNbesxaa+WiaGIZ6jsu3NSDmqeHHswe46i+2euLABJ/+7hBJpeGZvLSaa8Pgcw5yXlwBn
    /UVQLNbqHYThB9n5PpvSGCEOvD8FLTTJg5Wdip4V8h5NgS3/cLLDaV/cNBGtAFWXFM8kke
    PfJZREdh9frD4QRTt5PeVs2vsqNEEC+Bk2aCZ9oeRRnZAvh8urANyDWTIaU+0x0zWk1oB1
    1CKlcvOkzdbLhnhLqNNjiu+9b2pRDm4OcFcoKlmVuc0G4Tgz8TtYYaPDAIGX/tbg15R+1j
    2e1DpCSgS3wUwvXpI88mPOE2UpKfU8W/1xxCfStNG/rUMaU2u3NTQFBVvQ7WtsX3mg+UU/
    7XS1HZr58SiK+oBzNZafhajVmZDnlgTh7wmSJost1rD1bdoOpSeesR355G8t5NomuGFal7
    nZ3yGe9Saxd6KZ7kFb/J7cqJkMLygNjSajne8V5dRhGRL8z4V0ypRcku4TMQ
X-ME-Proxy: <xmx:ndqrakku-tE6KVAEniCUERa2rEIJMO6Lynf0jYcKBPh3LlHi6ruEHQ>
    <xmx:ndqrao3ojGzimCwoLxEadFfkf-EohTHJPp_twjHpEI1kq1swHIipzw>
    <xmx:ndqrajh5VpSP7Mgq7shCClApmogwIZcPzjfxqWBIDtkn-9pfQeSZsw>
    <xmx:ndqramUwGP4Azsb7j7jzDhf4YCFK40X8vAJ-yblTAteAEIvB47sLLg>
    <xmx:ndqrauxxGghxPCPq8CjVUmfz5IT3s-WBQYcXCVQYOsDcz7RnvDLo4QFy>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 08:18:36 -0400 (EDT)
Date: Thu, 17 Sep 2026 13:14:24 +0100
From: Greg KH <greg@kroah.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	elder@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: ipa: Fix valid_state leak in ipa_smp2p_init()
Message-ID: <2026091702-engraving-bride-3af1@gregkh>
References: <20260917115424.2149947-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917115424.2149947-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:54:24AM +0000, Wentao Liang wrote:
> qcom_smem_state_get() takes a reference on the state, but
> ipa_smp2p_init() returns without releasing the "ipa-clock-enabled-valid"
> state when the bit number is out of range, when the "ipa-clock-enabled"
> state cannot be acquired or its bit number is out of range, when the
> smp2p structure cannot be allocated, and on the error paths that free
> the structure. Release the reference on all of these paths.
> 
> Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ipa/ipa_smp2p.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Did you forget the Assisted-by: tag?

Please reply to all of your sent patches and fix that up with new
versions.

thanks,

greg k-h
