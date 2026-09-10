Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0B1C3BFC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009876; cv=none; b=k2KCedhAyRvuSHBa99HEXkYy9RPaUi8ClwHyOd26jgp23zmq3kK3PmWMsqkMj7o0aodQ1b8lDOSSK9UBLqyLoFIMz8xAxUPdAHqNSayXlcTprDh7/j/qU1WoR2UskSZejt2wR5aDTYLK5yXWchWay9YQO+oIK1hRC39p4PfERTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009876; c=relaxed/simple;
	bh=HHaP3JdzC+XP4NNFD+TmeX4WXk/1Ya5ezPKmN80QIVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROVxCYQyYalijSyONTQVbk3nthE7bhmDIT6RKSuJ9wLj0WOncg8L9dW5psXJ/Y2dwP86t/EtTLg7amVzWgv+0awGMTd6d2BKz0pkNmm6nmQhHnHUoH9H8xjdcyGrTrw37rIo4ghRU1q5eCzHzDPZ5iTGAWAEQgf/iLv81w/3Te4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=JcsXRB3S; arc=none smtp.client-ip=91.218.175.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="JcsXRB3S"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HHaP3JdzC+XP4NNFD+TmeX4WXk/1Ya5ezPKmN80QIVQ=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789009869; v=1; x=1789614669;
 b=JcsXRB3SrsjhRWbdWRUwz7oo2uxF9xYAO/z+YRIoIXjq4eJpOo5SzVQNSZuZF6S02wvGMj55
 R6XlKwFivrGN+4pXAWFgNCCPORLo/HP5hm4uFqJVg/xdrSR8Ikc8VusEcYGPhNLcbBKz1dyh/4i
 9UFAGFmYbiqvdm60cOYOgsocu4xlCdhbCOTcvXJta3OWnveVwJYy2ZYHBRsUuTYvVMmUS8R0TPx
 GRN3enx3g/OPVvgQ7L0LnWTqsa4YPRvAqienjC8TdkyKWehNLYVQDZZ5L+o2+vaUKqTqN8kiKLk
 fIbFqvZvY5NuCOJMvg+LBgViZXQDZN4O6D5UDaKwSwuQQ==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 15a374e8e8a4eb93;
	Thu, 10 Sep 2026 03:11:09 +0000
X-Mizu-Trace-ID: 15a374e8e8a4eb93
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Wentao Guan <guanwentao@uniontech.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 0/6] wifi: mt76: mt7925: cancel mlo_pm_work at teardown
Date: Wed,  9 Sep 2026 20:11:00 -0700
Message-ID: <20260910031106.25906-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two are marked for stable and were not picked up:

  81faf578320d ("wifi: mt76: mt7925: cancel mlo_pm_work on stop")
  2889e84282dd ("wifi: mt76: mt7925: cancel pending mlo_pm_work")

The second is Wentao's and catches five paths that mine did not, so
thank you for that.

They reached mainline on 31 July and first ship in 7.3. Neither applies
to 6.18.y, 7.1.y or 7.2.y, so backports for all three follow, two per
tree. Each applies cleanly and builds with no new warnings.

On a multi-link connection the driver schedules a job five seconds out
while setting up power saving. Nothing cancelled it when the device went
away, so a removal inside that window leaves the job to fire afterwards.
The code has been in every release since 6.15.
