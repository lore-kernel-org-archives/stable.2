Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690839;
	b=YiX+WkL+AiM4jOpUBr7sTqe76jzvciWocmNmFQrGUHN9DV2oGmO3wrJhzMxZH5WQRmsJ
	 0fRYPA9bulxDwyUu5/47UpSHFTW+yjAasgMhLfuhWucE3b0aATgmcD2Cm+IJAXR2AST+u
	 IWLOc9l3T9wwmP0WD3FZOf5BwmYsd9I0vrT2X09lmkGiyxOti6ij06iMqAoMketG2twAH
	 ByDT37YlCxkL8klnlEaqX3wNaW8F5xZ/nRrGEZY93y53dTOrTe1RsAxbJTHw6j0+NzIKK
	 AqKnGxiH08MznwN/J2NwEJXcxFnrLJWf3ySTcysjvt4RolJOPpZP5RIVhTMRziu/0ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690839;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B+eNvJhfvNdmdTeUsMCHHrwmrIHwL9fR5Evuw6xT+Uc=;
	b=ZOkjyVE1S/sy4Dm/YZwUMrBJJ3GFXIAkpsVNjwvnGUhMzL9IQTSlk3/BWgqxPV9mukhV
	 orY1W2gEZQjXmnST6BlpucbGwjyGPmMa2YSNSI2O6GAVHQ2F9leRIOIGuZ4hBGbxwHjdJ
	 sN0vT6W/zdOlF7KLlhtVzJTHpfiS1V+8eVyXT2Jl/Q7thWU+jbSjGBS7dxD8LcvY7aJYN
	 J7AABgTIhmFOxugeOKH86FFeUF9ESMgRai25luLwo9bQePppYNEgqUDwFPf4i7S4s1/oq
	 s0SQZ1p/43NsZw6K8Tuq3VbjPa00OL5ULlQtt/cpvhrLhPeKboNtQ9cEMxkMUsFjLMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MoHr1mwF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91C8606A32D;
	Tue,  3 Nov 2026 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MoHr1mwF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4F11F000C1;
	Tue,  3 Nov 2026 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690838;
	bh=B+eNvJhfvNdmdTeUsMCHHrwmrIHwL9fR5Evuw6xT+Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MoHr1mwFRaq2TGTAMRbam63GEuqHqbo+I2LWYGT6pUYj6BuDfaV3ulaxquM+bAq77
	 mhBDDBoifZ3lyzqH/vANyzXSIQB5sTO9UccxhwPJJIoJsezz/XsgK8tayls3V96V2y
	 eQgQ6DtjKF/AfNjgxk74suBCwQCQxhSZ59msSmdxzU7NMO0PGVolMwsUGJXExgTPmS
	 aNMoBC79xULgyscGBXL6zr3H09PNSZBhzK0twvGxj5GH8ektlvwra0FaK3Po+jP4Ob
	 utcI8knwtOym8JYUaiaclegpS7Dl62copYGH8j8WoEIEAbUc/z3vfa40Bx8FyXPdKW
	 HPGgwfeoIrrdQ==
Date: Tue, 3 Nov 2026 08:27:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: hsweeten@visionengravers.com, stable@vger.kernel.org, 
	abbotti@mev.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] comedi: comedi_bond: Track opened devices independently
 of subdevices
Message-ID: <20261103-stimulating-malkoha-of-popularity-a9d0e3@quoll>
References: <20261103063301.1025860-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103063301.1025860-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 06:33:01 +0000, Wentao Liang wrote:
> bonding_detach() closes devices by walking the bonded subdevice array.
> If a device has no digital I/O subdevices, do_dev_config() never adds it
> to that array. Its open reference is then lost. The same happens if
> configuration fails before the first subdevice entry for a device has
> been added, for example when allocating that entry fails.
> 
> Keep the device returned by each successful comedi_open_from() in a
> separate array indexed by the configuration option. Close those devices
> on detach, including attach failure cleanup. This also removes the need
> to deduplicate closes for devices with multiple bonded subdevices.
> 
> Fixes: 3cf840f65ad5 ("Staging: comedi: add comedi_bond driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/comedi/drivers/comedi_bond.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email, thus I doubt
   that we speak with an actual person.

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
letter), how to document usage of LLM and what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




