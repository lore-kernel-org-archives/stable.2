Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC123A873C;
	Sun,  7 Jun 2026 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780837301; cv=none; b=KbDnwxvP/D2Fx4lBKyjDmgh9l4O76AwrC/nyKSIQE18lNLSVWmMmQv/U88Lp5mzpv8q2YJwDppyapkJh7QLgkatE2VLlrnYSKuoksjzvy+yw7upOks8qItN038pf+Og0qL4zXOTMipOaIbJrigoh56k27xgS7ky1rfhp4oWn8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780837301; c=relaxed/simple;
	bh=sCQWvrOwyzOu0il+mTFkDGuqasbhT3DyEXaV/X+xHAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LasAhs27CDAcZGsosT8v63FaaQM2WyJV3snsxCMvIvEMnPhiD9NqoU75ZCOtNzhtiDjmgS8258/zX9h8MLLq07yqH8Zb/Y0zMHXu3kz8CU8o5mPygwIfusWRm/vtd6a6sanwz63JF8mMoQfh3W3Pr0QfUnkFzXz08GGHhgvuLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=jMwSe8gS; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="jMwSe8gS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=wy4Pj
	RKnyBWkiFf6A6DugXQqGmLPNMoUQDUhuKI3GcU=; b=jMwSe8gSIDf+ARf8uzemg
	ckDTkml6h6Y40vnF+LV8vucHKTTVYMvjgGdcsS1ZTjRyt7dB5cQmv9r0I3uB1K65
	wl5CZXQXCfiCZPFm8UvgAaBRcHzWOmk8xYoeW9XQ5DofJAlJY99/9BV5mKvAKAXC
	5BS6p6fFlJ6ye1fQHvDLyY=
Received: from localhost.localdomain (unknown [101.5.11.216])
	by web3 (Coremail) with SMTP id ygQGZQDHE5GlayVqeLw4Ag--.6443S2;
	Sun, 07 Jun 2026 21:01:25 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: v9fs@lists.linux.dev
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net/9p/usbg: Fix use-after-free in disable_usb9pfs()
Date: Sun,  7 Jun 2026 21:01:16 +0800
Message-ID: <20260607130118.16579-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQDHE5GlayVqeLw4Ag--.6443S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW8urWfuw4fCw45JFy7Jrb_yoW5JF4kpa
	y3JFWFyrZxWryjva4ktr1vqF18Ar4kAryxtryjg3sxuanIqw1ktF48Kr9YvFs8A392ya47
	AFs2q3yDur1kurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0Jj7SdkUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQILAWokna+N0wAAsr

disable_usb9pfs() frees the IN and OUT usb_request objects before it
disables the corresponding endpoints. If either request is still queued,
the later usb_ep_disable() call cancels the endpoint queue and the UDC
driver can still access the already freed request.

With dummy_hcd and KASAN, this is reproducible by queueing the OUT
request and then disconnecting the configfs gadget:

  BUG: KASAN: slab-use-after-free in dummy_disable+0x2b4/0x300
  Read of size 8 at addr ffff888009702400 by task sh/1
  usb_ep_disable+0x8e/0x1f0
  usb9pfs_func_unbind+0x193/0x350
  gadget_dev_desc_UDC_store+0x135/0x280

dummy_free_request() also warns because the request is freed while its
queue entry is still linked.

Disable both endpoints before freeing the request objects. This lets
usb_ep_disable() cancel any queued transfers and invoke the completion
callback while the request storage is still valid. The request objects
are then freed only after they have been removed from the endpoint
queues.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/9p/trans_usbg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 1ce70338999c..5d0d6add150e 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -278,6 +278,9 @@ static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
 	struct usb_composite_dev *cdev =
 		usb9pfs->function.config->cdev;
 
+	disable_ep(cdev, usb9pfs->in_ep);
+	disable_ep(cdev, usb9pfs->out_ep);
+
 	if (usb9pfs->in_req) {
 		usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
 		usb9pfs->in_req = NULL;
@@ -287,9 +290,6 @@ static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
 		usb_ep_free_request(usb9pfs->out_ep, usb9pfs->out_req);
 		usb9pfs->out_req = NULL;
 	}
-
-	disable_ep(cdev, usb9pfs->in_ep);
-	disable_ep(cdev, usb9pfs->out_ep);
 	dev_dbg(&cdev->gadget->dev, "%s disabled\n",
 		usb9pfs->function.name);
 }
-- 
2.43.0

