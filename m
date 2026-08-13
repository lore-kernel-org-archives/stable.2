Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE033EC83E;
	Thu, 13 Aug 2026 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644105; cv=none; b=Zrkfr8zMa9vJGgOSV2Px6DkHFep2/JrtPP8IJ4fy0S0bASrw8X3/QNDsRPOMXI29vEeM56FeWZSJ+uuZUkQEQlpb1/QkUL33F6sKxLJnwgKebZn7/Vwvy7ZbFu1t0VWidEAvmsZeOnui7DhKQbKX16jyB7eng5epQK00VdgLTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644105; c=relaxed/simple;
	bh=ojk4+/q1LTqv50aTKLRsMmkEaK6Gnnm0VxMJIgPQBG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9Nh3O6qXki7tQg8WljX1G0lSmog5xf5Yj8F5xfe8yasfynRQ/FYU7+bYI9fwfcQF1OFcE34UR1SavmV2BCs/dKppIC3158q6j3BtQqYkSccToFo8avdIwZzFtiG7HkIfxPMnE5ejmu/0+V22AkD1fKBxhWkvspe/dWLUoy0NQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=cbMF3qQd; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="cbMF3qQd"
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1698:0:640:befc:0])
	by forward501b.mail.yandex.net (postfix) with ESMTPS id E629281FF5;
	Thu, 13 Aug 2026 21:01:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp) with ESMTPSA id P1VkbdWdFW20-nCm6xBzR;
	Thu, 13 Aug 2026 21:01:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1786644086; bh=/RNaqBZzAwLTxI7nXUB43pLNDhaKnBp2ZZo/rpJFmxY=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=cbMF3qQdkkyWCOrRG1ABhBro3ly5enDs9tLYWxJQy5jYIdXHl0NbyBfBXZTVN+q7C
	 OSkJUGuubHkvQI5JisQQVDBFTK/XkxLVoq8vEjjG1u2QUv78pyHT4gAp5FwY3YXMJ3
	 0pmpYF0n+e2gPKPZAY/LrjTHjzu7vr1KexH9a+cQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <bccf1ea4-b1a1-4606-9b6e-4d3e20277cf6@yandex.ru>
Date: Thu, 13 Aug 2026 21:01:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: gadget: udc: Fix use-after-free in
 gadget_match_driver
To: Jimmy Hu <hhhuuu@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625073705.803880-1-hhhuuu@google.com>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <20260625073705.803880-1-hhhuuu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/26 10:37 AM, Jimmy Hu wrote:

> The udc structure acts as the management structure for the gadget,
> but their lifecycles are decoupled. A race condition exists where
> usb_del_gadget() frees the udc memory (e.g., via mode-switch work)
> while gadget_match_driver() concurrently accesses the freed udc memory
> (e.g., via configfs), causing a Use-After-Free (UAF) that triggers a
> NULL pointer dereference when the freed memory is zeroed:
> 
> [39430.908615][ T1171] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [39430.911397][ T1171] pc : __pi_strcmp+0x20/0x140
> [39430.911441][ T1171] lr : gadget_match_driver+0x34/0x60
> ...
> [39430.911890][ T1171]  usb_gadget_register_driver_owner+0x50/0xf8
> [39430.911910][ T1171]  gadget_dev_desc_UDC_store+0xf4/0x140
> [39430.931308][ T1171]  configfs_write_iter+0xec/0x134
> 
> [39430.957058][ T1171] Workqueue: events_freezable __dwc3_set_mode
> [39430.957287][ T1171]  dwc3_gadget_exit+0x34/0x8c
> [39430.957304][ T1171]  __dwc3_set_mode+0xc0/0x664
> 
> Fix this by ensuring the udc structure remains allocated until the
> gadget is released. To achieve this, introduce a new
> usb_gadget_release() routine to the core. When the gadget is added,
> usb_add_gadget() stores the gadget's release routine in the udc
> structure and takes a reference to the udc. When the gadget is
> released, usb_gadget_release() drops the reference to the udc and
> then calls the gadget's release routine.

It seems that the same (or the very similar) race condition still exists,
see https://syzkaller.appspot.com/bug?extid=9cb1ac7fce4944ba9165.

And the following may make sense as well:

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 183a25f65ac8..944e46af8b96 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -405,6 +405,7 @@ static void gadget_info_attr_release(struct config_item *item)
         WARN_ON(!list_empty(&gi->string_list));
         WARN_ON(!list_empty(&gi->available_func));
         kfree(gi->composite.gadget_driver.function);
+       driver_unregister(&gi->composite.gadget_driver.driver);
         kfree(gi->composite.gadget_driver.driver.name);
         kfree(gi);
  }

Dmitry
