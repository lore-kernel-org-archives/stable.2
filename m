Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398F4ABBA9;
	Wed, 30 Sep 2026 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800719; cv=none; b=JcZJrKjKu3Oyxg/35SB+AEzOYT5Fhr5ODuVQ8d4hOoeNhJ/3EDwJJjc4S0jQVfYOgdgreQaTZaaPf6aZgTAQcEXR5BaP26QBOyXtA4YJaHfiZhnlE3OkPEtEC1X1CyuWE9JkhEyBROJi59MQcDBdgKu6vYDQ4UanVSoCGtGm4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800719; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tbwf6rMPbYTGaJ2OPSsx9qmTiQfLbjMZkq8S6J/DyrIs0tXh9X+4RMgrw6V2nqFUYBmG1e69qFeMRUa6XfiH51EeBQcIpHoSYmItUUIn4vAjcGkZL/H+51r9R8x1UCZV0mBXKgkw3dE/qa5fC4nlo93aq4Y98zBMDKAP4OgICP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHXzwrQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHXzwrQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572B71F000FF;
	Wed, 30 Sep 2026 20:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790800717;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GHXzwrQ6e6Fln8ttaqH8dB/tcFXCGOQxwxNYh8L6GCFgD1jjwSxHriUmm2CBXqgA5
	 0ya/34oTotZDVLoH0T14d0z7Zq1Qez+yvHJ82cXqRPEbhxpuvoltjjI7Ibx2VyTB44
	 +DIjrz+rryOvSU8MunfFsS+jj9FMSaIyEWpflGX/UWxroaJhA8TWLwHRLS5yxcpNsu
	 ZmRAUKpIk/ERpY/9Ae2zy9PCkzNstDMNcSmOIM5gk6el1RVVS5wKX72whyzX8sfqKB
	 fKAXUaAegIjBhT2jl7uZ/Slog4vRVUbuf8n5bdEwQaLvgw9sj7LOAGG59AO+Mnt0DZ
	 9hVTb3gCEBMKg==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] macsec: prevent AES-GCM nonce reuse after packet number wrap
Date: Wed, 30 Sep 2026 20:38:36 +0000
Message-ID: <179080071686.31693.6630251274230925732@kernel.org>
In-Reply-To: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
