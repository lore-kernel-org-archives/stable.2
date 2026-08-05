Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085333F44F2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971624; cv=none; b=T0H/0hMLEx15BKfsAGZw06qEfyfSXnJwojP1b4rKFyLBbVtHzGFfm3RA5h6yNiLtQn2lL6PDBhD2iicCo9V2BIXADaVwQv3jdk6mRMRyNtCTqjr9c6XWztv3eGY9n0lZhEi+KXYSs69FOmNdyw1wZAy/2FOKxu0PueLndCxpW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971624; c=relaxed/simple;
	bh=LkM7fYhWWWgeAM3toSceqwVG2Yw0sBxFlU/yKJv2o00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1b/rAam+fAPM2VxssM5Uh4/OtXNqe0RvE07CAOkALuNFA+En8J0bbavK1pIDbIIHqRTR8iaDv2DaUaK+lSURI51X+OAKSwi+4nURGTn/wjfg7VRMTNnbU+OUGCEKm1Bq5r+weRK5v34Ehuzgke+aH5YErpfkeKldL5bQnLQwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=PQ7cWnxd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="PQ7cWnxd"
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3F8BD3F9A3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 23:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1785971619;
	bh=nHbFOVIYeLhSKL2+ouvuUKp0EuJiRVqY6uld36J7XZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=PQ7cWnxdtC7+xGcKOVwIKI5Gvo0MeERWb+Fc2ETpR5EY2eNmjPnovqCCuS5M1f/yA
	 SQVDwRT9UxLn3aTaKGhCsxgVv3lnMpAFJiGtX4aNRYgPeId/6K6xxfMq6DSTmJWWPs
	 C8nJEqTF/KdWIfquYxOaC0R7x2trOMTqqvwVP366+rxmGZu3unAeFAc3E/dyeon/Yx
	 0hpwFeXbAj/NMUDtbunEnXV9xkdYn46wfBVVdLk2LryndKaGFptjcOiz1pEPKlitQr
	 Xk13OMiYUye0JnZlQ7tIeLuI4w/TUzYYUgDxD4SlqAi7se1TJIOMCSrdZ0dxs6rE0/
	 ZyTBZyk7G/EdAWUhcpZPdhY1dDVe/vr9ybrOWEOOV/iT0zOcJ1NNg+rtZtPv2tTOTk
	 VtR4iZ/UsADrRlU0rIyHTtUMDcj19tDAe1wV5Wu19W5LQX55PJJ3LI2lWlmlMJMLkw
	 OWIOrpurQv9n5mVIrq5diA+fsZWocT17wM7o1xutkxMkOHmoo2GoKxgeTdeF8QmCWb
	 g6WpR+aDwRQZXmxix973Ux1xzE5D2qKkT5ATZrvVXxdDS2j1ckpGSQ5uR6GWdFpZzK
	 5KA4tMLB8pVQN6d3DE3oMgO70pAVKwB3PZrAFPZKffU3LRtMADybNc9+5MzFrKJVFc
	 y8nlhdZzzvvRGJ7YJ/DuevHc=
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso1922591b3a.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 16:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785971617; x=1786576417;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nHbFOVIYeLhSKL2+ouvuUKp0EuJiRVqY6uld36J7XZ0=;
        b=CrQDbezaNdAZoyZt9wsUexo4gxnB/Lr9IvtQaoiPtqwIGeoL5UIzKX9rxGo9GXqW+1
         nm9C4kulQXY0oPtVYHxyFqtILA4rSw2GZ672Jp9acAbV9MWeo4/iVQHuZshYhlqEjnr+
         ECou8VIJgSbaM8xeXwndBipW8iAvugThumKPe4fMTQvUzVsuLTTzuti8AvvzW0KUHVNv
         WCnlzA6fvXGowPf+6LOFTiq9KA7tJxFbOjpdmSX7fyNbAr1a/YFRKjgNZjaiCHe5vfKv
         WmG2jW61A3LS4lSSsUisEMBMJpq2wzVjQ/gIBPhhV+zilSphk3RNh+bFbp2yCnMWWGvl
         A5eQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9Mx4zxEZXB59WqFgLFT7J+auLw1x7yyHI9PcMGG9e06bTp1KnWcFOZszdN4SvOZAszJ+mAbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZFNg9CXfdEaOk1GMdDWbtUNSpNyd8YY06qIkSrb2xGukRhxC
	wsa5WJiy65uErNKc41kirmuKO1TKnkk6zTiG3Y1kA52N7tBBqaS7k4yzOJm7VDrIgS6Stu3Jgvf
	QwqAUG9FW2DYj03kTsbZT4iAhEbccb2tpexpbd9mIzCCSqmvGeokNXdNBp2ZbohJ/exz3Y2jpcw
	==
X-Gm-Gg: AR+sD135HlUZjAUzQVlZDp0VWZqr5DkIVwU1AEFIhs5V3VpbG9K/tvhVELMox/Kv7Yp
	gpVvpAD+kpavRTf8PpCkwDt88Rfev8Alug0z0EFblH1QJjQiwpUslimSR9th50VRWThHnF5fPda
	NlqzlJlaSEcG8XEngf/WzFo8VtVAUHuz9l0bHZ05ysJsZWKjQg9SqO82u90CvcoMd3dfm+xMtZG
	Fwu7aQGMBOBC/ra8sYIQbrZuInPD1WP/SDtMYm15NEYU9ect/Pr9jiiMXfikfT07R2H0d/Ftx10
	sAGKudX5078cRhvmC1NeofyS3E86U6pXZl7jUcFGG32ogzK1TCEacB25s60aFeydFV0BMqj1fF2
	fCeDE+lkghmIkJMk=
X-Received: by 2002:a05:6a00:3ccd:b0:845:c7f1:29fa with SMTP id d2e1a72fcca58-84f2e04a63bmr11049888b3a.30.1785971617347;
        Wed, 05 Aug 2026 16:13:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:3ccd:b0:845:c7f1:29fa with SMTP id d2e1a72fcca58-84f2e04a63bmr11049850b3a.30.1785971616953;
        Wed, 05 Aug 2026 16:13:36 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-cbe707f037dsm2428288a12.12.2026.08.05.16.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 16:13:36 -0700 (PDT)
Message-ID: <97987e10-07bd-4f06-8b64-e3e076aef33f@canonical.com>
Date: Wed, 5 Aug 2026 16:13:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix cred UAF caused by
 begin_current_label_crit_section()
To: Jann Horn <jannh@google.com>, John Johansen <john@apparmor.net>,
 Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Morris <jmorris@namei.org>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
 <CAG48ez31uJ1utneG2VepgkpYp-zpmypoBJ5TTXOxiPLrZsXTrQ@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAG48ez31uJ1utneG2VepgkpYp-zpmypoBJ5TTXOxiPLrZsXTrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/26 08:10, Jann Horn wrote:
> On Tue, Jul 14, 2026 at 5:39 PM Jann Horn <jannh@google.com> wrote:
>> AppArmor's begin_current_label_crit_section() is a scary function called
>> from lots of LSM hooks (in particular VFS/socket-related ones) that checks
>> if the label referenced by the current creds is marked FLAG_STALE, and if
>> so, attempts to use aa_replace_current_label() to replace the creds with an
>> updated version that uses a new label.
> 
> ping, I've seen no activity on this fix since posting it

sorry, just swamped and not catching up so far.

I am looking at it now

