Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA940F8CC
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191596; cv=none; b=GvaS1nyLT7gb/p7fVC7hZ8BuJqjEgAIeeg3wEdMtJutTvylQWftAS3QHVHNlYy9gp6o0X+QJBmZnAnaYMrmYahW6pVuccH0ej7LUprzinlUCTQd7gc+MzW+oUL1/xeDLxlAsy55NA5t5INOv9Pgzw6jBi8wlBiCBUtRTWLjrBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191596; c=relaxed/simple;
	bh=t8o/UGgityGJMHj76HO8iaVSRXTqkeYimX5nVorT8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD2hBX9mz/h9ViG0wSA/MGkToS/GwP4w9gP136imB8L5q3eXTOkP/Rs2fi/5F2/hdnTxiXH+GuszpgKFlHqYh+7Dm/IfpJKwre6JY7tGZP0XpXiKY/NxUOwrrwnxXprFj/UCdgQskCMu5vJ9VsCOwj4lJo2oBrkQDVtlq24LlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwRq6ZWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwRq6ZWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414821F00899;
	Thu, 11 Jun 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191595;
	bh=t8o/UGgityGJMHj76HO8iaVSRXTqkeYimX5nVorT8Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jwRq6ZWj/VLEqSLG+wXtgjJbRFSZ2OqciUOqqXBljPbUx++OwxhrCwF5HBpER8mR7
	 kg7dMQaMiOrN25riM3UZ8Ky0EokXYJ9RJJKoFmLF9bHznRWiJxBpzfbuE6NxZbz5OQ
	 IlKmb4v8NKmun4Yj9tn38aRQN91WqUdU7P8i+lAanpRhItVn9XZQXrAv7wEHSVE8cg
	 KODMQEmNWQr4jdJWcMBgDvcL5T6PI+jTYG4oCbOVIA8LG3v8VK2h2nfelA1Wd42vYV
	 NPXVRA2v1KQwwO+nRXkWZgsO7Xjjj2oJJ2YgLdBtSso6K35GSc+SVefQgtbL/s1Hnf
	 NnTYOG3yNjRvQ==
From: Sasha Levin <sashal@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in pskb_carve helpers") to 6.1.y
Date: Thu, 11 Jun 2026 11:26:23 -0400
Message-ID: <20260611-stable-reply-0105@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aioyuCnSKlch1wdv@eldamar.lan>
References: <aioyuCnSKlch1wdv@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 05:59:52AM +0200, Salvatore Bonaccorso wrote:
> I tested down to 6.1.y; the 6.6.y commit needs to be slightly
> different. I have not tested 5.15/5.10 (no net_zcopy_get() in 5.10.y,
> so more work there). Should I send an explicit 6.6.y patch, or will
> you pick the change for 6.6.y and 6.1.y yourself?

Your 6.1.y patch applies cleanly and looks correct. But I can't queue it
on its own: 98d0912e9f84 isn't in 6.6.y yet, and I don't add a fix to an
older tree while a newer one is missing it. So I'm holding the 6.1.y
change until 6.6.y is sorted.

Rather than have me hand-adapt the other trees, please send explicit
per-branch backports: your 6.1 patch doesn't apply cleanly to 6.6.y

--
Thanks,
Sasha
