Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279633;
	b=eadOi+7BniGu4v278tvLRN4NCUcocGspxHzbuE9gElDQyFnXaL3hw+kgduUltqnh2aAA
	 qKp8Q5Dj/olshj95251QfatsKFA7nF7OMO77AF5vdTpUjdMn6P8jYgqrmoobkq79WB3sa
	 nog/CkNUPHnev+c7ZclEMquUM+tl9MfHHNf7GFeZs7PXZkGwY2q0gdZjwMicMrxp+HSte
	 phAks4feePIyFhXj5Yx4vNPXmcAo+oPWI4FG2UDtpQjBYVuNIo8kfPMJUdU9W8grmlwyd
	 jUQQJV93RovReJLJR/t87NJ04YWrAnDMrerJIGF2Jy8+O1o7Qip6Ym+Zezt2eC4rkzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4wBXUZ6FpdwTYkG0jag9ba1skQI+CQfpR4wutPYZULU=;
	b=yO0SlhRglqQDP7ZLJZgF2AxrIiP3KTySF2yXyQpbU1osXI9jNovrTRGNpXgKDkl0JJtz
	 aeYeCll0Hj5k8LKZqzpOl5vApc7ua/avs2w6Y513z4bJQNQ/nR/KHDoWOz9g4WKxt2Qd2
	 RPv5UqyDOzVC2WV04xPAPmG0+HQDBHyYtBN7IsB7pPxkhEHR+0kXgxJd2Poskdjf1R202
	 h9Xm94OPOEZMZo+BnOqwWShncpYdfVaa1UH66PbbXWi9b63xCfky4Y12jgL4skAZctMJD
	 JmUk3jgvmtcaNRuRfCaZEfIU8i4Zrb+RTy0bc14pmBSiOTQ6KcGsI7zjLzz5Ilzi2kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=pQmSb3gf;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40B606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E40B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=pQmSb3gf
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f1cf92c9eso151114385a.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 19:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794279632; x=1794884432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wBXUZ6FpdwTYkG0jag9ba1skQI+CQfpR4wutPYZULU=;
        b=pQmSb3gfLqpuEfsLBm1LR5zUz9XYLmKQzpAiD5nGQZQWa8EMFU7bkUSQtaCJmU+Pl8
         hUFh39i7QuRUOPA4YnZjm3jVwIGvrn12Tjruy8C/94/6dhkHViwJlNfAenaA2GDJN1HY
         5pABHMLSWRgX/3mAXR6HOrozb5CcQgK1VGmbClFLcWLtSg20aqNFbiE8gaOLy5F4UPn8
         FSOnDl5z8LlhZNPWePXLCXP20aPpPkYIEp6HPP5wBdT0v5EXOm7tTcA988JHZEPhgHeY
         ZRU2qe/k40k5cNRwyFipHNiVogP/rgC+sP01NEv5otoocKnfI2PNSnq2A8Z97QHAYjLq
         cQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279632; x=1794884432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wBXUZ6FpdwTYkG0jag9ba1skQI+CQfpR4wutPYZULU=;
        b=PRUZA0ayMI+NS49ZdyK2Es5bBharKuyzwGmE5XVBluvBi+amakM4MalVkxWjKLqOf1
         +3ztAhEcWv+X7LwfC8HdmjaXK2m2nHIBicpxP3yjaQwG7YvcGBBnXrapCd2GK6ENXV1k
         RLdjSvsnD+TR+NNZqPzmQegHzkWXoSNAVZcuI+LeB+/6eCFOxbNJusG9/28J4cDq1XC+
         Vw8+5by5pA6G+rwTNsOg0HdE2VRj3uqaVDV5iVdSO8RvX2m78tNWcZS+DUnGqIPGB3ot
         5MFUWV4ZY4evYZVi6punisfPjwcuaHexLVoNr77aunDUe75axMqCre6OeEqLqY5TwrRI
         Mqgw==
