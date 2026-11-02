Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585004;
	b=xL4loPITYNQMD5hKoBbC5Qh0ZwnLUOgrhZfDxllD0El2U4Jj3MJVV7s33Ldeh4igwRS6
	 pGols3wb2Z1lNWmZANY/ZyHk/fTIYy6b5hI1NRXETBo/aTGNSBV+0NhZy2LY2rL0lLh5w
	 AsFvYEFR0BNrPRuwdkX8jkt7gmRwCjk5eOdgCbHJPcXepDI+i80mSWh08SlptuiZLk5qF
	 s9x+f5dONUpcZAszOya6Ks5km2VuYuZolU/eG7GubSAzd2e1XtqkXsXtcCoNHzKwNI5Rp
	 LsDF8xIC7asx87V+e84/URph9PfEbi1YyPTtih/sXh2qYWlyeJOKmBvrC5VI6RwwJqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585004;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=vbjAxX9Qy4b76rdgzSkrR0jEbOkdVtxQvCiJUr1ahQL/3vpFAMJ8ecDePhoH9t0yGj0T
	 fpNKw6VB+rcO0Qzc6AiAHlYQkfbSbGv+uBRFfQyMsnQ6CY6CnuIFErVKkrqyX6m4t1MYk
	 9wsY6LkfEIDiqIG3IC1uTXj+mOx4mOBa9uCO/xabaqG1gUTV2sTG7Qd1+wnzNiG3ewd5Z
	 +8SVgP3h1z7sFvHAQw8n5Xqc5ZQ1iFzLTEeVgog7Ei3R2FKZJ86YXycBNBr8KkUz6ETZs
	 HBE1UxMkvEHwPEhBgKjQJKdtdKBhazZh7SgqMvVB7RuavvqoCVl3Gzu36FJS1yfhsVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmGzi9JC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB6606A324;
	Mon,  2 Nov 2026 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmGzi9JC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCB01F000C1;
	Mon,  2 Nov 2026 02:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585003;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cmGzi9JC/l4trm2uERbpxDwTgJLepMnRLAb6LXkBISWCA5NvhMadbML4XHYhgiypg
	 N//7uLYm4hQsu+QWZFzwulEP7erDMoV3nrgtEnyufSWIC3vtMk9DvHephD6ztFhFwH
	 AlMVx3eG0obmBkehNfrOWLtvYauQioeeTGvVcMb248Phq4bKGQ3H9azaPaj1HOKBBe
	 IDDXf1/x6jqiqD11Chtvkfalt8xtmNkyQkxuIk9O70aJhpJcV2eTDWCNBmYmytFmyA
	 /KpyNxsdGODW7dO5sYkg2xkyvRUqGT+IPg2O/Vg+GJw/XEWeEisI+J6Cd3b0sXtFO4
	 e7pvRhErYCixg==
From: netdev-bot+sinfo@kernel.org
To: bo cao <treebacker@foxmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, edumazet@kernel.org, idosch@nvidia.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
Date: Mon, 02 Nov 2026 02:03:22 +0000
Message-ID: <179358500215.3286.12801503551646664009@kernel.org>
In-Reply-To: <tencent_0A4B784EEB3D358B09B43AA2B2F13AE44505@qq.com>
References: <tencent_0A4B784EEB3D358B09B43AA2B2F13AE44505@qq.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
