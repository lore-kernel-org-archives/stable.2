Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704213;
	b=vlsPjqxwQ0foA1Cvs20sQFkq6QYF7Q/ScHXB+NNOI1Ge8oE0AEx7bnOBXMrXS73MD9lo
	 6zlXADickcftn2QbQ490DI9KxBFhkbDHsIdPLMQBqn8Ms83v3blH9ALBinTD4tNOaJI8x
	 pPfrLHAnlDqtezy4t5L+YNpToKafa+WiCBq+x55z0qTlXxlESwm6TTQlXjYldjFT4J9n+
	 0CCaBpTD3juF6GMbDJU62UWc4ypwH9XNm0DKatWE1niaQ4Jr8pNwqKrQQnBuvsD/aEA1z
	 Pw7mKeaJJLIuSd1Hyl/s/R+y+4EhAJO6H6WKX0/fLNHJAFx7L+7O3NggqnjY99/GBIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704213;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Xrwz9IBfFfoHPQootLsmvN6SUAJ6eFYWOgccNCVWXhw=;
	b=ACydx0Uho4XJV2YKO1QwfXIzM9mX2HBhEodufMzasSmodcCyYo/P3ukgSFM7i230UHi1
	 ZaCAueKECMtFdggRJjSOmbFPuClxkN2WwlOQ/JFg4m8qRRo3N8TJIxO0EKSIaI9f+EMj1
	 nN5/dAY69rx4vTdty1MQnkNaILCD8b+W2esmlyA0DxXz7qrq/F2n6OP5N6wFHYE/ugkzk
	 fLH7qzwZFOpco9CAS9uRiVceKf7MK/0Cik6BWZM3cdgC09AVhykh7Ave4d8bqfmXPpDnO
	 PT1HQWxmgrBSZu2pbxNNEsbx6Rkik032P4k9dJ0pO6Lx2R9ERSRYlBbSfb6q8JHJG4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="it3qxw/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786E606BFB6;
	Tue,  3 Nov 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=it3qxw/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB841F00919;
	Tue,  3 Nov 2026 11:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704212;
	bh=Xrwz9IBfFfoHPQootLsmvN6SUAJ6eFYWOgccNCVWXhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=it3qxw/xgXslVOfDZnuYm37LYUCszoR1IwcpG5DTgFmzjezsEs9DTWVTsIJgkwkm0
	 i1zqsK5mu7KrB/f+b9HpX9MWbsXRR0/cJg52viK4qaSjUy6bhAyWuEgJsG5l0gHscQ
	 jLRPYN3ijnPFKcd0tvXCnJsS65DvcBwy0rnqEiwPhve6K96JNZKKoqaT/5jUZ86kwS
	 8KIBJdZzXNR2rGOG55qkD2BR70rbYC8ginIWxwk/6R7Jz4sqbO34iJCowhHKUMewj7
	 CERU1ibMpTHxBa1wat48SRUrUxNSxjFszDOT1Yu4AAp+Fq2xQTTD0gp1aK3BRTD6TV
	 M7tVKcG3ikDzg==
Date: Tue, 3 Nov 2026 12:10:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: x86-android-tablets: fix codec teardown if
 poweroff handler setup fails
Message-ID: <20261103-ludicrous-fervent-malamute-24ac38@quoll>
References: <20261103105544.1394559-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103105544.1394559-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:55:44 +0000, Wentao Liang wrote:
> lenovo_yoga_tab2_830_1050_init_codec() stores the codec device reference,
> the pinctrl handle and the pin mappings in globals on success; they are
> only released by lenovo_yoga_tab2_830_1050_exit(). If the
> register_sys_off_handler() call which follows it fails, the init callback
> returns an error before the exit callback has been registered with the
> framework, so the codec device reference and the other resources are
> never released.
> 
> Factor the codec teardown out into a helper and call it from the error
> path of both init callbacks.
> 
> Fixes: 4ce8f4c2027d ("platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830/1050 poweroff again")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  .../platform/x86/x86-android-tablets/lenovo.c | 27 +++++++++++++------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




