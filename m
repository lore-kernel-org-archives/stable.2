Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968471;
	b=TSQ7rzp27jhlXqKXyeiB9mhiXi3DFm2cd63XlzLfo8XR80zxWYws61t2Ot1FoZB6wOMv
	 DbeZ3D5F5M3TuuRYEk6eGzk8UnYw14bnSXD0I9VIWNcWsGgIbW6DA8ODFIKTF1hNf1wCc
	 qvtwLhHa+YCXP0VaPXGHUtzXoU+aeAPUt4FzsKpt0TlUjdGJE6n8JUNQ9vDroczHNZP/v
	 i9KV9TbF9dz8xVj063BganMrcP5YAPIdlIqP0vV9Q9KAYKbMPWySFOL6z9FkIXs7h3i0/
	 QUaI73xGrgodHKCfXODdllkx6/2jPaMymrZ54NYk3miSFBV91D4W8T2d3S+59v71yJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7iPFWmv91bwRmuYJusTGl3V1znrgoJ5UvO246yjWmxU=;
	b=pA8COXrcN37YKpOmyflZmwYb8rXaulLXSowxt1WxhDf6Rlnh9vbcyXaPWra83IDpZtsH
	 wNiNAVPlNm7rHJNs2R2lgEjKoO79taipGBzAe5N5UBySqPjyB81ZoI+MqfjMC6o80YQvA
	 ArhkTdIzohF9h+PqqYXCOd5Q0ABC1xSyGmCgi6MXHBV39E8MVVX2aRV5KgnbfIEzmWsWi
	 5OQFnDDibrXN1Lt8AaXFX8zuV/e70meEBQ8CjQOPVFdbIlY/R0da2ahT4JYtjEYmvxw8P
	 19Duw8kf7b3HlipqiTPSon2ji8MeIDybnVcm9wEyi0Bdl3ajv6YPNFBM7PYG1K/OEbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwJidFVx;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A95606A33D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94A95606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwJidFVx
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d427836e9so63710266b.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793968469; x=1794573269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7iPFWmv91bwRmuYJusTGl3V1znrgoJ5UvO246yjWmxU=;
        b=DwJidFVx3Bx+rwF6E8M5LH3EX4vHlDVPpjI+u4fo/cve/HU9LPHUcZMUZn+s4Vr7Gb
         mHJInOVDlaUmC2ofE88AE5qudefc7X0piM+GB75qIdhC9rZRfPekyftExUYJimY4wHwb
         +d0oAl+VdbXptutQ4mb4MoEuq3KdIuQjXIyAkIEvt70yjEZV/57MrlvRHk8zxe93GcaN
         SE8z8Uoa2OT5vR3E+4mq6E2unGhi4ZKQYNEGqaZBuRFAheQwPKEOYzECw2KOjbJTfF6I
         UOd7q9EbiUBt6Zi3KRWcrEvPevsGAcZLaTF4Z4arG4iQ3MUsm/BW9u/YVDXNRpT7Snho
         NvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968469; x=1794573269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7iPFWmv91bwRmuYJusTGl3V1znrgoJ5UvO246yjWmxU=;
        b=CZaI5dodYoWqMErQXOV7syvvpt+NZOHmWzV3Qtl386HPTKO38Yt88xlsTg1iiGMwzz
         VdG18rkYYm/FyQU/YIn4K5zgoqAM5P+635JOQqMfT/g8lPJeiufeChVSm2mtpgJq6ox8
         +2NjSzk3u97RVyAviYb0y/fQ6J6qun7VycjwbCXrFGFWovmxiSQCQXsuNYJFV5StQb0X
         vqZgfFm7d+tEIsir2FbBrPIffEMj5UrtC4jshGJrhAEd8b/opGQfjEvhMGqEUSHvdD/A
         EQ4/proFDAPMINSWCl7d++Jpvf9ffdHYSr74P0XbS3l7Y9aVllol8XlTXxXMpxWw+Pj6
         /wCg==
