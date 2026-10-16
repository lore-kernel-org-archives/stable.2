Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43B4229A6;
	Fri, 16 Oct 2026 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136342; cv=none; b=g/CuZhYxS6uX/waRGumAZgCtyDCfm52j9p6PfGuqrJLb5G+ohMxRTqZE/5rHHT5ALB7WL9dHThqe4U3Yp6q+Ffbhr7b+bE0OAAMrWlL6ah+xA7T/g/IDw9vryewoYwTE45ntIK8fbcFAOVpHn8RPh4dXDYwdEWLsPLMKQ2ZSTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136342; c=relaxed/simple;
	bh=rb/Mg1z8TxLEIRqgN2huzPSpFjhfC3q2NTylh1AhmZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HtUQoTDwDPdtBBB3iQ4OSWDvUYasrprZ1WsrTgCN9ECw9/qETf7E1yRmesNomskHMsR04q2xt1hLnhvEMHUSuQzVjGamyVykkLkzEww4hrj6jozIN4BYvtkrxZ8rOZkAsSgyVH994zeUBT6RE10dPOPzywzvomwKcLODzsriG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=o7qBxNyF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="o7qBxNyF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F11C6A157E;
	Fri, 16 Oct 2026 09:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792136329; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=NCFsv0oIKshDxbY/H7lYa3Gle3dn2/g0s9NbBJo1ldw=;
	b=o7qBxNyFQvUZc+hEXuOQfjyDTRitO/6OlWsS79Lm+PF/QwC94rLv1rBzZfa7uFJ6g9LKnk
	QlwZH3KPZZMga+iJhtb4r0Duj1gY5uko9H3MvSYxG3LIPnz9jy/GFHL8SiM2fX9b7jq22H
	QePUdXIGBIHJpQpcZJr1c0XqFKqbl73J5Fs3xJgvDOeb6sI3OEaO6H9DDunRcK6jydnfWE
	M03diP4Da+v2BY6mof62ruKwN79jMEWp250G+WaQFfu+Xzsi7JmHKaGsMzI7fwV3OlU9n+
	oZv0EoAoe/cKUhPmEyLDS+sNuVL2HI4MaCcP+mcNBtlK69jEJ++eSupcBpwEGw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH 0/2] serial: amba-pl011: fix RS485 state on enable and
 reconfiguration
Date: Fri, 16 Oct 2026 09:38:20 +0200
Message-Id: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBA0auQWTsJxYrGqxgXZZjCmKaQTkEj4
 e5WXb7N/xsoJ2GFa7VB4lVUplhgDhXQ6OLAKH0xNHXTmtq02PPKAWO30PiU/MY51MZgUns5YWK
 aopcBNbsQ0FvP9ngmIsdQgnNiL6/f7Hb/W5fuwZS/B9j3D7WRUqaOAAAA
X-Change-ID: 20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-f4fe437cccae
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

More RS485 fixes for pl011, on top of the ones already in tty-next.
Together they are the groundwork for a series I plan to send next
cycle, which refactors the RS485 code for better performance and
reliability.

Both patches fix changing the RS485 settings while data is going out.
Patch 1 keeps the transceiver from driving the bus after the data is
out when RS485 is enabled mid-transmission. Patch 2 keeps a
reconfiguration from stalling the port.

---
Nicolai Buchwitz (2):
      serial: amba-pl011: finish a transmission still running when RS485 is enabled
      serial: amba-pl011: keep RS485 transmission running on reconfiguration

 drivers/tty/serial/amba-pl011.c | 54 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-f4fe437cccae

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

