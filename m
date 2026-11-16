Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824553;
	b=lw97R6s29d+d3z3KJGQwNdbtEtCkYb24lzMC6zj21t6hoOz2idduysRPxzgzs3FhihrJ
	 gVSczEb3bR6o/474V6MCUrZ+k3RH6EhTodNseHDdEl9yVZV35CN66Oom92QNZC4Vybw8O
	 hBeM7Myl9vkp/IYb12ITID6ptiqLZygQxi391rYDHL6+NvLUNbolOaXSjxY3m9w5HznJr
	 IHkMisrqBLAx/je6R5eECATD+pVwq42SsD6g82mh8brAYvh6Y1pbOI6vHnA8Cx6frdFZu
	 fv7SiQEWBqqb2dMFsd/+1UNM/MzcaxaeewDJ98Qwy5aAiU61Hxs6A57vloP41EOJrnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=e4Et5WMZaz3LvBfh2jlwetoJpjp7/FMRj/wZQ24Y5ac=;
	b=HVg/CC6Goz1CPtyUMF2ZI6O4+bcArCrr+2Af/5zYu8J4vcrizv/quf6vDeK6ICYkt10e
	 bFIdTodLZZrGqELPqn4kEZdvWnEsABgABtx3DzMmy52/cBHpikPZSipW2WztBR+wOrcCU
	 gMsvxu6kLWZ7I/ooNWO/FR48uFwfLSjh+gQVNHw+yjL/DUEq486msItOLSiofFgyDQK9F
	 3LlGYmH/uJCRuwswF6XuV9wFmHSYZPm67qH5g/tqbWzmKHXcbjsZwkDusO9UlHT/oXUu2
	 sYkVhMdSllo8PADn34YjfvMrOtOotvuSwYlxUsCWFXu+l85kUwIGg+ws/nwGO0BmQYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="s/kR0OQn";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B497606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B497606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s/kR0OQn
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso19314465e9.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824552; x=1795429352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4Et5WMZaz3LvBfh2jlwetoJpjp7/FMRj/wZQ24Y5ac=;
        b=s/kR0OQnus/ELVQiXFewd4uRT1KvhI1DQz+VqaFQGfniIyQMOR1o5uLW2K8BMtcALB
         ZIL1cVqva+DwH+G3fXeg+CDR2u7QUVRzeG0ru8KZ4WBQhUdvVT46fHws81P+V+cEQ8pa
         Z3UvjQpJ180F0y26nlY8U5/nab+Hnq/c77dCza1EnXDbyNirk3maJ/xV3uIRZrOFPlA4
         xcE6rBIYl1v8qEqEhwY7mSuE/q8oOzQWXB3N9xgO5KQ8Kn6+q2RRIiemb3Y1haPJLFuQ
         ZRRtjb+oETeTgM7wFR66EYF9YSfRzphGrW/bDPwsibAAYPq9tbZeiG1tB08/MJeQpv4X
         DIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824552; x=1795429352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4Et5WMZaz3LvBfh2jlwetoJpjp7/FMRj/wZQ24Y5ac=;
        b=q+hzvZa2rJtl29Eo5G4B7JRNsqwvYHA+tAUTWREPW3vEQTGtDbFtcmOhoeITdVCOZZ
         s4Z+2+xnkqt8oakN/vMvjPXeuuZJq46vpRPrcTY16Ys4HOFO/7d0Iti58j5t/dXH0aOI
         nxlQZCVieajF5v9JhuMPrnUSJoQ0u8FI7cUmzSFAyOtESw3cPMzxisQXaqLShDYs8f86
         LRrSR/7E1K+Eo+1xFRbwhmRY8kLzhbvMz/fkbWSdbGJs+exmlK47myt3H3N08m+ole8p
         65BpXJmUHpIttFPc3H8vPIHqGgbKdEA59teueykShH3tJoBn6uBCx6Q4q3troeVIHH6P
         R+mg==
X-Gm-Message-State: APuU4Z9BBJRldzX3Q1CqY8mWCIj3nPBcelT3ceOA8g0l+I+DktJLjK2L
	+S+bFZMX62ITx46dVLQYWTlG+/4Bg3wbdNl53T1DbqLfrzdKkKt8ULJWcQH0qr0c
X-Gm-Gg: AYBFou2Txno9CLCDOro0eA+OJPx9MIBQaHyjx/46sLmO6Moz71AZQwjsi/v2gxf3nDB
	blu0WDM++PES9spt6znofuQs1Ktcht1J8jzFW5QHB7aWWQfLaMLkqfsUsPzm4rodL6OTGqQSwiF
	JnK1K1B2ivAGo0k/MJwGy8ZX+U8oKXmGGbP+z0PZeuKfDTZEw3eke3Fl4gxdugvlxlSKObyiT+p
	OCCqmZpbi4xQ/0d7/7Og2xJ4cyAuE2jkSwKO8aH9KA25pIY+x1hKbBSBW2fBzx2k3koDZeaGSbJ
	j8CWg7vfk7ntXTDRM86e7vDeL2KPbv3mUu+aQO5cVrytFSOoj008KnmjuYgjGsWMHqy+j632jiQ
	Z8i0RnWtCcEwSrrArKM7sKRaInqI+9abrU6VC7vfVYfJ6dnW2WV4enCaALNcF7krZQUAgWIYTKR
	V+6fvmeIfm9GabckhUnGi9vh/0Zwe4G6EP4D8qBOG74Ef3zOJQQmo/wzQP8+M1g4H/dvxWEaThU
	ozCmJjX8cvxtBH57M8ytDI7Q9w1ox2IaDt4R7m5rQjuh94IoajwyJiV2QixtfA0RfoRgFHB7OfU
	84mIrZ1dTkae4fEq33xv
X-Received: by 2002:a05:600c:34d2:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb55ac6cabmr206158025e9.34.1794824551582;
        Mon, 16 Nov 2026 02:22:31 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm388703845e9.15.2026.11.16.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:22:31 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.6] fs/stat.c: avoid harmless garbage value problem in vfs_statx()
Date: Mon, 16 Nov 2026 17:21:58 +0700
Message-ID: <20261116102217.80740-1-petrvaganoff@gmail.com>
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

From: Su Hui <suhui@nfschina.com>

commit 0fac3ed473dd2955053be6671cdd747807f5e488 upstream.

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250119025946.1168957-1-suhui@nfschina.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Petr: There is no vfs_statx_path() in this tree. The fix is applied
  directly in vfs_statx() by jumping to path_put() via a new out_path
  label, preserving the reference drop and the ESTALE retry. ]
Fixes: fa2fcf4f1df1 ("statx: add mount ID")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 fs/stat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 5375be5f97cc..9d3f1b276c86 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -246,6 +246,8 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+	if (error)
+		goto out_path;
 
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
@@ -262,6 +264,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 			bdev_statx_dioalign(inode, stat);
 	}
 
+out_path:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-- 
2.55.0

