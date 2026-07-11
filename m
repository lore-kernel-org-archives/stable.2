Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961626B2AD
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783609; cv=none; b=Ojr66LBPI6CCcSMDn2PU/LedROrlJ8FQnmT+42aMNGu8Oc/D1AdKBxOOoC7Lh4ecYMgP7Qh3XFYCqffvswgbC+ykFKxqRwPsHqbWSWfKg9ibeZgEdXgcVRp67SVE7+zZ2Iu9Qh54gxtDXo4H9QFbpcPvO+v5y9bY3FO2gGnaaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783609; c=relaxed/simple;
	bh=qu2LqjVG3gwCwIWPHQe2SrI7PA5vY7y+JJc4s9CiPJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWLR651xfJQIWiivVu+HAwFCV6axcxFRQPI6QCfMrFy4WU1yivLPGkg2YJlWeA3HYCsRpT0ykPXNQ8E47xU/e8sc9MwnRW3L3alY5KzvnjmpNSv9I1K/1V96X2BysNoIGVwtIB8lSjW5O9ExS5r/xiQZhbn+IPikRu6ZG0Ab6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgc5ovR3; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgc5ovR3"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e5d6f35c1so151273385a.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783783607; x=1784388407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGvjcggjuRHrVJRozwL5aIcsoUIst8NdaqhwI9EK350=;
        b=Lgc5ovR37HI4QAbBbdYChotZWcBl99mvDQVgjxQw8+KssIf/9bUBBj4hdjh6E61nfr
         yD4AXD4/lZvzFpdFTcSnGxHucPyQ0zct251JRNOyl/dsefg6rIXPcP62mvjlOwbF+4QS
         2IO6KtPto/gqzp5cP26o+EKYfWlBITqVuXsJ+TX5NBAENRLfouZ2cfYIdV2PKsh9bzE6
         eBuMKJrijSa+a5uzjxH+ww/U+FNYCEJ3nc+frVpvCwCzHi1tVhktV4FEQY/wljAOn3rR
         QD66FhcXx8jmbKf8X/OTIPkW5CGWHp6Ob2Q4uYCubkepDcOJ8dAtVlq4aFFNXdzei2W3
         GYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783607; x=1784388407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OGvjcggjuRHrVJRozwL5aIcsoUIst8NdaqhwI9EK350=;
        b=dp59yXDIa6sweRSLU/qHKMLV7Gf2V7n2t29acDySp0bp47hM9NgztML/naIhIWDt7m
         n+w8LSOI4m4blqGLyuRMY2vc60I7Hf9u6VwErhId20j6movYwR104Q8x2Trkd0GIjDiD
         QAwdwbRooP91N6RU/QSjwBArgbRQi4ixmUdADH5osgcXCZ15toYVRx3IbKbh42Rv9SHO
         Lt+VnyOycPG30hzFIhEvvCCU4DCI2Rzk+jnEfcMLNqraST/PxLlbPwfay5RosChNCz1S
         D9Rh3xFHibzpO6adhzdpEW7yxXFeb7kvY9uFc2Ky8B4D0huXe1Zle7iCZCtxqaXQQveH
         VLRw==
X-Forwarded-Encrypted: i=1; AHgh+RqtwiF09bFKQ62gfv1IB3fBpfgDRafXXMepWII4xFS2+ZEFCrSHx9g8IlQ6c98qr3UNVh+CfP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmbcb0J5c/EqAAJaxp1U0w97yPgg6/CqoXYUEu7lK9YDW/rzXz
	g9uycUEYJaV+kfx06Yq3cQ/A/ZRGa4hygyDcVxx+LrnwO+czrLGoK1wgBLukRcZn1gk=
X-Gm-Gg: AfdE7cmbXmGSQF0UX0bch3n/k8pZHXlrnBxAL6c1CQvtbOSOsw5YrETcBTenazKItqX
	auoxKipwC2D52Aq3zYGHZZTEtrI2Pw6XlhmPg69PcyD6bRtokME6B1VqJcOM/tWYf7Id+IGsDpv
	Amx4GrBUrYcPJuXTc5Q9jTnOMOQw3sbgtUvX1syUvKvWtCGjNYU49dpnZVPIifUhin6z8fkgOE+
	TPmw7Qmu4BtfCloc5Y2/vDS4/81WY+FmKSw4bJQj9A7cXcMDXaoOcpzk9mUOvmlBQFfzn1e0i5N
	KRNsbEMMsfHv51cYto2uv+3l/7abwTFqqKNmiZOiCIvSWQnxFbUzEiYoNpJe7rrH8lWKTkuQX7R
	NStgF8Nlwbq9E23PtJc1AbbB1Ip5C2li3o/CUy5InUE+UnhFINiAM/jzUDCw1OS7EQjpw8kZp9t
	s0g+PhMpp26jiMv79ECyiFMVR3IHBPo7bAPyYT7WLZeb40TBmlXD4rUpeHqKj8iqBTzpMQN/1Ef
	0aRxrQPbQ==
