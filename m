Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AEE30C14C
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067500; cv=none; b=m3rHfNZskXTjNCwM9IxZgQWbwjWnhwlun0ByKGwmow8c8SGzRGIXK8G+2BOWH2l9logMxMG1q24LcD4KjI9jqXANlE4PiIzy6LPjdp09pIbgOvkj3w6UTTcdekNU27f3NUMpqvmSDgCzYSzSDzy6JjfPML1ECac2DbNvVXYfHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067500; c=relaxed/simple;
	bh=X09LtppIkxdFEe/nXafOWSTuA+b6bmQduq0/Yvh7LfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1FZsv77FGlRen2XgWIqrVEAsvxuEv5D5U2QUWCtKrDj/mbLQc0sSDuhxH4sIdCVYwIPd85V6viuI6kuXyg7AyuJOgbQFoGW0flQZjUbOPNSVKTyy8j1G/CB5BoWpvulQo08quFvY8J8NRgZTgHwiyKpp1nmc2uMBebYfoHJmxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKkbHMG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKkbHMG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2761D1F000E9;
	Sun, 26 Jul 2026 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067498;
	bh=uMML1efS+UPzVQLzCYqWqxIChwAo1j7w0cpTXOZDtsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CKkbHMG0KXFP0DIzRLV7Y3ZGTCpddSntmKLgxKbz+wltZgFr2lioGJeY3fxGvwc9g
	 de/3jCdJ7tbLkfVuXE7/Qok7mn7eLtNx/mU/Kcc29S2oymvlKQ2QD4zmwuxREQpoZk
	 WvCUxNz9quGvyZO9l9ujX5xUEOq7zeHToBNo44AUI3BCx9OOPzjRvtC4NWDJw7cE2O
	 98dw+t4RzrcT3WbSky2FgtjdF/7l+igKl1W8dVBtRvdehkfpwIMi0/byqBPqu5o0fS
	 YWaZz+Q+WF+VEig6eHcuCYCo36JA+NOr3O8Uf9QC9G1rg5MFkhb7BmB/MYlsU6fqWx
	 QZ4rznoVQMzCA==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
Subject: Re: Please backport 101f3498b4bd to 6.18.y
Date: Sun, 26 Jul 2026 08:04:40 -0400
Message-ID: <20260725192000.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <PAWPR07MB100712177EB29A65F4385E4C29ACF2@PAWPR07MB10071.eurprd07.prod.outlook.com>
References: <PAWPR07MB100712177EB29A65F4385E4C29ACF2@PAWPR07MB10071.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> My attempt at a backport is below. Apologies in advance if the mail
> system mangles it. The only real diff between this and the original
> should be the use use of div_s64 vs div64_long + maybe tiny bit of
> patch context.

Thanks for putting this together, and for the weeks of production
testing.

I'd like to hold this one until Peter can weigh in. Upstream the revert
was preceded by 4823725d9d1d ("sched/fair: Increase weight bits for
avg_vruntime"), which is what actually cured the underlying rounding
artifact that 6d71a9c61604 was working around. That prerequisite is part
of the larger v7.1 avg_vruntime rework and isn't practical to bring back
to 6.18. Reverting alone on 6.18 (which still uses the scale_load_down
avg_vruntime) theoretically re-exposes that artifact, so I'd rather not
queue a scheduler change like this without the author's ack.

Peter, does a standalone revert of 6d71a9c61604 look correct/safe for
6.18 without 4823725d9d1d?

-- 
Thanks,
Sasha
