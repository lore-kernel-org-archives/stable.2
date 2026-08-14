Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE29348896
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685149; cv=none; b=TPPGo5g0kQ3VMH6yikfSklhBZ0sye0LyFGZbCdgcA+OmFq/IvSwwfGJJFASGYQd7eDYJjUeKeMV79ggdHiDONFMX1VLAKez1pjlVkuMdexcUw6c3GyGsgzWnpb2CZlaVCykER4GO7r8ULAMeJmEe4yIN+cJpvpi7fFWZeFatnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685149; c=relaxed/simple;
	bh=H/0j9VTGpIw85o2pShiiCvoF0meADA6ZpVf/rpuGrzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lj51GDYJK4lInA4DvEsRnj2uVyoQr3MXHU8Il9ddS7dfu8g+Hz2dmYXtCFk5tjeXgnwydXxt46KJz7Sbe7SUsUzNj7/a00CtSy8vtla8+5HEVYG9oWZ9NPTvVZSwMYSxBdRtEde7neE7tb5YZmA9wrBgeHNnxut7TmujegrMnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ptcOfzHI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ptcOfzHI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d0407aedd6so8401545ad.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786685147; x=1787289947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLASIE22a/uiaobsLF58hTYRb9DY+V8EmMZ+My6U0Ek=;
        b=ptcOfzHIx3edXb/hZ9wHxTJq7Bfmu4sPm4ZYm+a/sCof+XTURd+rmjKXQ/jsGVsaS/
         2qsDv/f1gswkdU6dsVNDEjVicNqldOk2tgDUGaAe3y0uTZIztJdqv+GyJJF56fnWWa9O
         K9Su4OQcpMstaty+q1xZ37DENNd6Ye1AOECAVh+KoYQWNTIGdeBnwOjD6e1WqjJwspqr
         j51vjnWX+TS7Qx+U4qmvNxoS+405u9RVRGI9fagKFH565fBUgWN2M7aqKijXCRv5j3ap
         3J1XFMMzOolwEYyyaRs60ZhjNMXqGYPFJLsmP1mGlOvAH55vNZLD9kZS11Q0k8gzux64
         TZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786685147; x=1787289947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LLASIE22a/uiaobsLF58hTYRb9DY+V8EmMZ+My6U0Ek=;
        b=oS3xMmfwn88uJJsUeE9PNREaVxl615fxAOPuvBLXB6jLXZeUZI57ARvAARrgHXHS27
         lRx573jOmZM++34529NB/fosWJlG0vcd265WCJ6MfMl4gUV7tGtnhLHZT8CZwvNZ06hW
         FH1GQdUc4W2g0AUdTmU7FOQ/1BKCohWOnkKShC9jtiIpYowqWrVBXokuzoPodae1jtQt
         t091tAks3wE80Z9IvBT7HQXoo8GAAVnrlogCYzz31kH+mCym371/WXe5zfevOiHUAjo5
         7rZy601VQ4XiMahk/2Mb3Ktbu9MzA0pPsV3/AQ+wtrQjAKndfbyezLS+ier0HycRTrBo
         9cPg==
X-Forwarded-Encrypted: i=1; AHgh+RqRpbsmmobdmD88BYVmRe9YNuyMVd6fS5M/Et9uppTuCnmpLHlVZbU+WpNldkvTuGT+S6JPM7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWfGJg1TF+IIdCRfq3XAsow0As3PXIpospuAZMdNZDvpgqpaJ
	xfMqDh9ASbamHGEQpRE/mZch73DII5UsPo18ISYQW/I0pMxnV/YB1tNBRIJVTc9CfA==
