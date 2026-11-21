Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795267975;
	b=CW9NP6R6Pj6lyWXw8rVd52ORUDxoKNB2MEj3IUS+s+RVUyUF5+9xhdVhGKxIeQrQu6+n
	 L6Gj13qmQE1Z3uDIdg6NrExGq1I2PNmmfqb0bPgJBTnjfuh64VKpsuUhLzc2sr1AZ5Kvj
	 8b9Hk7q9gadl3tyFAv+2WWcnaqO5Fit9J8+Mvo/K3Ttz2YmitwZfTmk7sp6HeaIoC8pLi
	 JgCvAGcEqLcB2faTo0i5YaT9TpI/R0jtKe7cWc5dR63Qulph8chTT7+zCy1L9LjVNbSx3
	 LHlH8AV5paccw6ps6nIbTvwevX6MnahXekDXfsytRMNA90Ebqjfg5pYa2UhqjedAjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795267975;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=JkdwCAEutEIfwhJO9SpdIcsXM2DUuJk895w0Ed5CRkg=;
	b=C3ELnhhtKuRPi6g+NiQWIJIKHJb5Hsbnsk6FL10HsXaG62GWv5Asta4b0QkZ32+EZsvh
	 ClJfnbN0E7BbP5P3E30+6vNlRsth/Uz0bLRHkWM2jvbBntLReqKtr34wkGR0ahmyIUa3v
	 K/tQg0XcojsleoEcUMKVyx1y8gnglsF75dMdWAX4rHbxZcxFb1qcsvVa46Ht9gWRlcmL3
	 BFlXbQnFDkqrC06rxnMCxTJ+aKx+IUPA9/vU3tBU1alac/Itwoh0wydDEt/O/2RiNZGwD
	 F8hEeC4NE3ujZjR1m3qRo2vOr2ZsWAcpvcQjYDhmv0TDfY+dvG+53GE5UU/qU/pCH7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F036606A320;
	Sat, 21 Nov 2026 13:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F036606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=JkdwCAEutE
	IfwhJO9SpdIcsXM2DUuJk895w0Ed5CRkg=; b=Mjbf1JLfvyZGwEl4bNTmB+A5IX
	A3F9pVBrGSn901WenGCPrmllMQOZS5aHE3gGCNl9pIiddztVSEzLOIIXLqyZNjiV
	rvTJNWiaZz6egh00Ekky1Ss2gbp1KTRElKuKu9ecd1essMQChXSYyCWg9uD2tJJQ
	WmBPpUtzYYur/C2r0=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCW1_x7nQFryewCAg--.24087S2;
	Sat, 21 Nov 2026 21:32:43 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	James Prestwood <prestwoj@gmail.com>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] wifi: mac80211: handle failure to re-add interface on address change
Date: Sat, 21 Nov 2026 21:32:42 +0800
Message-Id: <20261121133242.6550-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkCW1_x7nQFryewCAg--.24087S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxXr1DJw1kXr48Zr45GFg_yoW5Xr4UpF
	W5CrZIkryDJr43Gw43Ar47ua45CFs7GrWrCFnrAa13uF1Sgry3ury09a4j9FyfCFW8A342
	yF90yr45WayDCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0niSPUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUED2sAYljOOwABsq

Changing the MAC address of a running station interface makes mac80211
remove the interface from the driver and add it back with the new
address.  The code assumes that adding it back cannot fail and only warns
if it does, which is not true: drivers may legitimately refuse to add the
interface, for example a USB driver that has concluded its device has
disappeared.  rt2x00 returns -ENODEV from ->add_interface() once it has
seen too many consecutive -EPROTO errors and marked the device as gone,
which produces

  WARNING: net/mac80211/iface.c:306 at ieee80211_change_mac

and, worse, the address change still returns success to userspace even
though the interface is now running but no longer present in the driver.
Any further address change then attempts to remove the interface from the
driver again and trips the check_sdata_in_driver() warning.

Handle the error properly: keep the remove/add sequence, but propagate
the driver's error to userspace instead of warning about it, and reject
further address changes on an interface that the driver no longer knows
about.

Fixes: 3c06e91b40db6 ("wifi: mac80211: Support POWERED_ADDR_CHANGE feature")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 net/mac80211/iface.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b6ed6541bc42..f3105d0564de 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -279,6 +279,15 @@ static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
 		if (ret)
 			return ret;
 
+		/*
+		 * The driver may have refused to add the interface back
+		 * after a previous address change, e.g. because the device
+		 * disappeared. In that case the interface is not in the
+		 * driver, so don't try to remove/add it again.
+		 */
+		if (!(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
+			return -ENODEV;
+
 		live = true;
 	}
 
@@ -300,10 +309,15 @@ static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* Regardless of eth_mac_addr() return we still want to add the
-	 * interface back. This should not fail...
+	 * interface back, but the driver may refuse, e.g. if the device
+	 * disappeared in the meantime.
 	 */
-	if (live)
-		WARN_ON(drv_add_interface(local, sdata));
+	if (live) {
+		int err = drv_add_interface(local, sdata);
+
+		if (err && !ret)
+			ret = err;
+	}
 
 	return ret;
 }
-- 
2.34.1

