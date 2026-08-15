Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE328507D
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761224; cv=none; b=JoXpMOm5oTLjzIvldoO5umOg7toMhbTJrDKZY2p93Q8//AJSuo4pM3YX/epFJgbjmBTItlqmfEPP36n7F4wlOytJeY/jkklqOYUTAEaNCWfCQMAetC9ZpaHFIaqmfTeBdNbfSS+DYrxe7IX/FNidyleTzdvCNrvBWxEF7vCN9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761224; c=relaxed/simple;
	bh=WZNNL2W9nTnda1POAFKOJzcT/ck6ETM6U4Df1ivAoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO8WJ7jCBFiX9mG+qd/S364q9v3Wo508zp1KKSSyVhfMa+70vD5ZTDuHJ79MdYyldosoFFsmSTbm86QYClUMwC7OYWzQ1MYr8nTGbQ7LAenNJxphWEg0F2vOH5+cTREwLFybFMqYueVIP7A4ZPG3KeI+3iTAaUhDIYqsX2pFBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRREMV6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRREMV6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305DC1F00A3A;
	Sat, 15 Aug 2026 02:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761223;
	bh=+BOnvRDL/UTC2wFCxGPMvbtlNsJpQ0HBxu9/nDHYEAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WRREMV6RuIWf+o+4/Rgna+EXNoftYhyRHyGdovhiHfCRgEM/CUGUTSAXNXJzFaCEN
	 DHKoHgmGXAydvFbEHj1d4zGkMjzVLv89vkl0O8xGXRpIZv+X84TfD5U80/5iGAEceK
	 Ia1rTiGw+Kzrdx/dWZO9VLCFpFbg9GlynKDbdwkRASEZ6NQAW/dilFTiOR1QaoNvOt
	 dppHrF32gND8XhSGmbEX4+l93Ep8zJrOkhgtg/nuBx9YFum7w91YO+t7KA4sD0ONWV
	 9KJ3r0U1ixyrmZJZCl75X/0QfdEK4IbVH4e/Ji9UgFGIPA11GjooIh/MB6nsRMVumn
	 Jl9MkZKoLVL0g==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	keno@juliacomputing.com,
	keno@juliahub.com,
	mingo@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 7.1.y, 6.18.y, 6.12.y] futex: Prevent robust futex exit race some more
Date: Fri, 14 Aug 2026 22:33:16 -0400
Message-ID: <20260814193000.16@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <877blsna8f.ffs@fw13>
References: <877blsna8f.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 6d4514ca9cdf61fec4ec634cf50386f6f7e69748 upstream.
>
> A robust futex unlock stores 0 over the whole futex value - wiping
> FUTEX_WAITERS - and wakes a single waiter. That wakeup is a one-shot
> notification: the protocol relies on its recipient to either acquire the
> futex (and eventually unlock while aware of the remaining contention) or
> re-arm FUTEX_WAITERS before sleeping again.

Queued for all the active stable trees (7.1 down to 5.10), thanks. The older
ones needed futex_wake()'s signature adapted; the logic is unchanged.

-- 
Thanks,
Sasha
