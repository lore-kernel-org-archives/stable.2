Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4170392C3D;
	Wed,  7 Oct 2026 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404341; cv=none; b=o147d2LQ0jpV98ExQ9lzuqz6LHQD4TcSOlcRK8WLs1+pIorX1guMyv82WJlHNHNELKTgKgL8w2lOEyBdAqoefGf6R940eKe2vhcnbAPJ1UnUznENudj7ZUKwrxdWE4LvCVLYmoC4e9UngbhhfVlP3UF4/jGDro+PkLV2unKlICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404341; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnjxDF7w2aFqpQaRHkMjd4CPvuGWnB0cSb2LHvvNIQhOrZC11ijAdXc208KsPk8rNkD8JovGMyQjenn4ErZ5XYMoekPKN1ulBz+0/pWI6mubMwgtIpa/iiXyI2r2cKO312GVeCc1/IxNgZhzywpOrC6d7nZWSJsOENO0qLcM7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnLKMkmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnLKMkmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECF71F00893;
	Wed,  7 Oct 2026 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791404339;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnLKMkmx2EpIhgmcOwstvFPMK+Kin4RwOLJEaZiPeRWS5jprdTb0P0ZMkKCYUBnPR
	 ICA6R3BRYXNIXDKZxmU/FbrpwQTqlrp2yau5QN9uvicf8kwDWURkYcCPs8qXTYDOtS
	 lQTN7j/Glhg48KXDE9/J1Isnx90OyIKOQdWt5DX8TTV1/wEkHLGyzFybbnijLZGzLI
	 J+1SK18g6lKhZDVChgcteMf/W5CL6M2h7UDHzLBG3DROWrVwBccHYM71PgSUb9RrAe
	 XH4R0W+9TkNfpIsmCWx7plLNThPn5fgg+nO56PIoANnFhaCuhIxNzsX8pF2cI8EGBw
	 zjQnKfjWUPqsg==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mpls: unregister sysctls before network device teardown
Date: Wed, 07 Oct 2026 20:18:58 +0000
Message-ID: <179140433879.2527009.7621564864270726480@kernel.org>
In-Reply-To: <20261007201237.171863-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261007201237.171863-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
