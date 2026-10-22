Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660958;
	b=CzCkeLoqWYkar417K5Ivi8/rDOJ2TPcpJanZfEO58fcv6Bd1NFdfqvEfkWjvzZ9pfmm2
	 aXVDVdXpB8gSrBOVFJheRu5m1+6pD7JeBgEYTmlZ7Ur8v1ERnE7uCJOlOPpLB5nYg0wJl
	 zSZjkM/vgQrez0LRJREIsVjG0p2fJD4VBcQIMiiS3tMPTIWSQed52hBkw3Cw0ZuyeRpGg
	 Bb3t9R2h2UUQlDgnTMysS7SHUE1Sf+BNzcsEa1uG/BQKh7WrDdxgXn8O9Xehs6j/aAun0
	 FcQ6Yv/crLcC+E/AKssG35iffcRrP6GxzB3mt/1aysgmAlA/KfJuK4cMjWxfPHrbAAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=icU9YO4XysvgHIVlrdyvNfTHVdM7KlIy9zFDYV/1joU=;
	b=xQ94U7g6VCz26/YuKKocs+zg/wU7cnkjAUQMZG3vk+RcjLDjVQ5NXpk4bSlIOcdwbsHe
	 lmpws0zzAfWz4AlAq0EtCHBtrv2Da8U8B6lpW1/Id+qhxWQoY0wmN6Pe37CHG2lJ2RcxJ
	 Uc9/h6oLascUxG1QrONMOHYA7P462q+MV/DNhJhvVBxJjG331hHeUnqY/P8r+asLcIUXd
	 7m/63eayQQJnu3OykTQkbGd2oXdrGcEvZ/641Y9WVcByIUfojLX1+0p4w7CuXuJheLEN/
	 qEiftfp27ljOQa9icYn2282oe+QNvyJBKboZgt0XQQ9clmlWB695+zIQNTP1ZGL8Peg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ANhnSiVf;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B35606A32A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B35606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ANhnSiVf
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e64d52949so143372585a.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660956; x=1793265756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icU9YO4XysvgHIVlrdyvNfTHVdM7KlIy9zFDYV/1joU=;
        b=ANhnSiVfzgB9MNcKy4OsRyOoBJPY3Gg2xPECaa9IuD/0Y94JUV7KpwwC9JBBmgXKX3
         7R/T+gVz2BoscttxgoKYb3emHKYJkgGxHjkGjDpcOePbaweY4/AHbAYIts1hoD2KbBKI
         1JF8gqqozwanGCLuNbgyS5FTNNwMW38eXf4Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660956; x=1793265756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=icU9YO4XysvgHIVlrdyvNfTHVdM7KlIy9zFDYV/1joU=;
        b=Vp7VICIznlutYdgZGc8y5jGiG0C4Hp9AZOdqUTi03poJL8wIgjSGtYpikuKATeoZ0N
         4CzbusEH2tNGP8GP1n1aZjmkii8VDFiPGaN2XEgQdC9L30cvXT6mAOtMlW6ItSKDpkA/
         OAz4BMZaWE3LQVQeLE26khiUlZvYxgfIBvtlhjfd3VR/dgot8avUOiKx+Lg5g69pw/3x
         x/WcklbFXiMwLT4llgDGZOTiNKHPzSKWO752bOc2rZQcIpnByv+hqZtn+Lk67ZVl0O7u
         NNGniU0ghVcVANreT82xCS02D1FlFMAhnk83h3aR24Hdkdu8AgCdvLomCQMONwl6tXVZ
         DxmA==
X-Forwarded-Encrypted: i=1; AKwUvBxAJcai8H3WMWxUO35fDkgE21apI1NRyC+CF5U0qgVQWgG48SlmsYjq61HR65EqLh9qWGVR5MY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/7RCBdkY2F0yHAlZIxYR8bi4UokoIs006gcN0241siS79kIwq
	ueLhS5sBXzqzE+VX1scuDzRK8IDTXIjkMJjhaLMQsLIxAmrb6I16QW7tkSmmXDNGPg==
