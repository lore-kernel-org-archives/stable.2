Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79512D77E6
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346907; cv=none; b=bgudLyePVu+BZ2pKEPHKSXzW3jcXf2oQ9vZjb0jk/f9JZaq22OYOSUn5Ox34CtHNW8zKHqAZj+f0NKNWcZH4MDWjOXAjw9wGooWDwGeDU8pbhcxkjLOrk/Za3ZlZ6Eg+rW31Mm/Dt/zWY8q+i3fqbWTJwIaUjO0AZ5JubxYwxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346907; c=relaxed/simple;
	bh=A2wEBq7haRvyyYFDduzvrF3a7EoG3ML2m5Z5pdX6ODk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mukTnDeH+ru9mFToS96yu6JBmVzveBTUPLoEKJNZFhv8KG3kDdbXgacw8yVkcyLyu/PgO3K8kPJYF6Yfs5AS4Yh3iCtUORazMZvm3aKT5u5DuIakzcBU97FjrhC5nW28fP1rRBcTWMWf59fG89iYQGH1pDTzGZmiuFxLmn77e7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW9xBX/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW9xBX/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79D01F000E9;
	Mon,  6 Jul 2026 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346906;
	bh=FBzjemYg90Nxn5nzt/y7u04GheU+ePAAh3kEJQJo2ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GW9xBX/g6QHrKqfW8MYauZDpoDTCR7YBHaIBjgNuzXmvEuCSHGXiV9vYfcrGzxi9/
	 CO93GJDFm5YJGicwutNfou98kDS/AOXs4/7lH/Jg9ykmWuVvQBxWdBYmsomHip651l
	 9JzXSxndvqiuswfE18EL5w2JhoUY1SqFnCq2gmRye1H85VSzN9JvbrAGInscHvpJNd
	 14FppeuXsclcsyfnl219gKr9KNOt5wPRQ/mUVvWHTDr9fv/kmXEEPvSwHJ2RWLRUn2
	 WRBWWVuCA0zSCSBPC+bJLaZutCs/idls1ZvYzPKxoE18vI6xtxaJ6q48o3kGx5P9ur
	 IQlGBfID+N+Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ron Economos <re@w6rz.net>
Subject: Re: [PATCH 6.12.y] drm/amd: Fix set but not used warnings
Date: Mon,  6 Jul 2026 10:08:17 -0400
Message-ID: <20260706135124.draft-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706044046.1099672-1-re@w6rz.net>
References: <20260706044046.1099672-1-re@w6rz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 46791d147d3ab3262298478106ef2a52fc7192e2 ]
>
> There are many set but not used warnings under drivers/gpu/drm/amd when
> compiling with the latest upstream mainline GCC:

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
