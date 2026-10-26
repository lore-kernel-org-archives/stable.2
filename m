Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019488;
	b=ACWkwdIgiMI8IT681499CnRYJNb2xdA+UwsX+6SHvSaVVmwzxcR6tV4dlc8UmgCjyVLy
	 1ngM7ESsv36QtdaRnfa/81At/aIvK0E9eZjtnUUjjcMtyU/5yMfNRNJ1KZUN6+Kn6L79P
	 qg1arFrOzOKDnos3i/FZoIN8n4/1y33x9e5Q4/3p+L2Jb5uz/b83Sv9rXuI/N7wAAHxnq
	 Vtmt2OTIQE18kPknmBy515qn9i3+NUn9Wa6ZzaDllGGTAUwhi3U/KVUZ+JGyf7JUY4Lcd
	 fmGf4M5Nb+SodvHSonCUkHwZ2cMq9nE19rDlAekf4QX+ll28hCertNVyZ0dU/sDpPFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019488;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ZpdLqLxS1Nl3Vs+KqK21bSakObyAjxQEXejJEvQQgJA=;
	b=AwNYiONDieYmGqy/fSsvAejFl2ahQTexKrxiGTsjPleSyPJMAvk6mwnabdUZ4w2ubXwe
	 LeNl0r3kLe++U8cdzjBiT2klcxOPLEub8lZv5MW2yAUG+IZ/NnHlywvbxlBdIG89rmSvI
	 dTfIKgXkO5ycelio/avKx7Gxi0vHgM8nSmq+cDOReq8bkyniEDysxpUA7z1eFoxqDjwyX
	 0sa6l2mtwP8Jy93SkLSRMGC6AGgEvOF7JfIVGxT0J0viMrWqhsD2s6nABNquv3y4bCG0y
	 v7meLo6ToVhfloXWzZeNMNSOKlNNfkyeDTpvCAuebeF2vsOftc0K6mgj4SNU3iNKpWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72E0606A31B;
	Mon, 26 Oct 2026 12:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E72E0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=ZpdLqLxS1N
	l3Vs+KqK21bSakObyAjxQEXejJEvQQgJA=; b=4SfkruKFJPCgYSxQOH6RUW8nk6
	jKwDU2iUhTwGKVKNhca0aCHqJNRWO1UTefuiLKTxl4ZJ+RQCw8snqyLbHy6k3/fG
	mrNOKl2Xs3rbpjfNTqUlPJLLQxXTWPhIxmOqpIYGYpmvqx5bJTb99W9miw01ZuJd
	a/JYTWgF07ywKwSUc=
Received: from localhost.localdomain (unknown [113.200.174.126])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDWGwFJTt9qbqzpAA--.7289S2;
	Mon, 26 Oct 2026 20:57:46 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Anssi Hannula <anssi.hannula@iki.fi>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] media: rc: ati_remote: fix NULL input device handling
Date: Mon, 26 Oct 2026 20:57:29 +0800
Message-ID: <20261026125731.1952-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
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
X-CM-TRANSID:BLQMCkDWGwFJTt9qbqzpAA--.7289S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xJw4kCF1fGrW7GFW5GFg_yoW8XFW8p3
	y5Ca45Kryqkr4a9rnaq3WUZ3WfGrs7Zw15ZFySq3409rs8uryFyryUKa47Xa4UGa4FvFy5
	t3y3Jw4kuFyUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxU4ksqDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUSD2reG1O7tQABsq

This series fixes two ways ati_remote can pass a NULL input device to
input_event():

  1. ati_remote_probe() registers the rc device before it sets up the
     mouse input device.  The rc device can be opened as soon as it is
     registered, which submits the interrupt URB, and a report arriving
     before ati_remote->idev is assigned dereferences the NULL pointer.
     Move the input device setup before rc_register_device(), and free
     the input device only after the rc device has been unregistered and
     the URBs have been killed.

  2. With the "mouse" module parameter disabled, the mouse input device
     is never allocated, but the rc device still accepts mouse scancodes
     and reports them through ati_remote->idev.  Restore the check that
     drops mouse events when there is no mouse device.

The two issues have different root causes and are fixed in separate
patches.

The series applies to v7.3-rc7 and was validated with checkpatch, by
replaying it on a clean tree, and by building drivers/media/rc/ with
W=1 for x86_64.

Changes in v2:
  - Do not call rc_unregister_device() when rc_register_device() fails.
  - On input_register_device() failure, unregister the rc device and
    kill the URBs before freeing the input device.
  - Add a second patch for the mouse=0 case.

YuanZhe Liu (2):
  media: rc: ati_remote: fix NULL input_dev on rc device open
  media: rc: ati_remote: fix NULL input_dev when mouse=0

 drivers/media/rc/ati_remote.c | 37 +++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

-- 
2.34.1