X-Gm-Gg: AYBFou1aP474kGH062XQTSqvKKp8ua2aQoiflF3QOwaTabxVz8dpbLw+gB/JLMxii2Q
	FtmT2AWVKCRgII/DfhtR7/sbtIPERP/vAf8fWuCZ+seJhCO85sNOE7OspLMb9qlAiI6kqR5kMYT
	Pu7BGnr1h/Gavf7KxFALF1HJ4nPgVSf2r2oyLsUImKDxknhtkjzZrEnytP8xYik4dFb1NjGCxY5
	hEK1Dz9lc/BcRu3xTj+yfQoSiubQokQlKlo/2yCob3dCCE3OO8Q0Wrgulz65D4H/CDja7iYksZH
	wOuUdeQ4qJkL7+5CSRPtkTApr4gyHBT7NIJDNAKd4Bn9f5KFEOVnxiGllz5CD1PAG42hsMwtPyB
	snGAstww7OipZJhkJdZEMS+Rb0n4z7Nu8l6sNP4prUiVnfC4KhziBwvctI5ihlwgUO8a9ewvoQ7
	F2KV1n03ZdV2dmV+Idf4TkC/+nuiL4S3UGXR4Ly6QyiAj78LtzRw6msKvgsTM4d8D6gIUx8GIOs
	xJn4Pw/wfLnKrRmen3ekPYXD4gwhUnL7PF0HfUPNVTBgRg549GvTVQsWN4aWZ7Ga9GxZ0JwE6QY
	1o+3SG6atmPv3BXp8QCQaY7fN+gxOZvHQCsUvp52VBZHoM8=
X-Received: by 2002:a05:620a:294b:b0:93c:735c:2477 with SMTP id af79cd13be357-93f57f6fbd4mr922058985a.21.1792660956306;
        Thu, 22 Oct 2026 02:22:36 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:35 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Garver <e@erig.me>,
	Yi Yang <yi.y.yang@intel.com>,
	Jiri Benc <jbenc@redhat.com>,
	Pravin Shelar <pshelar@ovn.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	dev@openvswitch.org,
	stable@vger.kernel.org
Subject: [PATCH net 5/5] net: openvswitch: ensure a linear inner Ethernet header on NSH pop
Date: Thu, 22 Oct 2026 05:22:22 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-5@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
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

The issue:
pop_nsh() restores MAC_PROTO_ETHERNET when the popped NSH next-protocol
is TUN_P_ETHERNET, but nsh_pop() only guarantees that the NSH header is
in the linear area.  When the inner Ethernet header sits in a page
fragment, the datapath then claims an Ethernet header it cannot access
linearly.

Output to an OVS internal vport then calls eth_type_trans(), which
pulls ETH_HLEN from an empty linear area and triggers the BUG in
__skb_pull():

  kernel BUG at ./include/linux/skbuff.h:2830!
  RIP: 0010:eth_type_trans+0x335/0x500
  internal_dev_recv
  ovs_vport_send
  do_output
  do_execute_actions
  ovs_execute_actions
  ovs_dp_process_packet
  ovs_vport_receive
  internal_dev_xmit

Conditions to recreate the bug:
On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its local
internal port up with MTU 9000.  Install a flow matching an Ethernet/NSH
packet with a 24-byte MD1 header whose next-protocol is TUN_P_ETHERNET,
and actions pop_eth, pop_nsh, output to the local port.  With
CAP_NET_RAW, send a 4148-byte AF_PACKET/SOCK_RAW frame containing outer
Ethernet, the NSH header, inner Ethernet and 4096 payload bytes.  The
two pops consume the linear headers and expose the inner Ethernet header
in page fragments.

The fix:
Pull the inner Ethernet header into the linear area before restoring
MAC_PROTO_ETHERNET.  This is the NSH counterpart of the MPLS/TEB
producer fix in the previous patch.

Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/openvswitch/actions.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 03b31e33e880..cb7e16c6a8ef 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -314,10 +314,13 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
 		return err;
 
 	/* safe right before invalidate_flow_key */
-	if (skb->protocol == htons(ETH_P_TEB))
+	if (skb->protocol == htons(ETH_P_TEB)) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return -ENOMEM;
 		key->mac_proto = MAC_PROTO_ETHERNET;
-	else
+	} else {
 		key->mac_proto = MAC_PROTO_NONE;
+	}
 	invalidate_flow_key(key);
 	return 0;
 }
-- 
2.43.0

