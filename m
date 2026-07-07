Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45F35B645
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450861; cv=none; b=NjiDBWj5SLCkqm9nQlOaJK63qpDawxLHBZIQQgyt6pf/K0gCQA2myW9XL4II06oEZS1ZVPi+pVnLt9lR+8BHYpCxVsRFoYZbiAeapwZMklBFyu2HUND2q/JvdWwYxPfL2lTU7Cpkp5t3qmGm17om1ZauF0Zf1WcUbeAt7FZbqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450861; c=relaxed/simple;
	bh=g1HCBr8bsZcnUx3gO40OyrqGIOY7LwAa+VsmFs5/+V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSJTKT04kLY4Leh5ofQQ8cdiIWaoMz2IjCdfY4VpUh9xx2WvxGk4OL27QC74vRgbX2+A9mk0tuZ7izgybsqYMUbzSmfRKg3wmdSTF1by4ZwDcXGDaUv7NmGS6IxLZYuJ8yAFgRo13IZsvk+E1Q33OEPSqbdRw1IVDBvmFQVvUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6biJs5W; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6biJs5W"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso4588483b3a.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783450857; x=1784055657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lN2b/UwZ6UTOnQoQGsvb5dcfV+ZMY1X8+RCUQeVLWRk=;
        b=d6biJs5WL2W39/mWRte4YaVvkmFLFkQsNXihQs2Hy42ezuZ/3T3pgZ7nbCCCQGbEbX
         eS5oeljPWhGMedj9Je8hGaEj/1L3jbt8D5gqLgeVXhIZW4JqQQTMGtxVx/hGXnXLLZOQ
         05B3sFpRJHm19xwK8qxn3j24I2MbuWskVFZAgmA3HGDH4sWHbYNtPujzNbSNCqA0vrAY
         pUWEJPVnBdRPX7QAAdUqrC9nJt6mpOog/Ll7bBTRJZov+p72/SEt35AgfUqLgDuJ10vE
         H+Rs2Q4pRetJ4GO219GF6Unjf4xfdz4yTmTvW3jSR/lJ1O/lpn56tPt3LWDlzOdcPzQE
         V6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450857; x=1784055657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lN2b/UwZ6UTOnQoQGsvb5dcfV+ZMY1X8+RCUQeVLWRk=;
        b=msu7ECdG17UebVfzghqfnrz81JlTpd3qB2Ahm3VFv4lCO4WTKxFjLaD3n2sG12REJ8
         k8Y197JvM7G8y0I9+VGYjtgkoVEA53QE8Yr4lYRuhE4O2/wzdC51E0ICmfJaBss8WPll
         lDhADH/OimPv1yZhonzenrlUHSPBTi7EMRRUGgxg6fjikwBtCRbb0GrfAUfaSupaUijv
         NLXFxCdsNkp3FWH8n2S5ezmiHkyZBsojshjXXf8Mh1GWT0+iw79Dz8ChQ+kZjmdr5O60
         s2AtR21+pSw0qghe33ICVoNanbL7NoWQ5kr5IqlHLhji4WI6D9dwGTzbBaXI00+6Ow/I
         48pA==
X-Forwarded-Encrypted: i=1; AHgh+Rpw6+vHpAJbUEpzVrloqTbjN4S15BGWBkR6yffPWEQi04pHCFu78lsuezcHdd+/4JULAfmg0gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhF7qa2vzxmK1g1BBLE9cfMSyuv5m05s2kUkJEpariZfEdY0mH
	zYWDyo/UVimPdp7QnS5jDt07S5+jouL1Z9Tukd3DZ03HNH5G8kCw/ToV
X-Gm-Gg: AfdE7cmh+Xn3DHhAo624+EXMJfczAG8rJP7+3l6+qhwMJkU5UNXWyNFuJJDyJ17+2lZ
	jSaedQULxU5xNisGBRIRFCiW191obIvp0CrzBpIeUKFTYNyMrNATQdBhbpkcfzm5TV9HczVow+1
	/2hIYhD2zDldvP76PVK0B1gv6jshZRCSwTxAOROZBLtg37xVh/4ujHc504dQdtDgm2xGqHj8sbu
	/DRSuhe++6U+Wpqdon9rlqyXVE0QrQXpL7kRi9oyi+US6Ai57V5wZtj7xahqE0OHaizev+dcMVB
	PLdCUj4Q0At/VoMpnv5e8/MbL1SB0BZRzOmoLUFQFr9dOj5unBWtDtn/oy//dy5FU9lZyPGodrO
	DE3PDuws5ySXJi6P307T5TPPYSdTwMgyeBTz6npLzGlEGg3PfrS4J2FjAH9uCDwf7ypH+xPdDKh
	TBuz7r
X-Received: by 2002:a05:6a21:3981:b0:3a2:dabf:fef9 with SMTP id adf61e73a8af0-3c08ed5558emr7556572637.27.1783450856632;
        Tue, 07 Jul 2026 12:00:56 -0700 (PDT)
Received: from beelink.. ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm12305248eec.19.2026.07.07.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:00:56 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] xfs: reject remote xattr entries with an out-of-range value length
Date: Tue,  7 Jul 2026 16:00:38 -0300
Message-ID: <20260707190038.3811440-3-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707190038.3811440-1-qwe.aldo@gmail.com>
References: <20260707140118.3217585-1-qwe.aldo@gmail.com>
 <20260707190038.3811440-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs_attr3_leaf_verify_entry() validates a remote attribute entry's name
but never bounds its on-disk value length (xfs_attr_leaf_name_remote.
valuelen, a __be32). A crafted leaf with valuelen = 0x80000000 passes
the verifier and the CRC.

That length is later assigned into the signed int args->rmtvaluelen
(xfs_attr3_leaf_getvalue), becoming negative, which slips past the signed
-ERANGE check in xfs_attr_copy_value(); a getxattr() with a small buffer
then memcpy()s a full remote block into the small kvalue buffer
(xfs_attr_rmtval_copyout) -- a heap out-of-bounds write with
attacker-controlled content, from an unprivileged getxattr(2) on a
mounted crafted image.

Reject remote entries whose value length exceeds XFS_XATTR_SIZE_MAX in
the leaf verifier, so the malicious block is rejected at read time.

Fixes: c84760659dcf ("xfs: check attribute leaf block structure")
Cc: <stable@vger.kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: cc stable (per Darrick).  Now 2/2 of a series: 1/2 fixes the signed
    value-length check in xfs_attr_copy_value(); this read-time verifier
    fix is otherwise unchanged from v1.

 fs/xfs/libxfs/xfs_attr_leaf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index d0f7753659c9..948dc8b26fe6 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -339,6 +339,8 @@ xfs_attr3_leaf_verify_entry(
 		if (!(ent->flags & XFS_ATTR_INCOMPLETE) &&
 		    rentry->valueblk == 0)
 			return __this_address;
+		if (be32_to_cpu(rentry->valuelen) > XFS_XATTR_SIZE_MAX)
+			return __this_address;
 	}
 
 	if (name_end > buf_end)
-- 
2.53.0

