Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36637386576
	for <stable@vger.kernel.org>; Sun, 31 May 2026 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229097; cv=none; b=WaYmrTejnZSfZXu1dk4nGzk3zHbT2hoIQBYxPKb0nKN2IXGwnU6zW07zAysd0nkv3SGHx2p5zP381vyi7sZbD/sEB51UYbmOB2G9okZsN0V4hJFR4CXhTJtB8Z8A/c3c6R7kvWMN2RLykOMdBfGtVBqoSypsiGXGQbzzVMxOjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229097; c=relaxed/simple;
	bh=NONLKoto7eRwTUPCeYEECkrzXOAMDm5bu+8PZe/7nls=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RTsvp3x8ZiKspU00vJmlmyUbrPLbuP9GHnOpbMFEsHcoTl5ez34p044mcIDxkMfIaUA8D5Uzclm98s3b4DtfGeVlwOdl0DzBw/9+neMqcshnBZVEgBqqWwkyNF5NqkRs9SYamAi+NbdSp6REaHb/Pe5aJ7qjSsr8tfmBqdS/NJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmp07aoD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmp07aoD"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9144163319fso1635552685a.2
        for <stable@vger.kernel.org>; Sun, 31 May 2026 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780229095; x=1780833895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPje15x//JjtJNNtyyJtV4KyOBwO7VPG1InhgHR/odw=;
        b=mmp07aoD1kXupIOPf3+fc+QkjJTcSr4MQ+c/pAJUqr1V8Hgm648DFqys/YLTOKZCHj
         I5lBb/VSinae/3QE9r/WzmwUSi63dkaq59MXm0gcWvjHYBfuiwrDHMmboVEXIyFTs80q
         h1K3m56CfXmC71mDj2+XZ4WIol0lNmNpLqB7xg9LgBvtgKre6SnL28bjdnkZKspZu1rM
         RrRi30iOhBY8Hxd5///EvGV+4mn0WcgywOhLWfpTjWuTl9qT6Yk+2HLsYqFOLnDDdxLB
         thoql1VTK3BwmywnqYNcgsp50O3TEz/7GamEao2LMkksvRA/OpAkJwcENKvzgif3kyWZ
         JE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780229095; x=1780833895;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPje15x//JjtJNNtyyJtV4KyOBwO7VPG1InhgHR/odw=;
        b=M8F8Kvf/moF2J2bu4Cl/5MEoo2OVhXFkv3/FXfx0PVznqDhP+U3d0AU5ov+cKG/AGl
         phbW/4Am11Q0kOPPnEWWXK3tbOJM2l9h41aBUsBRs+UVkS4Q/bNGQGPvYB7xVo/67g2r
         W0BlYuRhAH4AaQ3i8jYgIyKzuQmwGqkp3gNchLmrOZYQjbVhM0t+E9BDFOrs3GSZZHc5
         RMo/m9z0wDYWDc1K8WY0D0WWfAdUJ0U2YxZXqxlL65bS3lclwhmGJcLYHmdSa4EJC5nj
         X23ToZNs3SSb9iYy8zC0KXIJUptux0RFpOybXpo0aP99uT51X+JMtkSv3WzTKqIVQ+/T
         uHUg==
X-Forwarded-Encrypted: i=1; AFNElJ8JLMhx87Zw0q6/jWeYf3MWO0yhk3o2WGr+HIv+qHc4uAJ1npYOVJgPglCCeiWsHfJEDsttTnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5pNNIrhgfJruUTu+5jWq+8LpkOVyQz4JgF749VBNudXliimqK
	anikatk5Py2nb/E4sJHirx0l0rg/jqwJy7/EB1yUKVctmA/OfnWPiQM=
X-Gm-Gg: Acq92OF1LYEMOMbO+W3+LlJTEOIw0i6R9kwPt2+sZCS3lCFH2CrHHRZLRQSXCj+DmIb
	wf76h+SyJVXpr6lQWCKiJE1rEpRdwdTMZJrKpsDuzNzKNDw88CU+pBwMVDV9oZxTzLBoU7v3MYo
	OjCEyXcMZbEuBunvPqapf+o9dJxilgj5D6b+Bq0pB8+dJRbC4KvNXYklZ2Mh7TyOe/ew0AIjzbC
	Wk+iOEKOsgK2eI/GSvehMhFuEvgqkPbOEeSe3FvohgzFQTywFtttvhmodfdS1rTRmGew0D7ax1N
	dYHsvbu+L+HttUm5j6/m6/UBRXNsmQzg9tSlT8McZ74/GnptEgH3WKG1p8+ADf6uCmx4NeBJdLa
	g0HdHABva6gEB5HUX+xt+xeAOXA8ob7LOIk9QOchcvWp9VYdduIEAjgffOOj/WHMbZFKWbejFHy
	OPyw7lfyx182ENXbIsNSth3h2zUXkC5n+7UFAZldEGDqYvB5kTg1Vib/2bJI1cTaY4ynFA1EQo
X-Received: by 2002:a05:620a:2990:b0:915:4685:f9b1 with SMTP id af79cd13be357-9154685fc7fmr729735985a.9.1780229094997;
        Sun, 31 May 2026 05:04:54 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915326016c2sm723500485a.25.2026.05.31.05.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 05:04:54 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/589] 5.10.258-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260530160224.570625122@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <4a908311-9cdb-e8c1-2e6c-bd846cf475a5@gmail.com>
Date: Sun, 31 May 2026 08:05:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.258 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
>
Built OK on i386, installed on a 32-bit device, no issues noticed

Tested-by: Woody Suwalski <terraluna977@gmail.com>

