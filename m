Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872703;
	b=h1dS+ALIs3yhLxSpdRAcfBjUgJPRhtDqGNt5+/AcBoFNXXcILJm/LwWqxhYrCiGTENgf
	 ARnUHxxmX2ykIeiq2E5RR6LWocMQZr2kXSdmneSFT0R59a6/6HiFQUiztuyob99ATw7Bv
	 yqsxjOJ2bQKgujQ+/IzUQ/Rkx0kVoSyjFii89zgq4HtSBFtV8q4gshsjXKS3UmypQ7E05
	 R4ATeOxJ24HqyLhllpOfvFx1nmk42retjMlpDzFDvE19O2/mROHg8OanQp6dCADHyxlN7
	 P1jhZ9mIFph1D14MmV5g/QIxdY6EtbIdeMA1DpbAm/r+CwAJgWTB4mFlW4SheC78jlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XYtdB9fC0oaNZXpyzEfImuijflw3XCzjWjHX9P8DNso=;
	b=z92gt3QBOeaQDxOF1MbqM2edzqgY9U/Rz/28/Y/YL0cAMNamBRoUprdKUFfdsBvUgGJN
	 XvQmCuNDICEj8j1UAHjW67NIKv5KyN6Mv5kuxDUhQrSstOvfDBwAZufI2iewHPS20o5rO
	 R4pN9r2dqFMbFEA+TDFmmyq28c5f8hvMkp3AESJlHarwmYUeV20Q8cJXq/H43sv2YXcPQ
	 5iJxdBAF38xBWrFR3obH/p8/A32r8o2x1l9GDBMh8dysmdTUA3NAR1yJHY35Vpssv7Luo
	 4iCQf2Aq39Actl5eEAFI1UgQEcwYOPYyuc/s1fVGvhsO4FiRWa3uqpMEn5xzqQVRoGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6EuHT86;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194F606A32F
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6EuHT86
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCD81F01825;
	Sat, 24 Oct 2026 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872703;
	bh=XYtdB9fC0oaNZXpyzEfImuijflw3XCzjWjHX9P8DNso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6EuHT86+JKDHMAfA4vYAapNfllmkEbF52nRKICu0SAbCTCDqssbdd3AfqfiIYPF1
	 BeV+dvLfILKPeI+t4IPztbM3o+Xw+kSOc78EDRfUH/c26222SbuXxsTYnFQCv0BoGL
	 wZuH0wyM4fNSlbMYtzBva8NhsEWl0sguo0kBOEn42KVT2oIqH4zckEPmpFRnknVhRL
	 L+j/g9qd37s+I0E8VRqCmnNiGa42T0TvbthBdC5s8ZLxXOqoRBgqd3mVfupeBAtjAw
	 2u95a0bHKfKGmQMMarWNM7DkJDcrYAIqfWQsN2/LcxXcsa2sEBXwBtJUcxy4AfXxZI
	 //jJMLKPeDoKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	David Carlier <devnexen@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 6.1.y] gtp: disable BH before calling udp_tunnel_xmit_skb()
Date: Sat, 24 Oct 2026 16:11:16 -0400
Message-ID: <2026-10-24-1-daily-reply-0019-gtp-disable-bh-6-1-not-applied@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024094956.833-1-ue081723@gmail.com>
References: <20261024094956.833-1-ue081723@gmail.com>
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

> This fixes the 6f1a9140ecda ("net: add xmit recursion limit to tunnel
> xmit functions") backport that is currently in queue-6.1, so it needs
> to go on top of it.

That backport has since been dropped from the 6.1 queue, so 6.1 has no
per-CPU recursion counter in iptunnel_xmit() and there is nothing for this
patch to fix there. Not applying it. Please resend it if 6f1a9140ecda
("net: add xmit recursion limit to tunnel xmit functions") is queued for 6.1
again.

-- 
Thanks,
Sasha
