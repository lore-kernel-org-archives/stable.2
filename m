Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5D3D75BE
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701639; cv=none; b=p35wfZczgykI6egxwSGgbna8zarodKdcc0gyOH2xtRPxiRIi8wwGCoSIR2MoY2tNzwVkULDy2ZpHBDoeSocYOxXL44IKObx22cRvkIAAUjQB+667uBzvfU1Od/NJCuaM7MF4Xmg+wOSWSCdHRpTnoCoTGanYuYpITiCYXGLGWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701639; c=relaxed/simple;
	bh=wc0SDDB7/GPLQafZAE/MDaXhwUgBUsZsP9JhFdtQvrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eud+AN5Y9eWoTDMuEcqcfOaADbgsFIDifc1QIK4i8wSuF8N2cjdgK31olUoOmdTu44KmXOga9bl7Z2PRF/OzrATHGnRm4XNFjGk3IJBgVB2ogCoVLnn9Ww4eKkdBBB7Es9Pnrh6gXpXI8V4qh69bqEXZ9h/IgM6wpRYDUstzT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCbY2M09; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCbY2M09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EE81F00ACF;
	Sun,  6 Sep 2026 13:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701634;
	bh=Sz25b/aL+MzWydrXVb0NZbqhEZ4m/17DNpfDdfyZCAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MCbY2M096C/0bgfvPN2cI7xeysD56DaZFCQC7tzCWobfqDbp08ACxCRQneh6aSqG2
	 +cqByogdoKcWtGO6aPBDjMOkjIAFlOzQoI8k3qvscGAS/1E9LjD+Xl7PuKKPw7wvUd
	 U5fck6rYpaklK1blUyCj0RelU2D2r5lB+ZPZTXYonCb86JEx28n8cJqvYG6hhmxit3
	 8daa9tR5euq+H2Xgr8+srlQN7sXPAvtSBk9s78xNHOOeea3uD8w8S+8NGa+CwQT/HR
	 bTVNgUFZbR1Y1oBw6JjQ7tEOe79VuqPwUHjOzQNAhT7Ygn+3NMQZQu5M3aEHcJ6YaN
	 MB/TSdGnq+RhQ==
From: Sasha Levin <sashal@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ALSA: seq: Fix port lock leak in deliver_to_subscribers()
Date: Sun,  6 Sep 2026 09:32:59 -0400
Message-ID: <2026-09-05-daily-reply-0029-alsa-seq-port-lock-leak-5-15-ack@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904070409.80648-1-tzungbi@kernel.org>
References: <20260904070409.80648-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit 46397622a3fa ("ALSA: seq: Add UMP support") mistakenly removed
> the `snd_seq_port_unlock(src_port)` call in deliver_to_subscribers().
> As a result, every time an event is delivered to a subscriber, the
> source port's `use_lock` atomic counter is increased but never

The fix itself looks right - restores exactly the unlock that
46397622a3fa dropped, nothing else touched. But there's no mainline
commit backing it (the actual upstream fix would be 177ccf811df4, which
is a MIDI 2.0 feature commit and not stable material on its own), so
this is a stable-only fix and needs a subsystem Ack before it can go in.

Jaroslav, Takashi - can either of you Ack this for 5.15.y?

-- 
Thanks,
Sasha
