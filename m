Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607621B191
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158066; cv=none; b=VBGv6eeX2VfL5vMTn7sxe/FObmOm4LaENJ4R+10Xa7p7wLMlG6iHNtWNz/w+AwEB+10UZfhX+Ko3TO3cShNk3+V79epVzb5kkKHb6p9Hf8B5gW7pwlbU7sdo4yIBWcrv0/SeQ1E3g0FQ8pypKCGn1sr4AESSHBFPAwMMZGv/mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158066; c=relaxed/simple;
	bh=ySSydyYpl7SE4zV9i494fQ/q70EuUAvylV+WXghzXgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVAh2NMUtYCfR9N1A5gCnMljOLY1lnthEuJPfODmcZwgq02EICWJOmsa/+/FpppzchvjGCpR+KYtWcMkKWCR062OFn4txXSLGEOw0DlkLKNiEe94zGG+KGAc89S4moT1vLnAEg/1yx8Sp5DOPiioGbCB66eAex4g9L4y3vJZAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlx5ed97; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlx5ed97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB2D1F00A3F;
	Mon, 22 Jun 2026 19:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782158065;
	bh=N5zjoGtNCopHlx1lovULGIGT9b/OdOrmzqtCn04ZaYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xlx5ed979XHpIk+ladMGt82wvYrQl9r0K2wPNg3bb6Qccc+4rHVuACullQuhR+cWi
	 UGgKv5ae055QQvYmP7Y8sw0IbDDYTav3bjQnZGP/wsmrnLzD89iW8CcA0cvFoF+26k
	 RxIVa9CfwyzbRpjFL60CYg6ZR/1yfcUOxBL0A43LQCYEYNbizWmLTUttlfkVv1yABf
	 xLigr7ivqL8C82/riBUp3HKMT/fYG66x5yQegZgfAovIpjn5/TkxlZOQTQqj6/OAHx
	 XpmJBFPgZdUgkdIIkupIKIPCI9q+rLyx+2SlytuFXL2VrWFEH/akgFxHAun1Nx4c2f
	 GprAivJ1tNWyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4] ARM: v6.6 and v6.1 stable backports
Date: Mon, 22 Jun 2026 15:54:17 -0400
Message-ID: <20260622152404.0004.armmmfault@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622102634.780100-1-bigeasy@linutronix.de>
References: <20260622102634.780100-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 22, 2026 at 12:26:30PM +0200, Sebastian Andrzej Siewior wrote:
> [PATCH 0/4] ARM: v6.6 and v6.1 stable backports
> This applies cleanly to v6.6 and v6.1. The v6.18 and v6.12 trees
> already contain this.

All four queued for 6.6 and 6.1, thanks!

-- 
Thanks,
Sasha
