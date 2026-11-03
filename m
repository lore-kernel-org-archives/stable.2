Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701557;
	b=IUGq8rnseZqYOULvG8X2ycWQTCAkdqcw/8Qw/UZO1Ml4diUcb7SFy8m8kho8GSBNqdrs
	 YFJ0s5u7sCklP7qrMp9UJhMWlz69g+Pgc0HRlNKSBf+LUEwWBeHxkubSw0gXXWdubiG7h
	 ABZ0nVNTWXektDzailaE5PgIoJK8LtbVQPussdbgFT0qm2ZFpRAonXczR6BV97cYdnsF9
	 pwJYZuNksM0gYlMQWcVDpizGrv6PehVdn+uimLaLeoY+Odk5kgbCondPzvKnwvA845JRa
	 +1/iB+ppd8ACsIwEJU2FUt10DKp1ID0MtStAePwTSPB+DCBdIPLMSQ+hSRL6glz8YOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701557;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5KI3+3f1eXD1AbwGu/HBthEKx4z9RYmeGKm2TceIDqY=;
	b=gricc+8ZVDACqj0tXiVlUlCrb/vVl/XHP5c0KnaLcUk7K1LzDpYmyFV8xEoFe7x4ypxF
	 V5NuHS7m/yG5caou5vqKOBAIx/Ot+htLSeZonR9JTqpIGbs42OmUcQeJ5MiS5HbfSXDTE
	 qxV3cMH1L7798v34MH59qKRNRCz/CeFRi4L5sBZX/8u8vA8tOML3XGlJwcEWjoFFvJaJ7
	 ws9mfdu18RKstjKQJUlv4aE3qK6DW5aG+4W4qDq1gBCvd9DMfcKGX9oeace4U1nDHRUDO
	 XarWSP52001IWr+bmcbiCRadRC0MLY/Ov0p8VyUrwy2X2L4yQisBWGVupRnszCYZwIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJDC9wB0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92152606C56C;
	Tue,  3 Nov 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJDC9wB0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07521F00919;
	Tue,  3 Nov 2026 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701557;
	bh=5KI3+3f1eXD1AbwGu/HBthEKx4z9RYmeGKm2TceIDqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WJDC9wB0x2cypdDvolmusK0+gB2oEMMxWNNIV6zLgH0Erx2j96CkahI5+/kIXDJuo
	 5xKlhUFmgHqvUVsaxLPFB7MhS9BVFTxKlKtlWXmEv5cwE3XCYXxvm4MgmAJHgDR+nv
	 VbsfEDH+psbgFqao8KYujWaVV4obgcwK1AclRl0GkjEQCNX6FnGlMXNia14FU68fjc
	 VgrC/X5WnQEf7DWXdYZegr0epiITF0dtHYLF9jC4Jop66gAFn0bn/VXLu2RaAVsizu
	 5oLjk48dO8DJslBixxSM5P7vIMrT5OZjTR9vje4o9qwHQgZ3g4PjvmGvrQPi3x8GuH
	 2aa/NGMeLSg9Q==
Date: Tue, 3 Nov 2026 11:25:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, netdev@vger.kernel.org, stable@vger.kernel.org, 
	Geetha sowjanya <gakula@marvell.com>, Sunil Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH] net: octeontx2-pf: drop the TC mark reference when
 adding a flow fails
Message-ID: <20261103-neat-industrious-nuthatch-12d90f@quoll>
References: <20261103100536.1310108-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100536.1310108-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:36 +0000, Wentao Liang wrote:
> otx2_tc_parse_actions() increments flow_cfg->mark_flows when it finds a
> FLOW_ACTION_MARK action. The reference is meant to be dropped again by
> otx2_tc_del_flow() when the flow is removed, so a flow that fails to
> install after its actions were parsed leaks it: the checks for the MCAM
> entry, the insertion into the flow list, the mailbox allocation and the
> mailbox reply all free the new flow node without touching the counter.
> The same happens when parsing the actions itself fails after the mark
> action was processed.
> 
> Release the reference on the error paths of otx2_tc_add_flow(), using
> the match id of the parsed request to tell whether it was taken.
> 
> Fixes: 6a57f091622a ("octeontx2-pf: Add support for offload tc with skbedit mark action")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
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




