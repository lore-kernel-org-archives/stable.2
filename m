Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B723395D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892425; cv=none; b=GUWgdGE71TWZxlfJI/RAXGwguwIUtuUP813IbidMAg95huDMjpIlcGjmVybQPHsxC7khYf4gPSxHACmrz2z0RRpC/02CxEa9G1Qv3pwH+hmNJxSwHTP4Ok40trPAXBOkBow+09pB0DQb0G38TU2uExOoPND1wx5tkhrqAQG6Ilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892425; c=relaxed/simple;
	bh=5KfyfdSUqEOfBdI/7ofqklxQr/tIi56pwI7dUUcZ9O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2wwmwxcCOoVFyHOmpGK7y9ZUie1EsaoNqsob+rnLbznhiedb69xQFEJc6rdbQGX+e0tF4dv8t2ub+F9kFryzLIyThr6CJUhbliEU05p9POX9chpcNnA6ApB7DQCwFe4j4/UvypbSA0c8Dn0wQSsvGr6Rnl+50DLVZFRRBkwLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3uj1ZSR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3uj1ZSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E361F00A3D;
	Wed,  5 Aug 2026 01:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892424;
	bh=dfo47+eCe9iHBGTg/TP9jYQgA4hHsKhCH74FbZsMPp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R3uj1ZSRs6hJIl0FnuB2NWfqTzoDyD+5F1c+Xc4uqXmOMffOCmLz6fm1mGQCHfW33
	 JAjVtRrV11usI2jYNbOMlXczr6qacRCU4CYTb5vNEBvJLitOBYIUM1ejpUTnugq/a2
	 els9rpXdg6sdCK6Kksx2oyIFlNrqwbClUnNl+6LoL4Qk4x5xMu3Z/Vf3aP17y+TBgV
	 HPj0js4QKF+QvWWIjkbTAWzcpGJxuYHTEseowFywmGZ9GWr2ByQTkDFNycNudEt/SB
	 mxFJT/L2+cNqQ3x2WskgjEPS09es0Xp4dfZC9Ju6/C35W5wQDGl7O7arQGy2FM/pcb
	 3CkOAU3sOSDew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tze.yee.ng@altera.com
Subject: Re: [PATCH 5.15.y v2] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Tue,  4 Aug 2026 21:13:31 -0400
Message-ID: <20260805011008.stable-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3136c976de3cf030e1d9d96b38fb68fde3e0e5cf.1785842041.git.tze.yee.ng@altera.com>
References: <2026072955-anatomist-verdict-df3a@gregkh> <3136c976de3cf030e1d9d96b38fb68fde3e0e5cf.1785842041.git.tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 04, 2026 at 04:17:00AM -0700, Tze Yee Ng wrote:
> Changes in v2:
> - Replaced kzalloc_obj() with kzalloc(sizeof(*pmem), GFP_KERNEL).
> - Dropped the stray guard(mutex)(&svc_mem_lock) which is added
>   accidentally when rebase.

This looks good, but we need it in 6.6 and 6.1 first. I haven't seen backports
for those.

-- 
Thanks,
Sasha
