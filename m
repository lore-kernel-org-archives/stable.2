Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C834CB8C4;
	Fri,  4 Sep 2026 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538879; cv=none; b=XySc6qFgWGuGYFLdfhfSFYM3RJkMr7uiaPcFLpje32ggJ/dKNOoWFfGf3Maqu+8z7dESPNMJFHig9gBy0lr3Vm1o1vWV0r0m+xh9q1iDO+/kU50JxLH5mz4/VY2jmKHCrcWjoMjT81bwt17h0wN9tAzyLPjSYWOFwCrLBJ7uCBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538879; c=relaxed/simple;
	bh=N7HXUlxgT+PwrqkX+rdX69GAhdbSoHp7PQ5xKuoczrw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kWM5VOdOujUGY88w2bEeRJIme6lnnFjWYZChlRvorv4nwWrEsHT1XeLdl0a55cFqRkOc444rNkcAD18OuCT0XUTXJe18Uf3nPj0CveoVF1dE+i0kGQTqmpiJhW9isqb+Fh5vnMWBRTpIaISFpe9SBcrLpPJKY46zoR6ECGJpAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D1rfOdVC; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D1rfOdVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788538869; bh=vxTXE7HOEBi2t5JWj1r5UaidcWmJ6DtV7Ta6E6ywxz4=;
	h=From:To:Cc:Subject:Date;
	b=D1rfOdVCWSKktOIArCksp3K3wWmpNMJScldTmj9ALLIWqqjt1Y/sc1rXt3XCulMc7
	 dfF3qyPOVK2eHn4p2glN2Kmj+PAi6rQTTmDDjPjmfCEASPtHCWTPLgwLRE8fhzgCwb
	 +UFjqe+ZX0lApeTJ4z4KFqwQH8V5ppYvojGkv/mk=
Received: from xgyy.localdomain ([2408:8352:603:550:7022:3b83:9f7:e2a7])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 5432E695; Sat, 05 Sep 2026 00:21:03 +0800
X-QQ-mid: xmsmtpt1788538863tb5f60adh
Message-ID: <tencent_D1C873B86B0E92011A264B0E196B911D5308@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeAktxJbu/jBXgAJ9QqmqP3b6oM3oKpaHEuCmCF+REkSlHarxE4u
	 g+v576zskM03OhwwB5I2v4DX1ct0KCwAjQphvh2+HWuV41/Eqn3iA1R2pMcKSnwgPwmafEE96tAS
	 wQH00ObKWqzaHOTEUdqOulDU8hxKQXQjBrOUWZwRfBth9MdQMBm1K293Ahw1MhJvxMLHso8GAxt5
	 bOVjDg5IxNWI7t0+l9d1If7g82kKys+tIPcZfddAb3+E+1WTM44WHkXGcVglv2YupbgOpwFc4L0k
	 9g1tU7vbiZoJU27wbrS9fjTxWgrbSbaKOAZF6YxV2sA7g2WwMBfSBU4AzTf84ditgfV3hNuz9Mjn
	 9+gZJR3NQcUv9f9XgBavmXd9XVRMEP73w70qVBtXrIzFkvcVuaB74RJBjbRp3JewtquEpKGlkXWo
	 ZCMNLyFBeyQroe4NS+gDv4GkklwAmUo1u9LncWD6e2Afa0Xs1RWUV1QwBnNRAGz2tkczpvk8JF0L
	 jASnfT0pWuX8q8GCr+bXQ8B6S5H5XmEcUiwFVWY8MrkNkvO0ca1fmkpVvDYZl3KjYw9sMOXRA3/V
	 XS0oBr1MRetC0rqxCcCQfM5Dtpigwqenj9Ej2f5xxCT+aF1766CtPK8VTQGEMz4edifVr2c1h/Jk
	 MqwRWUZeonQ5XAYLFBNw1mJOVcydwacmhd/eB2u5z0pp4/+LTtQf67P6z5WrC/lxO1fGtX+QMuW+
	 QJpjNknFsWS51vSDSl7fGUyAtvM/UcQUrQgkkjYPfNcbXw7+YklWGMVZ5I1mgsMLPOB7uObzpf36
	 jGUIVciHKmfIVbhdZqSmAAnHUDnQQwFVWnaXIZAiJ6td63mUeau4N4JM6he0LTvXDdDhR82kzeEX
	 PkE8sw3m8AxE5tDGTbN4jAXzxkwRxwruCAfs2p38SFjEnqRODKeiZMLJhjFVh/WtqiEbN02wsU5W
	 DLM0ZQHn3ft3fbynSZkjaEWMvjhJDjzvCstJCEwcpPqJhfEjD7+GtfB3TT+bynKH9gBTL6vvCkdj
	 BdvmCnEzd4gzd6UJwJKhuVUk2Xyei1hDSQLdgFqDn4Gm4klNSyQg8XAFsjWEWoZZkW2PNvfu7eMT
	 NUN8amraSY/djPJoFqwBhfi3qcID4tM/2tXZ94
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Zhu Ling <zhuling0805@qq.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	nsekhar@ti.com,
	faiz_abbas@ti.com,
	s-anna@ti.com,
	fcooper@ti.com,
	linux-kernel@vger.kernel.org,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH net] can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing
Date: Sat,  5 Sep 2026 00:20:58 +0800
X-OQ-MSGID: <20260904162100.13674-1-zhuling0805@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can_fill_info() emits IFLA_CAN_BITRATE_MAX with nla_put(), which consumes
space for both the attribute header and its aligned payload. However,
can_get_size() accounts for the payload only. The resulting underestimate
can make filling the netlink response fail with -EMSGSIZE when the skb has
no remaining slack.

Use nla_total_size() to account for the complete attribute.

Fixes: 2290aefa2e90 ("can: dev: Add support for limiting configured bitrate")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 766d455950f5..ba26c61a82c2 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -822,7 +822,7 @@ static size_t can_get_size(const struct net_device *dev)
 	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
 		size += nla_total_size(sizeof(*priv->bitrate_const) *
 				       priv->bitrate_const_cnt);
-	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
+	size += nla_total_size(sizeof(priv->bitrate_max));	/* IFLA_CAN_BITRATE_MAX */
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
 	size += can_data_bittiming_get_size(&priv->fd,

base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
-- 
2.43.0

