Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4EC55D888;
	Thu, 15 Oct 2026 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092992; cv=none; b=u8cto/xY+aoNAtCIwq7g6TlmOVY/z7z+P+0vcQ9dCkd76PnycJm1DbwSYXxLV/kq96u8OKacM41ZIEq1vEhJ1z2ML5ueF2CcsQftx+6iin8q7H/MoiVUs7yvC8TRt31vFiVEjvPtSYX6BNFdXv5buiArNAG2w16x/IRX1wlbAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092992; c=relaxed/simple;
	bh=X0IzxHW4W8rMNFnzhgP+RlaK9tEFVGYUKOAJJJO0Ig0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8+LuZ1Lr7ClxfUTDGQwazKYCUCWXpKfJ+vfeUp9IY8tZjKYzmnFeO3rwcm4PvLs72sDIbcpgy/nqy7PNGgBCbjyftZkNXIwjIMB9XQgo0rAUKewCvJmK4viNpoD9s+2UIyONALP2pLZ8dST0rCauMlcY3hkpzbFZMvBWs8V56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jegBLvRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jegBLvRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8543D1F000C4;
	Thu, 15 Oct 2026 19:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092990;
	bh=3+RvMKP78FVJiQAUwt830Tckq+2HbuWwJ+cMP/sPHMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jegBLvRDUi88G+ewB6Mna/dDZUGMXtDO0FLbmcJ/dSEg/6kf+tRBIPnHZggAchzAT
	 raVoHnWtrP1dJHqTB2DMs3SqB5n2SHv53riRC9/WNgNYdFWpboEnGwxH33ITfnvsLv
	 CrZksHIGICsJOG80GM6DmdMDbEGUprRNdxc2BehNznNEeFSlpPrbbhYvq51roStAEh
	 CVv/Kh4f3xUXjQbkY7oRMYdWyTEtRTQ0iT2Wnab1Oj4U4qUe6skOZLx8iCUXJV5IKE
	 QTAHmdJdENIQKLmiYlwiljPcv9zoBgkII1tzgkY1y3SpzjpKp8FHlh1SYKrQyr2oRg
	 JpyS6igXZq+nA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	apparmor@lists.ubuntu.com,
	georgia.garcia@canonical.com,
	jannh@google.com,
	jmorris@namei.org,
	john.johansen@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y] apparmor: fix cred UAF caused by begin_current_label_crit_section()
Date: Thu, 15 Oct 2026 15:35:51 -0400
Message-ID: <2026-10-15-1-daily-reply-0008-apparmor-cred-uaf-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014193517.24940-1-artem@trailofbits.com>
References: <20261014193517.24940-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> AppArmor's begin_current_label_crit_section() is a scary function called
> from lots of LSM hooks (in particular VFS/socket-related ones) that checks
> if the label referenced by the current creds is marked FLAG_STALE, and if

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
