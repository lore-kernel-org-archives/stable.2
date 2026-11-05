Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864477;
	b=xloW9d0LGLAeTVZoJS5+GGR1SZY4xAk1Ch/u/CQ7Kz7RpkjG5tLpAQgPvU+OQfkZzjC+
	 tatWAOSHgkcYTPGVADnGyyzQQ1QGIpikNdHGIUQH0oTiRZ9Dd6B7BJd89Pkn5Um02L5Ll
	 O6Yip3x2FthO70eOQFsI4UGKUJL6fEqa9kdjhk0ZryzIKin/80sLfbDAiNZs2d3KBYmFv
	 K9N3/h20DcxNcObryEFFe5WdE3Hb2ruhMrrR/Sk0VRXuTGQJkdz+FsiI8rop3UE2ZMzrL
	 aRjeN6CjTi49NHmiCtfFs8Di60F/tz0CsWR/l8Wp0mg6ZRpuFC1vkSseCQ5Jmr7qdOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1WWOUcVXPFK3YM/ThlZnNrlMZohJmxKvhAM0L3/kWEQ=;
	b=SfwOedq2xjL+aLcp42pE7k032ygrw72ssdEaYfwmJMO/ZaecbnYZLLsz0WV1XPczpFGv
	 vD5enwaOr9pG7+Njn4SvgXKqzvS00I1/RROc6WMIU7+DOgvphjsFciMk1d0BZCJmSSWm8
	 rk2MN59BXoar1FvT553D5Q+hSG2QmrIxegYrOPrcUFsoCt7vPbfct/D+xrSVK5ac4nhgl
	 NlHRMNmXIan3vIQCbN2dz5vxp2+Sx8LXsjHViGdXjLdT4h8aOOBdvpXfISgClhKsRM1/n
	 AXiZFlmyke1gxuwugomMkDVFgX00eeYhKAHReV2UUV4dQhSqIzqWNRr+LZC+1N1LHpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKgRu3tG;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B59606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36B59606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKgRu3tG
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a091e4eea2so128230b3a.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 23:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793864476; x=1794469276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1WWOUcVXPFK3YM/ThlZnNrlMZohJmxKvhAM0L3/kWEQ=;
        b=aKgRu3tGLWjETj4C7QrkeK8f0sI3lwMI4LK9ATDzwVeUJ/ujLC221+ejjb6VcxtEho
         3C1XecimCaL0eGB80FNG7oiqorJ5FPlMx52wB7xD9pX8CVENH/x1SbUVa12EA4VkKt0G
         XfkaKTI63ppcW59K+4vB2j79qbS2yRcHB7elCWPGo9NAKnvM2RWl/wrFAwdmkEZxR3BS
         P5Lu+iHO9z9mTkA1XamIAYpvLwznOo87W1I5rL387A+XP5AEjgVo2Gj/ShYmZ38FakDF
         00U9MYXDutM7NMCM/8CPwBZwnOBrMaLdiz7mActhHhjNZXnX6tzuiiGRlC2GllWE2uvx
         +jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793864476; x=1794469276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1WWOUcVXPFK3YM/ThlZnNrlMZohJmxKvhAM0L3/kWEQ=;
        b=NgXU1jf2TsXy5lTAqrF2peHqAf45dYFHSmAdESImytTJfLxu6eV8xW382FrnaBzSU+
         0heGBNHZyrSNDyhAZ/ugUQKBOp0fJ7Sn6q5htvSa8l7U/vbbWglFozJjcSXUNnnsQZID
         tjfg6nBixkbIpYJRt5N7PhM6tbqc5hHxejSuqgJNwARwkqZ0jaI7IUpzqmYt6gVRTwc6
         WaRMEd1+5qbkNY+9DCU/ojIJkx/gDLWej8qgcnjLL7CHM01UxuedWnl/f3TBAaGCHHe6
         PLgOcOFx2oEfuv0MnEVP260ImKZxdMGXyy8oIz27ijG2gLfScT46H5xSIY0VPGRbw/ml
         J/xw==
X-Forwarded-Encrypted: i=1; AKwUvBwdHqoc2C2uqcriIB3TlOK8+QWrzLqiilXPuBSRjojN/2Fdk3Wg/iS87kJzGkFOZUdtyA4moyk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Aa6rCPmQzR1M1+9EgPBMSu3ddb6KBJetIO7KkGJJhDPMoTIGU
	TU02r2kKibxybDJklmvGxDiVmDdkvxuOksG3lEO/SF/QRbqBh1dN5v1w
