Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C072630
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176558; cv=none; b=F3S6YHvrde2BosvRa7ZLYEYXGP2hTVjucnNNAgwqJV/vp33+GxjW2PKXjcWIRHVe22D2phkMoZlEbUnyJiAl7WhkxHmvz8yo7Lo6jR8ouaEBbsi5Uoto7/c2T5BLJo2mm7tNxI2LAyMHprxV9Z0Ym8OA+In/qP6kGm5UNNsWQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176558; c=relaxed/simple;
	bh=5fflkNDE/rat/McQZva+DERKMixrwiEK3N5kHCJcbQY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=aYD+E/evWarNMLVOwxB8hyRnh3PfZZavivZArflXMeKO/0KdGZS1T6MtwOZlpCJUc6+5s1CtH5u8MLwLx0bkqNjOnxyfk3BAlKmwXkKGIVu1LQDgpwN7qJohw34OD7RztuNJn5bkbsGwrcjcWY3PHNjDU+Zjbx+yS/8yVkyHG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=TnsscoqE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctnIRHZG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="TnsscoqE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctnIRHZG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 82F141D000D7;
	Mon, 27 Jul 2026 14:22:35 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jul 2026 14:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785176555;
	 x=1785262955; bh=rgcg9j98Lwqm7hey1BKsaFmbweONVXLnFrJnzYS4Qrs=; b=
	TnsscoqEttGXwtrXCBNUQhjosGMJI9YnisPcPkMOtH2OuX09nhwEV39DK8N5+C+h
	v/NIeXeV1gopiMhnqyu8zCzdbPLklMGHXZYOc+qBbC3kg6ua5vNAhAgR5A1Fz+Gy
	Ahxq+sVjNpn9WHM3AtSWJBXypdcJA7x5Vwscvr9EijVdsTDvmmvBOc8YiNN3UTjI
	Tkdajcyj/DxVQttxgSArdOjBeoQ3KhyvktRXFEi2aoW1ZBsTiXEOOEimGi/tBsnH
	oWat2Qzc/de/wVb3mWeq6+6mzEl4OtJvogFIW0LIJdTfrhx9mUecdMPizJKi0f6G
	CBTyTwHI9p90Q8QNZa/+uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785176555; x=
	1785262955; bh=rgcg9j98Lwqm7hey1BKsaFmbweONVXLnFrJnzYS4Qrs=; b=c
	tnIRHZG6howrlFgG7gi4ExpAv3yqUHDkr5SP1t5jrGfgHcrfECKONCuivV1xg3QM
	7CQbSw0c7KbCtITv+POS4E0+CeIWuv2DVazOcF+Tkmw6bXQkc+Ycns6oA8QdD/N0
	qHwEFDUdio7iMnle/GEweatucKOCQmRcBfZxWPnnIbfKuYJ4an0YOxx3+uxmF5+F
	vepB2lhEq8FtFyCwcJbsDrD8ywCkFYd0lEI/FObaGi19ojmV0a1B5Kx2jxf9X6CR
	Z9hcgRV7lch4rygFiU1jFb2WJIw/5uFesTHJwK3/NhK/AuJ4qof2V9zpvgoukpqa
	CXGDvD0EAWa3062njuM6A==
X-ME-Sender: <xms:6qFnarQfk6S_Y2iX-dP9QogJPdjFzUJK6eHgUKY70xEAEvu_gcVMWA>
    <xme:6qFnankLn24akx66VHJHkJQKLZ3dK5Xk6zNJ7axlyCTTv9qY2xJK_c_E98iESuv1D
    c8iap0EcGdjM3mPIyzR2wh17Ohg2O1Hll0Hk9T6PAosO8ZRwKnlpA>
