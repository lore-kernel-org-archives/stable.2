Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311073;
	b=WWU/Fn1EC4xWpjXqQjD4RibVs8FhpYARUEU+8FB9WThlSj04QcSqJjwtvYBMwzosX9xN
	 hHCQAUauU6rVUXf0BKeuEa9jYQOI1gZPrNjQBDl4mhUd6JLiVUP3rB+GrLoIBx4j6l2UD
	 BtObz9UI6LEB8OwqSuHpi19EOWjelYy4WywR8yAQzV7MblJGfkaKGv1q3YfGJmjcURvLx
	 GF9tspiip/doyy7URxKY8L357Q6SFQODgkdyrYowZD78SbBB35fiKI0Qn5HeYcmS6sbeK
	 oUhjenSs2KYbUK6bO5G/SRZxF8a1t/qcvN+boqPtNI43Z+xaFUtQm1GBFiD8iuCcgpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311073;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=O3nBA1bxzj3LOPPYJZ5eVBFFOAyaDsArinkmRytreTA=;
	b=EK99jl+c/w8qpgMNbeSOGNR1yhhKfWpoGlKxu+3yq3oM5Am6nHYH7jDBDcbcwhFQG8/M
	 qNCEAHQzchbL0fzl82RGdiV+U63NK+KMHouAo7HHLLeudnEBCWW5l1BimRSJZ9Dwuqw9r
	 46qVFKvoPu7KRQ2rDB/Kq+qgl2Bnuh5TNfqRbr5WDxZsDX8W0tQhw3potDXCSVt7cFiOf
	 7OSCC4xMt+XvZE3cIxSgQ/1M+vGEYY79Ty0nE3OEt/sesSstxCDx+UC4sy9+/ev9AUzQZ
	 w/NAbauK333JZ+hseTKqW/c8rZmmNSrAW14xVRVEfL/Hibryimpw4tSQzAicj5Q3YXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WgkAOQdo;
	arc=none smtp.remote-ip=209.85.160.225
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B0606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B89B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WgkAOQdo
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-53fdd2fb171so113931cf.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311072; x=1793915872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3nBA1bxzj3LOPPYJZ5eVBFFOAyaDsArinkmRytreTA=;
        b=pTCah9ROnh7nNdYGVGv8R6WOX0MVAKnH6Ro15uWBA/w3hCWNxsTcy5/osur/4Ku5dC
         C0j5Ksu7Oi7HaK2wBXM+Q26DUKsJ3z/lmtu+FBlKPJCorgv3I2QzcszsThsbdWUJXeQR
         m2bCuXzXdkdhi85zSUdyRo8BNsiqakCNiyz/VAhDWrGCo1HL6AQKhEpVbRA/wnOSgmNP
         zOnudxLoSokwgclhnG3aENwh5HGPS0Up6bDQ6MAGVAfKDIUPfrnI5YDa3x9n1Zc12xfg
         yj9oGWEZbWFfCyHNrB/seTnwzjb5TStvRG3PwjSNjlxHoLDLyDpXN9Sg6MBeCSUDrRvw
         nJJA==
X-Forwarded-Encrypted: i=1; AKwUvBwxjQhAOMZFMxz6KC6vezRcpbT925vOSpzKpmeqvRS9R7I+50a6owOXHtA7/iP1fNRegrIQuJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3r5ouxOyMaPKC4PjnlKfasvZkHNplh4EVg3y/pYZ5Z0ARziYJ
	h/4yPIX6p6QNDTCM51GtGaxHdvCY+iMdSkhOX59nhWlRi7qMg9bBopojYkddIIhdvbGjXX9LGMp
	ljnLU0jJrCpiCSipW/VIsU0cUlUtfLH0K3ua20Hi5E1wX0mNoc9x2i0DbqeDFEC8UV8EN+p7L2r
	uCiHU92IyZEJG1EKAu4motxT3iwEin6pBE91F9DLSxQ7QIj/+YgJ89lnAi6wOWKrYdHJynF/gnq
	pD8La07
X-Gm-Gg: AYBFou0UyGUS3t+5IYQgCd2daFSyRnwZUPaY+IKBLUd4ZgTRJqZZYhW8UpRZGndoOkS
	OcBhvXgbaOi5jxXsX/EcXKrkA+3lxtSq1l90voQYfdVI+4oeE+wdC7F8BGlMyWoir3A92M1a0tM
	LDQchD3x65qnSuMS0TIQXs/O4+4gHnHl0gD/KXpSDKaGvI1QJrDApLzOVshiXMnvl8OAXhaGXww
	T7vZf8q1iXsb0Tvlnp/mhe55I2RpsJRh++KOr6MVa7rhGZKYs9Fv70fyLcLTykEwQz2+8bMnxwF
	cNS68NqmV7j/u7jxj+ZiJzzK5003H0gPkwruguoK7trnIghQG0/Zzu9cJzfPLvL7C8TSSFRErWh
	yfo34lMga4zsMn/Vfhc/rpRoZqiXNkgsSvySkCXc4a/OO4GBh+/pjuTbf67hJUaK8pkcEfdb8rE
	d3eYOGUTVHVOU+3sjHj6NKcs2Uk7dbq+eN
