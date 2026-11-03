Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700596;
	b=D+JuY1EtGtkhs8ez+sz2ei+2Y6umJDEPBZjVjaVhvr/3qje8VByx2W6gG5prI97ttWAS
	 01v928zd3O6lrf2R/w/nJDLTgcCTX6da4gTSoIalrasvKfywoM6iPIU9lNHbplkTMfHV9
	 3xnRx1dn+n/GXPE71tpQLXb8mzYV4aP0xiAaZdb0Z5C3FdW+kpypv9gqurRBulZJl54vB
	 LUFwZEJM+go+ooJfoTlxPSFyB7NveKntr3EM0700n0qfhPLWQRc4/LeZvUUamd43XktSG
	 2TD4MkFJ7tVYiFpIjoYySNThCThQ7yL8K6fuivSeZRUgrB1QMz2jTBDADCa108AZKrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=ot9muRFCSKk9zQdNxbhfU2OhkUFth25F7jtBfnecIhT8ho9I5xe6jKE9i3vo9PCzdzq/
	 bOp2m4ledtECpw2Ps8H3i/pbhtUgDuBQGY8cE4rIOvoN7b+w1NBrBmamutC5MZLdoTnfr
	 c9pJXuznEet1SOgxMMS/zPlBnLJigKGP4sco/TqnamzYyvz/lnraR6c4/GSODqAxafqy2
	 Eh6nA+Tw/yOB2SetxWzXkNHwcBug1MQM4DVLs5Wm70YhGz021BEvZ8QLs/jqojx9+yYtx
	 9a0YnHRBEH89v9fTAEj9miu+n4l/ss3B7oJZLb1UdIwvkO39hGe+4Jz0IgTYkkwBGjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNvqcvY7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B0606C56D;
	Tue,  3 Nov 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNvqcvY7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9631F000C1;
	Tue,  3 Nov 2026 10:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700596;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eNvqcvY7SAcg8LuLMkEqWbxzFstW/ZKkvNG3OdZjbBP1ZPwmSBH/8jwHoCfBocw1Y
	 ge6XyvZG/ys9wfRMKxJkFFcCGdk+sst0O37mJovuBrd3JEjQ/JGPQXco6vyUvl+ubv
	 XtJHT9i/mk/HShpnocv1wstqsLRlQtAWLHgD+JDgpBoW4QWtH8ChrZLQMGyBZWTz81
	 y4n/jUMn3vsbJvZziH5mLWc8uX81ZMgO9bGqLr5aVLNRLWpWCGEn0/wi2wuPxbM4IF
	 qUPqZF49bxQ0AVyV8x1EEorcIhkZv7ndWFYHga1NSE4Ms6ldbDcqLLeplF8HlcmPSb
	 3KlM37Lb5S0BA==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: octeontx2-pf: drop the TC mark reference when adding
 a flow fails
Date: Tue, 03 Nov 2026 10:09:54 +0000
Message-ID: <179370059492.488859.17275486347975577589@kernel.org>
In-Reply-To: <20261103100536.1310108-1-vulab@iscas.ac.cn>
References: <20261103100536.1310108-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
