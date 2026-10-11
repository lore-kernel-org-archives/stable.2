Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531843546C0;
	Sun, 11 Oct 2026 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737314; cv=none; b=pAtAoeosDH8q4P+It1315RmpscKMxOWToSD5NvCHupVnAidxLcpNbYjWEoQJcDBG0oMjzEKKRmvx5HkvlZ/8gGol9Gkon7DPaLTw9ojRLZavG/lGOF5PQmfohVQZxad7mp4zla3nRmaAweesl1P1Qf+Uw3cI1jFaZmjNnet7D2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737314; c=relaxed/simple;
	bh=StWPMRXuvadY3Y4tTwa5jhAmqb0Xm1tJ+HFtSjbcfa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBacttz9tQKn4a/MqimKdqkazhEMvLqAeEz3JN3atgMmxiU/mb8LWEjWZmjxxLjqV2xdd4Qpepq8NpdVQAsMOLmjJRT160ZwbUu1X0IwZfAT+njRA9JELMy9hsoquRE3PJyb/iHqEnzoRenQS78gLJOeRcekUvL4zNY6aQvvavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/l7nrrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/l7nrrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842DA1F0089B;
	Sun, 11 Oct 2026 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737313;
	bh=jwTxdTC03rBUMEsWRjGh8nHduP43ajisOpGm/Tz7pGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F/l7nrrB+DEQr7aBzDPClmGFWUzue/KbryR6MzbH8PKWtcHSX2wgrdbWBNcXPyQbg
	 ol4Wj/FC7gaQH795J0JRLqxXG6bkRlFgCmNNenFBqrZgxlkCLPWntf+UYn9zUOZw35
	 DG2RMDjJrh8ydNGk2zVfzdV3JAfe79PFLSUGqcBXhM+lrRmYhwyRU2xQ9XWbUfVcQl
	 9W/hKgCdA5GB+5UmZ2nCmE3Q1dSHIhMF3d7PLbhM1TMK9Eup/T4J9eV64KK2wyfXcR
	 W+x3NIBTrwrQW10gHCJ+yjAUBex0Ft/tPCiqchN26VgZQzhmNTXYk7WztI7igB+KKQ
	 2yow4y/DiIYPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Nikita Nagornyi <nagornyi@amazon.de>
Subject: Re: [PATCH 6.1.y v2 0/4] fs/ntfs3: backport slab-out-of-bounds fix (CVE-2026-90048)
Date: Sun, 11 Oct 2026 12:48:10 -0400
Message-ID: <2026-10-11-1-daily-reply-0003-ntfs3-slab-oob-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009135415.850568-1-nagornyi@amazon.de>
References: <20261009135415.850568-1-nagornyi@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series backports the fix for a slab-out-of-bounds write in the ntfs3
> driver (CVE-2026-90048, an Important / CVSS 7.8 issue) to 6.1.y, together
> with its stable dependency chain.

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
