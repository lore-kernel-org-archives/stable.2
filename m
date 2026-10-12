Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD8318EFF;
	Mon, 12 Oct 2026 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792858; cv=none; b=sQqV/oMOyTj+DN9T/VGhD99q9xFJL9s2Lamuv4xSjfa2OO4ScpgyLqHwJIAoAIR06AujASnoaRuulrk/BxKKHY3R6Hb6Yiv/7uTYhueUZ7yQv/x3xs50vv9k0uqfmPwItUh5p+zSmc2VnToadK6nAquLZlV0bthXij739a4L0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792858; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKF+UEw125yfri152bYtHaNeDVmh4NhskFIsdWbXUctb/RPbz/kQCiSj0nFziWuekZQQNdHd1BLMjTrFZ96yhMScI2BfTxn4hWbnhJ0eZqHRgJdqKTYDRw2qWiLj2YnX7s+GvzFK3S/22iL1gG5XqCOowME73Wn0Dk2wWaIkGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2MoLppp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2MoLppp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41CB1F0089B;
	Mon, 12 Oct 2026 08:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791792857;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2MoLppptIZeabDpqce2b3XVxYnM9MgzdRoeVHP/8A9NNei4/K72hmLEdyCs8Ru8f
	 PYKwQ2HgMaNUE+yr84R4hxsH680ZuN3TKqqXrocQleifwD9a8ZukZULgNf/lcN1RZs
	 C8xdogAjLTCU4QKC4PxV79Zke0QMeMtxA1qo+zUyD/B1hskZZmP/DCz0pe1gAYDCRQ
	 9CdgfkCm3BaPlkYnMSv//PabEvuqXwcP93J2JugnpCn7o3NaEWky/zbH90apVBwePA
	 /7rhzquhT0WTGCnm2qvGwLx6DS8soYID8i7J23qMlR4GtI25PS6ZQm/0qwU0CVTIAN
	 +RP5q6ZY+Gidg==
From: netdev-bot+sinfo@kernel.org
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net v5] net: libwx: fix VF PM suspend/resume flow
Date: Mon, 12 Oct 2026 08:14:16 +0000
Message-ID: <179179285643.2527009.17221471747115363529@kernel.org>
In-Reply-To: <20261012080913.49444-1-mengyuanlou@net-swift.com>
References: <20261012080913.49444-1-mengyuanlou@net-swift.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
