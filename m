Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E6471D01;
	Tue, 13 Oct 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909327; cv=none; b=CeYWg0C4f7F3XT+aNwR8FMFznujseqMhZyslYbtXR84BzmdrtK0fYynapMQEnq3q8WAIJZ8Ehkok7KUvchZ7+pB28d6sVlFc8txZgpS0WvN7G+yR/DzkZ6/lR1+xiaWZfq5sFNuBuITrs2a61bPOKWRDqbzg/3cIP55NBDqaIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909327; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7S9OJo/zXvRfF1FKeN7HqN4fwv+nVIwv+y4Bbp/MxfBsmmNHVcOvRmRKF7d5x20dn4JwzzMMwIlpGvhLshP22qk4MqOhpXDKt3p3N+++1/dQoUzFIv5cDHw1uQ66gEK9j0vYYPYIDVz9qC//UZDCzUAL+CLmP00XpKdNlIE5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp5MZOsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp5MZOsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAD21F000FF;
	Tue, 13 Oct 2026 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909325;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zp5MZOsO9Mg3vyFVbda5fz2O89DKziTTwl6AgMBlG6t6m5mQWbAPvUe5NoirLjtI5
	 o4AwDvdKCxyBD431obf8UefXbGVk0T8i5fBfwxGmy5hcqK5d5uW8AVUhR0K7oaPItV
	 DNbGIL67EPm1DMSSCEoLAfZoVFjHwZARlkJ/I3WKG4kQZ5aLf9HicZ8RU7NFKbZWQf
	 x9//M5kQ8opYkiY08cbGu5qSiedZtTVlCWhl2LyyVdUZHtndz+2hfDDoK49DAlh+6t
	 FOCzizbPmFV/svZAAHzryZLrRp/FhLgU2g8gATesGQ90P/HbeDtLBhV3x4mBRaBNL+
	 OX70QhKnziomA==
From: netdev-bot+sinfo@kernel.org
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, pablo@netfilter.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_api: unlink indr cb on a failed bind
Date: Tue, 13 Oct 2026 16:35:24 +0000
Message-ID: <179190932479.99822.1849833897354968750@kernel.org>
In-Reply-To: <20261013162949.25622-1-q.h.hack.winter@gmail.com>
References: <20261013162949.25622-1-q.h.hack.winter@gmail.com>
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