X-ME-Proxy-Cause: dmFkZTG0IUH6IqjOo8ILsLRqcFWa+5fiMnqVLw2kvu9Ve9SSSk7YsWG9Zc95tRsDlJP6VH
    4W9lBEOpEuelX2IgcKJ80qdHsEUgb5IpktCO7He3CHUXPeKfcxh+/yISzlA2qhws4qQGc5
    YiiLyZ4Lg7wPZYxNem0Roaxx6qiaZena2R0tB5MrTUhZI5cx+kUZ3qqofLOivdr0U+i605
    wif+Yaeraurc4ZYPKT5pQc8QbKLKo9l2cJJQOxp5vGTmNmwEEWa2OFDeWoUro2CUf02EqE
    L8cl2ikQIPvYd+X/CPWov4Gq6BseE5gwQxy4mHOMKfHh4nMPxTh7jyfeGvOXViErqd4Hmp
    4PsnlhU8DkQy3FY537buvD0HlALnW/a5VeF4z/UZkajGH+Xpupx5ZNLohl4RWIB8oi/Qxo
    uZMjA6+op9XgUNznSUWmUjCEaxPr4NxUFLit6Yk0z39SFzc9AjH3Ww9qdNDiz09lyDMaug
    DlLXPYkfyGQyG/ZIql8eMb9r/sijPJ8Th4nc0VKYbCUlpFJ6adfTEeTjbaIONK1JTJI252
    jQ1hOjYQ40Xs75seEs+9Zm/fYCUNFHoZQTay2s/pwbCZLBrk8FW1ifTHnkbZ/sGVlv5YcD
    Xq4SrFIh2oC5bquPPV8aU9jWV2bTNGG8X74fS0gQ1qYX127oap0V3ql2uvOA
X-ME-Proxy: <xmx:6qFnai4wB_YjyN0iFZUyFl4dgNRjZGcS99YLnBDIgvDHEZYsVDk0XQ>
    <xmx:6qFnanUlV9N_iF6iPuy4Dy_nBFYYLV-EhzYjU3tlVSl9IVRNLf0MqQ>
    <xmx:6qFnak8kic2gAEjjyWWOU8z87IOEj53gPD9mmLhNOobLKGdhs_TN_A>
    <xmx:6qFnajlWBNDADOFUMzuYmKgZlT9SCeqK6AMPR8R4sba-3NTcSmhtFQ>
    <xmx:66FnamDEwMFomhNb7XbI98uIGAC62EHCF2GM4KHsgA1LCs45I2iIaDFR>
Feedback-ID: i1769461a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B8E083020081; Mon, 27 Jul 2026 14:22:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 12:22:33 -0600
Message-Id: <DK9K9VA0D520.349Q0HITXDW9Y@lyndeno.ca>
To: "Sasha Levin" <sashal@kernel.org>, <stable@vger.kernel.org>
Cc: "Lyndon Sanche" <lsanche@lyndeno.ca>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 6.6.y 1/2] platform/x86: dell-smbios: Move request
 functions for reuse
From: "Lyndon Sanche" <lsanche@lyndeno.ca>
X-Mailer: aerc 0.21.0
References: <2026072059-eastcoast-eating-4897@gregkh>
 <20260726212730.4016280-1-sashal@kernel.org>
In-Reply-To: <20260726212730.4016280-1-sashal@kernel.org>

On Sun Jul 26, 2026 at 3:28 PM CST, Sasha Levin wrote:
> From: Lyndon Sanche <lsanche@lyndeno.ca>
>
> [ Upstream commit 33245680ae565aaa114d726bf407c8ff38e75e71 ]
>
> Move the dell_send_request and dell_fill_request symbols into smbios-base
> so that they can be used in multiple modules.
>
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> Link: https://lore.kernel.org/r/20240529174843.13226-3-lsanche@lyndeno.ca
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Stable-dep-of: 6e9cab2247e5 ("platform/x86: dell-laptop: fix missing clea=
nups in init error path")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/platform/x86/dell/dell-laptop.c      | 23 ------------------
>  drivers/platform/x86/dell/dell-smbios-base.c | 25 ++++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h      |  5 ++++
>  3 files changed, 30 insertions(+), 23 deletions(-)
>

Reasonable to me. Thanks.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
