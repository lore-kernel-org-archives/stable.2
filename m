Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692075625FE
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091553; cv=none; b=iEUQIbLH38amj2Y4y850GPZ/NTh3PQ+4NhL6ELyTHFivK9tsl3qTAhx8f+KZQPw3kfElWMLYPmjkKhabrc/z4q+Xvkpuy5/KUhfXf4ZxQ0rBaWeSBrKJFqwWG03xxfzbATFeiJe5mjnEabSYzL6TMyUG5/B7+hMdvLkAjd3gXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091553; c=relaxed/simple;
	bh=9ZizkaRKIgbpZkbKSeMQoh6Jzpx1lloZFXS3BBBKxOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKXOaEmYaScAzSK91nBAa+vuePuA15Uk/T6+Eb0pt1sqEQun7n0wx0JHM/lYWri4OC3TMQtCra4FQOL0RlFs0+5KNJDAMyYbzHifCctGn3GHASuhm/7uNag2N0nYEuPTlxXcHwlNB072E9oSCcpzY2wTU7sHlTrSB1rqGAb5oLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObXmprKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObXmprKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA5C1F00899;
	Tue, 22 Sep 2026 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091552;
	bh=4DLwqfuCTFAFUGdeJu8CKTCrDLDU6YK1D9vmtA3YYJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ObXmprKQI3qb9LTwyGQNvuuGZtj5QfeHKMXO3rWka6pgUp8CmFny7WSvRmfRvC+pD
	 x8Er3WSVnwHIBe3gmmRyHrUxpHouiVfd/nQNklBGRvvBz8qxLbMpmzkzUgLGmObdj8
	 OoNDXgXQWscZ72roSqJ9XHBAAc7L9jmfwACkhwI2HEoQ8nxa6GHDhO9JLRRN+sPzK7
	 kPWxdD8L5i+Tvar2Qfw8dxTwodZJnB+0bNPhLC+gbZKSJUS1amZ1UxYBYV0XDJzDol
	 M+jIPBCEhULQ+RGeRYbX55siIQ02sZOA9YXCHo4fXMU9ydsNxlpu/23qh+UzYf4KDR
	 kyEOcO2LjWnEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: Patch "xfrm: propagate extack to all netlink doit handlers" has been added to the 5.10-stable tree
Date: Tue, 22 Sep 2026 11:39:00 -0400
Message-ID: <2026-09-22-daily-reply-0007-re-xfrm-extack-dep-chain@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arIzFfvyTnZnz-XZ@krikkit>
References: <arIzFfvyTnZnz-XZ@krikkit>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You're backporting all this stuff to avoid a completely trivial
> conflict on the nlmsg_unicast call in the context for d1ebd9081879? :/

Yes, and you are right that the conflict is trivial. The deps went in so that
d1ebd9081879 ("xfrm: fix compat ALLOCSPI request use-after-free") stays a
mechanical cherry-pick on every tree instead of a hand-resolved one.

This makes it much easier for us to maintain the trees for longer, as there are
less conflicts we will need to resolve in the future.

-- 
Thanks,
Sasha
