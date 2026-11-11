Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413462;
	b=PqF6Zy7rKS1gyGWfgM94IC4gsZGIxTJSjyo6iF3H978kFxrbfCQiIIOorSstiseAqtGq
	 tXJoeKZN6JDN2BWCzX2f1yZmjgWUkzY8rBQTfZT6cwYtpRNFaJpSo5B02LvzXACUJ+L4Q
	 4r1yJOVRNZxILAGXlshNXLMBWhqyFf7YOpzktLlKVECfqLWnLmLdWIyWEsMoE7EqBRpNa
	 IenYueYQws4ogv3+04Yt1KgDRP4831uXb8pvgT0cHI/0usS7hVWrcWbnHyR8ELMiL2WmT
	 mOta5/5+BqhZ2c0mKs/AsuufEuP6vxlGmNZwPCn5LYKdMHC3zLVmuK2lY3Ww2/INz/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413462;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=IQ1mPDexkSojtYyVSk47D/wUaW02eDfgF2Or9AXRbVsFxSzzONQAk+IBVVOXYbJ0fA6Z
	 FjMqmuZM02qyWNnw0hMtwT/Tdd/+LWCd3rvW005CwktsAJK3b5tRQshI3m3Yrlb44nDTF
	 p6pyoejdL85KDnFq0f5SvYrR3+jNYk/87FBenYIL+VP3vIMC7UYvI/AOOTm+V7QEf+gis
	 nG5nDMzLey2WTcaPEzDB6muZJMwC4yQCst8zHINIS6Vci6qDk5asgAHaUTtIsnXlMdZbo
	 8Oc/nHYSY+wW/tjOcXOn+7TtJp5pS7cqbpQKUTQYNY1qafrx/ipfhb4BCSknAXr2dKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTagwcVt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768B606A332;
	Wed, 11 Nov 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTagwcVt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4212B1F00A05;
	Wed, 11 Nov 2026 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413461;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gTagwcVt6wfPWOukbtMK4F+izOIVBaVc/bqLqo1oLkfqG6Dgbu90r2I4HbhHegp4N
	 w0soW6s/lBf+GNjMX0w5PpTSy0FBN2YhVHVGs1TKLkl8QVYeX/NJW0U78fn0VOty1K
	 e2crBA07nXei4i7/C8P6apBxL6/OTO88LRBAEvlMMlxoqJvGCtcs+qxCHAjtkKQ8Ha
	 bPGhTxVlRD449/awwoO5azP268UlhfFT/seYQiIs4J9L6sykF89A5+pciH39L8fZt6
	 gyYF4GJnKFGQgfxzED2IGZez8oANAYv4m73BHHdNm/2xADFLYJNjPVyrnDHYvm6dRP
	 SJRA0Gkz9HVzw==
From: netdev-bot+sinfo@kernel.org
To: Tristan Madani <tristmd@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: 
 Re: [PATCH] net/ncsi: use kfree_rcu_mightsleep for RCU-protected list entries
Date: Wed, 11 Nov 2026 16:11:00 +0000
Message-ID: <179441346083.2168702.8368401124283892037@kernel.org>
In-Reply-To: <20261111160649.677910-1-tristmd@gmail.com>
References: <20261111160649.677910-1-tristmd@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
