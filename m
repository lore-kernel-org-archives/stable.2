Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D7347532
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818257; cv=none; b=Q3JA9NH89CbxYlMyNrAxzBqRRvLdzFgXrXcCLa6scTHxPRtPCUN4OdBFISkCAAouZUv5C/YSeRimjQxDOePFp9h/6QbE4LivjNevPAiZcliZ+di9pqx9PrhCTaUdm5nomY/XQMVhMZTDa5jhK1cASwlQ0meK4n9nU6VZqacI/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818257; c=relaxed/simple;
	bh=Vr4sD5gaVvIrwjNSmCbSMSDcqujXYvfNHZksLnesr9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qZus8Vut6CWihJoCwMz7Da5+o9tiuIbKqtT+WBE7eGNrid7cHrEvAB3SXB9bB79a7N2obMLZAKkNzZrHwykm2eN2j1ePdorlqgXnYk9NAeodomx3qBaDVwqFpNi58cv0Ql6VSs+aqCo0BsFiT5an8PVFP/QCTHtbhMHIulit5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdw33/h4; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdw33/h4"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f0b25dso38373465ad.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790818250; x=1791423050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbkEHAOXrrNr8qInc/nHsawXJy66lW4VufrCb59C0JM=;
        b=rdw33/h4BDcrqtX9ICm+N4cWJB3VGNDElYPg5IK8u7qC7ba1m4XBgU8jHgtyjJkaO8
         9Yq7QSLAplfdq+N8QCLP7QQISQ7wjDCcTR21CXYx7NeoXFEsTdCJeJllX3F0JndT2BNp
         5Kw3x32NjQDFbyphl0AhtF47lobZ2faV7NqbV20NlrZlsvVfJ18q6DeFtF2wEHqNK7z8
         XjWLk3n0W7HYcOHfraCOGX8x3/pYWcl5JD/CKCzt4byZp/dLrro2WIt2mQM84fV4Kq6s
         VkIUhRG5cgC8zCznBdtykw+X0y8lnq8Obx8ocdVqIAxYG7lIMVE8hbpHxXi9OVvtq6AN
         DbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790818250; x=1791423050;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mbkEHAOXrrNr8qInc/nHsawXJy66lW4VufrCb59C0JM=;
        b=HGl7lBq6DSFkNAL2tk5yC3tTaYmbLByQfF869LCdzM763hcN0QBQjX/fQqhhPndnUf
         EpUvZlWeUSCRbXKnLG6qTERAQV4OlJ+9/+uJt5+3a0k+kAGYpU60SHlGf4Ar7eCFO27s
         UdYfFXf4cmK6OYtANDEEeNPmLqnbiq+fKh/HyrqJkeRLSqzXNc4mrQIOTA1ofNCUhDqk
         G/g/IJjR5yxlA0xGF/rXl/QLy86bcjxDwp8YebzZgLmxXMAD6JazQOHBNKS6cOLWCtbS
         FYtqnHyPRkYL5JFtW+jXyPEex790qyxFdvZFBz1r53/eaP378Y+O4Bi+F4QEO21bDbmN
         LjGA==
X-Forwarded-Encrypted: i=1; AKwUvBy7qHVeSK+HEEdfK6nI/17qEkuAABV/CULreW+mX918GnghJP1IoA5X2m7yvTKu3bxIJtJSrns=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPW5vvcC1hV3Bk+g+ymu70Mv7yWb9Z3Avv2NlQKhbIT87RFryd
	j7f9PG9krY98/SPCm+sCl/AYn1j1Q4tWawFfr455Tp6XNydyaCKqh5fldeyoxBww
X-Gm-Gg: AYBFou1paC/WG7tRbUNKNQRsOsquNOM3JZWxLqDFP9jMq7MRUZjBdPR3y3uO8o0WmVy
	iO12oAe0oXkJh4VNdij6stw1gVFUxv/a4s2OJUSkyanc5+g0pziBAPLlVCMjGAXMZ/JgfrHqhSl
	5R5SdHKcsYebU8fLfk5aUhD+l7pcvugSTKNMcDHMKq8oHj79K3MzNxWCibpXb2z/1d4xMtON3cx
	iAhlE/rNIe8tegPfJpf8CbKmFq2l6HF5gcRkLo1K1ECGppKtE1aAYwurLTj+iMjcdNBVNCttskw
	OrMrODOTKvtHPcSpU/qQlF6c4VjMNPQat9aopTYE06B0jjnjur3Wh64nvyx/fvC+E/EZ8dEg4xC
	uuqjS2pxoe+UBRvdtPzxV+7c1wM3uazE/wnsPCtzPYlVo8ajEoi/yEnx9TgzjN7WZqxhr1dF5NM
	EOHNLn1NvgZMXH248+Hunb0oNuAzbP5VIruSEmkBjDOlSlIsDV2pgGnamfemqUjzgeodxO/CUb8
	TkY
