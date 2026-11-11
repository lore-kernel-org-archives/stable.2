Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396757;
	b=BMXnhit5If41UkVjlYDgQb1dymzJl+8W84iBkh86bbOs+bVw+0ds1ZoknJJdZ1hsJnJd
	 udeZYj65uV12Wivz81QqlxCm+mtep3zXgdPl5FhVjdT+Uafw4PG6E939AUFzykwoI7Cdn
	 d5Z5kASw4oaxC/7e4it6LvJebxs5REyzeFweE/bhmk/PEXdVV05yYAq2q8qkwuKqxlF4q
	 2/i0DYrv67F4QVPaqMDPcPZ85/ZLrcD81sNYwKkb65wNR5bj4Y2hyNpm6e7s0xUNqoQXs
	 AL9iK8AYmcFiW6xUc9/u+mEpvskWh1c30hOPwt9ByHW/fvrIsj7UaaeMBIUKG07M9Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396757;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gEGIMyONOPzTbb4no4evpvp0Mhg4XBHb63YUWPNudjU=;
	b=yMX4hjDx+2ATKlj3dksrK4bwc47L8Pancd13BRbjkjnWI676WcNwaZKv25sjSqwdBd3Q
	 glAoqjB+KE9bSqts3SLoOYdF5ikEbwv/dSpF5ZwEE+UswsoiUlzGHUfMC+c/HgDLc/ERj
	 OXhaCYIlk0Kpz3I62OJekjZm8v7HxPCe6lhkBhgXQ127wO+R5nROLXUi7uJygv69o610+
	 iKOiCmPxow6sl4YL73tO7LnR7LMysVbEa7SCEVtSAsirTSgkf1Z+nzPNOt7rZqxa4fPjn
	 iQKGOHSd3iJ1gQNtBoy4MVlclKXjZBfasuZLK3dpkBzdu1xL8fl+3TtynHBXjFOpozg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rlLTrVC6;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47375606A31C;
	Wed, 11 Nov 2026 11:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47375606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rlLTrVC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rlLTrVC6fcR8PHrZxnoSGo66RhQajbvEeEW06cxVXz9B70ZDRdUsAeZWoTH/4L+WCiErPHqh1dW/i
	 BpfRhZc/t5LrGa1fujY5TX9XkOdo/2n9aBeCtxK1SB1uUIwI44cyosuMIMx4e6uZYQ+Y2q9bTlxHF8
	 Xffvq412sHamYfNk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af4524562d-7881a;
	Wed, 11 Nov 2026 19:32:26 +0800 (CST)
X-RM-TRANSID:2ee86af4524562d-7881a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af45248bec-daeab;
	Wed, 11 Nov 2026 19:32:26 +0800 (CST)
X-RM-TRANSID:2ee96af45248bec-daeab
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH net] net: wwan: mhi_wwan_mbim: fix dangling links on registration failure
Date: Wed, 11 Nov 2026 19:32:13 +0800
Message-ID: <20261111113213.280066-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

mhi_mbim_newlink() adds the link to mbim->link_list before calling
register_netdevice(). If registration fails, the caller frees the
netdev without removing the link, leaving a dangling list entry that
RCU readers such as mhi_mbim_rx() can access after free.

Register the netdev before adding the link to the list so that failed
registrations do not publish a link.

Found while reviewing newlink error paths. A UML/KASAN test module
using driver wrappers and a fake MHI context reproduced the use-after-free
in the driver's RCU lookup. The fix passed the registration-failure and
create/delete tests. Both UML builds passed with W=1.

Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 336f897..846b317 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -561,6 +561,7 @@ static int mhi_mbim_newlink(void *ctxt, struct net_device *ndev, u32 if_id,
 {
 	struct mhi_mbim_link *link = wwan_netdev_drvpriv(ndev);
 	struct mhi_mbim_context *mbim = ctxt;
+	int ret;
 
 	link->mbim = mbim;
 	link->session = mhi_mbim_get_link_mux_id(link->mbim->mdev->mhi_cntrl) + if_id;
@@ -575,10 +576,14 @@ static int mhi_mbim_newlink(void *ctxt, struct net_device *ndev, u32 if_id,
 	}
 	rcu_read_unlock();
 
+	ret = register_netdevice(ndev);
+	if (ret)
+		return ret;
+
 	/* Already protected by RTNL lock */
 	hlist_add_head_rcu(&link->hlnode, &mbim->link_list[LINK_HASH(if_id)]);
 
-	return register_netdevice(ndev);
+	return 0;
 }
 
 static void mhi_mbim_dellink(void *ctxt, struct net_device *ndev,

base-commit: 8d5ce4751fad9499ea408163af7f410f18a85782


