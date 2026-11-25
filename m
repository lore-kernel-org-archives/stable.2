Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598278;
	b=MugvkM0n2Yz0tIhfnBBZKEfFLg0Z6m3pbRZmq4zjXopgYHrBOMHVan7YHFT1WRMP9GuW
	 hvCVmdUwXKbzRpxfxsin7kLBBQ0zSESUR5pxRvrs4JVmUAVR0iAwWuVSG1Xb19pLSEdjQ
	 /slIGgWBOCt8rG+Il2ha4qJAGRBHu2rUZ+GUHuYMBXPFYMTozBC+JJfJ6sZbQgberNnby
	 akZTdIEkSqy8ZUF+XTn67NPiHwgEbBO/o68VN5t1/lzsW17Jd8IRMGm3Faq5hE/lh0rUH
	 0AuSsu8VUhmFd5g45p50AXwAhM7r8/FjJqUY2Cf3daveMjGxIdKd63VSerHDm3FPU7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598278;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=qi/hL0SM2QV1lH7QB9x2aIOYSNZbG/xbThH5LOAdZVg=;
	b=QuBYkDJma3pv5bLK7F11Fy9JTgY7Lnc8p7G5s9JmtuU/N1jlRgHb+/EMtcqDk+LIqVei
	 HJeQrycFzuUyN+9d4doUw8tL8bt25jn0BVVBvXjZwv6zjMk+qOuXFKw7B/19gJk1uZO8H
	 pq64n74vTbe2xv1GTPvSB2+6T14BJNGWCngKnofwRLc8EKIhbIJrAHV1QZo4gXfiTvBMB
	 c5HxdjU4n6neekGW22FZI31uoTKA9MxkrZiuOWR0ulW8RJg3bow9jk6hUpGy0nd7Rn9Et
	 s2dKh//8u4NzvU8o/7sc+R28eRtu0Sriaa+OP4HPWf+KyJc9cRYGMI2toBEoRqTJmWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF773606A685;
	Wed, 25 Nov 2026 09:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF773606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=qi/hL0SM2Q
	V1lH7QB9x2aIOYSNZbG/xbThH5LOAdZVg=; b=Swqb2n2+JnwThBuAUA1Nl6EtwG
	UmK+K+ZHui740SqjJdyOvw7c6tyslDctZJXTQs758HdJVTLmFD+MrysKQCYA2Tov
	/TLOPEKjJsgp8Ibhvdyk1F0vbc/d30fhIQ6zLRQ2IxuQOof9+f0go3dnM0CJ8iAP
	9IlP6TxofHr4K1v4k=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.108])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkC2_gO0pwZrgwE0Ag--.13180S2;
	Wed, 25 Nov 2026 17:17:41 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v3 0/2] media: go7007: return buffers to vb2 from the streaming paths
Date: Wed, 25 Nov 2026 17:17:37 +0800
Message-Id: <20261125091739.5866-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkC2_gO0pwZrgwE0Ag--.13180S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZry3KF17tF47JFW7WF4fuFg_yoWkKFX_Jr
	WkKrZ7G3WDta13CF1Utr90vr97Aa13KF1xXF48trW7Gw1UZrZ8ArnrKrn5Ja1xWF4ftrnF
	gw1F93yftrnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_Jr
	ylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUcvPfUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUID2sFqsq2zgAAs2

go7007 hands queued buffers to vb2 in buf_queue(), but neither of its
streaming teardown paths gives them back: start_streaming() returns -EIO
without returning the buffers it was given, and stop_streaming() drops
them by re-initializing go->vidq_active.  Both violate the vb2 buffer
ownership rules and trigger the corresponding checks in
vb2_start_streaming() and __vb2_queue_cancel().

Patch 1 returns the queued buffers with VB2_BUF_STATE_QUEUED when
start_streaming() fails.  Patch 2 returns the pending buffers with
VB2_BUF_STATE_ERROR in stop_streaming().

Changes in v3:
- Walk go->vidq_active directly in start_streaming() instead of splicing
  it onto a local list.
- Add the stop_streaming() fix requested by Hans.

Changes in v2:
- Inline the buffer return into go7007_start_streaming() and drop the
  separate helper.
- Drop the redundant go->active_buf = NULL from that path.

YuanZhe Liu (2):
  media: go7007: return queued buffers on start_streaming() failure
  media: go7007: return pending buffers on stop_streaming()

 drivers/media/usb/go7007/go7007-v4l2.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

-- 
2.34.1

