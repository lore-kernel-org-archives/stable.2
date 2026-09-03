Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A4374A1A;
	Thu,  3 Sep 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438522; cv=none; b=tXoPYcpnXxFKBChW6D1wm+T3Qu2Fy1fD6IZT8RZ9osw0hWM/a27PgJC0pXoN6eBqWJOUp6YDOybONLra9y6pakIGLDQF//bziadg0EuVezW7kK6mJhFPXNNL/ByFAMNYgv+ebXq7EMd2BUfynHPT4Yz4yOIl7aIHoW6N+KEIVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438522; c=relaxed/simple;
	bh=/0zMGqTUhBIF/NjG6lcR7sVz/bFVBB6Gqbthexjn7Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbrzQJHBgbs9Jqum/l2p7Kgody1W1Hs8u3au49W0AQO1lhjtxxaoUJ+gB70AVdZBfEllRw4QKrWfsOGifeQXpnnvdM7XW5cV9kC991UuNc03FuyrPNA+E/0NJlQdLvaPmYxK+kH4PrKdgRa6FlouLS9EQwTGf1SPSh1FJYX7Zpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=LA9ZSAmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBG18+q0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="LA9ZSAmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBG18+q0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A3A1EC001A;
	Thu,  3 Sep 2026 08:28:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 08:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788438519;
	 x=1788524919; bh=QWW0typ8ODLd5JsXCVVB3NFM6+RdMgBae3WRu5OCI4s=; b=
	LA9ZSAmmWLgELeAB9ANroCAIxMplLN4Rp77vWhswH3bxgXCFcrD+McnTZ/fAbLPr
	NTv8xNiDhIKxNssMms4U1qZvhAyiCtDjG+BuwiQlFlOjNmGRRuDAOXDIOTuZxXjo
	tNqzX0e2+/yhdubhp16crMsu8lMwuPeWnyF8XXTa68JsD98+OJX+uWBaYHAH7QJT
	jRgxYcotXoAqRZPW0Rrc15yFxtzCX64mkAncl7DCND7+71blgRpNVGM5EP6kwezk
	W3hZ9NeytF3ymXTvNVxTVhVMJ1Q1pLzP6TyM+KIAza0piD/kDFCI/PAZ0+R56ZR7
	+uK7bWc1khjWRzz0SSTOzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788438519; x=
	1788524919; bh=QWW0typ8ODLd5JsXCVVB3NFM6+RdMgBae3WRu5OCI4s=; b=f
	BG18+q0ieTcPzZnSFbH0BrOreox2z95gUeYo46suq2cKoretDgumxNibsk8yHpwI
	OeVijun/9JcH8bqfaVDAI+bwBDJMNLnMl9w7TKudePW3trDWrnrreQYi/6AUQjAq
	RXP0E+nuWFnGhe4Uz7BenJTaEj9iG+j7pUajw0pwR761SruVcPj5Mb4xSG+Bx958
	8ri8HDUQE6HW5MbWJTQubTCCXdeLsnC6qRanla0W9jfG3fnwvZ8eu7ST/VdzrZQd
	tmT7QihRhSBj0w26MkaD21+Yq5h20DUaWxylgt88wSHJm3njaJ2X++D3iD6pXpqd
	x2olEOpuxWisE9ElN2akQ==
X-ME-Sender: <xms:92eZascs4BZBMSv-ID2ILPst4blrXU_9UbcJi8mTGbwTrqJz7PtdyQ>
    <xme:92eZatTVio11AHHH5NiQQFe0qe_GYZ58yFb3m4-9NyhqY-WHgnE1D2_pgF3HVV8cb
    blpYa0p4XA2Ey-fcUFTf1zTGslKawBLI0mOb0Kr92vdHqMdAg>
X-ME-Received: <xmr:92eZajtBNovv5a6TT8qwKduno_3XCcHa7B8-rH6Kjk6Th3QrJwX_LJMwReL_rrwOEfhmkEu8yom3RIjrwSd1ZduYLrNOqhiCzLlZ2UizmPPjKsXr_HpFCENX>
X-ME-Proxy-Cause: dmFkZTFlsAYpnl69YsHaMHQye42HOsYZhwLZ2h0OOtL59vUp4XU847aaAllRPp/U5FFx0A
    Io2LpHNXsHYkwOmXDWsEBbBaS+z8leI1KMX4Hn6H/Fp02OC9ipAs+VERXUXUBB/bebULVW
    xoFIFI3f88ENUn9YDgksYmRWLQ0pfiQibEzpOveLlBafBQ5i274vtGKyEsQsCyBauNc8BD
    onmqpcuNPUHSIO/+7su719h1TChVWwQ/1siG/tzJhbZZ8fSfp6Pmp7psgxfmw+w1c7cJv/
    y70/2QjvT5STglJ3aaRqYE09IrV0I6oCbdj18dDbcoNt2K0FoLz2lEKnEl3HA6oJPMv3TC
    7T7Uvn8l6ITHDZNQHGlP7pAjSVjlin3MMQgd71ySTrf1EY3tUmIxGgYcz0QmQefYrTQPmH
    h+29wxWgj/sgMbrlOG9q+1f6um/F1/U1EydhxUOMClOQ4fHy5Q/T+OcBgsr+My//GKjj5g
    5c31IIAioNVrVwdffkCCGbvNCVDknj7ApQTCu8C1/9udWKrj5C1wkrAkWJqi/ltuvXyTgD
    a/QKo17Z9c8fTUiPTlI1boh1+6C74KdctbCzaTUNsAhE+bpwgwsa+XsIvg4tgNYZO5eTnf
    zWwUttxZWLGg6pZ55iSMZnG5lwFCtvb0YytR3bKcL1dhlRYFvfUidHakh0tg
