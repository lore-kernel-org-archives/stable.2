Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325FF30566F
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807885; cv=none; b=o6lMRD76PJiE6yN4OLOws4CJE4edGyQ4jbiB6emN9EC1AIDbym0yWM8e7gAqjs1VAEVA2U1JS/3ZZElX0GXuGrA3gH4OJnDqoGRFJp5HP1JG7nitX3Y24Eq7rXI+s36RCwnyMK3rwDs1f1o4HBH7ZqI6UGpKd4nPIuHq7CHv7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807885; c=relaxed/simple;
	bh=FpUC7+wWsvrA2VLIBXXmJTdFKZqoRInBuW3fq5kQY6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvaHVOcbPCXAXKklcwjLWSEhCRMN+EURZnYSRI2igf8QVT6tDYYOTuzUJ2USwkxVu2ZwLEeRZqt7GcaX3Byvp6qHUXq64mW0yak3xyqWc08Aes+N+Qgf5rm0lI4kzdvwynrZLJ8Oy0h7oT49IaYQFAjzuN63fjqxosUgsCmdMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js2DUVYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js2DUVYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50141F00A3D;
	Thu, 27 Aug 2026 05:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807883;
	bh=fBu3aQWQLTNkxld9WUk2pGL4Ad9YCnOBM26gwitBE64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Js2DUVYnh2acU60PxY+bnboRpEQdfV98l1+Sxs4PgUYlyzFvIrTDFO2Tu+SAvTHKS
	 MRmoKvipF17JFHkFLCNkJrR/NDRXNXswluavTMfvgJ18Il2jc9AnOpryLmbbq9mLrs
	 slOslkzNz7bwsZF07v/vgPmONIC3U3WvNBOoHPfy0BWP4tQH+jgHJjIwXDrNWBjf02
	 2IPLlL6iU5t3w8MC2ncrimlh8ozxpTIEvNw2lJ1Yan+5EjZAy3fZfYyF7Kkkvu1WjI
	 y38FcBYZROAagOHj5sq0+Oihqq1kUvFzTWYR+8UL5NODzz4UTzoGO1qYXQ1z4PQRRU
	 tZrX555GSAAYw==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.18.y 1/7] Revert "selinux: reject a permission value exceeding the class permission count"
Date: Thu, 27 Aug 2026 01:17:52 -0400
Message-ID: <20260827050834.10002.stable-daily@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825100338.4039846-1-guanwentao@uniontech.com>
References: <20260825100338.4039846-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This reverts commit 62be2361da29505d3183da854f1c98d2e208e852.
>
> This pick was applied without its upstream prerequisites (commit
> fa79a596848f "selinux: use u16 for security classes" and commit
> 18fa21f10d00 "selinux: more strict policy parsing") and is therefore
> incomplete.

The series no longer applies...

Could you respin against the current 6.18 -rc, and add a 7.1.y version?

-- 
Thanks,
Sasha
