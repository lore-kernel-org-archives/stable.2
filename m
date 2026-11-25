Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597026;
	b=kV9pah5yKq1vDahMK3NROHWy5x4a8/0AeSPhKSlgtDCwMJrdM65SYto8Y/62F3VwHxel
	 nfv35rQVEaOtyOFIJqvs9voTBXNyjCBTJJ83XAOfD9wqVyit61w7q/USTJUdTxDnL7ON8
	 bv0Tzzmwlc4oRNEufZOTwiZ7lemGEi7zv+umPCZLlxKlL/tz8ztqYzumBLDhym/bW1yP1
	 5Fh5a6bqO6XtqzWdsWWunWQVQ+HIcZUQ6B62REHUPtLyyOqMiRdITOiie4j4J+k+aWThl
	 R4chYqNnbj18PKjHTFFGuQuf4KSpX9cwiFkr5pEV0HeUNnbBaNFM22gBZY1CVqcbFtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597026;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	b=gOF2XzbvO4oq4vLgaQNzKBsljafhy3fellYHkNE9wknR0KKP8pQHwlRytfKFfTmzVHqX
	 bChBquJEhxQtzRlwQGYz3ACWVeq9ctgcdftHo2mCgKlkzdDd2fZh+2UGOissFLio7ZYJ9
	 cHmvEqBLqt2IEt74HatpG/AjM8MRw6RQqc5nXAliH+TYBVTYU7AOugJ4Z9NAt1ClcqGXP
	 Y48KthuuG5NtIWhAFmBGZQK0ck/5RczfZsobdXb+FXTjMOzpzWMfk+xaFqt2lwpGXfJ31
	 z7z4KHVZbJnieSv4dCAZu7lnc1hoym6+3qHtgYYWloek2C/PNeIBfbfq8wBMK02fxdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFRqGS6i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AA606A321;
	Wed, 25 Nov 2026 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFRqGS6i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679001F000CA;
	Wed, 25 Nov 2026 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795597025;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NFRqGS6i/PirNUe8tndvVBkUqtI16anrWsvfoG7f8Cw8dt4Npd6fQMdzdTFivz461
	 lYLmC2HuyQr36PIL8viZmxy5pRIOkFRMAdMmWS1CblNmr+lb+335ySzcsQlTFH+XEI
	 27e9smGtIge28Zr5KqtauQ+Dd/PqJP5+jheizg32bA87T2D+H4CfTVzu3bsliOwwNE
	 0ptdxcyBaPX9ODlzzoLUODbYrqlMWeqTz7taPcFieC43atBoZ+CjfC4Ba8SdL9KEEF
	 WMCpyNOW1Y2svzMOLyRCyD54hZjq5jZwjLpCD72diIQwD13/IwBtPUbhtl15g/PWHk
	 bfHJi49wS5FlA==
Date: Tue, 24 Nov 2026 22:57:04 -1000
Message-ID: <53d9cc0246e20e98bce12beade9c019b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Cc: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes 1/2] sched_ext: Attach fair_server before tasks fall back to fair on disable
In-Reply-To: <20261123-scx-dlsrv-v1-1-87c342d8246e@gmail.com>
References: <20261123-scx-dlsrv-v1-0-87c342d8246e@gmail.com> <20261123-scx-dlsrv-v1-1-87c342d8246e@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
