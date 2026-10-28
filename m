Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187116;
	b=ZQZ+ErhBNkw5lBqV1LtVo3ORbEPtY417bHs7snIoC2YTEM+rM2y2BKPmoqmLxqZC0Hac
	 jC9Xbadrsd9JuA4UlwV4GPcTH/Kkn3eje4tvIXP4Y63X4qXamyGgQqdsxF+CPLMsx6qZX
	 i3SHEneHqOAJjScePCJPmwcnPQ+/X+DczeyuXVt6ppzXLRNs5kLmDtz+qgqOgO0OucT5g
	 oUxOe438JR9iTCF8RY8mHiJzNG6rf3F7JNHB1T67TEi1fFVUpTzE8y6KANsR+G8GKvcM8
	 qZznWiXArTysA8L+I1zj/INJ49Wb23qEqbNDEhfaaj5xbA6bkSOZ1RkTWjMaVw9+5+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187116;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KvuBuwOhhaYmamcTSDk3hPj1rRzQq1G67qxMNZQ6S5g=;
	b=wXkZQ4HyPoF8rZQDiEcmuakXtdUmI+o2/j/KCdGP3ojHmFUNhLyAUNTzGq66aE4PmyCj
	 zqiZdzouT9ZSSsKMaXh4YNAT+p7xzbRgV0xiCP4A8B2qYktl1C781CGOyteh00Im9faXH
	 XBdpIhwDq9N8rjld7foH5B0pzUAxQTWjt+Ft5zVR80TPeuc3AOKnbscfN1qJFH8LWelSx
	 QpXFkk+VPM7tVEkSdvrgR2CF87abpccilMoiBjc+AnFdsIggYWH9NrYgcntoR87kH5Udq
	 DGloXbF2Z+8pfdlnu3LOFRASjk2sEF/yYQwqju3r7tWsJGqasqZU4AkhCp5dDA9AZvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=BP8JXNnK;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9180D606A321;
	Wed, 28 Oct 2026 11:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9180D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=BP8JXNnK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=BP8JXNnKuF2arqCOCI2pY7Sd5FwvWISknjYYz1omPpVcQygqnEkgB7FTwFVLNGc1aFUgncOedNbjG
	 aUlXdbgieeaO6k70+bGN9X1l3h8WHAQ1KjtHXtRMb3+17kAJR1onT+r9oxyAK4CFdqIOXmjZ0xLE+E
	 9iuuRTItbXLuBPA8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae1dd1dd76-2e04b;
	Wed, 28 Oct 2026 19:31:45 +0800 (CST)
X-RM-TRANSID:2ee66ae1dd1dd76-2e04b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W6400298 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae1dd1c768-052d5;
	Wed, 28 Oct 2026 19:31:44 +0800 (CST)
X-RM-TRANSID:2ee66ae1dd1c768-052d5
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangbin@cmss.chinamobile.com,
	stable@vger.kernel.org
Subject: [PATCH] seg6: fix OOB read in advance_nextseg when segments_left is 0
Date: Wed, 28 Oct 2026 19:31:41 +0800
Message-ID: <20261028113141.2111-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
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

advance_nextseg() decrements srh->segments_left and uses it to index
srh->segments without checking it is non-zero. seg6_validate_srh() permits
segments_left == 0, so a packet with SRH segments_left==0 reaching an End*
action underflows the u8 (255) and reads srh->segments[255] (~4KB out of
bounds); the read bytes are then used as the new IPv6 destination address
(info leak) or crash on unmapped memory. The decap path
(decap_and_validate) already checks segments_left > 0, but the standard
End/End.X/End.T/End.B6.Encap/End.BPF paths do not. Reject segments_left ==
0 before decrementing.

Fixes: d7a669dd2f8b ("ipv6: sr: add helper functions for seg6local")
Cc: stable@vger.kernel.org
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 net/ipv6/seg6_local.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 53f7b2452..1d8312467 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -310,6 +310,10 @@ static struct ipv6_sr_hdr *advance_nextseg(struct sk_buff *skb,
 	/* skb_ensure_writable() may change skb pointers; evaluate srh again */
 	srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
 
+	if (srh->segments_left == 0) {
+		*reason = SKB_DROP_REASON_NOT_SPECIFIED;
+		return NULL;
+	}
 	srh->segments_left--;
 	addr = srh->segments + srh->segments_left;
 	ipv6_hdr(skb)->daddr = *addr;
-- 
2.52.0.windows.1