X-Received: by 2002:a05:620a:2245:10b0:92e:51fc:3f1a with SMTP id af79cd13be357-92ef2c844demr268665485a.67.1783783606862;
        Sat, 11 Jul 2026 08:26:46 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm468641285a.9.2026.07.11.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:26:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Cc: Mihai Brodschi <m.brodschi@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs/ntfs3: reject an oversized resident attribute on the inline iomap path
Date: Sat, 11 Jul 2026 11:26:30 -0400
Message-ID: <20260711152630.2975127-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

attr_data_get_block_locked() maps a resident attribute as a one-page
IOMAP_INLINE extent: it allocates a single page, copies the resident
value into it with memcpy(), and hands that page to ntfs_iomap_begin()
as the inline data.  The copy length is the on-disk resident value
length (res.data_size), and mi_enum_attr() only bounds that length
against the MFT record size.  A corrupted volume with MFT records larger
than a page can therefore present a resident $DATA whose length exceeds
PAGE_SIZE, and the memcpy() then writes past the single destination page.

Impact: reading or writing a resident file on a mounted crafted NTFS
volume whose MFT records are larger than a page overflows the one-page
inline buffer in attr_data_get_block_locked() with attacker-controlled
bytes.

Reject such an attribute in attr_data_get_block_locked(), before the
page is allocated and the copy is made.

Fixes: 099ef9ab9203 ("fs/ntfs3: implement iomap-based file operations")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Changes since v1:
- Reworded the code comment and changelog.  The oversized resident length
  overflows the single alloc_page() page that attr_data_get_block_locked()
  copies the resident value into; v1 described the older
  iomap_write_end_inline() BUG_ON(!iomap_inline_data_valid()), which was
  removed in 7.2-rc1.  Thanks to Mihai Brodschi for catching the stale
  reference.  The fix itself is unchanged.

The unbounded resident length dates to the iomap conversion; only the
manifestation changed when the inline buffer became a single alloc_page():
  - 7.2-rc: the memcpy() into the one-page buffer overflows the page
    (out-of-bounds write, below).
  - 7.0..7.1: the buffer was kmemdup()ed at the real size and the oversized
    length instead tripped BUG_ON(!iomap_inline_data_valid()) in
    iomap_write_end_inline() (a denial of service).
The same data_size > PAGE_SIZE check prevents both, so it is the correct fix
across the stable range.

Reproduced under QEMU + KASAN on 7.2-rc2.  A resident $DATA value length
above PAGE_SIZE, as a volume with MFT records larger than a page presents,
was supplied while the alloc_page() + memcpy() path ran unchanged; the stock
kernel faults with a KASAN out-of-bounds write in
attr_data_get_block_locked():

  BUG: KASAN: out-of-bounds in attr_data_get_block_locked
  Write of size <data_size> by task ...
   __asan_memcpy
   attr_data_get_block_locked
   attr_data_get_block
   ntfs_iomap_begin
   iomap_iter
   iomap_file_buffered_write

With the patch the same access returns -EINVAL and does not fault.  An
in-bounds resident file (control) and a non-resident file are unaffected on
both the stock and patched kernels.
 fs/ntfs3/attrib.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index c621a4c582f9e..2f73714a2db97 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1034,6 +1034,21 @@ int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
 
 	if (!attr_b->non_res) {
 		u32 data_size = le32_to_cpu(attr_b->res.data_size);
+
+		/*
+		 * A resident attribute is copied into a single page below
+		 * (alloc_page() + memcpy()) and mapped as a one-page
+		 * IOMAP_INLINE extent by ntfs_iomap_begin().  mi_enum_attr()
+		 * only bounds the resident value length against the MFT record
+		 * size, so a corrupted volume whose records are larger than a
+		 * page can report data_size > PAGE_SIZE; copying that many bytes
+		 * would overflow the single destination page.  Reject it.
+		 */
+		if (data_size > PAGE_SIZE) {
+			err = -EINVAL;
+			goto out;
+		}
+
 		*lcn = RESIDENT_LCN;
 		*len = data_size;
 		if (res && data_size) {
-- 
2.53.0

