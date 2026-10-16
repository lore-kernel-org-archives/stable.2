Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209143B8130;
	Fri, 16 Oct 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140794; cv=none; b=f72G+nKxNyR8MlYvQeJmiMOUiubWeLR6nSmHwtIQA83bKAVkSf6w6zeQbmHeNXeuRjf0+GSySbRgLHwUPzPYE+icyckAESxtVu0nSn0kwQEBOzYxU9OuEy/N5petAHof2fbPjYQrSMd8KEsUvWYoy3AHPCggoKtt2gZWRD7AUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140794; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iS0TEqb3huIkxYkPoJF0zE0pnFfVP8b14IAShEFad2gb0h7xYzRmnXOpQ+aIEZIrBBE7tP9yevBXg12NDm3OWYrmivrdDZm48duttsUgUy8NPsfam3km/1HaSMQq6sGAr+7VcEeAq3TqxtyN9Q5WEJFL0s5iQjsya8tlNnHO3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/2p4Nfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/2p4Nfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9058C1F000C4;
	Fri, 16 Oct 2026 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792140792;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/2p4NfpwE76cs51b48QMte8/naMga/a7WdsrguJ6TknFrEmUSJLJE/oHX5iq32iH
	 dzcxZ4iMmbA0YSs04jXTnx5azcX6Y+kRGVISm8s3rjKAmN3Dy8UhuwZZfTKImZXdlK
	 BmsLTPyP4kgnW52Nk+yv7ipKtdJSDoeFoVug017ePpH+OMFGABLTaJ8sHQaFRBuZeY
	 KQVNdmEmtGHEcPPrH5QVCz/SLY6ipPfS7Q1i0Emcv+bmFnBh7G4Ym+XdFasO2IGRHb
	 5igv/gcv5TQO42jWmU1aumaVTDhqzXo6/4tuRmUNqBBQ/Wwd5vrE8rkuOvt7KjRSr+
	 eZalaGXL/fjZw==
From: netdev-bot+sinfo@kernel.org
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Patrick McHardy <kaber@trash.net>, owen kwan <owen@verialabs.com>,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org,
 sashiko-bot@kernel.org, zdi-disclosures@trendmicro.com
Subject: 
 Re: [PATCH net 0/2] net/sched: sch_teql: fix transmit-path regressions
Date: Fri, 16 Oct 2026 08:53:11 +0000
Message-ID: <179214079109.408196.5152796723435821487@kernel.org>
In-Reply-To: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com>
References: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
