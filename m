Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794414147;
	b=HrUqHqK3BN8Dxq+CjO/X8ps1tl3SFYA//qRBBg6L9bHQJDsawYR3hmkjKHVCoH4DfI3I
	 MqUhYCAWNL7X/JIksabnucJi80sFCB3YAcGn1qm29+ryStuqKbmBaCY7etc09zgegrmg/
	 nZ82sAgeJ9yvi+4cZ0tslihFLSSdGKZ6JNGCktsYfBY+HBXbZh000Yxuhj3z/Up754J2u
	 nMV8HXGX0dbOIu94M26CD7nfsc1GGPGOVIzu7Qu/WYQnSfA0zIkBNayWh2n1qJfZb2+fj
	 ocRY0aSCAx4HGRILJ5sYJCLKtZuTqZXFRvsdb2YB8tC25pyv1Vrc3Yu+BZLN9i9rhWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414147;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=q8mOpRnf+Di73N3yU2eDEU0GPveFfttiuju/Wh/wS8w=;
	b=pqI7wPpVJxSsaru6iQzV3+EXLTqw5a+wN4De7yH7Zr8yEtxgp+/Z9Av6mt8m93eu4Gi7
	 Zh5LlN59c3/eWU0F1pi3Ywwa+NXyHZqn6jXADUC+pvO26G4KD15l1VB44MZ5HVwAWWdUX
	 imgjZqgUpamT2g20aa57Rd6xHZjfFYtglL51CqlAmR+jQBNZV7VCHsyBdfBsLMiT1pgyK
	 OfFnxr2GRNOt4RJX+crIq+LM9f0TV5gKuDChjhpEdlsfyRmp6+/OQN35LTcONvO8oZfyI
	 eaAon/WUGsWRvHnHBQCsZUnk7R0vNIHAIC0rRP1JNSSEEaEpTvNqRW6QkpEcIyjjdbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HukQX5kZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A31E606A32A;
	Wed, 11 Nov 2026 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HukQX5kZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794414147;
	b=wYwlAyyARqfvEsVdiqYU2G+yd4Ntvwv/6F9gGI/la3liVvhwTEf3GveWBOJVvNn46x7g
	 g544yRo1rkI4KKclBkvSRWzL8DQer8rKo7KIPgr4Ojpf3gS04OtiTfQwNp1a/+XR//6r1
	 g+DhJ+5BXuxdhLQiASekkq3B6OFtv3orwvvbo3Oz4kK1EXDOLJE3S/xB3gDfuSfNh1GgX
	 05m3Z5s0LLn+oS8kfyJ9a0PVgNeWAh2cV1CL5LEyDOGsgPik/+mBnwv4wD32e513JVM7K
	 DbLQ2WtBf6ntR5cJqFSsLxZkaqA3J2tl8xa9e9TeGfAknjSy4i/RSWurCT8Gn5tTAWg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794414147;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=q8mOpRnf+Di73N3yU2eDEU0GPveFfttiuju/Wh/wS8w=;
	b=wO5LFu6haaOahJAHlJAHjn1vQSKYcXNOTySl4kemQaLFzt4KV0Jr/p4u6qIvN3oixRll
	 3EK0vkO+X2RVvprvsPUZi+SlnPSxr3nvM+z85BZfN4TnvwOhaNs1raybY5gYkp5dN6z75
	 Jkez4A8uHZIkIfi8EFl9H5xWTg/ptmfPJMGlNTqiC7/QIQBbVATJ7w843bkZ9DDdNgfVT
	 Uvyf+C353qjt4RAYlWqkIdyaj8XQSsjE1oVrWLLc3YOS0kpy2K/x6CWF+vJA9PvarbdVD
	 NypQnptO0hpOEExRRwGT9dzSoTYlEgbrdAedNj5+5F1Mcz/86l+zOaDfoDYv5BZkxkQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9E1411F00A05;
	Wed, 11 Nov 2026 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414147;
	bh=q8mOpRnf+Di73N3yU2eDEU0GPveFfttiuju/Wh/wS8w=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=HukQX5kZVzKv62Uw4vbqoKlv+mT0ZtoCTZW8Mrn9LU+fuONL2rgbvXY+KS8Fjp672
	 hpvtNVPyAEc5XeMiGtHdM4O9pWk/e2mm/Uf4vUJNum0/Qiav8YOJ8vQZ+ze3ln1gO/
	 YrrdnzvAkj+61G1WDjk/w02FLqq4MpcMV9ddecgJ7/E4JraZPC16t6X8ySszwjG5MD
	 Z2BgOYi+uKohTM79INMyYGTwnkjBndmqujq8PdWIfRtJEHomb8wcKg+dlfwge+wc59
	 xLsEYrT0ZRT0jreXOcucvqbXgAQtmfKwJLtYe3fYopliWXFWn/lSfA8REYNVVZr+Ut
	 bq74+OqcPdPhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F269749025;
	Wed, 11 Nov 2026 16:22:25 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 16:22:26 +0000
