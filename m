Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E010A3019BA
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937121; cv=none; b=i291Og2SNRYQECH3fcy2zjUQxUuQ39aOnLUUybC77ngEsxjFC/xAzmoj+gCwpmdSttcFtSohlQ+J0FebXa5oGKn9/PDG8qifF8hfXE7f92I7JiUkOkKlyvrZS2ODKiFbM81D9YQSXPKogt284mDids0WctfSAwhgBo1+KvdeAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937121; c=relaxed/simple;
	bh=T9DPgy72ZaoTAsV67cy8maddiZmd09+8aMKxKiewqXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFzY7KMCQfTNT/gF+gkp8PbML5ftbrX5Kv2/4hN6RH58zt5LJ/rakI65NfL4fPiSF7ZyYIubd5QWbL9ExpcwyEIIBmOuEDwrf+eceQcSBzMcDJ2KtVBJNRavbPRyk1zawtK0AsJDF6ZmyjtlDMKEG7eqwc1UlPeadZphxIYo0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lau+eOIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lau+eOIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CA51F000E9;
	Mon, 17 Aug 2026 03:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786937120;
	bh=O22P+cgRcVY7RvX5X/o7aOtGMArlnXXVZLfgPkUMYG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lau+eOIw/0G5EtHiiXJQ/QFi2Jb0kT3yLWUDZc+nUQprMa0MOJXJYplq3lKI2o7k1
	 NB16l1izlH/AaMZS35M0bGHMtpPgpa3uhD8WZ7cNeap20QrY5ZQht854rjrwaGt9uP
	 TGU8/6ugy0EwAAuIecxeQoLYEVlW+SnJqfa5+sN1lpC3uoUsWQh1zP864EPP9GEFrH
	 cNCitbh7kjdWEoMkrwl4aDRwJP6q4lVxa55iy1Rr3hCVAGn/GU2SGCXqAzDVjRqw2Z
	 /qzkaYQk053w0GXJDjhSuPogczHJD6DY4UV8q1cOQNISvdULgokQ0hH5ZlbszYiIp9
	 vCqY/7GehDT0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	nasm <n4sm@protonmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 5.10.y,5.15.y,6.1.y] RDMA/rxe: Fix a use-after-free problem in rxe_mmap
Date: Sun, 16 Aug 2026 23:25:07 -0400
Message-ID: <20260816211000.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814202359.654631-1-harshit.m.mogalapalli@oracle.com>
References: <20260814202359.654631-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 35744ab3d03c5fca8c1752f53fc8fc674e14c561 ]
>
> rxe_mmap() removes a rxe_mmap_info struct from the pending_mmaps list
> and releases pending_lock while the struct's kref is still at 1:

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
