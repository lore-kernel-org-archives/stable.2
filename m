Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239624;
	b=p3J+XXb8mbmb0ZngS1qMPcM2X0V9kNG3EH98/WlLslgTGBFIGUWFmy4z1ynKiZjVk9IH
	 sbUkppr1ib14+FQ4NQnFDS6SsLiGzccLudCB9yiHOXtv6MVvm+rGKa9ZUzCd5md0uQT44
	 n+BAa0gKtGX77mATH5BhmU3gBnIHkwwh0Mb72M2ELI3J+DcJG5NC66INDQdKm0MeCxgKe
	 UsL6BaWa4n1pzVZVJgTEUHPLgn653KD0hrGSTf/pl0zmGXiRMAqQDUfpg/t1o/MO7ZE7G
	 5or7+C2Ro4zhlBrkySrOIfF7SqNnoRJTPEYHwqujq3/yAjLDahG7c/gfOzJbanp2OBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9e2T5vSueerCIWTLsgtk6XlfxhRhSt9q/fvIz8irM5g=;
	b=Jf/emt5JfhUw5naUkbgpmjf4YUFasuK8On5iqYhSHHO8BHAHilbOQVzYpq7oIYF0gqHm
	 KTQfDu0hm1Nj+2V436FDMSlK8pb7kZ6GvODX5WqQmbLJZfZKMnqj1FC6qL+HIsHIjInpA
	 l3no3TafNVkkILtIBbxjKwFgZK6EqhaDhDfAe3KM1kPcPsO3qWYY3Z/wPjGQEoLl3OHQ2
	 Jxjm1dT1haKexHP2ttb3FUzUEODaQs2OTu75n0WcE3ABh/PLjNFY/b2rqfS44UpftlCil
	 9h5nTlL3Nvj47skxCWH8UuvFir+w3H5rhN289JaPTv76UNrm+QUjqYrXhUsrrAsw3yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Cuc/IwWe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CA606A337
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cuc/IwWe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B001F008A3;
	Mon,  9 Nov 2026 15:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239624;
	bh=9e2T5vSueerCIWTLsgtk6XlfxhRhSt9q/fvIz8irM5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cuc/IwWeAkF0dLvNl9VD2OoTo5pStjz398M4EmX1LvaskqAG28TebYtEe+a2tHOtX
	 5glYSbgQdb844Nj+sfV9jyw3q3Fi5vfa2VzSv7++DXspV9azXpaojAbUvaOG1QJoII
	 Ltq0Ir4fSZUnwXAHpIBHeFhyu8cHjF5EibzT6ynHEzgp5oVfGRM9bjR3QMVVHE0o8y
	 1Q+CybJA6X+omnmugLUOuHrJsZo3fsjN8iTCJBBTxOkUH4IOeruIbu+dOr5ImA/hxl
	 bIEUOcJWW1Jlv2BxVpztqCkDtohVgkKydApXiGWZ9rDtpZRXlJHXFs4gnw0IHfRXbH
	 uEnNZUQUt2xXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 6.6.y] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
Date: Mon,  9 Nov 2026 10:52:59 -0500
Message-ID: <2026-11-09-1-daily-reply-0017-bcm-qspi-6.6-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109030617.419442-1-zhugl3@xiaopeng.com>
References: <20261109030617.419442-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
