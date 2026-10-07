Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54637CD39
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394200; cv=none; b=epFgTklELek0rqcn8FpLdoImD3gE9PAm9abN0M50a3qflCEqAM3Hcg5gD99qgWSwlSbla9vrq/fzkeBSu+OgMil7TDkqMtWe+W++80y7l4+jNsX0bj5FTyYUcCOunWJGPKl8qBGcXa9KJ1j2OUdB0UQQS7cm4VZQ3TNrXs1t3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394200; c=relaxed/simple;
	bh=nxcEIJsP5P568+JqspaC5riVmJMyvmOUZ8MmoVK6k4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pH92Mlc/q4m19AolRavYPFbyibIpphuN5wuEM4sllcqoa945AGbDMJXW+kgyz4LqEHV6v4D9UO7lGpb/C4xcBAi652Rxe2kz1CdYrBJHY3wwJSRty4LAZddwgxjcd5M56ahC1fesa4+XcJ5uggxy5qYsLKh+pu0u0yYPl+hmhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=jELXcHWU; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="jELXcHWU"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-918df0c71e3so21759476d6.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394197; x=1791998997; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ulf4knBkH5u1TnqCidkxaqLV4+gGgnRz6zb0SQK2E4w=;
        b=jELXcHWUKU643dyRwTkXtJw+kClt4BKIxhjIEuFqqg3pqoXH9TBv0+9Y6Gke98T9vT
         UsEAxkvAmlJ46I6ywBuf8vU8Hbl/zlFTz9d0MKL6869grSzYxIxEtZR/wXPuL0CLhHeu
         j64hhAUjDVP3iqGpzv3BtMlIkE9RUhqQPMZxavMfP7ZEZS/e101snUYzfL9npTktOhkt
         5nw7IGUUcZ9+W4dGcM8QXtksaWsNUDCb1ZlWlb0i+FGMU6V/w8B28Leqv0zqUHMpBcAs
         zNhDhidDtwmfYrAxfI1+5i43sMZb3msLnWyT1ezsZxA5E3oL03ssttzL7E4ybFKByBYw
         77RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394197; x=1791998997;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ulf4knBkH5u1TnqCidkxaqLV4+gGgnRz6zb0SQK2E4w=;
        b=Fof2TuZ8L0n8OOfJZe/NrYXcJfJ/XFRw5WZXC7loR3R9+jsw2zIuA7DJ0fbGIgsZ+B
         4F61MHq5Vw8/2mRklEwZ5nj3jBymd6KawqetXki+7J4SfOO+DJ+xofV9iu93loC3dO0G
         U8GOihC9dwPeHy99JKz3i8+e17e4xKuXdG7eYEHsiBEiUV+xlAcghC+IxZSegYO0Irq3
         cvpYus8meUqoOlhRBIOJnYcr84+ynMgUjezNHydQ5MUr6CMzEpWeLnjGEm9aAxbf7R5A
         RNpaFARW0vtnbXUeRvRcMa+y5OF2yhKWjwNqsOIglundqh7b0tV89q2VD4owl/YnmdL4
         8Waw==
X-Forwarded-Encrypted: i=1; AKwUvBzvVW81+YZ47BlwCT4znSGZrUztwRAdplHn+Xl63/o81CfrSWkHMUSuJy9k6b5kL/gQly0oaB4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDdWe6ErVtUK7rwn0RnAS8WTVr+NwsxBwGsHyF2AAZXPXllnfR
	ZRcOAlHnnysFx/8QZjmkOdLhbfTCPbNEXydiOSSitCYMQ+78UKH81Fxk8su9XC+/6vDw/41FwZ1
	Ni5t9UYI=
