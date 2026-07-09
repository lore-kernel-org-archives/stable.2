Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB642F7462
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604681; cv=none; b=ZMEYfXxzECxKVDq/5gzSCtvymP1VXznVu2mu/8rAfRFinHp5ejCVmePFdkeyDBuiXwO39sej40NfMzlmh6ursSo7rf8n9qctTT+bJA8F3/6zJnJOa/MHZnuTtmMQmirMfSgN2TdNXKlLKNy/ALfjGL2xgi1qOwGe6607UaNrPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604681; c=relaxed/simple;
	bh=+e3rLnCPnclexU/TGq7To9ayodC+7dNeuVtCBIYlwpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xech44cSPF4Qgs+7TkC6oZ4A5Z6LQmEmLpgdId6io4zJ0qcOkjJ7EWSM0pmj3vfLXWRXpzUxYBuu1/BQiswvH0iqqoANxVK35c7i9xswswRzFmFnbL2qkE05OPfPzks/rAyVvjo50iTJFTBFq1OhFPDvZZHAro3Xf+MTJJJUP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPpD5sMT; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPpD5sMT"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-497d3e4460aso1174991b6e.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783604678; x=1784209478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7dGLWuFqFGELNIvjyOuEZBSnAuzpWLyUsbUpEnwxx1M=;
        b=dPpD5sMT4Uhem8FljfUpzaVxwWwcyJx4IU2C0jYPgDcK0NUcmwvVC30xi7VQ/eBLzB
         +ijSx//CSzntCqJGmSON5MhvF1c7EipZsLfNKyCEBTir94UL1PS9cTlthw6wUE8VilqG
         Zo8jXjNDrRgFQcZV5CLZfVOHgpL0czm6iVChspTdlV2J3Toc/EK8LX446b3r+7uE00ed
         vcDEZ07bp+NHGUz9OjJqYJ/OUepiM8ygg0g25WnH/YA76ooWCvGseyEAlLW6ag5SZucQ
         usQHX1W0dIbUBceFeN+pqkYdPwnWMF7wME/IgNl8UXIBxzXB2gsc90DfU3KuyOlrY/ZL
         Z0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604678; x=1784209478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dGLWuFqFGELNIvjyOuEZBSnAuzpWLyUsbUpEnwxx1M=;
        b=W+UQnhSscwoC5N5gIhZOajqfEiZDrYkGLT6JX/XxtZBWlKAeACwFUMBBSTiFcb9CfT
         JWg/HvptDYaeT7+thECf+qx+YMnw8t+uMkpUus4hGwqh6DX5joche9Uwtuuf7R8lWsBR
         v7d8exm5/NFJZ4nkxO920A0FNx2THhfcAZKgau5R7XUgLYDbE7kuLMMK5Qx/7UDOHOXR
         GtESVAlx6LGTeCuImfuiD/FzM6Hccik8mU2Er3fdXRqDd/JMT0tE1/tyR93+BNZroElI
         362usnyZAEadCevT8E5W1fLB3FADUIJTAXjy3XMD/gsoNS2Bdr2rv6L9RIpygeXcVWuQ
         kHGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IXBrgV7LHMj7LntSY+fjF1wRDi0XwoHbSntWgxhKsRlmVvykfYEtmQckL8yltm2gmPR0kP6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeIRWPoNXKhNUoK8aVEiv2xxh4QSroSP6tPqGtO5M+RBTzIxDc
	IFp0C0/qqg6C8ONNs3hzJWVpEjO4wzBoanU6fepKNNCn58Ne2ix0Mv7g
X-Gm-Gg: AfdE7cmXrCxnydiKhBI8Df78fKfp/JqNmm7vyJgR8ITGWi1FsGLC5dIybpXJIzMymNn
	0ZZDz5zp6ahXv6g+c0sFQWR3MGT5yX+lG2s5nyC6X+P1+iDN14xjZrVtEIb1907Rk77mIjMfIiX
	EeLs93SRO/kmTN+DuBuGdhX2hAgrq5uIlltKCXl/24pEJKTK+PDeZxJBuRIFRib+KP+HofifrHc
	mX41dBPt3vXwLeN0YS+P53C6T3sRrje9kyRT3VlN3eeyGv3vbRXc5Jgfbm4yyJTGsguwVVb+Gqf
	dUpijrrekO3b5s8aeNswppqLLTFHLlM0AL3iOshYSmFpz14ZLH2DuqYUDXS0vhWSbBnTeW5xEks
	A/PmFLIcjatJ/ScOGonE9NxEd+Pt7+Z9LzQUoi0hbqWRT8IcNZyVMqAEK2PzPpaetprbD7wTnwL
	IiKEg4EveRzGqdR8Y=
X-Received: by 2002:a05:6808:4f0e:b0:495:ca1b:7865 with SMTP id 5614622812f47-4a34d9c8f64mr3213817b6e.11.1783604678277;
        Thu, 09 Jul 2026 06:44:38 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1adca6bedsm3836998b6e.8.2026.07.09.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:44:37 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:44:31 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, yangyingliang@huawei.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <ak-lvwzHUfuFcRRa@stanley.mountain>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
 <ak-T4SMxr4rw10jP@stanley.mountain>
 <20260709083606-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709083606-mutt-send-email-mst@kernel.org>

On Thu, Jul 09, 2026 at 08:36:32AM -0400, Michael S. Tsirkin wrote:
> 
> why make changes at all if no one can test. in fact, why have a driver
> then.

It would be interesting to see what proportion of kernel patches are
actually tested...  Testing the code is often impossible because you
need the hardware.

In drivers/staging probably very few patches are tested.  Every couple
years I look at the data from where the problems come from and it's
normally from complicated changes from the driver maintainer.  The
number of bugs introduced by checkpatch and static checker fixes is
really tiny.

It's about risk vs reward.  Fixing a security issue is a huge reward.
Cleaning up the code.  Fixing obvious leaks and static checker issues.
Those things are all valuable because they raise the standards and
they prevent copy and paste bugs.

I consider a few things:

1. Is it a security fix?  I recently fixed some memory corruption and
   broke a driver.  I tried to be careful, I wrote a long commit message
   describing my thinking, but I still messed up.  And that's okay
   because fixing security bugs is important.
2. Is the code new?  If it is then there are probably very few users,
   and the original developer is still around so it's pretty safe to
   change.
3. Is it an error path?  Code on error paths is hard to test in the
   best of times.  The risk is very low.
4. Is the change small and obvious?

On the other hand, I often leave known bugs.  In this case, we're talking
about a use after free if the driver fails to probe.  That's not a
security thing.  It's unlikely to ever affect anyone in real life.  The
fix affects the success path so it could easily cause the driver to stop
working.

regards,
dan carpenter
