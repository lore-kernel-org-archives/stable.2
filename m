Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3937880B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973070; cv=none; b=dcVistHgw9YyQmI0bUlhHHLY0aTDDh/sX4USc+kG1br7sheKFY0VLmx5N3hLihBMrsdXU1ZvGw9LQYp8hMcGOtuPW3dpPPTRf5KmiZHZUtepo6aXpztz8TaDiCCMDLNz2eli0m8C5FpICX8HjVdysG/UIAVaBzYSy8OBR6sHoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973070; c=relaxed/simple;
	bh=ak9dADGghcuChCCYufRRo9PZpvy+34D/rUyr1Vb60so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FT51LpIzyTTt/cU6yyfr4pV7RbGX8DHxaebBwbXa20ry4GGs0W7W0mZm/JjiNte87kNf4ta0N7DMiznWzzIzLeFQv3E01ZSwavYRWdSg5OVSgcalTg1Dej0L341txwhuk1R01WRDJfu3x6+9yXbIHgeyuCIKqQ/FWnlA8xgqbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCVEUmfv; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCVEUmfv"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso21408875ad.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789973069; x=1790577869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftIvz1rLTkqHy1BTg2ZR+qbQLDLbs1QKXbJpaRGt6bI=;
        b=lCVEUmfvvQj8UJLPx0NGO25Px9HijsTHmX1tlzg73/AKI3xDMYmj325EHE1Ghz253H
         BRP2fj1CifLELmLPcpYLIvzBoMJVVtIDWvNYT1emgraeEmQKsbxnhWWQA6tlDrqUmatT
         6hDE2+7ECiTPKIkFKzbFVj7KRTzE0GOFVUgiyNT62CCz1AAe34nfsga7wU+m7Tv6ljIA
         JF+CjZzPRJJ9iXvGlIjCWjKVcUJDS5j9KoGeHavfeEfj2uW7JU37N/tW3L1V2gz5XcAq
         zgn/rykzu6VpLjZnvzujcVwKHtZGe6RFB+FI6Vs0wq6LQnOuRmYSchWbiz88lNOW6eYF
         D+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789973069; x=1790577869;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftIvz1rLTkqHy1BTg2ZR+qbQLDLbs1QKXbJpaRGt6bI=;
        b=iZ7/Qz1lVfaTPW+MRetsAc1QJXOs4uk562kzgHEUVUDsqp1qC+sahIixKPXBiAwrAU
         3nprY89SPl1y34caDfP/YYrcjEjT1pYS5I3jwfaTFOrO2dEbBz4vI+FQJOg+ztn/Ww1E
         1MHcESGl85DWs0H/FArHPQLVDvZQjVrkpUUemPOwG2BWrffeX1ZO3sL4UyTPglXH0rB+
         ee1rOYGr3b/YPMv+aczuZV7DI9S75PNSboujhlUJXW+G7N5RWTC4IgnUSPNB/gitMnM7
         p6kHPDNm0YBpsPiUBwm3v95b3fd8/c5ExcGXzKJZUWAtK/hoZZkVGSjYoA3TdE5B40TA
         py1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwJ354NntYMw0skEY94CLDa8QPdIdlDSk70Bs3VWAR6PVjLhFrrf4JTlnNqo6GZvGrovOvPjxo=@vger.kernel.org
X-Gm-Message-State: AFuF++mh34FZrWBjqzlT7kzO5lKSc5eZRw3KZQbKBnPGFyhSSeSnCVej
	J01+kc/3xLb6cDsVQrgF3KVLq0lPitIt8PefGYDYAyRPyjvdppGCjJglzuTQhg==
X-Gm-Gg: AYBFou1BfjANcMAERushDd7k8kHlsGvnKlszTl31DdIAWZkplKsx3zbZ1xziGz/h5+J
	NeaPBtR+wSRX5g5XKTlvacdkYsseaJH+gq9ep9aN1yJWjyeVyLXLIWu6AVipoyM5V4Nc3wiZIn0
	Tew80dzrKgDWjM2ySrrLwm5Eir/cgJ20aYQJQZE1Uc4doQCC0ygc/suZPcndrhrsy49GRRMzOp0
	dRVA+uYlxRi2mHib8yCowbnQIEI3eN/+i5YH/K+xiEVQWzPbYb47L39b9RYTZGBIuSZn8I2lCcf
	nvP/amIxz5KK60LuPssNe5oCBCKJtiENp3zqL3wwZG8DKR7668/5ylmBAyTv6QGMl6+F9iLK+7V
	aod8fEv0Bx/DaNM3nlatQGYXf73oWO1dkZZLD5tAgiDDwsMmQx00Ph0uk9+n+b766mB1YaQylFz
	kDd0qbEhRTjrxhVZbwYwph4T6SCorPz3JmqfVBWkMlCUogEW09/c+zRc0VRC49405hA7vThdFYq
	ToN1+NhTDlxDHb1
