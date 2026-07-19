Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D23A1CF8;
	Sun, 19 Jul 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473246; cv=none; b=mdrynz5BCVyMYURvmn0EhfR9qzE6LckI9djWgcROrPhypHjLLdSu1tFcitQOB0a3v0Kia3lvEwQkclcU5BVXxP4V28ENClB2D/d7zFVATpGxHvT84WqGfZfGbKGTogF9Lkqx22PrKfgiIVB27wp1sCRyIyv6pqjXfhM0BKdsgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473246; c=relaxed/simple;
	bh=hIc41mm6pOXOlxLqVE/55SkPwSgpjVVy+YlgEj/2y/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwJp+qJfHHMmIFMSFqo07/s0krZZ+Vms2KTENm/XS00jLHXIebe3PFqsthE1z3FMRxMNAQ8hmXGxt/BxXOT5amNPHsurDfJMp5LTmxNhwmKPWtySASh9Mzhm+ABSedJuZU1wD/Q3pM6JBGhNQ6MLVoKW4LsYb1unQhRzia+wcyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ksm/Iod1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ksm/Iod1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD71F00AC4;
	Sun, 19 Jul 2026 15:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473245;
	bh=NVDpuBOPHHUlJsCQuMMoGsDinP4Snq0r5Bzuj/HA1U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ksm/Iod1ZhO0ArxMO86kB971LDnLKaRJj3K+aiDvICYbGcSwvxRRYcIFbqUAoK+2v
	 G6fJHqD45yCUTvdV7G1MRtDWHtjsi7rlkcmft76+gL/l4rjJUpA6ZZiRH8ndlPG5/z
	 hyYhIdc3ADE2HlgL0szF9qoxnoCzFeXjZPQ6kkCm5PlvQCyTeotxXQ4RMu9bRKAmar
	 fT/4EEzcYRhSuo1YblMbTm/SpD4GaZbABZC0TPsYn093roE96jz7n0t3lfy7Hi5+Iv
	 KQGCTfHshO6KgKssZOJ0SZUsA9ix24316UksjR/Tkx/+2QQi717Y+wxnTfggR4vmdb
	 x10hrTDcHWLDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-media@vger.kernel.org,
	laurent.pinchart@ideasonboard.com,
	hansg@kernel.org,
	mchehab@kernel.org,
	Jay Chooi <jay@robocurve.org>,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: uvcvideo: deadlock when async control drops the last PM reference from the status-event path
Date: Sun, 19 Jul 2026 11:00:19 -0400
Message-ID: <20260718192718.0005-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANiDSCttWrSLoftLWPtx7XxYaQ7PRV2+Y0tvir2qaE77PMG1-w@mail.gmail.com>
References: <CANiDSCttWrSLoftLWPtx7XxYaQ7PRV2+Y0tvir2qaE77PMG1-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you help landing  6d27f92c54ce28cfbd2a8a479a96d6f4a781b7d2 in
> the stable branches?

Queued for 7.1 and 6.18, thanks.

6.12 and older aren't affected: they don't have a32d9c41bdb8 ("media:
uvcvideo: Make power management granular").

-- 
Thanks,
Sasha
