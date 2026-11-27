Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755262;
	b=HvJsRwFpaIuS66N6RBYhAAc1r+jdLG5w1vxeNa+kW+Wllqg8xIPazBi3xBnAOOna0udi
	 /4Z6A6MhubnjJLVB2jvEaQwxkEg92NSJGCQ4Si2lsvQhJySIACxp+HxJqmYKy3GKpOqDO
	 CyOYE8ThYPITyn1+ePvst/R2wkudGFzPgOvWklbBPNGfJsUu2u5xuRyWks1z9Pcy0uHGZ
	 PrRKMk8nkqQN05Jy8ihjwOhy4QfnluAoVDLdzuImGBRx8pIfGnfwmi03iyxweOzQjVZxT
	 env2gpGfaWYhnO23SGxoHoO89mrBKD0Bi9uH37nLkUz7NMFRx9XaTqg8tT6ngEa4cvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c/EVTji7z+Y6dwV+EMqdngXVJQdjsAkTv2omyfIXmss=;
	b=tOvPFh863TPoRr1QkPLvc+uzasdzyH4iLHp27TYkqfWw2+HQ6V/hEiVKCuhGaPbg4LPP
	 SlrRfnGnXdJC5gL4C3+VNoChh/IzTu2U9zX/bocW/3z0dlZ0CI4Y+fzjIA26MIlAJfme/
	 uIvBuBJ6hgknZtW8UlTB5J6WdwbXMMbt/IXG3n7tMvGaFH2LZ77HigeQB+0ltg/lGlwto
	 JbPm4AAIpU1vCOYFP0maqXLlL6yGaOvvGy/k08S+W4V297++eDShzkFn5462oRQrPm1mH
	 UAyk4r0qk5zm5+TBtCnSTPxF1UNEmMPSE98eM1rlkqVJeQSwTZsnsCGuN988XgFV+kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIWKpkz8;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449CE606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 449CE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIWKpkz8
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a3c08d6928so11456895c88.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755261; x=1796360061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/EVTji7z+Y6dwV+EMqdngXVJQdjsAkTv2omyfIXmss=;
        b=VIWKpkz8JIPN/o3czMhuX5bNtXUftrBXZmDOgRv0WjQfzIlo/jEAWx332iNS6dfq8B
         g/5KPZiYthfNm1YbPv4csx5NepIlP1OLYhNHV4O3ID6/YTO+RKiaf5H5STw6lJ0GN5ef
         O5jxX8NBYMcInu/YVehQVyjka3x0F/VhYD4VVQisHbNbebIo1wWa7eweq2wnzjzD50EZ
         HOAAQAr+6nuaQWhSy5JYkWaiUqHlFsqfravVWHToTsQ1/t/9GAvWnL6HQVwgKFfwgAVY
         UHuAH8Umvs+zW4lB6x3ucFzEDnyar2tlGYDEmtmuPNTU5HFbrDS/y5uxyVb/RWlJTbpy
         yhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755261; x=1796360061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/EVTji7z+Y6dwV+EMqdngXVJQdjsAkTv2omyfIXmss=;
        b=y9Fp8zTAJOwl8oK7mIwmd3Wg4hbIt2eZL/TjxNFFKEbw2a33kPNhg9jbmCdfS8c+zt
         IhvZOm41GxY5Jm4iNmzXIp7yC/baUwTE45nGGU/oorY9ZiA3KI5mV+2YE6OtzLj8Uwoc
         1rW5kp6CQjbNeWboiZ3CvwPjbxoRaIchjq7rB7G9ShHm0GunGxqzVKQI+gmUBJt+1tke
         CgHPvZ5LgZ3ybrcGkiUOnpAB5l3lbujYH7JaYvmJtWmh+fjJsfftkc6tPXaAjdDB8e5q
         mZq6uAIkO1m2n2ytCFM+DvhFZdSPPrUbk2Fw9PsquHcI8JMSx3LlKtp2G2pXPk/fqJP0
         wwXw==
