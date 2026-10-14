Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE1563FCC
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996815; cv=none; b=cMLyHnyQwXVaeF+G7JEIVQCn0kkh09nfvg1hOwzG+Mjrs+DMvj5961QQR21rWoTiT2JlbhOtFWCJlrJ6t/1IiSveoqWbim4ozdvpdiRJ6tWTeTAjdR1Jvi2iYzBZnUMgLwc60mOJR/9w+kFJ/jpl2oHhaLSyrKgVKzTmrQJ7kX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996815; c=relaxed/simple;
	bh=FxFBSu8TGVBzc/3uGtGsCxYAgw4MV+VgOVIkWxjOqEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwyai2fkcaEEc29M4ydpt2MnSKh+y+xe00EDLS0Z3d/aQrFtdGv98WM0kFJiGvdJ44v3dpqvQGf/BlwalihzUME0HDk9tHJLqodT5pQJXhBFmYNYWCO1ozgCl94PmlSiiV4ISf3cxTKQjHy9xXmTLOuWvXrpTVrB9dMryr8HXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb6e/1wx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb6e/1wx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E551F000C5;
	Wed, 14 Oct 2026 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996814;
	bh=DxYnnYRJMI/0wKUiiFw90VMmLu2PC48ZgE3oLXjCJqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qb6e/1wxqrDo1+awTWGCf1NN7A/9GYNUDhNVu3vMPuM02MsUIzhocvEDmja3gZDok
	 zmePLZJ7oLdpH5ctnL9ez4aNJS0lKX+gZEd7/yVRBd5GwZ6414NRsNyl9HR+r1wbCX
	 OQjWprrEIK+hxMIm/oUIrWqtyETXuev/4eVxMwSJb+ZAjQQSsBhxzg4GfMMyBDJQSl
	 YkETRDGRJyjhV0Law0uMcumMnd3AfS/BgmvurF3AQQhqZvqUqGr3AnDXvKzQNHZvWi
	 PnzHuX7shoM/jQst76gonyPlN9BRq+Byp8b513slk5WMtnjRbY9ePL9IZtqtmD5bDq
	 MlOHpkOZWrTig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	ljs@kernel.org
Subject: Re: [PATCH 5.10.y] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
Date: Wed, 14 Oct 2026 12:53:17 -0400
Message-ID: <2026-10-14-1-daily-reply-0014-mremap-dontunmap-self-merge-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013173115.2539223-1-ljs@kernel.org>
References: <20261013173115.2539223-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix another of these - self-merge.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
