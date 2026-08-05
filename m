Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17B3B42C0;
	Wed,  5 Aug 2026 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905605; cv=none; b=QrPZBRaqHqLZdGETIR6LwdiufY+hp8TZVHs9EQjajM8Ya7MKIZuBx++7lW9JM+L+63KwyOPWn9VSRfZ4qTFG8EGmkR2rIG9nkV1H5+Fn6wjTeeXeT3O7MoaUMyl7DoqcSL6UGF9f6YvbcCxldc4BjhCHUAum1XMib3/I6gP15cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905605; c=relaxed/simple;
	bh=CeY2O+kbQ341ETbdqORF7cX/lXue1rzJFu4FGMf0hoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rvcgd0WV0hpl+R44atqQWmHXFEOcM5zlS2qE7loa6K8CKiJo6kwjKdtqcHEruR0e//0OofuKSlj1fA7oyNyBusR7OtT4/VcSOqYBKDgwtjMWXeT/HkvNGH5i2PxxFrSwpGm6KhYzTAl3OxHSJjD+FuT6c1WRCQw85oiDt7bsGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4nBfCE5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4nBfCE5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 944BFC19425;
	Wed,  5 Aug 2026 04:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785905604;
	bh=CeY2O+kbQ341ETbdqORF7cX/lXue1rzJFu4FGMf0hoU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=H4nBfCE5gGY+lBP1RRT4d1HNQdP34gsSDIK9vIxE34YLQcUFMXHnEEGV+tcbVg9Nt
	 Cp36NQIXvUII2Va2uKW7kJS0Pz6DrnB/AUbE62FHPyH1cmegl18D527rrnY8Z6iWYC
	 EB/azwEEVt5TgbIpGZ1FNWrN2lXlT4vFJlo3VbREDICeoPtm35wZpyNiwNvQgg3rxW
	 CIV7wFEj5uepKnFfm21ylDrSBdsDZECmXNMuu1naXfrmz+/00zS0OHoHLYFA0gxJyQ
	 lb8sSkVIY6MfmjCbWusqui6ZA88RzJTd8bsNFSLUk9jhnqP8SShMslT6SOtDNc76H2
	 UcrwVYztj1PUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709CEC55822;
	Wed,  5 Aug 2026 04:53:24 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Wed, 05 Aug 2026 12:52:10 +0800
Subject: [PATCH net] macsec: check offload ops before inserting TX tag
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-macsec-fixes-v1-1-634d7679a030@outlook.com>
X-B4-Tracking: v=1; b=H4sIAHrBcmoC/x3LQQqAIBBA0avIrBMmwZKuEi3MxppFFk5EIN09a
 fn4/AJCmUlgUAUy3Sx8pIq2URA2n1bSvFSDQdOhQ6t3H4SCjvyQ6MU4nH3s0VoDdTkz/aEeIyS
 6YHrfDzru88FjAAAA
X-Change-ID: 20260805-macsec-fixes-d280baf70552
To: Sabrina Dubroca <sd@queasysnail.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=dnNbOmnffeebhe2aAVXh9WY4hPJFAjjHfVNB3XhEz6E=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrKKDhz9P9Nb8uSoy8fejEx82N5/VnuG76tj+9vcmP
 2ue5tQIPHPrKGVhEONikBVTZDlecOmbhe8W3S0+W5Jh5rAygQxh4OIUgIk8E2ZkuHC/sCd2a9mB
 A1f8JkjPuH7xAqNb2ExXlqK+/KTLtZcLPRn+52+4v8jswKfbecrl+5tkHvgeFGVbYlPu5lp7R/I
 j9yxRVgBiRVBS
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

macsec_insert_tx_tag() takes the ops pointer returned by
macsec_get_ops() and dereferences it straight away:

	ops = macsec_get_ops(macsec, &ctx);
	skb_final_len = skb->len - ETH_HLEN + ops->needed_headroom +
		ops->needed_tailroom;

macsec_get_ops() returns NULL whenever the offload is no longer live:
for MACSEC_OFFLOAD_PHY, macsec_check_offload() requires
real_dev->phydev to still be attached.

phy_detach() clears real_dev->phydev, e.g. when the lower device is
brought down and its driver calls phy_disconnect() from ndo_stop(),
when the PHY driver is unbound, or when an SFP module is removed under
phylink. A frame sent after that point reaches macsec_insert_tx_tag()
with ops == NULL and oopses.

Check the pointer, as every other macsec_get_ops() caller already
does, and drop the frame through the existing cleanup path.

Fixes: a73d8779d61a ("net: macsec: introduce mdo_insert_tx_tag")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/macsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ee0e2eb7dbc6..86c8009dcfa9 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3436,6 +3436,11 @@ static struct sk_buff *macsec_insert_tx_tag(struct sk_buff *skb,
 	int err;
 
 	ops = macsec_get_ops(macsec, &ctx);
+	if (unlikely(!ops)) {
+		err = -EOPNOTSUPP;
+		goto cleanup;
+	}
+
 	skb_final_len = skb->len - ETH_HLEN + ops->needed_headroom +
 		ops->needed_tailroom;
 	if (unlikely(skb_final_len > macsec->real_dev->mtu)) {

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260805-macsec-fixes-d280baf70552

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


