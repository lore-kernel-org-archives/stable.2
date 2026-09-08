Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E45592E8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876962; cv=none; b=WxtNe6Aed/aSSZ7xa4190i/yjRWo/NgY3DJefVmbtAaRaZf7hXJks+FMvG0dM0ZQo+T1C0CAztk5NaPTU8bzS5TuuZ4GCVhrKNeV451Qm/hGAlHEcMzaSK0ZjHb4snpJC3d+w3KYyk/Eyqxf+FSCdjA7m8kdO9TeHROCGVPNMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876962; c=relaxed/simple;
	bh=IsgZgtm5pOLfB+cdDXwo/CYfle/wahkTjTOEpWpwdQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vmvq81SZqlHgy2XZvFGdAx6uLVrqKinfy37PPo52xYjbEpIH9KLTEYXDyzJAgLWLGlFZiJBQSRH/CJKaHIvxXM/vCLg7U1JDIHu2jOM2CaoH6FYFeAx76rZmLoj821nqAgXPvkYjYimnXRhEuNN8MQwrBB9qHdrxJidoARXsaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp2KrvrO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp2KrvrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788876952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A5410s9Qo6j+t2XaIqBdkNResT35DW/jWs/0db2Ook0=;
	b=Xp2KrvrOZyjeI8gXaUdItHDYY4Qg5V+yFTBDBolCfOUdk3O0+u/CfKrzoqGvS513qwV9bX
	BQ1jC7LDUNywa8Q8LytYMr5z6oo+K+WJEHKBv2qUhGZ6hGiNprnwvkPyFjNHt0SnB1bmGU
	5KH7m5p05aMe3QwWcFPlwJ6Anrl6yDA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-L65PQtGROpuUgDIusHUWFw-1; Tue,
 08 Sep 2026 10:15:49 -0400
X-MC-Unique: L65PQtGROpuUgDIusHUWFw-1
X-Mimecast-MFC-AGG-ID: L65PQtGROpuUgDIusHUWFw_1788876947
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D3C41954B12;
	Tue,  8 Sep 2026 14:15:47 +0000 (UTC)
Received: from ebuild.chome (unknown [10.44.32.224])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 863FA1800347;
	Tue,  8 Sep 2026 14:15:43 +0000 (UTC)
From: Eelco Chaudron <echaudro@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	cpp.code.lv@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()
Date: Tue,  8 Sep 2026 16:15:17 +0200
Message-ID: <1b1582eb07550d71f3cbe210e5cb31eeb8d0ad86.1788876917.git.echaudro@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The ESP and AH cases in get_ipv6_ext_hdrs() used IPPROTO_FRAGMENT instead
of OFPIEH12_FRAG when checking for out-of-order extension headers, causing
the fragment header to not be recognised as a valid predecessor.

The original code used IPPROTO_FRAGMENT (44) as a bitmask constant where
OFPIEH12_FRAG (1 << 4 = 16) was intended.  IPPROTO_FRAGMENT encodes bits
2, 3 and 5 (OFPIEH12_AUTH | OFPIEH12_DEST | OFPIEH12_ROUTER), but not
bit 4 (OFPIEH12_FRAG).  This caused incorrect OFPIEH12_UNSEQ verdicts in
both the ESP and AH arms: the ESP arm failed to whitelist OFPIEH12_FRAG,
while the AH arm accidentally whitelisted OFPIEH12_AUTH.

With the fix, a packet with two AH headers now also gets OFPIEH12_UNSEQ
in addition to OFPIEH12_UNREP, matching the ESP arm which already sets
UNSEQ on a repeat, which is the intended behavior.

Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>

---
v2 changes:
  - Updated commit message as requested by Sashiko.
---
 net/openvswitch/flow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 46c1d66aad8c..868d9fdf3afd 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -288,7 +288,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
 			if (*ext_hdrs & OFPIEH12_ESP)
 				*ext_hdrs |= OFPIEH12_UNREP;
 			if ((*ext_hdrs & ~(OFPIEH12_HOP | OFPIEH12_DEST |
-					   OFPIEH12_ROUTER | IPPROTO_FRAGMENT |
+					   OFPIEH12_ROUTER | OFPIEH12_FRAG |
 					   OFPIEH12_AUTH | OFPIEH12_UNREP)) ||
 			    dest_options_header_count >= 2) {
 				*ext_hdrs |= OFPIEH12_UNSEQ;
@@ -301,7 +301,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
 				*ext_hdrs |= OFPIEH12_UNREP;
 			if ((*ext_hdrs &
 			     ~(OFPIEH12_HOP | OFPIEH12_DEST | OFPIEH12_ROUTER |
-			       IPPROTO_FRAGMENT | OFPIEH12_UNREP)) ||
+			       OFPIEH12_FRAG | OFPIEH12_UNREP)) ||
 			    dest_options_header_count >= 2) {
 				*ext_hdrs |= OFPIEH12_UNSEQ;
 			}
-- 
2.54.0

