Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601879;
	b=DsqdoUShUc/czrQP9LUbPIW75d4aXCR/CuYMst9Wike1tj80/XqZRfHAOATikYf8I6qX
	 v7Zr3spVOsfCnf3LHLriDk1mu83hllAgkhhPetsJmcpbhSWtmnP1dueECBmXK/MHXpok/
	 Avi4VpmclBwuqmumM+6VeirC0iyoB/jmvve9wgwrNs5Op/hs1xKspK1dSjV+mbrsEquND
	 tWAtdpkqYB/LaP5ii7++OSOm1EdRNUT01AgpRnGURz2qCCX6suCTiLo3CRK4Ewib/dMZZ
	 J2YysMoopE/xeoU21D7nr9aeJTKIuyLCZBfFC90MSs9nlLJkLUvYvAuKBvF+F9+OXZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JBahlw0BSTFIK+2BYvIp2lv3jJCouVM8oLSKaKh5Bf0=;
	b=p8xSdF67qs/jvCsMHICAvfEZ9ov4vlKV2FOwk0wWOqI9PDlB3JFTbnjBpMTtJpSChbNQ
	 DtIvdHMXlh7wccurcED2ZUjWAckdvgINGWl7xp9njshDsKuKdUc7hmDRmeY3yNxHR/RNA
	 rEvf0AQ4Lj8j8cunBr0Nzp++YZPJlf2cZqD2vFPrbiBCjBIP3eucMvnrtcJpnOa8+O3jn
	 nvRDcxaB2QdgjSxLul8iTCvfuPoX/fnPmoq4o9lcyfc4YIrfAeSVY7CLRhcuPByidsvVp
	 kbPl+AM78daMDAzYceDYVviX6y1XUpOIAAQj6FZDB4rReIC2ErL/bIJnoG8cO7t7l4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQZY3bed;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA14606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 06:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA14606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQZY3bed
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f22a8515eso260516985a.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 22:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793601878; x=1794206678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JBahlw0BSTFIK+2BYvIp2lv3jJCouVM8oLSKaKh5Bf0=;
        b=jQZY3bedA75h5mL9U4lJCKKP1OWkkjax5oaslpe0icrr7xNWD+mT9VPSDNloxGrivs
         CoSj0zZDZHESTYv0dGlNcRkq+VcC0fmjMjUou9DGIVy0c+hahq1xN/uCr9esUs9FMpbD
         txHYgHneSfSn8BL9uFovhc4iAklrhyJsyeHxcQNQ0gLx2q2z5sn6cJ7o0aLE9eVBnQPf
         g2Aa2bzjwIJH5NSZqkM8K5a999TqigiSILmvNv2fPrrXy5tJkfcJWFVNmgi/67XpR3Rg
         2OhY6zU+gGfWHpkeycAPv2U12ZpJpFSt0VYJgb5b3MXLGRD9fC/20zgnE5fU8z91wXsC
         c0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793601878; x=1794206678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBahlw0BSTFIK+2BYvIp2lv3jJCouVM8oLSKaKh5Bf0=;
        b=pQQHk1hXjVHjEVVPauI2P7rBSheXQSuV+0cUXt+eB0gWmdEONp5TC9vAaNu91yPsLL
         rwPx6d3oPtUJ1x0H7FGh1tiZratdi97rI6ZNPXlnSNwJyUjQBKnS2+HmMNmx88bMGxdn
         mbfo7ej+di7vQgLVfN+zQ6oBebwAZAe5EhD2BI3FjBAiV7z80DhCl0yIQvArYLlWhn1L
         3lxARv4NqYV94m8N37nvjhAPD7ErgVabEqcU9lGcS6UEPqrw6cdTdXDUvkZitGgNCLSf
         ytyBA5J/UQL4OItEd4pVsNGCe64p86nrNjPvvX2zdNmbbBS+aZIazKNGPAbyLU0le4ef
         mWcw==
X-Forwarded-Encrypted: i=1; AKwUvBwgoBrLTiAvMexQjykUPgBADofasVAZrOFN+Di6AVI5zGtrHJiU9W74dm5SsWEWK5YO1zz1DFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVO4au92lqVaOcYNFtC/lqhf7E2Ge+Tq66mFn1JKHUox54Vc/B
	MdDb7d7YOmgnUiL3tzOHdsjDwOLTHnGDjN2/KwczfzoGRRcmIm361z8opbm/roG9
