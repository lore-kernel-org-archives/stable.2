Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509347;
	b=QVkUI6HwyxoDhxX7EkV0yNFJOGqH/GObcfrs9K7mjiS7A0VwU4LQnc4ZpblT4PByQqaG
	 Q7KONt4eSLSwhgZjyVCBEM8KI1uTn0o9caA3nyN+jDwk6OPO9bgijdS123e1zPzuJ0GrP
	 HLovmveuWvq/8sG7KM8mCgWNSaTsrDmcfVUw6ceThvFy5Un1pdnuHvaDoFkGI1is2axY5
	 3Yfjqg/zKipXtet+DkdOVXYGnAE0t0Xz9lxGlBUi0Zgl2tlwhgdU6Au+21xdfEzJLnUvc
	 oyyO5Q1ybP2XXM0yt2QSjgoc/+5OklJA++dTIF0cqYJiRmWf+3qoiyeV7o+ymjF3W1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CvPBfBZyrWo/IURjWNoOSH2bYaPSh+KUwqyaCMmfae4=;
	b=YDtuXoV5jvyeod38VUWePIunZ+EniGFd15xZ4rGRXuC7RxKGvpsZSobIcImVX3ISUstn
	 C/CGGvTG5lyHwyDdGoim7Rg5I2brEp2tgoJVqP4udFfxGx+jmQjS/jnumTvdUosWGcyli
	 +7VlqUgtJSHnGxa6WePs42ErKy+vR7hez9S6xEgwXgPyz70E/mME2Npjuv+m959kEosYh
	 GYdef4GpJFffz4V14DwnFXViX/ssVOA+ZTTuNi/k65+oUYKXGeasn7U0tawu5idhxIOBk
	 BiQmittGNKYa/KKIbiXga5e//E1OvnI/yPW9TWDJU/int4SHVRtFgX7UyjKQW1a9Flg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiDm7SXd;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2128606A32D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2128606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiDm7SXd
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so1993147eec.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795509344; x=1796114144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CvPBfBZyrWo/IURjWNoOSH2bYaPSh+KUwqyaCMmfae4=;
        b=BiDm7SXd0FZcFuAA7mPowtUz3t+gCus/FpUals00iUR4Rxq1X/PCGRPOVzYmxWGTNb
         xlKvf0OVES+TriacQ3hV0ZEpcmwwBCvZN5n4FftfaDUe+hT4ovb7jSxT1LNNHHOak3pS
         D94SVu4y6lKy7GPZoPb3xfKghkpcWBO0EuzHJJh+uNQYhmtpAqLwJTPf2ku2BV8xEkzF
         XFH6DrPQyG7BeJ5VCd8vSnflV1pG0X5XLhLbVX+t+kPpaav0nFulscHdrO3hoTO8ORmf
         sBpbcmVViHjrmYtufIy+YhsFVKodxa7IhJsjzSmUR8RCH031avwKieiIHIRnHgTgDFan
         1itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509344; x=1796114144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CvPBfBZyrWo/IURjWNoOSH2bYaPSh+KUwqyaCMmfae4=;
        b=rTb5ZQ5ddHOx1706nEHdscpwrhlMtxh3Zj40aXFQ9RpYCYKWvJZ/E+o2uwUV6UcxgV
         oaQQfaD0+nG6qGgIbrcxYOuthTdB7F1yo9kgEMh23qQBxk9zxHGIjggUcFO0KZp1RDsl
         ST5y4QIlEX6nRhmbw1KaeakivpuYTiyqvBnJxTBVjdzd0qRWj8CQmVinack0KPJrobwY
         FqOAeJ3af2Z/Ehm3MzdFnh2RZ91BvQecWoxrt3y7TzSANqr8KhRpkGC4aE17HZekNk2A
         r6RWgKRvI6lrNHvUPmw9M0tSVxAoMGJAh5C8cDYKHAKQ6/OJj+16si5uUrBxJvUKomaU
         JARA==
X-Forwarded-Encrypted: i=1; AL+hErFCwxLtidCuBJoO9dhWsCCaFpahm/KOkqjNp4G5ORuXXDiGdltavaJwSQBb8+FQLVyivCNIiXw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OfrLZ0yW6F++d549rmqOeFLAgq3KTHG5oh/77lyNBDwAFA1Ng
	YsjhaffaRaFsGGqZsWT8y7jJU4JyCq6Eg1s5yzxjJdelK9DLGfkV0Lyt
