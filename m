Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F123859EC;
	Fri, 31 Jul 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491194; cv=none; b=po0wDIkXpgkqwTQP+dlxrMALtMCK+NjDSLnfPCjEXIfG7MhxLcOW4NQfCiU0KVN6DmJR6WgME/xSyP2GnQMVpg6zDEax+yvriUupKnLHhMaQHZpAYtFUPXH0BewRWxRwS5lS/9uWkHvYDsaORYkZuSeMTWmn7lXcBLkuyfV2Sws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491194; c=relaxed/simple;
	bh=6KCjKV4XzhJukLj/BBxG5U7Ra8WVbNjfUBfync98Ync=;
	h=Message-ID:From:Subject:Date:MIME-Version:Content-Type:To:Cc; b=GI3K/rFQ05R0ygeJqkDdQ3TE17flooss7Srg/svRqkLU3O2ux+8zsT1UgzXDZRE6rHwa2ZNDSPJp+vA6bwq7EuO96boBN0BwG4GZxnaViMXTrxeehaoaAhRcfsbaJwgzxHGa5aop0LWd6emfxu+6h8D+XcS7Z/J85UFGZ9fFdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iqKPROBF; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iqKPROBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785491181; bh=uHGCuO9CkxfHTd1FhCmxJHQnELJhlku/W3xFua8wduc=;
	h=From:Subject:Date:To:Cc;
	b=iqKPROBF28XdUXqo1rpUqVcMykXcEuK+NwQM9zgQhzBgutFmRtSD+MxVuYd2WAPQ5
	 T40DE49hJmG/8DzzSYvr6Obnhz88QuJ+ecuv5FJgf/SckecfdNeG8n17LQM9MmPto4
	 PKLWRsjJHbIJUjrr/bhTwWRNZ902cd35BC8Cj8us=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id B4623E87; Fri, 31 Jul 2026 17:45:06 +0800
X-QQ-mid: xmsmtpt1785491106tf9m3obm8
Message-ID: <tencent_CD05F020BAFB2537F5D1F4CBB425588EA80A@qq.com>
X-QQ-XMAILINFO: NHywbwSl5Y3d2uTgJ1yiaZS0JNDeqWR91Eovo/KkQgsowWoxY9b/Azl2cCWz07
	 V9rTu7KddTBE8dHZ/BDRTHNY3UR4+UJ1o/AMa9eo0Fis0aupgVolRzwCkr+OkUeLjnqfDpvbH602
	 dUFiE/dwXAyMaG7+29Mxh+mhVoTZLY/nZaX4Y2MeSYXDqJRWBuSqY8eWlhbtoyb/5QIQWXQX0wUu
	 m2OlEFfmUX9EjbmQCnUiyykX/E+A5jTOe2M7Ku+oroVSCKL0z+R7BfbJfMwnBVPECMQVONDMOUTn
	 d4W54rYlN1go+QGA4PjXSlHnQGQRBHeD+4sSG4sC7dlFQYmQprNmBgR/xZFJ7c1fLAlXJhbUubr/
	 c69q0G2dxglmJPSeORd2V9F5XQpcod2cp1K4bF6vdRKY3WVuVNigJ6fJRyG11Llvd0ddkuPMiZ5T
	 sm3wDJbpsPhhrfcUDXDL+Ivv9m4u9rneGOYJ5lT0flUckZu0eUPyaXZvPD5vyr+QFElsy8DzBXPi
	 8oPhSEvZ/l7rkT2xwMRs7QUTuU4cScmLnm5mWA+ONyiiqj+uvCf7eHh1Csl1nboBG4G0y4u2jk5F
	 BF+C7CoKpoO6iIHjwnFA7pS15mXRUhuHk1xmDIE9g8kMWH4zqA+WEKttQ5qnKUN8lxQpJyNCmodp
	 2PVgnyYCXpwLsKyBryfeRJxx0L6sfwIO81a0YeV+wp8hiBsVlGpvtO752eqPB8Tuln5ppZkBSP8g
	 VHQDtfcYpXgdG1jaXz5ULxpSnSrhTrlxryOZilAV6fKxVJLhAIY1tLBZJ/+V2c3WCFe7IrH3vVti
	 UbD+cSY0VpufU20StKMXCNRzm5zNBnZX3bNdSSIiGyuhEPveS3JFwqbueg9yDiJPhLk7f0bHO0WC
	 i4y37lM93Sg1MrhM+kc8OI7ue2tlBHkdX7tGJ9fDQ22RGbhWO8IGJFWrMEkt3ltVfgDxjD67TE0s
	 CiEf/T4T0pK2l9Aw7ZwiiGCgtm1W8w3wGIEJzCrvFX4iSBJV89XtXu9/eOpWICLZf96yBPEU+xi9
	 kLaIqs9PZknKm3eLAizd4tRMdf2pK/BVBebHKd4IOJE6+JjrqReN4cgXOD1KNCkgPDAVYLMtQFts
	 syF/llsio3Ds9+Uf12qkSoUKZy+Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v3 0/3] can: skb: make CAN skb freeing safe in any IRQ
 context
Date: Fri, 31 Jul 2026 17:44:59 +0800
X-OQ-MSGID: <20260731-master-v3-0-b56cd1e8d675@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJtubGoC/2WNQQqDMBBFryKzbspkIol01XuULqKONQW1Jja0i
 HevsSCFLh/89/4Mgb3jAKdsBs/RBTf0K6hDBlVr+xsLV68MhKTRKBSdDRN7YctGcY7acG5gHT8
 8N+61hS7XL4dneedqSnZatC5Mg39vT1Gm3V80SiFFwVKTrZEsFedxPFZDB6kY6deRu0MCBWFeG
 0MNsdK7syzLB8GxPJDfAAAA
X-Change-ID: 20260730-master-abf3e4067e47
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

can_put_echo_skb() and the CAN skb allocation helpers may release skbs in
hardware interrupt context or while hardware interrupts are disabled. This
series makes the affected public helper paths safe in either context and
fixes the invalid echo-index skb leak.

---
Changes in v3:
- Cover can_create_echo_skb(), including its successful-clone consume path.
- Add an IRQ-safe release for CAN skb extension allocation failures.
- Link to v2:
  https://lore.kernel.org/linux-can/tencent_549A2499DA04F6919D002944523FCC267D07@qq.com
Changes in v2:
- Add a preparatory patch replacing the existing kfree_skb() calls in
  can_put_echo_skb() with dev_kfree_skb_any().
- Free the skb with dev_kfree_skb_any() on an invalid echo index.
- Collect Vincent's Reviewed-by tag for the binding patch
- Link to v1:
  https://lore.kernel.org/linux-can/tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Cunhao Lu (3):
      can: skb: make echo skb freeing safe in any IRQ context
      can: skb: make CAN skb allocation failure paths IRQ-safe
      can: dev: can_put_echo_skb(): free skb on invalid echo index

 drivers/net/can/dev/skb.c | 11 ++++++-----
 include/linux/can/skb.h   |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)
---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260730-master-abf3e4067e47

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

