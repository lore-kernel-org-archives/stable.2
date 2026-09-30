Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCE34CFA1;
	Wed, 30 Sep 2026 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736223; cv=none; b=jaIrTABhDKcUuCwcOEi4JDO/1kNhNgojjDRH7sk7vtTNXJCVB0PgwP+n795Qx1VGf35nZaApuElNP+skJTkzMWCIvR3+obzQWbtkLU0DDg3BLDn3S82JPZaCufUwcsJflRMIatnflP3La6iH34gsf/8crj+KUsVbhM3MGn2cXxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736223; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bF3mFGsszd73mc5XQK1wGFc8eZSZpIxs2IzN1TmSCuIY+KBPuEcocBzpn4msymZLANbEIj6eIeinBWcCdGn0OdUlgns3Llfh2pemI4dm01AK3AROkdmPxdwvJafb6e9X5dV/P7RXAxUF1sfQ3wHCsoR/8SudmCK5Er1YETbmOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC/v4rUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC/v4rUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435811F000FF;
	Wed, 30 Sep 2026 02:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736222;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OC/v4rUnu5Wr6qTsyc1amFMhkOm+UK9iJH5EozcoBH09EkDNG+aRk33wn8qyThwrx
	 ktVnjIeBGyd2ZtGzuZp9TkOq8LKmWclI6oS1Rjf6PLrkLorih2qpNOt7aIN6tZUx0P
	 LMT9XnL0WjNmFlz1jsvZjg18wdBP5IgvVv/K/NTvm0OHWOO4eSxTXIHGMl1Ql09WBY
	 YWSXGv56+fRe/JCJIOy0j+zpVA5rIhVOeuWlx0cT8MA9tuF1ljIqg4dUBKE4xuqXfR
	 oK1wWSI/nWcKsXbrHIfVrLyAFDDNuWBWnRQ36qJrk0eOrw0gVRfywXdBXqmnssL1J8
	 qKdk+AZq6ei9g==
From: netdev-bot+sinfo@kernel.org
To: Artem Dinaburg <artem@trailofbits.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, David Arinzon <darinzon@amazon.com>,
 Shahar Itzko <itzko@amazon.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Shay Agroskin <shayagr@amazon.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Noam Dagan <ndagan@amazon.com>,
 Saeed Bishara <saeedb@amazon.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH 6.6.y] net: ena: Add validation for completion descriptors
 consistency
Date: Wed, 30 Sep 2026 02:43:40 +0000
Message-ID: <179073622069.31693.3189368668972123840@kernel.org>
In-Reply-To: <20260930024101.96014-1-artem@trailofbits.com>
References: <20260930024101.96014-1-artem@trailofbits.com>
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
