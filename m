Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE844607B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125689; cv=none; b=ENPT/jW4WSN4SbGKwJs8nUaRrUj7r446EgRd4sRiYDDmZh0h3GTNjZXPLkQYbPh4pguhc/QfzOT/GAyNhBKLWSlWJw2st9tYeEvTu7AY3BGpu7jbwL+4aCZslP+CCM8AaL785WXfVq1QZjyewmLBewodlTNGnerRcwtCOs7osNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125689; c=relaxed/simple;
	bh=H8qExSfl7g9/Qkx/tvjSMDGnJOKZw6gAwcQQuXxFkV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYgzQZv1JxKwZbMHH0c8Og+Ize/+7l0Z+gKdldj3n3+xJxv0d/uQtvlLr5faw45CtQoYVCV1OnZzz5/GsmLAlfonvICsTgXWd0PZWcFGlIgw6SBMIExi0yNX0CJ3RnTN8/3IHTqclPi6nE4VrcyQpehgQR7dwXyL23is1sx0nv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MER19MWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MER19MWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B5A1F000FF;
	Fri, 11 Sep 2026 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125685;
	bh=2migcvQfStfnbpT/AEGuCXUOrIpZqgioK3oUhd+CegQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MER19MWaREkdUOlD4irY0x7fTO1bwg2uAw3Nw7FVjoOjPt9dHrI6hubi1Xc5JDIvJ
	 GitqSlrfK3e1vOv2N2icP29SlKu6NgfPkrdbSHv5xTimLHy2G12omb4XtlSCtGmI5c
	 FyBn8PyTR8fhzIiTuCkdkgLI2sELjF9mmEJJxtViqDo4P0EvUd7k9EEpt/SK3RUjtM
	 iwKkASET92VEmtg2iu4XF/T8DaVX+dFm60Wf0Uy7nvs6EWJVJDAa66NMlN1V4gcWRT
	 aOTjdISVMYvtksE3eU+2kcEW4tMPs7sSGfcrNKyGFvFuHAjw2JVZvRuAlcQ69quUqn
	 IfUF0TfyQ/M6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tze.yee.ng@altera.com
Subject: Re: [PATCH 5.15.y] firmware: stratix10-svc: Add mutex in stratix10 memory management
Date: Fri, 11 Sep 2026 07:20:46 -0400
Message-ID: <daily-reply-0027-re-stratix10-svc-mutex-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dc0e2d1f4c4f722f5528197c4835f64442561397.1789011103.git.tze.yee.ng@altera.com>
References: <dc0e2d1f4c4f722f5528197c4835f64442561397.1789011103.git.tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 85f96cbbbc67b59652b2c1ec394b8ddc0ddf1b0b ]
>
> Add mutex lock to stratix10_svc_allocate_memory and
> stratix10_svc_free_memory for thread safety.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
