Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD3439A078
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548454; cv=none; b=lV4wW6AYi6NOZAycO0GazjjSIXx9Hi2WZ80Ouwtotr8XVmhCW5H4M1pSBRaRlGV03Bs0hXXsluu1UerbRUWKfNa8gOTBYXtd0yNOxvZrHOqUvlaCiCDm1Qg+PBufU5iLy67N2p/aGcIDQEdXScYccxjQC8n/Nv6VB0wDqDLEhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548454; c=relaxed/simple;
	bh=jJcSGXRLoyAX6cOyjXBA3x0CsP9kGy7jE7wrjeXLFDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEm0r6srjVHRP+vBJEpT3/mJLLq7p089JZ4TfEOwd0CwyfksW2FGRJ27P7QRMoRoVAc04CkkzmqJ9Ni4ydmd8Vbb6VFCYPAZ5YtkcOouYfO4SUcabyesFpexxNl+6CGyqUhpd/UGxSZHvZMPAQeSMkJSp6A32t5Jpz9F1JkbEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ4OytTh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ4OytTh"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so562537a91.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789548452; x=1790153252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nt3TtR6D8MLcyrkfRup1NcE0sH1AfJOXgLL4PDCV9cM=;
        b=YQ4OytThbXe3cc7YtSToK3dg3uHlTZGk2Zc+ZYwTfGWXKPRgQpMZu0foRlE9BbimA1
         irlyDRfEif9HrqWsFKwsbq3q0DGBkUm5nSsH+nvRASvHUlaW0nWpJJ4I+4yMz73aiGDX
         EyaE4kPyEb8noVyGxwGF72kH3eTK5zIGAWXaVumw5odS2WcI3eFFKslwcZpFillN4qG8
         gKwptg2Om9DFrWdxSPMcJvjtvq1RtzSHQly/SpgTp2NnxqPuU4TmNDghQAr3viUEiHI2
         9jJrWB/srFv0oHf+V7hDEfq4ijQxLyCSF45BnHHxoLSoIoykKyR1VabYdXa23VrKQl5e
         nGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789548452; x=1790153252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nt3TtR6D8MLcyrkfRup1NcE0sH1AfJOXgLL4PDCV9cM=;
        b=Xolnkv4kH7cgAjS5TmWbnI9BgpD3hjYzSJE5Wjcv/HbI1eb2SRnRYjkG/B1nZ5leDD
         ve7iHyrA15Hb3bnzMxC6DR4GTWC+tX6tno5miIxwLR8jfDX0aKzYYJMBrxuO59Op49CY
         Q3FEMLZGhREPhdZjx2gAq6lTZ60F3FWewuqg1hVQIG3fxatCsTV0MsMmweK9Uy3VcLuI
         PbQAhGmjaeGumxuaR4PUzirMu2rokX9ftzRFp1ahE6Dvqls4igzF71hNc9Bcd4VJX1Iq
         xM04nMLbuCHa6bRHr4xk7NKqaH4pOIzDNyVZZFComtYhUSnL/pCUN61RiOcQbklbMt8J
         IE0g==
X-Forwarded-Encrypted: i=1; AKwUvBx2y5vUSmDiQIOKEqixuBrfMlmesPjQGp0ijO7+mPbf5JXNmWdb0++b/eN6OcqXng1R0CqE/1E=@vger.kernel.org
X-Gm-Message-State: AFuF++k1JXr4hDmAU44wNaBsMJ/fl+TXIt6/Dz24kj56k6Dl+5GAGFhO
	5eRquDyQlR5dBJMx7ErWcjy939NaxBzhTqcZ3snpFutv0jo2pial9Ki9
X-Gm-Gg: AYBFou3lzhRxQZG7O9nhB7APWWDF3gNdIArxPxr7tByxeC4gU4ntn34wUAJ5G790g+R
	/LAzVtp5n8DsjfDbK/V62+nJxDLdCmDGioZ6GefZQsG+JsANUEDJwqJT6CdAN8TR1xp3eoftl63
	Y2kC7brRhCbjfM62MtoGVl5QzO2WP67DzmY2wr97WWiINkjwaz8ktlgDbU8H2ocsRvaNeQupo3K
	Y7SFTsqVo460kKRnDRHeXrTyQbdEgDci5KjmHOt4DTvyBXP9dNQw9AWRe4wFvLVMeWPuQS4wCSw
	9+BELRpR+Z+d3kVfmjdfsnUtPHJGZUfY33pSx/pJsHleaqkQomQFs63ugom06HN21hfvpAKDdru
	dWgaXZN97LlO8rbhKQnje7bJIniSK22QNNbUaK88i/EZC7Zi8FN8sVnDZ0S7h/WCS2iico/ZQRn
	DuocaXC/1HABU1Xn7r6HLDPwkZxucplQ+6dt/Sk38APxq0iRwQb3Ic48lfQ1OpaZl/H4VBW6Mi5
	ID5+lLGvg==
X-Received: by 2002:a17:90a:1c82:b0:39e:2065:5f60 with SMTP id 98e67ed59e1d1-39e20655f80mr2496696a91.18.1789548452224;
        Wed, 16 Sep 2026 01:47:32 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b6991c4sm3480351a91.6.2026.09.16.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 01:47:31 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: linux-ext4@vger.kernel.org,
	tytso@mit.edu
Cc: r772577952@gmail.com,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	libaokun@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	syzkaller@googlegroups.com,
	yi.zhang@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH] ext4: clear in-inode xattr space before adding the first xattr
Date: Wed, 16 Sep 2026 16:47:23 +0800
Message-ID: <20260916084723.877552-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANypQFZzxTAH=4QRRDoqH6VAw1daAq88NDWiQKoM7QTOnP40sg@mail.gmail.com>
References: <CANypQFZzxTAH=4QRRDoqH6VAw1daAq88NDWiQKoM7QTOnP40sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

Clear the space in ext4_xattr_ibody_set() before calling
ext4_xattr_set_entry() when EXT4_STATE_XATTR is not set, so that the walk
starts from the empty entry list.

Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
Closes: https://lore.kernel.org/lkml/CANypQFZzxTAH=4QRRDoqH6VAw1daAq88NDWiQKoM7QTOnP40sg@mail.gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude Code:claude-opus-5
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/ext4/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5c310747b965..2e5f39b710bd 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2274,6 +2274,10 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 		if (IS_ERR(ea_inode))
 			return PTR_ERR(ea_inode);
 	}
+
+	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
+		memset(s->first, 0, s->end - (void *)s->first);
+
 	error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
 				     false /* is_block */);
 	if (error) {
-- 
2.43.0

