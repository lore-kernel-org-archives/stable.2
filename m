Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F434734DE
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345494; cv=none; b=ErTW6objIKjJ+BQZ7kVuSvWfdZjWcnd7YLcD2aCkra6pEHS1aDiReVwxWwsZedBWBS0/IQCiKZSOuRRyH+KuoidMwY+IqnY3VyDJRla0SHELefMsq0NRo464Aoyx+KrOsGR3MVdKm3nz5A0bHByoHSPWRXeqJfXTkMNuxr5dfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345494; c=relaxed/simple;
	bh=BnuemxHse+a2/gGmYQjf5SbAdx7uvJn7RYhO3uV+Qmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3u2MXxnHbrVuR5fetmBUfRTdjmwlMMF5SlSn/pIH6mejUJ9t+ltrDFNa+i3s7RZgrSuQwQp1TWkOlO40Ud85AJuqrUKV2NE0s6P81JKrkneExtwq4M2NBxJKLJ6HByxeBAZQTgERaKTIIIi+3D8uKDCrsLC++oUpVh0aDMDVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com; spf=pass smtp.mailfrom=agilebits.com; dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b=B92yiX1u; arc=none smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b="B92yiX1u"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-9144083bddaso1312316d6.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1790345492; x=1790950292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h/EePFAN2I0oSDWPKvqO/KiMg/JE8Drv0QT/R0nbfqc=;
        b=B92yiX1u+05EtCtx2AhCFuC8mP4bluVjTL5SEs+sQX308H47b5YOTJL1/9/jtMyAk7
         //lBF1cstwiOOYRgfrZsov950rU8wMWjyf/nEPfKbUBsAejWAxynyeMQ3/bc7Duax25i
         DyZis8JmqoQelvzaBWLPsNhGfyKlTUSzE2NWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345492; x=1790950292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h/EePFAN2I0oSDWPKvqO/KiMg/JE8Drv0QT/R0nbfqc=;
        b=MIqVDXCiji/0uoBMoUld1G2EzpZ9kbt4lslVJOuNd3Q8f5vtu230hcwPlvM1dJhZ2g
         oHQQsnk+rWraGFiIXJF6+OXQrJrWZMTY8Cq2E8s8cuDYcV4+fkPsYJlF/38UHAXZ0+d7
         BvFiQqzR0DRtobRvJeohSaFIu0wsyaYX1S6KFUytEsjAXFnssAklKrRNqFU7cRkKq2+S
         q02RSviN5sWOtKBgEEBNNnVaFhMe9a4XgyCiCD0cNILU64KfGO5tj+gFcskhodJjaptv
         npxtHb7l+VqJe9CSj0aeWOOEZo0pJikwArm7cipzEyEz6ZmbQAvWpFI+JG8gKr7Qmg/j
         K2vQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgzyRcpClnA02sjnDkBWHFbdBnZDsMQc6uZO2fsSN44W5/35TMam6r8mVEWK1zU0u7suzfHV8=@vger.kernel.org
X-Gm-Message-State: AFuF++k3m1bhk1dQO/21a/6na1NqfhfznGSsV5LmejHY67ckSMmJrTgC
	Wz10B7PCKXLtX9/GILlKoH2PwK2iPiFQ2/TYMLFnXkZop//Ja+hh2NR0Fo1bKoav/EY=
X-Gm-Gg: AYBFou1vtGkYPg6vjMeu5Rg4oficTVBKsD0vWdZ5o5Z5n6Rcf95wZYv6SHcIYYP/S+W
	SWRN/ur4TumiZyv+3M8LdHxKCmfUyd2BZ+fdaGJBUp3RZcTxgWpQcDD9s3KVbwvySvg6figbVQ4
	n53hOQhzE3cUqscyQA99nF4S4evSDPxuGhVnv3/P8RO3tzSk4mzn5e/KbmUr4tZTOhBD9c9RiVE
	XBu6iYzGjMM37JQcBMy7qbYSVSz8b6AAvBVIMiVVaBht9HVvTVkMzR9ad4slaFaY2iwOqb1+1kR
	cyNP+JS8cet75oC4l7YkVnYU6wPMFCnKpVVtdWHs6ZDvgJVg3j/O+KyNiXSI0NXA6kJ3Ojtg8Sp
	ihrhWhREBlGvvFfjZzXuPBNsykn/KbDr7DDtag4l+fvdDxXyS/Fd5TKL120NZ8wqME/8KgqohxJ
	0q3+64ZQgn0gi2IvDAByhAGh4Tp5LuWxG+PcN5fJEEg9vJjsPwMtJk2SXPSau1cwgjykwi5mdBo
	hnWzGlUbgIr9qlXmMnH/OGv1kiafw==
X-Received: by 2002:a05:6214:3116:b0:90c:b843:d679 with SMTP id 6a1803df08f44-9142f8c7f44mr44499816d6.29.1790345491808;
        Fri, 25 Sep 2026 07:11:31 -0700 (PDT)
Received: from localhost ([2600:4041:59c3:300:7917:c7f6:28c6:182b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9143f0cc9d3sm3637356d6.19.2026.09.25.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:11:31 -0700 (PDT)
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
Subject: [PATCH nf 1/2] ipvs: validate cport in received sync records
Date: Fri, 25 Sep 2026 10:11:14 -0400
Message-ID: <20260925141115.16126-2-axel.mierczuk@1password.com>
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
---
 net/netfilter/ipvs/ip_vs_sync.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 5383aeafb0ae..3998e9a0a391 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -848,6 +848,25 @@ static void ip_vs_proc_conn(struct netns_ipvs *ipvs, struct ip_vs_conn_param *pa
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
2.43.0

