Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104523;
	b=SxpjeU6r9kU0oAYNygduLWhPJMde4lQdX+nUBvRVMmNKjCDIDjsq9WrIh1YSP3ALx2Z6
	 UasB1kp7k31jUXfTBPv7Ic3+K5CMd+cJD08A2MH0ZwsNUp6QtiqfQJdcdVtWmU7pc35LI
	 Rh0/DzW9Tfmu9BGrzCVnRHtIGxzRrUMUk4Nwp6JVa8jFqP7+uc3+eY+ZKXInaGY09jh0C
	 thGwcr7QmqYInksj/S/NlkniGNloiKftAs51RQMrz9QC7OXHy8vqqutEf6cILzXIrmBu5
	 szSEUInTBRQ0x/9030Ad6zP9LldxeHoW6agELoKc8IH2GcLQH2dLM1Ek8VWkgaKTNyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104523;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Zz0FJVO+7S454sw3tDLHsxJZF7cWsbxVWb1LkZmuVo4=;
	b=VxmG9//xbU3CBySFEZQlIWwhRSfUiWm6P24Kvsf2sqSo6Z7O155bb9JOk0dmPNVkTlJ5
	 PQurN/SRCBeaOC8RCml4vu6wgfPZMl2NOrz18h48nziFmk1WIGKeXTopVTwSS0GuGbYVc
	 5JF7VoPgh6xc95w2HBk1wA2yiLpB+vHMDw5tqP3G5XdwEDXBlwPcBJjjyI7d0C8NmHzcO
	 mU1oG5g8OLoIE5EjeqBZz4aaf0NCrDwD+I8s7UO1Y3imUafSfm4sS1lYh6Gb8R+BCMjtY
	 sPgY/dHU1REpB+GiSjg3t72hmne8kZEPo4RCXaSpSNgbgvy/MSFVYDC4msxN5glO+EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ib8uNe+0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71960A2623;
	Thu, 19 Nov 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ib8uNe+0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215A51F000C4;
	Thu, 19 Nov 2026 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104522;
	bh=Zz0FJVO+7S454sw3tDLHsxJZF7cWsbxVWb1LkZmuVo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ib8uNe+0TsO9MTLvxHXWMGoMSzFLYr2yDyTYTdEZaBfTTMMTLQZLLtkmnHcLEQF1R
	 UQNQeSYxbx4MSg8FOfkPjb5UJTrTmaZaW+005JPFD/yuZiE03hEsPKhOCs/z/4GS/U
	 4201Z9Fnz3VRIazzDH/dWkfwqZpXiG7rZooQMU6wEP9TN0bSIV9JNUzSVbXSI7viUS
	 wl/6QGiR/iWXp1gcFktGwNRI5G5w4o8aZg3aD/58s6NaBzUaZwcQh8FKhS8rvHy5p1
	 VWkRXP6DbnV52WrHjS8+FE0R6D5eJNHnWVJCTCVeQvDwgUhY+LTtKti+N0C+bELo3P
	 4nl/VrYH5rkpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	=?utf-8?b?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Subject: Re: [PATCH 6.6.y] Backport request: beaf0e96b1da ("bpf, lsm: Remove inet_conn_established from sleepable hooks", CVE-2026-63865)
Date: Thu, 19 Nov 2026 11:08:10 -0500
Message-ID: <2026-11-19-1-daily-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAMcAce_TKY0jMqggzwoYgB29OrFZYAi8Qae3Q2ZMVP_qKOAq1A@mail.gmail.com>
References: <CAMcAce_TKY0jMqggzwoYgB29OrFZYAi8Qae3Q2ZMVP_qKOAq1A@mail.gmail.com>
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

> Please consider backporting upstream commit:
>
>   beaf0e96b1da ("bpf, lsm: Remove inet_conn_established from sleepable hooks")
>
> (CVE-2026-63865) to linux-6.6.y.

beaf0e96b1da ("bpf: Drop task_to_inode and inet_conn_established
from lsm sleepable hooks") is already in 6.6, 6.1 and 5.15, but those
backports only removed bpf_lsm_task_to_inode.

I queued a follow-up that drops bpf_lsm_inet_conn_established from
sleepable_lsm_hooks for 6.6, 6.1 and 5.15, with you as Reported-by.

-- 
Thanks,
Sasha
