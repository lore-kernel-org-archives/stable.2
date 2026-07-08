Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED2420883
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504073; cv=none; b=tYcKL2X67bTlf53OIvV8uC2SAt8ENmzAgdPOJV+YgG5hY4pbRGGuiWt10Gr101UCdnNirV01tXLCABOg4aQdL7z3+B8iiBaxprHP64IIbiIUnmUSDl5gvfFZso+KL+GgN22eHpAm3V7cAy2LThX9/xRDh+9D1Hxzx5tLLk7U7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504073; c=relaxed/simple;
	bh=JyTdwvpheUtf8+htGl6SxvWEpDfP1eAs2auxYSC749E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CzudhPJr5H40W49+RbWSY73w5FQwLN1s1IUVHcmiMm7LdcLRJO/e5KRQkQ6JWxYlnjWwp1I0WK4EWB3eijXlxz7e27k5a5VyoPdPt/qeyxyCuLiY2y8O06qOXi9YpAg04JxZsjf6QpOJfP4U1uM3fuz8PsFSswyyreCyoXYpGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HBDbHeFY; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HBDbHeFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504043;
	bh=JHtNsomxwzudEylRCYVPKus5zSiIohQaYpYcv2XeVSk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HBDbHeFY4lpdl6jmCZro9LQfSw11iHWciTPQi383BSx4H2sq3fD0cSVfJAZKU6Yj3
	 xUrWlmO67v+jSD4i6cpKsOUoRnRHrU7sfepNwF8mT2Toxzxp6p/rhX4aVl+mqyL9gp
	 AtANIO5ra6az5DVijcbxt3HMx2X8aQiHlVZIhpXo=
X-QQ-mid: zesmtpgz3t1783504038tde8d7ee6
X-QQ-Originating-IP: EzTgtjfOjyhzwefGxqTrsRJm7U9SndkiT7UlsensGqw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:47:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13140400527161414048
EX-QQ-RecipientCnt: 4
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 00/11] bonding bugfixes for 6.6.y
Date: Wed,  8 Jul 2026 17:46:59 +0800
Message-Id: <20260708094710.27047-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MoSajO47AaeeikiqdDZ17IXBsliMTczCzTQRUuu6YSXXPV1CiFHhQTBc
	Hd6ve8ZsD3425coIqiIR4fhf9t98JlfI7xEmsCU38O6TGxY6QgNm+MCQpP7A81vL6GiDlnr
	a2iCDKdaTOJ32Ee/RZOPnmIGm7+3be8N3tQ7QQECiJNVqVn3UyVHwl0XG1J+BiNhOkUMijK
	Tkb3EApLSeyOTlenshZz4k2NzMr5Y/27UkAB1gZeDhgE8D/2iqtUkww6L0FNn6/JpBEm8/Q
	HIvW/0fi/v4MPEpu6WIHGUPX98fO4UxiIt2f7a4FRsI3Vb+mVy8f5o2o7/7aUm2ycSqDrc5
	d9P68DFEQ71g7yn7bdfHqn/zoS+JnWwWXARuo0Jxi/37veYqgf1ldJ/DV1ae2yxNTa/D8cg
	SI8xatcvFygxx+8ARWcmZ7PxCGUwCYKPsijRqIlqOwIL7het6ZRIz63NzQMD++VVQ9wLJ6l
	+hQ/nkaFEebBfECbpfgtx7VZElQEGFdIDnHv3YI1CR7hyG+kqwI7c4t5rg2UXGoKd2yczbn
	z8qKespvR1lbJus36rZFobiBsSeGSUBHDiTigBsI3optvO/lfa7wUdgiIyjnVi3KIxMVsLq
	iHZJ8uDUevn4ZWp0AlNnqbQQkWfOHuarhP5wJZm13UdDOK6K905xSySs09bcYl+U8bPXNHe
	ql0P44Sw94pclXnwN6r0TB/nMimqWDtJbQR3hLz3TJo8Fz4wrujEQAVjxXFmtBaCtathlLw
	eWdJFUc2/RA+PNHPwj3Qa6CmGJmURE9khNQX9PExNQu1VVibe0E879KxZR9eaDeubO6vKQ1
	hRweuFomGauIQssXJz7weLlK+dzAWDCSw8I6SminRHi/jx323TAQ/HB9IpysYjG1QXoTXVX
	3jXi71v/c6FWzlG95S3WUlGN5B7IJsBZgtIAaXlRtRDefwNO09wEhHUuCt7OjayYV0QVYkI
	bUjk9kkzL2iIQNx6ZGW3qVdNkEYqf7JNwUQXv2PNr5EIeKzxYXDH/AhdzQYiC6r9WR8i8rL
	WvFmDxQkLjMQcA8dZ42t9+bJlddYJuKC8opCOhHMRzJtR2v82pi49iww+ia6/l+8xs5QX9t
	HzvNpQ5SgB+xpPl57CqOLo=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Fixes CVE-2026-23451: bonding: prevent potential infinite loop in bond_header_parse()
Fixes CVE-2026-43456: bonding: fix type confusion in bond_setup_by_slave()
Link: https://lore.kernel.org/all/2026040316-CVE-2026-23451-1298@gregkh/
Link: https://lore.kernel.org/all/2026050859-CVE-2026-43456-ae60@gregkh/

Cosmin Ratiu (1):
  bonding: Correctly support GSO ESP offload

Daniel Borkmann (2):
  net, team, bonding: Add netdev_base_features helper
  bonding: Fix initial {vlan,mpls}_feature set in bond_compute_features

Eric Dumazet (1):
  bonding: prevent potential infinite loop in bond_header_parse()

Hangbin Liu (4):
  net: team: rename team to team_core for linking
  net: add a common function to compute features for upper devices
  bonding: use common function to compute the features
  bonding: fix xfrm offload feature setup on active-backup mode

Jianbo Liu (1):
  bonding: add ESP offload features when slaves support

Jiayuan Chen (2):
  bonding: fix type confusion in bond_setup_by_slave()
  team: fix header_ops type confusion with non-Ethernet ports

 drivers/firewire/net.c                        |   5 +-
 drivers/net/bonding/bond_main.c               | 129 +++++++-----------
 drivers/net/bonding/bond_netlink.c            |  16 ++-
 drivers/net/team/Makefile                     |   1 +
 drivers/net/team/{team.c => team_core.c}      |  68 ++++++++-
 drivers/net/wireless/cisco/airo.c             |   4 +-
 .../wireless/intersil/hostap/hostap_main.c    |   1 +
 include/linux/etherdevice.h                   |   3 +-
 include/linux/if_ether.h                      |   3 +-
 include/linux/netdev_features.h               |  25 ++++
 include/linux/netdevice.h                     |   7 +-
 include/net/bonding.h                         |   1 +
 net/core/dev.c                                |  88 ++++++++++++
 net/ethernet/eth.c                            |   9 +-
 net/ipv4/ip_gre.c                             |   3 +-
 net/mac802154/iface.c                         |   4 +-
 net/phonet/af_phonet.c                        |   5 +-
 17 files changed, 264 insertions(+), 108 deletions(-)
 rename drivers/net/team/{team.c => team_core.c} (97%)

-- 
2.30.2

