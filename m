Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEF4477FF;
	Fri,  2 Oct 2026 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936680; cv=none; b=nW/aWVJ1LabTPhhgws9Pm7eent1/en0Fo1UlkRXjmmazXwjdU+X8ZXw5+IhSz/6ORGqS7jEDkhPHjPFFbJ2sdSZIZDTgI+l31ynOZceYUqpOAgxT5W7f892YCPG/HY0FSqE6K3ByWWS0dBiOd5QBYKt4vzFbmj5YxYxrdvVM2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936680; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AEXme0jyKCsM5A2oCDE/peegb53f1I3xT4HVaD2DZoROl+qwXdHiMPCBxoPBAFU7yu3nz4BUpFnUUCGLxYhcj3Ef1Z2rGQXhquFAiIsix9M0xECK6ain7MBAWKXsPgOkPda9mPPDUMGojgVU+hMhZ8ynxhNNyaLqZlPXh5E2H5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZfzIj9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZfzIj9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0153D1F00893;
	Fri,  2 Oct 2026 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936677;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZfzIj9xHpVjM2Ihm+aqNLABvYflErHRGaFc+BSyVsZ9U2IkTYtzmrlOAupDGFGVK
	 gwi/bXhVeq8khDvdl7zpmbK20/UNl0bWCgJpzEKCd2kDMiGTdTD7w44JH+eW7ejiAh
	 Oqgz7k/GIeryC4F7ArGHCUy4aUsZNEQwtq3FUU9W/iWfjq1xYZoCsZmPc9Xmkddefh
	 3SaxOiHWO7TxJaAucYrd6zh0qN/RZSlotreTA0sI6KbseMP+SPYwxhS//O18/IXZKM
	 hQ8ROp0RxSCGuYc2Dq/mQImX+SfrZIQaoRggiVaifabq5lqkdCXgztKdBNAnwh/emY
	 Q/1ZtpN41J8jw==
From: netdev-bot+sinfo@kernel.org
To: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, fercerpav@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, gwshan@linux.vnet.ibm.com, joel@jms.id.au,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: ncsi: clamp filter table counts in GP response handling
Date: Fri, 02 Oct 2026 10:24:36 +0000
Message-ID: <179093667644.1402591.15174022673680128182@kernel.org>
In-Reply-To: 
 <CAANnmVBJ7NCV-SJrFtT9FO3VnaCK3xG5UzNud4xxoicxpY5qCw@mail.gmail.com>
References: 
 <CAANnmVBJ7NCV-SJrFtT9FO3VnaCK3xG5UzNud4xxoicxpY5qCw@mail.gmail.com>
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