X-Received: by 2002:a17:903:2349:b0:2dd:c100:a5de with SMTP id d9443c01a7336-2ddc100a706mr84160885ad.50.1789973068541;
        Sun, 20 Sep 2026 23:44:28 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc180395fsm28097345ad.81.2026.09.20.23.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:44:27 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v6 01/10] ntfs: read MFT writeback bounds under size_lock
Date: Mon, 21 Sep 2026 15:44:03 +0900
Message-ID: <20260921-topic-4kn-lkml-v6-1-75069f590b22@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921-topic-4kn-lkml-v6-0-75069f590b22@gmail.com>
References: <20260921-topic-4kn-lkml-v6-0-75069f590b22@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=ak9dADGghcuChCCYufRRo9PZpvy+34D/rUyr1Vb60so=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqsNIJUmoLpBlqtKv1k2NIgUVFkKJBO3us1Vrrl
 RTPQjCKIjeJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCarDSCQAKCRA08jD6945I
 0zW+D/9bgPD6T+PALPcZetD8brPfhyCnH11bQTcJJR9vlmuFNeOE+lXZEJ0369u/AirM835KglR
 dp6FyAew0XPzoU8SJyerypzS/SiMled6+sS0LknBRr9TxjAbcAJufbVnl61L7oMNDS/G+j2xcTm
 s++I12DNMGjXGe3qYWTXGKlV7TOBgB+N+hMynrKhpZp1ML4So/eXIqJUEugY2AXQVBs7W1id74U
 dbx0L7iqfGihi68rqzK4FcO/TS4o+AIDNwl07ytXN75zxT5tfgonWhlIKB+YUs94AVCd9bI5gSG
 oNvcPMvvimZA7qU742k09BNSJU3WTmVefQWFyR1AIt3R7e4g6HIYAvms1rFc8BUKWRwJoNHIZ7x
 03CnuQ77wT63yEPzgnQnQE1PczXvYhcxtaCjA9bQo89dBTnwFuDJ3g0amS9/wAhcp64WTB8MwIS
 7pNkwr4LEeoCQdJ0uv2H3rHAd9ABdwRoe5qocDWagDHuZTqPfIhR9xJcM79SFq8JzHGmkRltcyv
 6WAOodrouaLZOU0Gu3Ec/L+OauVw01II2Me0qxAN+14hxYzYlsLeWzQl9H1a5XqbOSzzuOWyEjw
 8JwqO4YNBNk5d23WdtvAvAQtKJxFOqjrWSVRBQxtbR99jYswS3kSsFvF7GUFFlu6eRQhUjHH70W 4/59BVQvQbFwcYA==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Read the MFT inode size and allocated size under the size_lock critical
section before deriving the folio writeback limits. This prevents
writeback from combining an old allocation boundary with a concurrently
updated file size while the MFT is extended.

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/mft.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 4b7449495375..c9ea11198aa6 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2901,9 +2901,17 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 	struct ntfs_inode *tni;
 	s64 lcn;
 	s64 vcn = ntfs_pidx_to_cluster(vol, folio->index);
-	s64 end_vcn = ntfs_bytes_to_cluster(vol, ni->allocated_size);
+	s64 end_vcn;
 	unsigned int folio_sz;
-	loff_t i_size = i_size_read(vi);
+	loff_t i_size;
+	s64 allocated_size;
+	unsigned long flags;
+
+	read_lock_irqsave(&ni->size_lock, flags);
+	i_size = i_size_read(vi);
+	allocated_size = ni->allocated_size;
+	read_unlock_irqrestore(&ni->size_lock, flags);
+	end_vcn = ntfs_bytes_to_cluster(vol, allocated_size);
 
 	ntfs_debug("Entering for inode 0x%llx, attribute type 0x%x, folio index 0x%lx.",
 			ni->mft_no, ni->type, folio->index);

-- 
2.43.0

