Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2645399019;
	Fri, 17 Jul 2026 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271925; cv=none; b=TQsxNzV8euEnKVmWGN+/BC4Whpf+tZt4AIyxhJwaPFA65bt73m6B0+LqLxRKYkAmzqPeHtcBBhANNIZYabvnlCb4l31gPBwD5BHuEeuHWtKsz1ou3guCPLvuFlPsRLoGTxjzOoXqKrt2NquBIURai4LUmy90Yog7zYovds37yU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271925; c=relaxed/simple;
	bh=0hwnV622AfE2GAnSMNoSc4ILPbsn62OjfFzGQI4nDsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjrsAKrvpVuGlihOCsVdgkehlGRwvLcg1iNQyo+5uUH40b5lO7rbVyENA6uohatsgorjpEOO5n9SdoyaeXTyXL3r2Zae2Gp+0gAtuwVm/uKZUE/W/B6Upx/ZN39nKdVMIZl8KzmYHbgXbwz+/67EH/DdVCEot5Yzj6XbeRerONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=r8gQmRjC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLzDhtXj; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="r8gQmRjC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLzDhtXj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 699A81D00133;
	Fri, 17 Jul 2026 03:05:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 03:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784271922; x=1784358322; bh=ZjTQ7BBxX7
	BxMZn/XHlgskJKXfujCvMR6jBeytcxCeA=; b=r8gQmRjCpGpbgLuJ+NmDJYsf5t
	DimD9fEPDxCHunlRXyI9zlqV6d+Aqo/0slsvlBNBrLZfB8mZj9jkuS4X/Vvliaza
	/7T2g4m02HZXLRVjqQmXS0aLLQCD9P9ajg+rrMolBttgHo1F68AX3kZOC7WdRX7d
	MlBVgm82YmdaOaQSUpo+1oSto+X7/Q6cXjlDkwBocHJvW3DlxJpPt10+lKIFKQVE
	ioS/dZToKRZIR+m8VyLlhyhM6kG2Feh8dPlhX3j0lFspAjmbY252P+/O/UJJRlp2
	oyfuqKuhgVbh1waKznZ1eUnKUSOTG1n8Gbsat5s22QqecdHHhLmGoR06EChQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784271922; x=1784358322; bh=ZjTQ7BBxX7BxMZn/XHlgskJKXfujCvMR6jB
	eytcxCeA=; b=pLzDhtXjAshMGBZRewvR68LuDfjg4y7Y0AaS8uLL1YcNvyIaXYn
	GlDauZQqfjEtK1amfUGmhxYCFcmcqJ1ckGKAWGYtdXZ7AlfB5vR0qXd2mxJuk3jm
	Nhpuk12BLjZUyou3wKbSKoSXeqROtehHDFcpChtnqk40Izck9MyuYeLWU0nc3opd
	9/9dxS3hq2vt6Pb1VrF2naDymurn1zXg/VwuOdrcfP6Ovk7g6L7k9q3l3Gn7kCu+
	L3wm4vZvx65KAIHq/0fsj9lYeujxp8bq4S+pAbXcs84VYXwpkpwMRWrbHYyGB2Yt
	0D7argX6m7FrV0KBKudbnZVAMC+T4HytUDQ==
X-ME-Sender: <xms:MdRZam0DBd8Lc4-drNf1Q7ZOc_HCcRF6cgnSytJyySGj2Ef7T7b1Ww>
    <xme:MdRZalfjkmXTFp03-jjCMtUOGJeifVJGpONSUvywC4PwYPTe4xatfreVhjlI-GhDA
    P1oJpupa1fTWnvJdFqlvE-xExp9gtMFEyFdO0DjpE1BfwoTCA>
