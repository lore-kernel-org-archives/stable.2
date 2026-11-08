Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156305;
	b=dYA6l8qV1jjFW5tTqPoaa0GNTuhSZLO5VLYNHXIDFA6r24JrWJs+APwaDnk4j8+OO7Pi
	 rNR9yn6PhuOmilT5oHBf3lmQvaC0SzeL4ztc8QO+j0+7GhYoWWAbQR8x8jr/IjxTPw+60
	 OsXqcWii0hqq/g0SEpb2t28n71OQNiTAP8l/ML9Xg0Q6Zeh8wXxqmtkNMEjoW/rpusFIl
	 +9xISI/t/OXgdNqQiMN1wO+3yrCX9dt72/rsXig85pivXP5bvBWiceRbHw5d/RFLU9J3t
	 JIayX/n0fujYeUAJ+IHUU3v2+9jxeFwF7cLdEfeX12ErX+nigKDER/rjg7IeUJo1vDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156305;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sa2NGAhU1hW/Ea6jxjJZz8ZlNvi+UjN6Lc1VmGPo6aM=;
	b=FvXj0qd+ByRjF5cQvwTAMKalO5wLjDIV7jftUQS9h9NcP9H1kERFFeMvRR7ZYGRVwMd8
	 PfmYc9V6Urvs9DWpMF8YH7U8FSNMoXDzdmGTfa9duzJ6XW6bCXJzcS4PfCgnt9XVVtuIr
	 6ERwNHhunP8QAZiiUZQyx6bFXTTOsmrIZCjhmLepMy7+Rv0nDPp/i7/H8Ehke1kMXeFpu
	 Qxf4hXr/g1OBuFwtanoluwPL8D9URbyF1Kmtj4gQVnxmywWGBfwt9plUl6as4f2M8myYe
	 xqR+r3Yd1V1xYsy/rIFXi4VRrglsePQX9V/lj1AOQfgcDnubgkzNRJJC707YVeaCJuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEBF9mcF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE78D606D808;
	Sun,  8 Nov 2026 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEBF9mcF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9721F008A7;
	Sun,  8 Nov 2026 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794156304;
	bh=sa2NGAhU1hW/Ea6jxjJZz8ZlNvi+UjN6Lc1VmGPo6aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lEBF9mcFhQto4Bn4moYu4kUljm+N7Z5bPXsZZdjvZxu/dAdbXtWqoVWgfOiVoZB6e
	 sTAR3g0uJshL231MY48MFo1O4NOnZPJ0giZAHCwlZ89YoADEu2J8RsjH2oBTIOuS2Q
	 g5m3xSl4wHasuUAESjQvHWN5Vmj8zat5KlO/4a8QlvIk2/1PcTV37s7oPOtMgqyR6A
	 BBJmyMXkeHNmqcZ6YIRR2MMwbdSPMsF9Gkg2s3AUd00v8tPWIozMCz3Qo2tjGkDUYo
	 ehWfGohiYJEbComRvjIewTsu+nGxJRsEjvjgLKgu5QTUGPRHKnPazQbSSizW5EnsWe
	 QcWgm5O7UfDJA==
From: Sasha Levin <sashal@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: Patch "Documentation: hyperv: Update documentation for sending VMBus packets" has been added to the 6.12-stable tree
Date: Sun,  8 Nov 2026 11:44:51 -0500
Message-ID: <20261108-rc-reply-05-hyperv-doc-vmbus@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <MN2PR02MB68631EFBCD22A9962272DD7FD4752@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261107022833.2698985-1-sashal@kernel.org> <MN2PR02MB68631EFBCD22A9962272DD7FD4752@MN2PR02MB6863.namprd02.prod.outlook.com>
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

> This patch should not be backported to earlier than 6.15, as
> vmbus_sendpacket_pagebuffer() was removed in 6.15.

Thanks. The removal of vmbus_sendpacket_pagebuffer() (upstream 45a442fe369e)
was itself backported to stable: 6.12.100 (899e014e6847d), 6.6.100
(6d2d375205455) and 6.1.140 (763db1b8b0036). Those trees no longer have the
function, so the documentation update matches them and I'm keeping the patch
in 6.12, 6.6 and 6.1.

Your note covered all three trees. Could you confirm that keeping it there is
fine?

-- 
Thanks,
Sasha
