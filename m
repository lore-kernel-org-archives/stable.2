Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB274431E74
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790025; cv=none; b=dFy6kGBY72mexGxiIbz8N6LA2KKZY2amw9ILJlLI1dr7TlIJxdSfpA0CQaJ5Rr25MHV7NpWVTCZyWAcayeor1BNJFhzpDJ1XUJqn5e0+Wgs8xPpzROK3ijbHX/YYHy5pO9E5vni3g+NLzpFkBLiOFlraShhz9AR4oXLi3A25uYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790025; c=relaxed/simple;
	bh=W+MVDNi4tJNH9YZk3zReiOPAtq1lD2hvv4uxd2kWLeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIMnHsicb+ohFDmKDjZQR6vQYUsZ8wNMtnszYTHFyZxICNjn/BSXDCaud0JP2rSyblLBi6D8dkX8P5xvnI2LkTlCXMo8sFbcBX1I8c0IV31Id+o08FKMYUfZf5X8w8jkuuDibo+mYs5iQY/IO1aT9IykfE0CmhUrC4xO0+7tBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnBu7jmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnBu7jmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED451F00A3F;
	Mon,  3 Aug 2026 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790024;
	bh=9TrqqRj7hy0w4li9ptCDHLCde2YcviXpBTTI4feFH0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TnBu7jmqz3TiQwYV50TsKS5h8QBviYvlqXRaRL0q94Tsgy9V+NS5rUM2tFX5gjcAC
	 dKRoW3JxMam/hkvqg/xS2YRVrOk+raobAypexL5WWXovMQG5zHq+YT00IDqRmeFNm7
	 HoFGvwzSvwFqUdAALK9OxDdI6RrPI0A4D/3/w1ueOPY+WMN6DnvVxFD6sJom0FdMo0
	 tIpUfol4w0wkYa87nraTXqSUcxbIyMuqQEOfHZYIniIDld++cPDKCvg487K1Gqmtsm
	 SfTgZdSqdGyfiS/3LT3rOu8turodkWiIFDlZiAU9/++1NnUcucO6joyUmkLvo/TO8q
	 Z2pynWklLwBUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yiming Qian <yimingqian591@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 5.10.y] net: qrtr: ns: Limit the maximum server registration per node
Date: Mon,  3 Aug 2026 16:46:54 -0400
Message-ID: <20260803203502.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802202106.3820763-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260802202106.3820763-1-youssef.abdulrahman@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 02, 2026 at 10:21:06PM +0200, Youssef Samir wrote:
> Fix this issue by limiting the maximum number of server registrations to
> 256 per node. If the NEW_SERVER message is received for an old port, then
> don't restrict it as it will get replaced. While at it, also rate limit
> the error messages in the failure path of qrtr_ns_worker().

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
