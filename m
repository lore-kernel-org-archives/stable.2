Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092139;
	b=VYXbXnoZ0bCk7iVHMY5DsWULHf4biBwL3In0S92f78fERqSx24UY/X12sEF4jgyrY98g
	 5G1pu0KAWkSlQresdL3Fods1UUZnuaAF6zcBT7nPJBsgt/P84pG2y9tAD/FiFXchUOmlN
	 /s6+VT5hyAsVHdtHHjtLiqvrSf5bpVKIMQKHI9BjDSuqePSZMMqDYjr+bikcQlpZ8iLD1
	 Ymx0in0qVgbaO2r6Ml03ATwlb89gCUk1yuURFbjbPjEicvNoHdKSlqB5p4fcVezkaYL8h
	 0i4aSwk5IEyrpvmR8s5LRe389xv08aequwblwfH1wG4wObUHiksb0Nc3NdyX0iTYNqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092139;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=jo5lzRe8EVnpLao4yyWpYXmNJbRmULl/8cO7dd+99hpezJMPsv8M+jGwylgQ2vzEw4wo
	 Edesh1Gk6JeFVvnB9NEiJe+lJAOp/CsfxTrLIE5zluAzL0T+2E/U6hbJUjFPmDCHP2dTb
	 pH4LT+FWm4JiEggSeG/rKQcPMhcxGwIlr+ASa8NC8QruqbQhcqaujtQnlqYCCfmCVxFLN
	 n+crgnhlDrZBzhvsqBusUaKiGY5r6LTDz87r/7NHOMQbE2YP217JlSBNGdMTaU1vtZ+bi
	 g9Rzl5O6IBR4SU08HQ+hHNULE64MFgvekcMvWsIITPuW6XBP+HmuRg6VXYd//aoCrVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AENENKWX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945D606A326;
	Sat,  7 Nov 2026 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AENENKWX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870261F0089F;
	Sat,  7 Nov 2026 22:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794092139;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AENENKWXvgaLOyHly9mC+sJ8w0VdjITTc+nvUShY90esWkZ6Q8PlvIimqtD8FnYkl
	 faxgJZSAZEBKWFcYZaSKIV8eBZxBVGV+56zP3+1937JSf4ZugSCfgjg8RiRlDVg2qc
	 LwdcvC6X563AFEF24k4J8j7Uq8UKz4kGa8ebLpTWMGoVu6UbEsXMg0XHmd5pObqEsn
	 Dbiv5uupLQl4j9uZrGnWzh9rz9qCQJy45oFigZUsrOkWZF1uz5VdQ4y7Y6Obtf9qR/
	 YMN7TWCwGYBLJ4y4m/qd9kVP//xnpKT9mExR1u3D7Pn8M19haHqQNo2oJlyEL+nzcS
	 k2d/DexVAHaYw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Dmitry Safonov <dima@arista.com>,
 Francesco Ruggeri <fruggeri@arista.com>,
 Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] tcp: fix authentication bypass via unsupported TCP
 auth options
Date: Sat, 07 Nov 2026 22:55:38 +0000
Message-ID: <179409213805.488859.18022217711251450793@kernel.org>
In-Reply-To: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
