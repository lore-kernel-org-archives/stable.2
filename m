Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94BD3C0608
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384130; cv=none; b=Rln498+nzz/+Z+PjE/JEGVZBaQA93ZCI0y8ho35WHKItCBDXvvw3yXCTrHVO/8nvvbWlIXoQPtfRe0hfrQIAQ8CmqMdsvhpIDcQCrapKzPpo/lKonS0xBoTdqVyP9fEifHY4qCgMtriv4JOSqK54M06DYo1dS0IZT4w+0T9BCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384130; c=relaxed/simple;
	bh=fcLGIXwwO4Rzea1cuPuJJJG4rm4KZjNeYMDEt3kez6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTauJMpfGEb94UbxQVVoCb7GWAcfGdRg2g6gLtsXxuEZ/3cx/kF6Yi49MnG+9IlW5ThqHHoFP+Cufy5s95bh5mBuQMhzkbWgCTsCKx4HbAbJJUlO9Vp53ELySZD7Bhm8OnsAjnBhW7yIADvhwrVnJhmGr1Iwt34hQa0LcGNuykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV6b7ux0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV6b7ux0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F381F00A3D;
	Thu, 25 Jun 2026 10:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384128;
	bh=fcLGIXwwO4Rzea1cuPuJJJG4rm4KZjNeYMDEt3kez6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LV6b7ux0goTHtBt7PQfbi1dcrTq5Djjv65AHxr6/0xP/B+Ib1apO54LCkacK8WP4p
	 HZ+Dx4Rx6TS4IJQAta5EPTst/kPZAnZ2xTH8LFwAExlVFHooJ78mC14vz82d2OU4Lx
	 oWtWtX02f+EWC/xI7EqpuzCDKqManNJX9fAHaYvgOz+ZiQV1H1m1pslaxOniK8vvYi
	 TY4ojhk/tieEkEFrPCWAmsvUZ0B/9IEeB7jisjT0A5fJczcoEhPx8hjM/+O0lzrMpr
	 svX/CCUfu/gqMunOdVjH/jAcJ/Ko0XW9+Qyw/wjJmo0jVA4CO/bUwR2K4QPxlFbiWF
	 hMTbxnrApT3kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.12 1/2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Thu, 25 Jun 2026 06:41:51 -0400
Message-ID: <20260625054005.0004.bpf-kprobe-612@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624062235.21002-1-shung-hsi.yu@suse.com>
References: <20260624062235.21002-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH stable 6.12 1/2] bpf: Reject sleepable kprobe_multi programs at
> attach time
> [PATCH stable 6.12 2/2] selftests/bpf: Add test to ensure kprobe_multi
> is not sleepable

Queued the 2-patch series for 6.12, thanks!

--
Thanks,
Sasha
