Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E622348896
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685088; cv=none; b=PLcz5XkHYC3jn9JbFoypceJ7jdup1yp5CBmdGMFItWH3PTKVCibtsoFAag2cvTs6Bg43qtSv5B25katQYaweaO0unRrzu1gmrl64YS10qNDWFkMgjmFZG0T+gXWHCb1jt03zd33MnDkulKDdvIVInbwLeBzJX6FJHV2mkRY+dUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685088; c=relaxed/simple;
	bh=tuPkVEmeH+6xIk2axBVOOnzvVqbouEKmsaV9ZB5Cy9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SC79p+UUspthqJiDtYhHLfIy0cdZAAININaEcQW0ZqOojzCXxUFSvx7EX2fY2iyzrnjQ4UIUblsPLeVPrSXp6nCdc+T43s+ayGnCkx/+Sn249jrOcv5+ZiwvvtmceTYiRKPibaiOWNsasN29mouSYMCCo8RZ129oNTmMUKeOLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZhgv3eQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZhgv3eQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95761F000E9;
	Fri, 14 Aug 2026 05:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786685087;
	bh=tuPkVEmeH+6xIk2axBVOOnzvVqbouEKmsaV9ZB5Cy9w=;
	h=From:To:Cc:Subject:Date;
	b=PZhgv3eQ7vpZMPhxf6ENG8xzNUiWQVEFHSrHhPxloeCoJORp9jVuhzpowxNjyTaMo
	 f8Qca/t+WaKcav715rIscqs3ZcGg5RBRSR7tX7aQc58DK5tSDkB2wSPfLIOiV7YVjB
	 i5HiLUzoks63siuUEFBt5gYrUQJ9J2ESVmd55NOgsy4hKrMegnT/nZoaOPOpGDcyFm
	 9huMT/bcpyOuuSogNxRk8NUSOBPLldgvzdS7LToyfYhbIKShO605V1hjeakqC61A6k
	 aaZsh80VRqDbiv1+RhvPz19t7NAh285H8J8f3/XpR8Yk2ysXjrlk+pSFmTsHPnbo/C
	 ku/4YLunvluIA==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 6.12 0/2] Backport of 6ee149f61bcce39692f0335a01e99355d4cec8da
Date: Thu, 13 Aug 2026 22:12:52 -0700
Message-ID: <20260814052439.430858-1-nathan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi stable folks,

Please consider applying this series for 6.12, backporting
commit 6ee149f61bcc ("kunit/fortify: Replace "volatile" with
OPTIMIZER_HIDE_VAR()"), along with an upstream fix. This avoids a
compile time warning in this test that appeared in 6.12 with a recent
tip of tree version of LLVM in my testing.

Cheers,
Nathan

