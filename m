Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43E399377
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757822; cv=none; b=rwiUMOq9p/yhkX3IfDGqVRjrEqEZCAxsQg2kgfZTl6QMvd3QbaTq/jqhcCJCaOkYbw+pGsI1hKm1EkYPZcRpErbU11nzoMkQNljLkN8W90Rq4dpnqXloQ/m0af2hAP0YCp3PSCfzrW/QRKdXAV1XTF/FDbbzSWDe4Yk90M42kEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757822; c=relaxed/simple;
	bh=zwCGPMyKbDKXxSkZVP4VChVpWXpG56uAzMmo6kFUA3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0CgMM60VsMUJjg+yMxVMWT71ZXpsP3HZjaV5DeA88Us0Jo+WaD9eW40/YN4fvvmaLNQrs0jxV8lLw5MKybVGdcjcWriIXbU5i2CI4OHG0C9t6fApmKniB/VY8CH+BoufrWFCeULuZqZQWbzcToPRBcV40CjXdFhV33pPOeHhl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6P3WpQp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6P3WpQp"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848643382fcso2805990b3a.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785757821; x=1786362621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nIfphApq7+nERoCSzy1S+2erTAPtHZ7WWaTp4W/ujx4=;
        b=Z6P3WpQpStVQ+YQ6d5NuswG1Eox8mVFnCqEYu5K07167O8w0UOgf9YpobnWwwzmvCJ
         wQci5j50DmTe4efPC/yF3aqW/Ts/vf9UoP/nkkDoKwmXIT8NbHriWNW2S288ZXCsPH+y
         C60Oo8+zC2YFoJ/Bt8aNUNhBTubGI2eR0imxtILbHGBLBnfM1S6bFlS+SFFQOYdLGiGS
         K7sC21zLidR4V5GTJWrUho/y2XEzTMj7VxHVFZRr3k7NgBIL968YR1jxXKWLNcjSwqDj
         vmojIoZU/9tMBjTjTjlvQ+pH6rkwlu/k5umeKNh48k5/Yjn4uHq94U/YW5p0bY+6r2fO
         ZmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785757821; x=1786362621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIfphApq7+nERoCSzy1S+2erTAPtHZ7WWaTp4W/ujx4=;
        b=astc2sPJ2vkFK3t7CThr0CdX3BYXrNhq6zMjwesvCdA/7bkzFmU4B1487g6lCxYNr1
         fxehoJGf90yDF/rjXiYY5tHjoWlOS25q9LZDtALf/epjffBUxxdXeaJC90TtjJLPvlGA
         HCHGH5ILLfCYdzND2I9BhlL/bpib9pYJKxvrYdBI3FLLhJvWQDnIEtTWqcoh5RigXOnW
         GC8ucix1G3v/DuJm3V+pfqaRz5OMkZ1dAcU89HXSTLDFDkF1v4H45PcHxXgbTX21O5cY
         HbzhBNJ3GicHyV530HFwKYmuxu/DoCiHNOR9IphqooMWOszGz7wTxTJ1tbywmUf4jH0R
         o/yw==
X-Forwarded-Encrypted: i=1; AHgh+RqmqBlhiWmzPtaQbDkGCZwlMj/5eDOaBvrluFrmHX/rj3hQrFv41pA/1KH70delvLp/bM/HtZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvE8d7q2s/3GcR58Jdv46kr0htdw+pCN7+NbDQdMSF4/yGt5t
	9Ggg+8jD2BWCSVTCzcZZoB7Er1jcndixhb21/5+m/XRq+Z+3MZ5Sdvvt
