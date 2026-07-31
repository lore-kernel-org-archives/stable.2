Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C71A9B58
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503930; cv=pass; b=Eww5rWTiUOQT8wHneLJIfjjgR77NQYODgEwJJgXYwYVo0jZF88akbBEYab4nrsrcXmK4JWGF4RV5pH4Ivpr3SNP2gYrVNewKUk4wPVJkGxpDNhzD0BRJRK+w/MefwscgSJRWstuDCSlo4xrIpdohyh7TN/nBd/7bNj1nC+C1yKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503930; c=relaxed/simple;
	bh=No1LZO0/xWGQaiEAYrYAljUhDkAED+OYsMfKkFdGXmA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LbuSQnfy3nMiHwnK3evd6bR43IwYpY8Crvsc+nwYLXVzRhCJUm7BRl36a7EWT+y1ia6/VcIP2PJmxlv24wd0Gv8IOAy4BXo5idOpVaQYNcUZioYTbpCBB01rmYVC7wTzymBG+b/tVkiHZ+13rsZlPMLf0iS80AVkQBOgTP8Tne0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4PeFN3U; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4PeFN3U"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4a483a552efso376488b6e.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 06:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785503928; cv=none;
        d=google.com; s=arc-20260327;
        b=W/33Gh9poydrA9rJWZM4fTixmGE0gkRf/ER4Ra80CHE5UDAHgvJZ0upIsjfjvyXIOp
         UjwLN7Lw+srVn1e3BB16BGsxp6rgX/Ztk8eOd6HrFC5DgMvvA+ShHfLtnvAVrwUsFM/M
         6QKr9wX94dPVVEMYI2P/YPVAhdnr4YjCXvkHA1qZKN8QdI/X8LCaBRT4S9kAtit4nSdL
         7Xjh46gEf19y4gqIkzdkqB3XnJn2UtcBX7DOGr2t+ibenNyCb+Mad0/jnQ/QW9VMUAie
         Yuu4nHjzSbiN2c36R5Cz2HFcx/4+YnYvKsnXxJXt4+33aSAhtuR03SjeZF44lvdOrCwo
         OACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=No1LZO0/xWGQaiEAYrYAljUhDkAED+OYsMfKkFdGXmA=;
        fh=A+SI1AbTOvT3VVFLHs6qrZdtNrZj/yGCAZisBl/9nBA=;
        b=rSOblFalZ2CmWl5p9IDaLYgSFxDTrmROVWnCC3fyLz8lSEP7kyBacbXXHUJoYumFIW
         0SxsLNBUAZd8GrVhq4Sz81sMx5blg/jepCRBnsnqrOS2UhEHEpQoXocKnqPJxp6izTMy
         nAy6EmeVs2wA6dBJcS/w17+cQUUBwko1Pk9tbDvTrLJOJuGZg2xyJ2b253JgWFWabgR5
         kXyzxC0LHCN94yZNNeijFIfZxv/g2kW4B9plEwQ8qYKdLM9NyEZDKBFy52mBoCmc3Tlc
         8m71gvqs07uomFsXWdqm3juAn46h0Zi1+nfCBZcYb6ftQxdePXO90B6X6WQBoemDDYcA
         U/rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785503928; x=1786108728; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=No1LZO0/xWGQaiEAYrYAljUhDkAED+OYsMfKkFdGXmA=;
        b=T4PeFN3U8XGk+G6x6+kAwMDU699o2JTjbnCvFXlcaY9Fn95z40SiCJvRvpJlouSg1T
         WfOUkEplNnhaNUNeufRXwA21DyoNOm/mhmV/co3YGK72OJ7AxAb7G4zSTx9dSC27msT/
         ZUKiqq1G2ZVGv8SwE6klMYvhCweCM1TiXJvjqntsiz2GAPetB/So0PBYn8QADp2fMi1w
         jh6XTHLJoqs/wTm1OoQhCGzDZ27mWAl3xZngFAWZixovpEpWTVX59lpmKfKU7KCex/lb
         utAm3j7fxRJYI2OY43mqfQmf+wCQjL3n79oEnkViJpVw395pMyGpTVT2h04LQiq5J5yW
         RYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785503928; x=1786108728;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=No1LZO0/xWGQaiEAYrYAljUhDkAED+OYsMfKkFdGXmA=;
        b=omwa6g3Pp849hQ5FF4G+bOKOIaQIira+oUvh50hY4+jkar41gCiKb/+3zZTDOhTsxH
         oG2Aamp93A8ACtbZDbVC/dmeyQ/yrgAnLYAlUa0wSduya6IaaQJwj9ptxYk47VJ3ktwQ
         uR6C8pZUxjFCYUrHL//0iJTlXhU3XBUN8Es2VaRxgo3WL+x0scP3mAX3Glf8zqCYJp78
         rHdKe3PbSvAJZNNjwdP77JRv48HqfE0D5MHAihfViXf28D28h7eRYHB6N0ZyhNClYP4q
         G0ubJaaa9vqqQUqwIyb7LaLwaNf8rws3iKwU1RnYJbYO9apw9tO1Joc/hB5Df+MsPlQZ
         poxw==