X-Gm-Gg: AYBFou3i0wJdevX59Yj8KVLTOybsr5bq3/02iw/1GhgTcTn2GTLklPFPsNMyl9OTNPO
	q1ZGsH1YvLQRIKMt/QVUseFEppe3OjVbWl7uyWBKpVHBmHPaozVgAnN/aa9zgxy0JSltgdpaO1z
	zNQVOUVHZEk2cA0Rpsc5pPDrpRZQJeFOqrhbkLa051Ap2AwLfxLzdssm/mAuejIDPXvdJRv/RkG
	oDSW3oJWhJ8lAwI9B+Kfl5QURq0V/HclTTAR9Siew9JeiW9XIi4sU+GTJtAxxxBc9XWZqGrZ19v
	CNL0WLXcwy+poPOptrZmB7AeuuWjDVJ41n0kqv7FoIn5zxNhTtCE+XG7tsqfrPa1885UUCmlaN5
	T7QYiDyjYPjMMHI/9S1hHcrgMM67HJC6WNiTqkGqZW3Ye6ocJQKLlekt1RF5RHa2O59K9ggqXaF
	R5UqMYPveIzQCpPoDRb89CADYiqiEQqiRB4INM8ZbPuv04oPBibkWkMfelRkntL+9uExzWxwNvP
	Jur8GQ6TRabTvDaENaz+IQDEKRqEW32cAtt4FJYmZhONV2819lOcVzl0YheAY94W6TzhdUAtoCT
	QkDhE7QXTdKWAqA7mjp3uJf4nd62PG1i1yF4DO94YPl6+iPCmarY+jUxK70Uj+OVA4VYGFqqvAv
	YQJymQQnd3Y8bYawE
X-Received: by 2002:a05:6a21:f107:b0:3e2:1823:2b39 with SMTP id adf61e73a8af0-3e9288c9c22mr22391455637.2.1793864476304;
        Wed, 04 Nov 2026 23:41:16 -0800 (PST)
Received: from localhost.localdomain ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb467f6668sm1959799a12.8.2026.11.04.23.41.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:41:15 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: john.johansen@canonical.com,
	georgia.garcia@canonical.com
Cc: apparmor@lists.ubuntu.com,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH v2] apparmor: make unpacked rename and attach strings owned copies
Date: Thu,  5 Nov 2026 15:41:09 +0800
Message-ID: <20261105074109.95617-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
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

unpack_profile() stores the optional rename and attach strings using
aa_unpack_str(), which returns pointers into the policy blob.
profile->rename is later freed with kfree_sensitive(), causing an
invalid free of an interior pointer on the failed-unpack path.
profile->attach.xmatch_str can instead become a dangling pointer when
the original policy blob is freed after compressed binary policy export.

The dangling xmatch_str is read by seq_profile_attach_show() through
the world-readable per-profile "attach" file, giving an unprivileged
slab-use-after-free read. ent->new->rename is also passed to
__lookup_replace() in the same load syscall, and the rawdata dedup skip
path frees the profile again, double freeing the interior rename
pointer.

Use aa_unpack_strdup() for both strings and free xmatch_str with the
attachment.

Fixes: 736ec752d95e9 ("AppArmor: policy routines for loading and unpacking policy")
Fixes: 63c16c3a76085 ("apparmor: Initial implementation of raw policy blob compression")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 security/apparmor/policy.c        | 1 +
 security/apparmor/policy_unpack.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 397f9ff78aeb1..695bea2a70820 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -282,6 +282,7 @@ static void free_attachment(struct aa_attachment *attach)
 	for (i = 0; i < attach->xattr_count; i++)
 		kfree_sensitive(attach->xattrs[i]);
 	kfree_sensitive(attach->xattrs);
+	kfree_sensitive(attach->xmatch_str);
 	aa_put_pdb(attach->xmatch);
 }
 
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index f1fc48e72d0e1..6da4579bbd8ed 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1121,6 +1121,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	size_t ns_len;
 	struct rhashtable_params params = { 0 };
 	char *key = NULL, *disconnected = NULL;
+	char *rename = NULL, *attach_str = NULL;
 	struct aa_data *data;
 	int error = -EPROTO;
 	kernel_cap_t tmpcap;
@@ -1160,10 +1161,12 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	rules = profile->label.rules[0];
 
 	/* profile renaming is optional */
-	(void) aa_unpack_str(e, &profile->rename, "rename");
+	(void) aa_unpack_strdup(e, &rename, "rename");
+	profile->rename = rename;
 
 	/* attachment string is optional */
-	(void) aa_unpack_str(e, &profile->attach.xmatch_str, "attach");
+	(void) aa_unpack_strdup(e, &attach_str, "attach");
+	profile->attach.xmatch_str = attach_str;
 
 	/* xmatch is optional and may be NULL */
 	error = unpack_pdb(e, &profile->attach.xmatch, false, false, &info);
-- 
2.54.0 (Apple Git-157)

