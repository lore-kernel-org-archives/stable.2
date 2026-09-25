Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25249B1EF
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345495; cv=none; b=VU4pHpQNI+tidgwe2LZbsS3D1HzTloEwjTrpuhPI+sOLJlBK4HrXm2BkwPbftAGfXRK94PTa0vAhB7Ps4hvLlfGcTw7uPVwySTikdsDij3pcuU0GOXHAXBQ1JFNSuekffyvHIA55LDrlEKxLTXIzZNuR1KMuLn64HIEvP/YAdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345495; c=relaxed/simple;
	bh=yo5fwu86Mw0YOj9FzmflPUzYzC7n+VFBQsdjcJILCps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1NkAHprYqyk3nnmhai/sYBHcv4Mn5efir+uANKutemYHUMBUQCZeXb9aD3LjTjX+86K4t964uZrexsEkjIgHrAGLRtTX4LhZYxe8pF+5hXOy0MmjOGH1jG3WeZGRoMAjPIRSXtvipq0UrCQfqnImURD7gMgbgFfDimRUvEmh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com; spf=pass smtp.mailfrom=agilebits.com; dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b=BeuZ3XDm; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b="BeuZ3XDm"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910cadeb0so68495585a.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1790345493; x=1790950293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q2mrYp40d3SwEyzC0ifjna6lr6WRZQqdhud4xFgB7sU=;
        b=BeuZ3XDmCWzyj9lW3Te9VH4Pvy2bKx+62S87w6P7p6kW3aw0IMTZB9GNgBfYxfIh5V
         3Qvkqs+3RTlTBGVyoYsdoV6lx/xPosuxztA1RDJ17qfgvkMPBifRRTM58H+gu3VtC4Ob
         CerNsrh+pL2PDb+QXIp5rpPx+em0cr4fpGx3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345493; x=1790950293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q2mrYp40d3SwEyzC0ifjna6lr6WRZQqdhud4xFgB7sU=;
        b=rDy2IoL+XR41ICqwZ2ugfk216XAFomlBnavNo+e4vNTJXzd67rEPm1RZjw76QjVnVk
         A9RwpdMZWGNjKSDrx+fkzVs/VJS8KFmLPN/ORyZDGb0bmcZVTJWoWUyYHr1l2ZkzkoUN
         /QgIKowQYCeiENnaWelqo/hVp5S4tlvEZoAx97lARcj990QlkcNgfPDnIk7vklqBAHUA
         PaQ1GFW8NrG/cyNYkxWX9gcZz943XrABOW/ze0z6G+zNBpUH3ZShW5cAQGr6UvjGZYvW
         rrKuPGu2iuAIQ8UCbOewhLZDr5vhpcX0yZwAmIpE23UZTPFmNgIs4oCIjcQnjSHBLkkq
         cyeg==
X-Forwarded-Encrypted: i=1; AKwUvBzywFD0c2mT7vCCKoGQvRpNWk7OaJ/LaEMLxHvMRkci2WVJTxkhw1vyPuqfL1Wrd3XMhl6jkR8=@vger.kernel.org
X-Gm-Message-State: AFuF++mBuizUrz9lFYKLMXg7H4vBr+oSgbqC8c2CaDz2jGZ3Rf7XnqGR
	sSMHig+LRRtnbW5rMOV8dizcXEge1Ap0UAbp3jTLrelbd/cjBr+v3StjnOYDG2Nf60Q=
X-Gm-Gg: AYBFou1lkytg/mA9G/rDglN+rb4u1qKWWQxcq9BdhkjRjy4Q8TBf0RlUflQJbU4NVZq
	QggNs4fy7fvDJbbt5NAGTCDZiV4TsZHgLLaU2+jLRCe+LVEIj+w5T8PHQotXH5kp01pEonLxM8p
	UsY1XIr/2MkyeJxSYudEPNphWlbNa7OKxydYFU33mJbz4ZNPjTfMJp1RCc74Qn0YSR20z4w19EK
	ZxbIg4tAmRmDPDztoQg/xLcYvhVKUtnk57ep96ANiEI5WMSLjHyk2yqvBlhG+xZQjmEDNHX6H34
	4QK6fcXz+GhpCXdOkeI4lXOhqmESc4a1s3sqkSVHRjg9rGRT2YyNCvwxI5oD9OFoEJlClvGSNkj
	cpKzb5uaGH2uOLIsx2vhb4Uc+QaQNvQRzSoB0q+An9omnYbvHQxngZ8J5fgEyAhDZYaTgzLmf7V
	KjVMz4omvj2Rr4vjkvupXKMXsteWwqIHFJ29r4aUYppTdkX4oTtGSruTr+hViqdNSzkegCOtPVm
	gh0CaFPuSKGLuKoHzb8eOile8sS0g==
X-Received: by 2002:a05:620a:6887:b0:93b:c58c:d3be with SMTP id af79cd13be357-93c43d7be0amr477352185a.37.1790345492707;
        Fri, 25 Sep 2026 07:11:32 -0700 (PDT)
Received: from localhost ([2600:4041:59c3:300:7917:c7f6:28c6:182b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c448b06easm190017485a.16.2026.09.25.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:11:32 -0700 (PDT)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: Julian Anastasov <ja@ssi.bg>,
	Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Willy Tarreau <w@1wt.eu>,
	Keith Hoodlet <keith.hoodlet@1password.com>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	stable@vger.kernel.org
Subject: [PATCH nf 2/2] ipvs: skip cport 0 connections in ip_vs_conn_out_get()
Date: Fri, 25 Sep 2026 10:11:15 -0400
Message-ID: <20260925141115.16126-3-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260925141115.16126-1-axel.mierczuk@1password.com>
References: <20260925141115.16126-1-axel.mierczuk@1password.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_vs_conn_out_get() does not filter templates. A template with
cport 0 and DR or TUN forwarding bits is matched by a packet sent
to client port 0 that traverses the out hook, and handle_response()
then runs ip_vs_set_state() and the timeout update on a connection
that must never see packets. A backup server receives such
templates over the unauthenticated sync protocol. Connections that
still wait for their cport with IP_VS_CONN_F_NO_CPORT can be
matched the same way.

Require a nonzero cp->cport for a match. Templates keep cport 0
throughout their lifetime. FTP data connections learn their client
port from incoming traffic before replies are processed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Axel Mierczuk <axel.mierczuk@1password.com>
---
 net/netfilter/ipvs/ip_vs_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 6fa3e1dc534c..24dbe34a4827 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -579,7 +579,8 @@ struct ip_vs_conn *ip_vs_conn_out_get(const struct ip_vs_conn_param *p)
 				    ip_vs_addr_equal(p->af, p->vaddr,
 						     &cp->caddr) &&
 				    ip_vs_addr_equal(p->af, p->caddr, saddr) &&
-				    p->protocol == cp->protocol) {
+				    p->protocol == cp->protocol &&
+				    cp->cport) {
 					if (__ip_vs_conn_get(cp))
 						goto out;
 				}
-- 
2.43.0

