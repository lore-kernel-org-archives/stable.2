Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561254707C;
	Sat, 26 Sep 2026 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790381917; cv=none; b=YC+mZ7/V9+B8XkDNOvTtGdvgyoCk8uWcH/AiGR12/RApodh1EAJOe/jEUXVqyTHS0TZVlz0cXQ7r6qLxGvYzG+6//izPb2owVHYt6TNnraTiLNUyIFpj7U3lE7pwPieQz4Rn2/TKsPFneIiur4/E85pEzyALezDJvZj7DjYQNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790381917; c=relaxed/simple;
	bh=XkEIyYuQqori9Ys/ZojB3WL+IG9HfzMMHagTC4plMuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+yP1x5io92x0VsX2n4P5qSkRoP05cCkyDY4l5cckAG1OwxQvjE2cRD0tvEL/hHehM4+kMdzbDUWed7UFqOpy1jBOmP2ERhpPBQpAbVwWKSucSesdM4Y9Foaaa1bBbi1esLppWtfTTi6TJEOtc+BTlnEkdNbocEM8udT1GXofTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLqiMhv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLqiMhv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F421F000FF;
	Sat, 26 Sep 2026 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790381915;
	bh=XkEIyYuQqori9Ys/ZojB3WL+IG9HfzMMHagTC4plMuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BLqiMhv/lZhFJ86ZPQr5hWV+0C1aOVVOLd2FZS278JVQ98eZKHBtMG2Pff872v3cy
	 VNt5mehfXJpO3lrUBmkxm1YEh9fibp2IE+RwkhzmVLQEu1j9VTO43GFGTfXqmjdZKp
	 YfQcsXT99jNIB2RU+JtvQesAT0OfbojI54xWOG9PMI1Y55iT7bfIunL1CM94E1mOZ+
	 g60gpzPmm3rp9XSU7D2UiVmhnjXfusnaZ9vtSfqJresp+Ccng2M/Lab1L8au3VKs21
	 lNpCk9amHjX+D6uCMsb/nOSC50K8fMn2+4csd1KnxEo19pE6xqI/bBY7aBJoU4IS5C
	 TVwSeDG6axO1Q==
Date: Fri, 25 Sep 2026 17:18:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, stable@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>, hybris <hybris@mojatatu.ai>
Subject: Re: [PATCH net] net/sched: cls_api: reclaim an empty proto on the
 error path
Message-ID: <20260925171834.73b5b367@kernel.org>
In-Reply-To: <QDISC-JCOT.v1.20260910090924@mojatatu.com>
References: <QDISC-JCOT.v1.20260910090924@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 04:32:49 -0400 Jamal Hadi Salim wrote:
> Tested-by: hybris <hybris@mojatatu.ai>

Please stop adding these tags, they tell us absolutely nothing.
