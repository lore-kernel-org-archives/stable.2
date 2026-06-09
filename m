Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F92798EA;
	Tue,  9 Jun 2026 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966334; cv=none; b=RSpPKvSrAsI3faci9d6eo3esGi7tg6mOmK74KBJ5CnLe6P0VSPIdH/QfydQqOHmvAfH9cEPyTmzDB2pA/iFJ5AjUsVEoPEwVq/m1wWiUcSUToCamiZsn07HRl/hwLRkqisxQEKYkI61IcZMyOXcxh58gEzlVRb8MfICtV6xt8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966334; c=relaxed/simple;
	bh=t/plAMezUmKXMvguGb4KLzV45hkyBwkme3lEnYgsZXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMFaryACBmsdVtjHPSPyqyZciEeAwGb5cnUIdxgqqmBpI2Ak5ilh43fQqSsHkHQvqvI8lAzOWv9GUr4/oeehyyPbUa1XDdSmXRbnZVqQZ13mxI6S1VAAm2EfUjjKvHDmK63p4j8F3i0gp4vcRLkssKeWeiwBouBfuFYREMNsBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNCJ1n6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNCJ1n6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423851F00898;
	Tue,  9 Jun 2026 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966332;
	bh=t/plAMezUmKXMvguGb4KLzV45hkyBwkme3lEnYgsZXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gNCJ1n6R9MnO3aPQ1mnkOzCmcIX5lJyFNqGJ6pabem7MnPjH2T24GP30YXWvRj96L
	 +QhkkjC68KLjj4ZxOkPCHWf+DudXbPkah1CE6O4EdmWLQP6Ua7Jqz7Ub6TPFwhddGu
	 edsWldJAIOHlI5LvcaCyp4WIkix1R6EVVJUJWZXcffbpNfuxcZhAXL9H9I/mkc/lrm
	 y41aHvcJkgOZeHxmi6ocGxyNeuu0ZcYG46HWOHjeSuv0QLIseP2eUfNtbSr5fNpCtp
	 PlcR4DX9VXgEwgF+EKTMt7fVemqGTO4uic/8QMDwP1F0YCuqFtF8psu2K8MQjhHeqd
	 XPikXjQ5iitOw==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: Backports of 175db11786bde9061db526bf1ac5107d915f5163 for 6.6 and older
Date: Mon,  8 Jun 2026 20:51:52 -0400
Message-ID: <20260608-stable-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606032024.GA3120787@ax162>
References: <20260606032024.GA3120787@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Attached are backports of 175db11786bd ("Disable -Wattribute-alias for
> clang-23 and newer") for 6.6 and older.

Queued for 6.6, 6.1, 5.15 and 5.10, thanks. On 5.15 and 5.10 I also took
the f014a00bbeb0 ("compiler-clang.h: Add __diag infrastructure for clang")
prerequisite, as in your attached series.

--
Thanks,
Sasha
