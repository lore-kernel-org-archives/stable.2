Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B432B106;
	Fri, 19 Jun 2026 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842047; cv=none; b=oSm3SY5zqLoCAt7AEYqoOBMNsIYhh0z3Kq7EERFPd4rJ1u1Itc1dUfPEpcxTkzLRFTOZ21OHz9TwDw43dbFKMlz39ynQpBDLQMy6ijdONDg5CMU6Jn23QWR8SoHTJ4shdIK5BdK3Nkwc1LOCxq7FZf5kYQu3AG9IV7xyOD+q3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842047; c=relaxed/simple;
	bh=lDb9e+3B4yyaiFNA/GWkzAxmfKkdsgwyopNeUaoUPHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7MmgGHEf3042p87PlImjW0Lj7wljjj9qrNdRK2GlvUvImxb0EuReZYdICs+DmWaKIlU2lSaYwiw8BGpIJP5v4fK77bQsnq0ibqXnuVhRhnjcZryyfkeEB7y567CWIfHAB/8J/ig9DuJvVIJbI/KWVOjuUciH4ImSX7Uc2IhGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr/OeAre; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr/OeAre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A6F1F00A3F;
	Fri, 19 Jun 2026 04:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842045;
	bh=cmffGm2q1sv7KOg5Cs5YvudtBs1bHVco7b37JKfPXlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vr/OeAreSOAVJFm7ql2EuBuqiI5RL3rYoEKMyXABhZqZEHwBPxag0TiLs7m2ZG4PQ
	 OzGdSDtBzgGta6ffMPebv23nLWnsOFvw0i6jYA6J2eijn+h0KTZIGEnZK8jD7Juc++
	 3TVnWqPjd/wq6mrMLpT/BjZ5SOXMjs9/rnFsfKV3NUnnADqclvnGGpH/R61Qa8rEip
	 c8ohLIwVIck+VvmhzkWfFkr1X0SkPoNpezEG6tasYLdfmEmlld1NL7epi3RDldwNvu
	 V0RCLVf85UElUQLlhLSPOMaPeMcsViqY8784PasUWXuErV2LmeUEv0Ux/PQLZzbOUD
	 fzQMeOXgbQOrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	io-uring@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH stable-7.1.y] io_uring/net: Avoid msghdr on op_connect/op_bind async data
Date: Fri, 19 Jun 2026 00:07:07 -0400
Message-ID: <20260618-reply-item042-iouring-71@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617174947.2975419-1-krisman@suse.de>
References: <20260617174947.2975419-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH stable-7.1.y] io_uring/net: Avoid msghdr on op_connect/op_bind
>  async data

Queued for 7.1, thanks.

--
Thanks,
Sasha
