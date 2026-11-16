Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821096;
	b=W3xVif8HXXyVdnFBxpOo/v2YN0Rs4A4lEYDdR6O2rq2csX1ZeDb3og2/H3mfk4mmLdDf
	 vYyvZ3wKbCpV2KKtxjj9e7NubVjEKomQMiJI981PuFQgAU63jii86VRd+CE6HJ/9t0wsP
	 snaYIVCBwRskxYsceJ/c+Qsm44883w8sthfFOUbAwBV6U82Jmlw5s5JmLiy2EDgPgw6Jq
	 ek5Pm6SxLJcCkiarRpNuKH9rit/Zc/m3O9+n2gKuw8JCO8MpXnXEF1Fv7N3YUDC9rctw4
	 6wjDBZmEaiT/2RJpuv3UPKqlsYBJt1VgiwIBW7S0uMCpI3Jn/e0lPRFmWhFRYI4G2vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PsdqLnUGdpIVrBYmye0zPsfH3hdWVwuux/Bo2cpeGrA=;
	b=b005nGq6HxIVMH/peSpREIbVORxpg20/VcpXRoPqmhAu88RweygszrCJQWu8sqzmU4KO
	 qen1ixm3UvXgJml9bW9WQFIsSZGDBivFnkoUDPpr3ykWQf/4TkRLFkAmnkGU3me+Nedew
	 WjQlNMy1OZmYH1O/E/eLbWyTMgs/nWACYs/REVKaCGIN3KScupjINgOMfyv0vCCdHfzxx
	 qkA99UuIyzT0YP0WzYYr5JBmUDX25ktLdfX6KW9QaVtkunBMHy0esk+TstA8kRUT1iyqR
	 2Fovxu97lTOItFR/5o5xB4iPzPGzt2fM9ZXZ11EewFGgIEYpvJOtyE7Q63zKLw0B9AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=J4oqTYKd;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D9606A337
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B4D9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=J4oqTYKd
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so9223021eec.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 01:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794821094; x=1795425894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PsdqLnUGdpIVrBYmye0zPsfH3hdWVwuux/Bo2cpeGrA=;
        b=J4oqTYKdhkb0jNaCJCwXA3+IdJxpD7u8orV+nMya3DxvW+VNn+8CfZ3PExRxLK/gvy
         ezpixVoX696YZTMc0YSOcD1crF10jmUMjPBtamELEHi2dXI/Q0V4EADXXBC2sYsKH9Go
         JwYubWJGJLwo+ebzrjNblarpHGiaDId4wiVIxT52yLCfi3P2iIvP+KodmYypN+wbeBSX
         Wv6GkIU9ZuUzd5JjznapSKUWqq/GoDuREl7M3NbSnel1xdGUZj5l8q5S/TloDa4km818
         aAxfM3bH5dLv63alpABlU5sxYgPWoJqnEAgvZT6PPOYRtD0hNdoZHHFyJJyMlZDs/TUy
         nmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794821094; x=1795425894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PsdqLnUGdpIVrBYmye0zPsfH3hdWVwuux/Bo2cpeGrA=;
        b=02dEz6Vs3L/mZrDo7cLBigxLsbpUPX7EGK/EZlIHZNvTnoJvtf/kngX3nNvnGHsZZ2
         QAnOGW4NabUGhQYkSr5yEQ05SCGzrJGvkwc2tRy5CI6fPOruocyvd2MJglCX3nvii0GU
         cPr69q6Q5p94SNEQVaoYIHJ/r57otB1kN7px0L3wu9Y0zeKUT6BcLjy7/SxB5L0kuuPg
         l5Gs13pOBAuscO2Hg0l25mVTUCzVy6onpfM0Y7UnQgqP+S4hgYKricY36HCtYzCqxAJd
         EY8OW5EEwva5u5XqZvxqXDxP9GhRKtqSPDLNWs3RfD9lILYCE7MdO25OQJZgRFI5vQCd
         xslA==
