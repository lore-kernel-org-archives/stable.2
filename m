Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336094;
	b=ukYTNxvVDqNcmvXyTRTS5OUIT9y/InfZKBjc6cMi4tgS1NuvT3rLq93OeG6N0C9Jg/IT
	 yoxLEEMHp1o09/yG1vUBPhxyyOdMKqQepxSepfHYo4apwFdkyi3/kr+r5nWtIsvAZgYro
	 PkOPMBu00JhRkPk0nbK5KDGPL5fwEQvQ2bHbCLaYWEAKXg58wcDOVCBus0Ujt2yvJFKKB
	 FrnaKWD85+zAmHlvUHu5C7reSsJqKMU9pZEYDwjD/2HAVi0pAaXgOghAvjbBkKYF/2n9l
	 85OOi1xL1QPP0IvnXFZ9Pd4bAvJkMvnnNdEkH8qOGAuvuCqUSQqjwc49IWxd0JDZucw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ky3MtLUzFYmlO1tnrVRhsOQoenG6X8953kGn4vc5xYs=;
	b=aQ686mirF+n0kO+mdaCXUigia/poLHVyWPwz+pGilzo1MtugQC9jT+pUwGNQQvX5CKcp
	 VdWRhyRe5WC5L5nn6ePg57b6hPHOdKGvR7OiYDFMCGKc8dfArLzvD0T2Ci+meDD4FSKdn
	 /im6EJn0XD9UyoZfBwfPmqZR06CxdGkZtkCljym0qCLu/2knudbrbb7DeKCY0s/pZSPQ4
	 nbxokRDK0MBEBSx6CEPLSeMue40sitWjWEU/arhyVL0/oraLskEyUVczhQiYe0ExZQzEm
	 +z1ByCqoqF2low6gTOpEBxuxORvRaoGs2IC4HD5uT8XzYTuRwWlHpAbWciqPijS/p9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3ChWxdK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439C606C6C0
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3ChWxdK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A291F0089F;
	Tue, 10 Nov 2026 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336093;
	bh=Ky3MtLUzFYmlO1tnrVRhsOQoenG6X8953kGn4vc5xYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3ChWxdK/AsJH6kFKJJS4a1yKVwif4YvqzDVasTMuOlaFXkJT5NSpUUJDXut2Rs9K
	 jwDTOssN6/VpmbNSjBgwOibCAV7232NQWyOzXufpwT7Sn30AyfCuITvcInfHly2JCa
	 fghA48aYPu7VIYNT7WkmyMXz4l4dyNnEii2h/smz0Ob0P9WIEZvkVuM8IDcLUqJ4a+
	 nTOuUq6EOWsZpT5Zz1cGbVATiAxkcpw7BCv7hDbphHvxRnOwPQsSLc6VnHFeeYvjV9
	 TjaXXiqoXDXKq3UzpZuWqnzVSR9ZE9WtK4/EcAoigI6XpS+Xn0tmZDLkWcjxdTxUVn
	 qaQvkKQijHngg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] serial: sc16is7xx: declare MCR and IER as volatile registers
Date: Tue, 10 Nov 2026 13:41:31 -0500
Message-ID: <20261110184002.3260682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060518-failed-5.15-1c41d09dcd07@kernel.org>
References: <20261107060518-failed-5.15-1c41d09dcd07@kernel.org>
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb ]

MCR register has the same address as XON1 register.
IER register has the same address as DLH register.

Which register is accessed depends on bits configuration in some
other registers.

To prevent potential access errors, declare MCR and IER as volatile
registers.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20261006192540.234402-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Retained reg >> SC16IS7XX_REG_SHIFT decoding instead of upstream's unshifted register switch. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e1bb025a700d1..c66798ef91ba9 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -467,7 +467,9 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg >> SC16IS7XX_REG_SHIFT) {
 	case SC16IS7XX_RHR_REG:
+	case SC16IS7XX_IER_REG: /* Shared address space with DLH */
 	case SC16IS7XX_IIR_REG:
+	case SC16IS7XX_MCR_REG: /* Shared address space with XON1 */
 	case SC16IS7XX_LSR_REG:
 	case SC16IS7XX_MSR_REG:
 	case SC16IS7XX_TXLVL_REG:
-- 
2.53.0

