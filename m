Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250205;
	b=0Jdxk3Lxc46ESLcTTlHewtER3G/w5K4GJXYYd+Qx9fah1bnyxegelorhbSVy+NHDSHkW
	 H8TRGC62aaZoOxu7G/Q32o1RKDrJmk6RbNMRGOfgmnzS47/hCpgfdxJH28rIxTOF9gTZm
	 8UDDSmI+z8fdo25NK+zeo9SmJTLCf/oGelawAkU/6QW1awDnhZyBrRFMhB3YmRRvldozR
	 z2oTf4D2YdIYVqPByColXEfQ7i6ZVyVTxwla1uTC1gPa6gI/eki/Lbx2EFzf/sAGW278g
	 e5ES2tLtnCLiWXmPeyoL6F/vYUUpCi3v3Mse7NoRHh3TJTjnG01nkbYuU7y4uT/c7tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250205;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=zx1cwdgOGsU5VOvrhxIe3lTZUynbysLzmn2YWTYIoE8=;
	b=ZXJAuvos+M2on5dAvKMTdul4gYBlnVQ44ZMaRRd8wW0NLbU3JueDYy5eec3eQpoc5b3K
	 y06/SuoXNSLy4dGmAVdRGJKRHndApYZeMIqTp9YhpVJmMEh1FG8tJK+GyAdXApIysg9G/
	 KLrkCHduKjt4Ec19swMcGNf3kXLT8gQpVigjGV+WpO53XdAyfTwMB+dF6wqOLOGsHO4uZ
	 5STEsTLifZ17yhCsv2MYxi84abc9vc1L7cZsD0Yk6uIPFnTmcFYSxDpkkd4jKBP9GW3hy
	 lkCFOYNn3jAsfcw5QtS0C6+5bRksLjyGTSQv/uWPw0GOONOrckx0c/OGrZELvi4zlLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2580C606A31A;
	Thu, 29 Oct 2026 05:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2580C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=zx1cwdgOGs
	U5VOvrhxIe3lTZUynbysLzmn2YWTYIoE8=; b=AwjYRD8J7N+VP6sGzJ8AhOc2kl
	bOjZL7g1foVF7v+YVFJqf0MyNW8aCBRma0uGhR98MsxPOLPtLxlwpu4Cd5nGgXUs
	JvYIeLCT3Mm1tn16W2XN+EB22GZXSdtffK4JnDOF3+yrgDyyDjJr770wVjhiOzXI
	w3Tml+tTqfd/Ofyuo=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.47])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkC2vQCE0+JqAIH6AA--.62518S2;
	Thu, 29 Oct 2026 13:03:02 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: dvb-core: release the net slot when adding an interface fails
Date: Thu, 29 Oct 2026 13:02:59 +0800
Message-Id: <20261029050259.8915-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkC2vQCE0+JqAIH6AA--.62518S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyxWr1DKr4kWr45Kry8Zrb_yoW8ZF1kpa
	98CFyjkrWkWr4xCrsrJw4jv3s5Ja1ayFy7Gry7Kw1DZF45WF12kFy0ka42vF17ArZ5Ar1f
	XF1UtFWq93y8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU4CD7UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUAD2riD9MOGgADsI

dvb_net_add_if() reserves a slot with get_if(), which sets
dvbnet->state[if_num] before the netdev exists.  If alloc_netdev() or
register_netdev() then fails, the slot keeps state set while
dvbnet->device[if_num] is cleared, and the interface is never announced
as created.

A later NET_GET_IF or __NET_GET_IF_OLD request for that slot passes the
state check in dvb_net_do_ioctl() and dereferences the NULL netdev
through netdev_priv(), which raises a general protection fault:

  KASAN: null-ptr-deref in range [0x0000000000000980-0x0000000000000987]
  RIP: dvb_net_do_ioctl+0x4f8/0x710

Return the slot to the free pool on both failure paths so that state and
device can no longer disagree.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvb_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index a2159b2bc176..912841f7cd55 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -1358,8 +1358,10 @@ static int dvb_net_add_if(struct dvb_net *dvbnet, u16 pid, u8 feedtype)
 
 	net = alloc_netdev(sizeof(struct dvb_net_priv), "dvb",
 			   NET_NAME_UNKNOWN, dvb_net_setup);
-	if (!net)
+	if (!net) {
+		dvbnet->state[if_num] = 0;
 		return -ENOMEM;
+	}
 
 	if (dvbnet->dvbdev->id)
 		snprintf(net->name, IFNAMSIZ, "dvb%d%u%d",
@@ -1392,6 +1394,7 @@ static int dvb_net_add_if(struct dvb_net *dvbnet, u16 pid, u8 feedtype)
 
 	if ((result = register_netdev(net)) < 0) {
 		dvbnet->device[if_num] = NULL;
+		dvbnet->state[if_num] = 0;
 		free_netdev(net);
 		return result;
 	}
-- 
2.34.1

