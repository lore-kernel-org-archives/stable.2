Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF42AD37
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744159; cv=none; b=CVJyOIilcs+2PVs2wt8GLxRfMKWB9lN/AHIKdy2k4kqJZ6HzOgan2dhZQ+wenJfQGvg900cSxsITN5ANZBLf/+S/MIDox5/9i2fleD8mzx3J4VSjAWB8VUl9Qb5Cjv1tE+HP9aHMEaGPWNo6RmfW/1XG9Nl2pjL7EAflXZGn5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744159; c=relaxed/simple;
	bh=MOM7HsfmS2zaxMhNHCsvCEyuPd7bzr5BdWWkTLQINXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGsyekDSYLKTpFZQK7tmsC2CxrAIBe2YBlZ7pNYegPeX6uyEy+oJWkDu+ng+Y5isqAQjIYXFYh66S5rWXEzaHmVXh/DE2meOKYEtoZ1RWIVTKMTF1n2O/GQS1v9AX5imGPYgEPTofGKlLCwxowVfBpXWoj6Q4LRkANhjgKD8t78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJa+Pdlo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJa+Pdlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E551F00A3A;
	Mon,  7 Sep 2026 01:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788744158;
	bh=1xClWAvUAZiW+kqng2+2xWcRR9Nr/qJbLGiovgKeuiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XJa+PdloEgfepw4fWKWCt5vDguG3ZZnvni6xlc0+2hZZP+8ZtP7p5D/n8+iV0jsVw
	 nBwNnIpzJuFj7ed9LSnu3Nba14C02uQ8yVG7WhgaOKnBiuZRPc/6sttQ6xr0zFs9QJ
	 eVJ4zYAsQjKN1LNUTUY65UNd+1elAY6a20+m7IxMu80LYtY2hznzlJQXtT2BRz2wLK
	 cev+h6VgQ6onJmS008nuE/9qzL0zPBsxtTypB2I7/dgqOrrfPsZ53uSjAZ5R7e40El
	 F30u+Rj2u93v1BjPGAlEH/rnoklWNGz0Dw1O87h2pMBr1QLawKEvJjAvUhnHgJOd0e
	 uJYTjYHCmNpUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	lee@kernel.org,
	Ali Ahmet Memis <ali@iusegentoo.com>,
	=?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
Subject: Re: [PATCH 6.18.y] mfd: qnap-mcu: keep the reply buffer alive past a command timeout
Date: Sun,  6 Sep 2026 21:22:31 -0400
Message-ID: <2026-09-06-daily-reply-0001-qnap-mcu-buffer@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906101457.671435-1-aliamemis@disroot.org>
References: <20260906101457.671435-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 47504742cea7878ebd1bf1491bbed923df6b90b1 upstream.
>
> Move the receive buffer into struct qnap_mcu. It is 37 bytes and the
> structure is devm_kzalloc()ed, so it lives as long as the driver, and a
> late write lands in memory that is still valid and is reinitialized by
> the next command. bus_lock keeps commands from sharing it.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
