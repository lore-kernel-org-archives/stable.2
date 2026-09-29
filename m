Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653E560ABD;
	Tue, 29 Sep 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707875; cv=none; b=JoiIXKdCfi6zFq8p6dSeJfEOTEpO+/W3k3RMTMqpKWcGUKlnE4IsHrLRzqQQMcqL+5tPcAIy7iBycahI3mQuLlIVd3jevbN5D9qa52U0vObIoYxh8ZlKi7imi2cw3hUx8IgdGFgZw11VVoww5MLfaF8odfhVsdC1IbI7XnOvryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707875; c=relaxed/simple;
	bh=2AKEd8ickgoIIQuv9EjCJAnoc0hhWDCJ8mIaPvsu5vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qky1es4iIHTVoTF/S+COF/cb41nYg3Gr59aphv3H3OOGe69gQz3UBGZfvC/KxflAdQZkUPMtDp2SrdbAhFdIdmqmii9SbcyoS24eifgD8Zjl7F6XnHNxCsCleuZunH1ojBuoaolc6lPIYXbXFtBw8RMOWRNLdv4F7zyoOcMASHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk2XoWII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk2XoWII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556101F000FF;
	Tue, 29 Sep 2026 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707871;
	bh=uOwy2R9ycU/4Vrle3YkExgT8YD1TJOiSb3ryhwkzJ5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tk2XoWIIx0Ha0Yzpc/XL3tHAatTmYDESctgQ6FqkVwiw+S0Q5hFAyVQKa9Ek4KsVK
	 9cHZcM5Jc0IGZIKIbO+bGP8xXSt2sQN98bBsiAu8hLHdJl7Bky/0O0EzyzwCle4xyi
	 THMmznIxEY2C370gkSDhgoVfAJlPGdFkuXoEeu7Wsjmg/e5kO3r9R/m6u5FRKVdPCR
	 sC55ONyyImmw2oHrXdMaxi83fH1eFKtDLH50q7vuC0SflIEqy4P9rTwegfy9fsp1Zu
	 u/bpNZ2gscdP6QmECx+2NZM97r3s/iKxfx41vk7q856WoZsyv9IVtVuQ0LKkfBmJeo
	 +Ed4qyjRMFfaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_jjohnson@quicinc.com
Subject: Re: [PATCH 6.6.y 0/2] wifi: ath12k: backport CVE-2024-40979 fixes
Date: Tue, 29 Sep 2026 14:50:50 -0400
Message-ID: <2026-09-29-daily-reply-0007-re-ath12k-cve-2024-40979-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929025856.85683-1-artem@trailofbits.com>
References: <20260929025856.85683-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> These patches are a backport for CVE-2024-40979 on 6.6.y.
> The second patch depends on the first, so I kept the upstream ordering
> instead of folding either change into the other.

Queued the pair for 6.6, thanks.

-- 
Thanks,
Sasha
