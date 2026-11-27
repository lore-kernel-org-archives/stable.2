Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771380;
	b=Fw4DAXtKTG+YxQ4AfSUW8rC6JF1bV5U1VoYi2weeq1AowZRouqJkZHiP6Jq+bslpxKWG
	 G9lOTTgyZcSwOJcWMfRmJgLaL6oIQOcykn5Z2J83dT2UtZF26uMiUsYnrFbZ+XmmfqCoG
	 sad4qVRUfUWKlUxI3DzDC819iBZ/by9yr4gR7BA+ihCq4V3ed0Khhczi99gO+HlDcNVaV
	 i5u9loENrJLjoNJkZdSLzVuqDGjaMM6Sgunb5IKhOWplTiw4K9Cr0qKk2JdmoFXCMDdJs
	 ELVaqWoiguWRQtOuzIMfndsbwtumihbtk7xkxUcx+sAW15PJ+VQ3itGSJPjCr32PEgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771380;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=UoPJk+lV9pL99wjFv+XO5yhawiiMq3pCuBhcEZKNMQ8=;
	b=C0JLUR5wUjwCpIh92u7ug53KTExKyCymdUCPNh/P1mpBz6QPAYtn6WrAfwVA5BERKREp
	 45lEcRCAPPQdot/KgmC+IviEfC8fBPCJsm6K8Hy012BAzoHajTV13XUwjKlNqJojOv420
	 z4V/L7M1tmWbF5kQsiIxBqAHx98rEb8KVNjh5uxHV0KZBIcB5e/vtK0T1ubl6I/PHMxYv
	 4wE8Vg3t0+Sb0fg/FQZTY9CAISsZy6URx28T5D4WfsWN6Xw86kgYW9lbRVBSMf+j9FuON
	 ainjFqOGeQ8MCKG3gyX28zp2CfumC/qx3k72qMF2Qul0DTs3JprTGOwmDEgiVUcJIyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=QCuIHpvi;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2D606A31C;
	Fri, 27 Nov 2026 09:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=QCuIHpvi
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 891CC207AC;
	Fri, 27 Nov 2026 10:22:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wqv8zZ9YF_LM; Fri, 27 Nov 2026 10:22:56 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 85B4B2088F;
	Fri, 27 Nov 2026 10:22:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 85B4B2088F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1795771376;
	bh=UoPJk+lV9pL99wjFv+XO5yhawiiMq3pCuBhcEZKNMQ8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QCuIHpvihSA2IAFS9IxNhdaGsiIuPm3E3uK3N2rtkY7RGJZF39VBjnLlx2YtpotOo
	 CbwX7yYfl+hCNe/0VqCdJ8bj1ABC9/xwWR2qofDNG6xJ1qllp/CtelvW1V4JOZYwsg
	 HxEEK5eU/n32xhTLaEI6vp9SRYU6xfqn3jfziQg9q8g92C1FyenaZBmpCUD9koKGat
	 f1jRAlulZvDAzugTp4U7uzGeBfleADWM7Nr0F6B7LqBP7MLOPw/35nv1Vdvw01gS6/
	 SSdRcC3ZeKI3sv1oA6lsW6xkC8c31gV8Uo5F51iNWX/4h6sJ5oFxDmYyRy18QU0NJ/
	 tZRM0cUvEfTgw==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 27 Nov
 2026 10:22:55 +0100
Received: (nullmailer pid 3466405 invoked by uid 1000);
	Fri, 27 Nov 2026 09:22:54 -0000
Date: Fri, 27 Nov 2026 10:22:54 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
	<willemb@google.com>, Simon Horman <horms@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, Martin
 KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eyal Birger <eyal.birger@gmail.com>, <ipsec@lists.linux.dev>,
	<bpf@vger.kernel.org>, <stable@vger.kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net] net: xfrm: interface: restore dst_orig on every xfrm
 interface
Message-ID: <awlL7kfqy6gksZlI@gauss4>
References: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Nov 20, 2026 at 09:08:56AM -0500, Jamal Hadi Salim wrote:
> Found while auditing the xfrm metadata consumers of a steered packet. One
> of them is an xfrm interface, which restores the original route before the
> xfrm lookup; the swap warned on the metadata dst still installed in the
> skb, and only the collect_md arm restored the route at all.
> 
> The issue:
> An xfrm interface takes the if_id and the underlying device either from its
> configuration or, in collect_md mode, from the xfrm metadata on the skb.
> When that metadata also carries the route the packet arrived through,
> xfrmi_xmit2() puts the route back on the skb, because the xfrm lookup takes
> the address family from it. skb_dst_set() expects the dst slot to be empty
> for a reference counted dst and warns when it is not, so the route landed
> over a metadata dst that was still there; a kernel built with
> CONFIG_DEBUG_NET=y panics on the first packet that takes this path when
> panic_on_warn is set.
> 
> Two more defects sit in the same place. An interface with a configured
> if_id never restores the route: it takes the metadata dst as it is, whose
> address family is AF_UNSPEC, so the lookup finds no policy and the packet
> is dropped as a link failure instead of being transformed. And the restore
> moved the route out of the metadata dst, which a clone of the skb shares,
> so the clone that reached the interface first left the original packet with
> nothing to restore.
> 
> The same slot overwrite is in the unstable helper a tc-bpf program uses to
> attach that metadata: bpf_skb_set_xfrm_info() records the route as dst_orig
> and installs a per-cpu metadata dst over it. The per-cpu dst is shared by
> every invocation of the program, so the restore cannot keep anything in it.
> 
> The Fix:
> Restore dst_orig in both arms of xfrmi_xmit2(), taking a reference with
> dst_clone() so the metadata dst keeps its own, and empty the counted slot
> with skb_dst_drop() before the route is installed. The helper allocates a
> metadata dst per skb instead of a per-cpu one, so the route it records
> belongs to that skb and is released with it; the per-cpu allocation is no
> longer used and goes away.
> 
> Conditions to recreate the bug:
> A tc-bpf program that records the route as dst_orig with
> bpf_skb_set_xfrm_info() is self-contained: the overwrite is in the helper,
> so the first packet that calls it panics inside bpf_skb_set_xfrm_info() on
> a CONFIG_DEBUG_NET=y build with panic_on_warn=1.
> 
> An interface with a configured if_id shows its own defect without any
> other patch: it drops the packet as a link failure without consulting the
> outbound policy. And a clone made after the metadata was attached consumes
> the route before the original packet arrives.
> 
> Fixes: 94151f5aa966 ("xfrm: interface: Add unstable helpers for setting/getting XFRM metadata from TC-BPF")
> Link: https://lore.kernel.org/netdev/DMZJS8O5A4YX.9T2P4DT0DAB7@gmail.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Aplied to the ipsec tree, thanks a lot Jamal!
