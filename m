Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE70C363095;
	Tue,  9 Jun 2026 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020336; cv=none; b=AZN6KbR1uz8XuVp2QQCt4SnPYpHXXpDdrZ7D6RPZMX9MR0f1rt0iZBUW4LUGpDL3DZi8l9pA7jexPShDYUDH2Q0HIXTSRWIQ+wZvJv1or4psR290NXI8OSOmS8cLGySXnAgkhd3Dv/EfuX0lMCfE7AoG+6GHF2YGbNmsOPBnBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020336; c=relaxed/simple;
	bh=8042xhM56BUjDU6m/D/cqtu2jqtYY5gytptBcB/9n0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRZfp3fe0NJzqVvf2UrbdfOfFCu29wVPhBN668mM74/dNWwbz6QR+UIwlX+eyOU+aK15XrS+G9PkJaZ5RViGg+8xAlOL1+QamJ4kFYVeuf30+adbDoeDd+Scu2qIhrYXjfUPQeUOv5NGbLb8IcmmSIWykbWnMhHMz4gE+ugxVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Pxu95Q9+; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Pxu95Q9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=d2nsr
	8MMQegCYjrAboIX+CyGXLDqAeF5OkypEuhFvp0=; b=Pxu95Q9+b4Vy3CuLfoo6T
	Wh+DWcxSXL58xNb7biIn/SR6ovXRsJB/FZyjS2RsQR+0j9eTFjkSgRWegHaIMZcE
	O4694RQBwwEyFdJZsPzzBeANLH1UDC+UikuDLmjc5WpLbCGSnzvOhA+lAx8CPhf8
	OWSOiZd0KhEhmrqxm50ZhQ=
Received: from DESKTOP-35NLEVI (unknown [166.111.239.142])
	by web3 (Coremail) with SMTP id ygQGZQCX5ZKiNihqKZBEAg--.20133S2;
	Tue, 09 Jun 2026 23:52:03 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: v9fs@lists.linux.dev
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH] 9p/xen: drain response work after unbinding IRQ
Date: Tue,  9 Jun 2026 23:52:01 +0800
Message-ID: <20260609155202.1706-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:ygQGZQCX5ZKiNihqKZBEAg--.20133S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur13Gr4UGr13WF4xKry7Awb_yoW8tw1kpa
	9Iyr98tFykAFyYyFZYqFWxJ3WrCFW8GwsrKryjyay3X3Z8JFy0grWkKw1F9F98Cr4kKF1I
	vrn0qFWq9rn8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_XrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0lksUUUU
	U
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgMNAWonzACpjgABsq

commit ea4f1009408e ("9p/xen : Fix use after free bug in=0D
xen_9pfs_front_remove due to race condition") added cancel_work_sync()=0D
to keep xen_9pfs_front_free() from freeing a ring while=0D
p9_xen_response() is still running.=0D
=0D
The work is currently drained before the event channel IRQ is unbound.=0D
That leaves a race window where xen_9pfs_front_event_handler() can run=0D
after cancel_work_sync() returns and queue p9_xen_response() again.  The=0D
following unbind_from_irqhandler() synchronizes with the IRQ handler, but=0D
it does not cancel work that the handler already queued.  The teardown=0D
can then free the ring and private data while the response work remains=0D
pending, and the worker later dereferences ring->priv and priv->client.=0D
=0D
Unbind the event channel IRQ before draining the work.  Once the IRQ is=0D
unbound, no new response work can be queued by the backend event channel,=0D
and cancel_work_sync() waits for any work that was queued before or=0D
during the unbind.  It is then safe to release the ring resources.=0D
=0D
Fixes: ea4f1009408e ("9p/xen : Fix use after free bug in xen_9pfs_front_rem=
ove due to race condition")=0D
Cc: stable@vger.kernel.org=0D
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>=0D
Reported-by: Ao Wang <wangao@seu.edu.cn>=0D
Reported-by: Xuewei Feng <fengxw06@126.com>=0D
Reported-by: Qi Li <qli01@tsinghua.edu.cn>=0D
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>=0D
Assisted-by: GLM:GLM-5.1=0D
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
---=0D
 net/9p/trans_xen.c | 4 ++--=0D
 1 file changed, 2 insertions(+), 2 deletions(-)=0D
=0D
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c=0D
index f9fb2db7a066..73c75fbdfa21 100644=0D
--- a/net/9p/trans_xen.c=0D
+++ b/net/9p/trans_xen.c=0D
@@ -281,14 +281,14 @@ static void xen_9pfs_front_free(struct xen_9pfs_front=
_priv *priv)=0D
 		for (i =3D 0; i < XEN_9PFS_NUM_RINGS; i++) {=0D
 			struct xen_9pfs_dataring *ring =3D &priv->rings[i];=0D
 =0D
-			cancel_work_sync(&ring->work);=0D
-=0D
 			if (!ring->intf)=0D
 				break;=0D
 			if (ring->irq >=3D 0) {=0D
 				unbind_from_irqhandler(ring->irq, ring);=0D
 				ring->irq =3D -1;=0D
 			}=0D
+			cancel_work_sync(&ring->work);=0D
+=0D
 			if (ring->data.in) {=0D
 				for (j =3D 0; j < (1 << ring->intf->ring_order);=0D
 				     j++) {=0D
-- =0D
2.43.0=0D

