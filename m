Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092693;
	b=v0WbtTYEtRt0Py7u6sPkNU0EUBCgXefx2mjTGb4p3HtGw1F55zR3TKYvQ7QjePr7mbFH
	 oJLlo/omWnwZW5OXkb5zorldJZV1zuHj+0pmYf0SlCai3soFMjbfHSyfisXOSsSfl/TBw
	 +Co2xdaoN9b0tJGV1PcMUtARL8hoVjRRQXeksNeaueYnzKdduw9m4hfSSiVEYI3ZDV3I1
	 KrYGDOtusoRgYFVTdpLF7JsZ8G7UZV5RH3+zWg/Y3xNghTCjLX/rwqNqDEC6EAX0nnJzA
	 srxbEM2eo2lfVEYaJ+Ch76dS8lGtgEolJvIkvhGzga19bjvel/akFZIzI/wNSRB5LmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lXs4zAc85AsFqIhTa+JCtj2Zz8CKIByhdaGIc/+HrUs=;
	b=d2+85SwfgdymLa3ctNyvghuVPUjXUY/rvDynwEhdE/bxvyoOh+TTKpFvt2HckrnXgE6x
	 Oz4+3oLfIa9GpG7x7tCbOulgSM79H4BGkRE6DMg79YpXCG3/5lqp4CDK3MFIeH/eW6R01
	 OafI2DGK72IZyFDuIuS+k/NUaflhvcOThY53h7duK2c6NhBvf5UrmhlITvNE6LegkX4wl
	 XBXgv0+jVSmxyedP+z9V70nC4TxeFBDABDe1useqzr/327pue0NcJrNkcOs3T2eHbYXKk
	 I0woRpOG0lzOjG4lMahs40prIji4k5QenvhiEmp6rFNJDM059QMcm++xhOHJFiGhtcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=adevBwaW;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF5606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5FF5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=adevBwaW
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1274514f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795092691; x=1795697491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXs4zAc85AsFqIhTa+JCtj2Zz8CKIByhdaGIc/+HrUs=;
        b=adevBwaWYBc0lOMo/wTlrM8Y4vJH0u7Vdsu84uznjSm7Ut2vuKc3HCVYo6New3sxh9
         OYnhctmUpUPLchaqXA1gyr50XmiQmSAWOiZ6YMcXEBbhgIrM0kUGY0MP8P4sHa6IXhG/
         AznG5112LyaYHnfbFSS+RP7XVxrreb8WDxKwLk6P99Avkhf6viudhzd75vx9rcVkHlDp
         QPVEnPWLmoHBX2XHReWdZmVT0usuhJ8JgK8qZmerpahdPd/et6dmO1nIDIjl82U41Kht
         aCsFArH8koHqAfKDsWAcalrxpo21wHTAhxqkgie+lxZfcD1ZP0hiNxfCtx5i+s0HOkmo
         TifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092691; x=1795697491;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXs4zAc85AsFqIhTa+JCtj2Zz8CKIByhdaGIc/+HrUs=;
        b=UwO1MNwKSB1ZdV1kntANOce8CdWUC1cb7lWw45plznesIwq2pVo9/Hh//xptrmj40+
         kqGLFRxDsBFN3JAgp89VjegKmWw1vPwYQ/hbNDVp1TCOTXJ+A2k+TxItDI0s4BfphlOS
         jpmt2PeDThUEAM4QDXluosGZSUESWYC8w408Zz9IAGoxyIKSEaIUeXlic680d46jYlmY
         KFfZ7ahgcXwDNi3kbS399NeOzoHwz9+uQ3UcN8tH65JIhbi71MeXKD+xd/ywUySwR5WQ
         7D9mADW182zcElzKN0wha2s3AAJgQEdEOmCuYz+ydfJYDfA1o+aPCKOMmcLhwHWFO6QA
         ONgw==
X-Forwarded-Encrypted: i=1; AL+hErEhlodqtdInA/8FgoOzHVG1XgWUbNHWraQz3UEAz9F11khNgUwsBuV6IGy9WSqYkNvL8DtXULc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rb4dCTwvgr5+0JZ7TIX4fOXnqhaPJJF/ZxqQ6PpQka9X2Algj
	V7Tl/dHU0dqiiI0+vgu5lyiTgfQReweFaVhn0dm+1ADdXhBnx/KWu0h1k2o3mx32IdA=
