Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795280643;
	b=kIDLb0ZrdY9/ppZfVFjQNJCuGt1yHjnTHZ4izap6uHHsW9XUY/fxpfVliGwSa16z6mPp
	 1Hdx6v9hJbBWWbIVb7d2nviBxk6QDqr+nbRSGGEeY+RltVqWpFekVL4WY4+RgGq2YfR/8
	 iXXawKGtqXgemtMnx8pUuAGYfy5zeNcz/nQYuckOuFhmCKca9eqZKz3XcfmR8Q88vi0U+
	 +COxDH+SQtDfnYKJVTidYttKKGUOhLRt9aBmwDcCbq4X3p1p3tIYHTl6wpUNyMSvhVUcu
	 BW/B/8uGzMseaA04lvWyqTMKqvg0GTYZYt7AjtyRCMW2uBM+Yrw7bzVJ+c1NaAXM0ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280643;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=KTEtV2d4YF3n94PQnGD8s33mCr1ytjNd6hJOzFbWZg0=;
	b=M0wOM2iyADxSwDMu7+/iGoJAbuUopK2qgMlS9rkjFIqZhsjMu5FgXJoTn2KiuLr4/yo8
	 y7rOh3Z5AdS3kuQs19ulFHVDfCZY+0TEjN4ZshSl1qmnVQJ4o3uT7ytOc+nTRsQFwGHxS
	 oXlULq65/X4eIXQ4UM5HousfVCuEwozutAYKKO9iHB5UNSV9q4IElylSx6D6oxfipGV3R
	 ReV8QRRCtdBKTKrNeBMnUTnaUygYucfP3rELtx2dvhNDqMAp5wSHSoRMxcm5gGYorVhbl
	 sHFRZSebvl8M9TE5+oUpkfnJBn9Oq7JMHlxPzY59Al1SbIYDCXuyYcLlS6cTroQZz1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50BC606A320;
	Sat, 21 Nov 2026 17:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E50BC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=KTEtV2d4YF
	3n94PQnGD8s33mCr1ytjNd6hJOzFbWZg0=; b=Enj6AZuKBa/UapxRxzFaB5au62
	W26lkb2650zTbQgxVx64XxFzRzDz9lfpd6gVvO085yYH6d1sRRvWDEpQxYnyTazU
	jb6asFBSNg7FKVIXipIwnHFwdjbRxIGyLZLTncq6LI4+ZzP1u7SYPIo0WV9EVSFz
	q4hLIhbqDo6TmdIaQ=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkBGSv3zzgFrpPIEAg--.58518S2;
	Sun, 22 Nov 2026 01:03:47 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	James Prestwood <prestwoj@gmail.com>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] wifi: mac80211: handle failure to re-add interface on address change
Date: Sun, 22 Nov 2026 01:03:46 +0800
Message-Id: <20261121170346.12440-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkBGSv3zzgFrpPIEAg--.58518S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxXr1DJw1kXr48Zr45GFg_yoWrWFy5pF
	WUG398tryDJr43Ww43Ar47uFyrCF48JFWrCFnrAa15uF1Ygry7urW0ka429FyFkFW8Aw42
	yrZ0yr45Wa98CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUy-zVDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUED2sBs9gOtgAAs2

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
the driver's error to userspace instead of warning about it, restore the
previous address so that the failed change is not visible to userspace,
and reject further address changes on an interface that the driver no
longer knows about.

Fixes: 3c06e91b40db6 ("wifi: mac80211: Support POWERED_ADDR_CHANGE feature")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2:
 - Restore the previous address when the driver refuses to add the
   interface back, so that the failed change is not left in
   dev->dev_addr; otherwise a retry with the same address would be
   filtered out by netif_set_mac_address() and never reach mac80211.
---
 net/mac80211/iface.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b6ed6541bc42..c45b42019d69 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -272,6 +272,7 @@ static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
 	struct sockaddr *sa = addr;
 	bool check_dup = true;
 	bool live = false;
+	u8 old_addr[ETH_ALEN];
 	int ret;
 
 	if (ieee80211_sdata_running(sdata)) {
@@ -279,6 +280,15 @@ static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
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
 
@@ -290,8 +300,10 @@ static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
 	if (ret)
 		return ret;
 
-	if (live)
+	if (live) {
+		ether_addr_copy(old_addr, sdata->dev->dev_addr);
 		drv_remove_interface(local, sdata);
+	}
 	ret = eth_mac_addr(sdata->dev, sa);
 
 	if (ret == 0) {
@@ -300,10 +312,30 @@ static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
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
+		if (err && !ret) {
+			struct sockaddr old_sa = {
+				.sa_family = sdata->dev->type,
+			};
+
+			/*
+			 * Undo the address update, the change didn't happen.
+			 * This also makes sure that a retry with the same
+			 * address reaches us again instead of being filtered
+			 * out by netif_set_mac_address().
+			 */
+			ether_addr_copy(old_sa.sa_data, old_addr);
+			eth_mac_addr(sdata->dev, &old_sa);
+			memcpy(sdata->vif.addr, old_addr, ETH_ALEN);
+			ether_addr_copy(sdata->vif.bss_conf.addr, old_addr);
+			ret = err;
+		}
+	}
 
 	return ret;
 }
-- 
2.34.1

