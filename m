Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903967;
	b=E/N2Y4mY+kOaMWWcNkxVEknLuRqwaGFov4RNNYVIYE/5Csb7eK++a2dOlB/+5jnf9K6f
	 f/IsIvSjck7rNfaGznwNFkEkLO3cebeuxk/L0k7ojL6lqIPKctdZrflGLZz5xs8+GDjn8
	 UbIrSmBU6WHPAJS1VCtg41a75zY5qcW4ZCO83y/c+KWwoEx7R1nNyf5m+265vN9ajHlyE
	 tvylt3Jf7L1idDUQq7bGp3dE5Hg9yu7u9Uxb67ci2AQ4KV+bge7W4m8VkCDcZrJUl0AXn
	 sozRJGhe9t5+pe2ROpo0LLo6pxh0cazRXRA5qo7U0b10cMjsge/3/gVxCE0mGdceh/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fRRdVoP5JTvm20m30RWihnQilDQOdRSbu7u3cc7HpKs=;
	b=h0Vzh6XGaPeg4VA7bBBuvhUn8S5+LJbgRFvzDJSYCy7EfefRKyyKHhKC9tZ6u+ykN1Qc
	 fOAJuDbQAfCf8LgFfqPi0X3UOTMt+iL35bM6RazMMCQ/mwng8naooLuYVGn2NhAPGj6U0
	 oFBpyklxWgJApi1auw6bMIdJAND2GsQDnlQ7Em7mwh1Em1a0b2UfN4R5hWgJNUMZIB2lu
	 JRmqkBLZyFGIV2PTpTisJClf56N7SB936/nqMt11ziqUvmsQljWYocqpXBvX5LyC0uLXi
	 I4/UozbdGk84XnV9ywrGMiqBpp7S5AuXGYZlaPzbGayFtZ3axJ6l4iYRmL8Vsd232Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kE64j65T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518D606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kE64j65T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C431F00919;
	Thu,  5 Nov 2026 18:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903966;
	bh=fRRdVoP5JTvm20m30RWihnQilDQOdRSbu7u3cc7HpKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kE64j65T45h6kR3BstsvqVvWfD44l6gxT3qDoPaSvy4Yl8NWGwSkiqZtzJJ9utiw/
	 XMqEJi3MELbNSy4eTCaHuIqmyBARwHkwSvzQ2E9ILFF3KiF9eu9hfSvZLyCSr7PJP8
	 Imm0gzqpUgAu7989YW20clQqu7AONCfdUp3sleJau+vDoHtwAKVaFgtk7qIyn6wARZ
	 UbFU1dKr7FTGU5zR+vqAJt7LPkwTfJIJxdfbNTK3V8Roh6hrWuCXMxAinx9qVLgiJM
	 EibID6Uyh5ul6OecYZMKzNcnoidmvm3ey2EaWIipoeXHXwjSVLIxpwAaKGeJUcN8j+
	 TzOuLO05mM6xw==
From: Sasha Levin <sashal@kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 6.18.y 2/4] KVM: s390: Enable KVM_GENERIC_MMU_NOTIFIER
Date: Thu,  5 Nov 2026 13:39:11 -0500
Message-ID: <2026-11-05-1-daily-reply-0006-kvm-s390-mmu-notifier@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105134924.4e417448@p-imbrenda>
References: <2026110445-lividly-gratified-dd5f@gregkh> <20261104231214.887398-1-sashal@kernel.org> <20261104231214.887398-2-sashal@kernel.org> <20261105134924.4e417448@p-imbrenda>
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

> I'm a little confused, why is this being backported to 6.18?
>
> KVM_GENERIC_MMU_NOTIFIER should not be enabled on s390; s390 will not
> use mmu_notifiers for KVM until 7.0

Thanks for catching this. I am dropping the series from 6.18.

-- 
Thanks,
Sasha