X-Forwarded-Encrypted: i=1; AL+hErHCZME+w4CHdv9ZKSrPB3tTLHZpeRSuWnLk3gP3puvu82z3VwIZ1RhvVuuHt3m/w1PLm9kBbxE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8C8AVvwG7vZnErhKffVWJbJkPiaJEeHfyZVh090UT3cLfDWqwT
	YUO1WFg9qs94m7z/A1gPImGEg/c5ZickbhFrxiY8cgROwwnj6hyBtAxbeeuQcy1MbsM=
X-Gm-Gg: AZFdTZd516QNCHV3AjivypjEIZvSnC89iafu2NNYtysxmJ9qUj/XNtviYlh3drd6HOZ
	HjqZbWBO0RiKebkcJPacgFpAGd0JitReyZAh5AWTMfVq3IgkqLVAGtlptGg1OVdKaih6KHjFgsS
	URthjIXsA3nuIQ1iAfXq7BGl8WU9hhskCTbIMoibR8zIdRhuaBy5sINPystiv55D2mB3QmDZNYb
	JvjjG+gCtBOXqcIzcNx5E/km1dzbxh67THEyzGkNUJTesogWs7ndNWatdI922j3jSnfvzyGyZoi
	0KsJlnU3rT3ld3ebkRVVUMW3sxfvHnRMmkBfiemrkWJRoeYX2y3+vgaLv+l8vT79eg11Nx+mY8k
	U6Do41dWdCDq1x9dB0YWahuxz3ZGHxUqOj5C7lAchWJaggYQDfAHrweoq84a+p1IuGKc082cbHj
	H5j7KKUny/fhlRyiS+yu/DqJ4LdJh3IP11Tr1imY13PJ0ZtdSJYPPFPABrqOhskHJQFj9Q9BxCU
	ON7zLbpTQ20rl/IBeuqiex7LZ4xZadAWUu8aMHBfBXv3Uunhsbk6S864ld+y4lFDzJqa6ivJ+HH
	tA2IZclRTpK16TSvDlNjPqAYHudZYyjX+df9+ihvfnrAtKRNFL+Ux7rrgPmMoZbskVlb/9QQc0i
	hg3oUcAV0H9AM3ymXYQdS4jUBBbQ=
X-Received: by 2002:a05:701a:cc91:20b0:1b5:7148:95b5 with SMTP id a92af1059eb24-1b571489632mr13900604c88.8.1795755261242;
        Thu, 26 Nov 2026 20:54:21 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:c4b4:d9b:2291:1e49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm80383487c88.14.2026.11.26.20.54.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 20:54:20 -0800 (PST)
From: Ozgun Kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	Ozgun Kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v4 0/3] hfs/hfsplus: pass the key buffer size to hfs_bnode_read_key()
Date: Thu, 26 Nov 2026 20:54:13 -0800
Message-ID: <20261127045416.1160-1-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119005943.37851-1-ozgunkultekin@gmail.com>
References: <20261119005943.37851-1-ozgunkultekin@gmail.com>
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

hfs_bnode_read_key() checks the on-disk key length against the size of
the key union, but the buffers from hfs_find_init() are only
max_key_len + 2 bytes each. A crafted extents leaf key overflows them.

Changes in v4, following Viacheslav's review of v3:

- Reordered: the two fixes are now 1/3 (hfsplus) and 2/3 (hfs) with
  Cc: stable, and the cleanup is 3/3 without it, because
  include/linux/hfs_common.h only exists since v6.19. The fixes keep
  the literal 14 that 3/3 replaces. The "next two patches" wording is
  gone.

