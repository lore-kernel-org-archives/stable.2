Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199059D60A;
	Tue,  8 Sep 2026 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907170; cv=none; b=VAR5U+LEUjDYRw09ECDolO3mTkf/G1pgjh1V+OxxRFZWI8IXshL0F3z9G4E4ae2f+zTZohRO81Z0EWYaZGKg1dAjXmOCpsSBjQG1T/3gIxFmAuNWMRRf9vpGHELBx8TXXb5dbYOEQLkO92N3mtcSvFYK6JnXtB9lHstVxQUESgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907170; c=relaxed/simple;
	bh=r4+6imm2cixbAzjE6HJSypfg3ZPolQpzYr9i7QBahjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPPih5pl4qSocTiv266h4af1NfXLui8sPmJ9Q2qbl7w2+mX+f8KJlmRlBaGGijUdVkh7eV55ELFqRvuo8m5VY5n/9O0OXdJOuqt/0gldoKSuaKQycU2IfNkbHdv735ya92YTgqR/i6cc+SMJihLrZ2gk86imRSEcxp8n6HaVsps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZftlDTKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZftlDTKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1431F00A3D;
	Tue,  8 Sep 2026 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907162;
	bh=BlYCZGR/JTnpR4X6mpxSSJVCoIWpP2K5WuhOaMyeRps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZftlDTKlyws3Q508jpZ2osnF3idMMmT0r4tS9igQdlhwiWrfMdYKfxiF0UHi4jtcS
	 Uwn6h9ApXNikfkH5o0LY+M5Z/IR6FwIsCpeYBwsOX9JWtwY42A311sj1aIRYwMZWGD
	 8rQKh5p4IgeZa4dawvyBK3mcTMozF//B4/Y0q357id316KrI/zq6LHI9Qh9etltREo
	 O54E6Rf9zN7I8ib5J4xGqgo+rQ76cF4ZXLM8x7HXLnvV5tcKdBCIezZ/d30cDFgLEF
	 /TdWR8QTcUu1WeoisZOUF7nYkvORWKoo6hj2ujzKZc4M/Moz76CqV6Eab4Gpqkre/w
	 L2sTUSpbunSmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	pengpeng@iscas.ac.cn,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Garcia <miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH 5.15.y] Input: aiptek - validate raw macro indices before updating state
Date: Tue,  8 Sep 2026 18:39:09 -0400
Message-ID: <2026-09-08-daily-reply-0002-aiptek-macro-index-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907184956.1567815-1-miguelgarciaroman8@gmail.com>
References: <20260907184956.1567815-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> aiptek_irq() derives macro key indices directly from tablet reports and
> then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
> the derived value in aiptek->lastMacro and later use that state to
> release the previous key.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
