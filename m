Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AB4FB9B5;
	Tue, 29 Sep 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726372; cv=none; b=AonofyTzRH3FriiaNiQnKai7fblAHEpzU0P5pkC9E889ZR3N39AxalH4BAGvkVCa/Mh4sX+sKS2/YT7WWor7OWGtEz4EiA3Ve3YBFMcfBGP4gk8PUar1SXha3ILTQ2O8L4PGTNjzjigDIPoU0UpgO2mQ9FBjg2QxZcUkZwtco9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726372; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MdgP/OyUTbsJc9Z9XCIWrBmzdZ2UNSqgOsOvnloxmevDHSx8oy3BqG/sTBWKrdvWh2M3225hQMCUNxQMFAKBJStLjhiq9/dB/pEGs1IEqWzSGCPfBA2TonaA+ju1O+CFcHOKzmOgNrDwXIbz5ZCSoh24b9CIscwWvU+waduEf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+p1iLMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+p1iLMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0351F000FF;
	Tue, 29 Sep 2026 23:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726371;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+p1iLMfPyb8pnNtkgs3GyRkSkJ5imuEi+odC6Nz7Yi5L1KSEW84tkza6mueTEJAA
	 jIzj+LbnQ3Tes3ZrqdVuM1NCt21Lqubd0KeZFKeZUxGF8U/zlxcFszwKa6xbrcT053
	 Vsd6E46e5lJ/PBI9tyzwfVEwVEVDoD+hSd5eoMubIZAmJuY8OEYOHDQSk6iUnf4smg
	 egVIrRwilK9yZqf60mCskGnFYmrsXbLxyZo3KFI0N6xb752QqJx+KmFL75GUSu1ax/
	 cblljF67kqWEghudpN8o0LC8wuizZ2/Q8tZPr9fnvBWD0jQSUbVsBGh94ErdznOwLr
	 S4XDZvrSWu7Ag==
From: netdev-bot+sinfo@kernel.org
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>
Cc: stable@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, raminwo0202@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 apais@linux.microsoft.com
Subject: Re: [PATCH v2] xfrm: prevent policy_hthresh.work from racing with
 netns teardown
Date: Tue, 29 Sep 2026 23:59:29 +0000
Message-ID: <179072636987.31693.5661820738342019367@kernel.org>
In-Reply-To: <20260929235256.1398309-1-taherafahimi@linux.microsoft.com>
References: <20260929235256.1398309-1-taherafahimi@linux.microsoft.com>
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
