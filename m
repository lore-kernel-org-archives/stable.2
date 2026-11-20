Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181772;
	b=hBCrmsD+toAz0s4cr7pzqTDMnFstoMs/eF9g6PdWHhKu09KBWA8B/YJNM/aw3u3LDizN
	 N+DjRvBUwCIQM0W1JdjEINvhlExv6J7h6A6XoutZp3PaDxyocdW6w6U8qWFTubacapXwW
	 QP6hVah+G0rz6OmGP/fqgBaDoCOTx85sU942uLpvk6MVGfQoWBGXSSjrgiFUB8w6mQ8m4
	 eaVi2WEXLiWbRYi5vU+wofCYXxIf3atIs1yHUCPsN/NJ4tf0XWzYhibtGx7sWUM9OMVif
	 aO9oYIQU8eLE3++eKS9UI0f6lTaUeGN2oH59onILBKZX4tWU4XepTcdkoBbs1lKgD2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=buQIV0vkdXGXpQqdQz4ZB0pqcKMsGECCL78uKqu8k0I=;
	b=xH7S7FZ7XUgxzmXRlg1YgLtXAcjpqvnfcc+paS7Ob8Ldv2e8MGoBqEyeKEb+PlbvnNCH
	 s4LU1esTOdA86LkkaUdK55DYrpCtrudxVkbzxLnhZUdfxwFLqZi+7GL8fz7EmIuqNCDoA
	 DJmDCFyFaXNUME+77VbNSDJ5Kc1ZOu20HQaCYGctCl2/lEz73P/Qd2RIc9RRwrXWiPd8q
	 rGM+1OV3qWgJWR40nIX2lVinMWkoIA9QnqYG8qsdaz1w67H9gvewzblHzTpVG0tDU7ydG
	 P8KFgFiU5UfryDOpvFzkDsFqhQ3/TwFMmsj/bKGfL3x08i4yPCqErCXph5UWuNI+FlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NJCf37oa;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E960A2601
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A4E960A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NJCf37oa
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso492130a12.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 05:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795181772; x=1795786572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buQIV0vkdXGXpQqdQz4ZB0pqcKMsGECCL78uKqu8k0I=;
        b=NJCf37oa3Vu2kSYXoj0jctv4LzonJfIcZ3ltwyjlxMqZG+ZogqcYpjIxSV6xKG0See
         RmHewxvqzhC42W1rNkX/84g3bRswwXYT3WyfSsk9Kzikg+Sq/NwbCrWsEgSX3Wr0twMR
         yJmW4GAdhWxqAOicxM4U6eI1Ea90Hmpl/KUja2CmxWAt0NJ9dVyIw3NsatYBk9hlBOhn
         SONi3hpY5+hnG9JRGA8RmyHh7NwP7ZnjHeCfKyTmJVgoJfya2+reuwPjhizzjRFF8A0a
         NN1P1EYlCs6OFmmeFDFrKJOFo0yhb6r26Z5X8eG7DzFDZd0mDVFyhdofLeJ1eUn7HpKu
         yCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181772; x=1795786572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=buQIV0vkdXGXpQqdQz4ZB0pqcKMsGECCL78uKqu8k0I=;
        b=Cn2lTlqnBtTs6wEYzEsox8blaqPwYIeDgDSfvfmvP+3dGfXRhgBfAED63qTrgg7IkF
         ZmBPcAXIWhWLxwOHeUVbtgywh9wL4Xc+cBHj8NIji9VRT6G7vUeM4xQo7V0VqPgIN+jN
         M/Q7myP/ChzDd57teDTof4nariSSO78YgRtdtM6CsJDGOeRciCzbWx+n6ofD/OyXVkmh
         OcPRPsVwzQU8NHYYMiYkB0KUWRezgBXD2TjdfvWLYdwqvp1dmGV91Up3BYzSDXe2GLNJ
         sFWT6n81hAW5Mmx8QfTF3p4tZYiZEvlgwRCksjROpeFNeyxZLgngrEKECbFqd1n/XPpP
         0TVA==
