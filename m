Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495386;
	b=dj9FJiX+gXlo47kRoqq/5NcEeqHIdpfPVyALUAQtgeL96sCCpyigcbouj60fr6GIBNjj
	 ZUrtN8rpwOuhl7+C6KD1MjWx/dFwpv5LKg/wv2ULPgXELZ8ZuPAIMUJBbSpA6jCYqmxB7
	 +/wu3yEl0m1EV3lR+1fbcT2PomhRpUg2r4i9TuEl2eEVHHm+Y5ZdMWU8yDHLZxoGRqmAY
	 6GPrs25Z6j59Vqr/C7SxCNppyX2XitURc7GTlFVlxNEkedsp39Io/f3pDHlWWWs5MUvyJ
	 2MKRv/vbx3UYhuceNP2ynCaan/lOPBwQadtuoQvHaw/liklEvztVTu+iOnoN+Gf/8WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495386;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eR/dgfTX4uX3tTDw1oIx0quyMtQsSjo0do2Wb4F29/s=;
	b=GihHFFicksl7hpdm5+gsBrmIWtt4bdP9NWIdj+9RJly92xNVyBE+emYon4ub8ECoeVRF
	 OLrAKTCgIqoJZ/AuebTLOWc6rBpFVXyyX/dikwOKYIPR0BnIfSnEtWe6qqUyiidqRNIez
	 M6tynTHJTXOsBSthjcuEgqml5up5e6zeb0SfP2xt1onkY54bPmPkX0DKCWS9Mwry9/50g
	 DhiNb/vWO+/cW4mSULd0O4hz79uWw2tz8MqWS3gliyisVDAUlDL9Y+h6PGVvezI/X7nHg
	 v8w+ys3UU1iB2RVREgSRHO1uLXD0h7rY7gxHMvZPNmhHwLQQeevE5T+8OfxeZTxdxzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFAL8ciK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33D606A31C;
	Thu, 12 Nov 2026 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFAL8ciK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B6B1F00A06;
	Thu, 12 Nov 2026 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794495386;
	bh=eR/dgfTX4uX3tTDw1oIx0quyMtQsSjo0do2Wb4F29/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jFAL8ciKEPVfAPoFJqaLI+cRjztWGxLzlgZ2ubFd8NzVcqMHflFmdg6cBG5Ea3qjr
	 cAsCTFkQ1DLiHdTb3b7tEJx9lTfP4X3ouFkbcwzDHDtV5DVcg57mDlApUrs9lMZozH
	 wIiyeIWYQjdjciPnOgA566JuvnvZDjabQ1Nq435e6TcbAmDdRI2w7AYsm7bZclylNn
	 V/4Fl3/vi8CQdYAP4UiyRkaA3HmO1132K5MwyVyls4rh/T1L9eJLQdKz76LO0Y3x0a
	 PTvQng3hL63LTAWArdr0iyj/zBtrojSGz61c3HSC2WwRH2L1u3MH3/skHjjta55OCt
	 nILJqbzVcn2fw==
Message-ID: <45fd1a88-8fbf-4735-9892-c374d8bf4df5@kernel.org>
Date: Thu, 12 Nov 2026 15:56:15 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] agents: add skills for Fixes tags, stable tags,
 similar bugs, and commit messages
To: Theodore Tso <tytso@mit.edu>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Leon Romanovsky <leon@kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, "Michael S. Tsirkin"
 <mst@redhat.com>, Kees Cook <kees@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Dan Carpenter
 <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>,
 Bradley Morgan <brads@mainlining.org>, Sasha Levin <sashal@kernel.org>,
 stable@vger.kernel.org
References: <20261111225940.1573565-1-tytso@mit.edu>
 <9c5f5976-ebed-48f3-94ab-1121231af6e1@kernel.org> <avXCcPYM9VAP0JHf@mit.edu>
 <31a56051-bd63-4a39-9cad-2c9afcd98340@kernel.org> <avXOSg4jOlzBY1r5@mit.edu>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <avXOSg4jOlzBY1r5@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2026 15:42, Theodore Tso wrote:
> On Thu, Nov 12, 2026 at 02:49:09PM -0500, Krzysztof Kozlowski wrote:
>>
>> Specification is also documentation, just like for example specification
>> for our ABI. It's also located in Documentation directory.
> 
> Source and header files can also contain documentation.  But we don't
> put them in the Documentation directory because they do not contain
> *exclusively* documentation.

The type of file and its main purpose is a C unit file. Documentation is
only an addon to that.

Here, the main purpose and type of file is documentation. Specification
IS a documentation, just like in-kernel ABI specification is.

I found no other than RST and MD files in this patchset, so I really do
not understand why this is not documentation.

> 
> If the complaint is that it is visible when we run "ls", one

Yes, that's one complain and making it hidden is improving the
perception, but it does not solve the point - it's Documentation so
should be placed in respective directory.

> compromise might be to put the skills in .agents/skills.  This is a
> cross-harness standard which is supported by some code harneses
> (Google Antigravity, Github Copilot, etc.).  Some harneses (including
> Claude Code, Opencode) don't, but people who use these harneses can
> solve it by installing their own symlink from .claude/skills,
> .opencode/skills, etc. to the right place.

Why does it have to be in the top-level in the first place? There is no
point in making LLM stuff visible to humans, except maybe pleasing
people behind upcoming IPO...

Best regards,
Krzysztof
