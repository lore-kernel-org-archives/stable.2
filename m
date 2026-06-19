Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D0368D78
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863087; cv=none; b=DW6cH148HihgUtgUHzjupTEeq9bJj8QtS+QSi6zxC1928u2ueGNADZabm8HUZZwg0ULdgA7ImiPuAMVYsL0TirURIvoRp0+0NfVuVt0cwqIDckq4pEjGC2WDN/0Ifb+iRTaNXR/ZmqgKFA7GovDLQmdd+rrs5x7RZBWMSpxt7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863087; c=relaxed/simple;
	bh=hk2+uuYecO2IQQF9bcMQEfm2EUhrTFMxzsBYQSG8ZtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i2HP/yiZJiIe+HAkRL2kXLsBq5mRnKXhnPaa052dS/6Y59UdFlOlPvnxQ4jT3sATAF73jb+pd8L/fn4hD1sAvtKk7RfSo0AdJjXdfrh/Za8O/86KI4pt+iprzTmx5w9FhjmNMy2gLSHzp78zhjOcl9O3kYqlgMvXHhvlZhqtpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bddemX/m; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bddemX/m"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so15979585ad.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863082; x=1782467882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U57pja5e0yJSy8SFBtN6ioJCsbtDVqRKjAnvzO5IXeQ=;
        b=XO/IUI4KPPEWjg6/bZmoZ1QTH7mWSq7AeA8g0BaafsK+/VYVY6DFZ0xgRHhKJ9CCTD
         uf1vOx/ynstdkh+a/bzEE7OMO/xC+XrjwzhSaqeG7MBxzlUv2DVgqY2Fj3KDd2o5BVD5
         rhiw2hucjoGl0aG+RLDIKdksmL8a/M49bS91jp/uPs0EDX8BBPBb0zQgJXHQizebzDaz
         F6G2gPF7u+Nr/8ZbMW8NN34+EuRdXto0lcpwVtzUyygaGjHGKSLpljJ0bQpjefC5yF/1
         umy5J0qFZSZtVwu2WLQZmVKUFIeA03lzHGAk031sFsAXg7CqDss6X+qrTbxX2BV8XF6Y
         gQuA==
X-Gm-Message-State: AOJu0YwXJvJvPiUW3VIFeenNVXwDMI4zwAp42cN1M+/uo+mmxATdJhdl
	2Ni3JiXcjtId3LGhJzIgzKn/BI7iaXFw020xO62nd8U+F0B/zeNPxFPtncz/jt3sAHF6Yysiyl6
	yXpv5puH2o1cgfbHn2n9klSCi3pnlBYJmmnHjUbMwnA6wVmDfGjzQBn7piWYU3cWGXJ8evAbrXM
	CUHxBHNi+KIgz3WErv+YQSgQEewyMrcqAwbaCi4+FkHwGRF0FfUuQPL3Kp/6K6X2tyCUbsGBG+8
	8MDJTuy0qp6EUzDtw==
X-Gm-Gg: AfdE7clZd8hXtXPuQdbJI1mBFRd6OER4nB2Eqomrk0tHCo8FLMs6evSrne14wVPnBaR
	BA21Namws+KXT/ze8IDd02AxxIRCVzqTOm+7bIStfro4M22YUJlHBZLmZcMjNpN5KtsWMOD/YDk
	zCODi2Ies8355NGwuKtP2l/+Xq93BtOG4g9LM8VvRM19ksSt3vtpqZen7NPJtRud/f7ZnDTNL84
	bMXQZ8G7mk0Vyu1nac7pHeNPfwg0Dscae2F6FXOghJZBgrOcOwaEhmyXHLmzA5czOGAwEuS86OU
	eSAIbjFZf/HQ9s+7AsYF9dN7G89Ir2gbZKXGCOzEF6llprMaw43e92ggS8BvWKae8/0tqi+PGtP
	5ZPGX+WQm4IEUFpWGQFsPNF9QV3ew4LEFBW549PGyo7z77JWGfVFS9y0rbBegXp+CknEGUEwuTD
	7JXE42RL0Tvs9ReTFwJAdOcVaPvT3gycaCjg57/dhJVHOGNTEFoA==
X-Received: by 2002:a17:902:f712:b0:2c1:5a24:b4ed with SMTP id d9443c01a7336-2c725dbf5edmr24806625ad.37.1781863082370;
        Fri, 19 Jun 2026 02:58:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c7208981cesm1130785ad.4.2026.06.19.02.58.01
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:58:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bdfcf7c14so7977927eec.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781863081; x=1782467881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U57pja5e0yJSy8SFBtN6ioJCsbtDVqRKjAnvzO5IXeQ=;
        b=bddemX/mueuoTUw+FgpYuMdZmN2YG6KQCleH58432RU1ZqVcX9NspyjesIHnNVo1M8
         zRXNHpWkO513UvHI+jtYcrSIVHzrDP7EUgyTMneZMbULLdHLIFsZEJxrEmBVPoLK8Y8b
         xvYl2rvC6rsyZTlwCwbz3grmvbDenVoc7BqKQ=
X-Received: by 2002:a05:7300:2310:b0:304:705f:e4e8 with SMTP id 5a478bee46e88-30c0d1123b2mr822016eec.32.1781863080768;
        Fri, 19 Jun 2026 02:58:00 -0700 (PDT)
X-Received: by 2002:a05:7300:2310:b0:304:705f:e4e8 with SMTP id 5a478bee46e88-30c0d1123b2mr821973eec.32.1781863079967;
        Fri, 19 Jun 2026 02:57:59 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06d5bec5sm1851910eec.26.2026.06.19.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:57:59 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1 0/3] Fix CVE-2026-23272
Date: Fri, 19 Jun 2026 02:28:47 -0700
Message-Id: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

To fix CVE-2026-23272, commit def602e498a4 is required; however,
it depends on commit d4b7f29eb85c and 8d738c1869f6. Therefore,
both patches have been backported to v6.1.

Florian Westphal (1):
  netfilter: nf_tables: always increment set element count

Pablo Neira Ayuso (2):
  netfilter: nf_tables: fix set size with rbtree backend
  netfilter: nf_tables: unconditionally bump set->nelems before
    insertion

 include/net/netfilter/nf_tables.h |  6 +++
 net/netfilter/nf_tables_api.c     | 72 ++++++++++++++++++++++++++-----
 net/netfilter/nft_set_rbtree.c    | 43 ++++++++++++++++++
 3 files changed, 110 insertions(+), 11 deletions(-)

-- 
2.53.0

