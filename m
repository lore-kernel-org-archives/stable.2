Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503119;
	b=mEii4iis6fQui/q+kuGouOL0l/IgIBor7K9+JlLC6E3wGxXLZa5WwVAbtP7HYPUqIqBO
	 FqKS6PlvNFqGaI7Wo1aD8AQTLoBdliWHjebahozyKG6HhuCPVW/nbTJ5HAy6Dx61jT6mB
	 +bbjy3R5SAc29E2cW8vqDmhLbk/3rkvZ3F2vzgkU5gVp4ssZY49oXpNDBIFcmf9zakOb2
	 O10HKSVfmDJya/sFm4A5CrLTq07wjxG6gUV8svVSuRlyyVUrBIEsF9KIPTqsul1AUJml9
	 nqyCnzFak4bh9zPgd1DfdqEEJXpcVcSqpihGL61H24Bsx2GmAjB6Afu02mdvp9Qbm2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DLIfcgoUznNYwhN2Vn/cnOy2bGBm6xaZc0Mel+r1CSk=;
	b=nXhhV0Wusdjb3NsmMjIbv7jdP/u4aYJJgtb+rN+62pgco2BuCRB7wCg+oRg/2T/dKG/s
	 bBOgy0tvaFx5IjyDn9F8OuQMG2nFkPfARmCOW0Mfe31sklbac8HrD192O/sSkhRBIssA4
	 UjPl3eg6oxEW4j0FuJCgKKUdvyS+z2gB/Yi/4unQfa3M576tRRxNotYpdw3sa995TZOg5
	 9MIDkgCXeEuVU3DrevEaDhcCSyLgcjfe56XV14m77kpIMVQC4XlChshLPjPWXyzawXUwF
	 fr9n8MzdzrEH4LAU/mMOsF9IAxK4rG1bJvDOzLOQ8mssViBjs1hnb1wkL82YSmkEUpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6Jvoyrc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C614606A328;
	Tue, 20 Oct 2026 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6Jvoyrc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604191F000C4;
	Tue, 20 Oct 2026 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503119;
	bh=DLIfcgoUznNYwhN2Vn/cnOy2bGBm6xaZc0Mel+r1CSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E6JvoyrcQgSw20ptEX+6FKJe4HdUtKYwB32TXrGFAmyuq6DyrdtvxCltTmtcbSBuv
	 xGs+d7jPEb8NCjFsGRD3s80g9ctHbvO949Koef6eL68QBz0QH3YlCKNLpbqvkX4C6k
	 us1DDZED2WBbUBkdym5LJQP3aFzYZkdmWGnoeTk76h4BVEfNu30Ub+6pr4X9/LvrsU
	 tTBCBnbDeKz/CT9LyXCYZllgk9LfPqgXjWXaQ/LuPcEIQIDcXXOSZBgzRfIoQWLg8k
	 NOWgg9TFZ3RF+lkjaCt+gcYnGQCXk/v2mBr2FN0Z7W+Aei8x1DBbbkfQ/+0a8DezrF
	 zpBrUY9y71/vg==
From: Sasha Levin <sashal@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: broonie@kernel.org,
	corbet@lwn.net,
	error27@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	kees@kernel.org,
	konstantin@linuxfoundation.org,
	ksummit@lists.linux.dev,
	laurent.pinchart@ideasonboard.com,
	leon@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@leemhuis.info,
	mst@redhat.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	tytso@mit.edu,
	workflows@vger.kernel.org
Subject: Re: [PATCH v3 0/7] agents: add skills for Fixes tags, stable tags, similar bugs, and commit messages
Date: Tue, 20 Oct 2026 09:31:56 -0400
Message-ID: <20261020133156.3153106-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016160030.118973-1-ojeda@kernel.org>
References: <20261016152828.3765695-1-sashal@kernel.org> <20261016160030.118973-1-ojeda@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 06:00:30PM +0200, Miguel Ojeda wrote:
>If we are going to have a skill for the stable bit and you are updating
>the list, then may we take the chance to include Rust soundness issue?
>Please see below.

Could you send it as a separate patch to Greg and stable@? It doesn't really
depend on this series.

3/7 only drops rules that LLMs follow more strictly than the stable trees
actually apply them. Adding a new kind of fix to the list is a policy
change, and it should get its own review rather than ride along here.

-- 
Thanks,
Sasha
