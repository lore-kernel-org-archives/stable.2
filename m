Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704194;
	b=lQmBiW3vU41XlhkCMvY46fkklwA4uTTasIskMGLU6elsfd+QVj/Hq3mUAV/SBR017Gyg
	 B1yKxetukh2KTHKtG0YXcnOXS1XA6254T9h1scSKCdefby1QBylDTwsyAaU04/yP+L198
	 RZ1OBr1H9vkmPEYy3y2dTS6SPjKZGE92bub3NAP6Qp1IZ1JBPOAmoUuk1zUJN8TYgtLf2
	 FXoLR4jwYZ5xCVRyC+PXNNpOWoMXCTZnE2/4igJyQKQdOuNJJ9FdWK9wIaFbWZlZoJBR1
	 /RbX2w2Om9i5iYtrt5oc4qbEX/Lnd9KbuYMnkmBKoiOgy5Ukj4kLzf4lvVIsdyAH/qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704194;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LTHXXlDvE713od3uIOfQGQRnvGRs7eiBzcZTb3Nu4MM=;
	b=cyXcoeQu0PzalkNZQHJkw2R9Q98GiYZeOcuQ30vvU2iJY9l0HRhEsHLX28l3unGLxWAf
	 nNiGbMeCzqpFAGgScMLU1fnM+n9kNmH4sozrbODcSJAdvE3hylvET/uKMvQPtaOlOdTNQ
	 asRI1cE5c/fV7ed2xovIR8kUd/Eae6OWms/yi0jrW0IZHFiCggNHpQwmkQj22mQ+brmvk
	 HdJ2DW7Lj7ctLWWldCkZZR9COLJrNPAQ4WslqeGdNPBt5COcFeMcxXMZJzvrQO5w+GQjC
	 t0AR7vb97Tqc1lxb2ZKQU55OsVy6yqb14g78fEFBLfv4ejuluPk53A6ziHa8QSV6Xrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQ8NJxvd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68391606B126;
	Tue,  3 Nov 2026 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQ8NJxvd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6491F000C1;
	Tue,  3 Nov 2026 11:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704194;
	bh=LTHXXlDvE713od3uIOfQGQRnvGRs7eiBzcZTb3Nu4MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bQ8NJxvdYbrmLsWPkMTMUq4/uW0EkYr9rXiXTSFD/B8lHEtAOf+wnbAKmG1GWt8Cf
	 +Nm96tuyHs67iCgx9MT63+krq9GM65Iu31bM1isrSWNT0PnXyQZhtMCO5+V/LkTEGR
	 h8GvUzh5uKiE276W5306FwhojrZX1uIdSjQcSpOGiGeVIoenbseoadSnsBnVI8dL+S
	 f6F/h5k/Jm+NmRmrak2vfKYmDGv1O42V5HkPqj3ndi6wRQ+9Qwkbr7IElCP06uhQqp
	 td/5Kv05yxF3jXwAq6DpuR3OfKnvqSY9rUJyC00iSWIlLruyVDmsNluk/JUbkFuGo4
	 6yD8IRaMLHEZw==
Date: Tue, 3 Nov 2026 12:09:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH] of: unittest: fix node leak in phandle remapping test
Message-ID: <20261103-light-vigilant-quail-e2b3dc@quoll>
References: <20261103104235.1373591-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104235.1373591-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:35 +0000, Wentao Liang wrote:
> of_unittest_parse_phandle_with_args_map() obtains a reference on the
> consumer node with of_find_node_by_path() and never releases it, not
> even on the normal exit path. The error path taken when one of the
> provider lookups fails also leaks the provider references acquired by
> the preceding iterations.
> 
> Drop both sets of references.
> 
> Fixes: 357aa4b61c82 ("of: unittest: Add phandle remapping test")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/unittest.c | 5 +++++
>  1 file changed, 5 insertions(+)
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




