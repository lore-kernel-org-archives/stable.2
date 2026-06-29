Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5735893
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782694448; cv=none; b=qJzDFUQ+cLaBMqGV9bOUKDVlWYTGL6pSOmGH6nv5/z+mO8bjNlVn+sOzSqOOdPyV53h5Ua26Gqft50RGAwq10lTiuHEg6qTMXJpSpjfUs9DQoe8k/tR8cMgxYTAVSHhf6a6s2j49bsAFG5d+A9o7K9+jA15/cxLxdCbr9jJWkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782694448; c=relaxed/simple;
	bh=beZ3mgZrxrlS/0ByvUQ65pYfTkAhJLUHsPsYioey+XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8hycslEdk7e5cU12KiYrn6SAIYYYZoVzxxP/zzizF5FerXAHvu06DAr0ME4ZiGADxeP91MdveHTfw/yW6CZOiNrxfO3x6Qr97WydnupomFXK1bRbqzQdAtwh2sAcxgGrkwO8lXQoo2jJpkIsOP5TmrnzpgeUBeVNS5CLQzKJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxhvvnVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxhvvnVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA591F000E9;
	Mon, 29 Jun 2026 00:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782694447;
	bh=gVEBQQ3Ih68cKsVxljEnf7h6tlE5psA3qhQaUm1QrxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BxhvvnVqnme4Rx9S7hySq+PuqWGIAZ52kArdjcKcUAlIsAkhoSNZnCep8tlw0WVMk
	 3linyT7Xsazmi0MpVRsd/tHyDM07OMKsMm5yCmDAEyZkdnHUYMe58V/aYtIt+Q50Ar
	 MzFQc3eHFoKB116rqHu4G1KAIqMgix569qBqkrmJu50nQDSLTqkKHp35y7kMD0aDSD
	 scZGiZ82GPKi0JZmsIBryK3vRys8CqzrJjyZXcAr9reD4bzr8ua4unHHJ1Fq3L59re
	 Zardu8b5XCnZKOV/RbS9vO1kQEyakOvvFZDOaeEcrwOALDhjhvlmEksyOMF7y3weVM
	 fFwIFuKmx5dGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	alexander.deucher@amd.com,
	ray.wu@amd.com,
	superm1@kernel.org,
	"Sun peng (Leo) Li" <sunpeng.li@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Peter Jung <admin@ptr1337.dev>
Subject: Re: [PATCH 7.1.y] drm/amd/display: Fix ISM dc_lock deadlock during suspend
Date: Sun, 28 Jun 2026 20:54:03 -0400
Message-ID: <stable-reply-item001-amd-ism-71-20260628203053@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260628140148.59923-1-admin@ptr1337.dev>
References: <20260628140148.59923-1-admin@ptr1337.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Ray Wu <ray.wu@amd.com>
>
> [ Upstream commit 3714fe242592e3699ac5e2c19d68b275a210be7d ]
>
> CachyOS users reported a regression in shutdown/reboot behavior on 7.1
> kernels: the display turns off, but the machine does not power down.
> Reverting ISM fixes the regression, and this upstream fix addresses the
> same ISM dc_lock/workqueue deadlock in the suspend/shutdown paths.

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
