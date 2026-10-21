Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573007;
	b=bsDJs+hgFrDzn4dnAJs4ADsl1CivEhbb19eiCRazQhYliGldDenADvvTSBUUAs4qJ/VO
	 GO5Q+7bU/tbxO4ghJ3g2wXMyW9RFudrJ/kziEjHNqgVCr/zdUW+0xQ0mcVhjF0Fm+kGEX
	 txqAaKgquXCQE9qUX8JInVXoaQqEQ7PtW4j4ew3VBN9n7wz6YsZXpV0MaepA7JzBiIlEl
	 s0tW2y5rFOXfGAgApz6O03SxTQHYLox1mtkInTBex10CILOierkFvy4SZsBlGc+Yg5e9o
	 NVfDEz/m34S4wPDlkcSSwO98hlpzfQuvy6gRyw1SD0dttu4JEPZhvWQhsrdhi+F3TPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EbKXyleNFY9/8wO9jUa8etPnmUJItO82wpWtCoS+TCw=;
	b=WHY3babKRCWcKhCwnM/0mbyBVZlbBKkDM/LdTym63JYFzK0d/DsE1RWiqVlF0Ih2qLnB
	 q4J+FrGUP5pOj7U6Plvaq7dfkq4YPEmZDIzkgXLwofpYdykM3qhEIsTRAzRGijyPrOPwH
	 WJ5nbJGw7QysJ4sQg/BqPEa/Fv+rTPCXarC1NmldJgkCNI6/28CL1Nvt3L2m+8Ggzi2vF
	 4cTVVukT9UDC3S8PBWPoEYKlBWhjUx1AFkO9LHcart8Pz4rwgQmnyGd4tXHw+XwJ106EN
	 GW8gq1zTEdUNmVN7b6eihgriiWyKWAyqywCqLHrgnZfNeeQk3riaeKOY2FV9QgNfPxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvWzPODK;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B0606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvWzPODK
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e98798cbddso2327625ad.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792573006; x=1793177806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EbKXyleNFY9/8wO9jUa8etPnmUJItO82wpWtCoS+TCw=;
        b=fvWzPODKAaR1ZepcYCr4Kqnj8cfIodJG78eH5l7FhHOvNA79KP9MkM8zHh09kywfF1
         iP+u0Bdv4FkQGSHItaZieRNGU0q3Y1ZhcuBLmD6bCWYr4YWkzK0eBEZ1C1y8XVWUjO+P
         fz+oQDwmE9NVKZQoz0R0/nZ3yNf2Jmd2b/MzPO29SpseRLye1/a1ooORC7eKuZJgzJtX
         zvBeAhNlngPrLndmGii9iNklOd167rGKjHSdjFob0H5VxpdZJtsx4K0941wZnXWBnBSL
         CXcfopI7YRtqE23T+wETOfXxU3FLGgt2sqinvPb5CXJ8fZhFWcIhSS1humAN9+Dpd/VP
         qMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792573006; x=1793177806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EbKXyleNFY9/8wO9jUa8etPnmUJItO82wpWtCoS+TCw=;
        b=VKvulwjMtWFetjxrhivY2CInBBxYlVPKfZfKHvUjLqJD5S4KL+RK12AwqenvNTl1tc
         Ng1/kRjtl9ll2A8YUayXP0Moc0mDVIMcS/bLfjLVSok9tSRm3Egcg263uXq45fKMY1rk
         ePDsinVmaZ0wTsvwL6lo1UUWSlZxCANDDavP6vEkHMAA2kjz/qFHjMUiXzP04izmqSfF
         IaJIr9BEYnjpRTTg6FaVYBfM76bT9Fa1teVAf72xy9OA5/pA4IGR/Uppqf9viU/2fmz9
         NxPZulGSHMSvT/Drskj0XwhoCMWzdNwJ9TMjzxyOrFkHhjVZxZVQoVJXTVxroDqybvKy
         OsVQ==
X-Forwarded-Encrypted: i=1; AKwUvByl9XHHepRdq2fsZNbFQV3yIHWPViodsvInmmFG3rnRwmwZmuoFmbjrfJZm9PAugEZ5Z2HZyBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuCo5R7fT81vMmEx4EyjrdtwgGqMIOMYaMBv5y1mF05JV1vZc5
	9XICTjLZHixk3+06js3eKosftP2DUmkW8dt1cro/WBm1vyXiRVZ5MiZd
