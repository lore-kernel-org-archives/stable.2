Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852137;
	b=gbdIjmPTl9jIDBL5hjzQN7U/t7ENBzhzg5oNdqXNuZd3uFY89zRvSRukMzRlbD2dKe0C
	 SUUkcY7pu0fIo816ekMSpIPDxP/d+ap2Zu9/9kjcFvfdfSiaB/p9SnIzi9m/YsqGUgKCm
	 L1tG7mYVDglDAM7BZnmAwrnh7gwbvPiA6RUTyAq9nZhwEKMXH4m2rXQCMaoi/ajh/om8M
	 2Nh8Pi5bDU0CuYV2mehYrjjuFMoWNafDtpegtokkHX4zbo7eF/+xqzb6SBZqG5x5BhK9v
	 0D05BivkqtwUvAkCtNK2rEQIODRT0xIwZvYXsiit1weDxOaeN8uOHq+ylcizqP4XC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xuYAqvftjzynacCTLNgIg0wwHTh7boJUBn23V0yCGAQ=;
	b=4tJNCm17T90Vr7hDPsWiSX5JNbbMWlqp+eggRamFH4YsUOeo3lMdQesS4H1RYNN9/DbN
	 OVv2JPMy5YK8gOw9KrI/MM6vwmkWPOhkzHfmfHwxbgPzWsBVUTHllmSVxh6kOEr4/arZf
	 9HjnbroCHgT+yHlaWntMNODbhNdvSfkD4QbI6PddPAVQ6E4c9Re+2zDP5H7cYPpbO5maH
	 Qk3656FPIjHb2jPSrBAAcsqyN/CufhddWtgIkfSiPuz20nQB7DTn0UGpu2KGLIuk5R4eL
	 oAZthCPa8QDQive2sDJazZHq5ahVRoEnsRDIGuEaiR6aTNERX22DHgvJNzZWJbnBZQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DGdsW4Br;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F876606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F876606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DGdsW4Br
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53653e30353so6242801cf.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852136; x=1793456936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xuYAqvftjzynacCTLNgIg0wwHTh7boJUBn23V0yCGAQ=;
        b=DGdsW4BrAohZiwSdkHIU4e/O/eFXLanlU31R4EZJe1h0+AhDNhmFObd7uFnFfj0+Cc
         N4jDUVpkemtiSJAsgbz7hUxSCg7uUHbb8NYbpXsWaDT6Es9tooivzcNjN4nNE9CnGBUX
         DPSijLLWJFX8ttsqJV/7oKsOTqfxcq8+ruMAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852136; x=1793456936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xuYAqvftjzynacCTLNgIg0wwHTh7boJUBn23V0yCGAQ=;
        b=P0g0W/eLGqp2pzXEBGW8VjUlEfTgMHWOhsuz6gfl7FLGircgG4w4ODzfY/uEGonK2w
         S5CXQjOYHgdyAJiGYVyVSboKYtlQOoOemZwP++4KG3BEV9+GZJTLVliKwBycTgOu0YS/
         BHiyujHEoPSWFpUekj36FkwlwL0EaPcjD5wf3Sbrof0t87etyQetX2FXhNxuknLOVKf/
         zlhygYDINZh4N0nWR1mRdvYUjVjFesJWZhaBJ4GD/0QTN/wubhmyxh4UfGgJyaC+qit6
         p08BVcFe0OBprP6yq6KOhYt9R4u96rz5Oxqf26H5AgFgG8jjW/JhnlDyzTxO5DM7eAQy
         kKzA==
X-Forwarded-Encrypted: i=1; AKwUvBxo8GabDZgGykvMzeAS/3TorxXvF/MNm8Ys1aU4L30nJDZqEp+GwiMjDgIivdfkYDNOD0P1rqI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5k1WrFv2P+5XjcJXA5Rg8hgQBgBtUveovc9vMXscECC1hMKna
	maC7XZ9bNsP/WsJcpdtQAnGVQseyYo9DqJM2FR8Kp5qv3apGRyXwKbj8PpbYZtU/Sg==
X-Gm-Gg: AYBFou0t0IcLXaMhoLTxqQJ9QxeW2WIbm8gHlR59SGa2D68AvqAP/NE+JKzXimLxqzn
	GnBSCxNqp0a/6tMe2rUC9R5bvB9HDS5sVbm61dBHOmInsOAf9K4/mzPyCrN5LBYGk5LLG8Fh4fX
	F/lxrxtfhtVrrUIUrfvh+ePdORrul6zH67WG/V5MpDYwodB8TpJOgQK7nIU1YSdojdT3804nqSu
	irz7zVt4CTyBo1GikT4TRFePtfgSoY/s9502KbZkuEa3+O6bvARWpfiCQsyaalx62ljifg8gy68
	GsJG+4SQo2jOmSK233uJL1MPvPw3DyosZXSt2Pw9OlN97FKWsgKFG+8J3gPI5ume9lMdDYEgVq4
	dQKA8d8dMFEMh56XaCT9ulBLxjTetPUavstZWTDlcOMYkd7qXCQ+XYJUWzCKjVGLe8q3BDTZD2T
	T17O+jGeH861d1NU1zT2NhrtPMpl/uXMOQtRYKFouWcMjljBDLPKEUzFvWpesaXk7W3PmKJ5GSZ
	q2lXnieQgU8PW2E6OlTxB2q8jOAyZIejSKBIGtAGym6v/olItQu1HsLbVjoodOfRm44Nmx6tfkO
	a9WDTBliDJ5X0c8SIBeSxkZTNki1elSZuI2diqrZyw==
X-Received: by 2002:a05:622a:90b:b0:531:164:fa73 with SMTP id d75a77b69052e-5383b554080mr28941861cf.32.1792852136437;
        Sat, 24 Oct 2026 07:28:56 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:56 -0700 (PDT)
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
	Pravin B Shelar <pshelar@ovn.org>,
	Martin Varghese <martin.varghese@nokia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	dev@openvswitch.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 5/6] net: openvswitch: ensure a linear inner Ethernet header on TEB pop
Date: Sat, 24 Oct 2026 10:28:40 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-5@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-3@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com>
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
pop_mpls() restores MAC_PROTO_ETHERNET when the popped ethertype is
ETH_P_TEB, but skb_mpls_pop() only guarantees that the MPLS shim is in
the linear area.  When the inner Ethernet header sits in a page
fragment, the datapath now claims an Ethernet header it cannot access
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
internal port up with MTU 9000.  Install a flow matching an Ethernet/MPLS
packet with one bottom-of-stack label and actions pop_eth,
pop_mpls(0x6558), output to the local port.  With CAP_NET_RAW, send a
4128-byte AF_PACKET/SOCK_RAW frame containing outer Ethernet, the MPLS
label, inner Ethernet and 4096 payload bytes.  The two pops consume the
linear headers and expose the inner Ethernet header in page fragments.

The Fix:
Pull the inner Ethernet header into the linear area before restoring
MAC_PROTO_ETHERNET.

Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - no code change; add Aaron Conole's Reviewed-by.
---
 net/openvswitch/actions.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 27152bca8a8c..03b31e33e880 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -153,8 +153,11 @@ static int pop_mpls(struct sk_buff *skb, struct sw_flow_key *key,
 	if (err)
 		return err;
 
-	if (ethertype == htons(ETH_P_TEB))
+	if (ethertype == htons(ETH_P_TEB)) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return -ENOMEM;
 		key->mac_proto = MAC_PROTO_ETHERNET;
+	}
 
 	invalidate_flow_key(key);
 	return 0;
-- 
2.43.0

