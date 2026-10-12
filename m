Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964236F8E4;
	Mon, 12 Oct 2026 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790462; cv=none; b=a6ZDLznAJm4Qz/98WczeJqoA2VMG0VOFc3gomrj7UO76/1yz4WEBUM6tO+5bRkVDwLlsSOyjY0+L69ncNAIbg2v9mzdU2NvBY0tpneSdX1bwp+xIiznqJYbmBGZcaEw+62C0Pj9vKAspi53Sz92BViL1hQRQARsqBcZItMwAAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790462; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYifa91/HsBFqib+JmK93VIdxcD1f7zc8EXMlNyeGYRf4K4+3fqtP63wlFnZhX4fsrD0PCS4nwfSvaMPGs0wWSjsgTSKdSCK5Gw4u6k4QryhTj78ZDOFc/eRSExMN/HZ+9Py9PtxX7p1EQKSWK19g6uy0JvRt5e720vTBWzSLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYRwkamt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYRwkamt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6831F0089B;
	Mon, 12 Oct 2026 07:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791790457;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gYRwkamtdaCFrqHTk1qrlaxClF7xQ8/EK6Qu3+UNdZ95gYl5ISpBw0Plcvw+oFhG1
	 NoQoBykp1kiH+R0qXH9mzQ3a0ttCgkQPH33tjy6SZYwcYnnul3qnM4bGf6IxEn/iXK
	 ehs9rnxOvA/wMqouHWrgAYDWmFx8el8E4o7MUFPPeY8+ygNlWHRAnqKemnUzjHQPvP
	 nsK9+/IIlf5Va/9596bj9dDNDTWwJ5pt1qLPgiWCYw3QYzIAOqXriWk/GMkikizw6g
	 fUgwgMnLphykSD69N2RkBu/QKdKiHNpY5DN77TxuQUOB/icr+gKjUKR6x0z7ZRsDqA
	 4EkytS4wJub/Q==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: wait for in-flight Rx polls before freeing a
 representor
Date: Mon, 12 Oct 2026 07:34:16 +0000
Message-ID: <179179045626.2527009.2374745016618209052@kernel.org>
In-Reply-To: <20261012072959.254206-1-xiaolinkui@126.com>
References: <20261012072959.254206-1-xiaolinkui@126.com>
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
