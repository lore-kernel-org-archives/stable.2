Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07B41378D;
	Fri,  4 Sep 2026 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512893; cv=none; b=Ch4kR9RckndpnsmffFsM8/8IQ0+yARxxhJk5j03O7/DinZEdff7wqzwcazrmbs4sG0l1jvAIVlLeAZ1NtIbnbXYVk/Faed3UaP2rv94BfIlmNNrzsgKVrESXmG+vSatnxptn3TImoFWT7R2SF15hYFFmE2gcyNV2dLfJLK7QcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512893; c=relaxed/simple;
	bh=mpp8J/bdPgjdIK7sO/uqXP3TH5N7hJZ7Ozy+GE2tPgs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Y3px0S+NhaKvqDWsEyV1KeoO+7HtVw/bivfGSt8zmbHALOh7/v7AsC9BXw44I7skG4ugikEHtZuYipVAQfLX4B33hbIpXu5oiqphnfzEejBH8zv50GH92wTPp9MaecfGvIOqIe8nh7eud9qQLmspKDSx5xbtw+QHqmy9ho/hBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=g0nx9wQG; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="g0nx9wQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788512885; bh=8NiL8xBnx4VOBYvUVLUUesLzYp6GgKuRjNDNS4J7pLA=;
	h=From:To:Cc:Subject:Date;
	b=g0nx9wQGiabIXzjZKeSN4UV5/afmXJEu6/5MwpipLj0KoqV/gobOdjXomDfgS0Luh
	 +Ml/qQYas+G7kVyI/sygxv//yhRNJC2pUHPGcjzIsEZ7jT3AQGxzGZN7ZQsMM1na//
	 KEV4Y0YN6qSAElcvaBPv3PSN6zazk3phJug66DWk=
Received: from WIN-B62RPRBL2BM.localdomain ([218.76.62.144])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1F2B1CFF; Fri, 04 Sep 2026 17:07:50 +0800
X-QQ-mid: xmsmtpt1788512870tls3ahoyl
Message-ID: <tencent_CAA125B50CDEC8BA29F4B982356549608D07@qq.com>
X-QQ-XMAILINFO: Ny1z5KCLb2WW8KoFC/CiCfd4NILi8+4OakqGMacXJQxH7dMFeBZNNOgxXAu8uk
	 xKyEPdz7N6X0ERgE9r3NT7lAmtnHAjy9Uv+ruRCcHRUG0WDi8fI/8fg/JfUBZjRtnwXOCu5/mzqR
	 xYpwg/7b8ZgmmGP8ztXqZmGWBlKQlmGpJ1Q1NdCUQk0qOMc6rHvExHCGRstmmIT55/td0axh5Mzu
	 YLw7zUBE/LuEiAX8MjaAocRYnDJUfruXzhKE2CE6ZYr9lPxWrCUs0ZBYiVrwYKvLr5pXXqP09CbA
	 pHMjkRmnt0jptu6GEaZgGBVxT7yWggOO4HpNzb1Hh8SScFFcho/DGEO8opxSIdMDUBSi8m7ZuVKp
	 uH0nAmJemU1qypeTToEFRlWVNU5A0qYufPVoIuv4YrEf3q/P9sMFMhb3XJNSfZvHq4PZcgw9ulzA
	 Vq8+N1NUBM59o1Ox3g28CXUGnxO/xs7FW658CxUT+TYU1ulniY6JXIZnOUDQGrySeOfXe/9Kbhwj
	 GOJOUYi2P9mb6LyRjE3y623kzUHy5rjlOK2rm0uW3e5u33EzewB9qpULi/c6cZj98F/g/5gXQgRH
	 au8DaZhKvwKZB7miGaRp7KSvbhRCJrCD8CNt7SI7brkDAkAjpqpmywejUfg1dQV9Z8A2muVsASiK
	 y+n4k8h6GGyNDMZBnkpiFB1oWjLyO4rwppJjdmBcaktXK5rGh3wSIIPIl3ZKEhM910kPV+Yu7z2U
	 RAuzsa0RBKQfZ1DZsB5fsn91/IuMc/JOAhCQGx9LEJteId7ZunwfYDixQTjvTiuWOuY0Ac2Y1n/B
	 qTYtSwWoykMBjMFWr1QzseajNUt0TpAbEe1K/TQpindUTdDgdwQvNkiwY2cmcuFEKYQH6x+tL2Iu
	 weMvB0WGjjHQIuQnDgYv44PU7QpdLXfWvSW0FhMBs4d0xbVf24oAtJ/y3Opp72nkmTo7NEqxevlZ
	 B8dforGdMABOC86USzOawFkle4H6iKQ9mgbfhkbACTEnsrQSgbz1wTVMsY3pQsNIGvlPaiWHYyK6
	 /K/s6TyIvnHvEpy8lvBaye0CdQgzFKwSToCpM97NZsesOP77LIJxQrjEpiW425XMeSGuFOgQ5WKO
	 HLMYl1ZjXQhPO0kcI=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Zhu Ling <zhuling0805@qq.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: core: Fix OF node reference leak on card add failure
Date: Fri,  4 Sep 2026 17:07:46 +0800
X-OQ-MSGID: <20260904090749.199662-1-zhuling0805@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_of_find_child_device() returns a device node with its reference count
incremented. mmc_add_card() stores the reference before calling
device_add(), while the card is marked present only after device_add()
succeeds.

If device_add() fails, the callers release the card through
mmc_remove_card(). However, mmc_remove_card() only drops the OF node
reference for a present card, leaking the reference on this error path.

Move of_node_put() outside the present-card conditional so the reference
is released for both registered cards and card-add failures.

Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
---
 drivers/mmc/core/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index be5cf338bdeb..92ad39c0cabc 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -417,8 +417,8 @@ void mmc_remove_card(struct mmc_card *card)
 				mmc_hostname(card->host), card->rca);
 		}
 		device_del(&card->dev);
-		of_node_put(card->dev.of_node);
 	}
+	of_node_put(card->dev.of_node);
 
 	if (host->cqe_enabled) {
 		host->cqe_ops->cqe_disable(host);

