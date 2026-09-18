Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244C35DA61
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692775; cv=none; b=SJY+ow8Sc2LVkjISDp3OcA3LIC5qoIUD4EupS8lRmvP4kzX0K2YYYuH/V6eb5wfTpxyASuWXv5rZ4mJYAa+5SUMTRtql3VujVHvMVlJSKGv8UzgRZD7W9I9YNEt2AEe/Pp6PfwK9JpNYFRui4v55X8G/woIoTGGuwqPGQTfjqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692775; c=relaxed/simple;
	bh=rn0FlweUaOzj2KoBeji3Q7f95KGzaHpApBJZqiELZ94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFLT1Zq2o2gF/wVI/JLVcuBJd3GcMSga92n+D5qwIm99WF5ssJac4RPWFO53h48oQaHthKYaUnkWJECxQuaMROB9n3uejuFVtZT+zlBYA90YXoFwRQ4CIbAKaQYg7bSOqSSqmhcQH5sU83NqURvj028qzXrfPFOjrbvN+15I3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPEmtPgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPEmtPgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022281F000FF;
	Fri, 18 Sep 2026 00:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692773;
	bh=8nd3sJ36yG/HboPT9f5nbegbDLz5L/fta6GkzgI0Ixc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bPEmtPgCXlSdkR2J0TVPvXQe/z9ZS+o1YgLE0s6gLIgK3XAXbpt2IXA2/liECAnqc
	 Wxrp5UBU/Wpv8PSd78EIabOtHLL9ibK5SX9nSrfmMw2Db0k6Yif6jdxaUsi6IaZNTw
	 jg0d3flcZTg0EnPs2gNExP6AFpaYHBpQ7l0678BouJhL7SAyr31stfH7fw5ktcJp0c
	 o5gQXsiZ0Z2cWhlawWlrUqEI1WmONF7gRdpnevRsCV+yU0l2xxwRDe5xYU+PHMC+ul
	 a0r5Eg3apXsEPFUw4RR7N7DS72JXQ+jm2J0xNq3V65A44ij1fid0iDBtS/9Sf+oxuB
	 bNAwPjHYImSvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	gregkh@linuxfoundation.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH 6.12.y 2/2] selftests/landlock: Add test for TCP fast open
Date: Thu, 17 Sep 2026 20:52:32 -0400
Message-ID: <2026-09-17-daily-reply-0005-landlock-tcp-fastopen@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c31e38b4d5266a93cc6f578d2be4b7369a58ccd1.1789655724.git.mic@digikod.net>
References: <c31e38b4d5266a93cc6f578d2be4b7369a58ccd1.1789655724.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit f4b30e0b1d488e7ffd8ea28d1365b9ba8e551edb ]
>
> Enforce that TCP Fast Open is controlled by
> LANDLOCK_ACCESS_NET_CONNECT_TCP.

Queued the series for 6.18 and 6.12, thanks. 6.18 was missing the fix as
well, and your patches apply there unchanged.

-- 
Thanks,
Sasha
