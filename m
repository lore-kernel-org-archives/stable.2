Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB38207A20
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784373594; cv=none; b=r1SCKN7nDerSPniceak/32je/dX0IuvYYmMUv1ciZhx/KfG+BY5V2uSPnqweHAbPsF33u42uraVbUWlcTGmQ+KC/Ton65LH/xcaTDpx3KdbkMR0zgdS6COqeidec4jDKkbzWYdrzX22OBMtqGN0T8JdU91FtmWMi3313uAr1xN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784373594; c=relaxed/simple;
	bh=6W/hFCeSCkIoGoGCqurtx8OYw3v8+uL0/QwYUtkuEr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1PcWa7ljor45ms3O5ah9pK8PHfUFgpKT25gbPs3vs/+Jf+FcPVpZl5lLnZf6J0vO+2q+qEH/yUIydvBSAN7lKn0nOgW22rCpEEFYb4ngAOXXnhFyY+xPzPeFI5WyditWfRi+QlBaceNGBb14efutzyPL7NNRpIJGWE1kGZW5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC3rgWC6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC3rgWC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84BE1F000E9;
	Sat, 18 Jul 2026 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784373593;
	bh=jbpNO/2pXstryLsBZliWdEvhJm4mxv1D9vNfZ9zHOHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HC3rgWC6TOvY0VzQ7GRgnPf7SUxyCT/+rpgBK3j2JdobNXKOhjdSd7c4Vxf6oXEk4
	 PN114rmkWgyeHucbFoyTEtyrnTcJ7bpA/HLGjHPl/CEpdfIG1yjDLYKZ0wWySdFldS
	 7/tEWx3PjQVNdOMRIPXC+R3VzsQMg9FWelz0ykZEdcGYvAVBo86rYoMVyy1T1RC4u1
	 TY3oY/e6ZVvebdaDzK1fOo5cJrcSoC3Rl2WMfERCPerZ0kpS+CSDvoEYl7kkuiauOo
	 H72g4xP9a+0PUXKCm0gKx2Et1rFqW3vyVxYaHezsg14z/hJ+xbBlR9uGW8KqCEUhMR
	 8YUbgFfMY8kzg==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build) in kernel/time/jiffies.o (scripts/Makefile.build:229) [logspec:kbu...
Date: Sat, 18 Jul 2026 07:19:48 -0400
Message-ID: <20260718020213.rc-reply-f24df84cbe05@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178422474345.11595.3718390216125966001@kernelci.org>
References: <178422474345.11595.3718390216125966001@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> New build issue found on stable-rc/linux-6.12.y:
>
>  in kernel/time/jiffies.o (scripts/Makefile.build:229) [logspec:kbuild,kbuild.compiler]

Dropped the offending patch ("time/jiffies: Register jiffies clocksource
before usage") from the 6.12 queue, thanks for the report.

-- 
Thanks,
Sasha
