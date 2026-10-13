Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC03B0AC6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879249; cv=none; b=Ho331j2HdUc8pYSxXTr8gNIoVCObDdeCNtaJlHHbIQlI5VyZtY+jaYjbYQQbsNQD7z77yYuQFzooVtrzaYVEWoteq0k052lEHxWtTQSZRl7KrqXJWba4eSqJfmb4lX8Nq/RiBcA1Qp/kcNOH4OQI4mACucDdb1D9yOj5gQIXxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879249; c=relaxed/simple;
	bh=WwRtsX+o3Yc1BZpZy6ImBzyNEsrrxZVX7aPBj0iBNNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB5rhZNXs1l5FNOdcKfV8f6HQV/xQBEeHiQ1noZZnh/OxByK1O85w5SYZDfAVta1XSORKBZp9FBgbFAQYHcJC7dcJN04Z0KM2eZqgyezeqCB34g5lfUlnRrLU7fIf09H998zT0+l9B3/LH5sQ231IROuz1aJSL22kn2BmlH+OUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ImBbR5sT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ImBbR5sT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso24209255e9.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791879245; x=1792484045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qE8viVfc7wSzykdGhKjE2C5YJHAozDefAUnUohB6XA4=;
        b=ImBbR5sTwRM4cizz08l5eBbwMoNWIKi8p3hYox+xpo2rKz4P7vWuh8n5yyCaJIOHP8
         pe5lPuhmVc7uSK759NRRnpRAiijkIjed8Au8i6P/kl1OnPsPfoXYQUfb8Fsn15f1q/na
         mvM48HMTWxn/WQnZMuYn3TTrpdQQy771sq0B+DNLZkrk/7mzs8c3rkWC46rikUigJOdl
         Vco9M+pNyRurGfmYqmztAZbxokRThCXdUnV3CS1f2pdVsLBSbwz7/xcXaAWihiGbEDyu
         3hAVJOGpgRtfnz3Is/3wuJG27d+/64Bgu/vSvIZX/PH+J29jgAsxKq+OUqrFSO1O9298
         7Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879245; x=1792484045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qE8viVfc7wSzykdGhKjE2C5YJHAozDefAUnUohB6XA4=;
        b=zFLy8kbNS+oGoXjJL+W9/h4t8Whpp/cbxYS0fcvHWdiwpH4Li18DkQStvbvU7yY6IA
         MlVBLFJuTAB9H9PZu0xmDV5v5QIdJ53OuG8yCczlQMIXS+mHuopxvhrvOF1krTHgxooB
         9/FaOtU0Yl2T8q/KruAIJqdn0H++mv/PkJiacsGNBle6CSpbVrqUHxysQD3Yfcarp6kL
         a6CilDydn/geTN8FZtL9WVzb9MwN4Gzr0gHnvSFHo19qS7RYxXY3eD+qEQeiNM2OzN7u
         n5b2kQbZdbqKF1xgWfaM0CyRQcw72NZ/NYfhEHqhdlgkHq4+Q4wgp1m2XUiWKk4Kglwp
         D+FA==
X-Forwarded-Encrypted: i=1; AKwUvBxwF/ljmwVAbbLMdwFgCtPmYUZsfm5wZURDFLRFBV1eJzAc63kyHn8IUd3q++T6joDI3qn4jRU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6I5IZ7nS2Ots8R8+wDck3qbAig+jyaqLtx/b8MgZst4AQ6GYE
	NqRS/F7QtJj5vGdU6NzNJB4hj8nwS0iPxHrJCdN3d/a1EA7TBy8uUZIkkfJWIQZXYZE=
X-Gm-Gg: AYBFou3+s+r4NxmNbr57GAx85RN1oVombxwfXfG7bcrVBRRh0RudtRtOD6ebfWFm4kW
	ggEkhVojnD1CP6eZLytYghXi32nScDr4x0FFSWwdXkCNLRTeARtJHihdaiWXlmkLgBVIvCEwIgk
	Yz/nZrz6sI6T1k8H4ipzUhnqSlgONlpjUoywvArVufklmj0qtMTqlrQXH6lTNPs+5vAS2l7MtKG
	8pX1Io9iXoFpsAOp1vDM4CgMBodOOigdEF4TqmyrrGVffS0blx4AXovAfnZPxFzqGZcpAhOmS54
	i2WPg3gK8Z55+iYEVuxltL80sToI6ZvMjfMv8aMW/kkvLyo9PxC5ppbGFINzKVV8h0nB99Z0Hnq
	Zdll6pCZ9PDd5VMldcFj8WTJYfyl2hbOjMJyUlrsnUmrglaN49Wby+Tsa1x47vaG4eg1zhu1nQE
	ojxDUVv4vBavhW/9XUiCYm92p5ArwmtHvwb83ZvIkJJnLjr2iguU5abOsBYG9hivD9iVm5uL8/+
	AXnrvhszasinXG1m1BAPIN1WEUKzDY96RFW3uCA
X-Received: by 2002:a05:600c:8106:b0:4a0:c02:938c with SMTP id 5b1f17b1804b1-4a18e4d683dmr203452395e9.25.1791879244612;
        Tue, 13 Oct 2026 01:14:04 -0700 (PDT)
Received: from ?IPV6:2001:a61:13f5:2701:b3a3:b9f5:f3dd:ee85? ([2001:a61:13f5:2701:b3a3:b9f5:f3dd:ee85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1972eaed8sm233812305e9.1.2026.10.13.01.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:14:03 -0700 (PDT)
Message-ID: <2207cca2-89e7-4694-b903-aca15cec1edd@suse.com>
Date: Tue, 13 Oct 2026 10:14:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [usb-storage] [PATCH v5 1/2] scsi: sd: mark disk dead on surprise
 host removal to avoid I/O hang
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>, Mike Christie <michael.christie@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "usb-storage@lists.one-eyed-alien.net"
 <usb-storage@lists.one-eyed-alien.net>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <TYUPR06MB6217DD31B1B3CD09E431CC12D2922@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <TYUPR06MB6217DD31B1B3CD09E431CC12D2922@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.10.26 13:29, '胡连勤' via USB Mass Storage on Linux wrote:
> index a1b21ea14e54..98f861fb7e80 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -4272,6 +4272,10 @@ static void sd_remove(struct scsi_device *sdp)
>   
>   	scsi_autopm_get_device(sdkp->device);

Here you resume the device

> +	/* Device is gone; avoid sync_filesystem() hang in del_gendisk(). */
> +	if (sdkp->device->host->surprise_removal)
> +		blk_mark_disk_dead(sdkp->disk);

Here you check whether it exists.

That seems a bit inverted. What is the point of resuming a device
that has gone away?

	Regards
		Oliver


