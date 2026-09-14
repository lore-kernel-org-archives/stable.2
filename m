Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56221B87C9;
	Mon, 14 Sep 2026 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344883; cv=none; b=Ni6aNhGob4lo9365owz8c+eCOdHfFXqBK0hKb2CkoEmkVaUQ0/gNeC5QqqzIype+dw9TFVqUiAiXsIqW0aAUloxXgbUtMNYdFnRjPR7pV95Rqs/ZtsJQ8ZNKS15Jhm42gHLcw0PelsVnFoe2JhRA5abNXsHsJwf1N5pkQfLyY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344883; c=relaxed/simple;
	bh=7MYsXecj403vmZji2uuSJ9nQ+SP7jO5uBWMCoAzrigw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lQtqS2Km+Oy80N26leXRqa7Yy3mLWtCMdc2XkTwn1rWcT/M/ENfYQNTToAgXnqqOCO4Vxb96qmFYA+Sowpi6Om+ZyN0UBMh2PTMjiuwO2T+iHKwVuxC4PWAZ61x1hLCYPsK4kCLH4Fhm8HYmBDv5MKxbJvseC4/i2JTwCmYMgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciXO6tSs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciXO6tSs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66C8DC2BCC7;
	Mon, 14 Sep 2026 00:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789344882;
	bh=7MYsXecj403vmZji2uuSJ9nQ+SP7jO5uBWMCoAzrigw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ciXO6tSsbKQPw/u6BpXfbnLOKUlMIwdA2976j8YUWH4Poz0nLB6eGEBncQHFDGls4
	 UfQroOl/in5ax8IsTIjjZANS9xfm8C8fAQQsaP8rNWnzNSWFGqibbV+bOCmzbpGKqn
	 WpX/sjOxvScGX43VtlJVgAwViMFV0CLM0NoD4ImhyGCr6416OuMVDrhtZ2dfX2c4dR
	 losO9AaDpU3Tk9gS1sCiCq/SRkziYU0QUB2tv3tl+3JFZIt+ls99Eb96qyJxrDP22I
	 ul9U5SuHn9FmocpRhBJtzQOTwZKoKeLvxeZ++5J07Z276IF4cP1Lm0yN3pPUqnXUcV
	 nT0/N15Kahgig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437E9C88E63;
	Mon, 14 Sep 2026 00:14:42 +0000 (UTC)
From: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>
Date: Sun, 13 Sep 2026 17:14:09 -0700
Subject: [PATCH net] net: lan743x: fix RX checksum use-after-free
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-b4-send-lan743x-uaf-v1-1-73d563d08ba9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBAAvyJ77kKM2pB+pXiIyWq3lG3Jqgji3
 03b4wzM7KCUmRRu1Q6ZVlZ+S4H6UkF8BJkIORUGa+zV+LrBoUUlSfgK4tpmwyWM6JNzJqQueuu
 hlJ9MI2+/6x2EZuj/UpfhSXH+/uA4Tkf7Y+R8AAAA
X-Change-ID: 20260913-b4-send-lan743x-uaf-9d770ad5c929
To: Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Mark Amirkan <markdamirkan@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789344881; l=2027;
 i=markdamirkan@gmail.com; s=pscsi-20260818; h=from:subject:message-id;
 bh=+D0VC0g8sC9iwdKy6+YMNFy+J0OscJTzNWqy5rMabrU=;
 b=LsFa/Ck+61ygVbvn3cK3h7HmOLhrEcg+D1fG//LEQbKWreZCnKj8nO8wxZYj6UsX6xLSNuUTz
 HlkaZh5ytQCBUyPHtykaIktIuqlK9S1/z7BTq753h2gi8y86RwMgmTY
X-Developer-Key: i=markdamirkan@gmail.com; a=ed25519;
 pk=/wb49ibt4gZFDncmhFQBYtjPvzT1tfJtvK4Mqt1P2Wc=
X-Endpoint-Received: by B4 Relay for markdamirkan@gmail.com/pscsi-20260818
 with auth_id=961
X-Original-From: Mark Amirkan <markdamirkan@gmail.com>
Reply-To: markdamirkan@gmail.com

From: Mark Amirkan <markdamirkan@gmail.com>

lan743x_rx_process_buffer() adds each non-first receive buffer to the
head skb's frag_list.  On the last descriptor, lan743x_rx_trim_skb()
linearizes the head and frees the fragment skb metadata.

The checksum-success path then writes ip_summed through the local skb
pointer, which still points to the final fragment.  This causes a
use-after-free write when a packet spans more than one receive buffer.

Set ip_summed on the surviving head skb instead.  Multi-buffer receive
can occur after a live MTU increase because existing ring entries keep
their old buffer size until they are replenished.

A KUnit test invoking lan743x_rx_process_buffer() with a two-buffer
packet produced a one-byte KASAN use-after-free write before this change.
The same test passed after the change.  The driver object also builds
with W=1.  This was not tested on physical LAN743x hardware.

Fixes: cd6910501cfd ("net: lan743x: Add support for Rx IP & TCP checksum offload")
Cc: stable@vger.kernel.org
Assisted-by: LLM Symbolic
Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 24ae56a3c9ed7..82d3ec20ba259 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2604,7 +2604,7 @@ static int lan743x_rx_process_buffer(struct lan743x_rx *rx)
 							rx->adapter->netdev);
 		if (rx->adapter->netdev->features & NETIF_F_RXCSUM) {
 			if (!is_ice && !is_tce && !is_icsm)
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
+				rx->skb_head->ip_summed = CHECKSUM_UNNECESSARY;
 		}
 		netdev_dbg(netdev, "sending %d byte frame to OS",
 			   rx->skb_head->len);

---
base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
change-id: 20260913-b4-send-lan743x-uaf-9d770ad5c929

Best regards,
--  
Mark Amirkan <markdamirkan@gmail.com>


