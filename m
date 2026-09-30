Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F113164B4;
	Wed, 30 Sep 2026 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760841; cv=none; b=cbRdEoG4TWkjw0+pSVYxULVlAoWlslrvou2VJ7+xUev6IUofRlHPCtLqvpIGh9YGyNvUdTuc1batM4nmV9dDVaw9LJ3BvEps/3Ml0TkP1bzwoBmTa6EVJjTz93hODKVebxRtaH64y/lyZJjGKEs1nTbBYJQnlwtpk4R74kQOJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760841; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eo5F0jT/r+J5hVwv/mZXBj10pkNh0Nxoygk0d8Q8E9HEu6yiudQzKbcUbV0lgr46rUSlQPZoDnVf8Ody9Xd3ET25eP6N00Pe3o9aqpmIVSxqQxRVu58h4cldnobXKPa/ExG2YICieGJ9p3Br1xAKGkD9CncU9LZ0plw5k+FQpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWxG3nCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWxG3nCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0AA1F00893;
	Wed, 30 Sep 2026 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760840;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hWxG3nCDZrWLmetbhbBgNsmr0c8/yZNTV7HdNINYkSC8C4rOdnSEXmuhJgTNWh4id
	 96O+6zZPMPuRRpsebP+D0kt+QYTp7Us/ohmUS5C5zaw2iogWKhp9+xCC1tg+etCR5P
	 9glXbuCP9rVqk/hOfhg5Pjv4lzeM58/i85HSr4KBbdl9FsnwKPwIbVPsKUGybMsGfg
	 1d2Tej8E3m8XDDv1S0yts9DAcU525XcqkYg8qFLt30uYruhHu7R45rpxE8D88zgLfm
	 ZKGJdGsitDzpn+pqTuy22Q8+HQ78c6OzqB62CQXuMjcvjQ+7ogsyeSUHSpg7+25DGt
	 0h4Ya/NHSbQng==
From: netdev-bot+sinfo@kernel.org
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeffrey Huang <huangjw@broadcom.com>, Eddie Wai <eddie.wai@broadcom.com>,
 Prashant Sreedharan <prashant@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] bnxt: prevent timer rearming during teardown
Date: Wed, 30 Sep 2026 09:33:59 +0000
Message-ID: <179076083948.31693.5116207941809657090@kernel.org>
In-Reply-To: <20260930092806.2977763-1-runyu.xiao@seu.edu.cn>
References: <20260930092806.2977763-1-runyu.xiao@seu.edu.cn>
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
