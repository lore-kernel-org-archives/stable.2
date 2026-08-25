Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455213E6DE7
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647642; cv=none; b=SnIrJT4Wuh3Wex/GW05CAruQSh0vOS6ZIF2ssqt8vyjYA+Se4lYcp/7wLSWkN1niB/r9zdtt/WUZ6yHYHXeQhhB2tY61+CwjAg2vzX56wgQJdoCtOp9A3ScuBBMLv0IzkrwLOX9r70x79Iv2kDHW+8evEpD0fLTctUocWRxewm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647642; c=relaxed/simple;
	bh=jQmRjKS3+vMFIIdVez2XmwoympGUXadkF7Jjo3Uyo1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wt05tbhX0t04/O+M5ruZIs+dqkojhw2K/7yug9PZx8HzChkxrm4a0KG/+R+qLo1xC/n2rbtKQsn/wj1ggj7Nx/0dEcjWQLII634NmDgVH3uzzW/t+L86C9mSD8dQyblMZwTOM635Gkxq8izRGBHwHBZwoDuF1N958zEaO3zvQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5v0xQly; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkY4+IoZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5v0xQly";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkY4+IoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787647639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTpkfInV+KzHo/KAHdT9LTZrdvGy13iGVgmGM9DUQIA=;
	b=g5v0xQlyL7AYFPLXEAjLjdIpU03XtUhiiZMcqjsf45Z+5pF+HxN9Gyh0gfYSwMgTudl+ad
	QlcWvcalVHycF0rR6kH15CnNd+baQk/eG+bYh3FJcJkRMYXuo9Ew+Jy1AZeHThpbpCgCVa
	K+FjJcc/ABfWCemhNUKCjVgTQl5AREc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Z21jbfAZMDCQpLjvj2glWQ-1; Tue, 25 Aug 2026 04:47:17 -0400
X-MC-Unique: Z21jbfAZMDCQpLjvj2glWQ-1
X-Mimecast-MFC-AGG-ID: Z21jbfAZMDCQpLjvj2glWQ_1787647636
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a0fab609c4so605294a12.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787647636; x=1788252436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTpkfInV+KzHo/KAHdT9LTZrdvGy13iGVgmGM9DUQIA=;
        b=PkY4+IoZIOMR087l4ddJSXUPqUezsfy5X7fSnqezuvjnexUhXMuDn2SVgK2FVEzDDU
         tnp+Up5cXySCJ/ONp9LYICi/BnRrdxI3bu1cVBQwP5VRZFue/AdgE48YQd0WkgaQ+Oat
         mMqxkw+EvJKRal/MSZtUMU4IJKrjLhD/mqrg+K8Ji0C1g620w2QrD4zplte2I5k0/Cas
         lJYnwDFJFeJ/X7BQCEi1A3IxfH3TNt1P4zDlCm0ZQ6mhYwA1N0S0HrjKsbbQkAna/UAV
         WEUdmjbLMgP+v/3JmEelllZR4w6NsGK7bm7RupUY1sVKQW718fVfoBFQM1rzxYKGtK6y
         qGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647636; x=1788252436;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTpkfInV+KzHo/KAHdT9LTZrdvGy13iGVgmGM9DUQIA=;
        b=HR7zk2RQHTuU7FzXVx+09nXO5RHY5jN4Zb4wyOF+QEwMWjEm2+sznykqLWkZdznE2o
         PGw4b4KEBcig3DO/6fVf5qY0KbA0HfzJA1pE6qsvDCth8mmqxSrZaxImUG8SH+WoulA/
         4t88O1PhtkFQ3saAYBW4uem5a7/DhY/azZqGCIutp5t+tYa2/RS7ld6rOnI95+CdVPE6
         0tOmpYOj6Qkq5SV7Jh7cV+LMsNjS/BB3bLX3raNGW56+jL6TGccZH+0OpBBzaCl5eP4+
         H+mJNzKcF5trAxhbfp+8V/rTZCTbqVz4A08V2kIFwl5U+2W8ZPaT1ulzcyYp765q2WsD
         I+Jg==
