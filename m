Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F13314C4;
	Thu,  1 Oct 2026 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861974; cv=none; b=FxRKEPlbwPC0fpi3twYxa/2bVYhA5iXZByg80NAvWsguag6rMFJ4TFJxsylm6kTW4NRznrLPl4nxtXhj2Rg5BI3P4kL2P+P7kyZ7Niz2jiOXdtB+QL52+hwRuuxeg7QKufcPBaTuutObhWETgBiuSbVEErpSCS9eHcVcQneRb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861974; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7n7u+uDhn3eIyoBW2lkivjvFtQNyH86P+7YhEvXAIL5ylG2gqPcmZ+DUBxuRfLrY38SgHQlIgisPQRYxJcetC+ZJw0ltgAynG71xQxDv7oRlDTOZ4E/wX2eRLUGf9u4w50ezKUBfLgrpF1ZcEGgjJyVTu3CBLiIejyl0lOrk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXWbgXib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXWbgXib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB4D1F000FF;
	Thu,  1 Oct 2026 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790861973;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RXWbgXib9VcLCV35INB3aSLq5xLEfm5fp3CKoXK1tjEx4fJ0fKDUJVUViP7A6aZZg
	 iGEYE1tpE4Md+2iV5dxtGakSlPdhHasSUQtlAjYS/Mu3emXL5S7McOqCDXjB1UX4lG
	 AebGq1EDzzFqbi6ywOlj45CTtlGCNv86wGMWMuxWwdiRc2aoBE0SwTMO/5A+JTwJ+d
	 +b7Euxi2N+JsXgM46W+sbRm8rv1s2WW6Z8HHynBZfrM7BapZikppQe9oFThFwUj1fV
	 CJIH15CjE81jf/fyZEMPD5Rtz31JjJasR9Dgyxx9DvMqkLtLGjKvDFaCbOLB655cZq
	 F75lzDSdthAFg==
From: netdev-bot+sinfo@kernel.org
To: Artem Novikov <naa@amicon.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, lvc-project@linuxtesting.org, rrv@amicon.ru,
 pchelkin@ispras.ru, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15] vxlan: Fix potential null-ptr-deref in
 vxlan_gro_prepare_receive().
Date: Thu, 01 Oct 2026 13:39:32 +0000
Message-ID: <179086197227.31693.8704060058711859109@kernel.org>
In-Reply-To: <20261001132039.21201-1-naa@amicon.ru>
References: <20261001132039.21201-1-naa@amicon.ru>
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
