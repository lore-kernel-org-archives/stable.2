Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429396;
	b=WCju0YS3JW5aFR/MvugDI04fSCR8BPH4vI4It9kSLyEIiqqEEYqB4B04Q62iSqikCLAs
	 +2TRd9933AxHdRkGRy2gntQm/jCwlEAWNNaW8MHklynDl4D56xXhCmzHQMW0rOE+lx3ds
	 bln5xSOMpIkVRDCWqeQ/bmSApIFpvW7qNTLtZeQycsQhE0gmhdLmLQrI1OVnFyucy7aIO
	 R90wVkocU4n08gstCOfIgQKJVscAraBXTE5SykjV9EodfTmjDE8AMtj8avdmw+JzCviYO
	 jFKVKeFIQkJd7EKRR7nOHYyGRK0Jx3dgg2QOAsxqpyT+q+9pHcfJ7RzgK0y7YHsfmsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1MG7opruDk6HGbhLyOi9TXyXBCsTd7Khpfpd5KuFRfw=;
	b=uvAe5RxDbXVSrWKZCkt3UO8CQleE5/UTyguu8M70SZUS3SKuuVgkHA+D52fyvtK7aRPi
	 duJTTgi6iQ6zhf38GX4EZZ4Pxy/9q+6Bj5g1L206L2o+qo2QUZ+EhkMmy/NEiIA2pOMvp
	 Rs2HaK1KKra0i4x7mHfFM74YbHUYz+lsUDc6mpd5wLb3Tyin0l1kk1/HrKvY0VtkorOpO
	 tgYMXb4dLIruOS//YzuvFHcOxosqdIy++A8MYqKbA40ysSTKofE1uvWOyCgNEps+SCK81
	 fDcoxC/uz1+lpA0tIu70LdDexG5t6NHZITNnN70Ce1wrA1cf80b3pC7lCrUqBX1ecpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cmEDHLqa;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AAD606A33C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6AAD606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cmEDHLqa
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b467581b98so28423145e9.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795429394; x=1796034194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MG7opruDk6HGbhLyOi9TXyXBCsTd7Khpfpd5KuFRfw=;
        b=cmEDHLqaWYolsqsyPJ6jVl2HyBwR4eOy3PT+08higAX1YYgkcwC062OFRyuyIWXqkX
         t8lH6BuXt3w2QUgepijLAGLr4VkNVcdRKcFL1A0ioX6jMt16yzOcpke/ySd6nWemt2B2
         vO1e7FP9Y3XTcwhFuZaYbvJWBAqMaC3u7qPQYHaV0jRIVXlRLkP340VQm9zPrzQyoLA/
         NTq44exarTHa5EuwRjqhGckyQ1eYGd6V2q8AwlwGmvcUXsibUhH/mCLQS5vLox0CZk8X
         Eqn1SWUa3s8TDegfC2T1SUZ+8sHyMDWXqzgT6Uf6Gh8p5BA4dHMLQ9NjLfDyvardwwkY
         iuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429394; x=1796034194;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1MG7opruDk6HGbhLyOi9TXyXBCsTd7Khpfpd5KuFRfw=;
        b=PjRttROD/8lwv49GP9ED3UaZMX4X0ghVqTYa7oclnU4ReceZGQb1oQmBHGBn45Wakw
         c8OnMpO0Vq2XyavzurTEkdGnPEFlzajtSHxDhCfXTxeWkwKGo5TY8QqDUrTYlC1AJ4lb
         vPW2Ar8qKTlj/gZJ/y7ANcxHVTTVLY85bjpklRm7KmCTxvR9moc22+zC18PStbGxbenv
         VK0f3dHD70OA28RkhfuMESBYT+r8av43ETXx9N1g81ptLWOWIKp8pf7a14b8T1xnhr3L
         j2cfnslHhVFAvrgB9EITRycIJ+iVszkJTSgnhNCQbOWtsHFS2BjdbOSmqLAnmGZS7vnX
         ISHA==
X-Forwarded-Encrypted: i=1; AL+hErFq2claRzbMIoXHNODkMs58QqrXuehaeocHCkaRnqslSImPu3c0z7IufBAfKQmqZ4rxa6BO3PE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ihyYKsgzRq6xPG6zTAndtnqAFLxJ4IgABe5bACPTIWo6TZlTU
	CCfARnEQxBdBFk5Z/mWribNG5d3ts7WgGZIoDud9bF83m5S4F54kG3Zrym1gLsPX1bc=
