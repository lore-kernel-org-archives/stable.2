Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631713;
	b=fVmnRo3H206S8WpnWgeu9wPdvr+AoIoTv1kIOssY/5z6wsqWVPF9kfe/JrUSg4N2bWa4
	 R75Ljruw8Oy0DW3DO+ia7D19ELw060lUtLBNiK93949STAPjMVx8vZvkakCir85tsljiw
	 1ncG+Tx06SPE62K022g+gzqv6pf+Aitft90JK7OY5shJ4emVkRrLoQoj/69RMWBnmNKXP
	 VAw8+Tu4U4o2b1/FSJJEhkkq5sLcxeexqh9Roha1cLW4NUwtubcGnB9OB0hvo/5bIZu5i
	 bOmz+WaH96Q1ZC56/3vmyjEyiwML66i+L2Eh6nOO8OjoidM3lEmMuBGephdd5vpJ9Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8l44OpvREKctVeUFVW4vf198xHBq2jFaQ6cO5qom3KM=;
	b=QadNMwC2TNeKAXOsprD9spFqg3gVB83vFdaQkgBNe6ldjLMkhzROw1A8dNnUNEwzWD/J
	 WxNNhhWpdvVxy3DkBM69hdz7tNYyYnaw/Xz3taTQbD8sBxXVW4TI2ZImdi2X4AaZDYM6N
	 DPIbtdiUr1sKohfUFZiSRf4UJgaFQC0+KGfpxzY/4smM1ox5xO/DhVPW9OJmWjTg/cZKb
	 f6NDWeFlZpK3B0Byr+zjXrhu4l4s3GxFcgq3lxlqiswIWWG1j68DPatQvVEvzK70u8BER
	 1+xcBggBmDmP2BmLfcRzUAVBMuUSZm1zNvF6ZpKCfQdzWmRHK4i3oMWpPftBEdGjTsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nrOjI/IQ";
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBA60A262F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ABBA60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nrOjI/IQ
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ea19bc317dso29329345ad.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793631712; x=1794236512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8l44OpvREKctVeUFVW4vf198xHBq2jFaQ6cO5qom3KM=;
        b=nrOjI/IQ8vLRDHe1WeG4/2R824pmXUtn3ORubIMGUAv81K4aIF1ybSqn14Yc88zYEO
         kzdxo9I33lORrsimuUAV8Js5ZTDmPmNBpgdeiAzbjjfvgv6Umfx87NRldYWwfIYgPOnW
         eBR/eJzTfFC1Pyuevj10xoTjKy+DLDs7MYk5Zj8B34Vn2MZtWyFLOsnk2P3VnpdxTW7F
         ChAKJxH3MxP3TA897ZAKLOBwCdYMscH85vQyOG6LUwmhKHRwrb2s93oyCge7zqiBwQFc
         /Dw0N5WOr31coa832+VDR0xDGpUv9aCbhXNQoe10iWxMOLG8FPtXYcZPQ5G/P2XHITGy
         w0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631712; x=1794236512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8l44OpvREKctVeUFVW4vf198xHBq2jFaQ6cO5qom3KM=;
        b=IeslkSUklhlhYUcpFqB9mgrWmHk9OUeZSed1j8S9CtszfLbQc0PgSj4d6KYZzgwxDZ
         tabWq1ObUi6P/EXxL2KOkIcZpLSz3Rs5WDPfETxjtjynOVozTRnJQ+8cydP6eY2IwOfm
         MduLyC1f5kHh/QUIlu+99DxSeYoVWjk4cp8Ubq14WJUAh46otp9WbR26ijPO4xK6h7Wb
         /iEen5GZcearejx84zYGGGF8KA7H5sp0BsDzqvlW6/EPFfQ9ktW2CrLN7IKbmyeGyE+6
         3ev+BZFi1dyuTRU54bmc7KPLmGACyt4GyZSgWVedfZfV0GPZAx6qq0IhbDotiLW/oBbs
         0SeA==
X-Forwarded-Encrypted: i=1; AKwUvBxp5K8i0tb86tRL4Lohx0Y+9lVl+fevOAraghBtDhTjpt6PmG/0e+0OLMOZZOA1DMGQhn2B3Lc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TftpUMQ1/GA4kSlTTT8+8/l5lMIFHRKTkUOkG6YsRf74HfurL
	2U+PZzmUZaXBQ7VTmr5TXlBeydX4Pf75mFQH7BLkdA0Hc+XbjHoa5FMx
