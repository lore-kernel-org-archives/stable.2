Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03D3B14AC;
	Tue, 11 Aug 2026 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462584; cv=none; b=uecJQsOhBD53LpsYulVcPu/KXzSpfAIjMt8yByBN/CLqTG9YZnuMQPeaaRz5mqVl11zwil5rYtubGE18eAp0ClXufWJ8M3Q/BsR4l4q8MPgZzArtgfhRph8R4rH0zNVLm/Na/+hRAV+lC/1nWQWzRlKERLA8LPEWzysjVf7HQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462584; c=relaxed/simple;
	bh=Q59GzEDpoUHHGUe3D8E87c2jAss8RA5B+SzBokELg6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqQmorCBUtOZ7X8i1RgdXeAlgQSD29wVI5JFcs2Qp5Bh/8wmndlpQG1LE42+a6xN3MySBmxgVKXAtYwM0NmofAKsTFpXrOdzyDCGZScSyafRDIf33vpwXZmQoj1+km+WoIJgoEBTTle9FKjV1cM4AnuYtolkdb5J/1KLRftAXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idEyY47k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idEyY47k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550121F000E9;
	Tue, 11 Aug 2026 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462583;
	bh=ZaD5mcjYTOEV7Pf7GM1rrgaqlhDXUgVppAS/u+xge5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=idEyY47kbB8+5NOdh6T2DOCmE4GOLcAVFSkhDQxhaPKyqL5q5lsRMVIuA7hO1MOfj
	 7SM1TnvGU8chEzIFOrbZw95DLcaAERHJKcAL3VnHguUVwpe1z+3btj+99pNJQjUSZe
	 Rpr6GLfwyUSihRkfc7srA8JIt368ai9emZI1pFj5X6rKBeUepv5Hgad70+KCjWRDeB
	 cfwV2vGb3dZ6BzXNhlE+w6bMmJ/ERetEdwg/tOUj8vNML0Vxq2OM1Lz+WPdg6teCsG
	 W0q4ndh5uduZ6VHGJkbxf4v8PgdBsl5GGoDpitiICDUR/hxlFNtmTK5mQiLcSvfz4h
	 XxQX+PR/N+bfQ==
Date: Tue, 11 Aug 2026 08:36:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, Victor
 Nogueira <victor@mojatatu.com>, Quentin Monnet <qmo@kernel.org>, Simon
 Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
Message-ID: <20260811083621.085021c9@kernel.org>
In-Reply-To: <CAM0EoMke_qk2jJdWW0rHvZcwMNd7RCG4xGkpNYZpPtrSKg2Q3A@mail.gmail.com>
References: <20260809094418.901607-1-jhs@mojatatu.com>
	<20260810170533.5bdc7f80@kernel.org>
	<CAM0EoMke_qk2jJdWW0rHvZcwMNd7RCG4xGkpNYZpPtrSKg2Q3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 07:35:41 -0400 Jamal Hadi Salim wrote:
> It seems a v2 may be worth it:
> fix netdevsim's cls_bpf path (Fixes: 2b3486bc2d23), keep the core
> check as defense-in-depth without the bogus Fixes:, and walk
> block->ports for shared blocks (block->q is NULL there). Or drop the
> core change and fix only netdevsim. What says you?

Pls post the right Fixes tag in this thread (without wrapping etc)
my scripts will pick that up when applying.

re: blocks - don't care, those are a switch ACL feature to me.
for BPF offload - the offload mechanism itself already works
at the device level, so the program can be loaded once and then
bound to multiple ports. Or at least that's what I _think_ I did 
cause NFP wouldn't have enough program storage for all the ports 
it had :)