X-Gm-Gg: AZFdTZdYZ2AuR7ay7pFa1KOkhoVhsWUxjL1JjZndUg4seqIHnZ59Iuqyia9OmVNcl8N
	cvYQe0S9aN4K8pRDJ8UZmIwqyY17WSfz/SdV/fP38f9UtgKUUhy+/Y2SEqKzoQI6R7ksk9EoJXu
	sny74quIJiUf0Dq+/m1KvLstcKTNJ2VQRDs7gofBCMVpwyqIDvZs4L27Nrm3O1ZsaNxK5GQ4FHz
	mHu8GxBoan+i3n2/mmfZy/xpe6ff/h/3To0DRIHu4eDD2htptmn0QbYw0Y82YJ+2c30Q3cdTuwa
	xWIKdllK+aKpGW9NwNJZ5/APGSC99zbV3iY3omAu9kusAkd7I2ECSrE3qnoE7GFfYxa/dNfg63O
	bej/M9cf5go9keFv2mczCXtNJCWe9yGzw94tbKzj7jdfuwrvLpDsqwh0KSbZZ0DiyBZoShdrWLV
	HzlhAq3vZ5bsgf5hn3IIUvF/gUyhB50qZ24eSf0Sl1z/sXBzfolv4vEtjihKuy65T2nNyP64mEW
	ogzYW6BWBNDrpToe8Mq041lK7RPV+/APeTSUImPHvAupigrfCMVKgTBf+sjoTvEBTNokWUdUBn5
	DLuZjWNOaaXS66aQRvszd8/5/+2WshW4gZ1aqZS++hlMdmDcMzCgjiKxrtWsGCrMannW
X-Received: by 2002:a05:6000:2dc7:b0:4a7:518f:bea6 with SMTP id ffacd0b85a97d-4a7518fbfe3mr11572846f8f.28.1795092691185;
        Thu, 19 Nov 2026 04:51:31 -0800 (PST)
Received: from ?IPV6:2001:a61:13e6:9f01:eee3:1629:f0cc:42a? ([2001:a61:13e6:9f01:eee3:1629:f0cc:42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095e98sm9240494f8f.42.2026.11.19.04.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 04:51:30 -0800 (PST)
Message-ID: <e3956050-8b80-4270-998e-2e5ec70cbdf8@suse.com>
Date: Thu, 19 Nov 2026 13:51:29 +0100
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
Subject: Re: [PATCH] usb: image: microtek: don't receive REQUEST SENSE data
 into sense_buffer
To: Alexandre Becholey <alex@becholey.ch>, Oliver Neukum <oneukum@suse.com>
Cc: Oliver Neukum <oliver@neukum.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20261119084526.535901-1-alex@becholey.ch>
 <643a71e0-7347-47f3-8cad-ce31f76cb8af@suse.com>
 <AP57iwtzG1Kr6EB4hY7F0Hd-DaLhPZJzxoKNuvDpeiAKZvyxsddI1fl6kRKAc2Xg1ox0kL-KAdNYmZrRMEYN_mZRamfiV6nXjdcfDhJhGyY=@becholey.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <AP57iwtzG1Kr6EB4hY7F0Hd-DaLhPZJzxoKNuvDpeiAKZvyxsddI1fl6kRKAc2Xg1ox0kL-KAdNYmZrRMEYN_mZRamfiV6nXjdcfDhJhGyY=@becholey.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19.11.26 13:28, Alexandre Becholey wrote:
> On Thursday, November 19th, 2026 at 1:02 PM, Oliver Neukum <oneukum@suse.com> wrote:
> 
>> On 19.11.26 09:45, Alexandre Becholey wrote:
>>
>>> The special case is not needed: for the error handler's own REQUEST
>>> SENSE, scsi_eh_prep_cmnd() already points the data buffer at
>>> sense_buffer with at most SCSI_SENSE_BUFFERSIZE. Handle REQUEST SENSE
>>> like every other data-in command.
>> Hi,
>>
>> thank you for looking at this, but this fix seems to not take an
>> approach I can approve. Where sense_buffer is pointed to is
>> internal to the SCSI layer. We cannot use that in an LLD.
>>
>> If you think that LLDs should not use sense_buffer then the clean
>> solution is to remove it from struct scsi_cmnd.
>>
>> 	Regards
>> 		Oliver
>>
>> NACKED-BY: Oliver Neukum <oneukum@suse.com>
>>
> Hi Oliver,
> 
> Would you take a v2 that keeps receiving the REQUEST SENSE data into
> sense_buffer and only limits the transfer to SCSI_SENSE_BUFFERSIZE?

Hi,

sure that would be fine.

Yet, I am afraid I have to ask why you want to solve this issue
at the level of the LLD? This looks like a generic issue to me.
The size of sense_buffer is documented. I don't see how this
issue can be limited to microtek.

	Regards
		Oliver

