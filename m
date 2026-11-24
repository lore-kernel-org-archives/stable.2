Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509219;
	b=xDkHgUKBA09+jltxSNXwZ2pwo2IolPTJcFblyZcTxW8P9cJ4xInKYrbzl45wRNwmJrAf
	 sz976kC+qm1ytw+AhybK66d3QVObDN4zlCYCh06WePSNEuNKfayOYINZJQahQLoXHvNvo
	 rfHT9OG7HrpOnTnIKbb5PM2iN+6O7oAs2fjGOoZtoUw3p6qqelx38s3PdQ9TWNnPdq2cW
	 +q0PycvHuDjvLBkYghG2zV+tsb4q0yx/c86+qIU0hCWefT0yzdRByx78HwRDQpqaIkuYC
	 28HHyxo0M536yvD5fzTw1v9Rt/E0BBOfS57R6chgX6ErDmtWBGykZo8WwgpfCIQQ3bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IHaPZxvGPPauklr++9jBux27Uh1MCS1CpxGOkczFd/A=;
	b=ThnoJ2pR7iCkIYKKWP89pX5Ec2UgAOY0yKlkpjUAvwV2e3gnPaESCL1WYRqTKpBWeZKu
	 1Yef/+Hbm64VJGCDjJvILDFI+dFINfdQ5DqnkaJZBzlzkd2MK/G2Ayq6I/8CC0pD74JPR
	 yNc35A4Dht8efs20b9EC6wcwJLxfgaAEQPXBnyWlhIm6n+2aP4ljIsxcSkULNYnWSjJ0n
	 ry08WC5vRN7dDOKvcY7bmoNTpLPER2PJV6caAZM0SU3E8oI3Ax9g38sPDbSK2J0V4yAId
	 xK0+Oz6HL3e/dqzuObQHR/BhwmgGDABw4yl3plel2uKfQnOHHk5kf+zfUkYHUrb6sbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b="bkH3c/n/";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5D606A693
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F5D606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=bkH3c/n/
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-170135e43c7so6141251c88.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1795509217; x=1796114017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IHaPZxvGPPauklr++9jBux27Uh1MCS1CpxGOkczFd/A=;
        b=bkH3c/n/jScsSPF0AtfJbwWKG3EGbh3eR9Oq9iW56tUWHAbE05TTA/jlR1Yzn1QKzW
         XVSWmcE95xz1B+mjnPaFbEVRwZqUeV5l7eqy52+L3OQYoNfHS+k5g5sMRwm6NZPd004i
         YVXHAspEaC1j6oJhKgUcSADHuBJFdX6QG34QwaNrkOYXntwP4VITflsxiOKvcGhnZubl
         vVHd/s546Os+2lu8fBGolT1yJP54gDwIQwj31laVTe+Bcwl7ook9mE5KHxJqtJ7xMUpr
         zHW4MSVddUNFrVz2cN1pUzQg9GYnHByCCQt+TqJ+Lff6JMDj+dMOa4zPC7l3blNlWrBs
         TgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509217; x=1796114017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IHaPZxvGPPauklr++9jBux27Uh1MCS1CpxGOkczFd/A=;
        b=xxeaLSvnNLxpGmjvcCSVhmK8lUW7EPjvR76VxR0uYvRZIRy7GvgItbaqBkZISBRYHE
         v2JoU9riqJVGMxBo3/oDeax4nm/qwYhDnrb4ORxfXTYysQvcIf9zjjF+n25fI7O6m53l
         XqIhaSnktyRLy+3RgTq+qMUlbwSgFEkWagBBhh2fLL+t1UaZtHjLbuBASr8SQBlansQg
         LcDel3WaVXAwuInL5dSnQm7RpW3cKAhPcSXrq1rbLOA+0Dnv8PbIj2/IWgzaXY8THIEc
         Q2ChxLExi5ChjDbBuHPtn3SyWyYKOSvUWK9nWkqa0zGLUGegaB5REBDYMpP3DcDICHge
         A/Nw==
X-Forwarded-Encrypted: i=1; AL+hErF+N1dXUUluUzhLnYzkcQ1uPCegRf1gHpx4f7b6XbOm9vHtAHgn3McfWGO6FKTEnHrQVqBNoqk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QZud8ghvSmhxxhmuz84kYsnQD8Bb1T+6AcBMHARj4evhEwm6N
	S23C+ylDKPqE8HlNtjTMRPQahKiXe7x1iD4uy3dJruIPOOeSwlfMd25RGhHW6AYaig==
