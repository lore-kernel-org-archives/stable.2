Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212667;
	b=FBPrc43vGbzPcVnINl79d0bmlVsBid+oFso8DcznSiuyKU3iTUngIky1o+v6TL+DjLjD
	 rbYw/YqHgBk3wONGUUNZvkXA1Ng+Kz4orrd4OvxqFJCx6M7kM+16eFcHvCLMuvVmBmTYC
	 qvxusCMrWR1SwYL4tuA+Ve7s+E49EPn9WjXH+GG58agjNTzLUHlf6ofETJZgMq83jrpzV
	 R944ARBrkhnQVytFNIfEsLqukWwcy35cvmlSz7W5fFYICQZBGxQr6tRUqJ11jLCcVy3mA
	 o0qG9XcSeGNUrZMtC0vE3T3uMxWjyUiE0aLfY8SJGJl+q6++24B4gd7CDv2vLBLPbfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pgRFFSuqTaLzsyNQiW1C7k3T12ue183QKOBEGRFvIJQ=;
	b=Nm1MHOsgpMI3cEcKEF2S98qM1YbXG2L1dISMXewaS+Rjmgrcps+HRe7KvCjoZPf+hDaE
	 TU3/2lGyqoBlMeuYqkSdx/ay9oUugtVr0lK3y/GZqVB7hwdUNTY+xzSa0jnPCtecnHmx9
	 Kbo7mXEmLhqtf6usI4qLAzbZ+j1RPMBOxtg1PKk8ePCSqkuI2yHZbvbcWN5TvV21g2fHg
	 DI7WzeroSKCmEjWLRik/q3VKEQ2LYaZaHXO4zYYTvBGiLHTz/hybNksxMZvNTbMXow0nZ
	 kCscM4FjP70MRWfhFI3Dr/N1k9AR2SI/TiZJkcVhzpVAzf3U2gUqS95qIERHmp4sEAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jb7gnq7H;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DB606A334
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F1DB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jb7gnq7H
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b1ce85287aso522564c88.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 00:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794212666; x=1794817466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pgRFFSuqTaLzsyNQiW1C7k3T12ue183QKOBEGRFvIJQ=;
        b=jb7gnq7Hqictrz3L/FLiEVrQ+NRlVrpet0Uz3+I7cxsNZo5UwtsZn0rk2VLcEv+rmQ
         enOG9HdHEtnqIwS7VOSazpVCB3kTEIHhsK4+F0MWqiBaw3B90xJ0M1AaHDx20CKhiS0o
         iV/OseRs9IMuLBWhLgfKe+fD8igMC+6uYV7ncvIjfpuviudWymzGh4C6XxSv1tm6QNbA
         +Unu0mf/Ws1sFiThhU7RApWc/2GQejxOkIe3EOWiWqVFymgDOQ+vBuJsTKx1FqJNzP9E
         FEux7mrRTiDKTPEkI0GRmh5ZjZXm0JcqvTrpQRK75yQ5Sve7hbO2OKLKAqh0f378Bniq
         nqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794212666; x=1794817466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pgRFFSuqTaLzsyNQiW1C7k3T12ue183QKOBEGRFvIJQ=;
        b=BlWj4qy7APcACc4JVVJUTr1JS1WvESLF7rs4IAQ93WhEJZAYYs4qhu5g934gEawA4H
         rPNJepHBNvBBlc8ce+jBWCvWCjyuKWueC/bPDHlBYxmOlemh6y9EDCnGVW0UKtQ0JrUz
         39QeoWWA11LWFiTaNS7UdxtstPW8KStwvpgNIO472LKQL7ZpkttpzMmNJztD75vEu86S
         2zbQKJF+9LBriCtr1RnpvvVosYcXw8GyQYoDGhQs8Hiws0nD7zGHuNVICYWChEQGmoWJ
         QSZGlh7BZMiT7VCwmnFDYaMMheYU48fGFAxYeSz4a+AmoQnNQJbFSt9fQrnCOXovCcNZ
         2plw==
X-Forwarded-Encrypted: i=1; AL+hErFAxnOUreSVuf5IUfUpkvsT98dnywjh26PBsPvpANC7aUMbZNdk0X8sCmr0N3ZRatg5KViDNxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZyeZ7rVQh7D3arsafoEukOU6Crea2/Gipu1rPc/s9Ytq4XPa+
	iKK/usv0a51SqDv5rCnHRnCcxPs/lKm4N8egdXcWm8W1FuScSy9mDB9Y
