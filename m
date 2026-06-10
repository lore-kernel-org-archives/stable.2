Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12853AD50F;
	Wed, 10 Jun 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083427; cv=none; b=KySCsdz3COOvX6VOv14QgC2PX5ffQLU3rccSWn0IVq86Y6aLfPTDa/A+r/PEHXOeSo5T6qc7o0iKTp1Ei8ETz42fvAhAhV8CfVkBow/PapV2LM00fMp7G8g2UiWNwFgzocG7SHb2b/ZIyakT/Y5yv5MrtdQHdMwvDLk5I8CiKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083427; c=relaxed/simple;
	bh=fbksk0r+l9gUbaGDi2ftc2FYLTOsSKnUCY5rdrXJtvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qao2v+8SfdmgdihBk7m34eEr5XW4cLbXXKvf/Iak/F45q1eC/K0I7iRttN5rlTb6Sd5Mr/QYWxD87unCZ6D0wuk9kAAORwwlO9+K6qWAo5u+YiwAzgns0CftRDYmCah4llrTqj0Oxjz7kNR7jF1fTUwS8GRsKSpn32VUs1QUXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Gs7Fho2s; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Gs7Fho2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781083385;
	bh=4/9GXdd9QofpntZUP+2Yz31YkZfX5I5OmChfTdC5E9c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Gs7Fho2sf4pthFTCs9Gl7EZjBYiIwi1p3HhVZgOg9uYSdhxmlYGtfFzs97OeoU+P7
	 NBNx0Tt8jP3bfzIEAAkX5Xecz3UA7DgBydd6vkGy44pYBxmeqU4ZfAPNbI07pVfNJZ
	 zJ0Cj+F/wkfsPd+DPQpAoCWXpcu0HdFVSeGKozQQ=
X-QQ-mid: zesmtpsz3t1781083367t60c1950c
X-QQ-Originating-IP: uUJTKHLDiyboehVIb+VaTl5+nJDih1sIucCSx6/mUPs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Jun 2026 17:22:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15373450884566247854
EX-QQ-RecipientCnt: 10
From: wuyankun <wuyankun@uniontech.com>
To: linux-wireless@vger.kernel.org
Cc: jeff.johnson@oss.qualcomm.com,
	johan@kernel.org,
	kees@kernel.org,
	wuyankun@uniontech.com,
	sumanth.gavini@yahoo.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath6kl: fix invalid workqueue flags in ath6kl_usb_create()
Date: Wed, 10 Jun 2026 17:22:36 +0800
Message-Id: <20260610092236.40026-1-wuyankun@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MjqaYNLY8QZGud07TBn/4w7nutsls2aMgVqYMXa6nKkxJNcOotmaBjKz
	D24n+zZ9B1w0VQ6tGXCjUrEJpy+nV08eOSMqzkP8XUVkhOKYeh6qBmkV/Q4w7SfDP+hc8h7
	cm87y3ipjxfQoFnSiViTj1Ad3IHqFCeloAn4irfGit9N0exjZH9avFghyHNqODpQWKutrqv
	a+bSWlVnOAj5MvJTJuckqaQ61WmUwPa1ZjzK6UnwbTxpSKO2Txy6Rn6YycOUZk7HCVbxBqE
	JmE/BO/KP5kvJlOpV97WgrnpzsWScNQbHFI1n5bNkNblk8hJT++3/Tty2/lY/lAeYpsIJA3
	HYdA4KEzrquB4WWqZvpBjPOsrp70c4NNBwOBK7bQseK/zk6EFMp6ZOYtYlNSyVwnqh9T+8m
	FctzZnUAy0Exhxmf07toxw6vYqyNkGEfMmiindsoph6BXw7wo+X2mJlNr5vfYKzeH80eg8f
	2decbQAklQziHhxEf0oBk/YH2DKDYnE/YVVPx98Uerc5GC9vv/r6tXiwe2VvMPPdpiCEB0j
	LtSzswlxeMbTyOWY17YKx2x8lt3gEbgR6ez/ERhjvUame3ZruBpapH1HTHKok8RgLQyXT8u
	NynYxsXB5FnDj0hbBt5Nhr9/V0Rhe1j3hi7kVUHZGTuEW0X0dyFsc/VZ3hpohfq38RFR1QW
	Os75Y275YGJjybFlP32VIEBI1yHpPGYhncZ3qKCd9BkxbGyKngjqgtlXQMVMrL4Xa/xL1WI
	YNI6NeUncGsmypeGQUyxh8DkWlrAcptQVBrY9aySb++jZQq/z8sPFRckZz9pcywZ6BNwsFR
	RtU+Sejr6qy/dLf7U0sC+vh8bIf8+wVVOO70hE+BE2AF+eAwzcCjcZKSvdNP9kMn3heM/1R
	gzA9zJoWhaE1/xVvklhZZYRWotL6cOIlQOr+/oWimIgUEGsqS0dPvp40hFehHfxCBUVwkhy
	U0V3kJKmeITGErv5IS2ny5Iripak9mzvC7eqjO3LxgkIym7uCi7dL1tL9oJDkTPb/JJLqEf
	NYQ5XQuVWPqn3MckbTxZLHwbWZg45bSwTs/tI1UP4YyyFFmmQmSPjT+gpHpnc=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

ath6kl_usb_create() currently creates ath6kl_wq with flags set to 0:

  alloc_workqueue("ath6kl_wq", 0, 0)

This triggers a runtime warning in __alloc_workqueue() because the queue is
created with neither WQ_PERCPU nor WQ_UNBOUND set:

  workqueue: ath6kl_wq is using neither WQ_PERCPU or WQ_UNBOUND.
  Setting WQ_PERCPU.

Set WQ_PERCPU explicitly to match the actual execution model and remove the
warning during device probe. No functional change intended.

Fixes: 62ebaf2f9261 ("ath6kl: avoid flush_scheduled_work() usage")
Reported-by: syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a289c01.39669fcc.33b062.00aa.GAE@google.com/T/
Cc: stable@vger.kernel.org
Signed-off-by: wuyankun <wuyankun@uniontech.com>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 79c18f5ee02b..945984c3dbe6 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -636,7 +636,7 @@ static struct ath6kl_usb *ath6kl_usb_create(struct usb_interface *interface)
 	ar_usb = kzalloc_obj(struct ath6kl_usb);
 	if (ar_usb == NULL)
 		return NULL;
-	ar_usb->wq = alloc_workqueue("ath6kl_wq", 0, 0);
+	ar_usb->wq = alloc_workqueue("ath6kl_wq", WQ_PERCPU, 0);
 	if (!ar_usb->wq) {
 		kfree(ar_usb);
 		return NULL;
-- 
2.20.1

