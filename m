Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3E23ABB9
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524502; cv=none; b=AGiF5hzRLIXhC/aClIlZD9rFzRwx6sbrCKfY/+tSrFhL3OKPC2vI5EaKGiyxJsvKtiSZRWCfDOyD164qPcEqzz0A1s/0agIi+JmKpp0IJni1mR4cAXgNfdqlM9ix5Y/51+DfpxPEDvnxyw12HAb67E4i6PGtdItMH+uFuA69Rik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524502; c=relaxed/simple;
	bh=YYWgt/bB4PiazSmR6vTdL/25b6fyXQrWu890b/GyQcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9q0XHCHhVHvSDj2BuwgFtHmlV9ZkGPWCmIzaMXJVNdM8yRBV2aVJApkOd9rAp4kQYhFEapMLmDPyaHktayiXQ1/IWJmVSsCxvBoZtYKw7ycOJWr4/8gujf0PiEhgFP3FBDDv5uuYhwcHhaAqK4HtDPJBidkMYV2TG7OEVc9ejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jTNV0LJT; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jTNV0LJT"
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 56CA43FBF4
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786524491;
	bh=TeD6NjxH35EM4mHzexqu0xczYJ+/szbvzgeJOvh5dRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=jTNV0LJT6me1ezcWJXQU0Jllex+L48amYsQB4j+ygNvkmlq7byraBbn+xBwtDROpA
	 lM9nPw1Rd8uKxO0VYr/EK1oJovHX5IFQ8PQwPWvXJAUiKsLa9DqI7rKnrbdkMXFAaK
	 xk3x0vvEbeVpP6dUyxB3zrcDXUGxJQPtx3OdzUap0d6BXt2EjcnNHaoIbvnrT6xd70
	 hYEDAUL7BxVlmVCZAa5HJqGxxGU4ysJjYwkLQzX3B3Ni/eIXd0ZfXV8iXN2keJ8W2J
	 Y4iEt1BYeaP3TnfLko6Ftj6Es6WI9LYCuQXnuziqwSf5mb0H0sqQXn3NuV94nblO9q
	 1W0/baRTduDVOFxZC1N2mdgFD0lQcdnnw4mduhWqG8oEwElgm2/kuEMDbwdfddLBlh
	 68g9K7F3cNSwF1cTurMo8uvsG67IP6VS2PdEDnM9e3rW0fw1/U1uYMs2xaCJtg2O72
	 l41lyBL1M8fAaGp6DLzFKBtLAiDvjlpxbfG8idYqzBLw4e87foV0pqhq+4sCKqMwhl
	 /dIQEjDZm4pI72g2RqHDdA3kKoQC2apx05KSFXJVS/8h5QF2nlSVQjCrpsiHtZYwBr
	 tsjSGf2mwLCvfRpT+f9mzodWhRV9BNy1NeTOk7Kj7GGEYKGZcJ0fk1RhX2rqxjI82X
	 kVhWjhlA++ZO99cM5YoqOw1M=
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84885a4fcabso819622b3a.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524490; x=1787129290;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TeD6NjxH35EM4mHzexqu0xczYJ+/szbvzgeJOvh5dRQ=;
        b=fzWRrVW5je5VwQu8Ye0ObbWnRFnAOFvVJ2Xd6HNYUqQhjaB0SPuYeWagqjLOXsq7dM
         rA/WrCZLmSGUgZqHBMdqh6syXs+zvYoa1khItY9PAk2EFmAw74PtMuuYsGhGrrtrbNSQ
         ay+XVCtXzTnMyeCxGWzNtpFken0MEwjX2d9LdYBScR9dRXe1lRMEqJwlc/oTnzb1gE2N
         Stcpwb0j81RyAXAkGY1VozEgYxkOG5sWSH+zL/OZ8jHESErL8L9GLo4C5V3oAUgVlGms
         AAuI5fI22dU9Lpuvz+8R2hY9d2kZ+sCly5OgOrM7LX5PJ4X4JBxMVC8ZaaIyqZDZIQNb
         Sqww==
