Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8842E42B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125686; cv=none; b=eu9BwD4HHwVP0zRYPLA4kUPjGUZaWgVb19HXR1OIN64iK9Uz5ZApSeNbd8LJt1Ujt82Zziqqc7NkjSb/VwRZ21LamXiC4UoUOi3TiKmYBFSRu71hN6rvlq2mwi6uj1OOS5rrIPw0vkSf6a2gwTB6qEBBN2BBclDk9RXLBFfBtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125686; c=relaxed/simple;
	bh=9sUxNEskW/DA0jxPjD3+dhFmoMzZ1VwXC72/DHdv7Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doL0LzcdIn6PyRMGCcxntr6RAbtMbOl7g2UOzG2NHnPmbn97lPakmk2lNY6W3kKS4GQgsH2JY1yWvCL6DOgWye1ykgj2fFfcS3fxw+1UWRMwqluS3H/BC6Nqs41btyJ+V0egiY1qMYCWs2bcxH0MZRShS6jNvjJqSAQOJMVAYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxLaLuSU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxLaLuSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A9C1F00899;
	Fri, 11 Sep 2026 11:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125680;
	bh=Tx71kNvVRBO/zIx4tDTHr+NYLHJ17Nz7eTMbyzSECVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WxLaLuSUd/t/3GUTlf6t6R+iENb1Jyj6PkiU1pCtiz4yW9ebBfTvPL+bwKneOfq0L
	 8giLbULVCBufI8MIGvemMQQTmPJUiizC6sh3xNaji70lWs3/LFbdHrQNSny9Ax9Rmt
	 zA7i0ZOYBgk6TjkrDfKDmCwd3enTMxh4X1ZSxpsvZ5V23g+QlLUZYKMrGsF0HHptCQ
	 StBD5hF+C5cjwpRhH8KuREVo66E8eGbGxDtx+hHYDgP+OcigUfGnSUkspMAqE6CBpa
	 L2CqMEFZbNy0GPawm3H95E+6T7NFIQzetFwQBEkp6cW1eMyvIlZJ+wIhRkTIadL9wk
	 TWzdbeBUhGxZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.10.y] batman-adv: bla: avoid CRC corruption due to parallel claim add
Date: Fri, 11 Sep 2026 07:20:40 -0400
Message-ID: <daily-reply-0021-re-batman-adv-bla-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909191528.1168924-1-sven@narfation.org>
References: <20260909191528.1168924-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 08645ab95768b88e2ff85a89211994651710465b upstream.
>
> batadv_bla_add_claim() is used to add claims and modify the backbone
> of claims for CLAIM frames from remote backbones and local packets.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
