Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C441A923
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407052; cv=none; b=OPZEc0cX1KW1V98ZfFpTHuLjfQSikjXGfcf0mJTsrrSjfvozsCG2TIfAeieqaoehz5AYf8Ru8HB9J10+f5m/ZQVk/hLmIxYMv/Qccg95hor7ptUptEHyJtspLvUYmVsIRsedWcvywWLLUIOgz2mYEMQwGWfY9eX8Pp0lk4zpQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407052; c=relaxed/simple;
	bh=aXQMVws8NEOcopKwlDKAlHm/cxYGVXWq/LVxNX5+5II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqYUKqHGo1FzQdyfLff0yZGhCxMbfOx/GG0IFO47Yk8KXPTZAfkGj4Ki4cDiTiDpV6N/WIaHGifTuGwZEpMab+sdfCtSbuFQNVDKZCSQyDkwuEnXpItTLr324/BeGlgJ5oeDqoPycjKJS0zhW8On/Gn/bPAc3F4qoaKyh2NshoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1pMQaA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1pMQaA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB55C1F00893;
	Wed,  7 Oct 2026 21:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407051;
	bh=2EJs/j6UCs/72KYfvLPxDwUMYmrOBhSj2vNnOxqUgwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X1pMQaA9a0juxOjvfn8fHIdU5jcvVlewRJDm/66Rn2n5owpDe3YZxgKWQeRfmcf+m
	 JmT5FgNPRCfVSobLDe/QPx8kGdiKiBeAALZ9ykkwKKrrI/VyHV9Wv3HSm6+Sh5D6Gl
	 77hOHOH1kak0gtxKq8b7aKecXcTsH3Wjlq7ZC2RbXfTovdkbYQhRIPAAeNMg6QTvR8
	 DvmLBVGstunBHeD6bArd+3h0jkylGFTsmG8DfUxkaOV5B0OaukERtB9O4YYjWer8xn
	 45gmelTYPXZNkyPBI2mlYtjBV9BLD/Hl67+btk0bbCVpXzAOJXm0ZERuOa+vOCUwp2
	 9E/JeesSsB9Gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 6.6.y] KVM: arm64: Don't use the VMA to size stage-2 block mappings for VM_PFNMAP
Date: Wed,  7 Oct 2026 17:03:32 -0400
Message-ID: <2026-10-07-1-daily-reply-0015-kvm-arm64-pfnmap-block-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006133359.3163466-1-smostafa@google.com>
References: <20261006133359.3163466-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> get_vma_page_shift() derives the stage-2 block size for VM_PFNMAP VMAs
> from the VMA layout alone, which does not necessarily match what
> stage-1 maps for that VMA.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
