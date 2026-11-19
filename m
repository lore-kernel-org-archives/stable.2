Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058674;
	b=HofZEZVxsMKcMnnWgmDfTIpU3hZ/tTdWPjf/iPMdEzlJXsrnIbcmh2/xjz4YIyp0Fj/M
	 fq8oBFbOO9zMZfxQ64MRsy1KNO9xh6sxHUO5r8oRJdK7nmUThk4VkEp6Urc7u0d9TYLss
	 QKFJtKGwuh+z95A6d/rFCi5YlYMFgAAlhaH7zOLGbMpUPUFCpcqvPn1/t/+iIpTdkkNKc
	 e0GBR+7RcI0Y1IJsNcMBPf4vEiVCwHuqn9U1tNSfYlQq+SRhiuzYBUAvY6f6EolRrgDPl
	 yJ5Xf/3ybdHX0xWb9HSrJaBkWORc9+lJUeoPD4hwNEfOlUopqmV14OOgDBdYWdkjkuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058674;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=slaT4gB0sfm7HwuWnPBOjBdhg+gcCdsY7+bBkis98RE=;
	b=ZuSRFXr5kem/91aGtxEd99oFR/xFSNN8xPZlcHxYe7J0rtU2Hgp+NHVBuK2C4rVyFguw
	 ye8HuATgAjPqsG0AJfv3eMc+fDREJYkImbieqc2a8ei97gw6C+0Shw/lte4HaHpUThQAf
	 P7z1KfWuEn5MOkF1VwYoAKjzHMlTqhUYvxNwITedQW+jZDAi9yCBw2XtVFpMkF+0ydpDh
	 hlJWVHGHbse8Qj3XkKWXJ8u8TkhG/g6N6liXqnlCY+qe+m14i9OA6gWZbomLXPHe0xTCu
	 A+9SDxpWwnveql3uDqu/Kd968tqeJ5H30sgcpqif6BiZ50i4WrVH64OmgJ1yR5ZZP/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6PW2uZg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7D606A31C;
	Thu, 19 Nov 2026 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6PW2uZg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09341F000C6;
	Thu, 19 Nov 2026 03:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795058674;
	bh=slaT4gB0sfm7HwuWnPBOjBdhg+gcCdsY7+bBkis98RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g6PW2uZg+N5gEdDe7OJQpYHJZEjUhrRRW9jfek39q35knvQHTMaVtYMZTq2FJVuW/
	 NDQA+zb9yvdMG2M3ApjKq5cNHg+ORjjf71unpTyOyTpNRttuNIRcQ/o1/o839+3U6Q
	 UTVu0qpciAvMEqn8xLn/tl2FROTiyRhwZbrjkrfHnjWUFlMOIXRgjYI/KviiSzyyGK
	 ZeSvjbhGuhH7swccd86CUWsT36HdgBVhJYFqpRHMwiqXg3Su/n1glhk3Gc4akpM2Yy
	 LBP+gdFhdzd4znf4jt46IWqhBnY1FBEyurD+grJHGbS0l+o2mP5H7febTgBOApeoRJ
	 aBuI1GMt6wJ3g==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>,
	linux-bluetooth@vger.kernel.org,
	tfiga@chromium.org,
	tzungbi@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: btrtl: Return -ENOMEM if bt_skb_alloc() fails
Date: Thu, 19 Nov 2026 03:24:15 +0000
Message-ID: <20261119032415.4010732-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119032415.4010732-1-tzungbi@kernel.org>
References: <20261119032415.4010732-1-tzungbi@kernel.org>
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

If bt_skb_alloc() fails in btrtl_initialize(), it jumps to `err_free`
without updating `ret` (which is 0 from earlier calls).  As a result, it
returns ERR_PTR(0) (NULL) to its caller, leading to a NULL pointer
dereference in btrtl_download_firmware().

Set `ret` to `-ENOMEM` before jumping to `err_free`.

Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
Cc: stable@vger.kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- No changes.

v1: https://lore.kernel.org/all/20261027072148.3963826-3-tzungbi@kernel.org
---
 drivers/bluetooth/btrtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d2c2e79800fc..35a2c9d3380c 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1143,8 +1143,10 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 
 	if (btrtl_dev->drop_fw) {
 		skb = bt_skb_alloc(sizeof(*cmd), GFP_KERNEL);
-		if (!skb)
+		if (!skb) {
+			ret = -ENOMEM;
 			goto err_free;
+		}
 
 		cmd = skb_put(skb, HCI_COMMAND_HDR_SIZE);
 		cmd->opcode = cpu_to_le16(0xfc66);
-- 
2.56.1.708.g77570a6a1d-goog

