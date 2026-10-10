Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1B136672;
	Sat, 10 Oct 2026 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660619; cv=none; b=ZLOcDjj3pQqB5WFQkVjo8yim7SaDHzXgr4VkYc0DpSjQC/Ihq31tsvcYBMLdtkbGyBxCyq/j/sTe5ZLLhiibAeyKVVbUcqpnyzSnbPzAiMTO7a0/rHJ3kEAuQwpQhVkIcCh/IdPChfSM0r9i6hMPwVE437fLjtSROu28h0L0FeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660619; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUdk94/+qweNXALabclXM1ZJ31JzjT++w7ZW/wrKD2qeKS5MNDrShyZI4H36KML/8IMYHgGkrTMB+Hb9MCriHSWQxXq9TxiUCQLm70L3+9pQIh+TkarpFhAi17/82suKCCi8a9paqPgG9wbD1jfqGibQ18dE9v2RLaANA7zUTMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIxjSiyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIxjSiyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4A51F000FF;
	Sat, 10 Oct 2026 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791660618;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VIxjSiyvy7GPyHh7GPGs/cAOLj0L1Gpwx/jQM1Jfaour1dHT5yiRMVpwGTNOGwtiM
	 sm9Qv/IBYQb/cF2b3L78k7ffrxVIv5xTILX2kACDNQdhE1fQpN7JDF3TZNAM5sWQu2
	 OwBAbW6Vrx7jVYr86ZM/shIev5SlLBffsgyjgFvUNSgXSK1FH2N9HFkdeS2C2sgucA
	 J34vl5yWBhQlVtB6SxXefNg3ydRc2V0KTtT4C184Zu2VlCKaQOqK+o4VCxV8ZxtZza
	 GRYhEqbFkDoU1yK/8ODB1Sc8khxZ6RuWudbLFD6hzU6bJJ/ed9RdnKDLXQDNsDMP5l
	 aX5ISzZsfTLOg==
From: netdev-bot+sinfo@kernel.org
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-team@meta.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Dimitri Daskalakis <daskald@meta.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] eth: fbnic: validate the Rx completion path
Date: Sat, 10 Oct 2026 19:30:16 +0000
Message-ID: <179166061680.2527009.7996052669840871461@kernel.org>
In-Reply-To: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
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
