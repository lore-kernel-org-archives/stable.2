Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B92E401
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974491; cv=none; b=MGsJN3xB+d8lRVcPZCFxk4tZDyVoY09Tdxb1QOhFkqd+NbjQVGjrogar20qQ942PkpU14C4QQ5FdVjoR1EvnfljbOpXEbc7ieY+nktou6U2nYYv1UKKkq5iz/Kv94yqToS1ZQKqLmB9mPardzbj12vcQwGsgPjvljFJ2HUnX4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974491; c=relaxed/simple;
	bh=0QCU1TV3wxPkPR8yoEUVZ3rP+dY37yoq42hubPC9Ckg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBWEmlH6r8i4xRnmx2XhTxM6JA082PQXc2k/1Iv6GLAbi35rtBZvK3ZEsz3bKJYT4WxnYcrG2fBAqsSNXtqufQJ9Dmyx+LMpydIfAvfm02HsuoWMqdRwgD2uuF/Izqu8mxm9N/arVXpI7z5v21FNFSOKC0bBzsR1gnOxJd28tNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaMIajmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaMIajmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0132A1F00A3D;
	Sat, 29 Aug 2026 03:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974490;
	bh=bmOThtCGZ+vwSdMUhMH1B9zAc4KTzXgxJFYO/RN62IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaMIajmUN3p9mAuJnizpwBQ8TtWtELdpSW+c8P9UjqgWoH2VNuB/F33ahZ6DO0eZM
	 FU/wf7cWUY77jGAQ18gfyLe/DpcGfqaKNmG/fu/QB9pPuZrhU3sQJ0COSjr0nNPUqP
	 2yBbWhgKWLKteJQnzMacyNLH+yEr5ZAy9cOIT4IUH1xq9jFAYy/gkjagex7P1fP9Mo
	 NvfYeOQ8wxHKFRwG9M5nn3DJWvzIBsMep874bMc/ITVxF/FpbrX9SRgK3yrxVNPMeR
	 4wx4ycsBOXU1yom8lVcYpzn4MfhaWriwBoJxjdxAkwsnvUTrg6n/nyRDBs/NjN/7r+
	 K8WgDID5i0n2w==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 7.1.y 0/5] Backport bugfixes for selinux
Date: Fri, 28 Aug 2026 23:34:36 -0400
Message-ID: <20260828-stable-daily-0005-selinux-7-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827175144.4174620-1-guanwentao@uniontech.com>
References: <20260827175144.4174620-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> changelog v2:
> Rebase on v7.1.10, and explain what and why the first commit need be reverted.

Queued the series for 7.1, thanks.

-- 
Thanks,
Sasha
