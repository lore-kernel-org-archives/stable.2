Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3E3CAE60
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255013; cv=none; b=k/jFbTCBRIG//cO0+Nw9kj3/CA38dLtyD2C96GX+C8Yxv1/zsS44dLq7SzqQR6lGUiRAexnaIsPM6PzmCmU3YJEkJAO8eWKYfx9YFwM5230BuyJJ0GtaFjXScN24gmyG35luP7q1bbYRaJ7F2Xk6WUEKblyDc/ZD2u80PODoxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255013; c=relaxed/simple;
	bh=CQkHTvjNoipMRSQAqx7AiedRt//n+DYH2qsz24iFqeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfaS36wYE95afnYsinXHnh+7TG/PilFWQZoR8kB2AmQxyvbyz5PDi0hJqvjhq7BvDl2juHDD2MTlAFt5BXpCnwnUaV/KgYuo5/CCoJkgZHZVXX2YVtB7tS6FuOBSJE1c0WQw+YweYTobGoSUBUlUQXg/z5xMJv7ZXUQtbeiLsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0JKA1oe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0JKA1oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE48E1F00A3D;
	Tue, 28 Jul 2026 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255012;
	bh=Mi8Qf9WChf7g85hHBmgM6KJS30WNFr5k0OINJyNh07I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0JKA1oeI+Cqe6EKG7gcP49ZdN8MBtQ7fipeY3Ck3hFSJI+lcHVuV0P8NGDB6yuNr
	 nyhW6LOo3omfM1IyHhVDngva6uRH1aVoIu4I8Za0w+OZrSugcd2pm97fXgsUMpvxeN
	 vaM6Knj6CMjDHkd0l3yKmil6dpRbKiMlrZ8jy3Ou3uvqnswqALgs+qPmoVuJXBUSVU
	 Wj9acMiMoGdhrBTvt5r7otgeTlYQxOQRPfquGh6L8w4BEdAq3WxPtUpa2IYnzNQwEx
	 In47ySCnRyYh0ZoNZ58GbrxPFtwMpVZBu5RH1WJXepBQOpThHHv186x8hlZqNilkWF
	 +TZGgb51FkYUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.10.y 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
Date: Tue, 28 Jul 2026 12:09:56 -0400
Message-ID: <20260728155654.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724101342.16000-1-socketcan@hartkopp.net>
References: <20260724101342.16000-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> -		sprintf(bo->procname, "%lu", sock_i_ino(sk));
> +		sprintf(bo->procname, "%llu", sock_i_ino(sk));

This hunk is not part of 68973f9db761 ("can: bcm: defer rx_op deallocation
to workqueue to fix thrtimer UAF").  It belongs to 0fe27e598592 ("net:
change sock.sk_ino and sock_i_ino() to u64"), which is not in 5.10.y -
sock_i_ino() still returns unsigned long there.  The result is a -Wformat
warning (a hard build failure under CONFIG_WERROR) and, on 32-bit arches, a
/proc/net/can-bcm/ file name built partly out of adjacent stack.

Patches 2/9 to 9/9 look fine on both 5.10.y and 5.15.y.  Could you respin
1/9 without that hunk?  I'll take the full series once it's in.

-- 
Thanks,
Sasha
