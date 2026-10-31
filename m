Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793449057;
	b=qAYGP9xwKRpe+MV7EJ/VLg6VX+g0i59CWvo1liJi2gE6HGdxmVO+WErj6DC0MAlqeC1h
	 aYNtugsjvJy2/+ZLsXuir6JRRjcdwhhSeRco00zgBEC0Z6+GgfZ5VvhvYyoBXQYyTF9kZ
	 i2AEzQ0sTnmLwm4DOcFWcQj+tVoKy5wRW9GKIlprGODIpnGo+q8VrTfKV8qTm+xQ/RWTN
	 7DQwRrMHBCFJlJyevdcqRlZQ23sb9W4jRTt8TVXOXdVFYdWUKcXw9eWe3VA+w3sMSKi2+
	 BOWjzi5canWa6g/LfThOmdTxTndeRKcGXHGndCVDDFHbhEval/JjffZQBNZfBMfBkTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793449057;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:Subject:
	 In-Reply-To:References;
	bh=DaFdbTzDElzVBBLXWgdEnO74GzOl9L3uSpC4rc309Jg=;
	b=kAZsm/j8vJzL/xSt8ajb3qdlIukeXBlaFyalvfnrWNp0J9B83/MXv9flpFDbUDEXQuN7
	 jT86Qslv9aBHarAyXFoqlPlJsDYUu6Go2qT4UHE7yVx8Ysz6oq/IgwGQ78uL8RLvNbmRi
	 xs90g4ur/iarw20tIWXt21y8XB3h8kcvDQu57T2YFy58Pf24zvOtM7YQ7RUYZdyab/qSU
	 216AgtqaRu/D6qcaow7QZVJGdXiyuMysgT5rqG9A7IWm2l+fFGSgRHpgLQwmP2H6AFoqT
	 +dKttKSfTj8L2C1PUQJhiUFZQUD4VgXifp3Wljzn70MOmLRkTz60+jMG1A27VIPg1Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=UMclV2BU;
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BAB606A31A;
	Sat, 31 Oct 2026 12:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88BAB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=UMclV2BU
Received: from email.seznam.cz
	by smtpc-mxb-64995d6b58-wb7nk
	(smtpc-mxb-64995d6b58-wb7nk [2a02:598:128:8a00::1000:929])
	id 5b8e32daedb49fc35e012892;
	Sat, 31 Oct 2026 13:17:16 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1793449036; bh=DaFdbTzDElzVBBLXWgdEnO74GzOl9L3uSpC4rc309Jg=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Subject;
	b=UMclV2BUw574PFpKBVOPEFNDDJ3RkA9OYsOiImT0kFKnnmuZiB4L/jSGX/hs0X3mo
	 ECSSFwu/yOEFkBNBd3sdUOeJ4gbjEtnnI75GQ8XJ9xUyZywZpTyX14zyUXfNezrsqq
	 GdRcub+RaTZ2ZnUBfUknIf5537fvyBs5x5zXJXeUvwQgwR3RWS7CO9oO4KaSIO6nFz
	 ubtEkrlQf/YDeG0xagwmVZqawF5rRyaxqT9x+sgnotTnq8siRFuu49sAJIz6ZuzNR6
	 Fa3WQ9FXk6DNJfgg5iec6tODxs0JY5Dq9VBPdMrP8DXe3jgN6ZqxYkiIqRD7MoYzDf
	 Y8FzyCKQFw2kw==
Received: from [192.168.31.81] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-7df688cd44-5698r (szn-email-smtpd/2.0.89) with ESMTPA
	id 64c474ca-2c92-4d19-bbb2-930bc8bb53bb;
	Sat, 31 Oct 2026 13:16:23 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Sat, 31 Oct 2026 13:16:21 +0100
Message-ID: <179344898191.3643659.6660410741163325277@podgorny.cz>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
    Marcel Holtmann <marcel@holtmann.org>,
    linux-bluetooth@vger.kernel.org,
    stable@vger.kernel.org,
    Sasha Levin <sashal@kernel.org>,
    Radek Podgorny <radek@podgorny.cz>
Subject: Re: 7.2.y took the on-air address fix without its companion
In-Reply-To: <2026103011-coeditor-debtless-2d94@gregkh>
References: <179097754519.501890.1801734138080126989@podgorny.cz>
 <2026100356-magnitude-esquire-89fc@gregkh>
 <179337661340.2790793.10493980332574129560@podgorny.cz>
 <2026103011-coeditor-debtless-2d94@gregkh>

On Fri, Oct 30, 2026 at 11:32:40PM +0100, Greg Kroah-Hartman wrote:
> I have no context here, sorry, what is wrong?  If that's a bugfix, why
> is it not cc: stable?

Sorry, my last mail was too short.

It fixes a regression in stable. I sent two patches as a series:

  3889a5fcd091 Bluetooth: forget a peer's RPA once it advertises its
               identity address
  4914c4998961 Bluetooth: put the peer's on-air address on air when we
               cannot resolve

The second depends on the first, but AUTOSEL took only the second into
7.2.8 (as a552b4bc058b). It also reached 7.3 ahead of the first.

So when a bonded peer turns privacy off and advertises its identity
address, the host keeps connecting to the old RPA, which the peer no
longer answers. That lasts until the adapter is powered off. 7.2.6
connected to the identity address and worked.

There is no cc: stable because I left the tags off on purpose. When I
posted the first patch, the kernel still hid the stale address, so the
patch fixed nothing live on its own. Taking the second patch alone
exposed the bug. In effect the first patch is:

  Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air when we cannot resolve")

Please queue 3889a5fcd091 for 7.3.y and 7.2.y. It cherry-picks cleanly
onto 7.3.1 and 7.2.14. 6.18 and older don't have 4914c4998961 and don't
need it. I have run the two patches together since September.

Thanks,
Radek