X-Received: by 2002:ac8:5d8c:0:b0:535:23ee:eb7f with SMTP id d75a77b69052e-542b3d6fdf5mr7261951cf.1.1793311071582;
        Thu, 29 Oct 2026 14:57:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-542a841509esm27211cf.52.2026.10.29.14.57.51
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:57:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1ac19c6bc71so63117c88.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793311070; x=1793915870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3nBA1bxzj3LOPPYJZ5eVBFFOAyaDsArinkmRytreTA=;
        b=WgkAOQdoxiSUkbvOPGSxYKwczjRAD1+xBNkywrmM2ZkSlS30XA8bYCWUL39vcZICE0
         00dxT830TLwZvTRwiBwHLVzbqwH19cEME4JwLnraOIqIMYUHqe2jNJFhfZacglxu1Dqr
         0Dc7RzT6bvz4YTZTe1DY0xQrihgmfpLTpxiUY=
X-Forwarded-Encrypted: i=1; AKwUvByO/vBj9KWQgQYmcfH2idfByAdxrYaGqkpEdwm258w6oR7aQfd2KQm56Qm1av9x5Rt2aqX1+EE=@vger.kernel.org
X-Received: by 2002:a05:7022:3a8c:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-1ac4fa14bc6mr610212c88.0.1793311070345;
        Thu, 29 Oct 2026 14:57:50 -0700 (PDT)
X-Received: by 2002:a05:7022:3a8c:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-1ac4fa14bc6mr610153c88.0.1793311069368;
        Thu, 29 Oct 2026 14:57:49 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a136537sm1341988c88.18.2026.10.29.14.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:57:48 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/vmwgfx: bound MKSSTAT lengths before rounding to pages
Date: Thu, 29 Oct 2026 17:57:38 -0400
Message-ID: <20261029215738.3010276-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029215738.3010276-1-zack.rusin@broadcom.com>
References: <20261029215738.3010276-1-zack.rusin@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

vmw_mksstat_add_ioctl rounds the user-supplied 64bit lengths to page
counts before comparing them with the descriptors page arrays. PFN_UP
can wrap for lengths near U64_MAX. On 32bit kernels, storing a large page
count in size_t can also truncate it to a value that passes the checks.

A render-node client can therefore register a descriptor with lengths
that exceed its pinned page arrays, including nonzero lengths with no
backing pages.

Compare each byte length with its page array's capacity before rounding
or narrowing it. Compute those capacities in 64 bits and calculate the
page counts only after all three lengths have passed validation.

Sashiko reported this while reviewing the i386 hypercall changes.

Fixes: 7a7a933edd6c ("drm/vmwgfx: Introduce VMware mks-guest-stats")
Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin%40broadcom.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 49e04a50c6ed..58da332486bd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -939,9 +939,12 @@ int vmw_mksstat_add_ioctl(struct drm_device *dev, void *data,
 
 	struct vmw_private *const dev_priv = vmw_priv(dev);
 
-	const size_t num_pages_stat = PFN_UP(arg->stat_len);
-	const size_t num_pages_info = PFN_UP(arg->info_len);
-	const size_t num_pages_strs = PFN_UP(arg->strs_len);
+	const u64 max_stat_len = (u64)MKS_GUEST_STAT_INSTANCE_MAX_STAT_PPNS * PAGE_SIZE;
+	const u64 max_info_len = (u64)MKS_GUEST_STAT_INSTANCE_MAX_INFO_PPNS * PAGE_SIZE;
+	const u64 max_strs_len = (u64)MKS_GUEST_STAT_INSTANCE_MAX_STRS_PPNS * PAGE_SIZE;
+	size_t num_pages_stat;
+	size_t num_pages_info;
+	size_t num_pages_strs;
 	long desc_len;
 	long nr_pinned_stat;
 	long nr_pinned_info;
@@ -965,11 +968,15 @@ int vmw_mksstat_add_ioctl(struct drm_device *dev, void *data,
 	if (!arg->description)
 		return -EINVAL;
 
-	if (num_pages_stat > ARRAY_SIZE(pdesc->statPPNs) ||
-		num_pages_info > ARRAY_SIZE(pdesc->infoPPNs) ||
-		num_pages_strs > ARRAY_SIZE(pdesc->strsPPNs))
+	if (arg->stat_len > max_stat_len ||
+	    arg->info_len > max_info_len ||
+	    arg->strs_len > max_strs_len)
 		return -EINVAL;
 
+	num_pages_stat = PFN_UP(arg->stat_len);
+	num_pages_info = PFN_UP(arg->info_len);
+	num_pages_strs = PFN_UP(arg->strs_len);
+
 	/* Find an available slot in the mksGuestStats user array and reserve it */
 	for (slot = 0; slot < ARRAY_SIZE(dev_priv->mksstat_user_pids); ++slot)
 		if (!atomic_cmpxchg(&dev_priv->mksstat_user_pids[slot], 0, MKSSTAT_PID_RESERVED))
-- 
2.53.0

