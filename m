Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F52E06EF;
	Tue, 13 Oct 2026 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862166; cv=none; b=a0YS4+36uWOCqkGIk4PtkXA9LhrfeTen8j0Ul7noQMs6pCHDiOwmy8pXUSKQEeg5kaFnD1rzC8+cCeBJUfp5fCcM11gEUDA8JwavRePU9QX1XXtI6QzTVMrNn120HZYjHnxJJ0Eh4sG+m32oZaPHKxms4H5IKpYBE+lyuJp+61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862166; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtZKaS6IujJwdfx5A/BI/zSX/St4CLN352OPwRIjfjrySOKWFacygD/VMK7ZiMZw9l+5ipAS8NaaBF71QvqmMNvmJEDkQR6czYb6upQTxL1VqFAqaTXGb1wTF6Vz1UZ06+lIwKS3Z/Xjx2z8e+eig36U79cOx6n3nRbpecZSrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYnFXpkM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYnFXpkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D561F000FF;
	Tue, 13 Oct 2026 03:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791862165;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bYnFXpkMNtiJAML/w5KxQ7cWKsQmhDiXM0x2NnhfiuPdxn0wwg4B8979yGVrhm4q+
	 FLXRfZaHWovuTgweq1Hm75MNV5WL9DemVgdYkF3vmm22EAEV9XHoaf4dcVBW0Igf7G
	 odjTRBgGLAeXYRUaabEeqR+y914M8nKO/LQbvJ6j4LnHdzZ2RNmbGpumvAoRRk4i6t
	 3YpVp7K6dTrZFv9FataZdyCB0yhydd/JHGiYc2AtwjN1xsIBkOp0nMEOunrab6SWP5
	 og12dum1A+fZsX+D0GymRrCqwATX9Bz7LxeDhNyKnOB9szypR5Zk7P46KfvU719gzt
	 gVpF3L27+B7Uw==
From: netdev-bot+sinfo@kernel.org
To: Cunhao Lu <1579567540@qq.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de,
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] can: rockchip_canfd: stop bus-off restart before
 closing the device
Date: Tue, 13 Oct 2026 03:29:23 +0000
Message-ID: <179186216396.2527009.17545175870858054500@kernel.org>
In-Reply-To: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
References: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
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
