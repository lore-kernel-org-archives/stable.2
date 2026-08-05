Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099A2F9D98;
	Wed,  5 Aug 2026 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892419; cv=none; b=u+LqHfs2WxAAAxtn1znGk99Y4SxzoZTdpDh5bLzfXX5YvTxu5YXPyAxaenCcKB/DT1q7XG0R52pE/pqAkoWlkAg78fxMBEAPpd4u4MbFcHPAcu+0v8KI2Ugsqyc5CIL9WLM8/eO65xzlqSoLScR1WR0ltIwKenkbazy3je4snDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892419; c=relaxed/simple;
	bh=xFC/IK4VwGqI+Tcz1mRtKMyiW2iRxySFf76x87DX8YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWqPSZsyLyp5/kmhsnP3HdRrV2TTiX6EGGNwse1clAai/PhcNRKVe7tWQD8rflkYwxCwbJgQKvh6XqYJoYigAbUhYpburbRJgstIW3kqyWIUYr2o17i6UOfwjblg96rjjJP3WIDTA5Mj+dswpXHheCK9QHP0quYYSpk6/NCR0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFJ543ds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFJ543ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915FF1F000E9;
	Wed,  5 Aug 2026 01:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892418;
	bh=eUgsWdV3zgIFuUyGFWL7ozSgWcaqMwUp8QwiSwGOIE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LFJ543dsUdDfVQV5Ljw5fQSl5nyzH8qdnyhGvy45FWwvq7BU09wSdTNs8O6NtZo3W
	 NWAoQWzSyynMzSFTB7Xa2hutohtm1t1Js0vNZ02d8w1mm0bC1u5R+4HtvlsUbnI7Pl
	 fnF5YX5caXDzrnkOBTzAQvu5PNQqHOenrg1Qa+gmhe5cXPDpqDlhCTr4JGRIR6SbKf
	 s7B4kUysk2W8uZAczAFsBS/UOH2QUNTb6dtQ58HltwW3jTn1v+5glu38fUCO4qJZDA
	 o7heOC9GIX+eMIYyONtiqHgGvTQ5pTNQ+SuT1XGOO7Z71KW+PSg4ekHYzfXMHf9CPA
	 4iomXhbEOS21A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Lee Jones <lee@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Michal Luczaj <mhal@rbox.co>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Leon Chen <leonchen.oss@139.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 6.1.y] af_unix: Give up GC if MSG_PEEK intervened.
Date: Tue,  4 Aug 2026 21:13:25 -0400
Message-ID: <20260805011001.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804182841.452925-1-tkjos@google.com>
References: <20260804182841.452925-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 04, 2026 at 06:28:41PM +0000, Todd Kjos wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> [ Upstream commit e5b31d988a41549037b8d8721a3c3cae893d8670 ]
>
> Igor Ushakov reported that GC purged the receive queue of
> an alive socket due to a race with MSG_PEEK with a nice repro.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
