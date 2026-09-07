Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76694503E3
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774650; cv=none; b=tdndWdz96AnRqqValVJ/1203WQpxywG6vlCxGeCB4knc7lv+yll8pJIylbI4tO686YdImV+pDQLmUc1JSn8XTzcpqZrVePSze+tA4uj/fDABZy7U3oywYkiP85xD1ncMaRnIMpraeuzMvwY2A7NJXM2zFF13Bg/yobQQhpQNHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774650; c=relaxed/simple;
	bh=q1vbWVYZfrrPPpMgx2AV24vWcv0xH2e65F7GQzJtG90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKHPzFzo3RZWTsYkRr3p/q1CzyXlNWJeWLOeRSy6aTzGc/PTyx4qy0P+sjCy7tG2vCVOZPQolEMjG7HGekbQy9yt2+91uG3Zky+vWbBBJv1RRry4/aTOjubu2rBjISBDt6IpvrzO9d8PK2EcxakE0rmtDTPnJ/F2OGgexPGkx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M5ZCkBe0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M5ZCkBe0"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f96c5b722so2280128f8f.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788774643; x=1789379443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lb18HKgR/gRWdLmmzTs+5hKvWsiCHq7F1zLseYYFjf8=;
        b=M5ZCkBe0qY4Z0O/QQzvNMUKVIXcH6wv0+nvIeiAKOFKc/QGURoG9U1KFDc8NXZkbgG
         iqwN6IG+U8C54EMszpWtvZLkCiukA1HJ60+EwKslM5Lo3F/wZokyDpAqy9AFLdombz0l
         dRYIVfVf+hygi1SUnck4u50HlCx2xrhmgQcBnYu40ZkF8ZTBx5qB0b3mv+nqmqOZ5UlR
         nLFTdezqgzh/heqYTsekxmw7Zuh7YpU3dXYrgoXEPKvSeMOxE7dRWopWdTjYF8cTID16
         9W+KDPPNdEdSrUg8aqX/Qav733VUyd5Om2Ts7kAM0vWX2kRggesZWvSzhXYwyU6OpzMM
         wjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774643; x=1789379443;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lb18HKgR/gRWdLmmzTs+5hKvWsiCHq7F1zLseYYFjf8=;
        b=MewfgJvWs7njZWrRzBMg3PJFgQrfAyZP+MiXsNMUQUojQ96FoD/L9RGxgKg9PsGJxr
         fklVa+gPMiyaVq9DYU1bv7Frp4J1G9C/21+64UlspFj0hZsyNsxy/NOy6C+m5y39iCDn
         nOclubaMMbBzhZw1WjbZmqNjFU5ttKAj/69Zm7MWyFlbe4aXnbhQ9/MW4I12aFbH/ByB
         ibT9z9r3UjhtHBVX+AYRWL9mJNs+YqkJZQLqpiTOqJBbraRSDY3Egs/pGTtXIZdHL+L1
         jAucIK3cVT3CJqhxuyrVJYBcEpDjwh930y6HZUXcX5dyvR2KJaiitHW62M0fDQ6AQP1z
         LZaA==
X-Forwarded-Encrypted: i=1; AKwUvBwZ0jxBReiM3DB1rYVz4qL5BbWjTatBNVLwdaD1FNsf2nteBMtT+N2ATKw7VZ6yZkz3mz35rkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k9kysyzVPXG/2UPlzu5cO/RtygBW2p3SREPEwYVmgR+AJbHk9L
	TktHCiWt7WTHMNxZjnY0HOXvv4snHbmZa8/IZOa1E41USlgdsRB4ZAeSZHKbHq/M000=
X-Gm-Gg: AYBFou0lvcLDMYbFU+nn8OsIOukJLOOTJZg+Tgj9It9T7k64+UGPcOackcY0HJZG8tE
	O7TekJY3XwSpHWwGkWZzeOCm/lWKagbVCOazTUFaJqxo/5yuSI6qIF6t0axsQfaDgrYCWjKwJ4i
	OEaUz7d9oXCniN/czW4lXbF12rABkDOEcqzu+mF30nxvt8u0VmaPMKFHCKHwC3LuYtLVrgQtUym
	C3L0f1EyDpq9s4b3f7xSPbXLp7QlqCDbvE9a/ctwSz4HvQtZk6BqW0SqlIhhH/97IVQqZK5PY55
	1dX4WAGdbun9TY6lT254dlcbSDbVRrucBVa35Knz4svGOaU8QUaYvPC5/L9W75uClnuCFUjBp1S
	16CD8kWAm/QD8IEfMVBiAAHw0MHS4Se0+R7o5FnNBpKMrMRzWLnNsq5XiCIjD3AsHlDeIjWKUA4
	aQkk0ieuA6SqiX3ufxuZR0qbD3WPrhA0R8owiDpXRDccUPfMXQOMy5goliQ8wyqOtxceVoZyBxo
	G5di5OlvuY6RyRsg8W6CNA+A70=
X-Received: by 2002:a05:6000:470a:b0:47f:4919:d5b2 with SMTP id ffacd0b85a97d-4858707f262mr23189860f8f.1.1788774642756;
        Mon, 07 Sep 2026 02:50:42 -0700 (PDT)
Received: from ?IPV6:2001:a61:1340:dc01:654b:3cf0:59cd:498? ([2001:a61:1340:dc01:654b:3cf0:59cd:498])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm20770188f8f.5.2026.09.07.02.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 02:50:42 -0700 (PDT)
Message-ID: <72615ee3-46eb-4639-a408-ba29c1235d08@suse.com>
Date: Mon, 7 Sep 2026 11:50:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
To: Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260907065501.101013-1-johan@kernel.org>
 <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>
 <ap56NTVMq8GlbjmR@hovoldconsulting.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ap56NTVMq8GlbjmR@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07.09.26 10:47, Johan Hovold wrote:
> On Mon, Sep 07, 2026 at 10:17:38AM +0200, Oliver Neukum wrote:
>> On 07.09.26 08:55, Johan Hovold wrote:
>>> The wakeup condition needs to be checked after adding the task to the
>>> waitqueue and updating the task state to avoid missing a racing modem
>>> status update or disconnect.
>>
>> I am sorry, but in this case I have to ask:
>> Isn't TIOCMIWAIT inherently racy against the hardware?
> 
> What do you mean?

The interface does not state from or to which state it changed.
Now you could say that it is implicitly the last time TIOCMGET
was called, but that is

1. not clearly stated
2. not enforceable
  
> Looking at the implementation again now, it seems further changes are
> needed to fix the implementation, though. The completion handler should
> not be updating old_count. That's for each TIOCMIWAIT to do.

I am sorry to be obnoxious about that, but I am afraid that would
break TIOCGICOUNT

	Regards
		Oliver

