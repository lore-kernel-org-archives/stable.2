Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7244B69C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625279; cv=none; b=QU7oCxkt6KLPT2LektsMECrTDvOBggIXwHazLszKZ0R1bCi2C8iwt3uWgAgCGmUQwuPfVps4/ki9vjMkVvd3NeKFVrvWjQQunvmtqzrN0G89MhtqgY1Orqyc6UWFktdG8kRwojgg0Wq7TeIf3e6CiORQuhTNmRSF8Mc7p2iQgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625279; c=relaxed/simple;
	bh=5JmqYyyDgfSsRHDcl3vEhpb+/drglzI6uSvLi75HpDQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dCWDpdHpmpMr0rjB5aFnhkD5HMvJx6m02qwt9hi5w1kDFHwbVmESnmfLRg1miXVSUJeGxkJrky4tYzRjMnK0CMUUICuqS632XU0sSpJVrqdClUeKspZhY8MVd/sp26p0X1/nwqyi50+19G60rkrN5oYjtvLZG0UvoN4ZqTcbNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UprWIPNW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UprWIPNW"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c32faa62so71166205ad.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781625277; x=1782230077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CpRE23cHJ0y0nfaZ3/X5+DJK5VWJlzAlu8U0CJNFoNo=;
        b=UprWIPNWtNcAR+SWXCTsP+Rx5DH0e0Im5lCb2qnicNBWkz4e9MwFc47RvsxosFkc7F
         ONArQPh2F7zKP0GvHlHdXTgKkSf7aGteDl/9OvjxjWcer/X/g36QkPsNUmcV9ByPUm+z
         FNUevvz/g3udxf7A9Wg7ssvkzSL21Cq/bD5I+M5uUM3iwxJn5t6lRlyn1Dzf1FQ/XJ++
         9qbSojmXYdUotFfI+2BpvMdUEsipC+FTqBpjS5vRi3T9ndrNP6dnEmc5kuMD52CeTtho
         d9gi8fJcCPoK/9E/ckOc9HYR0GSumssbKEjrNibdLjA+RDgIHGDF/EPMf5NXQyz6XCsG
         JZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625277; x=1782230077;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpRE23cHJ0y0nfaZ3/X5+DJK5VWJlzAlu8U0CJNFoNo=;
        b=qBmKr8yYTEmEHoUP2Hv0lbFx5sZSZRpdDQOAvrt75foQ6HLVMRy6jbfYyM6eI3nPmT
         7zEQoxLW2eV8gYqFrmhxLkV/Yj+S7lVVYK5QOT9AYAccTDe3a1LyIhhIwzcmH69pCMCF
         aHAb5UJUF4rBrSARgSZystZSQsW/Mniysm6va84kIyEhciTHThRdMKr9NRkxDjigik9g
         fmH+psOIYmDLPoJB0cLQQLTM+44AJUXoGU5+O9miXDkB99h5HlqF7r5ZUDm/0M5vXnXz
         cZhbe6x+1LBz8IPvsOdXzHHqW0qQPVrtE2fbw+l5U3oKSBd3kUgW3nCoQATPol5N5NDq
         Q9Gw==
X-Gm-Message-State: AOJu0YzpZ7A0XdMElhMuYDKjnhR8ldV3bqcQb0Na5RyojdjZNu3e7OsA
	Gyw2TO1AHk49fAf6ZpsAwIO2RNgmR7MbcboUVZ6voV1XQ2sbDCFD9gFD7gjL5z4pkxc89bzxJP2
	PSTrGwXaheD0tkgtjts5DfM1SKy4k/i+oG2ZlbWhh7ZiGL9aK99BfR6/nV3NPiDcrZ1yyyW+7O2
	aNWBObDyB5CGXPNZGQIi/g8cQaj0CiCil38DfiIFwnQA==
X-Received: from plpv10.prod.google.com ([2002:a17:902:9a0a:b0:2bf:224f:daf])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2acb:b0:2c6:8eeb:a7c5
 with SMTP id d9443c01a7336-2c68eeba895mr98039995ad.34.1781625277099; Tue, 16
 Jun 2026 08:54:37 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:54:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616155432.2093908-1-kpberry@google.com>
Subject: [PATCH 6.12 0/7] net: bonding: Apply several bug fixes
From: Kevin Berry <kpberry@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bestswngs@gmail.com, chenglongtang@google.com, 
	joneslee@google.com, kpberry@google.com, pabeni@redhat.com, rnj@google.com, 
	sashal@kernel.org, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"

This series applies three bug fixes:

2884bf72fb8f ("net: bonding: fix use-after-free in bond_xmit_broadcast()")
c4f050ce06c5 ("bonding: 3ad: implement proper RCU rules for port->aggregator")
067bf016e99a ("bonding: fix NULL pointer dereference in actor_port_prio setting")

These have already been applied to the 6.1 and 6.6 stable trees, but
the data race fix c4f050ce06c5 ("bonding: 3ad: implement proper RCU
rules for port->aggregator") was omitted for 6.12 because it has a
dependency which conflicts with the version of 2884bf72fb8f ("net:
bonding: fix use-after-free in bond_xmit_broadcast()") that was applied
to 6.12. This series reverts the conflicting version of the UAF fix,
applies the required series for c4f050ce06c5, and then applies the
simpler, original version of the UAF fix that was applied to the
other stable trees.

It is also necessary to take 067bf016e99a ("bonding: fix NULL pointer
dereference in actor_port_prio setting") since it fixes a bug introduced
in 6b6dc81ee7e8 ("bonding: add support for per-port LACP actor
priority"), one of the stable deps of c4f050ce06c5 ("bonding: 3ad:
implement proper RCU rules for port->aggregator").

Tested by compiling.

Eric Dumazet (1):
  bonding: 3ad: implement proper RCU rules for port->aggregator

Hangbin Liu (3):
  bonding: add support for per-port LACP actor priority
  bonding: print churn state via netlink
  bonding: fix NULL pointer dereference in actor_port_prio setting

Kevin Berry (1):
  Revert "net: bonding: fix use-after-free in bond_xmit_broadcast()"

Tonghao Zhang (1):
  net: bonding: add broadcast_neighbor option for 802.3ad

Xiang Mei (1):
  net: bonding: fix use-after-free in bond_xmit_broadcast()

 Documentation/networking/bonding.rst   |  15 ++++
 drivers/net/bonding/bond_3ad.c         | 113 ++++++++++++++-----------
 drivers/net/bonding/bond_main.c        |  66 +++++++++++++--
 drivers/net/bonding/bond_netlink.c     |  37 +++++++-
 drivers/net/bonding/bond_options.c     |  71 ++++++++++++++++
 drivers/net/bonding/bond_procfs.c      |   3 +-
 drivers/net/bonding/bond_sysfs_slave.c |  17 ++--
 include/net/bond_3ad.h                 |   3 +-
 include/net/bond_options.h             |   2 +
 include/net/bonding.h                  |   3 +
 include/uapi/linux/if_link.h           |   3 +
 11 files changed, 265 insertions(+), 68 deletions(-)


base-commit: 1d3a00d3bacff25652c96e1527610c69e91f7c38
-- 
2.54.0.1136.gdb2ca164c4-goog