X-Gm-Gg: AZFdTZcDxETbAvQTvnaeAUIDmT+4U0aOOlPJST1T7/arWjjbqKKw7sRIKToGRFn38zf
	SolyOMPn+UeCd+2gTj/A9SSWi3CZ6hk/yOlH0XxLQZp3NfD00eD6bEpVLfruXSuDFLV+GHHzt7r
	RkyvE1/dgKnQrl2UFS8qqwnv95Q5y/FwiLodROp2oemp02wdw7ZnP3ZhsvVo0PU4dFm1YcVPh/K
	S17IixVHRQT1Pu/QhOBM7k5/XLLfx1CxfBBWLgLYowybfb3P/6vu8H/FOtyKKYfhqm+xqzVgBe5
	yEduWuGGuvW3U6Z8B0hX8ZABtkS0xtAAnYcIq+VDEiSumM9kuXfVk9XIf/+f5swPB7zSJEtd6rZ
	OGPnBYAQwq9yfpmLsFdH5MPRpV7FmwA8YpUgRZnMfwoHlAE2IXFY25W2w4/NauRYicwd/lLl5H3
	phrwWox1lw9bN+UsKRq3fAYY7cG4f9o0HABGmUooXoY35FEsjnodXyo/T8relPixgRZik+uwgPb
	+83BBHSP0gb4CK9mQgCWbtUGRVX1Fj9QDIyPihpwotnYt/ykSgeZvtXzbMZZQOg+osvVUXQGVGc
	6BB6tI/wpL3EYUMil66p80Q4sWqE2lOmaHWmkaViQ8uEtNwb2j0HNjtGrwRPDkRVNKGQztq1A+v
	zue/H0W/UJlrCkAs9
X-Received: by 2002:a05:600c:674b:b0:4bb:6947:3e1d with SMTP id 5b1f17b1804b1-4bb8892c0fcmr212081605e9.20.1795429394227;
        Mon, 23 Nov 2026 02:23:14 -0800 (PST)
Received: from ?IPV6:2001:a61:131e:b901:6da9:459e:7c6c:e85e? ([2001:a61:131e:b901:6da9:459e:7c6c:e85e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b205443sm22138236f8f.39.2026.11.23.02.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 02:23:14 -0800 (PST)
Message-ID: <51674f53-673c-4115-af66-c0fae252fcd3@suse.com>
Date: Mon, 23 Nov 2026 11:23:12 +0100
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
Subject: Re: [PATCH v2] USB: cdc-acm: restore the line coding after a
 reset-resume
To: Piotr Kubik <piotr@kubik.pl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Francesco Lavra <francescolavra@interfree.it>, stable@vger.kernel.org
References: <20261120171809.1494779-1-piotr@kubik.pl>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261120171809.1494779-1-piotr@kubik.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.26 18:18, Piotr Kubik wrote:

>   /* devices aren't required to support these requests.
> @@ -1739,10 +1749,27 @@ static int acm_resume(struct usb_interface *intf)
>   static int acm_reset_resume(struct usb_interface *intf)
>   {
>   	struct acm *acm = usb_get_intfdata(intf);
> +	bool last;
>   
>   	if (tty_port_initialized(&acm->port))
>   		tty_port_tty_hangup(&acm->port, false);
>   
> +	spin_lock_irq(&acm->write_lock);
> +	last = acm->susp_count == 1;
> +	spin_unlock_irq(&acm->write_lock);
> +
> +	/*
> +	 * The device can lose its line coding, for example when it loses
> +	 * power during system suspend, and acm_tty_set_termios() sends the
> +	 * line coding only when it differs from acm->line. Send it from the
> +	 * last interface to resume, before acm_resume() restarts the URBs.
> +	 * In a runtime resume of the device, an autopm reference here would
> +	 * wait for this resume and never return.
> +	 */
> +	if (last)
> +		__acm_ctrl_msg(acm, USB_CDC_REQ_SET_LINE_CODING, 0,
> +			       &acm->line, sizeof(acm->line));

Thank you, I was a bit premature unfortunately. Could you use
the acm_set_line() macro, so that the driver stays consistent
in that regard?

	Regards
		Oliver

