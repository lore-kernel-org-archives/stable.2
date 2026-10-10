Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213D1A682B
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620123; cv=none; b=ReDc/DAIwdI65sB1N2vicLlIqdY3UWQSuW30hYE1e1A7xvucqLZQ5uJR9CDE+76QJ72pGpWVddNkGgwvKStkFSPRK+86/mONjX11EkGAAGPVC6V2l2dEGASUQOsHa6Qx0cSUBv/tb7Ajx6PQc+wzUdivAKvE494jPzket6UgzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620123; c=relaxed/simple;
	bh=Uf/oosQ/UAQy81xB9H7Rsx1eC7q8VdIACUuGXMPsPNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjvDudyK+7zLy7au70JwxodqVhO/DUEbLTlETZtQN+JvVcrPXaeBg5D3JTaOCdY4t1DuQhqZGv7J+FkK7n4k799uvpYT0o8HS9w0xaapj5f+hxlM3SVMwnATFeJjOnISG9g/ZivBv3d/uSkPBQl/T2DLk6raESaFV46TWe+3uJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfCRkZGK; arc=none smtp.client-ip=74.125.231.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfCRkZGK"
Received: by mail-oo2-f9.google.com with SMTP id 006d021491bc7-6de19ccd89bso43689eaf.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791620121; x=1792224921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/b9AkOusiOjPBsWU4XsABElpJcJY0c8yQLeU8F399Ww=;
        b=IfCRkZGK1vl8aNQnmZ1Tz1GIj6Mqj6rmQZI7dheMnOJDLRDnedgS4oNz3mZiixGmi1
         EGNlqzplQZsloPkDwaWOVYSL7sjHvi0MQKVrQI8/ceBKjkIIP/HZQZBZu0kqgl6tAPJS
         yyfa5+umi0Pfi0PUFEbvKlLrQtEfkljIviODG8Gwm4pwFTQ72SqNeaZIW0VOzZ/1kWym
         tVWb7+z0OQD9pAQICqvD+o91/jpPGFy41eK7W0ImOU4lE7aOyq6iL2KtzyRbgeU+w4UG
         AxmHOwdwvbBMM63KQB71JMpX+3Hkhwc0VV83dO0QTToXAIM2QhrU7oMy+ex6124QCWd3
         VM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791620121; x=1792224921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/b9AkOusiOjPBsWU4XsABElpJcJY0c8yQLeU8F399Ww=;
        b=uMkRfUDu8Xeph1DU8nSie9KPliIWE8qVdvxO2QPMJUWni/ZFsHcEPsX72lBmN5XCj+
         pt2kOxVAvW3d1//3YxV00oCPPSBxfPV599NsJb89HCmVwYvudcES9FFl3O2PHOfEZhbv
         dd5Qornazoe25durU3YhvNSLoqrrLxTz33lfoF9Fdfd9brSIvoWzJE7JFZg1H16PGUpD
         +2TBHdFNk9JkUPZYYEsXx1e3v6Q0ef7n9Tn+VJJcFiLa0YKBw0s4JuqNXk7U411beI61
         dltpWQUlo8RJyHUqo5LHytSjVwGbIcQ4LDtbGnfHR4cCxE6RTV286DVWnYLExBKoKXqy
         SvLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzA3lNxnS1KLG5nZKqAYA7HRanxZHZRHPbj9F+LhcRKuzL45bTa4USEgN51z+OPH2l2GD52n84=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOtDg1zqh25VhD97SYGybmgaB1yc36Sibv2BTiOlfgxwNjf9oq
	4OBnPVV1l4cCzbdio4RGBn+BOtHX2aK3Ofja4NdCeSVnmyiNNMAbn8q5
X-Gm-Gg: AYBFou1o+h/wUZLtXhZG9sYEolaEIhNqYcRYt20EkH2C+XbQyFsip7+7i72dto3ZYO8
	wxB0DxWGnkIxdIAWqdsbBbR0loeG6wqI8kBQtQvu5VhvIZ6eQ4l1y6WbmpXW3zGW1+0U9VSxWxM
	x5ZKxpltSd3LQEXW6kC8o89aoJRGJKx9fHQp8O/GqvmdPDvwDZnsfzSpoEro7XFPCJKhae0pJqy
	K9UaO1zn/oTBNtmiIwp6bDjNSPVNsAEdxSJBceZ5c+W3dW/BmWnsETjyHIrADbWXfQOPgNirVkQ
	7fiPT2xhW5hnnJIjagJ2OsuFSQQTcScXj2kYWcXBz3Z3d+Hs3aUyiUcN5Y8zadSQ1boZIiRSGXh
	paDSbGujLZqr9i/vVfW30VkX1HRBoB0UZ/N0JI372DvsHf1yO4cGph+G+HQ/XuIERsy6ortJIE6
	wQELmcgjS5Tl+BYdy9FsgqDaGf3PCvzuJSTkCyGxgV49ZN0qB+lb3Nn0yWZF/KPGdC9lfrjio3o
	1rfapE34yxSVD5y35zcZXmyOA3vN5L6vKFT
X-Received: by 2002:a05:6820:1ca7:b0:6dd:d08d:7900 with SMTP id 006d021491bc7-6ef0fbb6725mr3230261eaf.54.1791620120710;
        Sat, 10 Oct 2026 01:15:20 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8302f625a10sm4067822a34.0.2026.10.10.01.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:15:19 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] rds: fix transport reference leak on rds_add_bound() failure
Date: Sat, 10 Oct 2026 16:14:46 +0800
Message-ID: <20261010081446.3112217-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rds_bind() takes a module reference on the chosen transport via
rds_trans_get_preferred().  If the subsequent rds_add_bound() fails,
rs->rs_transport is reset to NULL without dropping the reference,
and rds_release_sock() later only calls rds_trans_put() when
rs_transport is non-NULL.

Every failed bind therefore leaks one rds_tcp module reference,
unprivileged and unbounded: a few hundred failed binds (e.g. to
port 1) make "rmmod rds_tcp" permanently impossible.  The reference
was originally balanced because the failed bind left rs_transport
in place for the release path; commit 05733434ee9a ("net/rds: Check
laddr_check before calling it") added the NULL-out without the
matching put.

Drop the reference in the failure branch; rds_trans_put() already
tolerates NULL.  The symmetric SO_RDS_TRANSPORT leak is covered by
the same fix.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 05733434ee9a ("net/rds: Check laddr_check before calling it")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/rds/bind.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rds/bind.c b/net/rds/bind.c
index f800d920d9690..e4667b3128940 100644
--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -264,8 +264,10 @@ int rds_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
 
 	sock_set_flag(sk, SOCK_RCU_FREE);
 	ret = rds_add_bound(rs, binding_addr, &port, scope_id);
-	if (ret)
+	if (ret) {
+		rds_trans_put(rs->rs_transport);
 		rs->rs_transport = NULL;
+	}
 
 out:
 	release_sock(sk);
-- 
2.43.7

