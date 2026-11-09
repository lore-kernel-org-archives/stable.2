Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239635;
	b=RVdDB83dPMspGzKRhtPW/Xal2MNVqFYJQDdqPjUfmIETVmLpVHVKqzanzA4gzEW5t21v
	 14gg7RTb6WkeIuRAvZ9d8kpAJRyZVupH2Mwatf0MV1CyeOqTmBnLtzYhlDbK86WHeQW2h
	 cTyelgYhaaLOOjV0P8yclPv9QQVTu/+qTyBE7Vuq973JL1uFo6XvxbzGvv/KjLaTk9IXw
	 TGtWLXW4s9VbNfRwZFVMchY9CSsJma/+NcxBxDsJzY8/72Hxq6vCtW+fACqYCqj62IWBa
	 +VcvJvFikguZd/dxrAqH+LEj8Y4hh9fJLW+TkXTJfhIKQZMGvuJu7D2AEa7eUcn8/HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+peK76Is/BmQTldCwniNdhZzNIDH9msqww8fYZqr7+8=;
	b=zTxAJbY0r4mCaI5Vcr4BoRsmUyaJRqGAaEkRphvNfCCTtfFjz9rmqtMsZW3jRu4b5aBz
	 shPkiBqh1YI978Ouw/tozSkkzyJrAdogwFQeoY/d2mDGLrK5q5maX3r3qaG2l1H9aRQdn
	 5IX4AtOXqzw/P3JE7dbVcEnd4DkF6LPkbLQk450r6tUwIqadk3glzoRg6tU8Blq7F/PoR
	 7olmk5Ew76Uf4mo21d7tkQy0sYsNT606HOZiaH7uPmYGdCJoGwQn4MLopkY2DIP715znv
	 5vP2fMCaaqd3dDxGlnecsfIvCHXKYaAyz8JACkUVMs50XHdjtSH2skOJHzHujKALeLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWnJV0kV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21E606A331
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWnJV0kV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC60E1F008A2;
	Mon,  9 Nov 2026 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239635;
	bh=+peK76Is/BmQTldCwniNdhZzNIDH9msqww8fYZqr7+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWnJV0kVxLGO89HH+4GJLrjujrrcNuzj7/cr1tVFDYvNlcZkyqE0Se02uMNHgtyw/
	 E8wOUpXWr19hhFu7TA4UNDhxz1u2ZEi+csG4t3XgUBmOcwRhwRisETqqxnTV9JuvQV
	 fzJKB41TOn5zA+lQiYCEfd6PnhFUKjxeX8dVydqnWJaoVa2fv2tmlQGmZG+7n4wEql
	 eJwNfrcJY+xEy6V4xi+fu2su+EGmn+Wc1eiiAgNT+AzficDSV1tRIxJTMJzcNB0pDd
	 KqxmdSDp7DgCsI+UDk1ChZp4XHFqmLK0FWci1ONPwEuxBKt6u1/4dkUGaa9ADPRpnN
	 Fkz5VJDRj/xmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Sean Baggaley <me@drinkybird.net>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
Date: Mon,  9 Nov 2026 10:53:11 -0500
Message-ID: <2026-11-09-1-daily-reply-0029-uvc-gc515-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109093527.2436913-1-ribalda@chromium.org>
References: <20261109093527.2436913-1-ribalda@chromium.org>
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

> media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
