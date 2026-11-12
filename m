Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493062;
	b=oRrE7FuUTTg0lBC0LdQK6xa4fRJsy+h9btMSVZbMKlsCGQLOQrgaRTELaSwR6x1JVDSV
	 iaOPmQ0p697EcaRpzkuOxqhJ7HBAyeoTi/0KToCYPOZ5iojdNeHS1ZcxQropdhwXTO5IB
	 LVpOu3FI8SD3WEU5/o1sw7CdkbHTaPAG0/bb0Dru/o6EiPg2GesIaUkjQ40kt/r0Yu6Fy
	 /ahmfLBwVmRV9KxYz71V4l6DNuqpyIwe26IlN8KNaBfZOEGzp5NrO0plyf3p42XlkiaZ/
	 Hbw0Xmv2/KgqsEypI2TOubHsxuHPLwf+PR+4mPN6yppyqYCbHHyp+wSV/Boht9eyKFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493062;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=uVC1UZvNpbPR+bgPqRTm15L5xYy+BXidKU0ZA+GOJTQ=;
	b=RJ9b/Vo4XoFzc4RT4+fme5jDp3YUVPAHTBZynKtqOcussJDL1ViSVUWfvBYZsIOeNaju
	 1w1ZrHY39slTq7GD/OjaYA3JNaVuAPTiQMzrCMupgcTnMxUlRgox63szu8iQ1kxs/QUlS
	 C6VPnJIrE+njsnaTXEPk0RATFVYHjI9WC2T4PsdrWcpl2l7aROpSOK6778DdjtoZjMHeQ
	 jVjMYnU1yfnvvTQFepRob/WovPyLGpXLM6qpp9FOO+0QimoZl6hn3lN7y4hyg9f0AKY7L
	 GGe8icsFKl0vZYcoY291NmZjc9FKvPDS5mziQr4QlQWD55hA2HgV71Z6lIwY6+pmIqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juy3VrPE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A1606A887;
	Thu, 12 Nov 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juy3VrPE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A27D1F00A05;
	Thu, 12 Nov 2026 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493061;
	bh=uVC1UZvNpbPR+bgPqRTm15L5xYy+BXidKU0ZA+GOJTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=juy3VrPEurVo5mfr+33Q94ZroL1plyGVoPn2mT/38eat1u6CtVIxD67NREnEICYfl
	 dBVJso7hE+4dugVUr3Wlfqyel5uy4pyf20hdEaFcGlVPHTYDv2vDRnNSa70FqenejE
	 2m8tYS5oiL4v8XcMj3neOfk4dSlv83KdnwusJGhr4FNEpE21jpMilVEt7lFuQbEG7/
	 OObs+PlcxwBqloSxGJL8URX6N9Sp0WMy+/sUl7aZoCYyNiXCKuTnXLPmyoFVHoNDRg
	 MfvXNcLTSS51Us0kR9nmjs0T5abv7Zs3DrOkZ03xq9yPTcVN+s/H+As5oIIzLsuMcy
	 myQrl+dRnuuvw==
Message-ID: <6af42f08-c052-48f4-b0e7-32cb340edbff@kernel.org>
Date: Thu, 12 Nov 2026 15:17:30 +0100
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
To: Sasha Levin <sashal@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, workflows@vger.kernel.org,
 ksummit@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>,
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
 Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
References: <20261111225940.1573565-1-tytso@mit.edu>
 <9c5f5976-ebed-48f3-94ab-1121231af6e1@kernel.org> <avXCcPYM9VAP0JHf@mit.edu>
 <31a56051-bd63-4a39-9cad-2c9afcd98340@kernel.org> <avXJSt_3DYx6aQsD@laps>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <avXJSt_3DYx6aQsD@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2026 15:12, Sasha Levin wrote:
> On Thu, Nov 12, 2026 at 02:49:09PM +0100, Krzysztof Kozlowski wrote:
>> On 12/11/2026 14:46, Theodore Tso wrote:
>>> On Thu, Nov 12, 2026 at 09:26:09AM -0500, Krzysztof Kozlowski wrote:
>>>>
>>>> All these are docs (even if you call them as a skill, it's the same),
>>>> therefore they should be placed in Documentation, not in top-level. We
>>>> should not create one documentation for humans and another for agents.
>>>> It's just one documentation.
> 
> Right. The idea here is that agent skills will mostly refer to our existing
> Documentation/ and will only act as a glue layer to make agents behave better.
> 
> Consider, for example, one of the most common feedback points we have to AI
> users: "make your commit message way less verbose". This is the type of things
> that would make sense as an agent-only instruction.

I am not objecting to have the instructions for agents. They should be
however placed in Documentation.
> 
>>> Skills aren't necessarily *just* documentation.  The skills
>>> specification[1] also defines a structured location in the skill's
>>> directory hierarchy for Python scripts or other executables.
>>
>> Specification is also documentation, just like for example specification
>> for our ABI. It's also located in Documentation directory.
> 
> One of the reasons to keep it out of Documentation/ was that it doesn't mesh
> with the infrastructure Documentation/ uses. For example, Documentation/ is all
> .rst, while the agents.md spec specifically calls out for markdown, and a very
> particular construction of that file.

Documentation already has YAML files for Devicetree and other ABI, thus
difference of format does not matter. It's just minor technical aspect -
tweak the Makefile.

> 
>> Agents supposedly "are just tools", thus just as sparse, smatch and
>> compilers such tools do not get another top-level directory.
> 
> I'm a bit confused by this... the original reasoning was the it doesn't really
> fit into either Documentation/ , scripts/, or tools/, so we just gave it it's

Oh, it can go to tools/, I don't mind.

> own home. Why does it matter if it's a top-level dir or not?

Because we do not need one more top-level directory for something which
is already categorized. We do not create another top-level for
"drivers-embedded" or "drivers-acpi". We do not have "tools" and
"tools-ai". Neither "Documentation" and
"Documentation-for-ai-but-we-will-call-it-agents".


> 
> It's something we can always move around later - agents don't care where it
> lives as long as it's refered to by the main AGENTS.md, so if we later come to
> the conclusion that it makes sense to move it, for example, under scripts/,
> then we can easily do that.

So place it deeper please.

Best regards,
Krzysztof
