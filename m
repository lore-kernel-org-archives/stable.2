Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660955;
	b=eLOdqs7hprCKvREElemqaN9s3o0VNXV4AWxKKbPz2R9M64WLx0zbeGDzgHfCHBOMlcSP
	 gzaTfOtYBksLG2FIesPFubfUT1SnDdE7HLHEO1GYT21tfF1hdTXd8r+mH3xjjedu8KVdS
	 SMEJdB1Sg0mnATXqYq2Ddi8dK55c6Kdf2LOy0GMlKjTZPpoNeX9tiFUyVyKZF6UBLGpng
	 OMqRkZhmBTZovNPdcXzvVmfT6RCtFdWsRvw+8K7mj9H1D3BZ+lTzU9AHbVR4+yGXGBj+T
	 QmclswUGk24SnyE6TMb2+gxE3CVnB29IN/0jAV9Ze5uBqVHhV6zfKGaVnf2bVgjoSug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FU1XSWmj++ibIHIRMssfhNs6Kxu554Fq4tiwLZtw/UU=;
	b=PLDio6R0Qe3FQHe57+xuJ1Jdfp1mHsoUFH3NRwg/28NcYdRg2+EO9VREocL/63sARzLX
	 jVESFisPtjyLE+bCXtHl7u+lOFK3RsO06kSYAoEukk28w/7JnWyacF0+pKVQ8RRhwRTrq
	 vbaiojNFc4TZ5/4HKMd+2RXYzWQEt20Ggh5ztBMkMVjED1CeaswohsfrosuUUqR2zzkpQ
	 IgGmr9AM5dHRsTayv9NU/tTLCq/tQvp0EiVDlyzK2t720O9cJ6zZu12h4bbUHtTjBu5Yu
	 uIZHz+v79sCBKrG3Tk1q74ll5pRfjLYt/FQxA7/H10omPO67azQQqvDAc4Vhr3j/7Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="HO/kFuk7";
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55633606A33F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55633606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=HO/kFuk7
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f2ed2541aso65480785a.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660954; x=1793265754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FU1XSWmj++ibIHIRMssfhNs6Kxu554Fq4tiwLZtw/UU=;
        b=HO/kFuk7FCO5dJFBDbR1SvBkEcbzi2qKZEppDLmcN9ag9nG2ZJduZ5IIrdsvHyADIn
         f6Uo6NRyOuNpiYjBJUEU80y2k2QwlNeezB2RuRIWT6F6p0wCPjwvR79vfnoTGEf3hcWJ
         VRjjCrpVxZQqC1LRJRd4KcCzM7RompyKCUXWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660954; x=1793265754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FU1XSWmj++ibIHIRMssfhNs6Kxu554Fq4tiwLZtw/UU=;
        b=fgRkX69LT2FIdGa8FfRkW5CgLM9daaLrri0KD4YAMdKcbm8KqQaGQc4tnDr8+PLKAW
         KV6qrrp/weHyoAaywbg+fXTm5AA+GyitRmkVS9S41zBDDfkmKpuK+YHYULIFAt7RdPSZ
         HM5e9Gfj+WS5XN6SQV2wt4kyCtS9b3jNg6UV632s1ND9Uw00EtYkW1LA90fehJiF5yOk
         lJO2I26c3IK84qp3jituEyFLDXLK92eOVh3NYrBT18ipS9X1kBc/6HXbmdDbRBzKb8bY
         6E7q9xlEGOXseKwgtRLH+kH/F8zo2cCcIHCFLsYIlGZisCnw3vhFKQgtxS19ZKbOz40z
         B3Mg==
X-Forwarded-Encrypted: i=1; AKwUvBwQ0S7bkogV1kvehdavuSsakUwJry8d7L5K6YKdS9wBtgtiwo5k0ceHupigATd0I8I9NHe9g00=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeD6WhVhQXvKG6aPHqlfxpswFBXSKIBrdKkOwstg6O04xarO/0
	s1TOs5G8qDqFnNqGXouiVjE9u1duYT5s46rnttUf9nojd/FJU/vLyIXaHZS+wwKtz5Go4JBHZDm
	w2AI=
X-Gm-Gg: AYBFou25nokzz9dLZTit58DlQAZQSE6JDcaJmvrx+vzAJrz3rHC5hNga8Iqb20+zWHR
	LBADed/sf9Vsy41SotmK3xlEXCdhEDZL06Lyh2jpx6fClKwKFpqkUCfeRdAahlA/gzaMHCITkPI
	Vf4oreBspGY2uNReDca3sxlAmXzFnPlcT9C3oVey6IqYhZqvm6iz0JNLpF/ZU1uZ6C8iQ3oU0iO
	RyeB6LM1kJPyusbNbqCFt+o88+OmOtqWILBfU4uaAbIV5gawTHxbzSG68nI5E9Z8xWyO2NQ7cSg
	73qnZTQ4CFJLJs71O6rtlno4MbmMBjs7PABPs3OTxpNI2xmYimP3NAxR9h6/S2O25p8XX08EAh+
	DDnbDKxm7Q0Go+fHMh1q9zpSZKC85w5ByUK2ZfGBg9j7tTL2txjrjnJjMFsCvH4zr4D3svTESrn
	DQehLzRhFe8FWMYJf6X/OEUSKLNGKdo9mvG2OTL9iU8m+IzoHZZifVvtJU08PENV2VEXf1ddwPD
	89motmcItzbNimt3beib+tiTt4XEQXaT7GnpOHKEnhxPvDMJwsr6k5q3pwNnzPTOaaFT6NUFu4a
	hHwkurHVZuAe9G2x6dBY0dzwFw==
X-Received: by 2002:a05:620a:4686:b0:93e:5534:e63 with SMTP id af79cd13be357-93f624de650mr270152185a.13.1792660954420;
        Thu, 22 Oct 2026 02:22:34 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:33 -0700 (PDT)
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
Subject: [PATCH net 4/5] net: openvswitch: ensure a linear inner Ethernet header on TEB pop
Date: Thu, 22 Oct 2026 05:22:21 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
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
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
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

