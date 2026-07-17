Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6A3CB547;
	Fri, 17 Jul 2026 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274113; cv=none; b=deMmZfkL0EhTKp/LJxmO3j8+La7p4bU+ScaB5Ju8WEWYm0AJQ6wOdrYwlHNhSWpBBmjDr9PtJscZ4GSwcDddsz6/ycJ7tvU30A6u41b5xWEDkpSG5S7hFPniOZs7jyOwQNLAG8F706CyldQ/4dak+DjlBWFh99g3sHutTCAEryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274113; c=relaxed/simple;
	bh=8SKEyKMndiTDRqfCdBwt9rcLVmSwLTh2lFDRogWrbaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q4xf60j8gbJjDUwTtjZVy4UipXFskIY1OtnZqvVo3Wmn8ewOT7/VwzWy6h7Uyeo3GN9i+xLEb9viqJ37GUaXtmUZSAlilN2Bhdt6MfphWG2oCa2mSkIqtm3NoHsv1EMYm17sH8Q11L17QhptFGpYW43oYonMzawB3BvjRABiguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=WsM8wkYj; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="WsM8wkYj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=4sYHR
	0xVe0LOZkuozwLuH94zFR49TXLrdUIOJTadZJQ=; b=WsM8wkYj/gnT37xRZL/RD
	zixj1n108bb0xI/40c5FEn8QxZg/Jt9DO1p58OF55yFCh1b56+/sMgJTC/Pp5ro8
	NoYpm06sIYx4Lu8jQ9x7QHUTtV3CFlYO/UI+S9Ij46ztGkIvIod9+97/ZwhQ4NxO
	NmCds9xuLbKuC+VbcyNn8k=
Received: from node118.platform-default.svc.cluster.local (unknown [36.102.215.18])
	by web2 (Coremail) with SMTP id yQQGZQAXFbeX3FlqabEKAA--.18314S2;
	Fri, 17 Jul 2026 15:41:13 +0800 (CST)
From: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	yyxroy22@gmail.com
Subject: [PATCH net] ipv4: reject impossible oversized fragments at queue time
Date: Fri, 17 Jul 2026 07:41:09 +0000
Message-Id: <20260717074109.686170-1-yangyx22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAXFbeX3FlqabEKAA--.18314S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8uFWfArWUKw4DtF4rGrg_yoW5XFykpa
	9xtFykCr1rGF97Jw1qvF4Iq3y5Gr4kXa1jgryFyr93Aws8KFyvvFW0kFyag3W3KrWkZFy0
	v343ta98CFZ5JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwV
	AFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRSD7-U
	UUUU=
X-CM-SenderInfo: 51dqw5r0ssqzpdlo2hxwvl0wxkxdhvlgxou0/

ip_frag_queue() computes each incoming fragment's end offset and may
store it in qp->q.len without checking that the fragment can fit within
the 65535 byte IPv4 datagram limit, even with the minimum IPv4 header.
The only 65535 byte check lives later in ip_frag_reasm(), after the
fragment has already been accepted into the reassembly queue and has
updated its state.

A fragment whose end offset exceeds 65535 minus the minimum 20-byte IPv4
header cannot be part of any valid IPv4 datagram. Letting it update
qp->q.len leaves the shared reassembly queue with an impossible expected
length. A later legitimate two-fragment datagram sharing that key can no
longer complete reassembly and is not delivered.

This was verified at runtime on Linux 6.12.93-0-virt. A same-key
oversized-fragment injection (offset 65528, payload 8, end 65536) drove
legitimate two-fragment UDP delivery from 8/8 to 0/8, while a cross-ID
control stayed at 8/8.

With this change applied to net main, the same-key test delivered 8/8.
A valid 65535-byte datagram with a 20-byte header was also delivered with
both in-order and reverse-order fragments; its 65507-byte UDP payload
was intact in both cases.

Add a per-fragment bound check in ip_frag_queue() right after computing
end and before any qp->q.len update or skb insertion. IPv4 always needs
at least a struct iphdr, so an end offset greater than IP_MAX_MTU minus
sizeof(struct iphdr) cannot fit in any valid IPv4 datagram. Use that
minimum-header bound rather than the current fragment's IHL because
fragments may arrive out of order and the first fragment may carry
non-copied options that later fragments lack. The existing check in
ip_frag_reasm() continues to validate the final length against the
actual header length of the first fragment.

Drop only the invalid skb so an existing queue for the same key remains
intact.

The issue was found by Yuxiang Yang, Yizhou Zhao, Ao Wang, Xuewei Feng,
Qi Li, and Ke Xu, with assistance from GLM-5.2 by Z.ai.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
---
 net/ipv4/ip_fragment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index c790d2f49..32e5240a5 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -291,6 +291,8 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb, int *refs)
 	/* Determine the position of this fragment. */
 	end = offset + skb->len - skb_network_offset(skb) - ihl;
 	err = -EINVAL;
+	if (end > IP_MAX_MTU - sizeof(struct iphdr))
+		goto err;
 
 	/* Is this the final fragment? */
 	if ((flags & IP_MF) == 0) {
-- 
2.34.1

