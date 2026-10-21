Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792602514;
	b=AA0cL8lAZji/cmr/GxOXMnoDxESyRNjY4IVMOE6r4DnCWUIhFQ6jeNKulzBWuI67JnsL
	 p391kxuosyg6MzM4oA7yCMvkHln2pG47D3nEDRSApWDkcTRc0QCVeQ1X9eZ/o+flWeJAE
	 kExmi3IXUOTHvFMYpgxdX4o+YJqtb2l51gbt86IjKnu7KSQETZbYCE3nS/XUXPv7y1JV8
	 lGc9oD4OSZJBXKYkAbxmEEsL2dMq9kE6GU4+QnU1NMB5d02um6vaSlHFCbsjL3ghebpXB
	 E73XZey007pWhijUAknoHMIhgNUvCEbVygmzwyvU3LuTyv0lcJHTIeHkO5+xRB1pcTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fGCGePjfI8XXuGHsrc0ohceeeEG6k7P8lw+rhpyAdzM=;
	b=LxIxmwypF64qymJ/0skb2S2LqLYJLrFRzMDADUc8mrxLHLDWFrWXb6M2T4M9Zk/a9IXk
	 ZEJzRScMLRgui0f2UZADWxhWIV/e1hb4D3Sha728OSzlzkxuw2JqRbxh3yPr0QnRgTTSs
	 A/yOzleAYPZRf2zhAFAOqS3njad4MjvmQVEe5FGjYuXFh6K/FIUrVMF1drZiuRXZb1JoZ
	 FayzAc/qO3nLOLKqc8qr5Rhccp6D03miI6zhNVH3YK1UJ+cY5JWShZtCJXjsX6TnIvu1R
	 HeyHoxRG2zuysxZM1JaJIjjZpIqc464jxJ0yo335VTbA6AQzihm6u7kdplUH5hfWx5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zv9mNbCB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CF606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B1CF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zv9mNbCB
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab07d956f2so6291721fa.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792602512; cv=none;
        d=google.com; s=arc-20260327;
        b=pryvvautHLoJWtlmRh48LXuJUvUNazvQTZ/VyRUOUtsS+N/PF16QtZwtlu99Ls1JM7
         fCKFGT8KR9fqdqGu84jeAVtO3vUNPkId+QvfL1g7Bu8WbNWpf1iwbm/fFexYE2OBT+mf
         K/EeuB64nw2CddoRf1FD6LnQ1/RQLDomcqRSooUIv0KoEkBUuzoc0SZ25tCzwXZu3m2z
         DVYAtaYFzMOGqGjxUkKgbwBfLQYNrRXVJ5bpdurHQjpjmB+vVySn6j3SqkZmHzd0J+5/
         QfhPECza70pPwgrpzD4JxBI8hHAlcIylkIaBtDOstXvttJpv5lm5MiUTsQ1AAD0FYjQ4
         uZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fGCGePjfI8XXuGHsrc0ohceeeEG6k7P8lw+rhpyAdzM=;
        fh=EsRohECw0lgt/NqIPraNHL1kIwGxxWoIzWu/KvyOFcY=;
        b=GspVyi5qoWK9Ct1OldghDEoA+spS1KPrVJbz9c22QLLpM6uvo09bDhlGYZSSpg4avO
         uUgulDGwxMOlmKFuLoYCnn0ZeA4D0FWuWjqCv14BYDgXaJvga7zUjU/BUUy+kFOIU0Ii
         /PtAaIGt5StInWZnHQA6/0XVjKeC4YdWRtEFTjNBU819IkUAu62kA8JN8l42KmNkq05B
         7vXfPvA0A14pSTwiXRXNJUoheQdZneboQSxtNDRK1GfTYV5NoCDJutwBBP0VJLPXyWi5
         87KiwhH8sBuzSz164kg4xs1zsQM8G2+8h7EvwNMsJpqDWeJlaAIxuN+OthV7sKpo7rnF
         hwOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602512; x=1793207312; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGCGePjfI8XXuGHsrc0ohceeeEG6k7P8lw+rhpyAdzM=;
        b=Zv9mNbCBqDhn0djUp1ft6TyzbbWXWgYiBxpOGnriI2ekUCE+VtPTgnJI0nj5538Qty
         nWC+VbfES4c9ruBxf+x1AAJnm+GxvBw3P8GPFCbMMXwFxnhPH0BEoTCYg4oBdw0t+AUw
         o23nnSkwr0OpaxOpHrO7q7+6ElPDKIjw46lzhiJYoh07wmir4/IiHMjcYHGAzePGOJG1
         kUCnH8QPnexeoB3qxfm1A3ucseoXQ3M8oOQYh7ol2nxONOg/ajPzMyk/btIpNdDhJXup
         u1++3vUUJAGiqv/qQX9siWJtQ0cBrLyo4f2PjhX0mcDbsVZJFOeiD/H+f8RzvJ66C2DS
         SGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602512; x=1793207312;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fGCGePjfI8XXuGHsrc0ohceeeEG6k7P8lw+rhpyAdzM=;
        b=arqXeUvj+iu4QylNool0jtMJ4Eh5KF2fEpPwppVGYrbF2q0KHER9CoawK/R03fknzl
         Dx+kguudINSB16Ki50bsTqdZQ5J4gue2x3IiLELLFxoBn9/XWxEiQoiY6heAHv1KtR48
         iPhznL6zuifh5rTHjd4Olyo0Z/6fjJ+mIvlU/phWRGG5UH72X5ZtInRBjWAOmShknmel
         qJdNW6nfjoDuBZAPOPXrS3XAentNYsxYnV27NPX44Ls7wQ2GEmESrP1WhdAoe14e4p2m
         fEHkPtqHFFTXo2C8WVUbZkeyzWXTi9kIoWirMcGX9gaqXDvnnEQqjwkgF9YijQTXtvPY
         pZjQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0zaHzys9R8SRmRwx+3WcdjvS/0qR+XDUshZGTz3y5uD+3dhfpqh5M58phgOuVajcDdOGMmWM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/WdnciTVrbM+sZVnrk2xcuNuVGNv4y4m1PSpSX+QTaIq2OtQZ
	BY1ZMVlXIOrye4savlbaVput6jYVkOih7WPUQGpsAVH750ptArrRUwCIOhEZDB3mlMDbjmCYgiU
	AzfF6mbkP5fKhwGzq8Ac+HRSC5gU7EzI=
