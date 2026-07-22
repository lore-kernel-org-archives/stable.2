Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6E368D77
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681653; cv=none; b=TMd4wd4wkXRhXROyhyTkQq+Y+qC1TXbrbhCYmK2UuFTXEis7NCBI6VWOOQ7rFYPl9etB7Pw6y+yxEShkZGqZar2S2JR2JZXwN7v2rqjnirbiK5SOa0fkkbB2jFfJlHF/Sv6ZQWhc2YUbZhnty2gGQaVdkg3lb/XVI1XFtdU/3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681653; c=relaxed/simple;
	bh=G7xQkf2mbWjnoi9lDHcLn1FYALpn1Clw2e9gt8vMMxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pg9Jaaq63bOjh6BHnFUzHRS6x0ryIVlobCkYKga8Kn/JJaJQhukdxgvredqz04xygKfa1gINCxGyBlc74qrxJmVuMnfsZSvCtAv5vtAguWUPy8IH20HIajKEAJL7G7TyjUZq0yldFuP+XkC45SnOw2xr2+p9IwbVxWzTCh6ynBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHx5O0Rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHx5O0Rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C1D1F00ACA;
	Wed, 22 Jul 2026 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681650;
	bh=cKOzmCGMCS/HowMBcaJaau563Um5WEY9I932TsYVc2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NHx5O0RkaWHSxy9/qEA5XExgK2JH4IUCPLJF2oAO1hufispHlWp0is722WJEbpbYh
	 5y8ppMBLSWFLxlO9MtGtyUuDOhjnGOmUuurWGoPdH7BRDQC/88HiosBZ0dpPxZ2XNu
	 QUIpXSTQ0uma6wr1kOl63WXCJE9/CH2uO1WQS9Cpyz3Johkqn/XVqCuICfd3rQVE94
	 n9bZVxsu030L+YRPlDRgFnk1fze8LQEzAcQxsX2b0a71IcZxXqdeJw99cuBLkPXYyD
	 S76RVDUVMkLkHLZhwlJxW99L0qtX3TzMFX5b3sN+58REX3Eni7dLfL8rhE4thqxDGF
	 cjdAeAzino0Yw==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kuba Piecuch <jpiecuch@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 7.1.y] sched_ext: Skip ops.set_weight() for disabled tasks
Date: Tue, 21 Jul 2026 20:53:56 -0400
Message-ID: <20260721201114.0009-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721150403.3680077-1-jpiecuch@google.com>
References: <20260721150403.3680077-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Notably, ops.set_weight() is called _after_ ops.disable().
> This violates the expected semantics of the callbacks, the expectation
> being that ops.disable() can only be followed by ops.exit_task() or
> ops.enable().

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
