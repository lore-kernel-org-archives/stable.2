Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795851041;
	b=U3VWDzw7sule/CNV4Y0PsOPzde1+ArcMoYCUj71AIzeD9m9hnTBdRwpYmekxCaNOb9dg
	 JKhmLPEXOFm04JOAbf10TiqhB4qaoRq+rP9Ld4gm4OU1j+IqB5b7XLmfDDd6WKczQdTYY
	 mjC+AVFUKAV0wOQt30tVeRK+LpwM2HFeMXOFqaAMO5fPsErdOoGWeQ00yfrxwDOM+KKPS
	 QN514Wyf/LfEPd238MDFryrq8q878V179A7MbCLMg8OkGZgNP0E4dW3E+jk4nDVsDU0sd
	 8Z5ds4uk2Jid781LqX8q0rkDurFoROxwwFqTuIwn00wZ73+ujDQiSX98bClWEO9ikcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851041;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ucXfR3cSDYhBuxi+l0VEG7NklGFt07n/EYwZpJ+2jUs=;
	b=jmjF3QgndVlUNRWWxkuUCNKK09b3NKoVzuq720rCDcEzjIYgovumeD3YJX8oeIOL12vF
	 UV2qyJzLNw0Bl+qugESUVY3GDPondsgHCqEzm3grtxddZQJQ2+Yu1bZoFxLpYPWFa3GPm
	 MEfmYcMpv93A6PADFHg8TQ0yMVI3K7KW0TysobgV9AO1QulyMCfTjHiJOGzlFwWnwqnqd
	 NCsL6uR6/thtC+rd8OZYRThZqFoHnMVEdiSy/2p0cspz2foJZ/Ti4jjNBfrmsuNsJqW8l
	 xjbt7QCjf4efRJuiWvixEYOJLfXaFq1P6AwmgqZ+jRPU6mIOcbJId1xMv6W+/0Im7nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=BqOIyXzS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mMSwV3eD;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D4606A327
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 07:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D68D4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=BqOIyXzS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mMSwV3eD
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E4053140031F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 02:30:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 28 Nov 2026 02:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795851034; x=1795937434; bh=ucXfR3cSDY
	hBuxi+l0VEG7NklGFt07n/EYwZpJ+2jUs=; b=BqOIyXzSa5f79sssz4nV58fyq4
	BbKmIZXPXfikTK2q/bYCP3EwF4hDlgbxiUeK+4/5pA6iD5/KcEpdcSCeXzudPMcf
	6ERnClR/pha+ADKLcyG7CyQ7hagp2lcjPWqksQTPktKP/wRZBugWhrv+l70ps7gd
	qDEIzdVS8VQsahsLwbU+2suvRM/ER4NvZ9+AgXlfpJpV4ZisMGEelFJi+fEkm1mS
	wDakYz1w52mbqxKGI3LCnjASZXYIItj8fxG6hnhWYhIut7rEGHDSMa8q8jkwf34f
	L5eG1wf4JwV/Gyvl6pvnbVVRbSHxKL1ygMAxrj997/ZAIWkmur4sDSmRUYzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795851034; x=1795937434; bh=ucXfR3cSDYhBuxi+l0VEG7NklGFt07n/EYw
	ZpJ+2jUs=; b=mMSwV3eDRWplMI/BR4NlyWbz2a3C9OYRhRUAl53gWn7qBFbxjDY
	WhRi7i9KQQql8u6sPyvL2W+2e/LHxc6mfxbcIcqfWhm+6RO+GZhX8MQEnpNO/lzw
	7un85R6z5SjXM40YN/rYJNe/YEZYqdlZpUTWYN5QDZ7iqqUXpHYwgfYZlIINeb5q
	U2Lj6LhHlR6/Nw7RoMYgW+qwp4R8r34f8F45eh9jJqQDHKmyz2vZIhg4qUUgY2iQ
	zEMoE0WqLsqey+sjtmZ8cdgmMvFEgRZ25PQ/SZbHVXxVi9Z/k+if5gkrmAfmDIQf
	UsvNMCjNfVT/egXVfGHsWCIwnbihzJxFWTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795851034; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:slCOzcLaRftciai7kQt5ia4LKmTO8bMo8Cwa1CXMCOPu9Fl
	P8P4ZLdNneypq+rCkFt1IijHSS83A2sItvhiYpe2m6sC8eJ3r9QZQYIpa/D22i98
	cZwPbtlUK+yJPdccU4v4/MkOIG77fC30CKp5TagQIALvE4y8RfOHDCOREgrC6KiO
	v9picSTqfbW+SWZQUHSrGB67X+c7BDpQk4Zm3utYcrptzcxT74ZnWy3TNkqrP906
	qVYzPfCJUzZ00OsVb5OnuC3zHj/vbqipaUewuM2Xs+MP1JR5xWrnjPXAyqICRnkd
	w1bCOLqem2FETQ9baoMx0LApnvKVRzd2ba1xHBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:t1xG/vO4VxUjcO8/e1m8t8+8oQnLwwPc4XSyq8TX5Fs=:WA8Z95GQHdnl0MllBz4e2MznzTsj7UYxkpGkxvpSspI=;
X-ME-Sender: <xms:GoMKa92wAytwLI-lDlJfnE0KP9hgdVj7UyFQE3QgtLO_LUQpsp0MPQ>
    <xme:GoMKaxm_Is1y8J3ja5dmUXe9GiK10XIueKEMP0JJbGZb-pTsJi1MMIrjtSI0tCldJ
    4Wns_hEQiU6SfA5wEQpND7Me3RDvqc5io-SsVYjaVUARzSPDQ>
