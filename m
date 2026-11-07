Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079725;
	b=wZw4w73Z7beZcM9aqo7zhD6E9k0/Gi8lieiCxaFwz0loa/OoKCcJB7KyWGUUbn/pmROt
	 ASsFshUBnAx0KsMvHT/XDpr9rt4I9cq48yOKAC9dtvu+WKXZon/de2Ndiviz3BAOsc5tT
	 gucbNJq5IGFxLutvxMtepCPp+SuiNqxm24jM9gdOFb6L2iDj5xq9dd5wC94WMN4ZeZugx
	 /ZkRVQS8oUR7QhZTeeA0WYfCSVdMcMCA4BEODoEEfcLe5hZ+gvXpwdqyUN2ioUaP3oYB6
	 nDuTqwjsX8ckOJGyyEEcl79M8zaAS0BdnjVkj6phpeVzxjOt/4wgnrpIvDg+nYXOj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w90szJpdzekfEVNOhw/amrduU9AsVHLVBfjyoWv/t+A=;
	b=LWjle3JhQb3urgH2bWtBGE2SyHxyrogAQrtoaIAH9PUkpBRVf6DJVoW56Fz3Rt0gYUvG
	 NgQFJ4OeZ7f0yDPXlUOX/N/de5nZQmoZWso0IxzFzf4dPi7IJi9pqqZhXLGQSE6wQ68fl
	 awYviJqS62ilHDzK38PYfpdXPuOke4jajUvnFpSHlIrCiMctOIy4cHKYZQjL+9tIeJ8Cv
	 /95LTRH/Ab/2tmooqQX75Plga2lGVlLo/FuIVgkwL3oIjiV7cYHBlGm8kSRKLYIrao7BJ
	 4reboYUYG3n9M7lpZtXES/krl9Ww7qbILo86KKMBGsLMf0p7Muz5xVVlHRKE/Jm9ZOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RGr0hTsv;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE80606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFE80606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RGr0hTsv
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37000e7234bso22623eec.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794079724; x=1794684524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w90szJpdzekfEVNOhw/amrduU9AsVHLVBfjyoWv/t+A=;
        b=RGr0hTsvyDG9kcYi8oObA5cl5JlsF0oZFUgGMVMyW8SLmtQ+h3JpPrwQSS6D++cvR9
         gxcXj7JBZbHOaEGrZR85aG5xKyZH645cimD0jAa53sNhV7jREcwQqyuMSesdSatcYJGl
         AhdLbRTc7u8WhkGQVklb8nnBxcyYt4ARztUYWEikdVYbbYuZu4QMxVwYSeACdwo/mWjz
         6CxVV5iz6AzfZc7ilsiNQPhd4MkdP+5szujUtQ3OoC47FTWmgivZLyqreQN+oPFwSaZk
         tLBkd2vlNoYbwEGXAsHOfT1IOz6WgsnDfhmhdz/7EsskpmeqeEriFXHjU6PSwjiYBabF
         BKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794079724; x=1794684524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w90szJpdzekfEVNOhw/amrduU9AsVHLVBfjyoWv/t+A=;
        b=h8v2+VPNmgBoAhrH2mUClu4I7CQT9F8+a6pD5PdvdR/PVBlUzcCZ7bpg3gtGJNd4tJ
         KKjU8DrxsI9P7dpM5lQNb1RTlMLurj+V7Vi2cCy2p/1kyYelhYW6UetfzLH+BxPBPmU3
         NLe7eONbzWle9daEPMin5Oir/364LFw9mAgWlmtYbBDgbdoFBSvWH8W+6AP5pbQdWpxy
         VXwLW265GhQbUrMoy1TWQAhqE3xrvBu9DnQw2o5o5MHc5EgY1Os5TbzeCslA75DvMxgG
         katb0JMNApibD8RPnzWo4wuqZrx83DLFXkEGN5XrcoGDePOliCUqcBhmLetD7lEp+Vjd
         h4LQ==
X-Forwarded-Encrypted: i=1; AL+hErEgW8Uws2QVOxEhssIsFYnKmVxbj/hzo96OzTED/7fC6VX6+8FEbqnWI5ol05Wd+WXC8Sr/2WE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kWq41N2VpwOnaUY90n++YrQS+8Khg41hQd82DQ39TlCptZhR+
	c6yFpVmgJe+o+hXF0jJfEVe9I4uE141PlRqMXoA2sQPq8PQgw002FUhd
