Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F9563FB8
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996814; cv=none; b=pAdnF8xtJeEzvSnS6EjhqmihoBrnzG4mdGQDN20x8UmORlrOBMd8YaC5SFWUrvACj6J78TE6vWuCT1vWcQ8HDNbU3+6qUsPhfAzFZ8492zubvH2Bgc40i33yU99bduV04AejHbVUgFyDK+jQCaDe48ir9OXXlfr+E7tWY2Q3U00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996814; c=relaxed/simple;
	bh=S57ZnLuNMF6mIYO83OaectVQ7c4debPFd2RtjReG46I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2yXGsSOpEk4ai+IqpzBiZOxp8iea4+nUWKJaP9L1J3O36L8UxY9PK1HFr3XJt3ScbNbp/XXt9Y7pK0WyWmVZXP1N6x4mllnRwCZqIGEZs42NnSz5iYOa0q5m2NdZpNAhxvuPAo7GheMBiEjWzKlunL3i/iMgCr6FmLfeiIeoJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih8mvnIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih8mvnIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964DA1F000C7;
	Wed, 14 Oct 2026 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996813;
	bh=B7H61ZgZLp4YICXjgyYTbLewNJLn8PvljkpJNHVAvW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ih8mvnItso5fC20ce9yDPcRYYt346kex5P0sRmPmgJKyDGJqTOdhNmDXLu1Gxz79G
	 KOQ+HDQzjQ5sM5L0rUIbWmE9df8rGBBdEqiWcjtiDn7X+mIbWA/r6SN6LESTc7ZNbj
	 s9ddlOeeS8aAV1YsH1hqlWduljpQDiFzBx9tOknCtql70jIq6mNERW6QRqSDfp+Tmc
	 tv7nZSj/mDDCZ00+8M50NQis+IkD0ONu/3rm8OpPZQXWPDzpZ3TNkBFl0XosgfReKH
	 UwGnpzNor6deKrdnH4DsDFCH8XXirBOZgn+orv3wQWva1yOxNB/33dENZ9YekT2BSg
	 1O1K33uYdk9gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 6.1.y] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
Date: Wed, 14 Oct 2026 12:53:15 -0400
Message-ID: <2026-10-14-1-daily-reply-0012-mremap-dontunmap-self-merge-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013165904.2517439-1-ljs@kernel.org>
References: <20261013165904.2517439-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix another of these - self-merge.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
