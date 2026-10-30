Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356088;
	b=CrCqDQWLlAL5WVgH4cnWaqJJBXIb0+ZZooLvRaBnpHKjQ33vnl+VuhSEP0ooWlNIexcE
	 CrVuSkiY85XSXU+0Lt4TDpqhpLA4aJqV6ICYYTXDzMyX9VPpTe4aRU237RuO76wC7Teg8
	 D4UJlZfkCIlBU+NZnarYGbCtFWbgaoi8QRWuxh8UG87BjR8MJ1wg5XowkSsrjG7WRz+V1
	 tsPjrM7SznxMsZlUC2yioqSR8L/j7WuSuso2OBC+RP8VEcgh6bqOKfEhEbSNh4SAk/mC8
	 5b65srGeGGIatFeoTMkfG8B3SDv0D7cY2ps3ddRUzNXYH79fiFTvpfr5jc5XnhtYIeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356088;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NnAtcy2DdStviAIIu67Lv5yT5v++fcCVEEkxY/cv+jw=;
	b=0qRNHoM13HZxDNC2jJ0QjERp0nwXlKOv+vEZzLgwMnwU3q2PV4OfYJ1cfGmn93UOr7n6
	 96xIM5fpSmRqYceYC4xb4Gvkn7ocZIkOXnJjIXIeWnrNz+BOkQZYsJWa/uDqwHsNWEJnr
	 cMp3o/A2ok7NEgkDDCWWYxXOu1jGvAs1EqlGaCo4HjAHbhqgBswTLW4gPswLAFPDNE2WU
	 mOgIK/Z+n0/7cbiJtkT6tFReE+xd5Iu+vvtAur++qpOsbPg2zSHUz7Js+LuuFlHSDCW4Y
	 /c9Zf9Kv1lJf8rAMoHqrGX7IKWS/U5EPBr+z9K1fbk+u/97mtJO4LVv3RJTGAuE8UIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=kHpw6gx6;
	arc=none smtp.remote-ip=212.27.42.4
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEF606A33D;
	Fri, 30 Oct 2026 10:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65AEF606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=kHpw6gx6
Received: from stf-laptop.peak-system.com (unknown [IPv6:2a02:8424:8fef:6e01:2a4e:9a3e:485b:cbb0])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 3A2A519F574;
	Fri, 30 Oct 2026 11:27:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793356086;
	bh=HLQvl6Lqe0D0D0QVBPQB2h1Sv8s0n6l64rahB/uZ1qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHpw6gx6Xu4WCnTFDG9isBZzvFUO67x6PtwSzq0ySvFn97VtfO25kyPWWpif4dmyp
	 CwRDA0ZZHUpZEd7Ep7IrJWeX/juzHFDTrRK5w535dYq7SWu2jQYK8knojIb50mnAe6
	 SZxgDS1AOKPwOLh2L9oniAgeOmXyRajXcmwJX2bRX/xPoIGCeI24HBrtRY1dIPwI31
	 hzku0rlOlHePSL6SgdDyHz3iA1/W+clnXdlGhxKRuWQVWFPmndcJLvCQJVX4xnXJGh
	 d4qU7PvgYzi/jFneR3sp3PtbB6g9V48Bjp/tFAXLWp2N38COGq+r+NCjhGsyjUmsSF
	 fSe0kz6Qd+Jmg==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	wg@grandegger.com,
	error27@gmail.com,
	lukas.magel@posteo.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v6 11/13] can: peak_usb: don't read past the message in PCAN-USB Pro decoders
Date: Fri, 30 Oct 2026 11:27:03 +0100
Message-ID: <20261030102705.30262-5-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179281433565.3130.14307625292135673040@kernel.org>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr> <20261022-canfd_check_channel_idx-v6-11-197704231551@peak-system.fr> <179281433565.3130.14307625292135673040@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 24/10/2026 05:58, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> With the current callers, is the last sentence accurate? The code change
> looks correct. It is less clear that the old walk could ever leave the
> command buffer allocation.
[...]
> Could the commit message describe this case instead, so that the stated
> impact matches what the old pcan_usb_pro_wait_rsp() code could actually
> do?

Right, the walk can't leave the command buffer with the current
callers. v7 reads:

  - pcan_usb_pro_wait_rsp() doesn't check the records against the
    received length at all. A truncated response is then accepted, and
    pcan_usb_pro_get_can_channel_id() returns stale bytes of its own
    request as the channel id. With the current callers, the walk only
    stays within the command buffer because its unused tail is zeroed.

Thanks!

Stéphane
