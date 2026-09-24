Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFDC4195A6
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270021; cv=none; b=Id9WxR/xKyOE5NEZZTzePMLY+XUy8mwkn/uAkRkviFJaY4rO9Zx13wWCJ6IxhnLdKfKTb6P3qwN4UGQaK5Qk08gaqBM2GFAEisOA8igH5MCX9u5/VGRJHxadCANnrTbhyajNnIOFQeCp8HeYM/YLD73A88ZLh/z1zPT4SHtVWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270021; c=relaxed/simple;
	bh=dVLo2ZRp6O7roce1zzYzYDhtRsvDhq0yeFAG5RkUQg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9rit8uopikQMzrlaYjsSt+iFH9ijHVraZlQo6+pdFCw6RyyNb9331YK3MpVtWwpqqkY0dctJUTrHEpHfSikFoCZdq+V9v4Ly7+LKTlJhkuP6vlqTlBqjWdu1iMoaVbWuanZ8/zLPyuCglgNgtNd7cgCRIneT3DmZ0xkm9OoEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcCFgxVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcCFgxVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB10E1F00899;
	Thu, 24 Sep 2026 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270020;
	bh=1EHr64f/SyiS263kdi/ponXIcq0lpD8oRXEj+RJvhxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KcCFgxVByhGupKS1dBjL1WSrC2T7eB96CW6S2FOxsIVrLemqANCrvDikXcikPIkWt
	 T1LVk1ViQ3BWbuNTS3VTP13guhSKYnd4jd/jKHWQGloYFaKlo8HIeyr21j/VMUbztt
	 xYuKOSV0pBUn0haa+xfo5niukfvyXIQEgLL6QOZh8WSPCMdBaHK8a3Lq2eGRGfht2M
	 gT/erDq6i9TDiKRJJKctvBsmrjjh+5b9+2/RlyrPr0E2cVuQjbgblKnGjfShyRbiuh
	 VJDZ1tSam3DOWeOe+34KKMRSAsY4WrrjOSwHR/JL4Pwi/t9AD4OyxDMOcs3MEkAZd+
	 tB+P6p+JONGMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: Re: [PATCH 6.6.y v2] selftests/landlock: Add tests for whiteout object creation
Date: Thu, 24 Sep 2026 13:13:26 -0400
Message-ID: <2026-09-24-daily-reply-0007-re-landlock-whiteout-v2-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5c94ca5f91cdf1f61f9fef4d1ee9c31e61383853.1790169454.git.mic@digikod.net>
References: <2026-09-18-daily-reply-0006-re-landlock-whiteout-6-6@kernel.org> <5c94ca5f91cdf1f61f9fef4d1ee9c31e61383853.1790169454.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Changes since v1:
> https://patch.msgid.link/520a1a9a0c6f14c19f1b962ea33adcf672bf6fdb.1789655724.git.mic@digikod.net
> - Define RENAME_WHITEOUT when it is unavailable from libc headers.

Replaced v1 with v2 for 6.6, thanks.

-- 
Thanks,
Sasha