X-Gm-Gg: AYBFou1JMZNO9APhhcg6uvNl4MYbZBTA9ciVPTGc4Hg9A7Frd3jcxQtDVcMuTIllje1
	H1HhO+lEHl3WYL5ac1ORjRgyY+E5YHCJLaNmszRI+abjO7LjrZGOGjvm7XiKURFcg45mwcgw+ab
	Xuv5/o9/kzvNFbXW7/708kPeU/GVrKVPI21Jie0QSn6+fW3nynOT5n9JY+acjfuxhkIma7YKgV7
	LOa29ayz++WyDTtg3p9pX0xhQxnoLBRBBqQNc6S5PlxR7+UcZUP5+A9EloWTAfQmVTF/dl13bua
	wBWQg0AKVgUvh/Lz+x0pGIWbw+wdJda1/t++8LYmSlDjwWChODY05GBUiYLUiglI/8ZqewYSGTJ
	c7lHmPe5DOIZQYaR6zGRMHfyl9ShJdUvBeNQn59HSPF0sy+G1cq3WEakjAVlWJUFoqu1pn/aSSf
	cPpIyDigbre6r3CYIw4N+w+rhxSslGcKI5XmUhvJhZ4yYIhybBVZBkS3SyucJ4QUjshVtX8I+pO
	ahRXnWYTHVVR71+4VAdwYNNDr43OO87VQoMLwtkBYL62GSnfJGjjDaVGW2jYOLXBg5varASfHI+
	sW9GJiekGMurtqI26S/w1iNtKlSpLWA3ctT1tCbetuisPvwPIaWvmU8ikdgN6wMQPKwFBgSi+Jc
	3zwdW/Oeo3kxQ37ZhuMTgCYoNFqIZF3gLKnk0n7TwOBQ2lX7JWsHt9AK2CtZSMw==
X-Received: by 2002:a17:903:1a0f:b0:2e9:6788:9369 with SMTP id d9443c01a7336-2eb364cbac0mr99822395ad.34.1793631712330;
        Mon, 02 Nov 2026 07:01:52 -0800 (PST)
Received: from localhost (ec2-95-40-37-200.ap-east-1.compute.amazonaws.com. [95.40.37.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052bb1sm31540395ad.1.2026.11.02.07.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:01:51 -0800 (PST)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Viktor Malik <vmalik@redhat.com>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	"Bill O'Donnell" <billodo@sgi.com>,
	David Chinner <david@fromorbit.com>,
	Lachlan McIlroy <lachlan@sgi.com>,
	linux-xfs@vger.kernel.org (open list:XFS FILESYSTEM)
Subject: [PATCH] xfs: fix temporary cursor leak in btree shift corruption paths
Date: Mon,  2 Nov 2026 23:01:41 +0800
Message-Id: <20261102150146.19777-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Jianyun Gao <jianyungao89@gmail.com>

In xfs_btree_lshift and xfs_btree_rshift, when XFS_IS_CORRUPT detects
an invalid firstrec/lastrec result after xfs_btree_dup_cursor has
successfully allocated a temporary cursor, the error path jumps to
error0 which returns without freeing tcur.  This leaks the cursor
memory, the xfs_group reference, and the per-level buffer references
held by the duplicated cursor.  Jump to error1 instead, which calls
xfs_btree_del_cursor(tcur, XFS_BTREE_ERROR) to properly release all
resources.

Cc: stable@vger.kernel.org
Fixes: 9eaead51bed95 ("[XFS] implement generic xfs_btree_rshift")
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 fs/xfs/libxfs/xfs_btree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 7effebe297ea..d706f59b0301 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2567,7 +2567,7 @@ xfs_btree_lshift(
 		if (XFS_IS_CORRUPT(tcur->bc_mp, i != 1)) {
 			xfs_btree_mark_sick(cur);
 			error = -EFSCORRUPTED;
-			goto error0;
+			goto error1;
 		}
 
 		error = xfs_btree_decrement(tcur, level, &i);
@@ -2737,7 +2737,7 @@ xfs_btree_rshift(
 	if (XFS_IS_CORRUPT(tcur->bc_mp, i != 1)) {
 		xfs_btree_mark_sick(cur);
 		error = -EFSCORRUPTED;
-		goto error0;
+		goto error1;
 	}
 
 	error = xfs_btree_increment(tcur, level, &i);
-- 
2.34.1

