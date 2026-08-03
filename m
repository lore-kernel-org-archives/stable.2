Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32B40BCC2;
	Mon,  3 Aug 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763151; cv=none; b=HzxwlX7Nbs7PX2n6120jNShcjp3h2M/8EvNx9vz6TztRSJ7qfdUcP98K0o+shfSt5MUf95Mds8V/THCuHKKrRFFCfjuXpRtwm+NAeS7qs7Bf8Tl7avC+UTQpq2NH9+QlQxb2cyLCfkUWQz1YM1SgXSmQRd7h4I2xYfeuFDEu+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763151; c=relaxed/simple;
	bh=yplk1HANaY+P8tiXLrt7CsXt822BnTyeJCcLd6Y1kqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmnyfYWVLCBamntL6BrfdXeJ6946FfRqJsZFU98SLvRW+YivdLi24AQecZVTgHZG+PyS33+XO3/TRkWRN43ZnOzNIEzTvdNFlihSISX6AQ48NjC3PzoIrhVvKcPSMRXuh0rES+mGOGmxwOqmgHVTpxyKoQ9pN32ELFTpqCyNCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ra1fdXIw; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ra1fdXIw"
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward502a.mail.yandex.net (postfix) with ESMTPS id C5C2F80D74;
	Mon, 03 Aug 2026 16:13:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id 5DjqVbre5eA0-gKowOiXl;
	Mon, 03 Aug 2026 16:13:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1785762787; bh=yplk1HANaY+P8tiXLrt7CsXt822BnTyeJCcLd6Y1kqM=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=ra1fdXIwkw7Y3T9RAhh7MKZtcCDlFOYrxWidZ7CxI9+eQQF4Z8gQONa5l3oSOy4Oj
	 Fijjhzjp7JLInU4equt/f4LJRafhFkGB0hgHEvadJjBDtdFD8kEr6RV2LA04CczF1x
	 5Fs2FBOKLGPyiOxFeSHxuyk83rG5C+b7xW7czDpI=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <f18f3752-f5b2-4e38-934c-9f6afbc60575@yandex.ru>
Date: Mon, 3 Aug 2026 16:13:05 +0300
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
 <ed1607b6-0ced-487a-a241-17f1efa27dfa@yandex.ru>
 <2026080307-glamour-reveal-a851@gregkh>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <2026080307-glamour-reveal-a851@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/26 3:25 PM, Greg Kroah-Hartman wrote:

> I'd like to drop all the "legacy" USB gadget code

Hm. Then I would like to ask you to mark this code with Obsolete:
in MAINTAINERS and wait for some grace period at least.

Dmitry
