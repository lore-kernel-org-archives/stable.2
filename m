Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB28448BA3;
	Mon, 28 Sep 2026 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578758; cv=none; b=qHwNeHHqNnwiWyYNasb4CPZT/oEd1JOpHAI2Kp6M753LfK8eYRDA9rMI1aaTePrf/Mdaj2c6qO0uvIOlCHPjBrjwvhFvbT8W2jEUwS+Z/q9PY+81sMFvmfJ9ztMgnlMcio1HyBpO7qjfk1v69T4a5d9tRp5qIF7gh8UY/FRG8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578758; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Prq6I3tFPR0Wz1oLp2WKiJrInSRqyTtTVtrOvEZi11DiefK728wcZKOVCFZhNNeflRnGN+uIqyrPXVjty7FA41OYGZvR8oU41CBPtANS4Sd7uGxSqa+F0BIr6n4+tpcftesCP1qR/avdmAqZkrM/tr+NGqyC8FLUQhJdXyp3NWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5vc5nYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5vc5nYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A73D1F000FF;
	Mon, 28 Sep 2026 06:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790578754;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5vc5nYbCEgWsuLZkLDYObVRIIxR9jbxKbVVx6pC9mfWcbZXoOD6zIgzzrqL4FAwG
	 rwGeU0n1H4Mm6zZxF25WraR49swLaofxA1Cx+hRgiu6Ktpl6SDx94kyVVMsT6d6yrq
	 EnxLYeLh2BY3JKJGl1TzCDS/WWr1ToKlOFJtbYwXSqObPvewOK2VcEl/trPBQLq7JR
	 1UZ4hOGF5LNqEfMVgg7LRX6uTWEAPxq9bJ9JLt+maNMFQbO9ACRYAr6Iii7OWdMTdU
	 GPmgWj8i3g3igldQ5v5QmEEysh8S9roY07vWxRPfuB+1CrziiiL+Hay/6y4ufWKMx9
	 e5DGen2KQyZkA==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
Date: Mon, 28 Sep 2026 06:59:12 +0000
Message-ID: <179057875290.31693.7249107578001642813@kernel.org>
In-Reply-To: <20260928065306.1514795-1-xiaolinkui@126.com>
References: <20260928065306.1514795-1-xiaolinkui@126.com>
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