X-Gm-Message-State: AOJu0YzVIWtid+e8BrND3NZbA3Y8f5+6tEGinKacoCxmj1INwQK4k50A
	q/8teETiEY56gM4D7LapFXu42YDO3nHEriWQBvaV3WSzMh27kQ9hrxdbw2rP+9xh2g85iIgBtqi
	IxCpuFCdu5lyxU3y63M7bFbtgwZrVM1qVl8Do
X-Gm-Gg: AR+sD13F09wVf9bNF9jAlnS1lUitJ+0YiGp1i71Vd+v8cXJ0AjlkrKK8mXgqNdixae6
	tbImjVlwzZYyYH5NdUwczpQtUNjxugugBStkNbnErGeUVnYfmFiFWzf83+KBmUpG+eqPDOFqkXj
	xajDeZRLp+5N1Yd1yUt5pBLHqWik5johjU7KuJZYRgv60xbUhsQ3VTdQY5CSnUynBn2ezWid3zh
	4blk8gPifwoJC4kvoSezBk3BVVzTGnOf7/BJpUePEEYL8lM/xlWIJL5MSXabbUukyYeuBJoyU2Q
	hDp4n5Kbv5rS4wCSInrDYP0XoHKhFENMI25Af+j1IbB7h7c/v6o6gUM1Wt98lWlz3DloUrOUZ/u
	y4/IQAAy1AO4Ydnm2wJCGEmnG1FDcsBPcRDFwSyyvyEBkLskE+m3kAXgSL3JhXyE3NTJ3Da0=
X-Received: by 2002:a05:6808:178b:b0:496:fd2:94e8 with SMTP id
 5614622812f47-4ae4c51dc85mr2301495b6e.12.1785503928007; Fri, 31 Jul 2026
 06:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Smit Patel <smit5292@gmail.com>
Date: Fri, 31 Jul 2026 09:18:37 -0400
X-Gm-Features: AUfX_mwbt9cTvAsQbxrtWkq9sJY0s-Cbx0ff8_-RCd2WxaW8Zp4iRgH_w3ybUrc
Message-ID: <CAM5kW9DyDSJz+W70HhzQL4TeY28GTcOxDvkPHnFBh7TotqiEVg@mail.gmail.com>
Subject: [stable request] Backport b2870fc21601 to 6.1.y, 6.6.y, 6.12.y, 6.18.y
To: stable@vger.kernel.org
Cc: lorenzo@kernel.org, idosch@nvidia.com, pablo@netfilter.org, fw@strlen.de, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please consider picking up the following mainline commit for the stable
trees listed below:

commit b2870fc21601db9133bc70c48c603b487614fa3b
"netfilter: br_netfilter: Reallocate headroom if necessary in neigh_hh_bridge()"
Author: Lorenzo Bianconi <lorenzo@kernel.org>, 2026-05-14
Fixes: e179e6322ac33 ("netfilter: bridge-netfilter: Fix MAC header
handling with IP DNAT")

Requested trees: 6.1.y, 6.6.y, 6.12.y, 6.18.y

neigh_hh_bridge() copies the aligned L2 header to
skb->data - HH_DATA_ALIGN(ETH_HLEN), i.e. skb->data - 16, without
checking that the skb has that much headroom. build_skb()-based receive
paths leave skb->data only ETH_HLEN above skb->head, so the 8-byte copy
starts two bytes below skb->head on every bridged packet that reaches
the DNAT neighbour fast path - an oops or silent corruption of the
adjacent page, depending on where the buffer falls.

The commit carries a Fixes: tag but no Cc: stable, so it was never
queued. It is in mainline from v7.1 onwards. I have verified it is
present in 7.1.y and absent from 6.18.y, 6.12.y, 6.6.y and 6.1.y, so
backporting to the trees above does not leave a gap for users moving to
a newer series.

This is not a theoretical concern. In addition to the report in the
commit message (Airoha AN7581, 6.12.57), I hit it independently on
unrelated hardware: a FriendlyElec NanoPi R76S (Rockchip RK3576, arm64)
running 6.1.141 with Realtek's out-of-tree r8125 driver, which as of
9.016.01 uses a page-reuse build_skb() receive path. With br_netfilter
loaded, bridge-nf-call-iptables=1 and NAT reflection rules able to match
bridged traffic, the machine took 7 unclean reboots in 2.5 hours, with
uptimes of 59, 3, 89, 22, 2, 27 and 4 minutes.

Excerpt from the ramoops dump; the full dump is available on request:

Unable to handle kernel write to read-only memory at virtual address
ffff0000c213fffe
ESR = 0x000000009600004f
FSC = 0x0f: level 3 permission fault
Internal error: Oops: 000000009600004f [#1] SMP
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G O 6.1.141 #1
Hardware name: FriendlyElec NanoPi R76S (DT)
pc : br_nf_pre_routing_finish_bridge+0xd0/0x270 [br_netfilter]
x2 : ffff0000c214000e x1 : 0000000000000000 x0 : ffff0000cf600000
Call trace:
br_nf_pre_routing_finish_bridge+0xd0/0x270 [br_netfilter]
br_nf_hook_thresh+0x124/0x140 [br_netfilter]
br_nf_pre_routing_finish+0x180/0x490 [br_netfilter]
br_nf_pre_routing+0x1d0/0x484 [br_netfilter]
br_handle_frame+0x270/0x42c [bridge]
__netif_receive_skb_core.constprop.0+0x274/0xed4
__netif_receive_skb_one_core+0x40/0x84
__netif_receive_skb+0x1c/0x6c
process_backlog+0xcc/0x190
__napi_poll+0x3c/0x1e0
net_rx_action+0x350/0x3e0
handle_softirqs+0x110/0x2f0

x2 is skb->data, 14 bytes above the page at ffff0000c2140000, and the
faulting address ffff0000c213fffe is exactly x2 - 0x10: 14 bytes of
headroom where 16 are required. Keeping br_netfilter unloaded has kept
the machine stable since - 15 hours and counting, against a pre-fix
maximum of 89 minutes.

These branches are where the affected configuration lives: OpenWrt 24.10
builds 6.6, current OpenWrt carries 6.12 and 6.18, and vendor BSPs are
commonly on 6.1.

The patch applies cleanly to all four requested trees (verified with
both git apply and patch -F0). It does not apply to 5.15.y, which would
need an adjusted patch; I am not requesting that here.

Happy to test the resulting queue on the R76S.

Disclosure per Documentation/process/generated-content.rst: the upstream
branch survey and the apply-testing above were carried out with AI
assistance. The hardware, the crash, the ramoops dumps and the
workaround testing are my own.

Assisted-by: Claude Code:claude-opus-5

Thanks,
Smit
