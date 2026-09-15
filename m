Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B11FB1
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437821; cv=none; b=HSAMoReHrO4r6tGYMdZXEZaw2LwKMhoaeQk4rCiO4aHZAXuY2JeRikqf2HhrQwFQ5JOtjSGNnK4DkKaNGl2AbsgjHK67PdJwLAMDjYR7cnPs+VTZaw2TJNHVxfPUWG65Hw0Jp34IiQIxko1mfxau1vsUitnixg5dqki22jXoKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437821; c=relaxed/simple;
	bh=+c3CH9d8KGS/XUp65zZBRlrEGeqeKegUWcA3yfzFrxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFskMBmfpG2tLTLzOPpZLg86NRy8FjqFiY2N0n4e946ZMzNOGyN+JtDLyhZb3dJnZ/mSaimiLnHVfow+eCpWqI/qw2jW0ApUQuSvzDb4oSd16HT4WL/MirD2S7Nfc9HBviOgKAuKxkd/k4ldMVlGvmRAMQGQ9ufGU3ttSQ93ksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIxtui9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIxtui9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498401F00893;
	Tue, 15 Sep 2026 02:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437820;
	bh=CkfEMlFLhN/sbxL71ojsPKcieKhsUXtz6jDCBkdB4Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nIxtui9CIfF2rK+hNkvMECzx6UKJfxw7lkBsNSlFTW33XEJK2VhORJAOWx620m5Cb
	 yMKDgILWACHVsmSwi8eOyzWG+6XlF5YwXDuan+UbwGsekK8spz39xsTNiZo65UlOUD
	 ik2URpZSYkFnaGcZw6wdUOyt1+5EyJlt6q5VvyEgptgNYUFT5AyXEyzQJUZlVjxoGd
	 LZ2YIc0xbVtVfEGfupEqjcN1sHQTJMd0q8D2q5w80ts2N9KKcBZsWfieAiF4ZaBku4
	 RCDFV56YXQp2ETElCZVuil2pDp429mr1jyo3rqENdP0NmAmx5Aiu16AYsLFyZPyUAm
	 6ZMeruP0lUebA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linkinjeon@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: Re: [PATCH 6.18.y] ksmbd: defer oplock break until m_lock is released
Date: Mon, 14 Sep 2026 22:03:18 -0400
Message-ID: <daily-reply-0002-re-ksmbd-defer-oplock-break-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911151056.27965-1-suruurism@gmail.com>
References: <20260911151056.27965-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Port the deferred break machinery (oplock_break_add() and
> oplock_break_drain_none()) from the newer stable branches and make
> the three walks collect the breaks and drain them after releasing
> ci->m_lock, matching the 7.2.y and 6.12.y shape of the fix.

The code is fine, but Namjae's Ack came with a condition on how this is
presented: keep the upstream subject and describe it as a backport of
27a9bc968d4a ("ksmbd: don't hold ci->m_lock while waiting for a lease break
ack").

-- 
Thanks,
Sasha
