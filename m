Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.59.88.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400691;
	b=pp1thRUVfmS8XSHhXiOttgzV70BUI3OreKPKfhQ4e5rYjdqxYWh4IHeZngR9mXDpYJmt
	 FbiK/QdZ7bGN+EGtZjQwxw9XbNA6dwmaAtwARQHd8aWYTG3N2Ru01CntQl27b/g3AE//c
	 P8uVhYxf/uA1VnvS8gva4TNsKRlkjNJ/OQqXFPVicIfWZ1qlNzsxDgsP3ROcCXNKIgyuc
	 FpuOjDAQNp/+3UEjP35CBVGIit6cC5KbOONqUsN6dOFqDJGJAVghBbMsjEb8GSXZFjP39
	 60n0Jxx2F8Ozi8pOlXcXMkw9xmMpUMH3FM4HL8ixphFvH+l4P0SFQK9G1NASskUrMSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400691;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3SA3REMlW0h33pZ+/jaN4fyHLOaIUmQgzhd7ZwsM0u8=;
	b=KPNSLWdSaJbs6ceKRog/YvvYdXrO85a2YTx+8WRkF0f40GyBQnHH16eNsJH4hRGmU9H3
	 xV36bCVectIsumx/q6U0qcSqPG2eYHmh8QVbzFIGu8yUnvCXDde98U3u8BfV0dsBfLpU9
	 Y7lzD/YXzx5F+un7cQ48ExkXYNcRRDsduo4vqMUfBIQtuDwnHNsW2HZXiNuzvieCLVkdG
	 NrD1d6sDRHJ7sFA7h58JZc9Ojdmhfb20P8w/+fFWUZE8HzZewBeN+QWmt+e2yu89PUfsp
	 UHZlPAU1FfhpesknOUiYtP6YdAvjmQ2idyKTK4WdpW1DPqj4kTjbWAjZE6eNDE6m7Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=newsnow.co.uk;
	spf=pass smtp.mailfrom=newsnow.co.uk;
	dkim=pass header.d=newsnow.co.uk header.i=@newsnow.co.uk header.a=rsa-sha256 header.s=20160728 header.b="t7EV/VHe";
	arc=none smtp.remote-ip=154.59.88.225
Received: from coen-mx.newsnow.co.uk (gw1.mail.newsnow.co.uk [154.59.88.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D388606A31D;
	Fri, 30 Oct 2026 22:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D388606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=newsnow.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=newsnow.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=newsnow.co.uk header.i=@newsnow.co.uk header.a=rsa-sha256 header.s=20160728 header.b=t7EV/VHe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=newsnow.co.uk; s=20160728; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3SA3REMlW0h33pZ+/jaN4fyHLOaIUmQgzhd7ZwsM0u8=; b=t7EV/VHehaZqD9//7uETPQTMt8
	q9DQLDem+EvOXHQ39xY0VDCrLf87uCHDo5rXtP5JeOVz+japhcwJ0pkl/9VuIHk0QoQLXqRp+oGIJ
	zdj8mhDvW6zHad+KdWyNO0vCXTz7bTXvwvyjtGa3Ontw/k5ZooTw2CfRNi3mTaDbMpwqZg9kKoVDg
	XccG/BtlrwflotLCWvDYG7QMVSUoUPhbhkdXWLxyV58eTora8+L1/L0Wiu/o5u0hKZXj4ASe2kSYA
	cq6pvFdSS8UCqiGio1SNktlidcKnl3EDZHLeB57H/TVESSQ2ra6d1BecqcKKE3ZZqIYSTTS40R7+/
	+E5inzBA==;
Received: from weber.dc.lan ([192.168.3.220] helo=amd64build.webcluster.newsnow.co.uk)
	by coen-mx.newsnow.co.uk with esmtp (Exim 4.96)
	(envelope-from <struan.bartlett@newsnow.co.uk>)
	id 1xMvRP-00073D-0W;
	Fri, 30 Oct 2026 22:51:19 +0000
From: Struan Bartlett <struan.bartlett@newsnow.co.uk>
To: stable@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Tonghao Zhang <tonghao@bamaicloud.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org
Subject: [6.18.y] bonding: please apply 11ea9b8a88dd and 70fc6649b36c
Date: Fri, 30 Oct 2026 22:51:18 +0000
Message-Id: <20261030225119.40765-1-struan.bartlett@newsnow.co.uk>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Please apply these two mainline commits (v7.0) to 6.18.y, in this
order:

  11ea9b8a88dd ("net: bonding: use workqueue to make sure peer notify updated in lacp mode")
  70fc6649b36c ("net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block")

70fc6649b36c fixes a fault from 7a9214f3d88c ("bonding: ARP monitor
spams NETDEV_NOTIFY_PEERS notifiers") that is present in 6.18.y: in
active-backup mode with the ARP monitor, if bond_ab_arp_commit() fails
over while a peer notification is pending, bond_activebackup_arp_mon()
decrements send_peer_notif a second time, on the strength of
should_notify_peers computed before the failover. The counter wraps
from 0 to UINT_MAX, and the bond then sends NETDEV_NOTIFY_PEERS every
arp_interval for years. At boot this happens whenever a backup slave's
link comes up shortly before the primary's. On our servers FRR's zebra
counted each notification as the bond's link coming up, and ntpd never
rescanned its interfaces, so the clock went unsynchronised.

11ea9b8a88dd is a prerequisite: it adds bond_peer_notify_may_events(),
which 70fc6649b36c uses. Neither commit is tagged for stable. Both
apply cleanly, in this order, to v6.18.60 and v6.18.9.

Testing: Debian's 6.18.9-1~bpo13+1 kernel, booted in a VM, with the
bonding module built from v6.18.9 against Debian's headers. A
reproducer (two network namespaces: an active-backup bond with the ARP
monitor over two veths to a bridge holding the ARP target; it fails
over to the backup with num_grat_arp 255, then lets the ARP monitor
fail back to the primary with num_grat_arp 1 while a notification is
pending) counted the bond's NETDEV_NOTIFY_PEERS events for 3 s just
after the failback and, if there were any, for 3 s again 30 s later,
after the 255 would have run out. With arp_interval 100, a bond that
notifies on every ARP monitor run sends about 30 in 3 s:

  bonding module                         after  30 s later
  Debian's                                 29     28
  v6.18.9, unchanged                       29     29
  v6.18.9 + 11ea9b8a88dd + 70fc6649b36c     0      -

Neither commit applies to 6.12.y, so I am sending a minimal equivalent
patch for 6.12.y separately, with the reproducer:
"[PATCH 6.12.y] bonding: re-check pending peer notification under RTNL
in ARP monitor".

An AI coding assistant (Claude, model claude-opus-5-5) helped trace
the fault, wrote this request and the reproducer, and built and ran
the tests above under my direction. I have reviewed this request.

Thank you,

Struan Bartlett
