Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311F1FBC8C;
	Sat, 10 Oct 2026 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602166; cv=none; b=PeZ8xh3wdEDKzn9mnHteOVFMwGseB7TiAu8XjpB5s2LOTdPUQNxMiUHp4SoCnXmCQ90P/Jc8/hdVFGO3zdHxXTij9z3MVYjc3116dl+UuR7ZdPFLHhyOfdRraCQciL3FMjih9bo1vt/vbbW4M8sUzgV7Hsv17mlgWHwHo5IzctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602166; c=relaxed/simple;
	bh=f6EkHzolGy8GYPjeII04sc8oTncaFwHLWXs9LkHKYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJZPNWQreoCLAckUy2zWjMk8Xdpc1adLYBOz4/7zA7z2aNZw2yw8E//fyeqQ1usMAAI2nkJGq7+kLEBu/bouj3zGV3CwNiKY2SbEahkOhxxweNnFoEkNTvluvxLWq5k8Mr0L8Sv9xJWMVVPjtGVJe1NvvOmRuKTKBhF1qDbdvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi4eUadG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi4eUadG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CA01F000FF;
	Sat, 10 Oct 2026 03:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791602164;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pi4eUadGqvVNj1Y2cf2/9SEWMIWe1vHf/c/VDBW18QaPYa6JfpI9rUVRjg8yqXikX
	 mlN69xRPFyM6MjMCq4oDuePwVXJoOWJa79HO9DSwO8tQllHJXuqM1JspF7U1cnyrgY
	 zU5Xk+chkhQN1Bvr8ZcZPUPpX+2335k3xnILHktHuPyof6M3mqsXdK/EZG9zgvj3bH
	 OKu77+OMSLPp/l4HQBTXbkrg6QY/X/aVUPbd02BkPymUnhRK91gpYQlACur7nbfJlt
	 VGTWisdYe/QWLw7GD7vYQmGQ3BWDtnPxLbs63dY9pXFB6McoY0xsHRHCuu3ZLZpK53
	 aQe15hoLhgGtw==
From: netdev-bot+sinfo@kernel.org
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Fan Gong <gongfan1@huawei.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Xin Guo <guoxin09@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hinic3: bound the Rx fragment count to MAX_SKB_FRAGS
Date: Sat, 10 Oct 2026 03:16:03 +0000
Message-ID: <179160216357.2527009.7824300860543956422@kernel.org>
In-Reply-To: <20261010030901.1712792-1-yhlee@isslab.korea.ac.kr>
References: <20261010030901.1712792-1-yhlee@isslab.korea.ac.kr>
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
