Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6157400DF3
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629687; cv=none; b=T1MUpd9+7ENwn1WKtIoOXilluUUXu88guadTV4Udm10Q+jFks92RHW9NiuSX72twi6kctLpLDFu2s/jkX6yhKj9JIkBrHQsqQ8GP9CAPWt6Ndm0+SyHXG0Uiek/hdoQStDOacPF/izubn8ulnpdNlC4oSdjq8e36xFKcEAioNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629687; c=relaxed/simple;
	bh=Lx4pYf7ox2ftKijZw338RFHnP5fJrmBZaR9iQNhr5fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXQbdUQE4DdULvicCdI7DDKa+2IYUzQqe7fkRUY7QsbMOgCGMYNIp+UGNpxekQUUH4ifq7WsYF0p/tUPtzsQfrjFE3In3eOnZAde547MMTXGuVfSuN2vngNS2Vu5gvvFrPR3OO6bHEcGMKPHTzK6ZEWSfX/DW+LuQjMinECAgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=m2mxfjzZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="m2mxfjzZ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93ece7a73b9so41337285a.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791629684; x=1792234484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q++ROavf5Dntc+2Fvf5HgOibvKYoyzYPl6CilCM+dkk=;
        b=m2mxfjzZix1oEhOzoj2ZW6wmgD/o7IARnsVTgaza9BEdIbkJlDHdOKp2llm1VeL1w9
         5cOBxOU/GXJQyS59F0dnsvFnAVPqUun5GhQFN8BNDR+2xvqkDxkk+mxTPadUvMM1/I1a
         vV5UVqtxe6aR9PKJFaMdwBWdakGebYKkWC4UE+EBNiNLIXzKDCuGlSK4ZtRtyQY5VBvM
         sRUcnTX4ay7aMQgVsaQ0twmv1JWWjZOYREWM8oao4QAM0/bM972lFeFgLlR8I2kJrIZX
         0N42M1k4r66epuESs0wx1a4iJdKfLBcX/az8MfGO6yUzhW+/S4W0DclOAr+iGLhKPsmt
         llug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629684; x=1792234484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q++ROavf5Dntc+2Fvf5HgOibvKYoyzYPl6CilCM+dkk=;
        b=OXh6CXy95h6HE73DldfaNMPT44NPa1Q4GVgR7t5eDF7F5YaQ6clM60aD/z1ayDd1KK
         kg09Qh9+mW9dETLu5OfCwG9Z3OFk9j/wO1+ZHHFjm4v1jP/aS6XaMiy0vQMOrVZNr2lL
         ljbhIHQqKz8J/pwzZbNsWt0zzkXruXxQpb8TTfSjWYMDRzBVIsWjkC+nBeWYaUXdjE9E
         OGxC7GcmDY1AL578GGGwCVkie/7npG36KfgPn9hSolr0nC8LELtjDJLd0dXsDbKWNDAO
         kfzxRHSRxnUSZed0Pj4H5xaicr5nW2OKauI8w/ZWtB7QcAl7l0xTvEaViBhHbSH1/CGC
         HLzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJM1/Vf3JNnKDwyoA99BqcQPe906PU883+fpyzphbodGFF7SPfiTBmQrakAyYdRKX0MpWfwhE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVe+jKNzauPiJu+DdrdIHOWMv+7JDMMvVMt1KiIbrxa3Vb2vVg
	4FgdRZxhcC4RQA9c2TASPz4pPCdN1XiJwCfZrVySicW9rdbhMBTJeuCFOib2N1f2tg==
X-Gm-Gg: AYBFou0BYrPwACIzzGrZreSkZnQ6yuOE+SZPLYq6S+3d+YkOWDADRjHMiGGtVPrxeCc
	l4soRrm5V+OpZKonEzI1i/VpghVjfJ5dPKHQCRAWU13dJb2TPQXlrCdP0Oe+36R6yJt8VaU5EKT
	pIoFXIEy2vQRzmMndN15NOKe2aSXuEeLPLNVsUr4fJj0FSRc/jcvLf1db4ayKrietuD+ovxAxNC
	J3Q9WUa/lCbRujj4eodiCPapsVfcDKZ7xMabx/GuFPMqTH8LJoZeqKLGYEfafg3r18+mNF1ftnR
	d9JPVRHfAFTFnMtqpi8OS5+8JLDW3Vy1m99RM/nCjnCQr3Zz93mdcu5efwOu1JRp4D05ubjJltG
	LQh1zLKkH+GwH8hS2s+GKCj1dl66pGUtz5JV1d+RlHHGUeqFPthzMzLQHftUXHUuio7h5ntnRK9
	AkJ0bCMkHI3SnCsOID05Awvgw1uQXZS9+53e199QLGTNxwRFMr8GttdgHJ3xrXotpwzca24Lw8X
	zclIdmdN+Z1DYD0xwZxsQ==
X-Received: by 2002:a05:620a:17a0:b0:93e:c12c:f13b with SMTP id af79cd13be357-93ec12d085amr605390185a.69.1791629684570;
        Sat, 10 Oct 2026 03:54:44 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9898b5fsm394602785a.32.2026.10.10.03.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:54:44 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: David Sterba <dsterba@suse.com>
Cc: Chris Mason <mason@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: fix chattr failing on nodatasum files that have the compress flag
Date: Sat, 10 Oct 2026 06:54:25 -0400
Message-ID: <20261010105425.165104-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cf1afec09e9f ("btrfs: validate properties before setting them")
made btrfs_set_prop() validate a property before setting it. For the
compression property, the validation fails with -EINVAL when the inode
has NODATASUM.

However, a file created on a filesystem mounted with nodatasum has
NODATASUM and still inherits the compress flag from its directory, and
btrfs_fileattr_set() sets the compression property whenever the new
flags include FS_COMPR_FL. As of now, chattr fails on such a file, even
when it only changes another flag.

The issue can be reproduced with:

    mkfs.btrfs -f /dev/sdb
    mount -o nodatasum /dev/sdb /mnt
    mkdir /mnt/dir
    chattr +c /mnt/dir
    touch /mnt/dir/file
    chattr +A /mnt/dir/file

Before commit cf1afec09e9f ("btrfs: validate properties before setting
them"), the last command succeeds.

After that commit, it fails with EINVAL.

This patch will make btrfs_fileattr_set() set the compression property
only when the inode can be compressed.

Fixes: cf1afec09e9f ("btrfs: validate properties before setting them")
Cc: stable@vger.kernel.org # 7.2+
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 52aab510aea0..347509043f2e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -421,7 +421,12 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	if (comp) {
+	/*
+	 * An inode with NODATASUM can not be compressed but can still have the
+	 * compress flag, inherited from its parent directory. Setting the
+	 * property fails validation for such an inode, so leave it unset.
+	 */
+	if (comp && btrfs_inode_can_compress(inode)) {
 		ret = btrfs_set_prop(trans, inode, "btrfs.compression",
 				     comp, strlen(comp), 0);
 		if (ret)
-- 
2.53.0

