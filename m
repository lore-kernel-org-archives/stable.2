Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492774;
	b=EVwqfnJplifftoWugTfkm/kTk2EpE+RsntVTIJWCQHml2fephL33FwJT0VPm5BsLpvrn
	 WZUQAr7bXzaAT8Sa61XX61rkwBJqq0euwxer9Qqd8L6mjrAFT0IQgqtXPsfJIjkmC3CsC
	 cq5l3kLPyqkdTksPQ/uWyCjJgDtC6JRUbenhGVd7LHryB9kenANw/fxh3DTzx1VKeWsu9
	 XahVIVtTaaa3rQHeohRvq8KELz4+RoCsfkXD/6oi+0Kb0b4pA0Pq55COT8kvR3ETTZCJr
	 3KbAhRNQep7TmFXFSR+XtkiVnwTo3RKD/p112T2rE4XWzl1ppewYqgm2FFqkgr+899Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492774;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=C33IcFxkCejtNL06E1fQzKXXWvVqitln+U/Dyb3IHY0=;
	b=Mdtnla/fNi0NWu7nFStvxEZ0KfOoXLOvFVAxUAQoAdrjl1pY5KvgV/ipsGF8mE/6A6DC
	 Wav1pYaEFWAghu2R4AxyjbNU0RdW4r9cY8w/TtYSHXm4/I2WnYgbn5qIE8/73KqwRlDwQ
	 CMPllcKBZvykON1HVLjPDYGuO/7/MBYuq3+PBzUIYfBM8vw41b8nG00/MNjFVWTX9aBGT
	 h9eGsXk0/hWczGj74lqDn9oFqb7bvv/PKb13bTNAKARz/OlmU2xE3gKOaCGUtP+fpZ7Zs
	 NUnHVA9BUTtCQCywTGDe8cnezpgYus1I9dFlPFamVN1KWcCoYlAQJ00vaEQKSoz//Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=TBk7U3hX;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F9606A33F;
	Thu, 12 Nov 2026 14:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D70F9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=TBk7U3hX
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jQMmG00mFz5B17f;
	Thu, 12 Nov 2026 22:12:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492766;
	bh=5AGiSFjrfxLpPQtCABfNmTgTRij8Rox0DcLnnsS33Cg=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=TBk7U3hXYhYY3xnN6uLkZ4S0SsC4L2YLU5gOMgZLyZMKFouZIE0ae94AwYgwSloZs
	 Blol6AJRg4m/O907hvMAGR7jMSPrJ/7hRn1VmY2RqKeB57JYV92BAnAWwCplggvhN6
	 RY9Uxk/fIeIX89TrYHurwKHmeAOTFRLyhRsoRtfS03IFnNDGAClkO+GTE9yIvkRrMl
	 4ArBXdizAUM7RZvi2WIglwlZV6xPJHRAh+iEi0Bzm/HdJ6PV/L3SMeL2dCmL52fNzV
	 aVZ7GbtbigbFyqBsEia1xwMIYm/jJwaeSHonHpMp0TYcIxx+libvSeIgMcpqKE0NbY
	 tjjoet9urJjrg==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6ACECgsc063423;
	Thu, 12 Nov 2026 22:12:42 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:12:45 +0800 (CST)
X-Zmail-TransId: 2afb6af5c95d1ce-e293e
X-Mailer: Zmail v1.0
Message-ID: <20261112221245617fVtCglossnmJqcYZwdF9-@zte.com.cn>
In-Reply-To: <20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn>
References: 20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn
Date: Thu, 12 Nov 2026 22:12:45 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDUvNV0gYXRhOiBhaGNpX3NlYXR0bGU6IHNlcmlhbGl6ZSBTR1BJTyByZWdpc3RlciB1cGRhdGVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ACECgsc063423
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 22:12:46 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C95D.000/4jQMmG00mFz5B17f

From: Shao Mingyin <shao.mingyin@zte.com.cn>

seattle_transmit_led_message() updates a controller-wide SGPIO
register before taking ap->lock. Concurrent LED updates for different
ports can therefore read the same register value and overwrite each
other's changes, leaving activity, locate or fault LEDs in the wrong
state. The lock currently protects only the saved LED state.

Take the shared host lock before reading the SGPIO register and hold
it through the write and the saved-state update, so that each update
preserves the other ports' LED bits.

Fixes: 535dac4ab5f4 ("ata: add AMD Seattle platform driver")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on next-20261105 in an x86-64 QEMU/KVM guest with KASAN and
lock checking. Two kernel threads on separate CPUs call the original
LED callback for synthetic libata ports verified to share the host
lock, using a RAM-backed SGPIO register and TEST-ONLY MMIO observers.
The observer waits only when unlocked, with IRQs enabled; it never
waits for another thread while holding the callback's spinlock.

In 1025 controlled update pairs, the unpatched kernel loses register
bits 897 times (including expected 0x900, actual 0x100); the patched
kernel loses none. Another 256 pairs with IRQ-disabled entry preserve
all updates after the fix. Saved PMP LED states and entry IRQ state
are correct in both kernels; 482 invalid-PMP calls return -EINVAL.
This tests callback synchronization, not Seattle hardware or LED I/O.

 drivers/ata/ahci_seattle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 9758fa0260..a398778ebf 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -92,6 +92,8 @@ static ssize_t seattle_transmit_led_message(struct ata_port *ap, u32 state,
 		return -EINVAL;
 	emp = &pp->em_priv[pmp];
 
+	spin_lock_irqsave(ap->lock, flags);
+
 	val = ioread32(plat_data->sgpio_ctrl);
 	if (state & ACTIVITY_MASK)
 		val |= 1 << ACTIVITY_BIT_POS((ap->port_no));
@@ -110,8 +112,6 @@ static ssize_t seattle_transmit_led_message(struct ata_port *ap, u32 state,
 
 	iowrite32(val, plat_data->sgpio_ctrl);
 
-	spin_lock_irqsave(ap->lock, flags);
-
 	/* save off new led state for port/slot */
 	emp->led_state = state;
