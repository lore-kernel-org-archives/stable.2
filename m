Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593007;
	b=pR9Rm2MgBJRfUXoDKaD7zxYv1OO59sMgI9APDVgt45SzHwEeIsCOgHC9YitCO2uX5ped
	 SmAfQv0cRRInLJ8t8qsZpDwJv5CrmT0rOOyC0m/Qv0cw5/Twl1aZ61fRct4sCmaH49KbU
	 YdQLJiS3BPWxwvrviej+Hz5yaJtxMzB817sAqVjd4rKhJOTuvR2r+FvTsRxZlMYfZ+1nA
	 W1whZuAlB3I0VIa3K0MK1ZTAX5Jo5Z1sbGr5YopkuKuu48lgE4q+SDJXjej5RnsdF7x6A
	 MVEnm4C5RwX8WD5qM73nLDOYEnmJG0mDLp3K6dM4clXGAh3VvXZOz5n5uUVyrsv6X7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=JJNsA/o8ELYP7OKhTRd7t+GFqvdxUv9srxKUL6QVJdo=;
	b=BxwCd+80KFR8lWH2YjB6dX6M0BHEWuC4SxhuNR0SWkkMATW1sObMmZvqyt5xJHYyrFRr
	 xmnW07BaSaxVXJ1KiPVAGh4uDWA6eavjm0UQc4pvghl9Z9H5QEnJ6N0E8pp67WEQL8oge
	 dtZ3PhYyqCTl7K2N+AdfOBHuuD+2QQMDihdeRmryGtdhkQyEaT35KuVJHyNHfAdFzto0U
	 GqHlgT5zw+QlUCiDDH2Ud+YpW62Zv1J8KoGDXqhoRUWqWss5RET1ftf8kNl+nSkoULG0i
	 Hx5v8qoKozZn6jbBiKo25W636N2mcSlzFGI+RIjiNMOHeDzYQd8R+yDgA/x6lFlZQog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=I0eQF3g4;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890AC606B216;
	Fri, 13 Nov 2026 18:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890AC606B216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=I0eQF3g4
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4qr2vz2z51Smx;
	Sat, 14 Nov 2026 02:03:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794593000;
	bh=e/1ftnoL19LzV4jDwYrzKqd5zjFgzhBYF3wgdCOuF4Y=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=I0eQF3g4TJiE3lafu2OXnb8CMNwpZx+Ebh7QoNOreGs81DvAUjSbsgDVtEV4H6oD3
	 JufP+UrQpGHO1aFvFwQpJiMYwdsYVhCxXvKez1dCL+nEo86WpdCQ4OKxF8qBnoyilv
	 yXlrKpCNR4nHiCWR4ywbzc/Y5Gm/98e+eJbUQovmtz8ywuALUsoq9NzwfqPsQyHNXO
	 +u963Ry/f4z5qLmU5U5xhJGZPQ6NmzU75l6aKV7z8cqxg8YeUU68EJSZI0cFYv4+h1
	 xGJ5vdDOXd8edJhyMlK4WZCRRpyoEAl8dYe89W+NJYAUmO6CCvCzNqg2tknCzePOm4
	 SauphjH0r/fKQ==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6ADI38cx099945;
	Sat, 14 Nov 2026 02:03:08 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:03:12 +0800 (CST)
X-Zmail-TransId: 2afa6af750e09c3-3b8e3
X-Mailer: Zmail v1.0
Message-ID: <20261114020312969hzPj5VMaGjaujxVeWVaBD@zte.com.cn>
In-Reply-To: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
References: 20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn
Date: Sat, 14 Nov 2026 02:03:12 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCA1LzVdIGF0YTogYWhjaV9zZWF0dGxlOiBzZXJpYWxpemUgU0dQSU8gcmVnaXN0ZXIgdXBkYXRlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADI38cx099945
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:03:20 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750E8.000/4jR4qr2vz2z51Smx

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
 
-- 
2.27.0
