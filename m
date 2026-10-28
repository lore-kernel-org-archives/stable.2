Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206155;
	b=Wdmgvgxxq4M70PX3IqGDuYDktaVp53DovSsfE6ZI7pQ4smS8VaszMeAw3ua2jDvY6Jbd
	 k/WRyfWPFPrHW+HzzOm9awrgJzr/Ax7hHsI2AQrAzPrsOwghf99rfFo7m/s2n9VWcFsAE
	 lZWeuYHZ/fTlpH3+3q1TuFsJ8395eMZpfj1j8gKQVUjiS5o9bM1fKUzeuej2SbdIIjUm0
	 4Avt32PimCB2oMPh5srHnoKppie8RYGVAV4k0mZCkzRn0OmHwtXTLYfqTtnx4hajcEKSx
	 xXa1HTaBm6JWIJTD4nojSQIh1Ag/4aH35IJu3L6dKRJ7FyF/Et4gf2jaTviRr7EnpYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206155;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=nSZsANMCsxetn0hkNJF20DbdMUkrz7cvjEhPpMT6+4k=;
	b=BbGRjaErTgTmQG1TOAMHtvL/LRyKLAR+y6WzGrk9Z1pxjEvUU3NOpwW/jApZITpX8Q0e
	 cxn3UeOFB5vknUkILNCFnHXLsxPaTirKuCc0nep3UE9PSdoUYWI1qD5QS2+fnHTYVMFUk
	 Bsb0GC1+4j3vXMSSXcFv3Qu/4qri42HRY434EU2w8+otAWGXq7Qd6zTiAc+Q/J7zPhiol
	 dCJS9MrHWNXMKjOqep/P+g6Fj2HrVwLCqv1cgRNGVUp2ASzlHNCqCTOFI7p2dhhxHIE99
	 wwpVZifPkDHPz9ifmTJxgCI5AAh3CHxOWXaflpDQpk0/PdjSVsJgNO+5UInnGo5B1Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BD0606A31D;
	Wed, 28 Oct 2026 16:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BD0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=nSZsANMCsx
	etn0hkNJF20DbdMUkrz7cvjEhPpMT6+4k=; b=eLxIWl1LQZMs//g1qpklQxIaDk
	imf4T/KjStRHVboe9eTMhAP9OqNkw+b5bzzAFpod27vSSGPqo537deAw/87A1tLN
	+tBnwJcawZjon2spPObYls6X+BajzbhsV0F2Ft7EMDntcxJlDeyzEnqZy+y9iSqg
	2dj6LQgbWk7TIvZbk=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.26])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCmzQN_J+Jqguf1AA--.57595S2;
	Thu, 29 Oct 2026 00:49:04 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: linux-wireless@vger.kernel.org,
	libertas-dev@lists.infradead.org
Cc: Johan Hovold <johan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: libertas_tf: fix NULL pointer dereference in if_usb_receive()
Date: Thu, 29 Oct 2026 00:49:02 +0800
Message-Id: <20261028164902.8136-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BrQMCkCmzQN_J+Jqguf1AA--.57595S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryDCF18JF43AFyrZF17GFg_yoW5AFyDpF
	W7Ar17CrZ5Jr4jyanrArs7Zr1rXa10yayfGF1jkw4fZrs8Ww1ruryrWw4agFs8ZrWrAa4x
	tFWqqrW2gFWDCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUsCzuDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUAD2riD9MOGgAAsL

if_usb_receive() takes the receive skb from cardp->rx_skb and
immediately dereferences skb->data to get at the packet header:

	__le32 *pkt = (__le32 *) skb->data;

That happens before the URB status or the skb itself is validated.
cardp->rx_skb can already be NULL when the callback runs, because
__if_usb_submit_rx_urb() frees the freshly allocated skb and clears
cardp->rx_skb when usb_submit_urb() fails:

	kfree_skb(skb);
	cardp->rx_skb = NULL;

The submission fails with -EBUSY while the previous rx_urb is still
queued on the endpoint, or with -ENODEV once the device is no longer
configured.  usb_fill_bulk_urb() has already installed if_usb_receive()
as the completion handler of that still queued URB, so when
usb_kill_urb() from if_usb_free() later hands the URB back with
-ENOENT and a zero actual_length, the callback runs with skb == NULL
and faults on skb->data:

	general protection fault, probably for non-canonical address
	0xdffffc0000000019: 0000 [#1] SMP KASAN
	KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
	RIP: 0010:if_usb_receive+0xd6/0x3a0
	...
	Call Trace:
	 __usb_hcd_giveback_urb
	 usb_giveback_urb_bh
	 ...
	 usb_kill_urb
	 if_usb_free
	 if_usb_probe

Compute pkt only in the branch that actually consumes the payload,
after the URB status and the skb have been validated, so a callback
without a valid skb leaves through the existing retry path.  The
handling of a non-zero status with a non-empty payload is untouched,
which keeps the current recovery after transient errors.

Fixes: c305a19a0d0a47ac59a58865a4a63be65b1bf7c8 ("libertas_tf: usb specific functions")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/marvell/libertas_tf/if_usb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
index b85c6d783bf7..bca2912a1909 100644
--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -625,7 +625,7 @@ static void if_usb_receive(struct urb *urb)
 	int recvlength = urb->actual_length;
 	uint8_t *recvbuff = NULL;
 	uint32_t recvtype = 0;
-	__le32 *pkt = (__le32 *) skb->data;
+	__le32 *pkt = NULL;
 
 	lbtf_deb_enter(LBTF_DEB_USB);
 
@@ -637,6 +637,12 @@ static void if_usb_receive(struct urb *urb)
 			goto setup_for_next;
 		}
 
+		if (!skb) {
+			lbtf_deb_usbd(&cardp->udev->dev, "RX URB without skb\n");
+			goto setup_for_next;
+		}
+
+		pkt = (__le32 *)skb->data;
 		recvbuff = skb->data;
 		recvtype = le32_to_cpu(pkt[0]);
 		lbtf_deb_usbd(&cardp->udev->dev,
-- 
2.34.1

