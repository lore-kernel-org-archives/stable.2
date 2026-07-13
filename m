Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D8C367B7B;
	Mon, 13 Jul 2026 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940220; cv=none; b=cFGe/BVuuv4rU2ZS50Rh/wXzf7lL+7kAqTEXrDgLmYCbBN3OvyB4CXW6d0eb+0bAHUjwxNC2VFPu/uIkNxWOHdQ7ZpyBYPGrEID4lsaXghOvuCmSJX1OkfyfHv483879a9AmK5cMKRTd2jNIEP6aGTFOtAn2O+nMtZ1NjRT/9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940220; c=relaxed/simple;
	bh=X+GUCZSY7VaPmAb1eZdsudVEsWE4IID3rjLysW22MPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JecE+kgQTInIYqyiHjxKAC9UMaI9KnRzKcItFh7zMbAI7h/u5f4PMKGvybewaQ9+A5XkGbNFEgK2Kl5bU8vK/mQLlQQwFKX6ij1Mn7gIay32amk7GEIaLuU/njaaGzLPWD6QPVAZWrzYsZfwIosxD/6K8sWJ159iEoHgCrC0f+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=HJWZBPzv; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="HJWZBPzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=ViK3v
	pQvfAzETPkp1jCexkPmLiNdIgNhDxZkKvpJvL0=; b=HJWZBPzvYNSAOK2kIGY9Q
	noDewbswtmg/Bvmkuxp9eUuDEtCNLS2KrFEgfzfTmXnbXSQ/Lw0TlIm9Epq1FlP8
	osxS4DGkLrt6sBOP28N16pfpuc4vtAy1qosZ892jQE8amjNSXd0rUkdURalbgm/R
	qL5brTyF25zG5HQqywr/Y8=
Received: from localhost.localdomain (unknown [121.229.84.192])
	by web3 (Coremail) with SMTP id ygQGZQAndJFjxFRqT1wkAw--.20921S2;
	Mon, 13 Jul 2026 18:56:36 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v2] tcp: initialize standalone TCP-AO response padding
Date: Mon, 13 Jul 2026 18:56:30 +0800
Message-ID: <20260713105631.8616-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQAndJFjxFRqT1wkAw--.20921S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw47JF13Xw4UXF1fCrWkXrb_yoW5ArWfpa
	yxCrsayr9F9ry3Awn2kw109r45C3yDuFyIgr4UtFy3Gr1DWF9rJF18K3yrKF9IvFWIkFyF
	vryjqr4UtF98ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxE
	wVAFwVW8twCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUs4rWDUUUU
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQEHAWpUpbI3sAAAso

tcp_v4_send_ack() and tcp_v6_send_response() construct standalone TCP
responses with TCP-AO options.  The option length carries the actual MAC
length, but the TCP header length includes the option rounded up to a
four-byte boundary.

tcp_ao_hash_hdr() writes the MAC only.  Thus, when the MAC length is not
four-byte aligned, the one to three bytes after the MAC are left
uninitialized and may be transmitted.  For the normal TCP-AO hashing
mode, those bytes also have to be initialized before computing the MAC.

Initialize only the alignment padding in the TCP-AO branches, before
hashing the header.  Use TCPOPT_NOP, as in the normal TCP-AO output path.
This avoids adding work to non-AO TCP responses while preserving a valid
authenticated header.

Fixes: decde2586b34 ("net/tcp: Add TCP-AO sign to twsk")
Fixes: da7dfaa6d6f7 ("net/tcp: Consistently align TCP-AO option in the header")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: Claude-Code:GLM-5.2-special
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
Changes in v2:
- Fix TCP-AO path only to avoid slowing down other TCP paths, suggested
by Eric.
- Fix the IPv6 path either.
- Link to v1: https://lore.kernel.org/netdev/20260713081842.3119-1-zhaoyz24@mails.tsinghua.edu.cn/
---
 net/ipv4/tcp_ipv4.c | 3 +++
 net/ipv6/tcp_ipv6.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 209ef7522508..2f6ff630a0e5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -971,6 +971,9 @@ static void tcp_v4_send_ack(const struct sock *sk,
 					  key->rcv_next);
 		arg.iov[0].iov_len += tcp_ao_len_aligned(key->ao_key);
 		rep.th.doff = arg.iov[0].iov_len / 4;
+		memset((u8 *)&rep.opt[offset] + tcp_ao_maclen(key->ao_key),
+		       TCPOPT_NOP, tcp_ao_len_aligned(key->ao_key) -
+				    tcp_ao_len(key->ao_key));
 
 		tcp_ao_hash_hdr(AF_INET, (char *)&rep.opt[offset],
 				key->ao_key, key->traffic_key,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index ebe161d72fbd..0bc89014653d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -923,6 +923,8 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 				(tcp_ao_len(key->ao_key) << 16) |
 				(key->ao_key->sndid << 8) |
 				(key->rcv_next));
+		memset((u8 *)topt + tcp_ao_maclen(key->ao_key), TCPOPT_NOP,
+		       tcp_ao_len_aligned(key->ao_key) - tcp_ao_len(key->ao_key));
 
 		tcp_ao_hash_hdr(AF_INET6, (char *)topt, key->ao_key,
 				key->traffic_key,
-- 
2.47.3

