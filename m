Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAC3BED30;
	Mon,  7 Sep 2026 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823456; cv=none; b=ejDISmyOqMxqiFlF31fFEll9vwoRbDk8ZDAWAKLwl7ltoyXuMah3aIhWbVvlxu+qfQjuAYr29NuxPrBkjoLVYijEAbxKzzGNiJPSE7/lvbv8sxQfi9bUjUjEKhPXylTvCtrD6uVFI8gOTXmpHrdG3uDbSVhhu+0SS1J/A3AdP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823456; c=relaxed/simple;
	bh=uJxdDYpjMjLiy7DGLx8WKhHbO+tTwA99bwDNo8xKvnw=;
	h=From:Subject:To:Cc:Date:Message-ID:MIME-Version; b=D2Jjt8sJbmGJ3iotRMwGy2nxTH9rirYOs/ZcfRNy+f8SWdlvWGMS5ODwMsRqwe1j8zYOf5xllSpyyWOZq7EG/0GaaRG5whSHi66Zr926KtxbwiCR6Mf+afJ1l7hQnsMmzcVk06m/hH4qW3PZf1wrmUnu3Xbe0i9rNo8iaNythck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=dg83q89g; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="dg83q89g"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-9qx89
	(smtpc-mxb-7db765f675-9qx89 [2a02:598:128:8a00::1000:909])
	id 54514408e26be91151de5e40;
	Tue, 08 Sep 2026 01:24:11 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788823451;
	bh=EhwWjK8OcoT2zS+bgHTI0bwgl/A5Tru58VFidZFYCDE=;
	h=From:Subject:To:Cc:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=dg83q89grJs+INkpUSVsLfFxIDypfp9vHGrKBERTK2zAp6/U96tQy2FTIF8KQPNN2
	 OIM4rUqBUPBQf3KeQru9wwWlNwbTwbOsG6dcWIV/qpRKvNQ5sRh8Yz6v6V4hL4pORm
	 xzJCh8a8OhVcN7dagexrMX+7gONaB5MNr7c9MOFdnL7RzOa4/W33eSgabEfc9h1r6/
	 1NOJeQ5ZGqT5aBABlqyYDjJ0XxNVTcQnii0HBJzu803oi6owZ7l0Z1r1rs/xu7OqgQ
	 tGKdbMd6Dk4pjroeNQPNmofhmWPdaTj1cXeZyEeZymJzr/+XtTWdh2PzxF7dSTRBir
	 +0rlSPz1WgQ4A==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-57659868b8-2vb45 (szn-email-smtpd/2.0.82) with ESMTPA
	id e6eb8d03-cd42-4b60-b7e8-932567b5d2db;
	Tue, 08 Sep 2026 01:20:49 +0200
From: Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH] Bluetooth: keep dst_type with dst when reusing an LE
 connection
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radek Podgorny <radek@podgorny.cz>,
	stable@vger.kernel.org
Date: Tue, 08 Sep 2026 01:20:48 +0200
Message-ID: <20260908012048.3681904-1-radek@podgorny.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailer: python-smtplib (git format-patch body verbatim)

hci_connect_le() swaps the caller's identity address for the peer's
cached RPA when one is known, and stamps the matching
ADDR_LE_DEV_RANDOM on the local dst_type. On the conn-reuse path only
the address is copied into the connection:

	if (conn) {
		bacpy(&conn->dst, dst);

so conn->dst ends up holding an RPA while conn->dst_type still names the
identity it was resolved from, and hci_le_create_conn_sync() puts that
pair on air unchanged. An RPA declared as a public address is not
something any peer can answer.

Measured on a CYW43438 against a peer advertising an RPA the host holds
the IRK for, connecting to the identity address over a raw L2CAP socket.
The first attempt creates the connection, the second takes the reuse
path:

  LE Create Connection  3C:78:95:78:37:C3  type public
  LE Create Connection  5B:75:A2:26:D6:18  type public
  LE Connection Complete: Unknown Connection Identifier (0x02)

The second address is the peer's RPA. btmon annotates it with an OUI
lookup rather than "(Resolvable)" precisely because the command declares
it public; the same bit pattern annotates as resolvable once the type is
right.

The mistyped pair is also why nothing downstream repairs it.
hci_bdaddr_is_rpa() tests the type before the address, so an RPA carrying
a public type is not recognised as one, and hci_find_irk_by_addr() then
searches for an identity address that does not match it either.

Copy the type along with the address.

The assignment used to be unconditional just below this block and covered
both paths; it moved into hci_conn_add_unset(), which the reuse path does
not go through.

Cc: stable@vger.kernel.org
Fixes: 14b06c3a88f7 ("Bluetooth: HCI: Always use the identity address when initializing a connection")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 net/bluetooth/hci_conn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8de98af2fb58..5fcd85a00de8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1505,7 +1505,15 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	if (conn) {
+		/* dst may just have been swapped for the peer's RPA above, and
+		 * dst_type describes dst -- it has to travel with it. Leaving
+		 * the identity type behind makes the pair describe a peer that
+		 * does not exist, and nothing downstream repairs it:
+		 * hci_bdaddr_is_rpa() tests the type before the address, so
+		 * the RPA is never treated as one.
+		 */
 		bacpy(&conn->dst, dst);
+		conn->dst_type = dst_type;
 	} else {
 		conn = hci_conn_add_unset(hdev, LE_LINK, dst, dst_type, role);
 		if (IS_ERR(conn))

base-commit: 755cf7adf8dd2d12627cb7de223d35b12228e2f5
-- 
2.55.0

