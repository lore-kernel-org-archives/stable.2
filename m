Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39249B5DC;
	Fri,  9 Oct 2026 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538221; cv=none; b=ILUDiU/45Tp0w1NFh73epk65vkSaW01+PteCq3ciFIHJK9TnB4tjluAl+dI6Li9ntssyyZIChbeWUbfnjaR1ViTJO9iutYkprjqNdRTh2NbHGqWkRx9IT1WZQfGO7WCSNuE1U9vm6eTdg38MzphfUJfFiKFVqC8sNlBubnTnF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538221; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5FyriGXThEE90KccTa2r8XOBs7RRi8Ko4CNpVRYl+VtFm3CCrc+9HqCoCf5moeS9mmM58oTcUXMs3g8D+YdGQE7A6Gk6L0hXl230AregVsPA/0OcrQUuLi+GIDYu3w6nh8jmfv7p6gQJtnX+n5SMPgNucXUFfcFqb40oWgmyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7suwIbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7suwIbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A021F000FF;
	Fri,  9 Oct 2026 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791538220;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T7suwIbNytUyRRDF1w62Hmn/3RfxNOgAHWWb5KjNxCgWa0DBIJnLPlas7pk1+q0PP
	 Dd+Mqk7EvJel9UbfjhL7nDCdp/8F6Ugh+tSjg1/P4pjKQVKEprjj+Oz0IdJmvn5RVN
	 vx9k9zmZqfOrlrWMUe5A4gCr8DuRG6A+Z5HPeaApcEE94V+LeyKQbroAs8ndcfQWry
	 8JxYYj9qiSh5Yk7ojqQcfoPZZykQ5msWqn0aQ/4CKqN23KxVSY31HNY1Xo1kA3h1wc
	 Y2oKxRGB0O6MDHaKjpLAQRrM+mdYkvIL1QFHI+/+/Y0mief17ZUDucCqS0u0TQMtR0
	 NQgooWauf0B5Q==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: fix socket list self-loop and soft lockup on
 bound connect
Date: Fri, 09 Oct 2026 09:30:19 +0000
Message-ID: <179153821938.2527009.3636567807399933220@kernel.org>
In-Reply-To: <20261009092338.3146149-1-bsdhenrymartin@gmail.com>
References: <20261009092338.3146149-1-bsdhenrymartin@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

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
