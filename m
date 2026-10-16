Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B447A2931FC;
	Fri, 16 Oct 2026 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123729; cv=none; b=WzDYO7YLGfDXVTv2MFBgn6d4yjb28NzFR+g/bu/2KXUpYPMFYkoqnc5bXtz9pPM7NaMDIQL2GYgu5NDa93BSPOrPCFqt567Gzl0Kx1I6LyNaNMx+x3jtp5eJ2Mu7sTJVlZfj6H2yaBOY8KbTleP6modXeDTgitup5jtoHJaHOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123729; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XSSi5dr6A6EGTJWSSK00LejzSFGZMXDfZlGwzWgcsr/HyHOtKMTH+riT1DkjE2gSSpq+dSCv1Mlj8hy2gSjypUAgZFneePl11xkb6VJJ6KnmCVnYrxjUVbONL6afBa1nK+xek94Gj/mBSTHBgPj4TLXwghr0rmE1aje3E6SGook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnHIoDh8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnHIoDh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54651F000C4;
	Fri, 16 Oct 2026 04:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792123728;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnHIoDh8JP6ZRCb5noj1w6HpN487MM8mYF7v2olNZVqN6HnFL0CYcyBepeeSYwjCE
	 IjbLr/dO1hcl67TO9rjxsso1aBAEfwHhwP7oH3pQjv3fwIKu+t2w1dCMc+d7ZF0zj0
	 g596E4QjJOOqYZ+uENmI8YagSnXEhG2tLcL4HpR4d1rWPSIeaYYFRiEHvn9S9MhSqc
	 3rV/BGV4QEZEa9p6z1iihiDorGbEMYxpA6FPLi64WEZGNfAQhztVnjOdyiq5vgek2P
	 ZDOjQ03w5b8KEV3fHuGzTfFvJw9anD0C9WpOvU2ZLks2GTO+TyqKlMtSVREPzU4B/Z
	 LJy5LCZ9bM47A==
From: netdev-bot+sinfo@kernel.org
To: Wei Tao <taowei@kylinos.cn>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] net/sched: cls_flow: avoid integer overflow in perturb_period
Date: Fri, 16 Oct 2026 04:08:47 +0000
Message-ID: <179212372721.408196.16574878004097287123@kernel.org>
In-Reply-To: <20261016040330.59041-1-taowei@kylinos.cn>
References: <20261016040330.59041-1-taowei@kylinos.cn>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
