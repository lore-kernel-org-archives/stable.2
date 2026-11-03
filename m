Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.188.205.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712433;
	b=2dUTkx41W7BBl7R7c7Nt1hGlWhNgNLfKDNOYluxgchSyvyG+csDCSe9qIWnZ5IWfeVER
	 DUBXRB4f/5sw4MRvZD1t+pafZcGLCkiAO7PZDmCi0yfJZpaMVzLvvjIlMPumSseBDZEJM
	 4Jw5C2mzI+6vvFRwql7Rnec8aZX0m8bkPCBc4IOEXtcAGJpXD/dVBsRkB2sJ8K86cY7HT
	 n2MWvxJfvicGoWr4vnrOrfBtxn1hSGdcVES7UlxmCKE7iPzNw+JzXSGzR3z9o/yg3xiJ+
	 CtnpS5PoDpXDrOI8KKj5yvOGWLLbOImQZqp/sGJTZ3Qxjr7M9arSq9Bqe1wM/kY+0cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712433;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=6OP42S54OKX78BiUtyHVgUQAOSoy774DMu20I6vV1fI=;
	b=2O2EE+9VgDvkYp4LxHtDzd0fFZ06RShvicwmPUMZ5wPbtVRqWCa3UANrnU66PtcfPxXL
	 q5FFW+tjr693dh8tS7zZM9ERwQeReYoMtUEB26TT62cTUCAze7eD/SH7Xr/3KUGdOm3cJ
	 9H7+6DUlTv4o0f3HWY315B+xNovqjhVwI4YMW9K6J92OibJY3beuT8IrEhuz2qrDglIf6
	 k7ntB0n2O6eB7vJQMbLR300lOke7HcQfNL92hiZwY3SvBtEy4IjDuwViFY8vkfZwg2u58
	 ynTtAJWZhYPFqOL5K1B9boPu1xOELDArBp8gbddmAu0FJbfttNpaYs9i97QCCoQgwdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	arc=none smtp.remote-ip=93.188.205.243
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A306083631;
	Tue,  3 Nov 2026 13:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A306083631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793712427;
	bh=I33FXfO8Gp7E7V66wFrmBkH+r2omEzUOSnQAEGC4qEE=;
	h=From:To:Cc:Subject:Date:From;
	b=gmzWkpU2ogr0P4r0iopl7XF2VylUpM0uFl2rPtQ4dTB3Lyag9D835hn5UywaPbzme
	 NdwUyqI3l9KY2EejTS+XxJJtrvHpDt2dzx+7kpYhqkqfoPqKYiK3oc+uSVUK7fEKkG
	 26YkRACjjSi5zSywvZrZkYVYGJu0NJxsUKcnHe4B8i/TxUFPOTy8t09k6YoPDWrPj8
	 zIO35DV14ofL86rk+JXh2k/e7YRg+3cyre42t7OJu3G+e1ru6BaVLTLQupsUYHObrq
	 Ox+gPmtFTF3PYxTVQ9xEagMV0K5gr8lZCaYSp+Esrq1l+JtWRAUp/Go4ZLltEC89Nt
	 7QPSSQeiIajaw==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 57E9B1F6FA;
	Tue,  3 Nov 2026 16:27:07 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue,  3 Nov 2026 16:27:05 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.27.207])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jJq9h6wlFz22lT;
	Tue, 03 Nov 2026 16:27:04 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Lang Xu <xulang@uniontech.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Kaiyan Mei <kaiyanm@hust.edu.cn>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] bpf: Fix OOB in pcpu_init_value
Date: Tue,  3 Nov 2026 16:25:30 +0300
Message-ID: <20261103132532.643-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/03 12:04:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207225 [Nov 03 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/03 11:26:00 #28786010
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/03 12:04:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Lang Xu <xulang@uniontech.com>

commit 576afddfee8d1108ee299bf10f581593540d1a36 upstream.

An out-of-bounds read occurs when copying element from a
BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
same value_size that is not rounded up to 8 bytes.

The issue happens when:
1. A CGROUP_STORAGE map is created with value_size not aligned to
   8 bytes (e.g., 4 bytes)
2. A pcpu map is created with the same value_size (e.g., 4 bytes)
3. Update element in 2 with data in 1

pcpu_init_value assumes that all sources are rounded up to 8 bytes,
and invokes copy_map_value_long to make a data copy, However, the
assumption doesn't stand since there are some cases where the source
may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE, skb->data.
the verifier verifies exactly the size that the source claims, not
the size rounded up to 8 bytes by kernel, an OOB happens when the
source has only 4 bytes while the copy size(4) is rounded up to 8.

Fixes: d3bec0138bfb ("bpf: Zero-fill re-used per-cpu map element")
Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
Link: https://lore.kernel.org/r/420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com
Signed-off-by: Lang Xu <xulang@uniontech.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[mdmitrichenko: The older implementation uses bpf_long_memcpy()
 rather than copy_map_value_long(). Replace it with memcpy() using
 map.value_size to avoid reading beyond the source buffer.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-53076.

 kernel/bpf/hashtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4c7cab79d90e5..59f1ffa9a59d3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -844,8 +844,8 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 
 		for_each_possible_cpu(cpu) {
 			if (cpu == current_cpu)
-				bpf_long_memcpy(per_cpu_ptr(pptr, cpu), value,
-						size);
+				memcpy(per_cpu_ptr(pptr, cpu), value,
+				       htab->map.value_size);
 			else
 				memset(per_cpu_ptr(pptr, cpu), 0, size);
 		}
-- 
2.43.0

