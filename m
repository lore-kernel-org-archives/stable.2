Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031956;
	b=1PDjuPN+ujmwlTYewFV64RX7QgpDyDlYh7RiAxNX4FYI+h/GDgcf6/CgJ1k2JkCiDJ7K
	 KHx59tYRKlyK6DpfoI+/muHydgPyLKY0b6RsCDG/KFW6cb2VoLXFbQw2oo2EdH0ljbeK0
	 v+xSjxJwTlqp0/YAVtTz11q0uxq/zNZyUpA4CyjaEDShESSJaxdaxnq1W+/nUY+KekAFp
	 O0wO45y+aKZU+bJyst9jBrcNIA4YrwvPlG1ATI+11bWdwq9otI01qYjKNCwrLeqtyE5Ow
	 9I28uFyYQsBgflxFAtICKQoFxjNNiUmDQ5paR9b8eeKpha9IA238mq8nPZooiCb7h8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EvNm36ee6QMlzT0gTHiv5nNg/UkjSVqUWtytJ7TE48o=;
	b=CEwJPSbe/Z/3GhtmCUzbbERoyWR8OAcPWQt+rl3pTfG0CXIR7luzuGt5USjpjyaL++AS
	 FwlabrrrAaBFbcnXKmgnysFW8S98yxgMK9nqZM9MRUWzJcw6suR+wfb2kV89ZdiM3Z5CZ
	 KSCgwTqCh8g9/4axFRhBabveGJEUdVdrAR2XtmYmkUZG5+RGkajrrPv14KB4+iZjE0jXw
	 BtFdfQoZF8Lepj3bxUvc+S62khqCtlxQ/eKwXtwljaFpsmQvhX2Bz6VuedgpCvLg8PbVF
	 ekqEHzJmXj/i1o+92tjSbb+xQDFrh5ebXpp2wGAR0D66Wb6Ki9X/EKDzXO9Gk8K8zAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YIkEaTpt;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E3606A337
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 929E3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YIkEaTpt
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so2486313c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031956; x=1795636756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvNm36ee6QMlzT0gTHiv5nNg/UkjSVqUWtytJ7TE48o=;
        b=YIkEaTpt/23/K5+TQfElnCS7kgWm71Vbi1ImwCIs1IFJFDkhPtL30VzXEUHDGhMy1Y
         eUBW2y1XoFqvUUslvLCEP6vVIC5BYJ3Dc5uiUo4E20cyFGTPvT6BGzk7W7S9cXHh0hY1
         gQ+Mlvk8tzfZELL5NmwimPM1cCD2RqpdYhj7jYlaaBD1TEyoDu9KWrsjbbnw2dxYRDBS
         lWfnzlk+GrGN7iKct00XaXa92OXqnw5JgyerOae7DUatHl+dM2dAtP7ulnOXyNfZAd4Z
         8uvQsjnc3QdYFzbsGNqLbfLYyPQvR3KHYiVOvFc3Ns1OztGKsOH2uGQDD/vADA5mRtu2
         2kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031956; x=1795636756;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EvNm36ee6QMlzT0gTHiv5nNg/UkjSVqUWtytJ7TE48o=;
        b=D7uYbrm96FQWoSEnpJgRfcyv1KghZkDK3e9npeUrBV417l1XsndQaq0tZCT3u5D0Kz
         Y3e4mZvXxMOvtcL0WbDuIn9XRJ8v/xRVM3nOS0NN1oQ9h+ZifOcPy5m7yVTi/TRKeHUI
         wzmdLKOg4COkfZzBmDkRKnTK92YfncawSKexo9F3aEviqLu11OmX9afLg5mTgmD83f5U
         C7C7phCuKfNJWYItj9t4zb010dIIn5enq/v7Y+SZwuAQty5xwXHyryvTC5NmDklCTlQL
         KP/Hu8fQ/6i+PIL0N06xMZ60WRm6WBksIyM6C4aY2qfqX5wn5TCNQnkP3RAweFUptKNd
         fbLQ==
X-Forwarded-Encrypted: i=1; AL+hErHcPBuBmazaMsYrpodzHH9mJxYw0K8j6P46lOLu8oMAyNtas+5f7jlg58AzOilWxdcn6fhfqT4=@vger.kernel.org
X-Gm-Message-State: APuU4Z95uCKeqZ7ZyXeENg7KFOMR82XnNHKuofC74n8XxB77LKUzmyIT
	561Fe0AqclhfrSV7hYd8dia97fwBHgV3zHOg9VvoSvUg2hyU6BzyiZzJJwsGTQ==