X-Forwarded-Encrypted: i=1; AHgh+RrIQ5UqiiToDZzTH8tmxYqC/zmGCVL4tUst6LeVbyLeLmuMNqyKBCxE2o5Ufxn8BTEs29J4b4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLwB3OclTkc+IcBaurYexI3Otv27AaOjKoXh9npT75fct/fHp
	i9d3T9BE66WFnHpBwSnyNvjIdTlSNfL7D9I12q6rLEfsNlQVvJRLiKuz3TpYh0yN191m6O0BeXZ
	dkesOsrFtYW7BBJKKxEwjZqQPGRvHtLmquPjZDFWcwxTfa0FDUHQiNk3ASMMfeTmXJ8BHfgIvCG
	+JKWqIvWz/
X-Gm-Gg: AR+sD1364GPg9QwoeGKOsxfk3YqcmfqUrWjBro+JF90pcTt1aZqFyZbpjzfYh4wKuWf
	7OfRtWGJ2qXvGKwXjjNMJAvG0njcIbMBR77oJBrduyINFEQ52VAcnbBcLzwplYKdHAnujnn+IcI
	Ij2+t5KJhv3EY9+7NzI3uwP9OngPkpCZFwSJ2PVDXPwngPaiMvOPZ9GtDxz0Fy3fl6oWWPXmdV7
	BRumRQlXXmsIC0FzKR8ESisjrf9DKXR9Zz67bDUKLf2cnv8HbRmkHOGOXzTTHom2vyDh6Dw524b
	T+j6FTWt4sI2slLmpk72mHalTz/Y6VWpOM5nilFmkAYZ1BIIhISJe+T76WWKwy9mm9/VA+3xSgm
	QQnApm4VbhQ==
X-Received: by 2002:a05:6a00:3d07:b0:848:47db:a0ac with SMTP id d2e1a72fcca58-84fb554218bmr3476375b3a.27.1786524489828;
        Wed, 12 Aug 2026 01:48:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d07:b0:848:47db:a0ac with SMTP id d2e1a72fcca58-84fb554218bmr3476346b3a.27.1786524489410;
        Wed, 12 Aug 2026 01:48:09 -0700 (PDT)
Received: from [10.8.193.2] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84fb1ee8ebdsm683103b3a.33.2026.08.12.01.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 01:48:08 -0700 (PDT)
Message-ID: <1ae50c48-a393-4081-b5cc-720037bdbc5c@canonical.com>
Date: Wed, 12 Aug 2026 01:48:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] apparmor: deadlock in complain-mode change_hat
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Martin Petricek <mp@petricek.net>, Ryan Lee <ryan.lee@canonical.com>,
 apparmor@lists.ubuntu.com
References: <552f7777b10a92ef675cb12a07ba8b7b@petricek.net>
 <20260811184500.stable-0007-sashal@kernel.org>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260811184500.stable-0007-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/26 11:55, Sasha Levin wrote:
>> kernel:  __mutex_lock.constprop.0+0x569/0xa10
>> kernel:  aa_new_learning_profile+0x15f/0x210
>> kernel:  build_change_hat+0x19f/0x3b0
>> kernel:  change_hat.isra.0+0x5dd/0xd60
> 
> Thanks for the very complete report - the reproducer and the stack made
> this straightforward to pin down.
> 
> The commit is 32e92764d6f8 ("apparmor: grab ns lock and refresh when
> looking up changehat child profiles"). It makes change_hat() take
> ns->lock and hold it across the build: label. In complain mode with no
> matching hat, build_change_hat() calls aa_new_learning_profile()
> (aa_new_null_profile() on the older trees), which takes the same
> ns->lock again - a recursive acquire of a non-recursive mutex, so the
> task wedges in D state and never drops the namespace lock. That also
> explains why every later change_hat in that namespace hangs behind it.
> 
yep

> John, Ryan - this needs an upstream fix; the deadlock is in mainline
> too. There is nothing in v7.2-rc7 or in linux-next that addresses it,

right. I am working on a fix now.

> and I could not find a posted fix on the list. Two smaller things in the
> same commit that look wrong while you are in there: it swapped
> aa_get_profile_rcu(&profile->parent) for aa_get_profile(profile->parent)

yes, this really should be a dereference protected as parent is updated
under the ns_lock.
> on an __rcu pointer (the kernel test robot flagged the sparse warning
> twice in June), and it adds a label = aa_get_label(label) on entry with
> no matching put on either exit path.
> 

ack

