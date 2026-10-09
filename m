Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64D4E234D;
	Fri,  9 Oct 2026 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546874; cv=none; b=I0rTURjYTQcHrxozYNNNQQ2UXgolarMCI++m7HsIed0wNCaKR1M0MgHDrkg7tzlCd1zD32tqvrB5yGqJ6OCmM4wLDB6Z6hMOLWyYTKCfaMus3PaKZjBCHR46NEAYtYb+39pnB5rA6Duo48HWOM0MWiuhfD0J2OG4847EieSru5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546874; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ea4vBHHps4Bxj1r10dWCiP/ZWyT24sCHqa8eIrCKzzDc9Xlagn24p9R02mqJDfKSE39nGTVzN1C+tTUMbULHUis5VMIC5k2npoOedw9t07UN+dDMr030qJxC4lhdONE3/CphhrOs/Y8eBlKWBkeWgI/5AD4103ZYWQiJPN85u44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h48KUv5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h48KUv5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9441F1F00893;
	Fri,  9 Oct 2026 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546868;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h48KUv5ENL73MsO60544+jmEkIEhYpOjdfOIQrr3IF88muYEfj+Qv6DNEC8IGP9jM
	 WfVZTIwAe5dBB2avcGUzvgx5CrF0hyre7bYnAjv6IIeKzRPBh0ksNL6le9y0pNTpFr
	 OhDbbdWZrP4RrLH/29CnECQToHIqlDzwMgfr98Hs4QIK2UbnHi5IGvtR1lsbcfBs27
	 4+YFjw5fu0zJ/+Q/FKB74niOlEhkfWqoIi4z2/3y9uBarZJO6FbN67cfjTESQQHDaT
	 LbVQ3IKO21fkoBsHJkWYHfyLq9IjoW4JZ4TadOB3GCzFfWsSqMXxmW0en4jYP8DSs9
	 5dHrRoHb5JJJg==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rxrpc: fix connection reference leak on aborted CHALLENGE
Date: Fri, 09 Oct 2026 11:54:27 +0000
Message-ID: <179154686717.2527009.7769251289741823580@kernel.org>
In-Reply-To: <20261009115003.3696517-1-bsdhenrymartin@gmail.com>
References: <20261009115003.3696517-1-bsdhenrymartin@gmail.com>
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
