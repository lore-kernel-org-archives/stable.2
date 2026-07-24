Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF63431E4A
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892176; cv=none; b=QO47x9B0Rmm5HSHRjLZpZoDVsUzZhvpd4ouYHJ9mFldzXHNoti+4v5uRJl5WsnKuJ4nIltRwdtU3fqmnAqdH2twY/+Pc2qMM6R0bQlz+Ur82XHjsXKYN1tMb0r4uJptAOrRCwvbRvuV2b9qb1W0nQmXa+xkyfCIVWX7yJxJWJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892176; c=relaxed/simple;
	bh=yJ77XIYdJdEjrvQRf8qzTDG2mVOts5bKGRL2HWq5TFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ6A6ApV8zaRrlFVtVi9mT5+Yb7Mprm8MC4YNK5+XofrasbcRGfUCya1yCkogRuSLZz5nTk18xNWwW5TNlVELbRU3jortaSxJ/amdttobYNBIrZosiw1RW1dbzuPP1YWz6LD8KsEsYnLzZcoMh6A2NVUEzIrcXZ7cBvlbLnnDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZVE3DqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZVE3DqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61571F00A3A;
	Fri, 24 Jul 2026 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892174;
	bh=23LWI8Y5gPiFR4yzfDcBYyNbYfF8nhIANHopekXlILg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZVE3DqHn4KATkM331vEmNgDVOBmkSJ5+hRClbD8HQCV4ryAnaIgQa/fqSgripQEq
	 2/FCyYENa8LNvAiCgH+vVmXBu1C1h6fcTPl3yTIxYV0htbDVwG0HdkMyunWQlVb9Ut
	 it/Z4OJ/OYziEQsGGJ0Oazw05PAjgKscI2FU8uFUEkhEGznq5yA0o9xx7+WkxNscaO
	 KwEGJddabPLPX/I3ch586LCvnVp4N3dboNBlJs6b4JxgDPAmq5bkH5sTx3ctshYu3B
	 mZ6P8IjpIuNbCex+dkl8NwJDjrrGfS2KiWP2WlF7RBxyS391DIRFjoN13sxIJQlClP
	 AcvCOpjAkQhhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	kuniyu@google.com,
	kuba@kernel.org,
	sysroot314@gmail.com,
	Jay Wang <wanjay@amazon.com>
Subject: Re: [PATCH 6.1.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Fri, 24 Jul 2026 07:22:38 -0400
Message-ID: <20260724105500.stable-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722002709.12710-1-wanjay@amazon.com>
References: <20260722002709.12710-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Igor Ushakov reported that unix_gc() could run with gc_in_progress
> being false if the work is scheduled while running:

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