X-Forwarded-Encrypted: i=1; AL+hErEgWF/JJCMcaXucAajjSs22p4LcJriVJ2+s0L5kNvtlMEMXyCGqHYZKnngDfgosUowQntOHMuE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oc7Ig7K3wnbdwBOI0TxT9EehDS/m1DUsyZWS2PgIDIP+qBagR
	mTXLWwojiuFeQQnhnOPdW/6Bipv3lxR902z9NgKTHm8iKVNwZcXXO6mrGUXzwYYaaA==
X-Gm-Gg: AYBFou3jf9xyPA/PzNdee+HnivSh6Jznc5ol0G+ZABpCaCD1xM68Wy0y0+KOYTwx0RD
	Arfdud+XmtLr+J/+DQM49d2BQ3SSebutxfFK3XJO4+Jj1DEkBVIb0eY0MAZmEDWWLpQ1Yda57sb
	tNSYRKT+nZFiBWiRXzHp2iDwV+XRsnfc9i2w8QiXWyKbMHwoOFXFlaYEWHR2qPCG9y8U8Yo4SFD
	Z2WHXP9P3oDGtVLHNEL+cJvQlR1NWacFsbWRGDs3DlqNbsUYu7hxsleDzXnTqqh6Wv31AW3+0al
	9gYu8VkdqLM3zwOBTeeTRIq5mL5rVthJxC8CJvPb67+oliRMbNyzNh6aQ5Py9YASfxZZj2laQv3
	FK0KTrcfJo4pJh2KFDblwjxPBcaMsEVheJwcJY/svRnubNYOgq1SMjoYZg1EMLA0B1VV98XoyF9
	uRWYiGdJYgzfcpySLOVKqAGxZpezjn7XFUNqXcFK8TJHObvZvmf8FMbvhc6BTg/Kxnl5qEmNdR9
	5unOLUpZZ7eMnI+T4hgJph/zoV9VPToLH5cv8L/N0UiH9Q09E/CbXOCFpKQCtGn4zQd01jQtRhd
	C1uJibzt6nKznaMIT6YNQP68usuS
X-Received: by 2002:a05:620a:890a:b0:939:5cd5:e243 with SMTP id af79cd13be357-9479f1b9ef3mr232773385a.6.1794279631842;
        Mon, 09 Nov 2026 19:00:31 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7ae756sm121214985a.27.2026.11.09.19.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:00:29 -0800 (PST)
Date: Mon, 9 Nov 2026 22:00:27 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Pengfei Lv <lvpengfei20@huawei.com>, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, xuhaiyang5@hisilicon.com,
	xuetao09@huawei.com, caiyadong@huawei.com,
	suzhuangluan@hisilicon.com
Subject: Re: [PATCH v3] usb: core: hub: Re-guess ep0 maxpacket size after
 reset
Message-ID: <1df531f4-380d-4762-ae01-4554acef2c89@rowland.harvard.edu>
References: <20261106031625.1824732-1-lvpengfei20@huawei.com>
 <20261109093935.2634235-1-lvpengfei20@huawei.com>
 <3daf18d4-4936-4ed7-8846-b67f1664be13@rowland.harvard.edu>
 <20261109213437.5c693895.michal.pecio@gmail.com>
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
In-Reply-To: <20261109213437.5c693895.michal.pecio@gmail.com>

On Mon, Nov 09, 2026 at 09:34:37PM +0100, Michal Pecio wrote:
> On Mon, 9 Nov 2026 11:05:30 -0500, Alan Stern wrote:
> > Not here.  And not inside the retry loop -- ep0_reinit should be
> > called only once since the maxpacket value is changed only once.
> 
> Sashiko pointed out that xhci-hcd may not perform ep0_reinit() properly
> until address_device() or enable_device() is called.
> 
> So it's either this kludge, or dependency on an xhci-hcd patch which
> didn't exist until today:
> 
> https://lore.kernel.org/linux-usb/20261109112846.04bfeb0f.michal.pecio@gmail.com/

If you're asking my opinion, I say merge both patches.

Alan Stern