X-Gm-Gg: AZFdTZf6cyTf5LtVjXVDpvRO0DplPtMKUTkZq3Mqc+3x1CqRmcbym9PPpHyU7Pih2os
	0JmDkZu9j3pknY5CTHjxveYjmeTaDzDbORdgx4sWVD903KfpU0ZVJYaU6DjoUl56hm7YyMKRuT2
	/AI8J0IqLQSoFSeZ3Wwk+rlXMqxjt8SsUtr03ll2VOe13Rmzt1T/kyGcKAnxGK7DXVVo0QRsDq9
	kgC4Nz3Zzb0WEEiGXJMCfMSrV996qUqyLYtg4ZTf3pdX8gTKvNPrfWcrHqFIeQXGO1EQ7+bEQY7
	iZko1jvpcJEFGe2/YiyxQUvfpaGohvVNvjhJg7YxVCbCtjoD6/vbnZIf1YBspogKe0tUi+6kRVL
	g0o2DIAFRblRp4Mg+EG2cfIaTs1FuIq9ZXFOPd8HSB8uatNX5QArKAohry+v9qUvLkNnRSzViqb
	wVsit+detcxgLqXwqSzdVw/sOMiNNACw9y+NH1yHZlm4wf9W9dCnI6pdvtbiDU5Guk0G/Xa9cTQ
	BrOfpFEZjbKjvlIIXFmlN0iZ9mEW24XR0YtFkzG00uX4JbhkWzyICx5Peb9TbosZVbb/OK3cOaT
	RUC7wdoOOF39oT14dIrcc2U0QXCgJX/vzUXOAgdqXkMbDdttl3YS2dVoe3rPHVge8ALLNm7VjEQ
	y7RsETxf83HzmSdrmdj954222QaCxz3KojQdtPFkmR12NoSa4BvlXVifqvMwialxKwRDcP1kC3T
	i7o1h4BED4/CQdJBYttiE=
X-Received: by 2002:a05:7301:c016:b0:386:5adb:ac01 with SMTP id 5a478bee46e88-3865adbb1aemr14055119eec.24.1795509343906;
        Tue, 24 Nov 2026 00:35:43 -0800 (PST)
Received: from localhost.localdomain ([38.114.108.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm50849718eec.10.2026.11.24.00.35.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 00:35:42 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] xsk: fill in header offsets for TX checksum offload
Date: Tue, 24 Nov 2026 16:35:20 +0800
Message-ID: <20261124083520.45547-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.50.1
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

An XDP_TXMD_FLAGS_CHECKSUM request is turned into an skb carrying
CHECKSUM_PARTIAL by xsk_skb_metadata() where csum_start/csum_offset/
ip_summed are set, which will be handled in the csum offload like
ice_tx_csum(). Drivers like ICE do read network_header/transport_header
fields which actually point to the wrong place, leading to wrong action.

The frame layout comes from user space, and request.csum_start is
already the offset of the L4 header from the start of the frame, so the
transport header is known exactly. Only the L2 length has to be found,
by parsing the Ethernet header and, when present, the VLAN tag stack.
skb_header_pointer() is used for that, so it works for frames whose data
is not in the linear part of the skb. Also, initialize skb->protocol
because of some drivers (e.g. mana_start_xmit()) using it.

A frame whose csum_start points into the L2 header disagrees with its
own metadata, so it is rejected and dropped instead of being handed to
the driver with a layout it cannot use.

Only Ethernet framing is parsed while other device types keep existing
behaviour.

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Cc: stable@vger.kernel.org
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
V1
Previous discussions: https://lore.kernel.org/all/arKm5gCaERk6MaGA@boxer/
The patch is based on Maciej suggestion: 1) do not rely on mac header that
probe in AF_PACKET uses, 2) use skb_header_pointer and walk vlan tags to
inspect the accurate location of each field that existing drivers
possibly use.
---
 net/xdp/xsk.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 52d538160e0a..7c846f02972e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -11,6 +11,8 @@
 
 #define pr_fmt(fmt) "AF_XDP: %s: " fmt, __func__
 
+#include <linux/if_arp.h>
+#include <linux/if_vlan.h>
 #include <linux/if_xdp.h>
 #include <linux/init.h>
 #include <linux/sched/mm.h>
@@ -1027,10 +1029,37 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 
 static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
 {
-	if (unlikely(pool->tx_sw_csum &&
-		     skb->ip_summed == CHECKSUM_PARTIAL))
+	struct ethhdr eth_buf, *eth;
+	int nhoff = ETH_HLEN;
+	__be16 proto;
+
+	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
+		return 0;
+
+	if (unlikely(pool->tx_sw_csum))
 		return skb_checksum_help(skb);
 
+	if (unlikely(skb->dev->type != ARPHRD_ETHER))
+		return 0;
+
+	eth = skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
+	if (unlikely(!eth))
+		return -EINVAL;
+
+	proto = eth->h_proto;
+	if (eth_type_vlan(proto)) {
+		proto = __vlan_get_protocol(skb, proto, &nhoff);
+		if (unlikely(!proto))
+			return -EINVAL;
+	}
+
+	if (unlikely(skb_checksum_start_offset(skb) < nhoff))
+		return -EINVAL;
+
+	skb->protocol = proto;
+	skb_set_network_header(skb, nhoff);
+	skb_set_transport_header(skb, skb_checksum_start_offset(skb));
+
 	return 0;
 }
 
-- 
2.43.7

