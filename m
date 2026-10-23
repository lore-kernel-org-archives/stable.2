Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756778;
	b=AGDMwr65eXj+1bmVjwn+GJftkyNSk/iTtHnkBXiOyyRg7x733+pKfRcXzHHpU49Gxb/l
	 ewGn0jlu1dPyUito+R1KH+BPkqNyqKUAtGTXhlf1hHBCmJFVTxrzUKI8Tyz1KR0+TQaly
	 TA1R9Mhixgrnou5G4ym4g0ZNehhIeX3i34UNHvbbL+4e5TglMTb4aDnUKRgH89euLxOi/
	 uWMPH0UhbiH9vGR4GsnoccV4OwvM5gUiVoPqW0Cu4KhG5ITk08/HCoe1P19QYSu5hOX8M
	 XfnTyFDhe6p+VZcIQCkil6DvDKAGNlH4cF11ZeA+3+YnjyroMswxOdafg+Xu3ZwBG3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ODXqAHSl1PzO+WlHi3VkH0G2LZlWHwMXjD7qVV4H+Tc=;
	b=cuYyW2jkFs7/M6QGiy4jNT3AVAknxE3F51YGiA0TMOlOv+/j2RQH4VjjtzUmCsiSa0i7
	 xKx44QaUf5r3mnmElNxSaPRrv5aduqKzcEveDCTstPhqBY870g9jMfgFJZjjlvwOAQpaw
	 Dw9u1/BwPvIWyb/J5jgCvenWAn30YYXnPqwIsPLL/ltujqNDrT8L5KF4uRbqaQa9klxzp
	 h5Yeg5HxzedQaVfJU7Pg0QbN/ovhKUMMxx8MimWizkBBAIz6W0NIFdwNNgJqAxE4V/xyK
	 asELlDUchpzGtdYuV30uEfafcotphn3yaI8ldqYTAQnHOaoWywe7JFPUM3xD6glKMsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cjXdylKS;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8504606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8504606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cjXdylKS
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b55859245so12794136d6.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756777; x=1793361577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ODXqAHSl1PzO+WlHi3VkH0G2LZlWHwMXjD7qVV4H+Tc=;
        b=cjXdylKSOAu5bD0QGJAPwgXR8f/IvlXcgMSjZ7tyObvJC/6q8pxPUAsdcCYrMy4a+F
         psPWB1mAg2iznCNJNp3GwM8IEw4XumEmizNYh9DBpYGSIrSJYqTjUceN7ZDY+mYn/6zO
         hXQGMoUJ0nih7gjkktxUEn6E+LtvOqrd9qpqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756777; x=1793361577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ODXqAHSl1PzO+WlHi3VkH0G2LZlWHwMXjD7qVV4H+Tc=;
        b=FC1m3yLIrI2ZWCvgT36f9SFUIT9eyXGDhhxCFU30pvhrUw6cRxysZe/KPrVWxnnROv
         e0fN1jPSiMu1tediFqgGz+3lmif7d3xv+Oa2x5CH0I9+t9svfzMtgdEruVyWPWWJiOUp
         z+p6TPSb+HuNdr0nPZ3dhI/tSseWtH3zUuzO4JqlWfbDGOPpJqoViN45Xf9TW+kZvp1K
         1i2INapowMDgiOVQ5C6wJCLdaate/Tb+Sh1S5Zjskq8tTFfz0vFMNR8lX8T5R4hr8ILg
         hx5idTVWQTHPtiuuNnhx4mRvReF95QEGIlqlN6mgXpTGMhjjDssKLnGtOpckxAKyqDtV
         mn+w==
X-Forwarded-Encrypted: i=1; AKwUvBxSC8CjwVJ2XJilUp8jtCzNO5nSJHhxtzIu9zLL1gqf9Clu4Kd5BvD1vq+QcBSiPgih7/NOsUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/MXCKdSfb1X182XEVSJxtv+MqLeKMdEiWf8JHQwp1vDj8lPzu
	uVklhxNdVhaK3VYkcgXq3VQO25Wb0RTI+S/jNjYdXoCGkXp88caR/Zqur43xPBRntw==
X-Gm-Gg: AYBFou17tIseuM/En6rxkP67EDDvLztuqdluuqQ/cYlus1qkv3rhku4dOeVoWQbmiy2
	luSqPlIFQP0wuoMhB1xIHHis4BqcrqTnffGsiHnz25lYg5Udt7vlICPYiEpzNbw1sc9GF0IhbU5
	H5WhrH/MCmOmzYU7c52BMwEKvN7YULEZtPJpTa9sz0/ktgu2svvLscJa+6xRxk4ijVov5zQ5Krd
	x3NOiUXrMoVJmf2SMeOAOhsjX1sHfXlsGqtgNmPzpPmiybn8dj6NugBDLbnOST+UGb35sV1aJ7O
	DS08F4Uy6X+M4Z09eans6rA7/q4o9DqekziMZOTSyNYJYAsmAPp3a2UD/K0z76HdmcGyeZD1I3S
	JX3CWKza/LRCU9scQMYffECyrhY0ZmcjtFmBG1AqeSFWCIn8hdWbVDhO8R15OxaoKsPgxu4lJOI
	Ushv07GETMx0JItOP65YN9WofunxfX8ddC7FYYGxOVHlJ2yjXG8Du9DMzGZRsAUnarAlOucsYGf
	cUrKXFFqfPe+Vn86fEMTRzdXwByzq1DFT1raFrSay9PeK8n0UvhF/jF2CAtvtaZ7RtY6JvyWOSy
	WvfWpONRLqF90JsOa9GU5u0lw+u2yngKC5WMd8UIsQ==
X-Received: by 2002:a05:6214:328e:b0:90c:4422:84d1 with SMTP id 6a1803df08f44-91c3ab17827mr24192296d6.30.1792756776725;
        Fri, 23 Oct 2026 04:59:36 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:36 -0700 (PDT)
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
Subject: [PATCH net v2 5/6] net: openvswitch: ensure a linear inner Ethernet header on TEB pop
Date: Fri, 23 Oct 2026 07:59:20 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
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
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
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