X-Gm-Gg: AZFdTZdqt6sDzj4bgB7sY+7qYh7JBcKFHCxjGQW/JGz+Mh37Bz7flqf1cwHAcOdA/PF
	lPrPj/sTJ1EEfXYnl2+PA8ousyQF5A0Estb3lsQcEfLeO9t1CN2krE+3c5E2cOv+6FauKflZQYq
	p//+JW9auw2xom9k6D+IWX2/9GpyvlGkTUnQCj64PGCdgXlDLb1BfEMErLaDxzo0dQbJpWE4n+N
	WzxRPcZeWSJo9E97H81N6maEVpEMc2P2zhhHUkdK8LvgTd757B8SuO62ZEC+lVVZgQ1TGpWZha0
	iBlv8cs4EbcdaFWWW6TBmJARvmE1DABlNuLvmd9Lsf4ZXLswLX4jSngjzAJTBinzBNShi1I0m4d
	Ee3Ix0pRYuMXFxp4CMn5hAJU6M6XRWlRkmJeZv5KLNust2E9VYXlTiKxOB1DHFKLtIljTVO1tgJ
	U1tora66qJuoH1eX+oquLDjdYlyJTm7cDDM5fzM05bdCU04KlVsz3rqp+aV4bMjIpeoiEryIpDi
	dq9bmjy4/YBmOrb8FTKsBFelJSGOs21JZpgiAaCIwBCfBqfSnP7q/wxU/rq/s3nJ3G2KGsL1OHN
	xLnhm7jMIlZyonvtKo+PrOQVvXlpdTb+BMy8rpTtHRiD2iGZX/cqu/8rjn/MnP5TFPgBxPuoc5A
	UkYjnRPObHfk5Hg==
X-Received: by 2002:a05:7022:7f12:b0:1b5:4dff:8b67 with SMTP id a92af1059eb24-1b5568eeba1mr14216791c88.29.1795509216390;
        Tue, 24 Nov 2026 00:33:36 -0800 (PST)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm32784012c88.15.2026.11.24.00.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:33:36 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+3d9e2c65bdd43a254924@syzkaller.appspotmail.com,
	co+0b5d5f4d3472df53@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH wireless] wifi: cfg80211: don't parse the SNAP header of a too-short A-MSDU subframe
Date: Tue, 24 Nov 2026 01:33:27 -0700
Message-ID: <20261124083327.2037092-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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

ieee80211_amsdu_to_8023s() bounds a subframe only from above
(subframe_len > remaining), so an associated peer can declare a payload
Length of 0..7, yet ieee80211_get_8023_tunnel_proto() always reads 8
bytes from frame->data. With Length = 6 and payload aa aa 03 00 00 00,
the rfc1042_header match succeeds on the peer's own bytes, and the two
bytes past the frame are copied into h_proto and delivered up the stack.
The frame length sets where they sit in the skb head, so the read is
aimable and repeatable. Injected over mac80211_hwsim (init_on_alloc=0),
the delivered EtherType is stale heap content instead of the declared
0x0006:

  aimed at object offset 410 -> leaked 7372
  aimed at object offset 410 -> leaked 3d31
  aimed at object offset 414 -> leaked 225f
  aimed at object offset 418 -> leaked 7573

With this patch the same frames deliver 0006. syzbot reported the same
read as a KMSAN uninit-value.

Only parse the header when the subframe holds those 8 bytes; a shorter
one keeps the 802.3 length semantics it already gets on a SNAP mismatch.

Cc: stable@vger.kernel.org
Fixes: eaf85ca7fecb ("wireless: add ieee80211_amsdu_to_8023s")
Reported-by: syzbot+3d9e2c65bdd43a254924@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3d9e2c65bdd43a254924
Reported-by: co+0b5d5f4d3472df53@bugs.sh
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/wireless/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index ebb1f6ec7efc..0a0823d1d517 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1034,7 +1034,9 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		frame->priority = skb->priority;
 
 		if (likely(iftype != NL80211_IFTYPE_MESH_POINT &&
-			   ieee80211_get_8023_tunnel_proto(frame->data, &hdr.eth.h_proto)))
+			   pskb_may_pull(frame, ETH_ALEN + 2) &&
+			   ieee80211_get_8023_tunnel_proto(frame->data,
+							   &hdr.eth.h_proto)))
 			skb_pull(frame, ETH_ALEN + 2);
 
 		memcpy(skb_push(frame, sizeof(hdr.eth)), &hdr.eth, sizeof(hdr.eth));
-- 
2.43.0

