Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F42CCC5;
	Tue, 29 Sep 2026 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649858; cv=none; b=c6Ab+wxNJSBFVMajoZVEjXBQiuy7TDEStdorKxdmV8tZBtncSHAfNFIs//xQYcTOhtB/BzE9JLaPJXzCU0WKAEF1XxX5K4iU59jk74GBZWkaljc1r4oMpr4IikYZjlIc1g4v++c8IyeaKWk2rMRjN20MBAgtVcHELMzzjPWrSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649858; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ptz2ddHLay24htCGeNV1EprdMXfngd35KdewR2jaoQOzmW2A4BvmUaUhWUbti+N1VeyJFJlF5a08L/87ZnLBx3RGCO3mIrKSlWyUhpLYzeqI1nstt/7VvtXaOHxzAWEm3Ualb2nbULO48zgm0IXR9pcKuncWj2XQfwpcuEuEhuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiY4m2+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiY4m2+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35451F000FF;
	Tue, 29 Sep 2026 02:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790649857;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kiY4m2+5/sa04KJGXZdIepkpsvBb9jueTaqf8hkmlOhkcryR0eZa7278198yeMN3K
	 mFUmCCOB96OkDi7tNjeGl7ZC5YKDm5KrPp4Clt9GQpD+QkA8hiknJ+fcBBXWL9guQO
	 +ca8ih8bUNofxXH1cFgWowSwJfNVLEp/VdEvCh5i5CMwM3VL6bFQKPyQWng9XnXnXw
	 uR5BAs8BnDI/bppzho6LY1w5yyzTO3AfeDyF1daljERpOefPpOHilivDmYruaBp+O2
	 WQ8cXXdUMQFM9uLEGLZwnAeX8suTleyw0o+nUtHmvfFv0xkQ+1wqmgfOKAmGrDvqtx
	 FUi/3+HixJE0g==
From: netdev-bot+sinfo@kernel.org
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: chandrashekar.devegowda@intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, johannes@sipsolutions.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, guozh23@xiaopeng.com
Subject: Re: [PATCH v2] net: wwan: t7xx: validate the HS2 message data length
Date: Tue, 29 Sep 2026 02:44:16 +0000
Message-ID: <179064985627.31693.17462376426668707461@kernel.org>
In-Reply-To: <20260929023914.247374-1-zhugl3@xiaopeng.com>
References: <20260909054401.718959-1-zhugl3@xiaopeng.com>
 <20260929023914.247374-1-zhugl3@xiaopeng.com>
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
