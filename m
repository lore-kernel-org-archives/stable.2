Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725159;
	b=HWo67REL5PrnkPjxzMxIJhTeB+Okq2I5qFExSWHchnA8IDcwGLB27gpLKui5MxPdrtPd
	 IOQyYu2tirEDsIxW4b3Azxiohk/opGXTm8dQ/JW0wikxPcxiASoLt16JaejapHXQ7+8xq
	 ahJ1nZB6OauSLpRtb0EagcJCndFBPCvqZq0UNEOw6n8HUgM1e7f+k6nU7CFySYs7Pr9CB
	 TTzypQsoK4D3xt4+JDpgqi0aNZVmQzAvo7PPRASjMxSgWeJgHAOdZmHEq4NnIKuYFIa66
	 fDimMGjveTcRqVxb38RqYediyPPFhBHod9M9UzNv84swK3he7RF2NiwEf6hvcKR5sCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qyie3lp94voMetIz4ZK0UyMQldPElbkTK8vbvrxDQEs=;
	b=h8Lj1K1BXIugSZtfP5NpMvbVLSjEpQBRO71wIWG3bmaxiB7hGBaYdqds7UogOGlXP6f1
	 bFbJpJi7F2dbEKIy794l1gnamVgZYO+mIe6UiI/mz16QHsVIH4V53AMBjdqR+1vPcMfJP
	 05ZxiocBwjRSdNpB4BmplIG+pmKe9SuCxC8HJDCwifZYpjAuIVBdEUk5wm7+TBhuo3ivi
	 4JEGPSbv4bP1i/BGSQ+djP/voERvMgHMgNilsMyXl4G/FegvJ/04tVDFMibAn7s6mBS7w
	 t0tqALM0UsSIh7j1cmNEuLvuzEzqfS2pVdRPsEE3VCKZ0iXhiONQCXR7/aTQ3JswZnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1password.com;
	spf=pass smtp.mailfrom=agilebits.com;
	dkim=pass header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=e2u4H5ji;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5819606A330
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5819606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=e2u4H5ji
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9441591aa5cso109169185a.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1793725158; x=1794329958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qyie3lp94voMetIz4ZK0UyMQldPElbkTK8vbvrxDQEs=;
        b=e2u4H5jiGKGo9r6gEd2se4tGTZwmdU5p9nRdnHtOCSYXWlvFZj83tcGAwxxRpJ9zAV
         Mro8wC0WTq2rpRb1Ji8FduryNwdXihHaxmOaRYFBF1Tw8cmDMDaeaikwpbhBcj0Ovq4t
         1zp7PeTOuJVNUfTKrkm+Y2EsfuDAtAvurwlTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725158; x=1794329958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyie3lp94voMetIz4ZK0UyMQldPElbkTK8vbvrxDQEs=;
        b=eVmyKv5E/+EKLox7pNQyRFzRNf32y77qzrQURyvtoKC5EugFPSm/2CpfSR+EXMwc/z
         4MABeQnqu1PTXMKV3UUW+BBEvU9LcSg5FSCk5H3Z3aitO6sEAt9J1tJJey6nzpBNJvKy
         A6vcpGTP1FCuAw58Hz0b+TCbDEgkhcQmJqH9PyiM5Zbe7BNzX2fr7moGk1J2ly1JkWrC
         SQQA+25TdjrgFqo8rG7Foa7TkLXz02JwY7pxo+twCokYBZgiXHQj1QkLmxoyZ3atVvC+
         dpN5kK2AtXwYcMzFY4HtymhnyYAlkN09B54VAIwAM/P21EVkqnPQzvCQ/W2rDKhxJffO
         F/Hg==
X-Forwarded-Encrypted: i=1; AKwUvBzNGfXKsDCFWz+qTuKa+EZwQvavS37yoADMhMjnzMCuJr3SPB9eUJuiTYW4Ekt+kFW3YnKFmuw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eKppLEclWwV9SF/nFzMjM/972Kys8JuPXHtuugvWfxV+/d9kt
	NoAOpOOL/0Al7OXMfrdqkubDh22po302ELeBZQqil72nZJi9JK8hLsSXmcEOHSfFiNA=
