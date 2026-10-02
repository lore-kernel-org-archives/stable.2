Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3534BE44B;
	Fri,  2 Oct 2026 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963063; cv=none; b=K9vyUdLauTfN4JYG3BxwetaqTq6+nUlE1ENx+rDuxbYbHMUirSxgOiTvhiOl8ZcQGImWKodgTeGtZP3cir5GbZGZy0U/oaVlwWqrxeq+8uKrtJNoeiMRJI4rYRx6B8GOlynNJE3NFC8pNt0s92JpnlrtrA0drcZDeKDBlHJPkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963063; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7oqhuHacjMG3P9gDvn4rL1RJ00aEokqU0S7zzcA84sDBAqWp9kqaYPcdBBWw42Jrf5NNGJk5j5HrWHL7Mhgf5Y3HiJDUtiK+QaULv9lHesAmzPQQWDcVHcmxWUV144+shE4TLk7lpSLJpS3aAAg9GQ4gjLAYUaPwRFnfXrFcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuGB07QB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuGB07QB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F176E1F000FF;
	Fri,  2 Oct 2026 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790963054;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cuGB07QB9A1vIG01th0zcckLWVtNNuNDJZ1jpy0hjtoRIVTwscqCq4Hwcfo/3wHGb
	 L85wpxJupNw5WtzzCT1tpOkL8onx/QBd+noyALblOqNrrNOepsB8v9+FWXtGG2vBUN
	 McTn+6wJHZDBSRXdZVLv1Elciiajw8B/V+MxQk0nWJ4jly6pQWT4IIH/tfv0Q0NV6F
	 IYMuyluWYFhVKVbVrLnFRkCBeAUZ+Qwu8NxdB0bQy76j2tar9Fj2vkXtDvy1GX/OTv
	 Ui29/B3mGqmsIFMigY6Hj5JI60oKdvtSvcWnxKtw4bzhx97pjmVDdRHnt7ojcy4Cyq
	 HkfBiIt8UarVQ==
From: netdev-bot+sinfo@kernel.org
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v4] net: pin protocol module before inet socket allocation
Date: Fri, 02 Oct 2026 17:44:13 +0000
Message-ID: <179096305349.1402591.6316561110428507255@kernel.org>
In-Reply-To: <20261002173844.3537111-1-nicoyip.dev@gmail.com>
References: <20261002173844.3537111-1-nicoyip.dev@gmail.com>
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
