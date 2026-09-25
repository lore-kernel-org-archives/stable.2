Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F9442373
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370818; cv=none; b=R5iaEvN43olg003VP4mfpBEw/VYDZWQB+CqXWT64IOQ8RFNEo9BIrEuK9kLtj3Rx6xgAYuQvIpBun4tswpSK9yJZSNDNIjEP0KYwgWZ38BwB21Ko8ErwDXi8/a3/MAl717RjPU20v6YZ8G01tC1D3J9AQvg9frcLgl0iBJxxKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370818; c=relaxed/simple;
	bh=l2U8nzCNNQ/nwq4FEs6iLspFROyaC5q68fQmREhjkjI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=F+CkM9gvdXfawdDMb3ziTRYkUGSXyXErgT+4AJ5YWlMHMaELgKv89lkNa+Ilr6eNo9h8IqyzzznG8k1YCeXp1lhNDz6Z4AKV8bZgjw3K4Y6BolYORt5JVfZR3JAZbuYRdiSuutrl5ZsddNpULajZylSDbpwITc0tZNHfwrEpQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cisRoBq6; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cisRoBq6"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505824so11727897b3.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370814; x=1790975614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kE6Ci4ey9edySdwisM07uhodEQlZii4EnlJAnWzc9lU=;
        b=cisRoBq6/2Mq0XJdC1G9mBuK3ldnHNb9jKiaWs+33Rc9Ql4AWqtx8FuaMW4DlLSGKn
         aNzRW3Xr4Nb8tqUVTXnM29fbRf8rJhalyTQFeKez/3pF7KcvrqDZZ81KO07NatMbCHkm
         EeFPv3cZhomWMAftMZKLlhqGRuFKwPJdCTFWycrSnHHoPbyb0y6ug1YqTFWpEDKaaxji
         OIV/gPPS62wKm5YMYAdAEifz54ulE0iXwi7cfD1OzGQ8GhC0NWZT7U5wyHWs3CFc3SVw
         xu+EClqcAwz4x2xM247cg35WNjGDaj+q9D1CnllGILL//ReivfxRRk1EZjoPzyDRyYU9
         tWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370814; x=1790975614;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kE6Ci4ey9edySdwisM07uhodEQlZii4EnlJAnWzc9lU=;
        b=vP9PqktJzl18mBGjcKaelJCbDzvybi+zXYVO5q7VoW8I+HBBte/lsQy/eWKE05dNY+
         oMWKjUlecHTd7iOeXK+JCpxVj79WkzTFIxFipA4btEoafiT5OtJsUyIkh7OoHDpG4PgT
         JDt/eT/0jsLnMs0vwssKctIEexSSRFKAj6Za9MNY6IW1sm6WzIZRCFcAEV9g4AeBv74B
         GIbVnsIHC8J4pf0OUceEy5JEViZIL6+tLdrj2QX9cFN16HqKlOnYrq9gejmflSjJwhlT
         WFr1+gFcpnP+gUDKjzfL1qo0M8tTRUVsemeP88a5WO98SM+hdLcSc5tK/+HJ7n0tR2tb
         yXHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhcILftnMOfuKik8pkAJ+2QAfkrF1ZDdMs4akyGd731E1yUkj3JfSwIM5jEpX0ihk5Xl7WgeM=@vger.kernel.org
X-Gm-Message-State: AFuF++m6qo+L5GPxfVo16gXhyrbqBm0ThCl9GOo++6GC7hRPh0aBrbik
	00a7mtFudWgoDtuIRpdZUEqr1HUNWnntApkSJu5ljU82ztg9kkqfGCh5
X-Gm-Gg: AYBFou2caUIhD0wzDoj93gMAJ9VxseMwZ4Hw52DOoWgFvfemuhiDsUiQzSyjJ73s7LO
	XAxRA3+lG0CJwnoKJvU33sDrCgh7pBxCiWsPi+Gx1i1OSU5F8KUNyCOE4GV7o8vAcAVwH5hqgGu
	p75SuyK1Iwj1o0Byn8JBqr/jm0D/rHWQ8W2LOXwH1mXG9JfI0ngp1ZRGuWkObg/hou7LZ4z2tA7
	Y3sDUgxWHX0wOXAEmyfimPcebCiUWrDf4iVOWb6a4OzKUmp9TLG3avnTxGnq6XF3mZBUs/vK+Kh
	6vm8j9Wf6/VMzhyfrU2up8RW4H8Q1F+jfawbXCTrSoqMQBqJzuqCGshh1tR4T05BxBciQBNYNIe
	feAOrIcDskZ1qBFYkZB+EOddSyzDOsVH7QYwwz9nNfuB50eaix0H7gCtAZTEkP9lgcdGDhwje49
	O8FogQUB01OL2WrWubGYRechUu2PIG9vLU7wpw67IVnhz1NEUkBPMYiFo1pgOD38cHjc2dgPPzN
	NlpTarB5QsnIu/4G8KcWq9m7tq4vB9/21E4vY4l2hztmWUHzGZWnbjMzxaBI+my
X-Received: by 2002:a05:690c:19:b0:8a5:1570:a298 with SMTP id 00721157ae682-8a64ded27c7mr30052657b3.50.1790370814571;
        Fri, 25 Sep 2026 14:13:34 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860fe88d6sm13938657b3.31.2026.09.25.14.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:33 -0700 (PDT)
Date: Fri, 25 Sep 2026 17:13:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 dsahern@kernel.org, 
 idosch@nvidia.com, 
 kuniyu@google.com, 
 willemb@google.com, 
 kees@kernel.org, 
 richardbgobert@gmail.com, 
 zihanx@nebusec.ai, 
 stable@vger.kernel.org, 
 Vega <vega@nebusec.ai>, 
 Luxing Yin <root@tr0jan.top>
Message-ID: <willemdebruijn.kernel.21eac4268187e@gmail.com>
In-Reply-To: <20260924051521.32568-2-zihanx@nebusec.ai>
References: <20260924051521.32568-1-zihanx@nebusec.ai>
 <20260924051521.32568-2-zihanx@nebusec.ai>
Subject: Re: [PATCH net v6 1/1] net: gso: limit recursive IP-in-IP
 segmentation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zihan Xi wrote:
> IP-in-IP GSO can re-enter inet_gso_segment() or ipv6_gso_segment()
> for each nested IP header. encap_level tracks header bytes, not callback
> depth, so a deep chain can exhaust the kernel stack. Making
> inet_gso_segment() stackable introduced unbounded IPv4 nesting; IPIP
> GSO/TSO later made the path reachable. The IPv6 stackable path was
> introduced separately and uses the same guard.
> 
> Count IPv4 and IPv6 GSO handler entries in skb_gso_cb, initialized once
> per top-level GSO operation and preserved across GRE/UDP context changes.
> Use the existing IP_TUNNEL_RECURSION_LIMIT for both handlers. The first
> five entries pass, and the sixth returns -EINVAL before dispatching
> another GSO callback.
> 
> Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Closes: https://lore.kernel.org/all/cover.1790157745.git.zihanx@nebusec.ai/
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Reviewed-by: Willem de Bruijn <willemb@google.com>
