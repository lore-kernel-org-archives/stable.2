Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557572;
	b=R6QScVkMqLZxD/jCgy4X9xKipfacsZIUG6OFr6Q5slHjQmFC60Ofw5OA73V/6zNpxmdq
	 QiAVUty3lSbZdaWQUvO+BPhxdVYfu6yUq5mKlc4gt/+Qv4Nuaw+HWawKdVa0ZN8NCHvXl
	 wzBHByEFc++TwrKOnrQGZ/j4eA5i9nQpN8U99yhujtCRmpJUnb047jvRt0YEu3M5SCumU
	 Jt33QJBA1u/OgB1U4knS2TzEGAQlV0yuD6HBji+yAk6xiaRj7UZ0NYA4MPydiYpX/SkXu
	 bOzVAzDf0JHDvI0CQOnNJIM1yCrpkwdOFpzmA9QvEIAh8R877Jkes2ojP7eDWtHttZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557572;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZksgZuNOKNl1TH/noFc1nVuy/jJsd45gYszG2EUob9o=;
	b=j32pH2P3SuvbK5pZOLhOnyQBYxfLv+zu7x7/qLHz6WUlL5Xh/gaXT/nk5FDgC0uBptkB
	 +tDujNstKWSmzllrbuDBB1tIN4Yr1Lcx0bq+SkrfVod2oRjD+3gxS/lQQijG994kq4SiL
	 VjglnFybQNA1mfwn1a+/HBNMYg+xGAaAAa5KbrTYS1jzQj/QjqUQ6lFNI1yHL6uo27vPE
	 y4DAhYPNKI10fSh1yrWq15QosYGlD5pcXp7H2y7LkOepb9fOHtiX5wskpJ50rzZ5elwnj
	 Iyb7L1F22mb7PHtZvv5iVdH92W/3YYWD3vtKjg5+vM8s+4m+N/0ENfnYOIsePs99PVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZr6tMlA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22498606A31E;
	Tue, 24 Nov 2026 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZr6tMlA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3128C1F000D0;
	Tue, 24 Nov 2026 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557571;
	bh=ZksgZuNOKNl1TH/noFc1nVuy/jJsd45gYszG2EUob9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cZr6tMlA7dzu4E38ZJygKcTuOAk2nBBgQs1NudkepZp289aLPxFquzlQL+KsUuKu5
	 bKAICo+oX8pcBqU0pq1Tt5jXe2eHKITvBPpyoOBhcddg/z2oq4MQZrzjJp/5erxMRi
	 L0Xirs/gTZMRC/7XdHjlexCZZc16RANAT6mZnLWLUiHYhGJWswR1mXTER+L9yB0n7n
	 XOoBy3tP5NWBj8+em8dmBmvXsRz/eFMt5QL/rvUvpG5SEk++nhxTOkI6q1popzKfaO
	 R5hdPFAWekrxq2sCdDGI3MIhq/94AAwXpHlmVQKrady2JmT4N/xFB9OLUwOuxvKqDv
	 tyJvQNkHDZNGA==
Date: Tue, 24 Nov 2026 11:59:30 -1000
Message-ID: <8f4845c5a8f9f8927ab3903d6938b3f9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Breno Leitao <leitao@debian.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH wq/for-7.4-fixes] workqueue: Fix drain_workqueue() missing work items chained across pwqs
In-Reply-To: <20261123120125.375076-1-tj@kernel.org>
References: <fb224bad9baf5f44cf17e1d664776a4e@kernel.org> <CAHk-=wg4jAWZvxWo0OZ+fFTU=SBtQ7dnsUCV7hx+UAifkwPUwQ@mail.gmail.com> <avs4uWg9ch-Bqobj@slm.duckdns.org> <CAHk-=wg+MO19H7KVgA+SaZvvt5O+3Tp8AxHVhpN23JtaSq=G4g@mail.gmail.com> <CAHk-=wjm3vbiNYsR+aHxmM3KCEgsSWb379ZQbCuZEsN1dhvbKg@mail.gmail.com> <20261123120125.375076-1-tj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Mark Brown wasn't happy about the missing author SoB, so I made myself the
author and switched it to Originally-by.

Thanks.

--
tejun