X-Gm-Gg: AYBFou3n6mDOjPrSStq3Dgk0z5VwA34Gwz4cLswJyxn/rhHVqj5MA8VG9V5mcymbRbu
	q1d3EUH3w2siyUSYOp6kgw0kZI4EKUPhD6oJoqRTUwSUBWnCk/ElhdVAubdH0S4H7k/zhzuXPw/
	FFZ5vV81ZTII1cjP1EEtGOLktsgY4+9npGvqjEV+gugQJOvuOBNjwUh7N8O27M5EELe3awW2C7D
	6HkVuxAGD3wBGZ776fqhgwFcuzz7hBvoq0g5JOxsQelzsMJ0MEFo3JcB8A8uTTtXkli+5qWKPvz
	/O8WdK4lekT1trl2nEJrxxaMor8yUBNPy73bBnSm7udMySJB0RbMlYafj8oxf5uKSyde1WR+rVi
	N05jBwpfbIzIJg8gYV8eWPlxIz5pbNuy+2ERckymu1Hm23QrHLFYBVK7F/WOtvxU8/PibSn4YuJ
	DpxdgAne/30qKMmqybYs+NqVlifmUHkJcG1tZfJ+P0fQPKkklq5Gp2wOUW1sZ/en65Mh5/0toPy
	lMyPeDUbEngfu12jSknrDMe1ch0vtM9vELALfZXpfaPuXF3/xR1pJrOlxktgM+5f7ovib20Spvc
	Up3zUhz9Cf13qjv6X0+S5J3aQvcp9fOdvu3ckj6Y06XxlfnxoH4sPO39mnBrNSwZBMe1FPd1Ig+
	wcVfoetRYMNE5gFsH
X-Received: by 2002:a05:7022:5f0a:b0:144:fd7c:84fe with SMTP id a92af1059eb24-1b39fec31bamr5133858c88.35.1794212666093;
        Mon, 09 Nov 2026 00:24:26 -0800 (PST)
Received: from s1lverbox.orsomething.local (47-144-201-183.lsan.ca.frontiernet.net. [47.144.201.183])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3731487edsm12521742c88.2.2026.11.09.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:24:25 -0800 (PST)
From: Jean-Paul Sergent <jpsergent@gmail.com>
To: netdev@vger.kernel.org
Cc: Jean-Paul Sergent <jpsergent@gmail.com>,
	stable@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH net v3] net: dst_metadata: fix memcmp overread in skb_metadata_dst_cmp
Date: Mon,  9 Nov 2026 00:24:10 -0800
Message-ID: <20261109082410.206140-1-jpsergent@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Commit 3fcece12bc1b6 ("net: store port/representator id in
metadata_dst") dropped the options_len equality check when converting
skb_metadata_dst_cmp() to a type switch, so the memcmp length is taken
from skb a alone.  When skb b carries fewer options than a, the
comparison reads past b's allocation.

Hit in practice with Cilium geneve GRO aggregation, comparing an skb
carrying 12 bytes of tunnel options against one carrying none:

  memcmp: detected buffer overflow: 108 byte read of buffer size 96
  WARNING: CPU: 0 PID: 15 at lib/string_helpers.c:1036 __fortify_report
   __fortify_panic+0x9/0x10
   skb_metadata_dst_cmp+0x11b/0x120
   dev_gro_receive+0x303/0x620
   gro_cell_poll+0x67/0xa0

Restore the check: unequal options_len means different metadata and no
aggregation; the memcmp only runs when both sides carry the same
options length.

Fixes: 3fcece12bc1b6 ("net: store port/representator id in metadata_dst")
Cc: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Jean-Paul Sergent <jpsergent@gmail.com>
---
v3:
 - Restore options_len equality check as a one-liner; drop two-stage
   compare entirely (Ilya Maximets).
 - Update Fixes: tag to 3fcece12bc1b instead of 69050f8d6d07
   (Ilya Maximets, Sasha Levin).
 - Add author Signed-off-by, drop Reported-by (Ilya Maximets).
 - Drop redundant Closes: tag (Ilya Maximets).
 - Add maintainer Cc list via get_maintainer.pl (Ilya Maximets).
 - Remove superfluous in-code comments and trim commit log
   (Ilya Maximets).
v2: https://lore.kernel.org/netdev/20261003005449.2675.3@jpsergent.gmail.com/
 - Fix subject prefix to [PATCH net]; no code changes.
v1: https://lore.kernel.org/netdev/20261003005449.2675.2@jpsergent.gmail.com/
 include/net/dst_metadata.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index f45d1e3163f0..02fffbb85099 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -116,6 +116,8 @@ static inline int skb_metadata_dst_cmp(const struct sk_buff *skb_a,
 		return memcmp(&a->u.port_info, &b->u.port_info,
 			      sizeof(a->u.port_info));
 	case METADATA_IP_TUNNEL:
+		if (a->u.tun_info.options_len != b->u.tun_info.options_len)
+			return 1;
 		return memcmp(&a->u.tun_info, &b->u.tun_info,
 			      sizeof(a->u.tun_info) +
 					 a->u.tun_info.options_len);
-- 
2.56.0

