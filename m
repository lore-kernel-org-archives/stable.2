Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701598;
	b=Qj6BK8bpP6Ez6hoRDmVDOtx482mUfRXlqMoWqTiDQxiDGp0A6rV2U08SV3dJg0m/SB9M
	 uxtdoF4XAWM7fO7h1E1dJCIdfDAHVTUE7CohX6/2ZpBsr2oC6zK/IogTC+894/vUG/1+o
	 fB/8fdv7234qcCDlDX4AdO40JkZW29hMJl3frG8fdgb4I/R+OCBH1cmC8CXkiYZcOAJJ+
	 dYuMruoXwKncY4NzoFmV1DSa8rWYqeshVWMeJmR1ZiofyQ79EAhzfoy4wUlZ0nxEaiE5s
	 6ca830r8Lb657mK+qSSQdqbNaFctWc7E1FTfwn0TV3Xd0v7diALU9BM61EqfJ9qOwPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701598;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dbDCb73RToknYSAQMi1gN5mBalvvG3P1OdHm/ktqcfs=;
	b=TKGi5gF1y382pTmQdEoUfBdD/I1JFqxto1dKueArUC/zwY0OeObcxg2Qqzu2o2Aw2bkw
	 6yEoENIF1HkwjAGug7gWPLg/A9b+IhUdCpDPOdNIFR4oadx0/U7EaQtr2QyUDDAZVCktk
	 jSOoQk53/56kf6RKHRRIpEzLg+ODQ3jLSEr7zdSTY/mBij/oYoi06ITETW5PUm1ntWNjp
	 nw0NImhcRk3BMhJ9P+p9I2IyT5mVtexZGJvh6hw240PsZf6ZTQLZyJGvT37U9CpSWjIHj
	 fpNb/lIZSyWkaL7/bcF6PDR22Mck10pItNOxPnOblNO8z26oaq6e7P82P3HlNYtWJng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMsvWVtp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB61606F7C4;
	Tue,  3 Nov 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMsvWVtp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61921F00A02;
	Tue,  3 Nov 2026 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701598;
	bh=dbDCb73RToknYSAQMi1gN5mBalvvG3P1OdHm/ktqcfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nMsvWVtpyP+vCPLGp/KOKqkrNP8ynflaCpGgI45nZSjkrFoVuOB1BsB5lwUGQNuTo
	 qO+zfzZOjaNTicQEl3vsPvr8NPX25C60yDZDFf0x6bAhA7+YYR0TLOV1TloH+ZcxFR
	 0hAVQqYblZvx9F5V/fOVsOyL+IGDr9wX1bsvWgPjYRsq1F3ia7zJyVNWPgqQE1yiYH
	 bPfSSPKjvxb+dwW66vu9JRCHyRq0IT1BrcXF5nqfOpGBXepjkTE6xbukEP+iMG8NHp
	 0nlZdhOv5VTQY5oNGI0CSDHNUSybQxR7qStzfNznXDlUmKZOAAJ8HHsX4s1J8Bnw5+
	 1u/rTfqZufAOg==
Date: Tue, 3 Nov 2026 11:26:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	linux-kernel@vger.kernel.org, mfd@lists.linux.dev, stable@vger.kernel.org, 
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH RESEND] mfd: adp5520: Release the subdevices when the
 client is removed
Message-ID: <20261103-worthy-diamond-copperhead-c0340d@quoll>
References: <20261103094644.1289853-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094644.1289853-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:44 +0000, Wentao Liang wrote:
> adp5520_probe() registers up to four platform devices (keys, GPIO, LED
> and backlight) as children of the I2C client, but the driver no longer
> has a remove callback.  The callback was dropped when the driver was
> made explicitly non-modular, on the assumption that a built-in driver is
> never removed.  That assumption does not hold when the I2C adapter the
> client sits on goes away: the driver core still calls the driver's
> remove callback, and without one the child platform devices are never
> unregistered.  They stay registered, keep a reference on the I2C client
> device and leak the memory they were allocated from.
> 
> adp5520_remove_subdevs() already exists and is used by the probe error
> path, but it is not reachable on the removal path.  Add a remove
> callback that unregisters the subdevices and drops the interrupt, in the
> same order as the probe error path.
> 
> Fixes: 6b09274bacc7 ("mfd: adp5520: Make it explicitly non-modular")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/mfd/adp5520.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
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