X-Forwarded-Encrypted: i=1; AKwUvBxEqd8pbKToxrlqDoaqRn667nD5nBYkVUW7+ehGXZVPtoqU7y3r4rHseqFSxdduqzQ0Gr0TmZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r+X55zgFzdlfW0aDh1/H8er15XeODrPRozHjeqSZ4bfpjTZSU
	pkrs645Tszpy27aWj1wYGYEnxUVnNKFUz9QMUJW1YR3EoWk6YmNA4ph7
X-Gm-Gg: AYBFou2IcCEvKKcrGYZm44dpU5eS7iSsmKpO1ytwMqSlWLKH//RLTvr4ZgPqHdcWNnL
	wtLs3rEIb0UDOl0Y+mFgNP2+XwzadVZxJo0qMgKwfJUp0aIe+gjtqqyWTp9DNlV6Hfx9T+kt11t
	NK4R2/zdxe4CCkIKMVJrcammBb5Y3Z9XBp26CvG01JrD6hAUoFUbL2qhdClCMDqm3XMh0tF0dXF
	Je0SzAMH44oFcrAJGTSdhuvvP08E5AIgMMVO7EiFpE1CeqCLMId9U5kn80WzVETB1q+FzqnDyzu
	UErrWSg/b1ix289jLeTve7V7efM7jCPMZTVj4O2IRKcCvzaABeb9aosuWp2lxjN3HLK1FkC7g8F
	X4arzrCLVZ12j6ULzDgvXbriHjUUN77iL0vg9pzzU2QeoczL+xQr+3dqn4N95Q5AnFqCl0pASdB
	AaAEznENrWMRYCSCt+DjlrFX7k3n7T7s5pKKBOXb0ZH2T/fjGHRGvzP5YgmufS4Nj1fjoMKEL05
	zIu14vJ6+lrCV+ACh/unDlzP5KyrTcikL4zXedal6HizYPw995PgLc3Ky24QfD88v8cyUnAhISj
	W71DXDQINloBOuRtow+Qydl3Xh0uBVo+B6X8ZvyPluOiCZfRbbuA2I+LILR5AWm34tanl1im4ke
	KAuMZOpqWKYVNvQ==
X-Received: by 2002:a17:907:3e18:b0:c29:3c97:c994 with SMTP id a640c23a62f3a-c4d354dea2bmr229915366b.35.1793968468443;
        Fri, 06 Nov 2026 04:34:28 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d35671585sm76518566b.39.2026.11.06.04.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:34:27 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] ovl: do not read the flags of a put upper dentry in lookup
Date: Fri,  6 Nov 2026 13:34:27 +0100
Message-ID: <20261106123427.3842634-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

ovl_lookup_layers() passes ctx->upperdentry to ovl_get_inode(), which
takes over the reference. If an overlay inode for the upper inode is
already cached, as for a second hard link, ovl_get_inode() puts the
dentry and returns the cached inode. ovl_lookup_layers() then passes
the put dentry to ovl_dentry_init_reval(), which reads its d_flags.

With a local upper fs the put dentry usually stays in the dcache, but
with a FUSE upper whose entry has timed out, dput() kills it, so this
is a use-after-free.

Fix this by taking the revalidate flags from the upper dentry of the
overlay inode, which is the one that ovl_dentry_revalidate_common()
revalidates.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-986db859-840c-479d-944c-b9c43b93377e
Fixes: bccece1ead36 ("ovl: allow remote upper")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/namei.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 64d63b260709c..98e846b3846c4 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1382,9 +1382,17 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 
 		if (metacopy_size > OVL_METACOPY_MIN_SIZE)
 			ovl_set_flag(OVL_HAS_DIGEST, ctx->inode);
-	}
 
-	ovl_dentry_init_reval(dentry, ctx->upperdentry, OVL_I_E(ctx->inode));
+		/*
+		 * ovl_get_inode() puts ctx->upperdentry if it finds a cached
+		 * inode, e.g. for another hard link, so use the upper dentry
+		 * of the inode.
+		 */
+		ovl_dentry_init_reval(dentry, ovl_i_dentry_upper(inode),
+				      OVL_I_E(inode));
+	} else {
+		ovl_dentry_init_reval(dentry, NULL, NULL);
+	}
 
 	return 0;
 }
-- 
2.55.0

