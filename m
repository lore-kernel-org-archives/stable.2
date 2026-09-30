Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698EE4F405E;
	Wed, 30 Sep 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792084; cv=none; b=EB34aYFuIdFNa2SVjZu/oUKAjWveWYxG0zkZ+kTBKhmst5zV+Fn9OEid6hzmPgbqkmrzoQUSlsdcVw9blPaIXxYzRakpypZ7wOEtzAWSSXFa68WBWXaYWFKG7WQAvRbGU4UGnCAbfOm/SGhN+5n9Dh0Ghhd8GASv/euGfh0VMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792084; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPrCqc96Biq/HAQqOdIZWmrzwHnN9ZMavx7daIxajn+6v2pVtuQ0fj9ZaUsPWB7uXtEffI0T8/4a52Wfs5RRleW4Oe5gg7hBCKyhrROVN3A86uPzD/rzkHSDLuynbNJJn/QBPkV9K1uFxVfzApieLjE2hkSs07NNkz3VvDsVBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdkemMUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdkemMUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDE01F000FF;
	Wed, 30 Sep 2026 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790792083;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MdkemMUHMHaxgFu1bgz/hpq8HFimjTiLBLu9RI5PD2EGKpcZ4vCdOdgApDYS3B0ZM
	 DGFsiupmReaVNt4zR8N9HvPCvaLfTUB9+5R2sdwP5Qr9iqQcZsJBocE4kY70nebanE
	 wLUvpqLyRtSmM5F3Mo6Kb3CZ/bocVLh4lHHBhDxLwXgvIRPC9SpHLEzT6wEsOfWeZn
	 SinbFIc1HGfWYByiG207Rz+7yqWdzQK+lJHd7LZuK1h8pkpYUavrLnylPhYxkxmLgE
	 wnkEXIxfBdkmok3eOtNWBqLbG5m+9Lfr22q7bgAhEV8uiRiwFv/E+u/UdIleiGqGqM
	 /YFBldmx+n/iA==
From: netdev-bot+sinfo@kernel.org
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net-sysfs: release queue trackers before allowing reuse
Date: Wed, 30 Sep 2026 18:14:42 +0000
Message-ID: <179079208206.31693.6652896710710003404@kernel.org>
In-Reply-To: <20260930181106.271547-1-nicoyip.dev@gmail.com>
References: <20260930181106.271547-1-nicoyip.dev@gmail.com>
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
