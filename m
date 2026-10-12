Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAF2F90C5;
	Mon, 12 Oct 2026 04:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778817; cv=none; b=OEe1KSfsrFVVKR9Ax+ar3HFMNDHYV5hVCfEA7QRc/oTGsca2FYa3+Z/qOLRJAWbIkJUxPvMAofoXtIchdzTdYfd82OsJ+jN0jPwYfxM3f4lAfKEMzz2MwlxiYX89dAXApKUGIzsaTKFWvVMXHHSh3deNlRFjeKwY/bLesGAG07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778817; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwGvMEP93F1WlL3LXwF4QvbTJWp3HsvMBAJUnmI9DG/ODSQmXbtu9kmH5Q0lHXEJJtwEqU7lFgYGEK1KY4mVyPgV0YOIBhglG9aHXWYezoW8oV+JyGap30HVox1oEQNFZtkhU1WmhjQ5zqhP2aStJ8ZOSM4l7QBMVB1V/o+9lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krr6Smb5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krr6Smb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F871F0089B;
	Mon, 12 Oct 2026 04:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791778816;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Krr6Smb5DTw75eGL09iYZekDNw8dvwY1H/OWKLmzfuWs5z6LL6qpVOBSwwY7uDwE/
	 4LCcNss+h1UFc5ZAtmj5zqmIR89AMFqCEqzT/KM2pVFPP2pL2ozUPUZ6Rt83fEE1us
	 IldfD8pzbtdrQJzH5vLTMViI+UUSc5dRYygacM2sBNY2pFIWjaonoyanEY/rdU6MPC
	 JWaxYXWw+ES+H7VFQFIsanHudMko4UJ30WqYg2kEAtyPkMNMDrfS/E8cjTaPuKE2wT
	 Nn3hloeWQh4I2eqaDKUyd8NfZBfXhUDnQ1DGR1WQzFg1/y5XW6gC9fIvts++ZuO/1B
	 cateCGUPgW3Fg==
From: netdev-bot+sinfo@kernel.org
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-team@meta.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Dimitri Daskalakis <daskald@meta.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v3 0/5] eth: fbnic: harden Rx and Tx completion handling
Date: Mon, 12 Oct 2026 04:20:15 +0000
Message-ID: <179177881542.2527009.15617337640537625893@kernel.org>
In-Reply-To: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