X-Gm-Gg: AYBFou28KrhJ8yT2gch0sSl7iZsZ22WxyrWvogRCeIMrvSPvn7ekeg2RZK9Dxz4lg84
	TFWh2vWooKD3TmADp6BTqUTO0ILMKv9Hbc+lzUYBJz1iHXAC3GPjaHv0Psd/bn20RsWWlTPQTY6
	6KNT3HVKvrQr7Rq5yBKHmCFl0u6XmrUo9QsbU8BYcX12PhLJR71O+h8wRD+vYOIZa/Sh+Lglgid
	sJWqWPoM1X/OZFX+DdcNC5yfkB30I9lwM02o6Spqr2D/pfRU/ZW+kl7fEUrPFXYpamaBHmDLzAp
	o5fa341m21vLerp1RGDwV5HiH3RzEj7uUmuCf3+Y+KD+BvsX6Z2jEx81GyUn+Viyzxshq7Pdi4S
	oFsPQDs2oQwISQGDxjvdq8d8ugkDiDUujG9AMo9EhMv8zJFhjMp/QcBod1ycXW6PZtPp2oWweau
	b0Z45Vtn2bQDGXKLljJFbe7/g241xsztAs9/+l/um7a5HH7K9AjNQBOjBDV0OuulLeg4oIuXQ2k
	BVidcqs4Sap4P6UlSnG247HO9Mh4IsYw+Zxi7XwzAjbdkZ1ZZiP0QQNJdi2dLSQmpk=
X-Received: by 2002:a17:902:ce01:b0:2e6:1a6c:abcd with SMTP id d9443c01a7336-2ea4391f99dmr10699345ad.3.1792573005536;
        Wed, 21 Oct 2026 01:56:45 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b411067sm8420785ad.23.2026.10.21.01.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:56:44 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: jack@suse.cz,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: libaokun@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com,
	r772577952@gmail.com,
	ritesh.list@gmail.com,
	stable@vger.kernel.org,
	yi.zhang@huawei.com
Subject: [PATCH v2] ext4: clear in-inode xattr space before adding the first xattr
Date: Wed, 21 Oct 2026 16:56:35 +0800
Message-ID: <20261021085635.3633692-1-r772577952@gmail.com>
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

An inode can hold extended attributes in the space that follows its extra
fields, whose size is given by i_extra_isize.  When ext4 loads an inode,
ext4_iget_extra_inode() validates that space only if it starts with the
xattr magic, and only then sets EXT4_STATE_XATTR.  Without the magic, the
space is treated as empty and is not checked.

ext4_xattr_ibody_set() passes the space to ext4_xattr_set_entry() whether
or not EXT4_STATE_XATTR is set.  ext4_xattr_set_entry() walks the entries
there to find min_offs, the lowest value offset.  That offset decides
whether the new value fits and where the value is copied:

	free = min_offs - ((void *)last - s->base) - sizeof(__u32);
	...
	void *val = s->base + min_offs - new_size;

A crafted image can leave non-zero bytes in that space without the magic
where ext4 looks for it, for example by shrinking i_extra_isize.  Those
bytes are parsed as entries, and an entry that claims an in-inode value at
offset 0 sets min_offs to 0.  Because free is a size_t, the subtraction
then wraps around to a huge value, and the free space check passes although
the value does not fit.  The value is copied new_size bytes before the
start of the space, over the inode's own fields and, for a large value, the
memory in front of the inode.

On a kernel without KASAN, the copy corrupts memory: it overwrites the
inode's own fields and, for a large value, also the memory in front of the
inode.  The bytes and their length are decided by the setxattr() caller.
Nothing is freed and reused here, so the use-after-free in the report only
reflects where the write happened to land.

Triggering this issue requires mounting a crafted image, which needs
CAP_SYS_ADMIN or automounting of removable media; after that, any
setxattr() on the file reaches this path.  The issue was found by fuzzing
and has not been seen in production; a reproducer is available in the
linked report.

When EXT4_STATE_XATTR is not set, zero the first 32 bits of the space in
ext4_xattr_ibody_set() before calling ext4_xattr_set_entry().  These are
the bits IS_LAST_ENTRY() reads, so the space is treated as empty and the
walk stops before reading any stale entry.

Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
Closes: https://lore.kernel.org/lkml/CANypQFZzxTAH=4QRRDoqH6VAw1daAq88NDWiQKoM7QTOnP40sg@mail.gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude Code:claude-opus-5-5
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
Changes in v2:
- Zero only the first 32 bits space instead of the whole space.
- Add a comment above the check.
- v1: https://lore.kernel.org/lkml/20260916084723.877552-1-r772577952@gmail.com/

 fs/ext4/xattr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5c310747b965..8e1fd26329d3 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2274,6 +2274,14 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 		if (IS_ERR(ea_inode))
 			return PTR_ERR(ea_inode);
 	}
+
+	/*
+	 * Make sure xattr space is properly initialized so that
+	 * IS_LAST_ENTRY() returns true for its first entry
+	 */
+	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
+		*(__u32 *)s->first = 0;
+
 	error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
 				     false /* is_block */);
 	if (error) {
-- 
2.43.0