Subject: [PATCH net v2] net: usb: smsc75xx: reject frames without a full
 header and FCS
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
Message-Id: <20261111-smsc75xx-rx-fcs-v2-1-216a5f26842a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEGW9GoC/3WNvQ7CMBCDX6W6maBeKCUw8R6oQ0ku7Un0R7kqC
 qr67kTZGTx8tmzvIBSYBB7VDoEiCy9zBn2qwI79PJBilxl0rVtErJVMYm/XlFRIylvJ6u+tcR6
 dJcitNZDnVBZfMNMGXTZHlm0J3/ISsUR/ByMqVA3VjXl7q42/PIep58/ZLhN0x3H8AOCp+x+zA
 AAA
To: steve.glendinning@shawell.net, andrew+netdev@lunn.ch, 
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
 pabeni@redhat.com, joasantonio108@gmail.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794414145; l=3049;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=UakfyXge5Z7dCorT5L2tCidbQJeCZJFs6IXcWJSAcH0=;
 b=X3LdGQ0gmxyYqtbCxoFYV/DavCK6B5PoaonNbH+/qj6xL6UcK7taMtAk6ZVCvgO6LnrJkQk1K
 DShzMr0btrABu3f+q47WR8v7Vh5Qo+iUn+I5TZWfi4bCr6YBhITayeo
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

smsc75xx_rx_fixup() takes the frame length from the RX command word
supplied by the device and strips the FCS by using "size - 4" for the
allocation, skb_put() and memcpy() of each frame that is not the last
one in the URB.  The length is only checked against an upper bound and
against skb->len, so a device can report a length field of 2..5, which
gives a size of 0..3 after RXW_PADDING is subtracted.

size is a u32, so "size - 4" then wraps to 0xfffffffc..0xffffffff.
__netdev_alloc_skb() adds NET_SKB_PAD to the unsigned length, which
wraps back to a small value and the allocation succeeds.  skb_put()
adds the length to the 32-bit skb->tail and skb->len, which also wrap,
so the skb_over_panic() check does not fire.  The following memcpy()
then tries to copy almost 4 GiB from the URB buffer into that small
allocation and writes far beyond it.

A malicious or malfunctioning USB device can use this to corrupt
kernel memory or crash the machine.

A frame that holds an FCS but less than an Ethernet header is not
valid either.  usbnet drops it when it is the last frame in the URB,
but the other frames go straight to usbnet_skb_return(), where
eth_type_trans() reads an Ethernet header that was never copied into
the new skb.

Reject frames that are too short to hold an Ethernet header and an
FCS, which covers both cases with one check.

Found by LLM-assisted source review.

Fixes: 1b3b2d9e772b ("net: usb: smsc75xx: stop lying about skb->truesize")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
This issue was found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fix myself.  It is build-tested only (W=1, arm64); I do
not have the hardware to test it at runtime.
---
Changes in v2:
- Also reject frames too short for an Ethernet header, combined with
  the FCS check into a single test (review feedback on v1).
- Subject changed accordingly; it was "net: usb: smsc75xx: reject
  frames shorter than the FCS".
- Link to v1: https://lore.kernel.org/r/20261110-smsc75xx-rx-fcs-v1-1-4e048bfc28f3@gmail.com
---
 drivers/net/usb/smsc75xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 6f72a3f15907..893de273adef 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -2217,6 +2217,13 @@ static int smsc75xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				return 0;
 			}
 
+			if (unlikely(size < ETH_HLEN + ETH_FCS_LEN)) {
+				netif_dbg(dev, rx_err, dev->net,
+					  "size err rx_cmd_a=0x%08x\n",
+					  rx_cmd_a);
+				return 0;
+			}
+
 			/* last frame in this batch */
 			if (skb->len == size) {
 				smsc75xx_rx_csum_offload(dev, skb, rx_cmd_a,

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-smsc75xx-rx-fcs-fca968df1dce

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


