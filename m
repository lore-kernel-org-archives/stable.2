Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE582E229F;
	Wed, 29 Jul 2026 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291323; cv=none; b=p/qtr9GRSWCc3N4kePfM/PVHhpyeOHh618MVuwjcbr3naO82JCPsjfP/mDQLrUTgWjCRZ9CTUDTTUVG7kSLFBfNP3E10myyapymftu9oePyc6blyiqeQf7119vXslXES7V1X8Sx8gPtsh3JuJ7wu3HCkFXOyto9z1MgrleNHbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291323; c=relaxed/simple;
	bh=lfcUSZWSEInKpIE+V5Hpsr7RK9lUW56CjwB0fkrUCew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGbx7vtPFD7bskIzx+CixboUNCzqWY5tUyLU1D2D+JY4SDu4RZcqlnhoxCsy0TxeNAqDpizndjzkreyj5E5S5/SQ7+FTfOGyMlFR8FNCpOWRtjXi95xQke9pw+9pxrzPfBehMBocGa4akU+Sy5A6X9aFijdkwDJGi5MZKfU1cP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5478a6fc8af311f1aa26b74ffac11d73-20260729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c11f1227-5466-482f-b66f-d46df8c7cc76,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:45d5c5d40802af9cef4ae5aa85cb6973,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|850|865|898,TC:nil,Content:
	0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5478a6fc8af311f1aa26b74ffac11d73-20260729
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 907292887; Wed, 29 Jul 2026 10:15:12 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: joe@dama.to
Cc: 13667453960@163.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ralf@mandelbit.com,
	stable@vger.kernel.org,
	stefanha@redhat.com,
	viro@zeniv.linux.org.uk,
	will@kernel.org,
	yijiangshan@kylinos.cn
Subject: Re: Re: [PATCH] net: datagram: fix integer overflow in zerocopy_sg_from_iter
Date: Wed, 29 Jul 2026 10:15:09 +0800
Message-Id: <20260729021509.162079-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <amjLIvXcwsret4qR@devvm20253.cco0.facebook.com>
References: <amjLIvXcwsret4qR@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joe,

Thanks for the review, you're right on all points.

I verified that import_ubuf(), __import_iovec(), and import_single_range()
all cap at MAX_RW_COUNT (INT_MAX & PAGE_MASK), which is below INT_MAX.
Both callers of zerocopy_sg_from_iter() (tun.c and tap.c) require
msg_control to be non-NULL for zerocopy, which means the socket sendmsg
path -- always through import_iovec. So the count is always capped, and
my "io_uring provided buffers" claim in the commit message was wrong.

You're also right about the type inconsistency -- leaving copy as int
defeats the purpose, and skb_copy_datagram_from_iter()'s int len remains
a problem regardless.

I did look into io_import_fixed(), the only iov_iter init path without a
MAX_RW_COUNT cap (used by WRITE_FIXED, SEND_ZC with FIXED_BUF, and
URING_CMD). It can produce count > INT_MAX. But this is by design --
BVEC iterators reference pre-registered pinned pages for zero-copy, so
the cap for copy_from_user limits doesn't apply. I traced the consumer
paths (generic_perform_write, tcp_sendmsg, udp_sendmsg, TUN/TAP, block
layer, etc.) and they all handle large counts safely via their own size
limits or chunked processing.

I'll withdraw this patch. Thanks for pushing me to actually understand
the code rather than surface-level pattern matching.

Best,
Jiangshan
