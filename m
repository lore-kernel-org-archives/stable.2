Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280112;
	b=YnXhL2tDwiE/A6PtyLtseY8q1CV4hFDvSbyPSeRpvzPd1sH/35bCeSdfbG8o30yzzR2R
	 SSIa9MqCbILHuWiZs6fpPjO0ynK8L9Lc+Kzxm0Gy76la8X6YLIvtxI7/6YNve9t9vgwvo
	 nVjqrkWhqhavrpHZWPiPae5j1je/wfE0/qfaF9Nb43KCAWh2R5reZAHZDXvpI5SJnVBpV
	 bLC/z5uuGIEFLRu8fU2FzlNwKXKFiMLocjMjxg7+4Ql7H6kiTnL5Mmf199209lsoqxGIE
	 Y8kUeLmVwL6Mu2aJeM/JMjnpkA3p8AiRS8ArX1cNn80f2Q0XKhTeq2H3tBV+9eWVzBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280112;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=YYQn8S88z+ExXDKace3bLF4UdwK6mqRHP5p/PKHKID0=;
	b=Glghx6vsIpfVEjEYakLv//j1T6SZevM3nKtaxnqLcazFp2/BWpmwq36ZAA+v1EshHWHY
	 QK4En3WZ8KSBxOkDcFXRPO9PwsWIfl/ewJ39R4NOfYfFASa63zkHdv+kZ6x0YYWEza/9+
	 fdY5UUWNs72VfdI0Yay3LvBXAN7W7Wl2x3FitMiJN7blOI1jna1MSDG1U+yBL2They7wS
	 EaktK1oSueklYE9RavmBl0xresl+U/F38lMBij8lrbWyuC8ELxjd7uHjVVHWPYiBpAOqp
	 2D2xjFsfahpKQ9Co6taKCdQn0oqMChXZG4yHrrPv/J0BBmDOZ1Ah8egUFgCwxoorUSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=f6l8Ug57;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893FD606A31C;
	Tue, 10 Nov 2026 03:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 893FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=f6l8Ug57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794280086;
	bh=YYQn8S88z+ExXDKace3bLF4UdwK6mqRHP5p/PKHKID0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=f6l8Ug57LFStNNLXkc6miIHKMiDF86r21Fzz6rU6WI9e257m1tdKMD8M+1Z06M09c
	 WGbiE7QoI5EtumpCuj7cvVBmEV0Nd+R+vfZ7J2TKh28GmAQU93hPgqQU8FcjpNzMwG
	 jCn448fqdh/3Wkdx+i1xx3W3qFPCbFme5d/Fejmc=
X-QQ-mid: zesmtpsz2t1794280080t47be1536
X-QQ-Originating-IP: X5KzAynenyWeiju9eohUWvuC29q2V9Z+8Bbn5yn/y7o=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 11:07:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9820339102061776409
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com,
	johan.hedberg@intel.com,
	alainm@chromium.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix runtime config status opcode
Date: Tue, 10 Nov 2026 11:07:56 +0800
Message-ID: <3B679DA76E38DD0F+20261110030756.214083-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OROlIQ8AXA3lB/Maq0nByFyUxNwFDDSjiZPIQcjhlfFx2AQSV31tGY8e
	VLS1de761Xr5UfX+AaBTLToXpFJipbtaMpCiarYTPyCER2pjs5YQWYm+zD4+TMLhklFFLvT
	g5DndqAJdgZmbnuD/in0oZr2msHSHYPRA7VY0KW+HP/hARa19rlS2LPDSfx0mq9Nj5ZBb/o
	hvjVKMvyXlyr9vNfSXgNVaJINZdxIzjEqfONJKLpYphlBcuhOQfPh0zZu4m9c1amDBNz6ry
	mX9sJ1q4HjLOG81xiQFzBYFjAg4uVh3aBacgSeFqgodCYfV0a7WW3rC+wHCIUrKq90Qq1Zi
	iyVHBxtb+v4k6qNCsBkDYg2Xl7GZJziN4/P0JoHzyoeicf9bfC8Q7uT7yLWyY+dZRG811mn
	xG8f7/QalSxC3YTlCornOjREkoxfRqJNtSSCk5bmApgRePqJD18lmSB7PQ2suAxQGhGlDu8
	8S9B9xY5xHCkADP6gLTdxlYJKQDyJwVeOeLhz1XdrEZ7VP9U8HVk85GR9vXMQnIHm6GA46j
	ZKmBiDVUJSs/PYky1CHRjbtadvm0Z/2Ti9KliVDnqJLc+YQVESX7QbQqUOIz9bAwhZgguGj
	4CHytT+5nrqYa4NSC8D8TG4fLBmqNIUBSPQQdGW+9iqAJdIuFs9ZkXEqPbcQYwRX8PEnCzc
	DXR5fXvzPnrzD0izAUvmZ35a6/dNjIvwikrPU7uTL03IxcJXY0ba+Avt8++VdJHjgDSc55m
	B5OpHj4RT0mZiLNXGm3vtb4EjsTQBDj0y57CMWR8L+EPe3/Q/TAc8ml8ZyK0paWcg6GvPwy
	z4HUKmVswROevZ3292ZCQMynU6I/KfbrqDFMcKmjty9GhV9F1vJE/C16zD6CWo8eZ65/iE1
	2Z0UQoxWs0FgkwOR/kUXg9lWgsD4rYUH+GlagKy6swnYOjxjj6+up8i1RW4H9umMSiWyMtK
	AjZn/D0sq+Tc9umUwuRFtoQ9vB0iyL/w1DC3RgtaS5qritoPQHscw8CdNZ7TMubERT91DcO
	0GOmjwafJScBK7/iR9BucfRVtVkq0=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The Set Default Runtime Configuration command uses opcode 0x004e,
but set_def_runtime_config() reports its invalid-parameter status with
the Set Default System Configuration opcode, 0x004c.

A management client that matches Command Status events to its pending
request by opcode therefore cannot associate the response with the
request it sent. Runtime configuration parameters are not implemented,
so the command still returns MGMT_STATUS_INVALID_PARAMS.

Use MGMT_OP_SET_DEF_RUNTIME_CONFIG for the status event so the response
identifies the command that was actually handled.

Fixes: aececa645dc7 ("Bluetooth: mgmt: Add commands for runtime configuration")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 net/bluetooth/mgmt_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index fdcc752c6f13..6a617656bfbe 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -362,6 +362,6 @@ int set_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	bt_dev_dbg(hdev, "sock %p", sk);

-	return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DEF_RUNTIME_CONFIG,
 			       MGMT_STATUS_INVALID_PARAMS);
 }
--
2.50.1

