Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35223D45F4;
	Thu, 25 Jun 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384143; cv=none; b=YLjeLdwaekUVSJe14ajU8Zzeqb5wWXrahx186tN3JyFGNQexH7yvjWXPbp5mJAzps9mo5IF3xiJhLC6fDupCcHpDVlPwu1FdKbgUw68vVc7hw/IETyuEfcnSMPJjYhAfuhw9X9d4AB3LmcWPzD/4eYmOS9hlwaAhCVt7gqN7MHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384143; c=relaxed/simple;
	bh=UHR2VjECGuQa5UFUcTYLa8tHSgCoSshKW5a/0nL/cAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4tYNcDchs1wd8ec3K6K3y+qxWf980Ib4Cu/AGksKgb/cuzH1nYNy5/JX+72E5QDEmuANWNBytSoobVyUqzkCyhieVZaGsoiuIQ88LRmr+9MeGeBdT2u5VeCVv+CL3ca3ubO5gHjE5vwcadrk1eh1Rz5lr6HxJ3Upd630ANYwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSIbogI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSIbogI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378751F00A3E;
	Thu, 25 Jun 2026 10:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384142;
	bh=UHR2VjECGuQa5UFUcTYLa8tHSgCoSshKW5a/0nL/cAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jSIbogI1SuYUIcb061PfQgf0pSJCC7JowE8pffEMaXPfhLzjr+gl2O9kOXwpq15CM
	 6Xublc0JxOP9JHO9rKWvftmCPIyYlJBE0tO9Cv5AAdAPibdWZoEjAayb1SEMsh83a8
	 klVg9ENxW8VnbWd6hgHeidzSMoLVrLujPTKdpQjhNfHDAnKBYrRjW9k2TJfeUvsCxb
	 AD7JWn+wg4jbQe32MEyyJCeP8y7g0a0sL+hmUEN8UJ+L7Yzl+uYLjLSf1+YJX3NnW7
	 8eVFVQKe/5PcWf4+R/XlQtAczSfimKa5R6OIKuGToAWfQ0I8QJG4osLHEYxDZ3sdlx
	 w94YW3AyZt/OQ==
From: Sasha Levin <sashal@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	stable@vger.kernel.org,
	Greg KH <greg@kroah.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	Kernel <netdev@vger.kernel.org>,
	Kernel <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org,
	Ujjal Roy <royujjal@gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix series to stable kernels
Date: Thu, 25 Jun 2026 06:42:00 -0400
Message-ID: <20260625054005.0016.bridge-mcast@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please backport the 5-patch bridge multicast exponential field
> encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> e51560f4220a, 529dbe762de0) to the stable kernels.

I tried, but it doesn't apply to 7.1. Could you provide a backport please?

--
Thanks,
Sasha
