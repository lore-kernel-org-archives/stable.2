Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927247206E
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926652; cv=none; b=aysENyd92CDzlEW0huVtz9zGQpI0PQVQP1vLFeFDc/nutlCouWsCZNDHLv2wGxjwTujETSb73+giTlDSg/izT6BfjrGNVSEe+hYodD3bv+Ju1R7sndcZH5OeheM4uvDLe3SyF+tvKgSMgUEuPKUz7+qYrY6YBElwXVWQdCgCmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926652; c=relaxed/simple;
	bh=FtKuHvfD3C3wetSNPwcH5SJb7LwD6m3i14ErFDlrNEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgEhDV0g4dfUr42fr9qka6FVBJlA0W7mNaRQBIxFnj3TUm5Cd8T5a2zuS/Ty8XdcDItrHkqoIzCk6rqI58eEaoBsuYt1szx1FE2UWVvYZDYLIqriDtcCEKtluQHWlvbDDsPWrbNhgH7sWeYjTpG4OkrtrPhUhpwQTpNBHH0PnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOXPaU/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOXPaU/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB091F000FF;
	Sun, 20 Sep 2026 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789926651;
	bh=47G2d5+1E7yeXHeu/N5hk3AI9DWgcDI7Dv+ZM3rrqVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HOXPaU/E8srRc1CTzUv2LoFyL3PAidm782Z+7+qbPphfdjcDCTEBvVOr3CXF9xHNW
	 rNwGqogyvG1gyI11ZDop1tzVhhVEjijPN7sxQgLptLalAGPCwHuM78Ib+kt/TdAnrp
	 nSo/6WrGh0P6SlzWCIfpEJ+iH9BerjV9yniUR/JkGirhmqkCBWljD/i0bS7670x39l
	 07Or0hggZDKDZCNXjLa94garSjhC7wQhzzR8iQBe5i36Xqw45dUTi3yX73fvQdPRVM
	 dXTcUMm0H9TZhOjSJcZIyiIoLGQxQ3EUalpflElV0WAzH2nnIiPivfCJg0p7WOC/BQ
	 R/mRGhJEPzVhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	arash golgol <arash.golgol@gmail.com>
Subject: Re: media: video-i2c: fix buffer queue ordering
Date: Sun, 20 Sep 2026 13:50:35 -0400
Message-ID: <2026-09-20-daily-reply-0003-re-video-i2c-buffer-queue-ordering@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAMxPZkjojOOqT=jyX=zyzLT5-AYqL0=obJxnPKsgewfCeH+U2g@mail.gmail.com>
References: <CAMxPZkjojOOqT=jyX=zyzLT5-AYqL0=obJxnPKsgewfCeH+U2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider the following upstream commit for the relevant stable/LTS tree.
>
> Upstream commit bc4574c265ed738849e46d942617100580fcedd2
> ("media: video-i2c: fix buffer queue ordering")
>
> I forgot to add a Cc: stable tag when I originally submitted this patch.

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks. 7.2 already has
it in the base release.

-- 
Thanks,
Sasha