X-Forwarded-Encrypted: i=1; AL+hErGFSnUzfz2ltFjR89vp4vOFdd1b4xLGTuV4O1X7lLmA7UtR5K0gcmrEHVxrfxHU5ByUlV/0YHE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sXN74QYjNG9HSk69D+rajZc5485mshEGOlu+9T+CfnHW+q+K2
	6aCtfH5CR8qCilg4kac3tumEKtUlQf8PZDHC/dvl7fZwBTIkzJLxWvWoSH/QVQ==
X-Gm-Gg: AZFdTZf3G05T5uXGC3TY/gOaltpCLV7wPcSc3QwtTG0J945mHdDiPX9pxVON82VCFLo
	g7umtzgSnwSxS5TMXtM58WfiuUDELdLEKPyp0ccyzX1Y0bfStdgRgQ/BephWX2i3gpHFDzxchPM
	knDP9VfVVhviXUdecT66pVYpZDLFJ1BxQvNhDpALrdgV16tj43aso551S2bMGZ8OVbiFJbwlftA
	6eF6oGCNsrSo1iV3rRBFeZUX1BckswOjMJEW1lL22svbDD4dLP8UFNUgS55bg0rabxItFheG6Ij
	BjEgX39Rg1j5f+eBAGR9Wr/nsCYo5pq7whgS2TBePCdZuhgrprNapvoromKyDpXwXsYPuzx9An8
	bQW45DAxqQxtQEsvgmQcsREhwxbuGQrfRGM61N72OKGuApS7AlQ1nhpkkWEoH4lbGGCobdd+G4q
	VsoQLdypkERQWGfT+8jhLuvVVtPeWV7jKSTahP5WmvitmeT3Q2ZncCb+d50A4vhYlZ1jUVWThX9
	FcPRtoOoyiIlgjywHfHoeCvrXshaPG5fUzkAJiXd8NBL/YHb3g/zpYwRk3ALdqly6ebhaSseaep
	AU6w80WMP0dptTbzxmIrr2kTZImgp9UAWdS8akh1ri5mWLt29Aw5MGfMH8a81Vevx3w=
X-Received: by 2002:a17:90a:e70c:b0:3b3:a9a4:a60e with SMTP id 98e67ed59e1d1-3b41c92643amr2783153a91.25.1795181771890;
        Fri, 20 Nov 2026 05:36:11 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm7557362a91.14.2026.11.20.05.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:36:11 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH 2/2] fs/ntfs3: zero new clusters that a write only partly covers
Date: Fri, 20 Nov 2026 21:36:04 +0800
Message-ID: <20261120133604.427285-2-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120133604.427285-1-zhanxusheng1024@gmail.com>
References: <20261120133604.427285-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

When ntfs_iomap_begin() allocates clusters in a hole, the part of a new
cluster that the request does not write keeps the old disk contents,
and reads below the valid size return it.  The iomap conversion asked
attr_data_get_block() to zero such clusters only for writes through the
page cache, and commit 10d7c95af043 ("fs/ntfs3: add delayed-allocation
(delalloc) support") stopped asking for it at all.  Only the delalloc
path still zeroes them.

On a volume with 64K clusters, write 4K at 0 and at 960K into a sparse
file, then 4K at 512K: 61440 bytes of the file read back old disk
contents, both with O_DIRECT and with a buffered write on a volume
mounted without delalloc.

Zero the new clusters when the request does not cover them.

Fixes: 099ef9ab9203 ("fs/ntfs3: implement iomap-based file operations")
Fixes: 10d7c95af043 ("fs/ntfs3: add delayed-allocation (delalloc) support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
With 4K clusters a page covers a whole cluster, so only 64K clusters
show it in these tests.  With both patches, fsx with mmap on 4K and 64K
cluster volumes and on sparse and compressed files gives the same
results as before.

 fs/ntfs3/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 535a2b0804af..9c2ded9567f7 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -982,6 +982,10 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 */
 	no_da = flags == (IOMAP_DIRECT | IOMAP_WRITE) || srcmap == WB_NO_DA;
 
+	/* The request does not write all of a new cluster: zero it first. */
+	if (rw && ((offset | endbyte) & sbi->cluster_mask))
+		zero = true;
+
 	err = attr_data_get_block(ni, vcn, clen_max, &lcn, &clen,
 				  rw ? &new_clst : NULL, zero, &res, no_da);
 
-- 
2.43.0

