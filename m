Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248D04AF688
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384571; cv=none; b=RFlyu1z+Kiw/VOodaL7v41xpctu6bP9djJ2dUFDSjMNisSBMQGDFY36zIsU+Saeey1qcdM+V/QxPrGJwTrlBTItwipveq+Z+9xJk+DuRj5VUb9nEPK8OqXKLDLxpXaBgICz1MXhTPUUcpb9ngvgyxi2VwkfmyOqQ3k5tKdIgMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384571; c=relaxed/simple;
	bh=Rwpti7iQwDFikXIDN8JqQyuYZyRBY6WxLhROo8inQYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uk91He5sVz0J0eOZqjzJgMw4Uw+Kxv4oI8Di0ivEp/CsRsmhSn9Is0er/dcUlv1snoMqlsOJP7Y/ZoHUDD416A/4uA1QsPUrVGndudCetIxveb4o/CQiGnvAoSzcUG4P0GjEhrUVmVwrEVEq/3taeBkCgtl9xe/wL7eBEAz15aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YjWk6kLx; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="YjWk6kLx"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cc64570deso4486866d6.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788384560; x=1788989360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uHUCSjdJ+fy55MfodjzYcXnnlacL4uHKJaK4zHusjHE=;
        b=YjWk6kLxd5p4svlJmvF6ZriA1JFspj5OXM8xqXolUEIPIyX42q+SLKY/McsRNQgU0z
         FzG/pBj6/cq0s72oatma8H0XJkIH7NxPsZv1AETFJPw/lbcSPGwpf5HoJFaTZvOaLUol
         Q1ngRFA7i0IOIPorI5aa9UMz2xwRavccVUUb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384560; x=1788989360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uHUCSjdJ+fy55MfodjzYcXnnlacL4uHKJaK4zHusjHE=;
        b=ZNGs4BCRN5aTvgWlILRaUrSi99yXzAmpC7jeFeOyfJq5IvSEu93Iry5LSkExzWiu+O
         vRhbY9cvJlITD+zvR9NAPC+LG3Sn2bSDPttG8/XuvsW4B3S+ud1ZQl8GZQ5kF+23vetQ
         3iL4g6JofyKDMlF8Y9/gLtRl8YSDTKqdK+FAGPaFIs5fFwUvlhIS9oI0q12kEbdYNneX
         YpgdX35aN7nrD3Fbk+Dc1PHHb4+Hyic1vO1wOte7Mg7NrHfSyAVUcQuWGP5rL597sdUq
         aIMN+4KnP6hP8iBq7Vcjp5ik00QY3l+JABYMpFdinBA6H21H81v5Ythby7scWcVW395r
         /4EA==
X-Forwarded-Encrypted: i=1; AKwUvBw0GRX0XWdk1gkZN/LA3fblKVXyweeEBLdkDWrRdqFsV66rPxg6j0NIcaIVdPZ5kvs5goFrVII=@vger.kernel.org
X-Gm-Message-State: AFuF++neLRRrr0xA0NTWgRm1l3dSRCTbYH6M60o7uQBn02r+XlqWAscy
	E311AgpX4qqUHNYuhdwvhQsskEfIU81bdPFyc+LCMm3ZzIVVDP3OTUpjyFcHyK7mAA==
X-Gm-Gg: AYBFou3Dzmw0MdU4TiaYluF+QQm16M91mAkiIerZNUd/UiCuY9OU64j7TNmzBgaxGpx
	dW4S2l1iEi+cJ2UXXk28f8MvhLnwWN1+YtlUH8F5ozoRBAFs/Jl2qRytkLb08TDpbGb2P+nId5K
	RgvtYI32IFthHgAH7bA9oP0R+A9hirweFkvDK9JEalEmeSQ/pxkvXFA9Uf/DxJ8iBK9l5C7xSsv
	bbR4TC0QzxfaDmq7isTxNQbPofTwv3pzVwmwhQYBbiqDVF+D31fvipQ7Q3K2de3Af53J9IY7nNx
	2N1xhShrT77ZCHnx/ntA8/EqpoMa26wwyZKmdZ427vFJv0LHzxehrCW1B6mfofoYCTfVKV6xhBh
	t/o3Y45+BhR1W+waEHom1aDtGbdGqp0pr6fZHS+rEzrhwLONg+wXmQuWZc5rrm8DdqQPD9KkZCI
	XnTR6LSWF8nKaW1WNU5tSSBKCSfJ83P0FHz+CAmOQ2L7/WHGEc6b0mc9dD8Rpm1YIf0Z63s1Bhx
	8liN3HN1GDpg3S7QfnaWFKljUwMkeKF8RXn8Ic=