X-Gm-Gg: AR+sD11sWb7LkWtHjrgeb8w1Jg27ghgPItrghXqyMQinOwI6a8g4BQOkNXReWDFeiY1
	b+vLliePAvd5gA1c1Nebw6gG/p3D+PyZ4rUKYCNS3YGWUJ8r7tflJQ+Jpp8Ypfot9FLnv06lOhb
	nAsWP4GE3MGOyuGd5IcDb/4ciFdTcfW6QrgGjwj/ggsp4ry3xsTA3pMXuUqGBIKXLmPra7if0oF
	4Q310A61TGsPotHY17k6ut+JFVA2TD/Ia+m0hcHEtLHZljcXjynB9XCIYyXRWwhO+31LYPYv2yK
	YsHkNAJIP3gKY1nHG82r0zBx+eNcptbREHy4md6BMf8RVptLQM96PXWNJRqMnNrdlyIBlXBsN1M
	Cy5Hk5HT/ZN7JX9n9q0hGfONwI5cxet+hV//QqSuaPGhCYLs6HbMc5lHTEjKWnYFUanj+dWrSLO
	hvqdmVrYpB9NZV32+qs3U3K7zl47Tp7/QixH/tEXd9uuSP9kONIfbnyfONZWgy7u/+sLkVoh1sf
	JNLkhfBb857JgEJrltguiqX51B1/pXH
X-Received: by 2002:a05:6a21:62c4:b0:3c0:9c1a:893c with SMTP id adf61e73a8af0-3c92a96158fmr10167840637.68.1785757820442;
        Mon, 03 Aug 2026 04:50:20 -0700 (PDT)
Received: from JIAPENGLIN-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ebb342sm3515761a12.30.2026.08.03.04.50.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 04:50:19 -0700 (PDT)
From: Lin Jiapeng <ljp1205831794@gmail.com>
X-Google-Original-From: Lin Jiapeng <jiapenglin@tencent.com>
To: hch@infradead.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jiapenglin@tencent.com,
	corvus@tencent.com
Subject: [PATCH] freevxfs: clamp i_size of immed inodes to the immediate area
Date: Mon,  3 Aug 2026 19:49:58 +0800
Message-ID: <20260803115015.25745-1-jiapenglin@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For immed inodes (VXFS_ORG_IMMED) all file data is stored directly in
the VXFS_NIMMED (96) byte immediate area of the inode itself, so the
on-disk vdi_size of such an inode can never legitimately exceed that.
dip2vip_cpy(), however, copies vdi_size into inode->i_size without
checking it against the organisation type.

vxfs_immed_read_folio() uses folio_pos(folio) as an offset into the
96-byte vi_immed[] array and copies a whole page from there into the
page cache.  With an i_size larger than VXFS_NIMMED, reading an immed
regular file -- or iterating an immed directory, which walks pages up
to i_size -- drives the copy past the end of the vxfs_inode_info
object, so unintended kernel memory is read and returned as file
contents.

The immed symlink path already guards against this by terminating the
link target within the immediate area (nd_terminate_link()); regular
files and directories have no equivalent check.

Clamp vii_size to VXFS_NIMMED for immed inodes when the on-disk inode
is read in, mirroring the existing symlink-side handling and keeping
vxfs_immed_read_folio() from ever indexing past the immediate area.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
 fs/freevxfs/vxfs_inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index 21fc94b9820..f0589b6c834 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -107,6 +107,14 @@ static inline void dip2vip_cpy(struct vxfs_sb_info *sbi,
 	i_gid_write(inode, (gid_t)vip->vii_gid);
 
 	set_nlink(inode, vip->vii_nlink);
+
+	/*
+	 * For immed inodes all data lives in the VXFS_NIMMED-byte
+	 * immediate area of the inode itself, so a larger on-disk size
+	 * is bogus and must not be trusted.
+	 */
+	if (VXFS_ISIMMED(vip) && vip->vii_size > VXFS_NIMMED)
+		vip->vii_size = VXFS_NIMMED;
 	inode->i_size = vip->vii_size;
 
 	inode_set_atime(inode, vip->vii_atime, 0);
-- 
2.50.1 (Apple Git-155)

