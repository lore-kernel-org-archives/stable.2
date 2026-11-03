Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704201;
	b=pJZet7UWED331yQhd+TGBn+izR+WF3ZYjqViEi1AP/kSjnOMoLPs4HWV3Xg37GLjqUtI
	 vCbkluPWn7+McK81PP/VkUfdFmbI+4ChhYDicZ4N05VVO9bSefVSjFIk6aQkq7cS2ea0S
	 hyZ1U8OPvxhVSrHREA0ka2KhXt9Vz4LZkf7ZFowxa1lK/nzMCn3g62oqQ263aygrzlqqP
	 8TH3GrM6kwdjLoUnNalq5sOKG35uaSRbCHVdEpKVFrCf0nEVFrGBp0QmiHqM1fqhtgEBP
	 IS3+au9apWWSajpJd+NVu9cIPgVBhr/UpygvjKYUXc2h4hidV0PUWUcK66dTG0+gpHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704201;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V/64MdRHZYG+iHL/40CVZGl5w1WrDMY6/UJ84tc9K8g=;
	b=zru2MCE2RbsWpUfr1WLbm+Jlir3kbtjzN5kRc/nfGDL6cKtzYMQqJ0Lf1/Rxe1R2sEy0
	 QRZBIfmc26h1kpDGAda+pl6EoFEFmJO8NDAjTb5nKz2rq4ZeBI2s/xxboD8A/smwEbODU
	 iJDzoL/1HwMo5XnwNv+hc3RQPg70wev4gzkN6ekUXT7WxV9ppF82ShmcKj5hX0jmOCJqa
	 aTyazqgptmB+R9hMPqfllLGN55m0yr3q9+ToTb1eGSpUQRTIjl4CRU90LM76CyHMvoCbw
	 4/q1Pl0TzGIe1vfqCtLjUOJCJMnmunKg+SHt7LBprbqMqUnVVVWejGh0oqy/0XTpxEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnPguzxM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB6606B136;
	Tue,  3 Nov 2026 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnPguzxM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03831F000C1;
	Tue,  3 Nov 2026 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704200;
	bh=V/64MdRHZYG+iHL/40CVZGl5w1WrDMY6/UJ84tc9K8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UnPguzxMJUuTI2Jr6+FKCxLBTZKnittQmHrd5lqF5I1Lxt9Fs4Otg2F1H7pCIU401
	 T/cBva3JdP99fBXNBrKfJigcUGaAWmio/DoREr4rK25mwCLmQE2heYAkWRxiIHYWAv
	 3k8RBuGAx3Gxd2WcWd8ll4/kipqobTdGNIaCP7fPgCEWp7+faO3pf5xGWhXS+NSG6c
	 BVtt4UfPKSXhHAvWm7Fh9yKv4/Sj1P6xwaN3ilP4mUzFXLilw+7xQ0gvb2zCDc/uaQ
	 tLaqK0NQqxYGvsSj+Ok8+KqRrr8j9tWm0wHLc2S2RRFxAgZB3RhIZevkEpT9VmVkEx
	 C1ih6hyf869Zw==
Date: Tue, 3 Nov 2026 12:09:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, stable@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: unittest: fix node reference leak in of_notify()
Message-ID: <20261103-jolly-skua-of-perception-dac423@quoll>
References: <20261103104236.1373612-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104236.1373612-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:36 +0000, Wentao Liang wrote:
> of_notify() takes a reference on the overlay node passed to the
> notifier, but drops it only for the unexpected action. Every regular
> action returns with the reference still held, which keeps the overlay
> node alive after the changeset has been removed and its memory freed.
> 
> Move the release out of the default branch so that it is performed on
> all paths.
> 
> Fixes: 992b0dc5c38a ("of: overlay: unittest: add tests for overlay notifiers")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/unittest.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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