X-Forwarded-Encrypted: i=1; AHgh+RojUKTpkMVSrRe6B5B5v/ifzLS+mO9Jvp4Wj0yQQ4ez7HzttDLGKNRtIDnCRUlQJM+S6KVMatc=@vger.kernel.org
X-Gm-Message-State: AFuF++no6rw9JUjFodGwnc/aJZZjk/2QOYKpZ1jN43H/+BlheIUiRgQQ
	gBgqttc7MIFREDUFcHP+7LjF/4CD6c7g685Lvxpxo14OjCxXJanaiYRLgF6t3Ng1VytIjtWQJAD
	LAqf2xH9AYC8KUDPk4xI/DD9E9wMQj6Ug+3AZSRXfqQNIwWCfNA5NBFJeDg==
X-Gm-Gg: AR+sD112H4gaBq+UX7TmtaM5JagSlKTMraUxGVdytFd8LA3tRCvppz+OCPLL6QVxrNR
	++/gpf/ZFNXwWm05PLDoztWNO9TcaFVAsOnEpHLQne3mgiRFRFpw8MMkze27z+NVH6yMilgAYNT
	J/vRFbepyjAv6JdsL3oRZiEMzZK271GVOjAuM+N4BVEEzuYNaRc8uJXvaSzpd6zRpGbSOh2GiFs
	Y/VMtIPzWxccsbZIQNFRNb1gf5qZ32ynw+kovrCUjuWkeCkqCkgWn245hKlC5gHuCu52HRYLlo8
	PtiD5UJyDfohHcJOGtaVeCXcI5MQvM7TKSTktf0S4dlX6jLjFwIIjcfi2XND4obFl9AY/sumd6z
	/A8Mv1cc8k4Z+eRbQnuG8GkWES4rxnbqf9vplSNqViWw/cDXOLq3WUzvip9B5/vMQMdJLjBDO
X-Received: by 2002:aa7:d60c:0:b0:6a1:f3b5:f7dc with SMTP id 4fb4d7f45d1cf-6a5c3e88bcbmr3787913a12.4.1787647635913;
        Tue, 25 Aug 2026 01:47:15 -0700 (PDT)
X-Received: by 2002:aa7:d60c:0:b0:6a1:f3b5:f7dc with SMTP id 4fb4d7f45d1cf-6a5c3e88bcbmr3787879a12.4.1787647635491;
        Tue, 25 Aug 2026 01:47:15 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2ddad2sm12297384a12.30.2026.08.25.01.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:47:14 -0700 (PDT)
Message-ID: <7aed7185-d48c-4013-9a85-a8b27cf7eae3@redhat.com>
Date: Tue, 25 Aug 2026 10:47:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix spurious TX timeout after dev_activate()
To: Nicolai Buchwitz <nb@tipi-net.de>, Breno Leitao <leitao@debian.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20260824-trans_start-v1-1-0419cc427ed9@debian.org>
 <4f3857029d855ed4e513ae01a2e8f018@tipi-net.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4f3857029d855ed4e513ae01a2e8f018@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 5:13 PM, Nicolai Buchwitz wrote:
>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>> index ef2b4bf515641..4539dc2c6d380 100644
>> --- a/net/sched/sch_generic.c
>> +++ b/net/sched/sch_generic.c
>> @@ -1278,7 +1278,7 @@ static void transition_one_qdisc(struct 
>> net_device *dev,
>>
>>  	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
>>  	if (need_watchdog_p) {
>> -		WRITE_ONCE(dev_queue->trans_start, 0);
>> +		WRITE_ONCE(dev_queue->trans_start, jiffies);
>>  		*need_watchdog_p = 1;
>>  	}
>>  }
> 
> Follow up or v2: netif_trans_update() in dev_activate() now seems 
> redundant?

IMHO should be a follow-up.

/P

