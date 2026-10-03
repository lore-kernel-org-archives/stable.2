Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E037F33F;
	Sat,  3 Oct 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018189; cv=none; b=StsSUlHuvI1j/qyN22zaRdKMeOM9ztdjF1VoUbJWSYUfgGOkf1mB5j0YuekoXrKHEFGES3640SHRyeV37VGySRCllcUT11VJ+smOCGzvdzQItHa6IT3dRXTm0Qf29H+OEUWFsAvXb94AX4vhSGBjZ0phcrw2f7o478lgXIAx2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018189; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBpD27Kq48kJxgQDITt9xH7E5jmTCdvRXqzTTAdFC/7RdEY1LPmKJQeFnnYyR44xny46kMEgJa56aOrUabdK494/NGXLaiBpMpdyn7cY7jJeazyNk8mocW5ucAdRvOjZx0TtO0Lta8ATntN897OeSdTGKbNJtbr4HvlvwEIwYGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSOjfgb7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSOjfgb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F791F008A1;
	Sat,  3 Oct 2026 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791018181;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kSOjfgb7M3Vu9C+r7pv1Ga3ipGQHORIAXgzgXWtMbdDy/mYwPmZwIry2vEZuh/1Gl
	 koqVOo/oZM5rxa4bK+bpriZSgS6gOjf7OpxDs5hRLV9CpC73NiWICx9bBdgcStSqR3
	 ha0hcyOQ8Rpn/sRZ7iSCF32NsV13dYYim/GDDLe7sRnP2f9M8a4LkE0zxrVY1ybfrr
	 p0EGBCB6P7GvzN/ziV6TemKbUxC0JxAxJ+UYOq52XpY0ifgraxglMKWjyxjRgvHwNf
	 XLznhR7MEYBYWCrHbEqhWOTlqgsQ8uXxwESeCjrhHHc6j36cZ2976xirA6pJNR8tlU
	 Uxze8UVhZ48sw==
From: netdev-bot+sinfo@kernel.org
To: Jiale Yao <yaojiale02@163.com>
Cc: =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Soren Brinkmann <soren.brinkmann@xilinx.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v3 1/7] net: macb: manage the netdev lifetime with devres
Date: Sat, 03 Oct 2026 09:03:00 +0000
Message-ID: <179101818017.1402591.13375360078397491041@kernel.org>
In-Reply-To: <20261003085940.493951-2-yaojiale02@163.com>
References: <20261003085940.493951-1-yaojiale02@163.com>
 <20261003085940.493951-2-yaojiale02@163.com>
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
