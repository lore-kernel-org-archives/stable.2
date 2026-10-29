Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270363;
	b=fFWUm+eRweTvC/feSmB3LUKfIW9+ofm0sRghrBxuXzwQIXxIA0/JOyAsuoBeZ+JLTc4n
	 YSuWAdoPkTLP1fjKSQnMg5bBpPkitJmvoCgli0xjBFxTBrmRYn+GnwAndABtsv2BuEDv9
	 twJYNg3PCkULJOfTUpC0ZdMD37HCtf7tDAnLlLPo8iNMpUW6G0mGC6Z1SKt8Cxm6mlwA4
	 LCcM5dRnqcBL0BIIQq1/5OXTJ+u3oP+BS/uk+svvgVEixpQeW+/eoGPgfnsgcheu5qT1P
	 fgcc6nJM6Rv33F7wahkNRDdhE68G93QZIFK6BnelYJdPuSnPNlQHHJg/LOHs1CGeHUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3MlxG84R00yGGxmXTm5ZKcg9R5+P11QL2D2DJLHVQG0=;
	b=3z+RIE89BgAA0GUAjwF4Fup+6xf8E7qc64W7eEIBa7u8ZeaJV+PC1i01qrmfVLZztUX0
	 bG8Lvr7pRDSgrd6pMni6GHYPEO8Zx5kzNoazhBOhagBBA82v6PBAhYTgCh2Rw+JCmLoTC
	 odObnDpxpPAgMzNDOiFRqrXzuKbqv3DYQbdX3WQ937DK7MhlZDhR6iFAKSS82ODqNfV2h
	 DRiQmuoUvYJIpah5anHl1rHss5mfVXoh0hBIvdNyO59kH1C57wJ1D2DqVsmAJqurBv8xb
	 081VFuFi6pu6PTiju7txgkVxCA+h2XUgLLK3kqX5J3ozYTUAmK84e+E9vSsHgjiO9yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYlsBv8v;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E87606A333
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E87606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYlsBv8v
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4550d8ab15so265007866b.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270362; x=1793875162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MlxG84R00yGGxmXTm5ZKcg9R5+P11QL2D2DJLHVQG0=;
        b=OYlsBv8vyvkJqTtf57oBzP89SQSd01RC9xptYsctoKzU/Z22VM3W7AQInaDsQ3k8Kq
         bZ4FLR9JEI1fq0ocyKOnqAod/xgey7xsqUwRYKZ1o7S5BSUZKd0gZPODfCMqWndIpEtg
         pbmJDmgOmoKvAFdoGAHvQhL3Ht+9rmiOETpdr4eSpMyvwAVO3JS04YUwQAkYwxqyKqfu
         iHqMkeCMZ0qVfA53yYq8icsY3Hf1golYpNHyUJwdzMn0OKEf9mdRjC5i4AHZsCySSLGc
         p7JuTrz+G/+3Bl76ef6zKpj/2MhcbZuPE1r8dZdFVlew89Lwd+qNUqRc5lVfzfDsgQ0z
         eRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270362; x=1793875162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3MlxG84R00yGGxmXTm5ZKcg9R5+P11QL2D2DJLHVQG0=;
        b=hTCEt+LDR+qObpZKruRPB3PmktGpeIP5a1DiRejVw/GDEEh8054ir8g7rFafVPPmUu
         xrqW22etUpWdx6HPvON8yi4fxiUWtq45J116DpNtNoJ5L2rpCO/yaigvGO7HFyJo8on2
         t3mytFi/ZmlLcHO8MI1KxAuyA9MOMeNL0XMEHRIy2IAxIbTlP+UqkrOoFo7DPqTBZkFg
         F1Cal3GwDDz5dQ1020B3nuqYjjZIwyIyJn0ppcwq9U+4LjD3odI17ZjXYeOhKykVDYNt
         dRpakEyRO69qHgislP4HzkCiHW6altvim3zP3IR9+WOkS18+OQM5dxuiUpsm8GhbG2kx
         4VWQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1Gy+k7P1xyWU9GMbzH/6LchpBDEgHXHJRPRGK/n1A0SXhcZJ4W+dbXb0qKki8BC43PAQefN8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdzwUtPm8mLXv9/ifTijFCkNJZuXtVJM04di13veLWyEaX4my7
	A/+8JrH5BQfphpcZeVjAigl5oxjJaHfPydghWZkWBnV0duhJjASalfUS