X-Received: by 2002:a17:903:32c3:b0:2dd:c100:312e with SMTP id d9443c01a7336-2e2e4b6bff1mr23186575ad.42.1790818250210;
        Wed, 30 Sep 2026 18:30:50 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b8ff4bsm3607775ad.81.2026.09.30.18.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 18:30:49 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	Alexandro Calo <alexandro.calo@nozominetworks.com>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: only require compressed size on first extent
Date: Thu,  1 Oct 2026 10:30:31 +0900
Message-ID: <20261001-port-ntfs-only-requi-v1-1-b6504122a1a5@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=Vr4sD5gaVvIrwjNSmCbSMSDcqujXYvfNHZksLnesr9w=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqvbeL8oqgf496tPWERamFesVXH9RX3wgd0mKKk
 ej+QP9wEkaJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCar23iwAKCRA08jD6945I
 0/i0EACBNenvAr2jBOskdaN6DfbPGTzeZW2ZMHWcCouYuJlNUIKegfQWE6VTsghHNpw9xC2yYnN
 OF/HvXoEHg8mOO5FQdFkfnE8QeVeKyrnT8CP/mcp9+nRWfklJrpsnTjQdtW3xF6HSfunDDogdDW
 ljNkP4op1/5qB6UzDMwlchx+Qqkyu9kwYI2je6Gc5T9zGZubgP5y6wBl3+t9pQdqplj+YLbmrEw
 dEa8yxd34j0ul1z3AMFcM42bqT6afRYJBz5z2mvP9jHEKqtOUFjgQW7U92gmjkgKwWeQFWEaUGA
 /zzIoOXg/OSNuqhf+h4L9Jt1u7JAxyuNIW7NgMQNtN5ZQHvJt9hWShTp90/Y4QXKgtgndyLH+Gw
 8G+bxZdIYws+e+7s8QXW8gTfsVPOIJ/0QXFGtclpreBI58s67wNmw6T5srYpf8eKrn1DsixlfNh
 X/PYtCZJR/5gnQZzDc6w1a2uM3/32mRikDrgqkXDudezC/EXfGUgf2aaJURju/iU198wndthR8s
 rGBdRv0dS8P79THnOOQk+edtelknQrBRbXc0DFJptEGeNjIObFcR8cYIND8qzNCwzD98r2//rK9
 ps2ssGc7D2Y2lgSONSid2Bo5ZFvFCBSjqjqlLbrpqdqYVVD3QQ6RRLP/4sIr6rNRFTqUxsKB/Pd bE0mpRJqMOR52BQ==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

The attribute validator required the compressed_size field for
every sparse or compressed extent. Continuation extents omit that field,
so their valid mapping_pairs_offset of 64 was rejected and compressed
reads failed.

Fixes: ffc755828de1 ("ntfs: Fix min_len for compressed/sparse attributes in ntfs_non_resident_attr_value_is_valid()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/attrib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 333b3371acb4..6114368ae1b5 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -700,8 +700,12 @@ static bool ntfs_non_resident_attr_value_is_valid(const struct attr_record *a)
 	min_len = offsetof(struct attr_record, data.non_resident.initialized_size) +
 		  sizeof(a->data.non_resident.initialized_size);
 
-	/* Sparse and compressed attributes have the extra compressed_size field */
-	if (a->flags & (ATTR_IS_SPARSE | ATTR_COMPRESSION_MASK))
+	/*
+	 * Only the first extent of sparse and compressed attributes has the
+	 * extra compressed_size field.
+	 */
+	if ((a->flags & (ATTR_IS_SPARSE | ATTR_COMPRESSION_MASK)) &&
+	    !a->data.non_resident.lowest_vcn)
 		min_len += sizeof(a->data.non_resident.compressed_size);
 
 	if (attr_len < min_len)

---
base-commit: 259abb551e2944998cad4214c201954ab1ac5c8d
change-id: 20261001-port-ntfs-only-requi-a2d6f88542ad

Best regards,
-- 
Thanks,
Hyunchul