X-Gm-Gg: AYBFou3rbg3Mu3OE7/FW7u/vJqcT69f2H615TctHT67jkIBUta5dvpE1R9Fyl3rAGsK
	y5TfXEoLy9SRshMdoIv4ZcQUnVFsg3A9Fc1v5qiNTS35SsBuEEXcjeGyfPIlR407cCpiDWdzOZl
	iiYz8Sn+2TuGtwTLCXkrjNPGKQRKAihanC9xGKj6KbNUx+wnibaCz4JHbkEGfo8yXZ83yH4//Pu
	RdqINp+joEWBCjFnA5yQ0vH7IR7ifP/Zlp7DZsfe2f4KQLePgy5YHfxNjfYkuJKl6woSTl3TVFa
	tQqoLl/9GB4izXx8gDtiTZTLRCJWHPiPXFvb5IahtCGOiCKH1xPwpSShLBJ+JtGJ72AJidr+Fx7
	3U8V/b1h37niHIR+nqMP+X0tSTh8NZWS7dc3y
X-Received: by 2002:a2e:b8c7:0:b0:3a9:d9db:61b0 with SMTP id
 38308e7fff4ca-3ac441b9da4mr7661721fa.24.1792602512104; Wed, 21 Oct 2026
 10:08:32 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012042851.389128-1-oss.patchbox@gmail.com> <20261021071853.GF851443@liuwe-devbox-debian-v2.local>
In-Reply-To: <20261021071853.GF851443@liuwe-devbox-debian-v2.local>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Wed, 21 Oct 2026 13:08:19 -0400
X-Gm-Features: AclHuK_5n4DvXcr46txfd26PyChDfZ8Vzl1LcIm1g1VksjW8svHx4dm9Csz8zzw
Message-ID: <CAGG=RgAxjGkcMC9NjxqrCQmbgordQeZ9vqAFayuRo5q1sY9ZxA@mail.gmail.com>
Subject: Re: [PATCH v1] mshv: Don't free overlay pages after a failed unmap
To: Wei Liu <wei.liu@kernel.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Jinank Jain <jinankjain@linux.microsoft.com>, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 03:18, Wei Liu <wei.liu@kernel.org> wrote:
> I would like to get an error or a warning here, too. Can you send v2?

Thanks for the feedback.
I will add an error/warning log to hv_unmap_stats_page()
as well and submit v2 shortly.

Thanks,
Yuho