X-Gm-Gg: AYBFou2tfqIInagTUUcf/nJet6gXfsJmjSDEodTizPpfusa0weE/RbejvYVNNc8E80d
	Pe9rveXKrltitrnMsQeLeH9ulWSLz80RPJ7fE5mQPL2cYMRkJM9jqCVBecEr2d0fNMTY6Mk1YpM
	yNwMD1j16GfszwI2eHtJRHbMri1MG4YCuo8BP0hJcfpY25mMvD+HnOQ6DE90IvbCbEwEMrcHuG/
	BCx25UG9/8T9arX6OvMNuwL7zJ0NADATci4WSZ4e4rN/Vr1VXHJzlqv72fKUEern1OyxYdhQGrw
	RU4AGdvxqqFH4c00JIPHV7+k8f+eRPyqCDspc1DDrm2bhTjAClvxXlChQ5MrF5/VPs50UY9bGBZ
	iOc6A/QbIwisjHqBu1zztycyAiPHNBRgiT/V0vtPxSbFsBERKTK6f0OjZez2xHcwhwo/xEcGFdX
	5uA6jGdBmlJyL82RT8XHjGvo5Ub2sAKgwZ5iFKNYJCwAXrKFWsy4AgXso9HPlWgjfsqJAdzSOtt
	79VTYORRVPM8Ac=
X-Received: by 2002:a05:6214:451d:b0:914:4129:92de with SMTP id 6a1803df08f44-919976b94acmr54775506d6.1.1791394196971;
        Wed, 07 Oct 2026 10:29:56 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996d0556fsm25727146d6.22.2026.10.07.10.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:29:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:29:34 +0000
Subject: [PATCH net] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIAH2BxmoC/3WNyw6CMBBFf4XM2gkPqzX+inHRqYNUsTSdYiSEf
 7fg2uU5uTl3BuHoWOBczBD57cQNPkO9K8B2xt8Z3S0zNFVzrKtKIymUJ6EdwoRWxhdKMj0jTYk
 FFbWadL1vDicLOREit+6z5S/gOcH1J2WkB9u0htcZGcmFaLztVtWHklS5yb9XsCxf9OZ47bwAA
 AA=
X-Change-ID: 20261007-b4-skb-copy-csum-stale-bytes-4bf7b713258c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394194; l=2000;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=nxcEIJsP5P568+JqspaC5riVmJMyvmOUZ8MmoVK6k4E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMRBnjw/ta2UpP2RDQp1kaRlRViFZAVb3ZvXE4JKuE81FPw9Fm+YTe89rAnJKPUv4QeMME4FEqF
 +mbfSHILnggE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
after copying only the linear part, and the rest of the caller's buffer
is left as it was.  The callers copy into a buffer that is about to go
out on the wire: an ICMP error quoting the offending packet, or a
driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
is zeroed beforehand, so whatever was in memory there gets sent.

Zero the part of the buffer we didn't fill.  The checksum usually
won't match the data any more, so the receiver will usually drop the
packet, but either way it no longer carries anything it shouldn't.
Only zero for a positive @len, a negative one from a broken caller must
not turn into a huge memset().

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
This was patch 1 of the skbuff BUG_ON() series; Willem asked for it to go
to net on its own:
https://lore.kernel.org/r/willemdebruijn.kernel.235bf1cecf85f@gmail.com

Tested on net with a module that marks a nonlinear skb unreadable: the
part of the buffer past the linear data is zeroed, and a negative @len
leaves the buffer alone.

Thanks,
Josef
---
 net/core/skbuff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4aea06d5167d..41beaf625421 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3633,8 +3633,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		pos	= copy;
 	}
 
-	if (!skb_frags_readable(skb))
+	if (!skb_frags_readable(skb)) {
+		/* Don't hand the caller a buffer with stale bytes in it. */
+		if (len > 0)
+			memset(to, 0, len);
 		return 0;
+	}
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;

---
base-commit: 23609bce9e1de525d1d0e73fc68c6e7971d0b49e
change-id: 20261007-b4-skb-copy-csum-stale-bytes-4bf7b713258c