X-Received: by 2002:a05:6214:f2f:b0:90c:de0e:d741 with SMTP id 6a1803df08f44-9103476d3c5mr25060216d6.15.1788384555713;
        Wed, 02 Sep 2026 14:29:15 -0700 (PDT)
Received: from majuu.waya ([142.159.91.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm27169086d6.2.2026.09.02.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:29:15 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vega <vega@nebusec.ai>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 0/3] net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
Date: Wed,  2 Sep 2026 17:29:07 -0400
Message-ID: <QDISC-2899.v2.20260901233641@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260902212907.SarAMZD0WSkfjiNod3aUoZfxUv5N56McECcfcnO0hMg@z>

An unprivileged user (via unshare -Urn) can set a huge tx_queue_len
and exhaust global memory through ring allocations sized from it
(pfifo_fast skb_arrays, tun/tap ptr_rings).
The reproducer from vega@nebusec.ai set the following params for
illustration: txqlen of 500000 -> ~32 GiB/ring attempts, 1.6 GB tun,
~960 MB tap. Gets worse when you consider qdiscs like mq.

What we fix: every path an unprivileged user can use to install
an oversized tx_queue_len is rejected with -ERANGE before any ring is
allocated; per-ring memory is bounded at 256 KiB.

This is for you sashikos: What we deliberately _do not fix_
bound the NUMBER of rings. With the cap in place the worst case moves
from "one knob" to the aggregate of ring x queues x devices, example:

  ip link add v0 numtxqueues 4096 txqueuelen 32767 type veth
  tc qdisc add dev v0 root mq
    -> 4096 * 3 * 32767 * 8 = ~3.0 GiB (one command)
  50 tun devices x 256 queues x 32767 x 8 = ~3.1 GiB

Unfortunately tx_queue_len is a bit ambigious in meaning:
In some cases it means a ring size (which is pre-allocated, ex:
tun, tap, and pfifo_fast); a cap of 4096 seems reasonable here.
but in other cases it is used to indicate a queue limit ex:
the qdisc consumers that allocate nothing (pfifo/bfifo/gred/plug/sfb,
htb direct_qlen, qfq, teql). 32767 is a legitimate high-BDP queue
length, so we are going to keep that value.

Getting back to you sashikos, after this is merged and shows up
in net-next we will send followup patches as follows:
this series is not misread as "closes the OOM class"):

a) Per-site ring limits at six identified locations
    - pfifo_fast init/resize,
    - tun attach/resize,
    - tap minor/resize)

   if you can spot more in your review we will take care of those as well.

b) memcg accounting (GFP_KERNEL_ACCOUNT) for those ring
   allocations: contains a memcg-limited container's ring memory.
   Not GFP_KERNEL_ACCOUNT has no effect on the unshare attacker
   but will protect against containers  (memory.max in its cgroup)


Patches:
--------

  1/3 net: cap tx_queue_len at S16_MAX in netif_change_tx_queue_len()
      (netlink set, sysfs, SIOCSIFTXQLEN choke point)
  2/3 net: reject oversized tx_queue_len at netlink parse time
      (IFLA_TXQLEN policy: closes the create path + veth peer nest)
  3/3 selftests: tdc regression tests (netlink, sysfs, create paths)

Changes:
--------
v1 -> v2:
- new patch 2/3: close the device-creation path (Jakub Kicinski
  flagged that rtnl_create_link() bypasses the cap)
- rationale reworded: the 32767 ceiling citing NLA u32 range
  policy can express (s16 bounds), replacing the invalid virtio
  ring-depth claim
- rebuilt tdc coverage (sysfs path now tested; nondeterministic
  resize-rollback case dropped)

Sashiko v1 review links:
https://sashiko.dev/#/patchset/20260828121902.66837-1-jhs@mojatatu.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828121902.66837-1-jhs@mojatatu.com

v1: https://lore.kernel.org/netdev/20260828121902.66837-1-jhs@mojatatu.com/

Jamal Hadi Salim (3):
  net: cap tx_queue_len at S16_MAX to prevent oversized ring
    allocations
  net: reject oversized tx_queue_len at netlink parse time
  selftests: tc-testing: add tx_queue_len cap regression tests

 .../tc-testing/tc-tests/qdiscs/pfifo_fast.json | 209 +++++++++++++++++-
 net/core/dev.c                                 |   2 +-
 net/core/rtnetlink.c                           |   9 +-
 3 files changed, 211 insertions(+), 2 deletions(-)

-- 
2.43.0
