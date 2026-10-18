Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687083368B0;
	Sun, 18 Oct 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792323229; cv=none; b=KjvHrytrtuYtsz0+JYHc0yH63QAk2eZmdS5XjcLhw+wEZ0n6dh8gjSjKDOcp+u9RkRmNohxku1f/2qsjDXpMOm1lJfa9pbQVJnuuQj9A5JpdAGcSVQr912kys5dLCsdCIngWW5O4eE99egqwXDlvCF/+mBugQ1hQaMAhLQZKu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792323229; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=huuIdmrNuHm0UWY+8P4MULS03kBynojdoJ5pKg1QV4JU73OP459gR8WF61VYP7Bx4dl2HFXZ8gy9Xl6QiFD2JEYkzAXUs5uG6oUE09+Wo8asDMeeLRyxXLQxh7TPSCZFpcQA7o0sBPSOM/dDWPueWdh8EgOLXkccg+tRWnxy3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxvT7YJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxvT7YJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9A41F000C4;
	Sun, 18 Oct 2026 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792323228;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CxvT7YJsy3ttXANa2ctmoyxUj5AqO87u5gTKQ39dY8zwgz+56IIdPvTwB+aPetE0Q
	 3ZHX28VuJviweh01F9da37pDnG7pmPlmdln8HKdnVmbTVux39UmoqLBxk8G094K5+S
	 +XZtS5eaML1anwbcPwwF2AXXhJ9xa6SNhgYO7cHWdQB88IUTnv1RWQ6AE4Ek9KSk4B
	 ExPOT6gRMEBqz0KJXDw6xIVhcuFwBWfS1HniI5KCK3Gd2EHH1N/BQnfzmixjOrHKGw
	 zXtke6b1kPqOVUUlj9yM6FHtRImqUop3wb7MgwlPaq26zMkrl8uQKoAvC9vL0Jp8tO
	 a52AusfIN9bJA==
From: netdev-bot+sinfo@kernel.org
To: Qihang <q.h.hack.winter@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, pablo@netfilter.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net/sched: cls_api: unlink indr cb on a failed bind
Date: Sun, 18 Oct 2026 11:33:47 +0000
Message-ID: <179232322705.3290.16461222882953603304@kernel.org>
In-Reply-To: <20261018112955.61470-1-q.h.hack.winter@gmail.com>
References: <20261018112955.61470-1-q.h.hack.winter@gmail.com>
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