X-Forwarded-Encrypted: i=1; AL+hErEwizUGqysigCLGBhxcObwsf6HmKRenFZJO5JlE8FG0TDLzbX6/6EaCJ0OeqaYh65X5X4F4Ohw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9V6tkz9j44q6UQwOb89bOTRrKRR6KgXZvEVjXq7IGo2JTW+csP
	ztm3BlyDATx+dOC+KyjxWyvwf3HZulYIuHm/fhgiqgdlgtDlivICB6dmBCrP5ilFZw==
X-Gm-Gg: AZFdTZfYr7rlYHUXa2sS4Min2jv3W10cJ59dIp0KsgX62mEIPRTPoO7YaKssC5UOnM7
	m4f8kmtXnGdasq+HA9Opd8sNJW5RwnYxNKbSNiZSxIzgvKgzGB9Nbx1+GEMKWdQhQb9b1Cj53Ko
	g9CeIf5ow8or50i6N46TOPRA1IxvKsOZb2kQzWsu/MgK58YQYWV7ShjjFNMffg2aDkVKDOhtrCB
	QRKaz1FpFoGMpNPMxAcGpnFPrKEkvTWSofOUUsk0RTqBiJ6JxgtYAOu7Kvy4uzXH4dQArkbHr9c
	tUBivytjokdZQ/HfLzwj8QBwnTJCGWMqwdM6O8KXARl1apTO0Unq98brWxdxEOw6n0mj3VTQL+P
	nqkKo9XrEmWIk873N+OGMWRzZCC6GkhSyTab1lJSFOTRm46E76Dw0z+huHSAb4ZaXWQNT6wcVhn
	ZkJQF2WYqOfHaFF3EjCc0rjYYyaECcmHGJ9fKzwFBkEBxO6174GIF6s3Pc2kuOWhFSE6C538+tm
	QqGJB30YamKv7+kGPvJq6dd47Xc9I5wpjVKB0RAmkldsEfov3OwfuR+Gupj7bYWrl6kT8I7+5ZV
	41O+FqV//LjTGx8r9jZXu8tUbvXRXi+6o7QqSA==
X-Received: by 2002:a05:7301:4889:b0:36c:3b8a:8089 with SMTP id 5a478bee46e88-37967ddd89cmr10058508eec.36.1794821094425;
        Mon, 16 Nov 2026 01:24:54 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32056314eec.26.2026.11.16.01.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:24:54 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/4] virtio_net: zero the stats reply buffer
Date: Mon, 16 Nov 2026 18:24:43 +0900
Message-ID: <20261116092445.3391334-3-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
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

virtnet_get_hw_stats() allocates the reply buffer of the device
statistics command with kmalloc(), and __virtnet_get_hw_stats() parses
the whole buffer. When the device writes less than the buffer holds,
stale heap bytes are reported as counters through ethtool -S and the
per-queue netlink statistics.

Allocate the buffer with kzalloc(), so that the counters the device
didn't write are zeroed. An unwritten record header then has size 0, so
reject it when walking on that header to avoid an infinite loop.

The used length cannot replace the zeroing here, since the device can
also report a larger value than it wrote.

Claude Opus 5.5 was used to audit the driver and draft this patch. To
reproduce, the virtio-net device in QEMU was modified to offer device
statistics and to leave the counters of a receive record unwritten. On
an unmodified kernel, ethtool -S reported kernel pointers as rx0
counters. With this patch, the counters are zeroed, and a reply with
missing records or a record of size 0 is rejected. The
drivers/net/stats.py selftest passes when the device answers with
well-formed records.

Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://lore.kernel.org/all/20260711150754.2918392-1-michael.bommarito@gmail.com/
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20261110001659.1654289-2-kuba@kernel.org/
Fixes: 941168f8b40e ("virtio_net: support device stats")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v3:
- New patch.

 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 57d7a98ecb57..498014773242 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4994,6 +4994,9 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
+		if (!hdr->size)
+			return -EINVAL;
+
 		qid = le16_to_cpu(hdr->vq_index);
 		/* The vqs of the queue pairs beyond curr_queue_pairs lie
 		 * between last_vq and the control vq.
@@ -5068,7 +5071,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (!req)
 		return -ENOMEM;
 
-	reply = kmalloc(res_size, GFP_KERNEL);
+	reply = kzalloc(res_size, GFP_KERNEL);
 	if (!reply) {
 		kfree(req);
 		return -ENOMEM;
-- 
2.56.1

