Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BDF2253EB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701644; cv=none; b=qyv90/Rn3aFNg3vlRcE8LLGnNT8hwEmQUXvK1u7SzZZltA3vGLS02FIxbfHEHrakRnEwzbiONVLN20ElFNMJvuNVB6YkwMbV35EPUF0lGtnAYeiksBDQ/3itjsIzZxKKpTWfaGH3gApwyDpWYDJJ03I6Gt03DLoI4n2jPv1wEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701644; c=relaxed/simple;
	bh=zdM+N2cCoD64YLLS8L67IiddsuxjWkm6DulY8o2vH7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUTIsh7j8tdQ0Xey8sxHLyOFSfuTCdOBVzY2a2KTqNQdlNhHRXPljl8P45fCF0OxtVbrZaNUmLtVAXP0fM5OYFGym9+29RMajzzhED45iKSAv+tDKZsRKiFaPcZmcvdK0zXRUmeRloXTnZ1KR7ZtNg1hC41epfaPIPeMRzkgmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex8TgNz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex8TgNz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1094E1F00ACF;
	Sun,  6 Sep 2026 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701641;
	bh=SrimCai9VHS8j7Uyy3nZ8YsemnDlWsWRSJUPlIoAfdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ex8TgNz8aGQ2/GGMapdzK6zqz+gjZoK25bxK7dXCXYDgQjvoDSot4Zff1i+WWaNqa
	 2zBPoTORFIll5unV8nLY1FWQyeFNaIl9JhQGzu+Za0+v+BWN5bz70XNNdYaiTNisxB
	 4yBO/pgGzWa9l2yRXEMuNuba9k1fmLCXEe54F5rTf+NEOVov8BIagBKrvSac4dn/VL
	 f1sS7wv15e6edcu05KuRpS4uWgAVK99EfcztsFcUM6yEMrW0WEKAv/hXHOsfbrXQMl
	 UD5YyNl5G3Lp5PXAzsj23z14UVxsuaTpidqx5qvanmo4rVDgvM7UUKDY4MYhTOb3rA
	 WLqIJ4D0p31ZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 6.12.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sun,  6 Sep 2026 09:33:07 -0400
Message-ID: <2026-09-05-daily-reply-0037-fsnotify-stale-mask-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905024734.3941984-1-yjkwon0026@snu.ac.kr>
References: <20260905024734.3941984-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a mark gets a new event bit, fanotify and inotify may avoid
> recalculating the object mask if the cached aggregate already contains that
> bit. This is racy with a recalculation triggered by a concurrent update to
> another mark on the same connector.
>
> The concurrent scan can read the mark before the new bit is added, while

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
