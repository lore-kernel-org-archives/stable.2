Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656710;
	b=YG8c9c4nlcGjtfx/9IP6QKFnusoCrDM8T+NAvpt2XWnsy/1mYhku/OWOO3eadFz4UIOy
	 1ZnFAehswE2zyG5jn1vectWersRXADvTRLr9bc1YrXChTcvztkzcaSlqTDykUnmWDs/bJ
	 evxDTsPFsxkqbJ+h2eitkDjyGQ5mq27YGXjBIeAvBQs4jEKETJZADUIp6P+ZhefHgjI2U
	 +2oIs+xGTq2lXPf+KBKZApvPke+LfwjomuA1iUaZ9WG2S0l9U//3PVyB2kYaAKFhL50AD
	 Fh9qsRZ+gJT6oMMnkC22fjgcbybOfGjm5JyXE6VmRZN5PAyvsbdZzJMq5n8aNqA68xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656710;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=LpGNfhzqJL2OG28JWQ4P737LpPhXFL4rdmOLteTjatM6M0/7FfO9/9fmEKL913nOlq21
	 0hi/4RsYSHgkROkAlXthXjZ/mviXfZnwbmDbT+C3O2yuonQLRqQcOFtLL3l6fr84/bPds
	 ZNUCH/cfXJgd/9URP/jwr5niRY8rEGlB+xC9BrxDpqw4x9FmspGlCuDMTzOoRwjaB/Py0
	 KQpTXnCnGB28jFZYZaBxmbyHtpXDOPrR7N6cPt2xviMo4LJAOY0FirApPQVAw1d078N9D
	 KU06Q8LpbHdxqCTJ42mPfn43uoj593/eqwXzLPN7FHL69eG60lcjbqpaMPMbqOKbjZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbET5MLQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C12606A324;
	Mon,  2 Nov 2026 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbET5MLQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8CD1F00A16;
	Mon,  2 Nov 2026 21:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656709;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NbET5MLQALxqlj6qPx+x3sQ8AdK7T7mlPYEGbEo/JUxfhEph3lhVx4Nc9QSxwSyDM
	 tbvJIdLHw8tbfgxVmnW1Rj52/ovIPIodBjrQhPOEU1f1YXD9duFraiGGrPH/LCjcg4
	 43pxW3GEsw47wdrqPM99HXksoc446BTRAthYsQzJY9KgO1yAEuOyAwd2B9vacTZczP
	 aVKZR4w4NveLOZKQpSoalStnbcyusEyle2Rqr8OMSfCcbTg4m6EnMr6aDf4iY8WZuC
	 rEwwKOxzVuxndVmFXpStRuOqrYfIcRl7LAzbFI2GebIyR4QpdkWWG91PYHYJB4wqSq
	 9lAB6qHULOA6g==
From: netdev-bot+sinfo@kernel.org
To: Federico Musto <federico@rimpianto.com>
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: atl1c: free the RX buffer when the descriptor
 reports an error
Date: Mon, 02 Nov 2026 21:58:28 +0000
Message-ID: <179365670828.3286.235970370033962888@kernel.org>
In-Reply-To: <20261102215253.68185-1-federico@rimpianto.com>
References: <20261102215253.68185-1-federico@rimpianto.com>
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
