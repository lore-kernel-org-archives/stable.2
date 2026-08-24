Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F87422E2A;
	Mon, 24 Aug 2026 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577491; cv=none; b=Xbb5y05ExbZ1RFzZS6GZzz+4TKHifnJFSVxNXtZU2gGr3ALVsXznsS4DWBtxv1q21Zu5pAYCRccgiQHz/WziMK58Vb1Je6HNx+XyaFUmf9cEE0AmheIJdc7Gwo+4jvjlzuLubO7NumC2SUWEVWY8CIR881Ruim3a6u2nGi3FR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577491; c=relaxed/simple;
	bh=d6OnOBzrkn09X1m28Zf7R19kUcxt/cYw1wdoRRIdu+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=saEEY8zFbjTfm5WQrD0FWeBOnWXHA9lvxs2pJ/eZEgsQRNBr3W6pPcIGyhHamyx98W7SqqGjeqI65x3of0imG7iohBpyhgToJ6pwKyj2qAXizQO7ZOuwWf0ahE+1fKubuGKW+4QuQQPvwVVot4ox3NxDnxOnltUtGGYZjL+L6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZXjqHiik; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZXjqHiik"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=E9wIUAtyouMXDIxcf17PDg8GmlgZubRdVIylrYjIKDQ=;
	b=ZXjqHiik87XDgFRJlvB87WA6NMCigdE7lQEpGwPy+ja0AbGxFUiexqHWAUIn1MB8wwds5RFXv
	8Z+zKgYO+jnak4PJW3wfErz9XIhkBSnC7RDn8EKcyax9U2fZyZ3/s40iAV/ohsJIUUq45acuho2
	yv1dClvsvSBImVOTwDQ86Js=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hTB5b2tqlz1prKd;
	Mon, 24 Aug 2026 21:07:15 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id CEC3E4058C;
	Mon, 24 Aug 2026 21:18:01 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Aug
 2026 21:18:01 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<weiyongjun1@huawei.com>
Subject: [PATCH linux-6.1.y linux-6.6.y linux-6.12.y 0/1] ndisc: backport ndisc_send_redirect() cleanup
Date: Mon, 24 Aug 2026 21:38:51 +0800
Message-ID: <20260824133852.328978-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Please consider backporting upstream 0784d83df3bf to 6.1.y,
6.6.y and 6.12.y. It looks like the missing prerequisite for
dbc3791e3b24 ("net: do not send ICMP/NDISC Redirects when peer
allocation fails") already queued on these trees.

dbc3791e3b24 adds "if (!peer) goto release;" inside
rcu_read_lock()/rcu_read_unlock() in ndisc_send_redirect(),
which seems to leak the read lock on the NULL-peer path on
these trees. This cleanup drops the pair (callers already hold
rcu_read_lock()), so the leak would go away.

The patch below is against 6.12.y; the identical change applies
to 6.1.y and 6.6.y.

Eric Dumazet (1):
  ndisc: ndisc_send_redirect() cleanup

 net/ipv6/ndisc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.34.1

