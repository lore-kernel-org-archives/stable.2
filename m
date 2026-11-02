Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=132.226.202.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634946;
	b=2lUJXcukGgQvV0KEL/biqUBo6ngb/GawRtIhYUVefoMjvPcYWaJtMs0DB8fmui+3z/5e
	 Bh8uijE4dC0y9OPJHKpMNLeqGbfEB8/nloSM4oK9Po6KazvKC3Tz6+eZwbieXd4avdo1N
	 n/jVEvlAgba/ZPhZEjHa/PN9jq6D5UcUet3RfuoP1yqHR7E7zU6nzgsz83SfBNSvXD54H
	 irEc63bJqywKy2HmWdj3VOHsXQvTbtO7SaYDSP4hH0OiEL+rIFNvXqOxWai4UFYUkiv+5
	 yD1ujYfDdaq4ee7ubnf986jXRkVd41URD0acjDAVdqCPnDY1lb6O5fpf2xsTpm46e1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634946;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=pbmLFuUUs2hY3LsaVxiT1WIYAS0SESeohktWJy7672k=;
	b=c1TgkkOL7EKI8LzpDqwhwq78oNNAB8h5hqsslx5oX+LOlVzsk7fdYn8ZhqO4ZYW+SR39
	 o+Hvo/86aW+iEApb4TTWX+A9IRJwUxq6C3aWM8Br7YV/DUDXcSZDY1PcWmI+Ry3kaKl6N
	 cN7s6IiW6kGQR5ndxutXfBzNAPS//RSJKQbeXRLTlUStvd7NBiS7cflMJ5GstQqjbYWMM
	 emxWSYS550yUMfYgSycnSnoNzb8OGF3WyJzBjMqZy/NRsjJSxzZzVdT5bUukMwN7jHpoV
	 GGv25zxUY78f64olS5ZEEgYGfoME7N+HtW+a+6EzEj9JXeK68aY31lu6O3sS9E5P9Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=o6RRkTEA;
	arc=none smtp.remote-ip=132.226.202.154
Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0029607BD20;
	Mon,  2 Nov 2026 15:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0029607BD20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=o6RRkTEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=pbmLF
	uUUs2hY3LsaVxiT1WIYAS0SESeohktWJy7672k=; b=o6RRkTEAjPV+bMCpvIMu/
	I4t65PgIO+Rmd439//39fY75VtK13w8gGFykEYVj3ZgnjH5AdEZUdyQ/1xzCxacD
	CnYdgBRtJxljlHlnPAuV6NcA81TzmhsfGlqEE4j+cgxPQqo5Q7vrfPqHXXMn6cJS
	trLFcBRkVfb4svv65dvf5w=
Received: from localhost.localdomain (unknown [202.112.47.69])
	by web4 (Coremail) with SMTP id ywQGZQC3eAZksuhq+eOvAQ--.35986S2;
	Mon, 02 Nov 2026 23:55:17 +0800 (CST)
From: zhangmh25@mails.tsinghua.edu.cn
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pshelar@nicira.com,
	stable@vger.kernel.org,
	zhangmh25@mails.tsinghua.edu.cn,
	jianjun@tsinghua.edu.cn
Subject: [PATCH net] net: ipv4: fix tnl_update_pmtu negative MTU advertisement
Date: Mon,  2 Nov 2026 23:54:44 +0800
Message-Id: <20261102155444.2658518-1-zhangmh25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:ywQGZQC3eAZksuhq+eOvAQ--.35986S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw43CF48try5JFWxKFWxZwb_yoW5GF1fpF
	yqk3yYkF1DKrn7Cas2vF1kX3W5Ca95ta97GFs8G34xZ3s8Xa4FvrWSqrWYgF10kwsag34r
	JFyDtryjk3Z8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw
	0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYWrWUUUU
	U
X-CM-SenderInfo: x2kd0wlpkskqxpdlz2oowvx0pjkxthxhgxhubq/1tbiAQITB2roVd5mqQAAsR

From: Minghao Zhang <zhangmh25@mails.tsinghua.edu.cn>

tnl_update_pmtu() derives the tunnel MTU for DF packets by subtracting
the outer IP header and the tunnel header length from the MTU of the
underlay route.  When that route has a very low MTU (for example one
installed with "ip route ... mtu 15" on an ipip tunnel, where the
outer header alone is 20 bytes), the result can drop below
IPV4_MIN_MTU or even become negative.

The IPv6 branch of the same function emits ICMPV6_PKT_TOOBIG only
when mtu >= IPV6_MIN_MTU, but the IPv4 branch passes the unclamped
value to icmp_ndo_send().  An effective MTU of -5 produces a bogus
Next-Hop MTU value of 65531 in the generated ICMP_FRAG_NEEDED instead
of providing usable PMTU feedback.  Values below IPV4_MIN_MTU are not
valid to advertise (RFC 1191), and ip_tunnel_bind_dev() already
clamps the device MTU to IPV4_MIN_MTU.

Mirror the IPv6 guard and only send the error when mtu >=
IPV4_MIN_MTU.  The packet is still rejected with -E2BIG.

IPIP previously rejected packets when the effective tunnel MTU was
below 68.  Commit fd58156e456d ("IPIP: Use ip-tunneling code.")
switched IPIP to the shared transmit path, which lacked this check.

Tested in a network namespace with an ipip tunnel: with a tunnel route
of "mtu 15" the kernel generates an ICMP_FRAG_NEEDED advertising a
next-hop MTU of 65531, and with a route of "mtu 88" it advertises the
correct MTU of 68.  After this change no ICMP error is generated for
the "mtu 15" case while the packet is still rejected with -E2BIG, and
the "mtu 88" advertisement is unchanged.

Found during a systematic audit of PMTU handling in tunnel
encapsulation paths.

Fixes: fd58156e456d ("IPIP: Use ip-tunneling code.")
Reported-by: Minghao Zhang <zhangmh25@mails.tsinghua.edu.cn>
Reported-by: Jianjun Chen <jianjun@tsinghua.edu.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Minghao Zhang <zhangmh25@mails.tsinghua.edu.cn>
---
 net/ipv4/ip_tunnel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index e6bcf0141..3200c33d3 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -536,7 +536,9 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 		if (!skb_is_gso(skb) &&
 		    (inner_iph->frag_off & htons(IP_DF)) &&
 		    mtu < pkt_size) {
-			icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED, htonl(mtu));
+			if (mtu >= IPV4_MIN_MTU)
+				icmp_ndo_send(skb, ICMP_DEST_UNREACH,
+					      ICMP_FRAG_NEEDED, htonl(mtu));
 			return -E2BIG;
 		}
 	}
-- 
2.34.1

