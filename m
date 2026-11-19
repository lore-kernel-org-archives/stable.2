Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058671;
	b=evY/s2bDAeIteUuTVBz7T3C0fom/Xzn99PaxbEmfGmMcSNplBayEHvO7nC4h4EzGp0q/
	 zEg5xiy4tNi1sZ1SR5ms8IT0cDkf4QE/p0ZXSuBxJbw03+LUkBF1BYmtFih0Ci9IUnNYo
	 pIW4X6pMOvDnOqQ4z0I/BNJwqR1u7zX2zPBgNMjuqHTxsyBIWFtkDpuvY0armqIHgeLip
	 4KXBjCht0owtseoI45SIVevn4pPH7Xpw5ZQ5OCyMHhOlkpUf6QsCtaQqQSXTrxNvp26IO
	 EhU1oeHREZRrnSoRZqKL4pJmok3664dP8P1h7vo9i3vxwDpVSPkYufMCqIux1YOC5IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2mNhyDwaMEGACBvpDWF4KwkXEBz6yoE9mrW9eR2FURg=;
	b=QzTPuIxDhgw2gd8buw685jfPVtIy42WL8kwkDGD5vmQSzbtjEn1LCzPPag1cNsj7oGRA
	 R0EGX+viaddWmPBCvDEXWah6JBh+rofKiz2MoCh5rE2M6cdhbCyUz94jxZPYsd2C1zKR3
	 tWoxPPLwChAetVzgRkNKHDPIOsDjAizfND7dvB1abMRv1G5Mk4VwhimrtjM7E9PNnjWdc
	 H06RoYkC1LbDyBcwTtgiYU0SNRMiZI4+aDzBbPf1fmEaa6pKoC2sj6LJd+6tcocSBujUu
	 wLQA2Se8muXwclFwVCRDOumHAhmWXyabHZ/Xu6gHJW3IewDOnMZf6VSoSByhLC+oPlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbw73cNX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16746606A31C;
	Thu, 19 Nov 2026 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbw73cNX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A581F000C4;
	Thu, 19 Nov 2026 03:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795058670;
	bh=2mNhyDwaMEGACBvpDWF4KwkXEBz6yoE9mrW9eR2FURg=;
	h=From:To:Cc:Subject:Date;
	b=Hbw73cNX36irobOwFDZ2EZSvU1HIR56UiZMJpjTT7rtnU1tZWUL6wWTu825CTEmdV
	 ZPKWm4NE9sorzDawFoVwlOszPFG46A97c8x+f8Jw2tQ0jch23yIUGOUaW+jGC0KHtj
	 rWXjmXviaspgmVuDdeQ1bb/r5z01ggjlvn/4/DLScTZ3cpYGt4wJpLE5Yy+kf3hjAb
	 dbNHWNW2GN3rx6q3Qlp0Yt8Bd/P26k2PZeOXgjaytJOzaNoPvIgA45YRjkCBzTcI4b
	 H6Gjz2+Q+uX3GQJ7ZAFHpktvMzvVRZQ8ddB4kCbF9xUi3yrQcRcoSgfOLIENlAQVb6
	 zLOwMx82/+lvw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>,
	linux-bluetooth@vger.kernel.org,
	tfiga@chromium.org,
	tzungbi@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: btrtl: Fix NULL return on errors in btrtl_initialize()
Date: Thu, 19 Nov 2026 03:24:13 +0000
Message-ID: <20261119032415.4010732-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
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

In btrtl_initialize(), the `err_free` error path frees `btrtl_dev` and
returns `ERR_PTR(ret)`.  Because earlier calls in btrtl_initialize() set
`ret` to 0 on success, any subsequent failure path that jumps to
`err_free` without setting `ret` to a negative error code causes
btrtl_initialize() to return `ERR_PTR(0)` (`NULL`).

Since the caller btrtl_setup_realtek() only checks `IS_ERR(btrtl_dev)`,
a `NULL` return bypasses the error check and causes a NULL pointer
dereference in btrtl_download_firmware().

- Patch 1 fixes a NULL pointer dereference observed when
  btrtl_vendor_read_reg16() fails.
- Patch 2 fixes a similar issue found by inspection when bt_skb_alloc()
  fails.

---
v2:
- Rebase to next-20261118.

v1: https://lore.kernel.org/all/20261027072148.3963826-1-tzungbi@kernel.org

Tzung-Bi Shih (2):
  Bluetooth: btrtl: Propagate errors if btrtl_vendor_read_reg16() fails
  Bluetooth: btrtl: Return -ENOMEM if bt_skb_alloc() fails

 drivers/bluetooth/btrtl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.56.1.708.g77570a6a1d-goog

