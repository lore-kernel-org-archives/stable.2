Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86241FD4
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701626; cv=none; b=UoXF83fu6MwgM7dBLZF+M7THk8nZdG3V6sPOrmBj2LkoQq6f8m2KwYIzYBjLif1kzj6zWHB6FcFprARLpL3daXwXRoEpRSFo0qpVsCZ6IMWBTW7zz1G6rBINaobGqp0h1osz/wwooox8KBEkFl51uFjAvSGuHIhwFIoujTU/P8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701626; c=relaxed/simple;
	bh=JppSqByEfGb5bIA+1yD6juOPJ/sRLzc++6pDddrEUyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuvZXs794Q5hDR2S1eJzSmmQ7vtOMwM7c26iEi3obdi+1NvTmGLgdC2Y9TxNsCLGYltdQcc6xd9eS+vbxmYoSwD9XxYjHQn4EOZfGFigX2JLuspxg/SO2OEPKKXjhiHFYC23OxCsB0d36/jvI/IsMoxNxZhQBDBKvsryreY8Dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtNNO7IE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtNNO7IE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC1B1F00ACF;
	Sun,  6 Sep 2026 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701623;
	bh=66Lg2aCmxVLycyA07QDY2Ksm2pg1/3VNJ1xyttevnhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HtNNO7IEGpWqL11tATGviJL7Xy9j8pd9l+TjtJA1JLLOcUd4zo8q3ssBAY6IfjGt+
	 BAJHgZ5SyRxK2wAyBOtexBAabBbtDrSgW12GHxmYa3odAIqLpL8aMc7qQ/GdOsLYA0
	 wVu/xvJH3aNkFicka9A1xNCyjUSDxlkKq8lODpOea3qjg1R5tmVDvHgL7/rlDOc6rI
	 0mD0Ef8B+NvSkl8qwjJpU5ykhGRPyVcNpvxRKu8lRGMf55nSKkRhKOD8yEnPP6MCXi
	 Ir2sZj9KqgP2/YKWSc9WfdpjFQFDtdnTkzbKc3Fvb5PjQ/MQfN8QWdYcS6PiOqBlSX
	 eNQuVS21gTZMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: Re: [PATCH 6.6.y] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
Date: Sun,  6 Sep 2026 09:32:49 -0400
Message-ID: <2026-09-05-daily-reply-0019-landlock-whiteout-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904184212.257136-1-gnoack3000@gmail.com>
References: <20260904184212.257136-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Whiteout objects are used in the upper layer of an OverlayFS to
> indicate that the file with this name does not exist in the unified
> view, even if it is present in one of the lower layer file systems.
>
> For the userspace implementations of OverlayFS (fuse-overlayfs),
> whiteout objects can be created from userspace as well:

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
