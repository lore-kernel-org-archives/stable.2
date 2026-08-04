Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468B2E2EEE;
	Tue,  4 Aug 2026 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805556; cv=none; b=f1lZT92L1Q8Kf2yYVtrfhlS0W/GbsGoU5/5/zgR2be3TbcghrXv31rLBOMGjIHXSTDTp9soJLB2A3t3/Sf6941X+Ot5+HIPCuXWKUcka1rVpDHEl+flfn2qJ51sP8tHv0HUWcHmftHmOickuGAwaxzf80xtQJqMW9Vi5WpfPeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805556; c=relaxed/simple;
	bh=zkqrnTpIFNK2eqTYrgfOssVj+yVLJsgRa8rME3Vd5AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6sH4jvdZ29gz/SspyGrotYr4hFt2JbkmrV/Qow29vqiw5T1OasKnMbQH4t8jSwFD5+lOjVEmGLXmFJXbVqF13oxyHhtMcPq1er4Ycb4kNlF6pCkr7F29Ry9DS5bSTrXxGYfw3vVWQxuM5NQpDu/ycDCF204w77cye466stmrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLGth6hH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLGth6hH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214DB1F00A3E;
	Tue,  4 Aug 2026 01:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785805555;
	bh=kmPUBoT1uuu7IHjK1MsaZi0W0KD3ZDmCmKX01nU+tzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BLGth6hHiXMPxQRrCcR/mSb2vD0jxpY/0R7J3FJZgemxncjvkQ8E/1tCpLwwqnmSF
	 HYVZTMW7duZYtXb7JcQjKPGwjvn4tkeI/Z+y/bG6k44FXE2AqvI+7u+xlWjNF/6rYq
	 /hAmmGSFV3QFy9xU2Dc5mTdz4cCFBdve+XyAXsanXQxaGa9ZHp61e6PXMu8KpXmK9b
	 kBI2631YXDe51mkjEmU+Ev5Y1kUaxg/DAm5wtsmkllHcX1RjkLDD73pDuOc8IOOS2O
	 x/gJ7AwZ9j6SKjDTqSIeuuYLzySK/wiEIkhzlctsFj29B74XO+r7nkR8YKQmP/OL3v
	 dRSLdIGXkJ0/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Boehme <markus.boehme@mailbox.org>,
	Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12] netconsole: avoid OOB reads, msg is not nul-terminated
Date: Mon,  3 Aug 2026 21:05:47 -0400
Message-ID: <20260803210504.stable-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803184129.24594-2-markus.boehme@mailbox.org>
References: <20260803184129.24594-2-markus.boehme@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 08:41:29PM +0200, Markus Boehme wrote:
>Subject: [PATCH 6.12] netconsole: avoid OOB reads, msg is not nul-terminated

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