- The + 2 per buffer (the "+ 4" in total) is not double counting.
  max_key_len in the b-tree header record does not include the key_len
  field. hfs_btree_open() requires HFSPLUS_EXT_KEYLEN - sizeof(u16),
  HFSPLUS_CAT_KEYLEN - sizeof(u16) and HFSPLUS_ATTR_KEYLEN - sizeof(u16)
  (fs/hfsplus/btree.c:318, 331, 350), where the *_KEYLEN constants are
  the full struct sizes including key_len (hfs_common.h:363, 382, 627),
  and hfsplus_init_header_node() writes HFSPLUS_ATTR_KEYLEN -
  sizeof(u16) (fs/hfsplus/xattr.c:88). hfs_bnode_read_key() copies the
  on-disk length + 2 (fs/hfsplus/bnode.c:83, 85). So for the extents
  tree max_key_len is 10 and a valid key is 12 bytes. Without the + 2
  every full-size key would be rejected. hfs is the same with a u8
  length: HFS_MAX_EXT_KEYLEN and HFS_MAX_CAT_KEYLEN are
  sizeof(...) - sizeof(u8) (hfs_common.h:390-391, checked at
  fs/hfs/btree.c:251, 258). The comment on HFSPLUS_KEY_LEN_SIZE and
  HFS_KEY_LEN_MAX_SIZE now says this.

- key_buf_size is renamed to key_capacity.

- struct hfs_find_data: key_capacity now comes after bnode, where it
  pairs with record. pahole (x86_64, both drivers) shows 56 bytes before
  and after the series, with no hole; the 4 bytes of tail padding are
  used. The hfsplus headings are the ones you proposed ("set by
  hfs_find_init()", "filled by find", "filled by findrec, reset by
  hfs_find_result_init()"), and there are no per-field comments inside
  the struct. hfs keeps its struct without comments.

- hfs: the changed prototype in btree.h keeps extern like its
  neighbours.

- 3/3: HFS_BNODE_DESC_SIZE is used for sizes and the new
  HFS_BNODE_FIRST_REC_OFF for the offset of record 0. It also converts
  node_desc_size in hfsplus hfs_bnode_split(), the desc_size locals in
  hfsplus_fs.h, and sizeof(struct hfs_bnode_desc) in bnode.c, btree.c
  and hfsplus/xattr.c. hfs_btree_inc_height() gets a local cnid_off,
  and the 4 becomes sizeof(cnid). Long lines break after "=", and the
  conditions next to the changed lines are aligned.

Tested on mainline 9437ee8b6cf6 (7.4-rc4+) with KASAN in QEMU:
- hfsplus crafted images: without the series KASAN reports a
  double-free in hfsplus_find_exit() and the kernel oopses; with it they
  are refused with "Invalid key length: 516" and there is no KASAN
  report.
- hfsplus image made by mkfs.hfsplus: create, rename, delete, fill,
  xattrs, appends and remount work, and fsck.hfsplus reports it clean.
- hfs image made by hformat: 400 creates, 200 deletes, fragmented
  appends and remount work with no KASAN report, and hfsutils reads the
  result.

checkpatch --strict reports no errors. Each patch builds on its own
with W=1. 1/3 and 2/3 also apply to 6.12.y and 6.6.y, except for one
context conflict in hfs_find_init() (older hfs_dbg() format, no
hfs_find_result_init()); the fixed-up backports build with W=1.

v3: https://lore.kernel.org/all/20261119005943.37851-1-ozgunkultekin@gmail.com/
v2: https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.com/
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

Ozgun Kultekin (3):
  hfsplus: pass the key buffer size to hfs_bnode_read_key()
  hfs: pass the key buffer size to hfs_bnode_read_key()
  hfs/hfsplus: name the node descriptor size and the first record offset

 fs/hfs/bfind.c             |  5 ++--
 fs/hfs/bnode.c             |  9 +++---
 fs/hfs/brec.c              | 47 +++++++++++++++++++------------
 fs/hfs/btree.c             |  9 +++---
 fs/hfs/btree.h             | 15 +++++++++-
 fs/hfsplus/bfind.c         |  5 ++--
 fs/hfsplus/bnode.c         |  9 +++---
 fs/hfsplus/brec.c          | 57 +++++++++++++++++++++++---------------
 fs/hfsplus/btree.c         |  9 +++---
 fs/hfsplus/hfsplus_fs.h    | 29 +++++++++++++------
 fs/hfsplus/xattr.c         |  6 ++--
 include/linux/hfs_common.h |  6 ++++
 12 files changed, 133 insertions(+), 73 deletions(-)


base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
-- 
2.39.5

