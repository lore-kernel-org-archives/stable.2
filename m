Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4E400DE9
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658595; cv=none; b=J6L7Pa7uIrWFCrv0cLzB6iQRiQsj84WinJfSHF6DdTqs8XdLZ4JomBUcPcKzh6CZWkdoCM7iHPRT8Twxagf9cxjDdkf7iUivPHxIqOxMP1Q0ATEWjN/Ve9S7gRd+U7H8RfV6ItDRu9SEpNCF84fsSLoiMFfwWlBcF8h1XsWnjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658595; c=relaxed/simple;
	bh=LFrQ+uGdgzC1GUBR4Mq1rCJjGwZdPDfL666BYk46gok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNLl5o5WwOnZOjElUhuZBLaQHnCnL+JO3TLcEE3OLn0xlIaVi0LtUw6XBGcOjrbveWgcvp1hiLU6k5pyvp40gVBEMXKfw0wqjRQvzAZoJlPjAx/nxfjxY4uc70MA4TZ6AkRQjrTqF6bRj8q13ho/qCaT//lzvjH6/i0A4Xd3jCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyIx4GTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyIx4GTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C9B1F000E9;
	Tue, 25 Aug 2026 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658592;
	bh=pIZFu7LZSYliawU8Qh1uzvn0Vk1bjeFd67QImvZ3tMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FyIx4GTrER5YEdf/wvFyROv+z6Hk9KsR3dSWhjOPh53PZlMaClXvll3n/vzsr1sQY
	 v0g9XuRzTXIm4qI6WX9RDPIeIh5Ptll2Mq1XdHmF1ZjSvBV5t1HQfGaFEpXw9Wt61A
	 C9M+0xyaoqXYbWZAIFNhTgjW5nEpwQZetyJ7KQEItd7o2mLHIGvOaHvTa2AqzP2/H7
	 Bfl6GWjQJx0YDzdDZ+EbvwbIe76Nj0q2Y1vzPjSZ4A2z2t9fXHn6xJp+q/D/Z0X/uS
	 lfdSohoEMGHpOBIEpZPjW0OgmxZfZbLzJ8ZSZV8gXV+eEelpy1r0YUcOepBr9CRlG3
	 fpFENa931J6sg==
From: Sasha Levin <sashal@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6.18.y] can: isotp: fix timer drain order, wakeup handling and tx_gen ordering
Date: Tue, 25 Aug 2026 07:49:33 -0400
Message-ID: <202608250013.6e9c30257cf35cff@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <376bdf5f-0e7f-4330-a3bd-7cffdc3ab857@hartkopp.net>
References: <376bdf5f-0e7f-4330-a3bd-7cffdc3ab857@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 21, 2026 at 09:00:21AM +0200, Oliver Hartkopp wrote:
> upstream commit 050f010f920da17c1044a4f174766ad553e770b6 is now
> integrated in 6.6.y , 6.12.y and 6.18.y
>
> But I didn't get a FAIL notice for 5.10.y 5.15.y 6.1.y so far.

No notice is coming for those, sorry - cf070fe33bfb reached 6.1.y, 5.15.y
and 5.10.y by a different route, so 050f010f920d was never auto-tried
against them and nothing generated a failure mail.

The gap is real though: all three carry cf070fe33bfb without its
follow-up. Could you send the same v2-style 2-patch series
(d4fb6514ff8e + 050f010f920d) for 6.1.y, 5.15.y and 5.10.y, threaded to
this mail?

-- 
Thanks,
Sasha
