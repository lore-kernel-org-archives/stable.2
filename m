Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C04369D64;
	Mon,  3 Aug 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753623; cv=none; b=KOdWSzrXEVeCVK/J03l+pZyJ9jSMq4k4uYY75MWko5LxUCmechkjzpNbfY/Xei2O792OkPiv3KqDCv/hwbJraFNWwXAJfk7oNy0Uqm3G5nAwaooIsm09rM2kdZ0oPsUsji82NlamRzUoQUe0JhmXeTRVfJ3x0A0ANbc7D591Ero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753623; c=relaxed/simple;
	bh=5oRj/55ncLCb/TwUPRPD1MEQPesw91PZnT8k8+D9JUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTs3a1Og5+HsekvxWMKof+uiG23cjKNbFkHODIFlk9TqneC6evGvVLPQHvDkD4rGpF1aeXlE7pKpqhsHzopbDoot+os1sZY1ze+T2+MKgbjzEu6YDlEYOKug/x4SBkhsli8pajj9AzvOscP14Z60oEvSDxleaHNoqSa3HdblWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=b+AUAqy9; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="b+AUAqy9"
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:b47:0:640:7767:0])
	by forward500b.mail.yandex.net (postfix) with ESMTPS id 5D907C1654;
	Mon, 03 Aug 2026 13:33:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp) with ESMTPSA id 8XgQqcmf4Gk0-IcNSENxe;
	Mon, 03 Aug 2026 13:33:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1785753191; bh=5oRj/55ncLCb/TwUPRPD1MEQPesw91PZnT8k8+D9JUg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=b+AUAqy9wAlUWyJkKaDnVYfscCvLPRQ8jo1WrHDEW0uWm6AG0ET7mCZ7bYG0vf7v7
	 A1mbdjrfKcach7KgE6EaJd7aRYdKu33sBWkyKnrvsADaFZqytILylpNyRB959wj1p4
	 u5xOVol/6Wj2b9SXJfRJ2d5D2BCeJIV/Dz/B0sZ4=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <ed1607b6-0ced-487a-a241-17f1efa27dfa@yandex.ru>
Date: Mon, 3 Aug 2026 13:33:08 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: fix device data management error in
 gadgetfs_bind()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-usb@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+6aa97991da41499aa852@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260803091258.85969-1-dmantipov@yandex.ru>
 <2026080336-roast-sudden-e02e@gregkh>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <2026080336-roast-sudden-e02e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/26 12:15 PM, Greg Kroah-Hartman wrote:

> What commit id does this fix?

IIUC this code is really ancient and 1da177e4c3f4 ("Linux-2.6.12-rc2")
looks the only match.

Dmitry
