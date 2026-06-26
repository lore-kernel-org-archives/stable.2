Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7F3DB62F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492580; cv=none; b=MQdY3wabZRN3uaW6YKUnfD21EQN6jPwQe1vXMeQz2stuCd2ut7YjgDae16tiuKX31V2Z3yzsXBcS4oRea+dIE3JidHNUUUD4NGCYQLrPcnnZ/D4iBj0O/2EzNV7QXj3GNUOt0XY3FFiCy5QUwJmy+kSB90pR6Kz+LE12x7k+GUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492580; c=relaxed/simple;
	bh=LHtnHVcHvaGJI0X6HGdEp2HjguFCMl0poNtw25Olve4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VyJ0ZrqfQidGaawkIyrME+w+pepTDFZNHnBJjhl8cRZcwN6mdztMKAGOqKRwVljfbM8BEL/cB8j/6ug0wVt80xSDGgZz5kdv0mazKP9Uf93P9KpJ1ksPqgLgKRkHW8SEGpRFJ48bybM8rFFPM3q/6y0ZSTFEGLcz/fLK7hQcSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n1iuLFxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="n1iuLFxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E5C1F000E9;
	Fri, 26 Jun 2026 16:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782492579;
	bh=LHtnHVcHvaGJI0X6HGdEp2HjguFCMl0poNtw25Olve4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n1iuLFxpMtpGE5mv8i8CbeL0peisfF6NQmwEapcRmoyn0NuxB0bkwUhVHqK4zw0Kc
	 kzDG9Vks90pZFG9J/viaaKHaR+dB7b4qEEs7jEbvnxYjofzrjzupYGHE8osL4cs5UY
	 RBzWLiqn1cUux1NGfJd6Wio3AfOhlTwQjtlAH8nA=
Date: Fri, 26 Jun 2026 09:49:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl
 <aliceryhl@google.com>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix CONFIG_STACK_GROWSUP typo in
 tools/testing/vma/include/dup.h
Message-Id: <20260626094938.a28667d2aa090fdb6ad204aa@linux-foundation.org>
In-Reply-To: <aj5qnsGDPC3nREdT@lucifer>
References: <20260611012258.432043-1-enelsonmoore@gmail.com>
	<aj5qnsGDPC3nREdT@lucifer>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 13:06:23 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> So drop both Fixes, and the Cc: stable please as per David (Andrew - can
> you make that change? Thanks!)

Done, thanks.


