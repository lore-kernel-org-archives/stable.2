Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DFB3BD64D;
	Mon, 21 Sep 2026 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975567; cv=none; b=W+vgrRFUTLFQCzjb87emRqUpUqiWUgPSlkTo2idKxVqQ2mKZiBckNFDvkOZHceyVNpmRMvicNELm27zHVjkIsbuGZrE3YIZtPUP6/2sREiEzngPzs5qa4fzvu5V7fwm9nqxoRApWsjRjTTku74slL3Gyj2XvtALQGJiKTz3vogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975567; c=relaxed/simple;
	bh=GqK89U7P+Urcs0Jv1SoaTfT4xNdMCDUxpjbtp7TnyyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdiXN86xoMmmThWkanPha4NIFmlSGQ27k/Cp3nTcMWeuwImG+x2nEkWvJ25j/7/yXxiu14e12EGzGeL5ezAvCsME/ixrIzA78vXf5GD32wZPNeVHzZ85gMjmlw/44k+UFTs7OV0ioS3ZkCrNT2zYOyQTQgk8OJRIEx0xLu44s8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=GBi5ESHH; arc=none smtp.client-ip=115.124.28.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="GBi5ESHH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789975553; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EPHR4VpXwsYv5AFQFeBRmLe/N624YOyPR6uVg9i85Ow=;
	b=GBi5ESHH2Wha3lePb1SH9hP4HqMYny+dw7Qy7OJUlbo5bOwmuetjaPe+IekZKoaHG2dcV8GT+YibLMsp20Tem0jjE2tG4NR5iFrHgASuprfK/srvUXEknOzWMmKb01EnziXmBqbQsnVSuEk/M/5AsrHpWRsbMHr390w1Xe5LwZY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1719459|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00975134-0.000581996-0.989667;FP=11527700046566641586|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jInOhLq_1789975551;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jInOhLq_1789975551 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 21 Sep 2026 15:25:52 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skunkolee@gmail.com,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_uac1_legacy: validate bRequest index in generic_{set,get}_cmd
Date: Mon, 21 Sep 2026 15:25:51 +0800
Message-ID: <20260921072551.3708191-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_set_cmd() and generic_get_cmd() use the low nibble of
ctrl->bRequest as an index into con->data[]:

    u8 cmd = (ctrl->bRequest & 0x0F);  /* 0 .. 15 */
    ...
    con->data[cmd] = value;            /* OOB when cmd >= 5 */

struct usb_audio_control (include/linux/usb/audio.h) declares data as
a 5-element array, so indices 5 through 15 write (or read) up to 44
bytes past the end of the array on the heap.

A malicious USB host can craft a class-specific SET_CUR / GET_CUR
request with an arbitrary bRequest value, triggering the out-of-bounds
access from an IRQ completion handler with no further preconditions.

Add an ARRAY_SIZE() guard to both functions.

Fixes: c47d7b09891a ("USB: audio: add USB audio class definitions")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
Changes in v2:
- Fix the Fixes: tag per review: the unchecked low-nibble index and
  the data[5] array were both introduced by c47d7b09891a together
  with generic_{set,get}_cmd(); d355339eecd9 was only a file rename.
- Link to v1: https://lore.kernel.org/all/20260917081832.187957-1-liuc63@xiaopeng.com/
 drivers/usb/gadget/function/f_uac1_legacy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 3f52099a4..7c8d60c7e 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -797,6 +797,9 @@ f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 static int generic_set_cmd(struct usb_audio_control *con, u8 cmd, int value)
 {
+	if (cmd >= ARRAY_SIZE(con->data))
+		return -EINVAL;
+
 	con->data[cmd] = value;
 
 	return 0;
@@ -804,6 +807,9 @@ static int generic_set_cmd(struct usb_audio_control *con, u8 cmd, int value)
 
 static int generic_get_cmd(struct usb_audio_control *con, u8 cmd)
 {
+	if (cmd >= ARRAY_SIZE(con->data))
+		return -EINVAL;
+
 	return con->data[cmd];
 }
 
-- 
2.50.1

