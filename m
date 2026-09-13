Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7F33BBAF;
	Sun, 13 Sep 2026 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331314; cv=none; b=AA4QtFxeMzij/msA+zDr7Q58Ve1OuJBOIDbHFeqRA/Txj958tFGSZRGLCuTSN84HUnO6Q2fPWspbC+0KBh9PvRCKwto2ECpRVPoNRPqSxXSki6MI+va2NII3H2SF4Advo4Cv6tgbSwj2+SMwnv7M05mg1hb8vHYtZVAZ2GdN+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331314; c=relaxed/simple;
	bh=bw7og3oUzy8UHTf3vFmCgYQlEDF78JSx4jQrcmwEZQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B616KfWkLcyEGsZQ39S7H7sCfUzlaDtKHOAOMbirImqA1rIXT2s6WX1Mzk3uzMznstNRSL/Vln8/f1YBF13RJl6OrAsNuFk/+yW2xMS8A+OnZ7pCwYNL33nAIfF25ar7qEcLuFBGxfMz+q9SrFwvoDk3YNvTECTM1hIrt+k/ACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=LA5L07vX; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="LA5L07vX"
Received: from email.seznam.cz
	by smtpc-mxb-7c4f5d49cf-t2kxx
	(smtpc-mxb-7c4f5d49cf-t2kxx [2a02:598:128:8a00::1000:90d])
	id 35f69b2583cc363c3079816d;
	Sun, 13 Sep 2026 22:28:09 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1789331289;
	bh=1pKsv0RnQ3KYdaC4eeqV4HCeBs4zRaYdQNenxWAwM7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=LA5L07vXbvDzJbvVNf4tqEf75Yyq6D6/RyEJxgj2/4sqXV/Eos9ye/ll4rIRIe39k
	 pRdAfdBu3ERThB9j/9jZYyZSQecUrAoTJ3dgZ7v+FYB2VEgyUdGsCFY/Blkj+vclSw
	 8QtvJwS46vqJBl26lYtIAMGV5OhFHx2p/Uii8498pDNvSqCs58etAR5ZRr4pE43mc9
	 mQrkoFLjPYTaeGlMpRd38MFJteLb/xOTrbWcFk4L43clyLMrkvSFvEpXDZ1Axb+BDv
	 EJGXjaMhd67pfz74HfftgRHjS1v5gNDPAswqqAbndNIP3QhzV8Yy4A9mcUZGbTTSzq
	 OkhEbaPBohcPA==
Received: from [192.168.31.51] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-5d885666ff-tvljn (szn-email-smtpd/2.0.83) with ESMTPA
	id 7fa8645d-c269-4122-87d2-b863a06ea0d1;
	Sun, 13 Sep 2026 22:28:03 +0200
From: Radek Podgorny <radek@podgorny.cz>
Date: Sun, 13 Sep 2026 22:28:02 +0200
Subject: [PATCH v2] Bluetooth: keep dst_type with dst when reusing an LE
 connection
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-for-upstream-le-conn-reuse-dst-type-v2-1-ed1d5dd4ae37@podgorny.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw6CQBBEr0J6bUcYEwJexbiYTyNjZCDdPQZDu
 LuDLl+l6tUGQhxJ4FptwPSOEudUwJwq8KNND8IYCoOpTVv3TYPDzJgXUSY74YvQzykhUxbCIIr
 6WQiHi+ubNnS+6wMU08I0xPX3crv/WbJ7ktdDfTScLXvHNvnxiJxiolXPkxUlhn3/AjCVwzmoA
 AAA
X-Change-ID: 20260911-for-upstream-le-conn-reuse-dst-type-f3b916d8c89d
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

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
Changes in v2:
 - no functional change: the diff is byte for byte the one sent in v1
 - reindent the two quoted lines of code in the commit message with
   spaces instead of tabs, so gitlint stops failing the patch on B3
   (hard tab characters). That was the only red check on v1 that was
   not one of the two known flaky testers
 - rebase onto bt-next/master, which now carries the "dial the address
   the peer is actually on air with" series. That series changed which
   address __hci_conn_add() stores for a new connection; it did not
   touch the reuse path in hci_connect_le(), which still copies
   conn->dst without conn->dst_type, so this fix is still needed and
   applies unchanged
 - per Documentation/process/generated-content.rst: developed with the
   Claude coding assistant (model as in the Assisted-by trailer). The
   prompts described the misdirected create-connection and the btmon
   captures taken before and after, and asked where dst_type is set on
   each of the two paths through hci_connect_le(). The measurement on
   real hardware, the analysis and the review are the human author's

v1: https://lore.kernel.org/linux-bluetooth/20260908012048.3681904-1-radek@podgorny.cz/
---
 net/bluetooth/hci_conn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c9466cb2c7c0..fa72cf8aaa7a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1518,7 +1518,15 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
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

---
base-commit: e40edfa049b967f0b9379bf549c59431302ad181
change-id: 20260911-for-upstream-le-conn-reuse-dst-type-f3b916d8c89d

-- 
Radek Podgorny <radek@podgorny.cz>

