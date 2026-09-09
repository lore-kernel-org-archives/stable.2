Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601D3101B2;
	Wed,  9 Sep 2026 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985605; cv=none; b=uQt5llsjGGgoZl5VH31JiOBYEH4A+HrcOrleRNmt9kFLvM3C45A19P1x8DRHBXNHfc8DKb7MOhuMXrzlJCfrur8nXhOBL+iWOvZNabVd2tQnSUVii3qhAuZ7DNcBLtAqeLxpyDittEdEG95sJ5bIKHMTlrjCvqgjg/v85rf2T2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985605; c=relaxed/simple;
	bh=ktN7tNdoYP43KwvGUyiKmOWRIyjxMh3OptPBEmbhk2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGly0xXgQLuJGotl9RYhONcEGvG7z/DRB+HejbyEexe6lbNv0kvPJdSiVpVMdRC19TAS/JkjBRPsoP/8XXY3kLTyUXjRhP3qKpwXG4ALCr/ocZ2me4VKFz955W3dNlRNSSJ6b5HImWeoYtK8FzwyB0GmPQU1ANv/FwIk5UWLgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc7BsVSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc7BsVSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400BC1F00899;
	Wed,  9 Sep 2026 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985598;
	bh=tX/kkO+6nAZ2yk4srIwlhYDMW0iyNqDX3IR530S8N1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lc7BsVSKX0Hc7DizsmuXfY4Gaot0S4Cx5Tkjxo/TKSM397DF7itQO4IQCY02LgPwY
	 rrLC/WhA0M67fnl1T7jsvCkgFylUFauKVXgzwja5wXcACbcSpRXP+qqPBK2Z27HCV7
	 +1pw8ThEq3/yu4iCrw+GA75jwMtJYh/YlcSnBkVdlOGLcVIHSZbXaJsZn9qbVku2mK
	 254UnwKIXHHPUDth9aTsvMOWzr2LI2sboyPTQ+ruYzEGD0E6PzmumFDoAuB/nPkfel
	 /MRg1ojXj/8N1i1LhBa1tVV1WDkyLn1uyCD7jTDZbTKtR4jB/9mP+ymwCiI73orvsy
	 LHm/v3p4MdyDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	saeedm@nvidia.com,
	netdev@vger.kernel.org,
	phaddad@nvidia.com,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Paul Saab <ps@mu.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 6.1.y 6.6.y 6.12.y 6.18.y] net/mlx5e: xsk: Fix unlocked writing to ICOSQ
Date: Wed,  9 Sep 2026 16:26:01 -0400
Message-ID: <2026-09-09-daily-reply-0003-mlx5e-xsk-icosq@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141332.2297825-2-dtatulea@nvidia.com>
References: <20260909141332.2297825-2-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> During napi poll, when the affinity changes and there's still XSK work
> to be done, we trigger an ICOSQ interrupt on the new CPU. However, this
> triggering on the ICOSQ is done unprotected.

Queued for 6.18, 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
