Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAA3AB28E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490407; cv=none; b=DbTOMoaT8DTsY/7hbt87JVC4Dl32/IEQPM+4Hy6dJUQGyspqUR+FrkXBujmXF2Y1bGo29MzaoeYbrkdLAxsO6tZQ5KC+aR7SxF+vWsF9J1BLlV92JFeei4uvibfftcfSTzoqmySTf2H907F2YthLMd/J0gERsNoMsMrQlDZNB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490407; c=relaxed/simple;
	bh=L+Lvkudm7xe7ScBBC2wxW0vqJW+XqzNKmUuHCBpkNyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUUwrcstHcb4zCScHT3d8XonT+B8N6txx1LIbGky6z7CAx1cSx/ZqBbroiLuRXjRtYNVVjHACiEyexH9qejRmQZ+6xuAbQzN9F3GHoOa3VylewDXVReSldv+Fb6wtOa0+0XeQAcbItZCo1zakmBqjk4Wnh2+gdtTjstQiuZjtns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSO31WBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSO31WBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083B31F00A3E;
	Fri,  4 Sep 2026 02:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490403;
	bh=Vawfy25VSPCZnQAf7dqA+MHBe0OVt0XmPdgJCgSAmRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SSO31WBuTausjj4USnqaGrTFYFa2f9NZTKLgrKskVbFhA2dpig4bjRssPn3CyiSzo
	 /wPqG6+NnaNlmeeznKSE8h6V7wTV332MDm9IVwiKEUpYHBYXO9AAxcQPHrRqhRqb0S
	 yUwiSWWE6fh3COAIk2773DJtruDQ6yaQFyjEk5P0VQaE/baYjRo4/f6K1c1EJWlrXF
	 Y1uLeP+PVAlKAhXc3VtFN+TGisUQbOrYDWPvNGw++gOPVXty7DIAuS4m7RoDqjfBqI
	 bh/nEiP6RZySMnpzzcr0MUaPHKWiHtg5Yx+uH3QTuAiOyIGsKF0H74He34D/SxyEQz
	 6WTTlY8gyN9Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Burak Emir <burak.emir@gmail.com>
Subject: Re: [PATCH 6.18.y] rust: rust_is_available: warn for `bindgen` < 0.72.1 && libclang >= 22
Date: Thu,  3 Sep 2026 22:52:57 -0400
Message-ID: <20260903-daily-reply-0005-re-rust-bindgen-libclang22-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903181837.12025-1-ojeda@kernel.org>
References: <20260903181837.12025-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This was fixed in `bindgen` 0.72.1 [3].

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