X-Gm-Gg: AYBFou2oZbm0vGxRhFTh0Ovxr/nvvtINtt5/sHVr3G6GcGltnCv+lbJYsiZKWE2T7L2
	4oC5zZCnToKowPmhOfFOGNp+4ut8x1hZbuiDLLxoezzLO1qo5DghNjGq2wON4YuK73yeDhjGGSB
	HJcObV+m16BDFPEJo1Nq0+N5yhaHjp4wWyJDNBRzZDJVr0E/Ddth62L5+vucNDf600Igad8miPw
	IPOGEoY9Mk86qycRKheJwRtKJaRff1wWzDYZKOYKS/zRKmWYpRR2Qk+jKJJ0QnkjJmN2QIN5xC4
	bvVFC63LycE/2VJ3aj/lkh0mkXp3VBv7U5W9rqNlv4DW0sidG+8NFYuDWuYn9iwIxZ9+5leZdqi
	T4hnmKxjIfVrzrdkrg/lD7EkcR1xP56cxYMZ+nF+6VYZbH+/APF8uy12lTperagsqhmR+NhBHtF
	eRCtmLHlytDCboB89axnmMDS6TcCQwHtBtGkyl/PLsEf7hhZsCpYJ6R1DENAMGEITUiFJCsXFS7
	cLIWufCma/n/ChnhJ0R6fgQNXjXQOtoZ9q2Gx30waH0o/Go9Tgfxjd11dnFz+bujibLaY7XGKhM
	xcbgLJ3vBfuro5IXUlwyT2UCrvmFGIgCIDeEdGFkxQFcyV1T1frdk+xcIoz7fMCKTUwSy+Hruc0
	6B8rQ6u5NHPI=
X-Received: by 2002:a05:7300:f498:b0:369:fe4c:b48f with SMTP id 5a478bee46e88-3724ff5b718mr132577eec.0.1794079723626;
        Sat, 07 Nov 2026 11:28:43 -0800 (PST)
Received: from anon-laptop ([103.187.196.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fc92fasm23026419eec.19.2026.11.07.11.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:28:43 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ntfs: open a named $DATA stream by name when making room in a record
Date: Sun,  8 Nov 2026 00:58:36 +0530
Message-ID: <20261107192836.3908453-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
References: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
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

When an attribute has to grow and the mft record is full,
ntfs_resident_attr_resize() walks the other resident attributes and
converts them to non-resident ones. For $DATA it always opens the
unnamed data inode of the base inode, even if the attribute found is a
named stream:

  tvi = ntfs_iget(sb, base_ni->mft_no);
  ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);

value_len is the length of the stream, so it does not match the
attribute that ntfs_attr_make_non_resident() looks up for the unnamed
inode, and the WARN_ON() on entry fires:

  WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
   ntfs_resident_attr_resize
   ntfs_attr_expand_locked
   ntfs_expand_for_write
   ntfs_file_write_iter
   vfs_write

With debug output the values were attr_size 13 (unnamed $DATA) and
data_size 550 (named stream) for the same mft record.

It does not need a damaged volume. A file with an alternate data stream
whose record has no room left is enough. The fuzzer found it through a
single changed byte in a file name of an image from mkntfs, which made
a write grow a resident attribute in such a record.

Use ntfs_attr_iget() with the name of the attribute for a named $DATA
stream, as is already done for the other attribute types in this loop,
and keep ntfs_iget() for the unnamed one.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
v3: open a named $DATA stream with ntfs_attr_iget(), as suggested, instead
    of skipping it (v2). Same change as v1 of this patch.

 fs/ntfs/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index ce7c1b524180..c92d1b06afc3 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -4933,7 +4933,7 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		if (a->type == AT_DATA && !value_len)
 			continue;
 
-		if (a->type == AT_DATA)
+		if (a->type == AT_DATA && !a->name_length)
 			tvi = ntfs_iget(sb, base_ni->mft_no);
 		else
 			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type,
-- 
2.56.0

