Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898864EBAD9;
	Mon, 28 Sep 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618395; cv=none; b=VyYbYvCXQ6hvmC5nx9QNULwiO4jhlXBLMoz1+nBH6BO845ZvLSeFp9AcqyVqUMYh+CoJ8B+pUxDQCkVDNGAubpVwOisWkDhZHXdVG3wmvOFGLtCMgEZQ+qzUMO4fytL0Ad/bCCC7rt59HaJPvODL7wPB5tVw6a0zboIsL+Jngp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618395; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dYaxN2vEoU/2X0RWXmdPGjdTnzG8lNzaxixTLc5Oxp9FK5+P+ngdt/hEf5z/S3kmDsC23hTt4OozzHRZBaL2XrOgeLmpSvoCgP78oyeYDD4o9V4q/gwRRCmQuTY1RbudedgczFp0ba0Ibi7OP6L//fLlM5nt3DZkgNKRLh2xvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb9JJzt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb9JJzt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFCD1F000FF;
	Mon, 28 Sep 2026 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618394;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pb9JJzt3zfGE2DOX+k2trfVlg+h0WPL3orsKoThM25hr7UHm2FkS2ELJrIbxwXkKb
	 XmeD7K7BXs+28MYzJ93yoYt0m7d6SXfHCsUtPNUNgH8DriIK+DQHLGaH4dfOJW5oni
	 B8MIiEGMMyAizuiolsEwuGmjL0aO//jL7yP04reKJcF5qz623FgPjwD9XaKTnusC3Z
	 7EmN49lhOp3FYCpP95S5MisKb6Pj1wMrkPaaMRr8mxfXtnP5xcdfFGenf+qUVrpUqg
	 jG07o5kHx58KmbBMkUUJ9nnQ2kpLd2ph+8+y4MzKE063UEMkOrO6gVO9hVEYjQcihe
	 5ZuRcPVyeJytA==
From: netdev-bot+sinfo@kernel.org
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org,
 Yuan Tan <yuantan098@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Peihan Liu <ronbogo@outlook.com>, Yilin Zhu <zylzyl2333@gmail.com>,
 Ren Wei <n05ec@lzu.edu.cn>, Eulgyu Kim <eulgyukim@snu.ac.kr>,
 Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: 
 Re: [PATCH ipsec] xfrm: espintcp: reorder operations within espintcp_init_sk
Date: Mon, 28 Sep 2026 17:59:53 +0000
Message-ID: <179061839306.31693.10369290440517739532@kernel.org>
In-Reply-To: 
 <dcb164e6a1064fcd32c2e72fd9ee918dd1427f15.1790617484.git.sd@queasysnail.net>
References: 
 <dcb164e6a1064fcd32c2e72fd9ee918dd1427f15.1790617484.git.sd@queasysnail.net>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
