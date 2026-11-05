Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858267;
	b=YM+qJq/q/mYvXRAMo4k77GbKIZW95m9EZGXeYHPugxshY0QnEUeMhAKtxp028WaOHPM9
	 EVowQfb8vWyLZI0DlB3zqwzluOJsOlGxRBUIx2f5Q1qto+S6C8DbOeDZ+iEc98OjEfc6M
	 XmzsW2B2yZBjPEbplEQSrvEDccG+kF88rm5udEuK5D43jUv1BipHla3usYuuqXVoyohgW
	 xvJuwbBCOEQmDc4GFKxLyy88Nq7t2pSupdjJFfDRIsrpQUIdrJEQv/NyrpMuBSBr+vI7L
	 3EtotJqvpqGSqyUK6zTIfG4qdpQ1ltAb/am44A+aWnlVmfgxvUEgexfCcIRC/QRf5uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858267;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CzugvlBhqbMDKAvT3TfBg5pfX9J4bdWCzsHPnxIZ4/4=;
	b=wlY9JgjbI7CTsYBKbdU3jCMIp6HupSZrZoP2tRsEl1P1/23PJrbqh8FDSrJ7N/f1Gc2P
	 5Gh8r1EhwVWIxCV4EfZe49wVrCvuM0VJrf7tm9HqUVgSBvwcy4lTvTC4zu5k4im9fIJtj
	 ZGrY8QSZCJGLuQ1GFH4tWBDddN61fmaqioDu1OyHHL+HYatUK3OVEATqwUWEepUaNRvq3
	 rHVCSnOlZdkPoLeken1WvaijB38weispXYeAMUgHO9lkNUX0vTr0GNKEJ4xWCnXGcmaEx
	 6wlhjT77UQRu2gg+bjj0BTbwey2q0+gCzOD3BNd+GXuXLHbUE+G/6AKp0pG27CnxMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB02606A31B;
	Thu,  5 Nov 2026 05:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB02606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	In-Reply-To:References:Date:Message-ID:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=CzugvlBhqbMDKAvT3TfBg
	5pfX9J4bdWCzsHPnxIZ4/4=; b=aljBKnVfi7a+9CRk0N7rMwDGulEDoJPsZBVF3
	fyQ/HKunQQBWecVAGgBp2moonDv/BLQD1qoefRMxV55YDyJzE26Hf5NObMjw3ZyP
	gFHmU/IQAxT4VOJb4miT+dFVmhXUqtFmIjJaUuRBY927xIKMBRCav76bOSwc9Yaw
	pYQrgI=
Received: from [127.0.1.1] (unknown [113.200.174.104])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkD2Of_TGuxqiwApAQ--.63435S2;
	Thu, 05 Nov 2026 13:57:39 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] Bluetooth: btusb: fix use-after-free in force_poll_sync
In-Reply-To:
 <CABBYNZ+iU=riZ8MSTkbqv4vn0OJGLymtN98uJ8_0pw6hEaVWYQ@mail.gmail.com>
References: <20261102110440.2589-1-25031212351@stu.xidian.edu.cn>
 <CABBYNZ+iU=riZ8MSTkbqv4vn0OJGLymtN98uJ8_0pw6hEaVWYQ@mail.gmail.com>
Date: Thu, 05 Nov 2026 13:57:39 +0800
Message-ID: <179385825903.13262.2748533820947958224@stu.xidian.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:BLQMCkD2Of_TGuxqiwApAQ--.63435S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw45Cr4fXw43Xr4DXFWDArb_yoW8Xr47pa
	9Yk3Z8Jr4DKrsYq3s5uF4xX34SyryxWay3t3yfWw1Fy3y3Cr13tr4xJrZ0qa4xuFZ3tFWj
	vw45WrW0qFn8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r
	17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU8hjjDUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUID2rrTMSUAQAAsc

Hi Luiz,

Thanks for the review.

The vendor_diag observation is correct. For BTUSB_BCM_PATCHRAM and
BTUSB_BCM_APPLE, btusb_probe() sets hdev->set_diag = btusb_bcm_set_diag,
and hci_debugfs_create_basic() creates vendor_diag under hdev->debugfs.
btusb does not set HCI_QUIRK_NON_PERSISTENT_DIAG, so vendor_diag_write()
calls hdev->set_diag() even after the device has been unregistered, and
btusb_bcm_set_diag() reads btusb_data->diag before checking HCI_RUNNING.
As hdev->debugfs is only removed in hci_release_dev(), a write after
btusb_disconnect() can reach freed btusb_data.

That is a separate pre-existing issue: force_poll_sync is not the only
HCI debugfs file that can reach btusb_data, and the changelog sentence
claiming btusb_data can no longer be dereferenced was too broad. v3
scopes that guarantee to the force_poll_sync file.

For hci_qca, qca_debugfs_init() stores pointers to qca_data in the ibs
files and qca_close() frees qca_data without removing them. That is also
pre-existing but self-contained in the driver, so I sent a separate
patch that removes the ibs directory before qca_data is freed.

For vendor_diag, btusb cannot remove a file it does not own, so I think
the fix belongs in hci_debugfs: either remove the basic files in
hci_unregister_dev(), or make vendor_diag_write() reject writes once
HCI_UNREGISTER is set. I can prepare that as a follow-up if you agree.

Thanks,
YuanZhe

