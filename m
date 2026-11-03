Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701568;
	b=NlgmRxDittllU1RLnbEbZejDOVuc3AkMbH0+jYqtD6NQfzfP3ynBzB3Gxco5D9WCckDg
	 kUvo5vib4jDCHwLWpyQwrchYxS+lAjY3WmIDOZ8Hs+ByeksijJjCUo3aOjMI/RHLcBMI2
	 cYlKDaj9czY8q+mgV+sRIlIzFlSOMfEl+5RmKKLH++LLjFMMDeirxfE3UyFua40CA+Wvb
	 7Zt1xshyIJMRYrPJQidySOchT8a21UbET8DZnUTrOVA/yKPRU6aM/mqFfUieGQd0Gi0x8
	 beStTpUXKSWZqlIbPxxC3H6cG/dRBwK2IYdGBFKkbEgzZOQIC4oj0kfRezcCSkO23Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701568;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZuF7fJYmTTru6AFzam/kZmRQYRbtMt5mtJ5Bhl2O7Ns=;
	b=xqqpZD0GCeNP0eb2A1bNqqCuH4ZBLfVuOkgqPD8EbarIScrFGzGeXkmZsW1NNL9mC8Zn
	 vTE5+nkIZfefK9J1T9uMNmBmms4njbglvCFfDxyRTXihjccV4mL1NweEefyqcSsLu3Kdq
	 WRGF+kROLYYCVqg0fNJMuVsPu7VZSf1sZ147oNB5Uv821+bJHOr/PefQ7ilmP/2B1EDSf
	 z15UQYZYUBhfeuAPVan1k1mfMa1p8lJ67XHBEN91Uq+CvbUMb6ikEOuxCzZxmYAljnSsM
	 /ZePICU1PTnirzA9vkjVWLkfXBHQR71ZIiCBRGLncC4SWNrinfPdz1STU3+S14cX27Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kr5GWY8B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3773606D837;
	Tue,  3 Nov 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kr5GWY8B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA4D1F000C1;
	Tue,  3 Nov 2026 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701567;
	bh=ZuF7fJYmTTru6AFzam/kZmRQYRbtMt5mtJ5Bhl2O7Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kr5GWY8B8k9A2Xlh6UV8JUw4/lNOHG5KFxHXewAh+SkTH5QgBoNDrB8KBI/ie6LK0
	 giaAY3iV9RjcMEkbFnr2p51A/K5476YCgnDARCKFQkdlM8FHMXygP39Rt3oZeduLYm
	 RILuMBXVjLAIxEMA82qC88imdvvxwC29yl3OCSXw2TNrIbhyS0HoSC9STa4BTLFkD8
	 Vibih8Xkv39rclW4dNAJvHNwOruq9rZFlRIlZ0Gb7Ora9bE8oTL/42Fk3VOitL2bNW
	 6njUttuBIbfU5lyY/qME+Xbjby2Q99tghrl2GwMDJsRyLosNKNC9IN8Z2zPMqOZU6Z
	 KYnVMV4Xx0Adw==
Date: Tue, 3 Nov 2026 11:26:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>, Elad Nachman <enachman@marvell.com>, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: prestera: release the ruleset in
 prestera_flower_prio_get
Message-ID: <20261103-fine-blond-donkey-b4cda2@quoll>
References: <20261103100532.1309990-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100532.1309990-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:32 +0000, Wentao Liang wrote:
> prestera_flower_prio_get() looks up the ruleset with
> prestera_acl_ruleset_lookup(), which increments its reference count,
> but returns without calling prestera_acl_ruleset_put().
> 
> The ruleset reference is leaked on every successful priority query.
> Release it after the priority range has been copied out.
> 
> Fixes: 44af95718fed ("net: prestera: manage matchall and flower priorities")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_flower.c | 2 ++
>  1 file changed, 2 insertions(+)
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




