Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29BA418359
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157292; cv=none; b=HJYRc7Ke61S6g4Ck7cJCh5Uzmquxm7TYnsexkW/HWJHqu2jVZoSdKaUtcpUiAwiAgmur3mADmhPxiOXhzwqXX9S6eTQ0Oxml6Ejb+3PLm8t5bnKENro5N5iRUyIUcMbXXvlrHQ7t0n+LL9QYyE9ckCgSMzMUYuGc+UDlPIIo08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157292; c=relaxed/simple;
	bh=IUticTq4foak3yxsGQl2vQDiakNmvntsdMGpOFGsCD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glHwU7GgnnvUZ4x1EuGizLDMfpC4n3/eMirBqIEcncIK17eyPgEFPLljptZL7XYlaKzld89qYbvtsnMmhfEQ6YbyAv41EZ42C9jFG3WxgUmueuOPL9L1Fkv28FjT+rW7gjSkcAG4WCVVxEndbpT/dR+JUOY6lWs+GfGZ7lDE0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=iisnueaK; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="iisnueaK"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so4376855ad.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790157288; x=1790762088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQDxycOIV80BPgrqxrzM7NANBApnebD30BToWezPxAI=;
        b=iisnueaKSaCz7CXaV8b7t8il/3RUHIYzy6lPx6TVpmG9za1rfF1/0Je4dT+5Ut8icn
         MDCQDiJ3nd2CFnN3rea8FYDjR42/I00+ZXLB+I0amPG2W87scf2m96JZ9n1w5+nFzJ0b
         toCVyg4+DOWleDkqmhccJAFWDdnsdfz1Lwl+eCsdJcFDzyLOoMDOeuuczfH/WNdxmsif
         j1PjijPDrKyO1I6DvULKYCDjVQF8BEhsvhXikiIkTqyGKxKYIdb1FaxQUZNBe3cahPGd
         N6n0b+rajCoH3tcNnrdxv4+9hju/Tz760jp7p/gGY1E++LswVcYcsYZEcIVyL4cIgvwY
         Myag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790157288; x=1790762088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQDxycOIV80BPgrqxrzM7NANBApnebD30BToWezPxAI=;
        b=W2j+ny0vHVgGDCcMpwYDZ8enTYK0S5ZiWdOh/DLIvTFTc6BPUQvKfOHYfMf2s+cqdd
         o9oySZvkQ87m5mcRUnYZvcZziqBW7zrx/15r6LZ5kxnjKc51fV9xuEwo3S1LvugB0Kca
         0xHPYCXFtKOzUkJwbR836c0Po1nlyez0R++lRN2NQZ/VH109b4Cohf6+RAjIxTuYwFqm
         yaeovAD15fYkLhW0jdS+d5fKCNlnC1Fez9IDtz5HFkeAgrOuKNs8bPQpJrm1irh3YqOx
         wweOkiyVFSEARJ6JE2D6J9F4cIJhHiTuTXKEuKuqyYSGyQPByJKG/03wKB55aLTpVhPd
         4BiA==
X-Forwarded-Encrypted: i=1; AKwUvByYT0UGiSoJoDdREl4b+tKaeATKkA59JEzbeeHOt+9F2NvwWVP+X2/gGH6BfMmgZardPiXveqQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lqHp7RQ6n0xQxoY5gKFJPGC5k/W30clyO2M4dglVhr9eNn2cvU
	7cRn3GpQjAzeSGxwcYc0mcj414uvjZLl21zlTdgZZ0F66k0WwRV6VPQlm7YyUkWOn7j0
