Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2873290AD
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858203; cv=none; b=khGXVHVd3k0iB2jkTdlsr2Try7UYf2WAPoF/+Jb21uvnkAG8/ma6zBP2CcxN2LlhuivC8izQW6VE7iH3GkWv3Kb5cS+y0LUy0cJJH+oA1RqGReLZwfoVpvNda/TkNW2C79ngYGgznvKDmbfi147iW4CljIS+10q+wQwl5TQ3/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858203; c=relaxed/simple;
	bh=dIxuY27GH9H66IR1F710Ta6hV31rXYA6c3/+TRjGgBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjvzG/IPcLeeulIjR0d0GfsMSMVzz7EyO+c90U/XYZpNhal2xSNHseLBEYrfQNrVOFsKr10/8zHYf6pwoETQbW0zDkgPz+5g6yDwniuwFiOcMeKlSszlwu6xzJY7eVPBDCr7u9YcBRcD97UgwnJbsYX8Qv0OulEwE4jIcmWPqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHd/c+0r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHd/c+0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C261F000E9;
	Tue, 30 Jun 2026 22:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858201;
	bh=dIxuY27GH9H66IR1F710Ta6hV31rXYA6c3/+TRjGgBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WHd/c+0rvNgkI8iGQD0ZaD8+h/Hs2F72UOlqWRAEKFfMlePPRVcvymspxTHQwsbfb
	 vp0D21QYCxp8evfrrCWYzKcM6j/PZXQycI1GM8q2wGUMapH8RyNpAb1Ds+Ft/SKXww
	 xuqfAcBgs2qYJVRQ47r7iAdbbyI71oZ+lrWQWtsJtLx8KFDB2eHr+FgReNQJo+od7u
	 G0ZV3hl4sCV08Req4XJ2vYBUHl5S875aZopt4HL30+6aykFTrInuzir/fFn/XBfxlU
	 xzBr8i98X8nTh9yYrrv+1wZ69DiNTz2pSOttY2LxPVLSQZC4r7bM/uo6FjBz1ea8mH
	 ESrshPY+dyY2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	mst@redhat.com,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Annie Kim <pulpannie@gmail.com>
Subject: Re: [LTS Backport Request] Fix RSS indirection table OOB write (6.1.y, 6.6.y)
Date: Tue, 30 Jun 2026 18:23:12 -0400
Message-ID: <stable-reply-item007-virtio-rss-20260630181642@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com>
References: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The canonical fix is the upstream commit 86a48a00efdf, which makes the
> indirection table dynamically sized. Please apply 86a48a00efdf to
> 6.6.y and 6.1.y.

Could you send a tested backport please?

--
Thanks,
Sasha
