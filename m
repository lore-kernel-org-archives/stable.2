Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4E3BE179;
	Wed, 16 Sep 2026 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523561; cv=none; b=Vq+qlO/vKaZfuaAQg+aC9AwnYWdRnU9MTrL0KR4JqmW/uefPBgY+9kigTMpo2BVkMA4xClrTPDS7xYXfH5XS96+LlfF9f/U5XpiuBd9CoiBLC7B5NHHa+eNQBKR/9hQfFTnrxW2MZToEIDGLU3BnlUTBAWnoj4VkHZoa8nNp+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523561; c=relaxed/simple;
	bh=XdOkhGdmTQ3hbfWvoK+SdTb8SKyg4AkTQrjXOPNvuto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sc0Vd6RlkOEMxazuCLtkePOllN1ZF5+OeH83UsulfWmbtvDEvFDeNFynOLK8aV1qG2zFDFQQbcPO55jCdGMWhhvYfYUdv2f0B83ite7clKKLl9r1O8Pm/ElXI46lKrldY2wnc4xyUKWdEq5eKD+ivoyas5/9Z1NUuWt9R3qBfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm6bUsho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm6bUsho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC201F0089C;
	Wed, 16 Sep 2026 01:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523550;
	bh=fdpxojSG9PXT5nNfmMBkzubbExYWeuFAuC4sHIuvP78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fm6bUsholE4nlWaaY8NN6XzXjlX7OkAxeYT7Rsx0s3nkdn6P+T/l6R8rZX5P7Ea2q
	 uWmNTg5QfQkNxFoRs3NNyNAGkMwUMmSo9pW7nrkk843Y6kAw8itCJc4WuTu2b8g9DR
	 uyrva6YKiTdXlilQEO1/OpnCCsgZHd/a/64PMz1HWOMxGm7tnOgpJd13CcF+s60ZCo
	 jLmyfpkllgLblSVqR2nbqwNS7JXrhyCPF/3QT497FBg/QkACmIrw8k4j1fHwUSsjtN
	 OVm9h1UfinzuO3KzxlT5pkUIfu5Nu16IxQ7isdAGhF4AmwFcvVYnV5izFX5xaJuEbq
	 /yV0JhLBeTxpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Patrick McHardy <kaber@trash.net>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Tangxin Xie <xietangxin@h-partners.com>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Miguel Gazquez <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.15.y] macvlan: inherit needed_headroom and needed_tailroom from lowerdev
Date: Tue, 15 Sep 2026 21:52:11 -0400
Message-ID: <daily-reply-20260915-0006-re-macvlan-needed-headroom@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915-cve-2026-74743-5-15-v1-1-bacf32f2651c@bootlin.com>
References: <20260915-cve-2026-74743-5-15-v1-1-bacf32f2651c@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit cef51860becd9700217c81732ca1eb1ea6ed6fe1 ]

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
