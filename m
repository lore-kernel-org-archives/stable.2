Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF71DA57;
	Tue, 11 Aug 2026 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406737; cv=none; b=poGqNpY6T0vVcUMapp8POx02Bk3gfKpvD42en22iDzRZ064otx664g/WXvaUMBV0vsBfKZhQMSM/iAzQBaqRSCcJgjXAihxQ/1i/WOrT5XeqP9415EAiO5PkgmUdyxGIPoCZxWvR7tikkrbIpVoZRpu9q+YHnMJopdnS9aO20ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406737; c=relaxed/simple;
	bh=mtlFkZXOgvlFgU20ul9QcWd0YromSwc9Rwo65qNo7QU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdtJgW7FoxhrDbw0jF3ZIHEvZSIqacU89ycwkovdrNek9PU3EYYeH+gxie75jeDzI4w3udu3hZMvrTk4gKWeAZ8Yk5CrEO8yatBn9vybxlG6SwhSlgvHLi/0NlW+YEJ/eGu19kNrDa7KZfF8iJMU8adoUNtGZw1Z4GLUK43dhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7IyNJol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7IyNJol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D4E1F000E9;
	Tue, 11 Aug 2026 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406735;
	bh=g1yQ1SxpkFUbcmiW/9+YKu69AfUhUSLNoY+6tBIS1VM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R7IyNJolQYBpL7XteNnjOz+ze5AXWRu9cXq6E9ZbVgl02SAJWd0RhGzwEDIgq/9MY
	 soRGWNDm5stgRN6YD9hgK9iTcRBhT9LjJg7hO5UvQ3B5g0mmT9U9BPxyiccc0fn/zQ
	 MdFNOXppxEfDNQQxOIrKmdCnkxGJrrznelFZ1ivzSyhuiawlbVj58y+QbICJTHADM+
	 7Oyy03XOEPSPnk+aUZ4oiKlklB8SsuLJZxhH5QNV4qqzSoIle82SK9x/gsQAJ7ZczU
	 aRy/fc/fg30JvrgZbDeJvgtckHCMbx0ZWcXu7lif0mACi0mvYjAFD8g9Sg00WIVAkT
	 GK5WVTeWLyOzA==
Date: Mon, 10 Aug 2026 17:05:33 -0700
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
Message-ID: <20260810170533.5bdc7f80@kernel.org>
In-Reply-To: <20260809094418.901607-1-jhs@mojatatu.com>
References: <20260809094418.901607-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Aug 2026 05:44:18 -0400 Jamal Hadi Salim wrote:
> cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> bpf_prog_get_type_dev() but never verified that a device-bound (offloaded)
> program's bound netdev matches the TC netdev the classifier is being
> attached to. This let a program loaded with prog_ifindex for device A be
> attached via cls_bpf + skip_sw to device B; deleting device A then
> destroyed the program's offload state while it was still attached to
> device B, triggering a netdevsim WARN (panic with panic_on_warn=1).

maybe netdevsim has a bug then. 

> Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> -EINVAL when a dev-bound program's bound device does not match the
> target device.
> 
> Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for specific device")

This commit in itself is fine, nfp checks that the offload matches:
https://elixir.bootlin.com/linux/v7.2-rc5/source/drivers/net/ethernet/netronome/nfp/bpf/offload.c#L579

Maybe the bound-devs got extended for JIT / descriptor access, and
that added some extra risk here. So either this is netdevsim-only
(and not worth the Fixes tag), or the Fixes tag is wrong..
