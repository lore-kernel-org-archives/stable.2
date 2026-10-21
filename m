Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611502;
	b=I/ucdtmYEbO9ARlLpXH7GDqCK4+lQv28mpVpA6dwj7fDZXHKtlo5NshF/Tln5+DNqXlJ
	 xn9jTo+HfZEnonIZmHVXt6KsXW0b+2GqYfxXZhsP8NYPH5iaHctjOGidIqkl4ggnUq7aD
	 JObaK9RYeAysfAxvYsaIiWhP/j+5L9NvbI6PNNDgGioAIVwoudAJcKeKpi7m3tkPnWn+m
	 kVYcNu5OJeK00eZ11MuSqHorBWng8jj4ZNcf1Zwm76cZDjBGIU8720mfv3ySpFOLrAmU9
	 M4d9WNRBIglBVcFLxLZSm5F0m8zKQo+U1ZV7RYzZDFttpqmb6JrxNtg6rhQ/ng24rvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611502;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=CkYQgiQUTNjWzLvekhzWBPzyb+2FoArIfMxMunavEW3uSskh7F6NpkAEYsPgD/i3OCTJ
	 bOWW6UGuewi2l/jTjkQYmtatQnATTPzVipeQRxvP5FuIKhTxkTkls9UbrVHYj1e8syWFA
	 JfSxNF0gvOsnsUztDGXYIE6O38CiFZJ5RgNFt9RCzELaiY6d6LCVq44GCRnZQwlh0TRzI
	 eW0YC2W6puiDt+3rOYUUt3xQcD5ACycqWObyav7Lbi0ArtO7ZrXndEtt1gFr47VJSpDyW
	 q/Q+snkClEIDm8Dv/gCXj0Ukwc+SkXAVwaU2EPGcpO6RbG1zYmTy4U453ezqePQ1okg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJGF4hzI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FE606A31A;
	Wed, 21 Oct 2026 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJGF4hzI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EFC1F000C1;
	Wed, 21 Oct 2026 19:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792611501;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kJGF4hzIvMEd9ibKNlucw7rb8beXp8+vQC5N8G6LlEUM0PQ3mH7TxEHSdtsHgtWB2
	 nhndT+PkAeIxAyjQ83Hhf6b2KiQ6bspPRVLRwsqzMoXY1Sm8YXI/IHoyNBKptGEZuj
	 hKyNUSXW8zuz/DLPXZbPpe8ctVfqfYWWwnoLXex8DuOWkujFqYBs11HdJeOtQkHmQy
	 PsPXAYqg5i9L4c5oVz0XUJVXj2aeOZ6Fhu5fzSqs45FVTep3If65mVyOFbYMlR3r8Z
	 gpeQyv0DWwU0h/QqYYqb48o8qwcZj1DbRmbo8VTiX9oFWFMuUiGYs4VH0XGtcJ+Ypa
	 5MkHElctjm9Pw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] tcp: fix authentication bypass via unsupported TCP auth options
Date: Wed, 21 Oct 2026 19:38:20 +0000
Message-ID: <179261150089.3290.10796131741281208278@kernel.org>
In-Reply-To: <20261021193151.1819085-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261021193151.1819085-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
