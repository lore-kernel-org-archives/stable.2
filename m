Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794796868;
	b=wvPySFNbSjiYjOcLBBo5cX5LtT5kEOA6C00mOLgpg9qpvEBBwRPOkvJGLSLOMxdwoWpj
	 BhN29OngWIVUOWS68diQNr5RRjCpHu6y6pKvD8wvvLz63z0iEjeAIWQRwZrmR0oHou2GZ
	 vnkrSX44aCfMgwFqtqpslvhZwp3CEKCIqkJPdBP7c3w5n/RFa++T93xw/AGqIsrKYW3zE
	 O3BgBpHq+0Rp8i3tYfeV8Qh3LNtLBGntE3MXYY3xeOOf7e5a1Ae1OiZFSZeQY8p4piP4j
	 8SsS7J9vY89yADRhjIraqEhBuVmyYcv6odyuRNzvejV1QKiGZKm5aMCAQX+x8BItPNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794796868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V2OEn9tAKSN4sXOsuonmkzU2ywS3aimW3cs+6O3cqU0=;
	b=VXwajVmw1AaFoeTNC6G8aUtLxQzR73R5OCixvoRhcjPXHApqLYnmW4/HTE8wGCEOJKFe
	 NhEYDdx59+iABpBIKF1afxmyZZAUhCEGEgSvAQhjWB12biN/pVTmicgRU2DLB2gV+Ao0a
	 y5BRU1wXXRSkcvzRjypDixFhQKOTXdgIb/KgWXGYSZjKu3crt1NZNMGhQrh+JCsvVZeSi
	 Olb0X/8xH0MQ8b6H+nX1wLqj/DP/91QgFbTcCKvlc5IDfyhV71XrbTdnUZ/ucfL4v02iC
	 3ZGTBY4NlEwRhFvijgas0myevggA86WlvQ6PZ/APu19wKfvzzZXB7QWmauHhSXc76sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fu067Wwl;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715D606A31F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9715D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fu067Wwl
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-862a00144f1so513941a34.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 18:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794796866; x=1795401666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2OEn9tAKSN4sXOsuonmkzU2ywS3aimW3cs+6O3cqU0=;
        b=Fu067WwlnNSDgeNFNMmXlAGr3qWf+wNIlIjF2/UUs3AZ8BqwuTRFwaVLXHoMHoitjQ
         OmMHs8QjjIG/z7o5xJVKWU6KoZem/ZW4M6O4f/pOFff6k/kSbzm5+xMc+P5DgKzp2lrM
         5xzY81eA0Pm0GWb57FNA/P65VmrDZkBmNaYBlCvhxUNUg4+9DfHuBCXEXJBWMSW7WYxL
         2ZYuG+Txsf8zqwIpFd2WHnpd6YvQeh2EmkTDGvRGAFWhNRqeeZeFemYypUfXgNV4vsP7
         CVq6WOVQ0m08vDz+xoOssyE3rQms0RWtsbprbqw91wGuEUVfBfVNwbZVYCFYdypjrAPx
         v0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794796866; x=1795401666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V2OEn9tAKSN4sXOsuonmkzU2ywS3aimW3cs+6O3cqU0=;
        b=lUgLIqfo9B37TI8wf2xeqKKHy9rtyMh5aizRKNM3pCc6on/UPC1X26mgNs5XMxz459
         uFDHq2t6VFRk6YT8g5jhqlAPZsc3TGPiHLU9c/EhRh8plkliDMqD/QWaBa4i+tdCwwnH
         oxLU1AmT1/6XZ+b3c+UiLZNh6aO+ymMYVeDtOeSu9MQdKqWVhdZqO1nQDRTgkkPce2Cb
         z21rJIr8djGkJjVaD454S4gCfGrtZq2AXmUaMvkgMZwfwlCOJCgk10B0axfvbnNB0AqE
         H548REuiaY2y6MMrETP3EY/4WH3IhXg3rvIGrR+RyOa320GJlJnn3govLBHJ9aXcTb1E
         IJnA==
