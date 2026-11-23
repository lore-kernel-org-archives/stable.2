Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427754;
	b=XQkXNNgGYURoFTy8PT17QFr+ffULO72l7G4ZdA3Zwoa19JqBEJbWJduuM13vN4KH61TT
	 baVuecu6vfIesd7wTr+u7FOFj4e9TeeLhv1oUhg5PiuAqQjIVpjgbdDMaaOhFSiFDqOef
	 VMRneVYJOO/ktRza5oI//aqUdBY5Q7cre+zofcNKKdmB/eOypQwgVDTkO0QzxMQdNFIdd
	 ibpDGf+x7CtkUo6h7NFFtLRRDmhvnyYnxyFzk4V2hAu0S/o+T0qYIdfZ+oyAcMGjaMMCb
	 /STxB8AKkXZlXpbxGnyZ0lYmyso8rvS0YJQ8EoJerjr7dm6IgO1x0aBzXgMjOfiSnEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427754;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=NFDq/dfBCfoa/KiAjzRfVOpUv5cnY5UK5YhJ5mmMku0=;
	b=dGW2aG38d1BItFkRRDJIGkG9MA92WSJmcQXw8GuoV/6Ual507oyYjBF8S9ghJ3KjU8wr
	 VRSRVS0FIOBN6TT5/OWz3NwCun1ngxHcjcDVj6fLRSSpY77i+aTmNBs7iFgNoHquEYxLV
	 RHurt7EDEF/1xz/CdtuvWhUtQ2uooGIs+ZmP3py/bt3+LCNJ84Aw8KvFYqpoSxAkrCfFT
	 H8N0ZcKbdaprVJBrSPggI1+ZmFBCbTP235YbDRSsCswb/X3z0rOQVlMYq3zfE6ZroD9iI
	 rb2ifRWky+b8K/zN+ub/5VQEtDzlESUNFgrHuvUtFDKcVEh4y/7UzP5VwQA5qeTnCsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=cfSQ1o9c;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2138606A31E;
	Mon, 23 Nov 2026 09:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2138606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=cfSQ1o9c
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jY1Xj4cVzzMks0;
	Mon, 23 Nov 2026 10:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1795427749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NFDq/dfBCfoa/KiAjzRfVOpUv5cnY5UK5YhJ5mmMku0=;
	b=cfSQ1o9cRMD08SVPSlNEhqcISoiYnXtkWfa9m9B545BBBgBcuKfKio8BqvYr8PzSk6kzcJ
	IsB3M5CJ27BrHBu0/oJ0oRS/tg2kIoZblS46Z7kv/oPWvvtG6lGM/0pns8OlBiTb5gphYD
	zmGLj8vOMbb4fOmpb9rgR1ddHMykypquBnxF1cXs1XsnJp+dg/VnGjn40WmykCL8fowGRV
	R3AF+fkgSvYDPsz1R6K1JuFXJa6woC/JqFpf1eDaX+nAlI9wX3qNsTJU4/jhg5Qd41zIUK
	QiKw7D/gy4BJEy/v4eWkk5sbU+1DCvpEOdQpXhZ/PYpDcB3a3pOmGktTAnmigQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Subject: [PATCH iwl-net 0/5] intel: fix a Tx hang at boot on I219 and Tx
 hang recovery
Date: Mon, 23 Nov 2026 10:55:14 +0100
Message-Id: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBQFr1Le2g8/ESJ6FXGh6at+kShJqoXSu
 5vqchhmZhRmY8Ghm5H5tmLP1MBtOsTbOV0p1jeGVx+cUy90qkqpk6xaenIfom7jbgho0StzsOk
 3PMI+D0msOP1FGS93xrrusCxfI3bFvHsAAAA=
X-Change-ID: 20261102-e1000e-tx-hang-dee96c03c7f6
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ertman <david.m.ertman@intel.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Helge Deller <deller@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=2406;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=DMwtg/bvCNLG7STyovCaXcE1wSYyWoZi/jHKr4ndvW8=;
 b=9OXIEyff4Wml5k0fiH+RpSyL7CxYDRnii0TPmWDGg0Cd07OQ4VEDt+nZiAlRGUFCI96BWKIKw
 /BWghHkuN3/CYhng266ajQ77CqZRcRZeXyTd519f2LzT4q59dgcQzDb
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xj4cVzzMks0

We've been seeing some rare hangs of the I219-LM nics in some of our
boards after boot. We ran some longer investigation on many test devices
and found fixes for both the hang on boot and the recovery not working.

Patch 1 fixes I219 occasionally ignoring the global MAC reset.

Patch 2 fixes why such a hang, or any other e1000e Tx hang, never
recovers: since v6.12 every hang report refreshes trans_start, so
dev_watchdog() never calls ndo_tx_timeout.

Patches 3 to 5 make the same change in igb, igc and e1000, which stop
the queue on every hang report too. e1000 is affected like e1000e. igb
and igc currently recover in most cases, because their watchdog no
longer forces an interrupt every two seconds (a22ed15c99a0 and
8dcf2c212078, "Get rid of spurious interrupts"), but stable trees
without those commits never recover, and with them recovery still
depends on a stopped queue seeing no interrupt for 5 s.

Drivers that never recover from a Tx hang, per supported kernel:

  mainline, 6.18:  e1000e, e1000
  6.12:            e1000e, e1000, igb
  6.6, 6.1:        e1000e, e1000, igb, igc

The lost reset fixed by patch 1 is in all of them.

Patches 1 and 2 were tested on hardware with a kernel based on v7.2.13
and with net at 5e9b2ad9b838 (v7.4-rc2), both with PREEMPT_RT=y.
Patches 3 and 4 were tested on hardware with the same net kernel,
patch 5 only in QEMU.

I used an llm to both run the test series on our testracks and draft fix
commits.

---
Steffen Dirkwinkel (5):
      e1000e: retry a global reset the I219 didn't apply
      e1000e: let dev_watchdog reset the adapter after a Tx hang
      igb: let dev_watchdog reset the adapter after a Tx hang
      igc: let dev_watchdog reset the adapter after a Tx hang
      e1000: let dev_watchdog reset the adapter after a Tx hang

 drivers/net/ethernet/intel/e1000/e1000_main.c |  9 ++++++++-
 drivers/net/ethernet/intel/e1000e/ich8lan.c   | 27 +++++++++++++++++++++++----
 drivers/net/ethernet/intel/e1000e/netdev.c    |  8 ++++++--
 drivers/net/ethernet/intel/igb/igb_main.c     | 11 +++++++++--
 drivers/net/ethernet/intel/igc/igc_main.c     | 11 +++++++++--
 5 files changed, 55 insertions(+), 11 deletions(-)
---
base-commit: af6737b9066832a2017c281159950ba92385ce00
change-id: 20261102-e1000e-tx-hang-dee96c03c7f6

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

