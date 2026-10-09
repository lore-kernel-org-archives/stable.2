Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3F3BE64B;
	Fri,  9 Oct 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568854; cv=none; b=szCGgYSFW0PZavl75kDZObGR66C4nTUWAAJU5tWuh/XKe+aSpq2auRxNJciRTUH9idw8ufYhP78D4k+arefzpUxqsadbCSdOw5+xEeAWW0BSoTQOG+HvwB+74u0V2OjiIyi35q6bNpHAqIsxiQNLkShZr6P70Rro2YcEDho4lOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568854; c=relaxed/simple;
	bh=f6EkHzolGy8GYPjeII04sc8oTncaFwHLWXs9LkHKYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bn1yp2/bY21OrV/3n/Nx3chtehLYBboR8MoAVrbRsb+EnyuVpoJs8outVZqQbmAcWqa4SpoV5RipEiQSE+GlfDmxn57n66OGKXKXJx5S/GTUhSzMvynylEAyLfAfK17hnxInyB3e28qVQAAGtc01sCJVyV+4BXm3BjSSWEu/d8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJSntq4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJSntq4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3211F000FF;
	Fri,  9 Oct 2026 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791568853;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OJSntq4dv7Ind1d/gKmJo/I1gIrjaU3aRmyPkkGZqpOWmVWI9pcn73X08O/7H3md7
	 xYCUYSZscbKLlnS5Gaxrd7LCbcVTsjrlhV9t+1O/kvScGOYzQZoOTbB3Uo/+aEGmIy
	 9YIZgFaMmAjSa5CXmtp9KdPKNYAxaVq/Jd6AK3L2hHgvcZAVi7hO4EsX5P3UCD1OQ7
	 ysLTAqbA2QcCa+bJlbs+CbeZCatrz1aavr4wrowWyFDFFrJoOk4tgEv3qjCptugJ6f
	 mFLroSwYgZwHFDbzTT2qqTtEICxAdTnY+IhxFamOJliQ1LbZpbq7J9qRCoW0b7AQ79
	 290tSTaWRevYg==
From: netdev-bot+sinfo@kernel.org
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-team@meta.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Dimitri Daskalakis <daskald@meta.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] eth: fbnic: validate the Rx completion buffer index
Date: Fri, 09 Oct 2026 18:00:52 +0000
Message-ID: <179156885214.2527009.12065288871742418223@kernel.org>
In-Reply-To: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr>
References: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr>
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
