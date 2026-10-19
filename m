Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443355;
	b=rWML7QFGJ9ySv+hV/9wrJq+a+OnWkgP7EOKOtOmeOMgjUEv6wz8/KUbboQEI9j+aN+LZ
	 nTJhrMeTyR6EF+LhHs3wnJGVVho5RTOeDD+iwdClfXZY0kUbCrveHJcy7YK0d9ueUKl3Z
	 F5e0aWcJZF90TZl85V/ZMIq/3+nl6L/cHafgAwjickvQaFMn11hegfZ+EAPmVKvxaBOx2
	 IXdfACbjWbb6Rd5T4noiJB+A7Vc5RExqwfEz5kfr6RwNnwszusLfdfh7IVM1LfrHA0+uo
	 GN70s6g4zF+uD8ctaYyCPab5EJyVIvA1psG9w2yzawQ2irXPkGXuwQeOZLR3ALz7BKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443355;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kMyG0dBW/Az96E10AA94x8359fEB2VYcxOdoeU7vZj8=;
	b=ZBsIbeYiyJlwkN1lHY//w8vHT+8Psv5uYwaQopR83YJlobh5YvW/yDQPzMO3DV6jPQcx
	 3UB+8fmfGdlzYlZBkaaNumZQwEum5CclkAOTErwObAktLY4BwbZBnls40efO/92Xbg9Wp
	 tr0hemkemHL8F9poDCOxYx63svjAnqwsIGHPy4MPYqBdSIJAtwGf0YRpw9Rb6ooG6zlST
	 Jw7FUAZPIDKVaFR63W5jY/uGwE+WQlQQ+Zso+Y4311UEuAtWL0FvU9VYQIKoGeATjTOAX
	 X/qW7ewcw82RqaaXhC+X/4a06nu44av9mLhTxiO6DUYTgHOSF6m2jEADiUfdu3c3gRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTmgdj0k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1B606A324;
	Mon, 19 Oct 2026 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTmgdj0k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C1D1F000C4;
	Mon, 19 Oct 2026 20:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443354;
	bh=kMyG0dBW/Az96E10AA94x8359fEB2VYcxOdoeU7vZj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KTmgdj0ksLb4vt5Az9yB86oCQQAOws0alrwyYP/5sb4xXWZ1KOGC9VeeLjm8TfGE0
	 A2ZNNQNICpvAeucfFnLpmzwbLWMRR7/q77IUvQ0mAuPz7Mrwou5UZrWBrcGzcuKjPQ
	 9zaPrcT0fYuVzCF3SHe0ZiOjd/Y5AmSv4yxmlDc/ChntmjUB+wrakVR8LHgeeCNq/L
	 cXp5WIgjnYBzf6kqlKLzQxRU2iOmT4iZ3aq33DmZj22xSNgU/lIeqrn9bw4XzZJ5IF
	 2rz3CkdxqvEqiLQySKMlHvZEgBMkr0Nzt3vedt49ZvS/50BLlbjQkTpKKtJaTqpf8t
	 b7IPPkVR/JBjQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Mon, 19 Oct 2026 16:55:31 -0400
Message-ID: <2026-10-19-1-daily-reply-0005-rose-ax25-6-12-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YB4ZJKsTNJ-LvPS4vdL-xaA28V3c_MkzjvZ0hk4RkY_sw@mail.gmail.com>
References: <CAFAa3YB4ZJKsTNJ-LvPS4vdL-xaA28V3c_MkzjvZ0hk4RkY_sw@mail.gmail.com>
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

> Now that the fix is merged in mod-orphan, here is the matching batch
> for 6.12.y, as announced on October 1st when Sasha dropped five ROSE
> patches from the 6.12 queue.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