X-Gm-Gg: AYBFou3MQOsem8UKwTBO7lEAd7JYwr59LbsBGr2oSvEmq13MWJzyBLEJP7n4uP0JLqJ
	VbwRucY9NKL+U3x61cQPT+gO+vxrQrbPQXaTbOF0UnkOB6OqhCJ8nanRwSWRDL1wzI5iADxl2YB
	l4YxzLrrwBKQEaJ3fVEKl/WfnB8DrcXsszXyT6pk8j1gNO76SxHNkZ3UmuJpOHFr4ombxe8EYDr
	sW0rY8tYRbeCtLwDc5ezdxgKy8D/97UHe9q5nW6yCSue5i6bNoHECz3+JWVYnV4KT1wT1EkoSv6
	oGf7dLvgaio/BKwVuwbQCTdEM8+8fAcfScVG1za/BoeIrkFWdlEw+ZOOmTX7IFqPbfCI+ktd0t0
	x538jHe1zQ0uYxsv0NEUoi4xI//3SKEXoB4p5Q8q+JK7dW1vgp8NLiAdIxhJEtR8gEw58E7gQkS
	ZWo9nUWqgQiX2wA/9ZEnZ8aOiUaT5w5dZy++iRB2BLvMRb2P86qkQWpg0BUdiUNnO5HNW7wTsIj
	osWEz8kj9qOK699tzKzCZWPL0eEIQ==
X-Received: by 2002:a17:903:234e:b0:2dd:ad73:c983 with SMTP id d9443c01a7336-2df69d595f0mr17906435ad.27.1790157287897;
        Wed, 23 Sep 2026 02:54:47 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc5f3d7sm4793862a91.16.2026.09.23.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:54:47 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netfilter-devel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	horms@verge.net.au,
	ja@ssi.bg,
	zihanx@nebusec.ai,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH nf v4 3/3] ipvs: reject FTP control ports as data ports
Date: Wed, 23 Sep 2026 09:54:15 +0000
Message-ID: <b5c5a01607eabe55a6a5a27a9ed40a0ac8ec65fe.1790146910.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790146910.git.zihanx@nebusec.ai>
References: <cover.1790146910.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_vs_ftp_out() creates a wildcard data connection from the
server-advertised passive port. If that port is one of the configured FTP
control ports, ip_vs_conn_new() binds the FTP helper to the new connection
again. A subsequent wildcard lookup can then extend a controlled-connection
chain.

Reject zero and configured control ports before creating passive
connections. For active mode, reject a zero client port and a data port
derived from a configured control port.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v4:
  - Resend the FTP helper fix as patch 3/3 with the generic cleanup fixes.
  - v3 Link:
    https://lore.kernel.org/all/cover.1789877273.git.zihanx@nebusec.ai/
changes in v3:
  - Keep the active-mode guard for configured FTP control ports.
  - v2 Link:
    https://lore.kernel.org/all/cover.1789435989.git.zihanx@nebusec.ai/
changes in v2:
  - Add the active-mode check for a data port derived from a configured
    control port.
  - v1 Link:
    https://lore.kernel.org/all/cover.1789110326.git.zihanx@nebusec.ai/

 net/netfilter/ipvs/ip_vs_ftp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
index 9e3e005a82635..4822a1a75212d 100644
--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -62,6 +62,17 @@ static unsigned short ports[IP_VS_APP_MAX_PORTS] = {21, 0};
 module_param_array(ports, ushort, &ports_count, 0444);
 MODULE_PARM_DESC(ports, "Ports to monitor for FTP control commands");
 
+static bool is_control_port(u16 port)
+{
+	unsigned int i;
+
+	for (i = 0; i < ports_count; i++) {
+		if (ports[i] == port)
+			return true;
+	}
+	return false;
+}
+
 
 static char *ip_vs_ftp_data_ptr(struct sk_buff *skb, struct ip_vs_iphdr *ipvsh)
 {
@@ -319,6 +330,10 @@ static int ip_vs_ftp_out(struct ip_vs_app *app, struct ip_vs_conn *cp,
 		return 1;
 	}
 
+	/* Do not redirect data to control ports */
+	if (!port || is_control_port(ntohs(port)))
+		return 0;
+
 	/* Now update or create a connection entry for it */
 	{
 		struct ip_vs_conn_param p;
@@ -529,6 +544,9 @@ static int ip_vs_ftp_in(struct ip_vs_app *app, struct ip_vs_conn *cp,
 		return 1;
 	}
 
+	if (!port || is_control_port(ntohs(cp->vport) - 1))
+		return 0;
+
 	/* Passive mode off */
 	cp->app_data = (void *) IP_VS_FTP_ACTIVE;
 
-- 
2.43.0

