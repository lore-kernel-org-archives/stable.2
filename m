Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704242;
	b=iDN4JC6+wGv0P1o9laMNmgZTZt0SVNAUSMy2c/9KI/ytbJs34bRMipbbwTyy6qigfd8Y
	 MyNtuzxCzJERb0uIjJWyVKx5rJQCPUT2NT9okifuZg/IkqNro7H3Xnm365GXAX62x1cY5
	 OhkBKlof1hFhgMfNx53LF31l3gsCVMbXjJKkgFWIivvi9ui1Oh4OSkbeI7Dw2AZrvNmJU
	 N6C3OS9F+Ih0G7mHwMvSDU6u5g41p3aEhgyzXzTFtv9lv2I9NIGrXVmqj+pYp7Hm1ROaH
	 GxUn2OClSk93oT5Q2QswRFLoKVoGEqsb6qkQ8rCsubLXQHX8y1Bv1vKiJvIJHJuu2fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704242;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LbX5Q7p4xQHFkAnxvv4GcKsc3X8LYGY6+OaH92+Mxgg=;
	b=gIOEoJG6M51EF48tchk+aHraPRrP4SzZMZhScG4WRtFpRWcswfqguQPdUz0vxJ740Bh3
	 9QvH0Iq7ejvFM0HpQtJqfkrszQC2Hw3qv9xHHVLg6QAIAdbFCwdp893mqZehyh5UOU58t
	 +P1t9kLmpAXaWKT+ZrJWEDNqQGrL3qwCh635jKwb4DjQcIIIEMY0eE2rUsAg+rmJU1jb2
	 QU/jMwU27qPcDYLlT2bYmAAFgDRhe/JU7QupcOdPhJ2CBZD3qRJwpzG46wZJPHZfvTfw4
	 i50MH+QWsQ3yKitupUPnFr4jK/ahtJztRocJPEXv0EYv1ypnZt+Rv20sQDUA1TfuAZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaSCruUJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB9606EE9B;
	Tue,  3 Nov 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaSCruUJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DBF1F000C1;
	Tue,  3 Nov 2026 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704242;
	bh=LbX5Q7p4xQHFkAnxvv4GcKsc3X8LYGY6+OaH92+Mxgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iaSCruUJv3kdb7l48HlV/ZPCcpEN9U74E07lrc4MkMn2Ex9UaC9XanM/TeR2DN1rq
	 hzilA5yK6jLeyWsbCqC3vjokTV/2d9rMV9KgkkXQHZ60CdmDdUWTbhd44O056GhHXn
	 EgPJxCCg5n5JLg6F89ATgtvQwmdm2SJyMGo+veJPK2T9zFcUUthKCAnIceBEmRidOJ
	 BJ1tGJaUzeGE1hQR5Na+zKNMmUr3PhF9VQmqXkjrtB73UFEl2H73zTAHkUNEZkgo0Q
	 wSY5QBK+DxTzsEAQ7rSIQEV3pxPxwEkz8K4CK2G9CkE11S9it7dR7nZTHDcV5UdCOO
	 JDzrml6d/OdFQ==
Date: Tue, 3 Nov 2026 12:10:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] of: unittest: fix node reference leak in
 of_unittest_match_node()
Message-ID: <20261103-tall-silent-skunk-9e4e0f@quoll>
References: <20261103104237.1373649-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104237.1373649-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:37 +0000, Wentao Liang wrote:
> of_find_node_by_path() returns a device_node with its reference count
> incremented. of_unittest_match_node() never releases that reference:
> failed matches continue to the next iteration, and the reference taken
> for the last test case is still held when the function returns.
> 
> Drop the reference on all three paths.
> 
> Fixes: 1f42e5dd5065 ("of: Add self test for of_match_node()")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/unittest.c | 3 +++
>  1 file changed, 3 insertions(+)
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




