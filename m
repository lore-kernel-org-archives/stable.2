Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65D4A68A7;
	Thu, 15 Oct 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055036; cv=none; b=FntiuQKuaZJriynXH/RySnal1Qi/wgO+joTFnWnhKBwzROgEMCDqDUhKLo8hTGQLerj54fm3MgZNI3aKZgnBtl/eUwRpT0+ypLA/KbxjsbKHxI532T3JiuCV+rn98O0+iPKQtskukywdfsORFJd+XrFpnzg/VupQNEVnnKT2Y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055036; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iM2CAoG3ggHM0K4yPtAUU+xouFGzqcLVntPr6SMI+YIhYWWMAQYexfE1tad9duBFfNwqiugOTDzj2wKdmhquFDTY6leDKwHImAvUncATslW8xmpw3MiXbLSTKI4RrYzYxEiMl4ZzNwQ8cPIJNeQwsQpocZHxztS/gAcQ7LDb13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSRxo6US; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSRxo6US"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C435D1F000C4;
	Thu, 15 Oct 2026 09:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792055035;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dSRxo6USK3mc/4RQGRenUGQ8U2727f+oI3Ftl0yKjPBN568MCXCgNwmZSoGzysnUy
	 JIRe4/X+X2uCl3WWgKXYzQtSUZWrDYBxZebGjtE75Purw0BPPWvfH5tGvd1dQcuRc8
	 Aa/DUUlmxLDBYgCQjPqxujc4t27+Lm3+HfRtD+6stCuut7mDBTAJczCJuA6dhdbd7w
	 fJp/w0/hHaV7WPfPn9yqWBCXIzH3Zv1p5kejHg77+cJ6DtdiT07hujc8eIronx+gQE
	 Dk50bYDtnGMmr8S8FeRuc04w8mj+WciTZAlEIkkaQ6KnP/2N9/uIFITb7oFOtXwQG3
	 zh3kwzX48f18g==
From: netdev-bot+sinfo@kernel.org
To: Xia Yan <yana06070@163.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] veth: keep carrier off when resizing channels
 with a down peer
Date: Thu, 15 Oct 2026 09:03:54 +0000
Message-ID: <179205503431.408196.3787158263559792614@kernel.org>
In-Reply-To: <20261015085821.12725-1-yana06070@163.com>
References: <20261015085821.12725-1-yana06070@163.com>
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