X-ME-Proxy: <xmx:92eZauflAcbzV3RwQ91Xz_U6EmdzHSdmafvC6Y4De6Faf2ztXFX7_A>
    <xmx:92eZatb7jm4f1N_Wc-VWoxOp4VV_temRPqs8wVLTQsexx09xb-xUgw>
    <xmx:92eZagZ8IycP34iL4p-hoFpLoDFmbsJ52HxpX8kr70ZWbRX_lllhKw>
    <xmx:92eZaiKD1JdiI-MnM3r8HWvOvZA0eN8z5WdhYK6EmyfC7jolUatuWQ>
    <xmx:92eZanCOCoE6zWvDXExaVCY5da7xM6l7ClFbHsnQ2MGcj5VQMBKk1ly8>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 08:28:36 -0400 (EDT)
Message-ID: <29f823ee-9423-4d19-97bf-8fa951016bf9@themaw.net>
Date: Thu, 3 Sep 2026 20:28:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: autofs: fix memory leak in autofs_fill_super()
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: bodonnel@redhat.com, brauner@kernel.org, autofs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+df1db6e034b3953e19f5@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260903081048.132524-1-jeffinphilip14@gmail.com>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= xsFNBE6c/ycBEADdYbAI5BKjE+yw+dOE+xucCEYiGyRhOI9JiZLUBh+PDz8cDnNxcCspH44o
 E7oTH0XPn9f7Zh0TkXWA8G6BZVCNifG7mM9K8Ecp3NheQYCk488ucSV/dz6DJ8BqX4psd4TI
 gpcs2iDQlg5CmuXDhc5z1ztNubv8hElSlFX/4l/U18OfrdTbbcjF/fivBkzkVobtltiL+msN
 bDq5S0K2KOxRxuXGaDShvfbz6DnajoVLEkNgEnGpSLxQNlJXdQBTE509MA30Q2aGk6oqHBQv
 zxjVyOu+WLGPSj7hF8SdYOjizVKIARGJzDy8qT4v/TLdVqPa2d0rx7DFvBRzOqYQL13/Zvie
 kuGbj3XvFibVt2ecS87WCJ/nlQxCa0KjGy0eb3i4XObtcU23fnd0ieZsQs4uDhZgzYB8LNud
 WXx9/Q0qsWfvZw7hEdPdPRBmwRmt2O1fbfk5CQN1EtNgS372PbOjQHaIV6n+QQP2ELIa3X5Z
 RnyaXyzwaCt6ETUHTslEaR9nOG6N3sIohIwlIywGK6WQmRBPyz5X1oF2Ld9E0crlaZYFPMRH
 hQtFxdycIBpTlc59g7uIXzwRx65HJcyBflj72YoTzwchN6Wf2rKq9xmtkV2Eihwo8WH3XkL9
 cjVKjg8rKRmqIMSRCpqFBWJpT1FzecQ8EMV0fk18Q5MLj441yQARAQABzRtJYW4gS2VudCA8
 cmF2ZW5AdGhlbWF3Lm5ldD7CwXsEEwECACUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheA
 BQJOnjOcAhkBAAoJEOdnc4D1T9iphrYQALHK3J5rjzy4qPiLJ0EE9eJkyV1rqtzct5Ah9pu6
 LSkqxgQCfN3NmKOoj+TpbXGagg28qTGjkFvJSlpNY7zAj+fA11UVCxERgQBOJcPrbgaeYZua
 E4ST+w/inOdatNZRnNWGugqvez80QGuxFRQl1ttMaky7VxgwNTXcFNjClW3ifdD75gHlrU0V
 ZUULa1a0UVip0rNc7mFUKxhEUk+8NhowRZUk0nt1JUwezlyIYPysaN7ToVeYE4W0VgpWczmA
 tHtkRGIAgwL7DCNNJ6a+H50FEsyixmyr/pMuNswWbr3+d2MiJ1IYreZLhkGfNq9nG/+YK/0L
 Q2/OkIsz8bOrkYLTw8WwzfTz2RXV1N2NtsMKB/APMcuuodkSI5bzzgyu1cDrGLz43faFFmB9
 xAmKjibRLk6ChbmrZhuCYL0nn+RkL036jMLw5F1xiu2ltEgK2/gNJhm29iBhvScUKOqUnbPw
 DSMZ2NipMqj7Xy3hjw1CStEy3pCXp8/muaB8KRnf92VvjO79VEls29KuX6rz32bcBM4qxsVn
 cOqyghSE69H3q4SY7EbhdIfacUSEUV+m/pZK5gnJIl6n1Rh6u0MFXWttvu0j9JEl92Ayj8u8
 J/tYvFMpag3nTeC3I+arPSKpeWDX08oisrEp0Yw15r+6jbPjZNz7LvrYZ2fa3Am6KRn0zsFN
 BE6c/ycBEADZzcb88XlSiooYoEt3vuGkYoSkz7potX864MSNGekek1cwUrXeUdHUlw5zwPoC
 4H5JF7D8q7lYoelBYJ+Mf0vdLzJLbbEtN5+v+s2UEbkDlnUQS1yRo1LxyNhJiXsQVr7WVA/c
 8qcDWUYX7q/4Ckg77UO4l/eHCWNnHu7GkvKLVEgRjKPKroIEnjI0HMK3f6ABDReoc741RF5X
 X3qwmCgKZx0AkLjObXE3W769dtbNbWmW0lgFKe6dxlYrlZbq25Aubhcu2qTdQ/okx6uQ41+v
 QDxgYtocsT/CG1u0PpbtMeIm3mVQRXmjDFKjKAx9WOX/BHpk7VEtsNQUEp1lZo6hH7jeo5me
 CYFzgIbXdsMA9TjpzPpiWK9GetbD5KhnDId4ANMrWPNuGC/uPHDjtEJyf0cwknsRFLhL4/NJ
 KvqAuiXQ57x6qxrkuuinBQ3S9RR3JY7R7c3rqpWyaTuNNGPkIrRNyePky/ZTgTMA5of8Wioy
 z06XNhr6mG5xT+MHztKAQddV3xFy9f3Jrvtd6UvFbQPwG7Lv+/UztY5vPAzp7aJGz2pDbb0Q
 BC9u1mrHICB4awPlja/ljn+uuIb8Ow3jSy+Sx58VFEK7ctIOULdmnHXMFEihnOZO3NlNa6q+
 XZOK7J00Ne6y0IBAaNTM+xMF+JRc7Gx6bChES9vxMyMbXwARAQABwsFfBBgBAgAJBQJOnP8n
 AhsMAAoJEOdnc4D1T9iphf4QAJuR1jVyLLSkBDOPCa3ejvEqp4H5QUogl1ASkEboMiWcQJQd
 LaH6zHNySMnsN6g/UVhuviANBxtW2DFfANPiydox85CdH71gLkcOE1J7J6Fnxgjpc1Dq5kxh
 imBSqa2hlsKUt3MLXbjEYL5OTSV2RtNP04KwlGS/xMfNwQf2O2aJoC4mSs4OeZwsHJFVF8rK
 XDvL/NzMCnysWCwjVIDhHBBIOC3mecYtXrasv9nl77LgffyyaAAQZz7yZcvn8puj9jH9h+mr
 L02W+gd+Sh6Grvo5Kk4ngzfT/FtscVGv9zFWxfyoQHRyuhk0SOsoTNYN8XIWhosp9GViyDtE
 FXmrhiazz7XHc32u+o9+WugpTBZktYpORxLVwf9h1PY7CPDNX4EaIO64oyy9O3/huhOTOGha
 nVvqlYHyEYCFY7pIfaSNhgZs2aV0oP13XV6PGb5xir5ah+NW9gQk/obnvY5TAVtgTjAte5tZ
 +coCSBkOU1xMiW5Td7QwkNmtXKHyEF6dxCAMK1KHIqxrBaZO27PEDSHaIPHePi7y4KKq9C9U
 8k5V5dFA0mqH/st9Sw6tFbqPkqjvvMLETDPVxOzinpU2VBGhce4wufSIoVLOjQnbIo1FIqWg
 Dx24eHv235mnNuGHrG+EapIh7g/67K0uAzwp17eyUYlE5BMcwRlaHMuKTil6
In-Reply-To: <20260903081048.132524-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/26 16:10, Jeffin Philip wrote:
> In autofs_fill_super(), we create a new inode using
> autofs_new_ino(), however, if we fail to create root_inode,
> (that is, root_inode failure path), we return -ENOMEM without
> freeing the new inode(ino) that we created causing a memory leak.
> Fix this by adding autofs_free_ino() to free the inode we created
> in root_inode failure path before returning ENOMEM.
>
> Reported-by: syzbot+df1db6e034b3953e19f5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=df1db6e034b3953e19f5
> Fixes: 66917f85db60 ("autofs: add: new_inode check in autofs_fill_super()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> ---
>   fs/autofs/inode.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index c1e210cec436..6b15a3717ba7 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -323,8 +323,10 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
>   		return -ENOMEM;
>   
>   	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> -	if (!root_inode)
> +	if (!root_inode) {
> +		autofs_free_ino(ino);
>   		return -ENOMEM;
> +	}
>   
>   	root_inode->i_uid = ctx->uid;
>   	root_inode->i_gid = ctx->gid;


Thanks Jeffin, this looks better.


Signed-off-by: Ian Kent <raven@themaw.net>

Christian, can you take this one please, ;)

