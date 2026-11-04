Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786586;
	b=uhGP/dlmQxBbud3dww12rQKq+MrsFb+aE8Xl79hLGTAaSsw2AUIeuUiAMKfckTXl14qQ
	 UxxKGFJRkXQH9Q0H7jQXIGJgqxCON9wJ01FTNxmMwiR79auvmYj4XlNPd2kJsoOE0unFD
	 G8S+ZsgcnOCCc7amgkQF/iEYngvLi+dU6z0GyGW+KL6gP3N4eo0XvPotPQ3zPWGBrlRQF
	 17//BIyUtURqWLOpt8psiUMvS9muy/T65qmk7IXrGF4r5Kg8V29TGO+HbOPWTBsaCTOnP
	 HFITUAEZh8WP1wvPGqKgZjxynpRJ55608dCbgR9mHD7jgHldWdrqS1/fgnHaZb5CfaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786586;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=1uSRjBukXt5Dd5O77lr8PlstNG6LU3yReylREjd+JGMBU4JINM9cfkimA48qojtYNWQP
	 kuFri0CRgV5InJTuB+GLc7HdSo6taTDYOFXt167fwoPH/XNCbmaoQpTLLMI95HINzvdcg
	 PoWQY2V4qCWUAWVFe6We1B21vWkZ2EofnzYMuClTrw8ow0vdyEanH5hQFe4nomQYKQgab
	 rHhTYbJ5cAYvxI3qI7K+R1D0PIj1z3s/205AQL/SYSXRKAMe2b6Kel/bNv8DTaVzJGwQy
	 Vo8uB+7J1fUQveHTahRr9rGF4b5kGRmW6SxDE/UZ1PQjMER/nvjzQw5cBlQoFBAMQKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4hUIRK7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F7606A328;
	Wed,  4 Nov 2026 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4hUIRK7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEAB1F000C1;
	Wed,  4 Nov 2026 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786585;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q4hUIRK7lDxlTwiRVNaJGxTPAiN/l7vZNchSOA4DrZa0R96ZY6IrkIqVhRLj0jeb1
	 gNEEjq1SXvNTbcHawXpC9cWHy2jJN+nGse6jRDawnpk3aDWOD4w5eVS3oI7mtb+dSa
	 lVkdmCyNIdWKocjbK647dnTrlxEZD4ZoyW07+PAGgK/1N2oxI7+TpmCn3lbrXltCKP
	 4C1SUxftATUV3v7fwXSffcoQm59l3bN3o5wmUst6CMLC14PDLwbfCDQxMyjTG+1qz6
	 6ay7L7NHxaDR7MMJoKzqlGWry9URlB4DtWrNBsSfRDe3tVPc07U8CndxCXfzmL9VX1
	 CmHA3DVSucSXg==
From: netdev-bot+sinfo@kernel.org
To: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 zihanx@nebusec.ai, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] mac802154: validate pinned interface before beacon
 transmission
Date: Wed, 04 Nov 2026 10:03:04 +0000
Message-ID: <179378658462.488859.2613991577119336688@kernel.org>
In-Reply-To: <179378621331.55520.8126896786309171541@stu.pku.edu.cn>
References: <179337523079.51423.6573078122047317758@stu.pku.edu.cn>
 <179378621331.55520.8126896786309171541@stu.pku.edu.cn>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