X-Gm-Gg: AYBFou3srqED35ROWYdURpl/NJ1RI7gjRzJZIe4JBBwDYc46neIdQCpCk8QPCAMQznZ
	89z6M0EgEMu4OUlki2FDSHR7kzCSOXsLHReHNt6qx/cpP3w6OEr/Dux0CKHxBIYg+73auxryNek
	V/u9fCfNeGeN7r/NSqe6MsQJw7Kt6fzmHsSoMKPShwiZwLCWD/ej8GmNVi+WdznV1z0fwOHZUMa
	tmxH/9ZnMbsY0bs6DmxhuVeAGmY78S90wmmVyJSzC8UZhZNyQ/sv7sRnReT50wwXlT3lCmB19Fo
	hbdPL94bZydmBz9JSbNDBmiAD8soJXpOvVDKX3ATSdz/a4xXU2CQ8hSfHf8BbXSbUXmJW29pPmV
	R5iHoMFOvyuaTk4Cba+hWWdBBKWcOlEms6XSbWF4DL3jRyOesSWjSx7N84vaO+JVh42VOiWbDL0
	IG/q6hAcgyRbZ4ugAI8l/yH+gjrQeVkd6npeQZfM5hY35eSs99KR8vwfVjNn22+O8Q2BuU0NaRV
	bggDWZK51oHNTkH1nqVZdZF8/VxnqfslDRxWNmRzVJgBcAbijLo/fgfhtA1L4MJfEpvYFJLS7nA
	MvU9k0aoVGAPcMsNK6dC7iWRKubUabzSGmDp86UjJwcbdHrqltyVJiRSBZ+MdU1hgRIpQOaLF+E
	AYh9DnUV+ItSiYlhNY5HrYS3voyW9UIht1yOVG1BX686XWHp/nijlgg==
X-Received: by 2002:a05:620a:2686:b0:93f:5f83:2cbb with SMTP id af79cd13be357-94421581847mr1475900885a.7.1793601878603;
        Sun, 01 Nov 2026 22:44:38 -0800 (PST)
Received: from ip-172-31-15-253.ec2.internal (ec2-32-195-47-40.compute-1.amazonaws.com. [32.195.47.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2a9sm765276585a.13.2026.11.01.22.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:44:38 -0800 (PST)
From: Deep Shah <deepshah146@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deep Shah <deepshah146@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/siw: Fix use-after-free in siw_mem_id2obj()
Date: Mon,  2 Nov 2026 06:44:37 +0000
Message-ID: <20261102064437.23976-1-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
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

siw_mem_id2obj() finds a siw_mem with xa_load() under rcu_read_lock()
and then takes a reference with kref_get_unless_zero(). This is only
safe if the object stays allocated until RCU readers are done with it.
siw_free_mem() frees it with kfree() as soon as the last reference is
dropped, so a lookup that races with the final put reads freed memory.

This happens when an MR is deregistered while an incoming RDMA WRITE
looks up its STag:

  BUG: KASAN: slab-use-after-free in siw_mem_id2obj+0xe5/0x310
  Read of size 4 at addr ff110001042aed88 by task repro-rcu2/90
  Call Trace:
   <IRQ>
   siw_mem_id2obj+0xe5/0x310
   siw_proc_write+0x282/0x430
   siw_tcp_rx_data+0x12e/0xbf0
   __tcp_read_sock+0x12c/0x440
   siw_qp_llp_data_ready+0x147/0x260
  Allocated by task 89:
   siw_mr_add_mem+0xb2/0x2a0
   siw_reg_user_mr+0x19f/0x380
   ib_uverbs_reg_mr+0x2a7/0x4c0
  Freed by task 89:
   kfree+0x301/0x530
   siw_dereg_mr+0x31/0x50
   ib_dereg_mr_user+0xb9/0x200

Free siw_mem with kfree_rcu(). A lookup that loses the race then sees
a zero refcount and fails. The umem or PBL is still released at the
last put, since a failed lookup never touches it.

Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
Cc: stable@vger.kernel.org
Signed-off-by: Deep Shah <deepshah146@gmail.com>
---
 drivers/infiniband/sw/siw/siw.h     | 1 +
 drivers/infiniband/sw/siw/siw_mem.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index dbc998248b1e..4ec9c2ac75e7 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -157,6 +157,7 @@ struct siw_mem {
 		void *mem_obj;
 	};
 	struct ib_pd *pd;
+	struct rcu_head rcu;
 };
 
 struct siw_mr {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 2a08817d3cce..be70dc9c8f81 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -115,7 +115,7 @@ void siw_free_mem(struct kref *ref)
 		else
 			kfree(mem->pbl);
 	}
-	kfree(mem);
+	kfree_rcu(mem, rcu);
 }
 
 /*
