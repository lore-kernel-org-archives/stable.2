Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7140F757;
	Mon,  3 Aug 2026 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762527; cv=none; b=C3VuMI6xlqpl9QUgm2Yhl3Wfhd8uX60Unbtdp9pzVCbUVvhquGib3gBA98SG6gWW8s3ieQtbiBQhKGhA9cIDL2dK39/6sgBpMSEv76NYE9YDMcud09yfWdeS3XsJ/usKLM9cYbDkuHORWib5DC1R+FmcZpIxDue/3kk6suhG72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762527; c=relaxed/simple;
	bh=wtZY2ezo0VnONKLHMMc4vyeRbPr2VY+XGb1Hui4wwQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+xef38xp0d9fj3/Q1eaFMYnVomRzyIHg+K2b4pm4DZL6xzvJr2sISPekq9mL2dIerNC4n5H+bP0b5x0BkKDgqtYQMOTVXBpRskTeofDXsrDjC8q4YFa2sEhddLqjfSjQUyVUFNSOftGS8MFmcBatoUXveRub2M6MaJohiQG9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Yo0Bt9JH; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Yo0Bt9JH"
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c16:161c:0:640:b95e:0])
	by forward500b.mail.yandex.net (postfix) with ESMTPS id CCD9DC0D69;
	Mon, 03 Aug 2026 16:08:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp) with ESMTPSA id c8jSjkngqeA0-0mjfm0rI;
	Mon, 03 Aug 2026 16:08:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1785762520; bh=wtZY2ezo0VnONKLHMMc4vyeRbPr2VY+XGb1Hui4wwQc=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Yo0Bt9JHk5eRERNT5kKU3shYMlFXokRXrvmXlOJoUAJYzEooiBUCAZE4vsxB1+TvV
	 Vj7YaLGHNti1LqxwD6ZhCwowV2wopAIRSQuHi/kzXt/PzJdhA4Mw+Co7/ZzASYVAw3
	 OHxfOHWh1TDJKm24vfIsL56u/j0I2m5Jv5ik8Nu4=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <49291e7f-031e-4478-9d5c-a399c0533881@yandex.ru>
Date: Mon, 3 Aug 2026 16:08:38 +0300
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
 <2026080337-ovary-grappling-8541@gregkh>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <2026080337-ovary-grappling-8541@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/26 3:24 PM, Greg Kroah-Hartman wrote:

> So this is not anything a normal user could ever hit, given the age?
> It's only something that fault-injection causes?

Not sure. Anyway it just looks like the regular -ENOMEM handling which
may be found almost anywhere else.

Dmitry