X-ME-Received: <xmr:GoMKawjHTQZpn4_jWoogdYPDKw8d7Qt5jR1QoMtxLsDbvHTm_OM0MjBiE1PkHT1xa2wvfX2r5OHqHWV4nWYDvTv3TcI0yYw>
X-ME-Proxy-Cause: dmFkZTFUzIRWWZC+1BU+ZkZPhw2fte17lLuJPHFZV4uMVtmN4au8GicGuZNVfy9wdPQDkT
    ghL13mdoiVeFEHULpbXPdDxZMcCAAlSj9di5mXLv+VuiA/k5Auq17zVJCZK7xCqtOMJ6Mk
    TsKigzs+W7CiX8TsD+34kDRUdeL4o/9rIyEWpQmFxgAhWyqH+gL1nJz1We1TV1zb3eSAnc
    RuA/9YXg1DmGPxVBfHmq9I3i8QWTPd7b3aEZNwW6DaNhi9y/AjpKFGBqpmJGAAjPTbGS1o
    tgSnoX+NsVTnSAM6wT8qBMSLEgQGJnUkT/uMq/g21bo4IzbhX5yPZ28G/Xb0Aw52nDx6Jb
    61yR4L6omwARQLHc2hHut105vlYIW+mzDKDfsD7ipcirmMY0iGi/NIbfQxkbBbFSd7Awl7
    EBSsDyBOTFimnvYLbMMOuW/cJFfOI/BXrKtXgBmZqjF3DtqROtCek6cQDNGbnH/0pD6fXq
    B+IK8NvDjP1GfRmgHsDEKsnrjbcnONEgX9E74EWebvNMnHxbmHI1XkCqdHtSdjfLHxjNsd
    CKWYh4Y/02wWjazF/xQLnZTJjwt13sTQ35hHDCaqQg+Lx2eBraX4poDN4yXYrTNKb1waxo
    WFns2aytOWDKk0Q2iTiIdiT48ymZzQk+oNEcvpozun3IFsZh22YUqyet+0RA
X-ME-Proxy: <xmx:GoMKawQ8xsJh2LMDw3PKWrQPJaHrX8X7hK_fZ4N3IsGZOg_bywkolA>
    <xmx:GoMKay9tgwT74zI0fATYuz010ynRg_TK6dlsu193HZnCSTay7cufzg>
    <xmx:GoMKaxM_zIi-P7da1Se1zrCO9sGo_qHYugwNNFsSxI0g_e2QAh7Ujw>
    <xmx:GoMKazgsRP1hjbHWcti3OqgN58SnMzyxQtGBpVbotjTEdi8l06WtsA>
    <xmx:GoMKa8MqJklW_rLW3aAR9xkRYmoHh_kt7flQeYrq01Im766yRJHC0Lf3>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Nov 2026 02:30:34 -0500 (EST)
Date: Sat, 28 Nov 2026 08:30:30 +0100
From: Greg KH <greg@kroah.com>
To: Henry Zhang <henryzhang62@gmail.com>
Cc: stable@vger.kernel.org, jjohnson@kernel.org, quic_lingbok@quicinc.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [STABLE REQUEST] wifi: ath11k: signal strength fixes for 6.6.y
 and 6.1.y
Message-ID: <2026112814-habitable-falsify-b2ab@gregkh>
References: <CANTW0ypcrw2+BAqVKWQ6BOY2eUDK+D47aXuO1zuwZ1VaYwyvVw@mail.gmail.com>
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
In-Reply-To: <CANTW0ypcrw2+BAqVKWQ6BOY2eUDK+D47aXuO1zuwZ1VaYwyvVw@mail.gmail.com>

On Fri, Nov 27, 2026 at 09:04:06PM -0800, Henry Zhang wrote:
> Hi,
> 
> Please consider these two mainline commits for 6.6.y and 6.1.y:
> 
>   94f228ac4f5b ("wifi: ath11k: fix ack signal strength calculation")
>   aadeee47e9d7 ("wifi: ath11k: modify the calculation of the average
>                  signal strength in station mode")
> 
> Both are in mainline since v6.11 and in 6.12.y, but not in 6.6.y or
> 6.1.y, which still add ATH11K_DEFAULT_NOISE_FLOOR to the ack signal and
> to the average signal unconditionally.
> 
> On firmware that reports the signal as a signed dBm byte
> (WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT), these paths treat that
> byte as unsigned and still add the -95 dB noise floor, so
> "iw dev <wlan> station dump" reports impossible positive values while
> "signal" itself is right. Seen on a QCA6390 (fw 0x101c06cc) with an
> Ubuntu 6.8 kernel, which has the same affected calculations as 6.6.y:
> 
>     signal:          -47 [-50, -51] dBm
>     signal avg:      109 dBm
>     last ack signal: 103 dBm
>     avg ack signal:  47 dBm
> 
> 109 is 204 - 95, where 204 (0xcc) is -52 dBm, and 103 is 198 - 95,
> where 198 (0xc6) is -58 dBm. Userspace that reads these values over
> nl80211 gets wrong numbers. No connectivity problem was seen.
> 
> The average signal code was added by b205ce4c266c ("ath11k: support
> avg signal in station dump"), so 5.15.y does not have that part; I
> have not checked 5.15.y for the ack signal part.
> 
> - 6.6.y: both commits apply as-is.
> - 6.1.y: aadeee47e9d7 applies as-is. 94f228ac4f5b conflicts only in
>   the Copyright line of dp_tx.h; I can send a backport without that
>   line if that helps.

Please send tested backport series for all of these.

thanks,

greg k-h
