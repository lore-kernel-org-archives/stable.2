Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793576352;
	b=KQCiWKEgMrYeK2ikI8V7kPAXQP0HMZopAVOb21h8edMTRFuBTOObTBYfp6uCUwCF0n9h
	 dD0RiQHuRe4ldE7y+iEsZk28f6aJXnvH1R37z8qqhaURhCMYQ11ZTmbzmJ+suVM6066/2
	 sPVNY1NesC3YeLx6dyo8+5oxxwh0IUlHtfSoOy5AxwGE1d/MiYrVFsINonn//W4NCAd8T
	 7w4o9JVXFU7tQDsb1w98G3K/VOQER2yUZVulrfoNg6bFrU/S5E6jYkVk1V8qb/6PkGFY1
	 36068unAq9sZT2qyFHTnB0/xEnwixxqEmOrVpTKXDNPSoGeVyvVGSBcpQf+fg5okBFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793576352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=NWXJPhbBN3foRKmGex3uHz/XbIeq0LjTlHBsW2QPca5f+aGgkijhy2LwPjHOLYvG1Fl5
	 D+OKhbuBR7Ka2I0mc2MDkI6IHec0xxD6RKUf2deF2hRREiAKQooUJ67FSAy4NwzWgC5YQ
	 TreisrNkhvpcWtoov1ke1kjfdgNR3w/r8uikK01ks6HE1ApcJ6irTMD9Lu6OhGpesvzQ2
	 lSRckNG7FSzC1whe4oTj93bH4WGPj5EyANqBiKUfIg1bpidTEcS18tM0HPWxnzIzJ+NDV
	 Hl5uLA2UFwv18rQ7f3igV61X9zl2sOBOI7p4RFjIryRSzIKOV/5pDL1XQpQo2PWHMgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcQaYuIH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A8606A326;
	Sun,  1 Nov 2026 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcQaYuIH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D111F0093A;
	Sun,  1 Nov 2026 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793576352;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcQaYuIH/4IVtn7KTqJbGEttz6Id/oHhP1JrpxFH0lTQ1FQayQJmrVtioCxZNKMuX
	 Qunum3sj9FGyE85ln0esOCri3Z8xoLUjDaR/LsgIMlgtYBN4g50w7FYDPam0PzsPVY
	 Ytgq76Awx+Grvik2SFGKLtdsrxkqVQGEk2aikwMeshiGHf9URptYU6DJOWhTnV4j52
	 8Rasw+ubSHkeNkZtZuRQH52+0aBFcb6QKogNG7/QRGBm/Ze91fdt2bFNgSNBVZOYUO
	 BEqm60eqnHjH5r6XpPH7p8t5NzbylH2rBbkLRtdtIhLcU7s7ifQhln0qn5tYgCuwzF
	 oO7qU0gmLh3qQ==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
 Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown race
Date: Sun, 01 Nov 2026 23:39:11 +0000
Message-ID: <179357635158.3286.10001576876397197758@kernel.org>
In-Reply-To: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
