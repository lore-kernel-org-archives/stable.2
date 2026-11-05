Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893148;
	b=OTicVKL4PrDHN0OeuQc0TxFoot3dJNpHQ3/eOUkK2sJ+OihKi/2HTrRU9+P1T3jZdVEZ
	 CcwJ3epdx/tplbJMIQyU/LCl3XmhYfvOegRxHm6vgaiVopbpRuZ/4Yo+w0LRio1DLaPQz
	 NAmOP7GdlUFFaNXVzdpqih006xgT9vgZ2VlW+1WZkQ3ZiVahhG47NjJFzB7tbCikCkGWy
	 2n51ajZqQL+SI7RNNAvE3KK7kBkrr8C5Cs8BVORI2/g2/8eSJOP40LjM3NVh4HSvNo13L
	 Fkz9n8jxnveDZ2OeyHdj80RPBVLWZ5SccCVZGzHv+KLLMRwY1w9cvmV3wlOnx/n09aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8JkfHiQEMtf0YYgXubzDg94vF7YvHDx8RH2S+gQfkvI=;
	b=0oc7vpOqhUIj54THCvCCGcL9OtkTGmgQiSowcPGhva42Ou9MAJEsRmFKh8l8ug26TnqE
	 B8RDHixruKca/jRtcZP6JAZY58l2iXfEsi0TdMJtuhg66fdsW/O7BU5p7n3vjwYMrClGg
	 8ZxGa4iTdsUGaB1m1bRn8LCJt3FlWHA0jqyAFfVNEOXkDQJCx+10GN8BXrULYmCuACzfo
	 3Mmbwap2Re1NSDogWMWODgBr7sF8MX+76IF5NHXW9VjTFIkH/LQQ2Vq1O7VwlM0DWdjo4
	 OZ78MrRSp2Iio5oW2jQYkj7u5HbdvaorFqX0xq3ElhVTpEO+P+a5SgkoQyyvTJwP2hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=VsxxJdLL;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EF606D808
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 419EF606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=VsxxJdLL
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e55db58cfso212372985a.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793893147; x=1794497947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8JkfHiQEMtf0YYgXubzDg94vF7YvHDx8RH2S+gQfkvI=;
        b=VsxxJdLLlfPOOtPonUHzniELq44+vkwx2NhzVYM+d/WiKtYn1rc2Dj9j860sK/BKYk
         vpoSTrlRbE1PuFq7yuccJcNQWfi3mzALQrIhPdBLpEJMBXoLnnMuwCq6vobOqzbGWQ5k
         hAIakt+aLJly0qKi/N4qCYMeUPnESlQTcefTHdav0DabkQpiBVclMiVRKw1mENC5bpXm
         HJcafXEvWzVgl8Rridpjy7bYk8xywjNJIjWqBD79E+fiCCRpg8lUQE+E1kOdznRdNqxK
         AsWa9Et5UIK66lV6BZ0MpPbkNGp9h3RzLJKoVMImgAstaLxHgCjJ/wbAh4b66Q9oG2x7
         MTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893147; x=1794497947;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8JkfHiQEMtf0YYgXubzDg94vF7YvHDx8RH2S+gQfkvI=;
        b=D4977WqU5BnkbD7Bc5OKFuZ1+bBRAwRn5hwbVr7Wp9i44VmmzPZilVRXeBdEAHSq5G
         cDeHcb8/JBGD/z/m7RnRuIeU0Q54csEevnyjUCDxpBZ10klGjfItf2RoR3eT7Suar7nO
         Y5GEOkc41QPum669fHLjj9jz/VFSZuPrqQglaKVurtOXXSwCdtuv/f07Ov82AiElCDja
         2OrVsMzKoz+XFipopCnChk/QfxK1o0hVRzXkQUb/Kbv+Q6o2ZseZPkVtCBvgbIo7xD0i
         DKW/4v2ZGscJ2OI82lKTGuIZC5Z/S/sIRnjOgn/mKk7u58RAjtGB9OiGNi4/5ETaH+Rg
         bvIA==
X-Forwarded-Encrypted: i=1; AKwUvBwrYE2GFzL15zhaNZHbqNi9+IxZKE+UlFPbTmtLYaTv3rYcE8JftGA64+annMVmBkcdXf8tGBU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VSaN/Q9eq5c57SdqN0Pri4qPPA42IM+ybofpyPfOz2lRKt563
	N4G4KAXuGMr0PBqTGyG1byUmNmGVAkIrmQ5rcrL0Lyt2wz/cKedgrMSlYBicCSWa0w==
X-Gm-Gg: AYBFou2WEVrR79i7evHOjovY5Cz0Wm40hXGPi1t/eh1aX707IHHlofAHqFvryvBnMjm
	faheFpPT8ttHz8uiYi0Zcga2Cr9zBqVIJZm2GImy4ZT8fqvMsSAku4bFhUicswuM15KPc8z9x9w
	WXh+nHvARduLbnXGKtm3VNspoG6GkVBPA1XthPPem4VNPpESKQk0O7TKberrDuHUOGD4IVqMVDA
	dk9IV8lAczu8qjychDBjyi1MLppOG01bk5jdqxUI/c2ODfK8Qv62uJ6oGavLiEqfJc9ERmBde3N
	1Z+H4evKG7bGK2KwhWmb8BWpO6HzMHJqiGsPW2LjtmGoKV8ywaAXUBYdf4FjksLDnBUhhRA/9Ue
	Fb3vDEFt9I//DQxyDnjkLIpmCGZdDmUaWccnD3DNAUZCkHND7uUIUUKw4CqXWF71bgTg6+yxJP0
	H1CgQbt5SSZvbxtNEcKScYy5WxpO/ol7/R5koawheS9k0SUeQvKamidlI7I+eeVCZ/8vGqvM+9a
	CtE3IuZPD2MKMRFBcBI+CXs1Ek5uBosmye7TJ5nqZslCs4WHzEyLK9VaL5Je4VUw9ESdvQFP0Fx
	FKhN7unuXPZPvYIxQdffOyhgysih
X-Received: by 2002:a05:620a:618e:b0:93c:6e1d:96b4 with SMTP id af79cd13be357-944217b4de9mr2981549885a.62.1793893147067;
        Thu, 05 Nov 2026 07:39:07 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d485a5fdsm488893285a.34.2026.11.05.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:39:06 -0800 (PST)
Date: Thu, 5 Nov 2026 10:39:03 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v5] usb: xhci: Fix use-after-free race in
 xhci_stop_device()
Message-ID: <a6a3adbc-bab2-4047-b417-5faff738f59e@rowland.harvard.edu>
References: <20261104000031.679944e7.michal.pecio@gmail.com>
 <20261104035637.3325-1-25031212351@stu.xidian.edu.cn>
 <b8ea2f8f-ff9e-4cc6-853b-114fe51173e6@rowland.harvard.edu>
 <20261104175949.71804650.michal.pecio@gmail.com>
 <d7448504-a63e-4f3a-a828-7656b1084105@rowland.harvard.edu>
 <20261105085238.337cb70c.michal.pecio@gmail.com>
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
In-Reply-To: <20261105085238.337cb70c.michal.pecio@gmail.com>

On Thu, Nov 05, 2026 at 08:52:38AM +0100, Michal Pecio wrote:
> > I suppose we could check that there are no errant URBs still in
> > progress just before putting the port into suspend, but is this
> > really necessary?
> 
> It's already being done, looks like those drivers aren't *actually*
> trusted very much. But there is the ep0 loophole.

Well, we can always add a check for ep0, just before the actual suspend.

Alan Stern
