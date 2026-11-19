Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092430;
	b=pSXhxxLvXsh/BLB0yWb9gYdKtFt2+4/SYASHFB4sv1Q9sPtVMCXAxDtSFBwisWTmu8bN
	 Z21LNMAoLULIHbmZhbysLCcB0y3FaZU0CtlN0ZJ9EorWPpcV9WKHj+/a+6C9kLfdeewc2
	 nXIiTJlyic3Le4NEUfl8GjWqo9puktRGt/ePd10/uREvdKPWh22nT/SfISHe7PF6oXhDt
	 68dWqOM+D3aJHdXx4jZ5sj9QgUND/3wT+M1Dx434NBiKaCddrKL/khH33tDaLnV4TzVjP
	 pIo6Q6DqG/azOUZcjYjS7TaftwFtqSt1j/ubbKElM4Rg+4i/eSTXxWZFvORMGO1+vNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aPwkHNTj6RUG01VnZHwQBe6NlajTzrd9yw53YuOCt9A=;
	b=WsYU0HZTnA04McFb+qro0uO/xn0MXbTEP3alGH1PpcgdiPG7o06kqUII5RlEIs1ofx9T
	 tTHTSBBBYSywTRnGEpHL8JTmw6jJ87RPNIk332BX/S1DAkWYca+8ApJpn/We5Z/XDlr1H
	 Ub+8Yw4QckRcDnkyE9/AHNbuP3+kB0fJlFFtsTfIHWfqV2rD/uQNW7H6LGR7X/uXrhcQu
	 wGcVE5d+DgR/BC0FR4oPjTuu3dJUa+Chms07lauZmITBjd9z6esriQiE4bBi0T6O8WY8l
	 mg8dtXNbsWsf9iGIZOkcLyzkOosFQeKZuBl9SONn9ot/HlXl41eowUK7LQY4ibYdaRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NvwwWLRD;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA5606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AEA5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NvwwWLRD
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so16350525e9.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795092428; x=1795697228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPwkHNTj6RUG01VnZHwQBe6NlajTzrd9yw53YuOCt9A=;
        b=NvwwWLRDp7Qs5UtSDGgAABsVFvqMBo2hh8Z/WQZno7bgQw9t1McyppSQDAAAFFJnHM
         zmpK0HLKciV1gu/5Te7mXBNOakuOo27N8NPeoLzbwket3yMFoHB9M499ittKYxkfaw8d
         vYxW8+yd6wbh326wMOE5DHUqiWsa+JxHiBfWUnfYovtExfQ+tdW239H2AOxZA+nTu5oW
         EDWHRmfUaT12N+2kFSPfneTa97maN2s9aA/PV8tpflWJ5Hii7ITem/+Kr9ketFFb8ee8
         91SpXmZ7lgHsQFTpNMeMKq5jYN7Ifk6JNc7v0mRIAei0JaNLmYMRM2b8eC+1ng9Xim62
         50vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092428; x=1795697228;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPwkHNTj6RUG01VnZHwQBe6NlajTzrd9yw53YuOCt9A=;
        b=Ab6b/oDpmJiDRmo2D2vUYDM1Wl3oC9hSz1b3jw650qQ33YynKbig66TX5l45DYxE2Y
         NzORQZznSNYOYU1iBSzHjaGJvwpEpcY2wNRn+xNO5UU7C4xSFPGdbHnopimPxAETefbW
         KZuHV4YSoPypCCAXDuSlDSgjmuxggCfrZoo91siq77n8FyMdRvBhdime2r6QQ0V0h9Ag
         HlhNJDDZzEfeYx3ilAiKfoTPQYUSbS0Zu8f/vcaBWI41f9L4eM0AZA+brt1f7t2fyIg7
         xZib+fwMmlMn4MmSGhLfJhweU2VUpfOLUZ5M/cJoN3NnVHmFbbABJIhGB2tPfffrhdVo
         eDAQ==
X-Forwarded-Encrypted: i=1; AL+hErFzeeVvaCS7haH1v5R4HRpPFQs2XVzyir4PnxiLdlDf5mDGYmyoKNPqq7JJUTvRHRgHiuffftc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s+5VWu/9Y4dsOVNdSbJMW7rLBvutbEP3LP5uayEtdxvvtemn8
	2BbUlV3iNfGxtt2yfG2vpewePicmNYOYlsuaAeV+4fzr8/pEDp/+x+sSmQrUwG6OqxU=
X-Gm-Gg: AYBFou1n8zD5jtTsoMm8szxS3qgqceuDoDW7//u1h7WOg0jnX6sYIjtcpSYPZcEM8Wf
	Rh7aBBFJm3HV3QzCiZJFPm1Sv3ixVhCcJUSJN35hGHEs5tPnQkWmWJR76Pi0xzUf9Vez0x1X1ti
	+LaLiPVOr4eSjcm4GF1BFTgWvWbyBRwzbuvWekqyBOuHi/yiFZ0ed77kmFsdhTCCAO4+XWAxap6
	PSzvesmoe8A0jFWCxOwk9tZVRfMG8xovVaaIIpcEgXwePR7g+4ucQixfFGYG34+MHqcQvbigApX
	fy3CaGgScaZjH7YdSo+4sNU+up4QGIdmo44stATOgh4A8/YGmo+c/82W+hTzQDtRRKl6WQeSz9d
	QVUxfP4B/YXT7OeCZnVLP2o4FrpUuP9H+xGBC3glrcXc06KrlmJVcwWSPW2ZcEevvEGvROSDkVy
	GCZO0ON5/VTP15eSP/0sU+klzPfAxFRloZ25pbHotFktlP+MUG+Fl9x56Uc/aNbY24dNLCR4wVw
	FNxUtlN3XOxdxKUPKXXiBtqOmWkS9fTo5o38SliU52dhQ+MYeal5aVMO8lHVWJem/ee+l4bvQxQ
	c/9WY8+prF+pmSVnBq8wjpesT3dqOrqTYV+ICRfHoJTSkBKQxbLxgq07t+PKH1xDNV3q
X-Received: by 2002:a05:600c:8b71:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb7da2c635mr107058465e9.21.1795092428543;
        Thu, 19 Nov 2026 04:47:08 -0800 (PST)
Received: from ?IPV6:2001:a61:13e6:9f01:eee3:1629:f0cc:42a? ([2001:a61:13e6:9f01:eee3:1629:f0cc:42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8535741esm54667975e9.11.2026.11.19.04.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 04:47:08 -0800 (PST)
Message-ID: <1817932e-469f-401b-bc04-37f30625c3ec@suse.com>
Date: Thu, 19 Nov 2026 13:47:07 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: cdc-acm: restore the line coding after a
 reset-resume
To: Piotr Kubik <piotr@kubik.pl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Francesco Lavra <francescolavra@interfree.it>, stable@vger.kernel.org
References: <20261119122842.3611681-1-piotr@kubik.pl>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261119122842.3611681-1-piotr@kubik.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19.11.26 13:28, Piotr Kubik wrote:
Hi,

thank you for this patch. However, it has an issue.
Let me comment on this inline.

   
> +	/*
> +	 * The device can lose its line coding, for example when it loses
> +	 * power during system suspend, and acm_tty_set_termios() sends the
> +	 * line coding only when it differs from acm->line. Send it once, for
> +	 * the control interface. In a runtime resume of the device, an autopm
> +	 * reference here would wait for this resume and never return.
> +	 */
> +	if (intf == acm->control)

This test is problematic. The interfaces may be resumed in any order.
You are setting a line coding before the rest of the device is
resumed.

To do this cleanly, you need to look at the counter.

	Regards
		Oliver