X-Gm-Gg: AZFdTZfkATUilYuW67y6YBCCkPpKtj7DZKQP5kr5HShfFo6VLSR5fXvvnZN5Zgv7m+M
	HVKzA3QcZ8brfIt/4GbCvXPZV4f0PqZkabFm/V0nBnyDcBItHsr87owZVlAbRY8xWZ1yiMGvtDO
	YFMs8tpF21xBMQoCKrk/6dpNCtz8eUZNvUUX/mB8OR9+MqiiiJqrC82ukDA6wnZVfRRVuLpInGB
	lFS4nOAJmE3tk+Ng5giLAGCUTwE1b4pixb9GGrfxJYSZUKnQKRZHn5lKPcS3hC8cnzSrX2Jsix7
	ckvo8OpRaRchUd/PVs5F1cPv/7evu0o+Nf+stu6qjc89G0jZ93YMmPuwIt8hWYfNWm5nziJmC26
	wTgAVetzM5NgLjFt0gWXZmww6inmYVuL3AsrXE/Hf/2aIRvyAJ6uxMKMn+nzHC6M0qhCqcHiTz0
	+y7t5MM+9lWJrvFN8rPK4GSol0QmS67uMILmtpzq4WoO9BtQ0uB02cIHguIa0oILvgAQhU+4Hyy
	YNdhueKU/zCbeT9KhacoCH5lhOv7+tXJ85GCv7qTMPmO1XDATSZHpAnVziMiERmJj39SBxwOSju
	mA++FJPGg4J/GtS5RvaurBQjBnpHhtRqK5A/Z5+78qKQEzvokDwxH0RLJEUOCyyH6whZ2w5SeXq
	iqQ==
X-Received: by 2002:a05:693c:885a:b0:376:37a2:87f3 with SMTP id 5a478bee46e88-3828161ae29mr3343574eec.31.1795031955504;
        Wed, 18 Nov 2026 11:59:15 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6800366sm9938909eec.12.2026.11.18.11.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 11:59:14 -0800 (PST)
Message-ID: <835e4c45-4b46-4d1b-a2d2-de1147666842@gmail.com>
Date: Wed, 18 Nov 2026 11:59:13 -0800
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
Subject: Re: [PATCH 7.3 0000/2651] 7.3.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261118150247.972732815@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261118150247.972732815@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 06:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2651 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

util/annotate-data.c: In function 'global_var__collect':
util/annotate-data.c:785:30: warning: implicit declaration of function 
'die_get_type_die'; did you mean 'die_get_typename'? 
[-Wimplicit-function-declaration]
   785 |                         if (!die_get_type_die(dwarf, 
pos->die_off, pos->die_tag,
       |                              ^~~~~~~~~~~~~~~~
       |                              die_get_typename
util/annotate-data.c:785:71: error: 'struct die_var_type' has no member 
named 'die_tag'
   785 |                         if (!die_get_type_die(dwarf, 
pos->die_off, pos->die_tag,
       | 
       ^~
util/annotate-data.c:786:50: error: 'struct die_var_type' has no member 
named 'from_alt'
   786 |                                               pos->from_alt, 
&type_die))
       |                                                  ^~
util/annotate-data.c:792:44: error: 'struct die_var_type' has no member 
named 'from_alt'
   792 |                                         pos->from_alt);
       |                                            ^~
util/annotate-data.c: In function 'get_global_var_type':
util/annotate-data.c:849:26: warning: implicit declaration of function 
'die_same_file' [-Wimplicit-function-declaration]
   849 |                         !die_same_file(cu_die, type_die));
       |                          ^~~~~~~~~~~~~
util/annotate-data.c: In function 'update_var_state':
util/annotate-data.c:905:42: error: 'struct die_var_type' has no member 
named 'die_tag'
   905 |                                       var->die_tag, 
var->from_alt, &mem_die))
       |                                          ^~
util/annotate-data.c:905:56: error: 'struct die_var_type' has no member 
named 'from_alt'
   905 |                                       var->die_tag, 
var->from_alt, &mem_die))
       |                                                        ^~

-- 
Florian
