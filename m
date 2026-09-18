Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00F4FECE8
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739763; cv=none; b=KdaRPy4f9Rsm+0gQiNDKzFdrltaYrNG+Pd5sL8x38wzzxd6RvuvDbWnnLH2jq73/tGGvE5ewof2goDBajp74VWoMXHgDb3nRjwev/e9sELbCydkGtaV2xr/MwgCaAAYwgb1ZmBGct5d3446AczIwRHq5ZI+BCyTaX7RXXpuayYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739763; c=relaxed/simple;
	bh=oLmGdDlmT9FsQ8Nns5gbaXtz/Y7Q4xu35sluIs2bD/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbbZ3gOOJ9lbNYFkhqgSlHKq2ZoceCmMB6APY7dln6NCtWLjmguSZ1AwbQMfwy71kNK26OieiWLchZVOobDCohXthkN0yxtBmOt/3uKZXc1Q7q9L9m+dGWEygUF2Q7f+FzDDAZTR6IkRm2t/txYHvnVBjTQtJuMwGjAhbyXZb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tQJui7wD; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tQJui7wD"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmZ0H3VnLz16rf;
	Fri, 18 Sep 2026 15:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789739759;
	bh=GBaWyZsNpf6Mq6Ba//QGR2wROdsbPFqMBuqnMq9IDG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQJui7wDq4/ekdYf4Z5P+itPMeWB1+eROfLneiMxKaPJjblrptTytYohso+/Nyzk7
	 QWxKnpqxdzJUEDI2PBQLWODCAVNnBkbsnBWrbTKLnMFQHQScgMKs2TORQgP47xjU/7
	 +iJ2yS5CzCPRdvYorvW2Xemgv8+2KR89FfS0C/Ss=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmZ091z8BzcBq;
	Fri, 18 Sep 2026 15:55:53 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:55:51 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, Shuah Khan <shuah@kernel.org>, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5.15.y 2/2] selftests/landlock: Add tests for whiteout
 object creation
Message-ID: <20260918.ineeFoh3ooHi@digikod.net>
References: <88432dfe86f2aaa9ae499587fd7acff9d34a338b.1789655723.git.mic@digikod.net>
 <2026-09-17-daily-reply-0015-landlock-whiteout-tests-hold@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026-09-17-daily-reply-0015-landlock-whiteout-tests-hold@kernel.org>
X-Infomaniak-Routing: alpha

On Thu, Sep 17, 2026 at 08:52:42PM -0400, Sasha Levin wrote:
> > [ Upstream commit ee890889b30b22f9a21636061def7a04e4f89380 ]
> >
> > Add tests to check that whiteout object creation is guarded by
> > LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
> > userspace:
> 
> I am holding these until the newer trees are covered. 7.2 and 6.18 already
> carry 672fa082d48b ("landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout
> creation") but not ee890889b30b ("selftests/landlock: Add tests for whiteout
> object creation"), and taking a fix on 6.12 and older while 6.18 lacks it is
> the wrong order.
> 
> 7.2 can take the upstream commit as is, but 6.18 cannot: it has no enforce_fs()
> and dc75f8904694 ("selftests/landlock: Simplify ruleset creation and
> enforcement in fs_test") does not apply there.
> 
> Could you send a 6.18.y version? The 6.12, 6.6, 6.1 and 5.15 patches themselves
> look good and I will take them once 6.18 is in hand.

I sent the 6.18.y version here:
https://lore.kernel.org/stable/22492930911630bb9724ed1c34248143f8913f68.1789655724.git.mic@digikod.net/

and the 7.2.y version here:
https://lore.kernel.org/stable/732f5f5e0f5bb22d5717577d9c382b00c87725c4.1789655724.git.mic@digikod.net/