X-Forwarded-Encrypted: i=1; AL+hErGuKaaE7Nm/KVkyMBN3H8Yo/kVDA6Fs3UENWP3JBMMFsEx8xqT5fkh27NkbOWFPWMOZ3zgudJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/H1gks7WkabCX4cT7szxjVIYgcCxzX2zWTwtxWBEavXvU68uT
	kkbc+5MZsBEiaDHSGjHtDnrPpbSD6DQobAt8E1mnn45Q+r1QpyJzOVoh
X-Gm-Gg: AYBFou3VRmZTZhVx2EtTizBgHFibBzMZCqR1euIpdNUoQQBZfG+ijoDsOAd6adZUPNd
	gi3valW+39QrTt6hNe2r1jtMGMJV+6guHvGmogag1IimKEbPPJ6kDefutrlq9KNdM8/2W3Y237n
	iqsfzAbkpsbDw4BVJDraW6QB1fpz9vuCWi2d9lER4x35FhdwXb0JR088pWfIfUs1UwTfms/Xdxo
	IbGQ2BeujY2fEEB+NUyNfoPLot1v0xaKWH9iPAcwSMr12HVgpBVD9G3WOlyKeNJYyVqAKpwlYK8
	/8bcxTfbFFMo4Fs4mQJMIgNkcwUXqbZVgxKDei0x63dYR3wS3Bk+IsUJLZAgOBhZQHG+fzR2gRe
	GWPDdLiyyYYrlcnkW0qQRyI+SpYHphvI+dYHvL1298b1900QuzOzIpZrHxOcEqUkjYGz5oUEJLi
	VOpu5htINT7O/Qt0Q3DuwbrWD1zWV0cBKJ/M79XI2qDTRliiaIctc4CNfQ8wHxUXRGgaIU9Zi8/
	+PvgwL5LEI4cN8QK4os/MXDY1NnlOJfEwS29JSmgYVeSh+5ui/usZT5ruQBGij/xF+nTukcKUX0
	oVRYcmE2xHI0R69gc250+xDNuQAAT0r0xc4u66Q3ybW91V6XOC+s2tjxGXugNI2gy1Y=
X-Received: by 2002:a05:6830:a21b:10b0:81c:a6c8:8a65 with SMTP id 46e09a7af769-86289905565mr5197772a34.25.1794796866535;
        Sun, 15 Nov 2026 18:41:06 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862a82c4625sm5441937a34.22.2026.11.15.18.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 18:41:04 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Yuyang Huang <sigefriedhyy@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: fix uninitialized heap leak in multicast address dumps
Date: Mon, 16 Nov 2026 10:40:56 +0800
Message-ID: <20261116024056.1274402-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

__hw_addr_create() allocates entries with kmalloc() and initializes
only addr_len bytes of ha->addr. Dump paths emit entries using the
current dev->addr_len, which can grow after the entry was created:
tun's TUNSETLINK changes a device from ARPHRD_NONE (addr_len 0) to
ARPHRD_IP6GRE (addr_len 16). Both the RTM_GETMULTICAST dump and
/proc/net/dev_mcast then emit up to 16 bytes of never-written slab
memory per entry.

This discloses leftover kernel heap contents to anyone reading those
interfaces.

Zero the tail of ha->addr at creation time, so dumps can only emit
initialized bytes.

Cc: stable@vger.kernel.org
Fixes: a748ee242681 ("net: move address list functions to a separate file")
Link: https://lists.openwall.net/linux-kernel/2026/09/10/320
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/core/dev_addr_lists.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index d827cc21867b..53a2dfa2706c 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -100,6 +100,11 @@ __hw_addr_create(const unsigned char *addr, int addr_len,
 	if (!ha)
 		return NULL;
 	memcpy(ha->addr, addr, addr_len);
+	/* Entries are dumped with the current dev->addr_len, which can grow
+	 * after creation (e.g. tun TUNSETLINK), so never leave the tail
+	 * uninitialized.
+	 */
+	memset(ha->addr + addr_len, 0, MAX_ADDR_LEN - addr_len);
 	ha->type = addr_type;
 	ha->refcount = 1;
 	ha->global_use = global;
-- 
2.43.7