X-Gm-Gg: AR+sD13BRdi/I30gmDj2royzKf0UVneLBSsRM3pQetlkYhrgy56rhIas1eDb8x5fOMd
	vXvtnv7aoEh1BTKZaHwqCaJthiEZzFoctGzp5SOdHFoab51VIjN+/YVxtC0oBvhByrMPMA+Y90E
	Iv7h8c0ux43holhPpdAr2m+w5QRe16f6uARmJTqfPnOQGkbNqygJq2Pf1ILVr3L5Y1zhdjO2pvG
	MsMUGBFNyFM88I4TMohzgzp4vkCwD4mVo3q1CyTS9HZHl9JBx8wwzTfVRuz+bPRJ7n3373z0GGA
	K+8VhjNI6UaoXkFU7oT6EE2Lt4wd5Rr9DGIN6nR0IlyiUWp7n9g/SLQDtvWV9CxQcPV03+D0yE2
	T2Ke039bgzEe4j/4CZnNPF3JpqCV73CH5COz6nBpO4Uq5Eo+uqki+shD3jl6elYoKbUHKWY69HZ
	XtiiwqVyyy/7QmWKrXhF2VYe0nkjxZbCpn6C/LH5uXguYBWVGO7CKxWEheQjh5ZVyigUW8GQ==
X-Received: by 2002:a05:6a21:e58b:b0:3c3:8255:8c4a with SMTP id adf61e73a8af0-3cc71ebff67mr3607716637.17.1786685147097;
        Thu, 13 Aug 2026 22:25:47 -0700 (PDT)
Received: from p1.. (209-147-138-29.nat.asu.edu. [209.147.138.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387e49d3sm5051237c88.7.2026.08.13.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 22:25:46 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: andrea.mayer@uniroma2.it
Cc: dsahern@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	bestswngs@gmail.com,
	justin.iurman@gmail.com,
	alex.aring@gmail.com,
	davem@davemloft.net,
	horms@kernel.org,
	idosch@nvidia.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stefano.salsano@uniroma2.it,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
Date: Thu, 13 Aug 2026 22:25:41 -0700
Message-ID: <20260814052541.1198373-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521200859.816b8923b5f27bba6124461e@uniroma2.it>
References: <20260521200859.816b8923b5f27bba6124461e@uniroma2.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrea,

We noticed this is still not fixed in net.  We tested your idea and it
works.  This is the patch we tested:

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 9c677eb1d1a6..51941ad656a3 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -368,23 +368,16 @@ static void seg6_update_csum(struct sk_buff *skb)
 			   (__be32 *)addr);
 }
 
-static int ipv6_srh_rcv(struct sk_buff *skb)
+static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
 	struct net *net = dev_net(skb->dev);
 	struct ipv6_sr_hdr *hdr;
-	struct inet6_dev *idev;
 	struct in6_addr *addr;
 	int accept_seg6;
 
 	hdr = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
-	idev = __in6_dev_get(skb->dev);
-	if (!idev) {
-		kfree_skb(skb);
-		return -1;
-	}
-
 	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
 			  READ_ONCE(idev->cnf.seg6_enabled));
 
@@ -485,12 +478,11 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 	return -1;
 }
 
-static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
+static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 {
 	struct ipv6_rpl_sr_hdr *hdr, *ohdr, *chdr;
 	struct inet6_skb_parm *opt = IP6CB(skb);
 	struct net *net = dev_net(skb->dev);
-	struct inet6_dev *idev;
 	struct ipv6hdr *oldhdr;
 	unsigned int chdr_len;
 	unsigned char *buf;
@@ -499,8 +491,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	u64 n = 0;
 	u32 r;
 
-	idev = __in6_dev_get(skb->dev);
-
 	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
 			     READ_ONCE(idev->cnf.rpl_seg_enabled));
 	if (!accept_rpl_seg) {
@@ -689,10 +679,14 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	switch (hdr->type) {
 	case IPV6_SRCRT_TYPE_4:
 		/* segment routing */
-		return ipv6_srh_rcv(skb);
+		if (!idev)
+			goto disabled;
+		return ipv6_srh_rcv(skb, idev);
 	case IPV6_SRCRT_TYPE_3:
 		/* rpl segment routing */
-		return ipv6_rpl_srh_rcv(skb);
+		if (!idev)
+			goto disabled;
+		return ipv6_rpl_srh_rcv(skb, idev);
 	default:
 		break;
 	}
@@ -837,6 +831,10 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	icmpv6_param_prob(skb, ICMPV6_HDR_FIELD,
 			  (&hdr->type) - skb_network_header(skb));
 	return -1;
+
+disabled:
+	kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
+	return -1;
 }
 
 static const struct inet6_protocol rthdr_protocol = {

We don't want to take your credit, so if you have time, could you send
this as v3?  If you don't have time to land it, we are happy to send it
for you.

Thanks,
Xiang
