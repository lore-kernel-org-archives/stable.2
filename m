Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786073;
	b=v+xcZZSjnqVB28e/IcMhEPdmI1SaZorE4zUvFwkQTTVBXaNRbho0N+wRBQFdUwrKJty9
	 Puzb8FRSOy1t8EUxgATtKJ0Kpikttpt0bDf+OtsNqxtN8QZ5XrkXmHtmZEbcEeFI2wyUY
	 xAul3igVNPIYogeXuKRI9Y6e4In0zCjOk3oRCRy9w/bnWE0enmoWlGTlFwQtTPQH29SWy
	 FXaotlYt3E3/eFePrrqXd+hLtGZola2JbJY6nOM1KYKE28zFkAnyy85uOe3ato8TBWQkc
	 +gSJV98iecf7KbuUDK8STxQ+y2ZJn3Ke8Q2vpQUl8i7negQ+3TyXovxmzE+xzX/4Y4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eGf9q//nEMy9qxYJF835gw6PsliCRg6lxJY7kFoZRfc=;
	b=OQo3dHw2vmgxTl0RBaI3H8RCx0uQ8rn3iiaMcW6JgBxMzClf5HOyh47rkGYzV+wBCP7D
	 GxypR04LqnUqo/tTQ6/J5cJ7jV+AtPXQgnd1xkE0nYf7V1CJ2/TJviF3YAzJzDMqaoxF/
	 pGO1GVeE4kQrGncS2UeRO1kPkP7QIRecG/qMWn4T0J6Hro54UxaLD8XCO+/jmagESaSPA
	 Vqwu2LyigRrWrFf+DNhA0GsV38vGeh/jxaPfPlbzvyLuUS80q/x0IIl2mGgawGrILMZng
	 Opbbgu6VBqY2rwHymJ4/8A/D1BeqM4s4UV0ziJy2lNYHM07waXWaB9agHXfJQAsZ2YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYJOpCiW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86394606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYJOpCiW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC54F1F000C8;
	Sun, 15 Nov 2026 23:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786073;
	bh=eGf9q//nEMy9qxYJF835gw6PsliCRg6lxJY7kFoZRfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aYJOpCiWnlrYIJyhhsWvIhFR89vlv5Zw+ylRqKGbRCtp7anI6bKZusPpLFXb4eqLm
	 4LZ0Iyg6R50zKGSOBqNMEDT6ONEXv1C60OlMcMcWYkpSr340hoRxD0bZp8TNo76rJT
	 vbgjbqdHqhALCJmMrgpHfgWknk9gwHHvf7qqUXK3kf7sIE9P3RYO2jEKlUfDvzsvAV
	 l/sdX8LTXx7QPqgsOBJ3zZbPGjaJuVbvCshh9Ago0LfyAyoEFcTgZ/+YB3tkQT9DVz
	 j33rCYZvKy5lLIyA4qkUxo7IQ7YMaBvra2p2e5oqu29XGjtEXZ3Hz3wPRHtDgfK/Bp
	 LKCl1PGq92/xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	ljs@kernel.org
Subject: Re: [PATCH 6.18.y] mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows
Date: Sun, 15 Nov 2026 18:41:05 -0500
Message-ID: <2026-11-15-1-daily-reply-0004-mm-vma-lock-seq-618@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114183034.70512-1-ljs@kernel.org>
References: <20261114183034.70512-1-ljs@kernel.org>
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

> [PATCH 6.18.y] mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
