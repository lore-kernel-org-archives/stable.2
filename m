Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6458379C57;
	Tue,  6 Oct 2026 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287371; cv=none; b=TWNMQcfFiOANx0KmvA2JFHQo9kGs5GYI6FFh+fc+UA23eIZBDI5LSNKnIpzggWQoF9QV6D0S94E5BKKLmyGTT2NGENwQ3ZCS4czDvJku5Yjh+eYjIGJLfmZ4PVm84rUJmAPZ0q2oQ2Y/WdSU/h0i1cIlg7r+uVOIWVu95QPkH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287371; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dw+Ft/ji0BUJFeTu8pEYE2a7kKYbln2lF4QkIbkhLFBvZ4nvyGXjRzgGQFC/K589vPZrGuWUiEeg5pjZq9FOerL+eVeeZ7FkN6NEUMzjh+AD+bY39pLPEBVEYB0mUG6bUeC7ZPnLjmZjq28FVZb812WBzaXOKSmLvSmavSyrPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9Ycfj7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9Ycfj7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D111F000FF;
	Tue,  6 Oct 2026 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791287370;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9Ycfj7zwFp2L4fcbEE9Fm/kyH7fR+WUFx37SoK6SaxV9W8bsf8R2QT/1aeDnQMD6
	 i/wSYHAaq6CYlPq+Xgs8AQFGTVQR41/+Yd42X0zNyFGYqF0hkZl4qsQTXrlezkrHjs
	 TpMzk36D1PphALcHAHARHl8lCJGCZP+iBLywM1nt0pDsUOkUXU1dmyWqXKPHOC4Ouf
	 HfM+gG0ftB5Cg2zyx8JzUzFcbmH7euI08A0VeXi3z2DyfzGbGmXLYgbp0F7gY4zL2W
	 x28CrqCgJbV8Jf0FbkxkmX4eLxa1Twe+WipkiDloRtY8+tNp1lMebRUtw6sOR606SX
	 OFPYgyvfXWVLQ==
From: netdev-bot+sinfo@kernel.org
To: Yiming Qian <yimingqian591@gmail.com>
Cc: security@kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] mptcp: pm: in-kernel: fix C-flag endpoint accounting
 on family mismatch
Date: Tue, 06 Oct 2026 11:49:29 +0000
Message-ID: <179128736955.2231598.11573311159059195469@kernel.org>
In-Reply-To: <20261006114409.117190-1-yimingqian591@gmail.com>
References: <20261006114409.117190-1-yimingqian591@gmail.com>
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