X-Gm-Gg: AYBFou1rPFNV219R+JDcAM6NhkFp6Ww6wxAUfT7iE3NCLUWGJBzFCT+FxgzCDSzYsGT
	WUH22x3lD7jlQ55tKaf+0Ap/5yOKA8YvLeSzlDhYpwhLsr6TKpT96ygDEdSECeK8GOM8pmuVUC5
	lK5EoOaW/2LIQ9EbvbTpgsocMzIt5g1fBe9aHwtB7lhViv+9tnzEmPjZNcwCDsHv1+ATCxzD9KZ
	McbaqmePibJZckH4pi4pSLCSUpLPcvGLqm3AcrSOqEwWCd+k3BifeiCQApxG8TknHiVLJJBLkrd
	GpIIsMEYvrRkwvV+Rnm/Ii44akvZPLvSRWh+B110tM9Be2iLqSbZYsV4BQPFTtGMs2cnsyNvynn
	8E4+1Ynir0KbMCeNurZyeXk9OL8TPQ+JzJdh4w2CCxAeWByXw7Lc84lJm2/PnSAuruGfDGAky7z
	M3Beo9WrMDwG6yqgygBZSGdW6kMan1TjFLJVpm3m0eJTur8nV0Q3oIMNnfMKeyWhewW+Q4yxQyu
	WlQX6RMW7v9t1rPZFvfw2xWssXMpdmK/knVqm66nyGzqbk+RnwWKAmMALt+qGpgWm9E2j7EriM7
	DCjSRuSeJT6mPeG+7lzXyfq1waeE/DFBP1Y9Jl+y271W9jGOYx24SLEUoep+Kb7/AiPpxt78kdu
	7bBM0OZQS3n4=
X-Received: by 2002:a17:907:d15:b0:c2e:317e:d711 with SMTP id a640c23a62f3a-c49bdf0b1a9mr401098866b.27.1793270361414;
        Thu, 29 Oct 2026 03:39:21 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4992141068sm496431666b.60.2026.10.29.03.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:20 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 05/16] ovl: check that the parents of volatile/dirty are dirs
Date: Thu, 29 Oct 2026 11:39:09 +0100
Message-ID: <20261029103913.2785828-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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

From: Chris Mason <mason@kernel.org>

An unprivileged user crashes the kernel by mounting overlayfs with the
volatile option.

A dentry that serves as the parent of a lookup must be a directory.
ovl_create_volatile_dirty() walks work/incompat/volatile/dirty by name,
and ovl_lookup_or_create() returns an existing entry whatever its type.
A file or a symlink that another task creates during the mount becomes
the parent of the next lookup, which calls a NULL ->lookup.

An unprivileged user mounted overlayfs with "volatile" in a user
namespace while a second process created a symlink named work/incompat,
and the mount task oopsed on a NULL ->lookup call.

Fix this by returning -ENOTDIR from ovl_lookup_or_create() when the
caller asked for a directory and the existing entry is a non-dir.

Fixes: c86243b090bc ("ovl: provide a mount option "volatile"")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index bd0a3f9039d25..18f56d463572a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -621,16 +621,21 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
 static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 					   struct dentry *parent,
-					   const char *name, umode_t mode)
+					   const char *name, bool is_dir)
 {
 	struct dentry *child;
 
 	child = ovl_start_creating_upper(ofs, parent, &QSTR(name));
 	if (!IS_ERR(child)) {
-		if (!child->d_inode)
+		if (!child->d_inode) {
 			child = ovl_create_real(ofs, parent, child,
 						&QSTR(name),
-						OVL_CATTR(mode));
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			end_creating(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
 		end_creating_keep(child);
 	}
 	dput(parent);
@@ -652,7 +657,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
2.55.0

