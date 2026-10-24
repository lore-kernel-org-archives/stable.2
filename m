Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852141;
	b=CDHxRKVIkX+6tRupmo0Hp+cJaBcp7zUSm3Lt4Zya1KFxh1L+iy4MaWHSxtEcJpGoSCHI
	 tU2KL6XTAD6aXh7yMZ8HJW2wIpS2I0e6RCKUbJzjnxzjLcsXvH1dZpU5rw8WGTiWK16wR
	 Jj2jEJ/goYfFlvcbSEOrlxY5YA5IhyavQRwBkg5BgiCIVmCibo+X7ywkC4OW62Q2lX1pr
	 2WAkiyMUSuq1xH0wQOGSQbbDnm884QRmSWFuCLQESFf+/7nPsj66fWAxjG4apKRAthxD4
	 Rgnl83omtVrvePdhVLjU51EbZqh1SjeXnxhfRQsZOJEfDhTulataPKRIPDa524d1tBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LdUZFtQfnDJTB+Kjt3GB5JZyxdn+86cnN+wn0AYC36Q=;
	b=SuLE4v3DQw/cK6hxosBCmGPz3hbXCEjmFwwzNdXXSliKv9d+ywQs7SCPFsrDzMSv8Xf0
	 ogVrPIwCwy62oQVtLddC59uMNctc+wYIW+eMmkz01qmpPmA0kcgRE4bggwrpJN5O+UX7g
	 05jvKWj5nBFUwbuSXikSvQVrBQT09+A6OjEzW25Ff/WPZqoV/A/gIFjHWswvkfZpZltmd
	 lkCsph3h4twkPyDCpwACWcyJxFjoPoi5bWDTjEmP+LDS1o717oo6gUC0jfqfj8pnhJJed
	 50+9D6EQxt1PYBM7LihTY+QRjeo4G8asDk00rGTD1WZat6golhkZGXVbDbFVzzLljzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KKgqZaCu;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEC606A32C
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DCEC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KKgqZaCu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b9e758c50so23519936d6.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852140; x=1793456940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LdUZFtQfnDJTB+Kjt3GB5JZyxdn+86cnN+wn0AYC36Q=;
        b=KKgqZaCuJVZ8EzsWFmIEA33mw34SV+GSc+V5KaBAuTIuMcF/cb97vu5G2LEA6Zr9CE
         /JPnhwhnp79P7QlDRhh3T1zUsda5taUVP/GGNenMiZ9UTLe28VUIwf1zKYj0OqaIM0m5
         3/jjCYrbq6tIHaIDWWsmIfhuP0Gfxr7At84Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852140; x=1793456940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LdUZFtQfnDJTB+Kjt3GB5JZyxdn+86cnN+wn0AYC36Q=;
        b=PUwRN9J1uliYtY0ezl3Vs27lLkOi+Qllp45UFNOVMGX4wrvjaEZoQfFdTPeJVoaPH0
         +dZbO3dkqO1MZhRZQtyFv92nTbd7ndivREaEEuiY0fJqka6AIGjKkqlx/LexPpBXgRcc
         q6fFpcnVlEgvoyo49u3EMeNsqrZoZTHn5Wxdoenp1BkH+nxz9QcnTmkQotVmc8+j2xKG
         0Pf+hZ2gMwT2qrGNuWLv/jvX53y+xSHit8no+HXMpUiqw5ygUttTeX7IM87EcjMsI//U
         GZOCNwt70yuDJQosfTFwudY8/nRd0ckmXfM9Vbjj3Ur/ao+t7u0jyilz+ZtuCdExLkJf
         teGg==
X-Forwarded-Encrypted: i=1; AKwUvBy97AcXgPaoe8S76XY+83q5m6Jvn73/Wk66wTZClyLP846s49aTELKTBXX8hLkAuXKhHR05BeI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5bR4a/Bzm4+ehUbOtcoot6GOqPvb35+Z7BHxC59lkCLiNnFvN
	L2ibp+sNNUeMFWmkTWl/wY2aqUe+C/wNiY83e2nS/wtfnGku3uM5HA9+kcX3ifZ+yA==
X-Gm-Gg: AYBFou2HmpJvfqzm/j0hGFaG0d33zglN3AJMvW81DiWkQ7uSetUodgrEv553/gfJLP+
	IXegxKG2tb7WApsUvoTrZlNIwb+PmZk9/FSGyusWTVZXyUw0WPMWasPRRZngmDwhNuTT2bZapp2
	oRbsrjY1LzDME7odkSQobTFP+t3y9qj5XFjW6r92ccapmq0vGNIlW4EH49HiuhFXNmiWHp9jII5
	Jd/l/tRJqvzAv0Nl+bJJbieoGt/Ff517tiN3cGNGAuqBqCw+K9D3uG/QktStf8PJsGTNPGdTLDz
	yFytrFaEBu0ZVqdc4YSlVuqOnV0QHHAhlS1L3G9TVXnr5//tGigUDHLulKclp5xR+wkqbcT/y9x
	l8d4MTT68qpKeM1a+p0cOO9rqWCynDctdyKKqBVbHPlEMqM4e0Z4d4LpiBhSeb/eXfE9MCz93KC
	ZvlzEZgPtlg6DnxFwtjJMiHZtBCdzWjcMjzG7oTYm/5C+/8DXrZLwy3VxTuZBmBsjmy6HHY9BZV
	/zZXyu/knNeLiyQGjFjjclPPB1/3t7OOV4ZXKPq8PEhcinAU7DT/2m5+9xFRDZ1q5cCODQtzgoo
	rmi0dIGv7g0IzH2ZqXUH4nE1wq3ABPotmUlSdEFsMw==
X-Received: by 2002:a05:6214:c46:b0:917:b006:50c3 with SMTP id 6a1803df08f44-91c490092d5mr30067256d6.4.1792852139897;
        Sat, 24 Oct 2026 07:28:59 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:57 -0700 (PDT)
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
	Jiri Benc <jbenc@redhat.com>,
	Pravin Shelar <pshelar@ovn.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	dev@openvswitch.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 6/6] net: openvswitch: ensure a linear inner Ethernet header on NSH pop
Date: Sat, 24 Oct 2026 10:28:41 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-6@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-5@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-3@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-5@mojatatu.com>
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
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Jiri Benc <jbenc@redhat.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - no code change; add Aaron Conole's Reviewed-by.
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