X-Gm-Gg: AYBFou2yKnCbEYSYBroSiQn/T6Lpg3cRrUJ5MssCobsk6zB/VJO0akI83L2Z5lyoqQj
	Wd4X2UkclzklwTS/wXnBLdTEpJBr09LgGUU9Maq+M/KHR/o/B2jAwhqnErJz0L1b33mfo8qzYVV
	gLbLBj3p5t1VQEoyghoVf2Abe9dkibxeCYmWKXbP5dJIuDKJnJaTpVhQysxNWhUSbwSMVL+8d4L
	prO6IHpMPXFplwCLnMr5kld2k7kp9Ic1wUHXyPLnUC5N5JA8FV4SG2SwEsWCnP+8ogoYhigKiNL
	TNCqrla8lDryjFFuqdFtQ+sDIK2fLBuJHf2Bt1IPKo5tXxUXwb9LbXS8e9Ti6vq2msOa/MrUZh9
	/rGK1Wikx8QVAAmdC8lwH0RRR+/j4C7yfKJadl0vpDru9lOvSdxyUQIlqHqjrURDl6Aga2zh4pc
	CyUheadlrBd8P0+IKiSzkUg0HcS+UwSXe+mj/FnlQ5fV9ZQrWRYHmGn4I4QH8VV2w2U7Ax0F3nf
	ile1oNl8vWEwtX83aIjxdlZ4v6MPoCr+fEeLKIXA0cl56oC0Mr5whdJbz7YLADLxSTKtyzrNDHK
	Bz0fROcmKLnr1nLvQL7hmC4Pgh3HSESQjDaRWJsdpjaTwjqq4gp0Ptt8IDzuMowdzv/wMiVrsGW
	4uhFCbw==
X-Received: by 2002:a05:620a:4613:b0:93f:1789:8359 with SMTP id af79cd13be357-944133bf945mr2719600885a.31.1793725157802;
        Tue, 03 Nov 2026 08:59:17 -0800 (PST)
Received: from localhost ([2600:4041:59c3:300:a850:2af1:eb93:4121])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d3410ae4sm5514285a.26.2026.11.03.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:59:17 -0800 (PST)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: ja@ssi.bg,
	horms@verge.net.au,
	pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	w@1wt.eu,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	stable@vger.kernel.org
Subject: [PATCH nf v2 1/2] ipvs: validate cport in received sync records
Date: Tue,  3 Nov 2026 11:57:45 -0500
Message-ID: <20261103165746.39516-2-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261103165746.39516-1-axel.mierczuk@1password.com>
References: <20261103165746.39516-1-axel.mierczuk@1password.com>
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

Local templates have cport 0 and IP_VS_CONN_F_NO_CPORT clear, so
ip_vs_conn_in_get() cannot match them. A template received over the
unauthenticated sync protocol with a nonzero cport can reach the
protocol state machine. Before template state validation, this
could cause out-of-bounds reads, crashes and kernel data leaks.

Ordinary records with cport 0 and IP_VS_CONN_F_NO_CPORT clear, or
with a nonzero cport and IP_VS_CONN_F_NO_CPORT set, create connections
that incoming lookups cannot match. The latter also keeps the
cport-zero fallback in ip_vs_conn_in_get() enabled.

Reject all three cases. Continue accepting ordinary connections
with cport 0 and IP_VS_CONN_F_NO_CPORT. The companion patch
"ipvs: filter some flags received in the backup server" rejects
template records carrying IP_VS_CONN_F_NO_CPORT.

Fixes: 87375ab47cd0 ("[IPVS]: ip_vs_ftp breaks connections using persistence")
Cc: stable@vger.kernel.org
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Axel Mierczuk <axel.mierczuk@1password.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
---
 net/netfilter/ipvs/ip_vs_sync.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 157f5c8361ab..a85dc95e29cc 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -853,6 +853,25 @@ static void ip_vs_proc_conn(struct netns_ipvs *ipvs, struct ip_vs_conn_param *pa
 	struct ip_vs_dest *dest;
 	struct ip_vs_conn *cp;
 
+	/* Templates require cport 0. Ordinary connections require
+	 * NO_CPORT exactly when cport is 0.
+	 */
+	if (flags & IP_VS_CONN_F_TEMPLATE) {
+		if (param->cport) {
+			IP_VS_DBG(2, "BACKUP, template with cport dropped\n");
+			kfree(param->pe_data);
+			return;
+		}
+	} else if (!param->cport && !(flags & IP_VS_CONN_F_NO_CPORT)) {
+		IP_VS_DBG(2, "BACKUP, conn without cport dropped\n");
+		kfree(param->pe_data);
+		return;
+	} else if (param->cport && (flags & IP_VS_CONN_F_NO_CPORT)) {
+		IP_VS_DBG(2, "BACKUP, conn with cport and NO_CPORT dropped\n");
+		kfree(param->pe_data);
+		return;
+	}
+
 	if (!(flags & IP_VS_CONN_F_TEMPLATE)) {
 		cp = ip_vs_conn_in_get(param);
 		if (cp && ((cp->dport != dport) ||
-- 
2.50.1 (Apple Git-155)