X-ME-Received: <xmr:MdRZajWHuoA0bkfAIcq44FUIrtrMLz4xg8BnL9FTw1_ASk6TSFY83SriaI__qZDGkx2fWMR5rZlisiawkGAYgw8clQ>
X-ME-Proxy-Cause: dmFkZTE/NZscOm6WbqUCDU+JxqgeecwpxctQwR+Y2LJ0R1wen5v+tDUrcMuf+0BeWo9sUi
    Ni7nSLfFmb/rAWYP9VN64JwxmucDY0IGadpPOFUsShmApfu/0PzOW3a26upb6vMVsyyq7k
    JOsg3hEQ77Rv+jD+jm353PPd9A3RDKiOFYMQ3RE2X+UtGpOIVwQaqx2MN40xsvC/ocO3oq
    sjHNCu4SKL8jTSjUSvcK+K//FY0lSTjFq8xYLy8wYovLut5RJaEuyKdhhvlw7IP9JtiMM5
    jw/avbfL43Ef7V/xNtj3pD9I9ReyV/Q/p+bGR6a6gF4j6AtBl336GCYom7a/b/ZSaaxfCr
    rmDz/EceO1OlSCNa+y89AtOhZrPmJrOIU/tre4MzWJEZbmMZ7tKv9fZEGnrE1fTWcynBD0
    yenLyAAfdUF2qbCeB2uihlqqWZfO+H0/PUMFuItXkXxkmFrrwzpxsdMv2g4ZKmZiSJHboi
    S5ARHgWgk6mqD6mIBY/tfo7S4nPWYzUMEwxTw91ezgkMoDR4QkhVjZuG3NwBtXKUE1Kpze
    kNCRULZXDN+u2EkKmUza3KjlOn1mI0ll5A3E92erLyXm/q344MqdsDZhFQ4aS95j6X6zaV
    Z1G3qr7iDe1tHA2A82N5NtyaTGD1G7oHD2mDdF0WZxBykIhxntooUY6cpDFw
X-ME-Proxy: <xmx:MdRZal9E9obRv3negdGzSFm7Hka4VcDnap8DyRJFwWVnBhBeP1MTJg>
    <xmx:MdRZalgWo85x8Ev0N90JjP60OGTZsFsjt98-kiLZEkms4BurOfJzxg>
    <xmx:MdRZape3CoYyZQO-KXAqbF-kyjnnPMao8EHKOEZalAWzWAP2BXWM9g>
    <xmx:MdRZamLa4HiLaqw3t22k3rbAEjm02zD8SKAisf7I4P40AZLnO4Y08w>
    <xmx:MtRZar_5diKGExksiyV1FA398pNEijgSEY3ll8QSkbol9l8w-BB2TKBr>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 03:05:21 -0400 (EDT)
Date: Fri, 17 Jul 2026 09:05:15 +0200
From: Greg KH <greg@kroah.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: stable@vger.kernel.org, linux-media@vger.kernel.org,
	laurent.pinchart@ideasonboard.com, hansg@kernel.org,
	mchehab@kernel.org, Jay Chooi <jay@robocurve.org>
Subject: Re: uvcvideo: deadlock when async control drops the last PM
 reference from the status-event path
Message-ID: <2026071726-gopher-onshore-61ca@gregkh>
References: <CAL+2LXtmekL+oc8e48uUXL_2SXvfCc_v7MrHJ6JDh9usRHu0sQ@mail.gmail.com>
 <CANiDSCukMqtarMGb3F0Nf3TfTB7TxHDeWu776StV+0q5q1VSVQ@mail.gmail.com>
 <CAL+2LXvV66O_qvbrHeFyHGjreyart277PgfKVK7jKfJ-MXihbw@mail.gmail.com>
 <CANiDSCttWrSLoftLWPtx7XxYaQ7PRV2+Y0tvir2qaE77PMG1-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCttWrSLoftLWPtx7XxYaQ7PRV2+Y0tvir2qaE77PMG1-w@mail.gmail.com>

On Fri, Jul 17, 2026 at 08:54:06AM +0200, Ricardo Ribalda wrote:
> Dear stable
> 
> Could you help landing  6d27f92c54ce28cfbd2a8a479a96d6f4a781b7d2 in
> the stable branches?

It's in the queue, still about 500 patches deep to get through.  That's
the "joy" of getting bug fixes into -rc1, and not earlier releases, they
get delayed due to everyone doing the same thing :(

thanks,

greg k-h
