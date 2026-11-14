Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677286;
	b=0dZKzCmoQqPqB9DzqA/13o349pk98BxTGU6tVH8KRor4/peWKs+X3gNA91xdCW/98wyC
	 cOK+ixKYQeSgg1XBuSEwb9skWf9VhwtNfSWftcpvfFzVbbNPcsaCFcYumYoXwPEc8KUc4
	 u3bwRCgnUwmC3nQalyF9ZtuSakd7yczfnxNZ3i0K8Hxmh3QnRKse+eKawTNdg+zjlXWID
	 HrOv4k5a1riy/h5/u6ZQvmnPXcCrH9gZEw7t2RyhBGjZEzpkSMpN5kA3mIiuHFUKwuUmg
	 6NiArsidGrzm2dufFb1Pn0jkJ6SpJ8NdA6XFayK+hUA7kfCz1vkQpbVbR0y2MevAPZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677286;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=LFJIrTHoNKoLywvkyABL7mHp+gK4u9o5oPm8cmfaloA=;
	b=WB9h8ciEaCXFwk03q8Hrewb0cIMHyQSHkYuf23f+b6o3yB7jS2iDS7nFClURRj+6nrH7
	 DaSR1wcwhQWN4YE9fNE8Iol7dQQNQnxuYTKOjN1HHfNXQA+A6DZNY2cyAwbviCLZeQ8ab
	 2EdzX+JauH8FOHAldRXcHkNeFFWiwG2PubGUFtaVzqT0HmbN2fSOfGQu4gLy+lnNW1Q+v
	 hfM/YHechkDQ83ngsSWha1dOXsToh1OPh83MCApHPnFLLNGdGRIPakli29SCcIP3Z0UO8
	 HKkkANFWkWOWWUO4Sru/st2/FIwUROSYt3a92tUmltU666CIyQKn1d29x49JUB3t1cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="wh/1xGIe";
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9623606A329;
	Sat, 14 Nov 2026 17:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9623606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=wh/1xGIe
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jRh0g6sf3z4xPS3;
	Sun, 15 Nov 2026 01:28:03 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677284;
	bh=1Mb+x+aS+924O00shC+z1whh+aojOH6IJCSnYH2Yy9Q=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=wh/1xGIeLHq7nomVKFii5/MBr50ubdLBMglX3cf89/OLZAQD4AvUDxTdaHlHnqFG7
	 znx28WqUBs/2W8tMtWAUpq2/xkNOrjyqIxroNPpSmh0Fy7RKbmCKx7V9iCVKIyot6b
	 Tx2WxIVV4bnVbqOp2xiLUdzS5TIco8gGU6TowSvUCrVPfEP+uBd3qzoY85sthBsKb2
	 y7HPKbZNquMk5JY1cDKzsRFAy4vkqcWkIo+nLrBlhG8+PL3Jk4IwgjiHhOa1BY/Gqe
	 2gEmrHQ0THPd913MxEoSqIFkdrtnB+N56Z2WF4Slo5jaSilDefMyWXjvmck0tDESxE
	 oaLVdDY+0F/Iw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AEHRsme016779;
	Sun, 15 Nov 2026 01:27:55 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:58 +0800 (CST)
X-Zmail-TransId: 2afc6af89a1e011-53fbd
X-Mailer: Zmail v1.0
Message-ID: <202611150127588115YPbE0vZGI-FTHIHXJTI5@zte.com.cn>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn
Date: Sun, 15 Nov 2026 01:27:58 +0800 (CST)
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
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDUvNV0gbnZtZTogYm91bmQgdGhlIHJlc2VydmF0aW9uIHJlcG9ydCByZXRyeSBsb29w?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEHRsme016779
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:28:04 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A23.000/4jRh0g6sf3z4xPS3

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_pr_read_reservation() first reads the reservation status header to
learn the number of registrants, allocates a buffer of that size, and
then reads the full status.  If the registrant count changed in between,
it frees the buffer and jumps back to get_num_regs.  There is no limit on
the number of retries:

	if (num_regs != get_unaligned_le16(&rse->regctl)) {
		kfree(rse);
		goto get_num_regs;
	}

The count comes from the controller and a target that keeps flipping it
(possible for a malicious NVMe-oF target) makes the ioctl loop forever.
Each iteration issues two Reservation Report commands and allocates up
to struct_size(..., 65535) bytes, and the calling process ends up in an
uninterruptible loop that cannot be killed.  Daemons that issue this
ioctl, such as cluster lock managers, get stuck with it.

Allow the retry only a few times and report -EAGAIN when the controller
still does not provide a consistent report.

Fixes: 28c97ba38ff9 ("nvme: Add pr_ops read_reservation support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport and
a TEST-ONLY nvmet hook that alternates the registrant count between the
header-only and the full Reservation Report.  The hook is compiled into
both kernels and only the host fix differs; no extra hardware is needed.

One PR key is registered, then the guest issues
IOC_PR_READ_RESERVATION.  The header report always says one registrant
and the full report says two, so the retry loop never converges:

  unpatched                            patched
  ioctl never returns (the runner      ioctl returns -EAGAIN after
  hits its timeout)                    three inconsistent report attempts

 drivers/nvme/host/pr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe264815..fab3bad2e2e0 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -275,7 +275,7 @@ static int nvme_pr_read_reservation(struct block_device *bdev,
 		struct pr_held_reservation *resv)
 {
 	struct nvme_reservation_status_ext tmp_rse, *rse;
-	int ret, i, num_regs;
+	int ret, i, num_regs, retries = 0;
 	u32 rse_len;
 	bool eds;
 
@@ -305,6 +305,8 @@ static int nvme_pr_read_reservation(struct block_device *bdev,
 
 	if (num_regs != get_unaligned_le16(&rse->regctl)) {
 		kfree(rse);
+		if (++retries >= 3)
+			return -EAGAIN;
 		goto get_num_regs;
 	}
 
-- 
2.43.0
