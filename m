Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759054D8DAD;
	Thu,  3 Sep 2026 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448904; cv=none; b=X/d3r1yco94y2tLf9OLvdLuDnRnduolrcHke7F+FZKv1Gy5V2wlSfA8F3DO3YszhpHZgW+RxecHYJ5Z6fgLEQ0F3fXOYPJ+GnufIEY9V+W/RnL8BoHB+79z1kIe8l4wuet+/iaA5Awi6JO2odnAMzri0oeBqHtEWOeyNeT2+vFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448904; c=relaxed/simple;
	bh=nRTYXO+CiccuUTUk2c7qbiCnWkPrZRtzyZnhjjtQ0lQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MXc30WUnmDa8lfb0av/yoEyIOBzA+YJOT8T/VKUBnGWpjSmD9AAScpzkcsJD4drAfHO9xWeorn7naUWvZC31TwY/k5ftUczmTj5p+88oV9wKz0Pi7H4B3x7Zs5rlHgPdyhuTLe1Kjpwh/X74OJMOJxr8UUwSj2xnGPjosTjLdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM9LNJhq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM9LNJhq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03871C2BCB8;
	Thu,  3 Sep 2026 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788448904;
	bh=nRTYXO+CiccuUTUk2c7qbiCnWkPrZRtzyZnhjjtQ0lQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TM9LNJhqh63TPLqxn9QelRqtpLUMOMMtPCO6KDOhbxZR8QLdLjQrFTzsWMXeIwjlr
	 sAjxEY5WygijwxKZA79JsITT84njLuhqKLrihYMwC4bwyFYxWw1CpmA/4SMdI0xv/V
	 49uKhVOdKH2VAUk886fPRRp1iYDB0ppzfsCqXjscCFD69j3dQxIx2ie54qPWinm2l3
	 6Md+fPWhqkuWoWcpfAAmgUX1JkuJMBJVJW4zQ1HU+OCU+Me1yrnN+Aae2cZqX95aad
	 mGhACj4uKWPrecB4uuhBhU/8vyHbL/w5pqn4K6laW6oTZVT7fgXUxk1EmhLqyCj2pb
	 1RfFqoISDHLbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E243FC624A4;
	Thu,  3 Sep 2026 15:21:43 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 0/2] wcd934x fixes
Date: Thu, 03 Sep 2026 17:21:41 +0200
Message-Id: <20260903-wcd-dma-v3-0-d3920c6563c4@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNyw6CMBQFf4V0bU0fgK0r/8O4gPZWroliWqwo4
 d9tcYGJy0nOzJlIAI8QyL6YiIeIAftbArkpiOma2xko2sREMFEzJSR9GkvttaGtrQUHkFqpHUn
 ruweH41I6nr4cHu0FzJD1vOgwDL1/LVeR591/NXLKqa6gLBvJK2PcAUcctuZNcjOK1dLsxxLJ4
 kob56qaNUKt1jzPH8as9wLkAAAA
X-Change-ID: 20260823-wcd-dma-bd621ee39887
To: Lee Jones <lee@kernel.org>, Thomas Tai <thomas.tai@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=nRTYXO+CiccuUTUk2c7qbiCnWkPrZRtzyZnhjjtQ0lQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqmZCG3KXrAunwVO0uDPNrVIgmhb6EIr46J/1lS
 hhjh/PS4C6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCapmQhgAKCRBgAj/E00kg
 cq25EADD6cqCfFx+SY9+V8JFxnvfgpMuKQcpqH0ptsE2wSEqx10jK6ZaFLrJ9JhV0dUG+A5b0lK
 BDKomYmY1qf7TC40wL4Oj0kbPbuRdXuxW+/Ddk+0HEU9e/GTrwxMbk6rk7ji42ZnF7rZoJWhOQH
 QM/tOa1GI75lYWV5Oi60EuGOhztTTtX0AO4FGftwAfAd6kTgUk3mA4gQv/aQdc3GC8y7TiZhfYU
 7cbFOkUD8gBNJeQl8ehg2ycxhvNo7pzLmxfYuSvLcq7Jk71b9qUPJh3RtfoAHpSvjgpSzJH5pA1
 U2R3fd4Hr1Sv06xSZbucCwLMnjuTEIlzB63hlnrE1bl2vfdGY7Q1ImUemXLieygIkiRdsLrCN2r
 oTw8+4pA8mgVdQe7w2bjIb7zA6aE8k9BuNQCLYDUlAnevg79K0AoEE1aUzxPCSSUUhpZG/XFpAd
 0FEMwwUlFnQ9I+r0qethICNWmB9+HGsTzPTmiYpYG7TpQ+rWZtwRIoOxOONcdG6IhVzKhnx4foK
 WLe3GQt6VjBIypOFZZtQog27mhl1VVKKiTg6lP8GpVXsXSCv1SL4kipy3i4AjKqOj8kgFqm03Le
 WgbEXhCJcbeILhgSceELzSM1KilyVPdKRoI+jKhdiw8ZkFSLuIOcVjFYVgzrHqd9wU9hylxF4UC
 e9pgA+WqtUhfMTQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

$subj

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Capitalize commit names. (Sashiko)
- Add commit addressing the NULL deref when of_irq_get fails. (Sashiko)
- Link to v2: https://patch.msgid.link/20260903-wcd-dma-v2-1-189cff560a28@ixit.cz

Changes in v2:
- Use dma_coerce_mask_and_coherent. (Lee)
- Link to v1: https://patch.msgid.link/20260823-wcd-dma-v1-1-95e44a315ccf@ixit.cz

---
David Heidelberg (2):
      mfd: wcd934x: Fix NULL pointer dereference on IRQ probe deferral
      mfd: wcd934x: Set DMA mask on parent to silence "DMA mask not set"

 drivers/mfd/wcd934x.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260823-wcd-dma-bd621ee39887

Best regards,
--  
David Heidelberg <david@ixit.cz>


