Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEB44838C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109662; cv=none; b=D+xFxttPRwwxMuO5865yfw+6VLYrV0Or/2Ajg8QTBq09ov8/nCPA3bXSrD1YU4Mhvck4DutdZv9k5tFaKpXqejVN2CjqQZ5iBb1y1UDT6RKYb4WYbquq7x9l04JBYwGQnLM89CHTAJH7uHgFVyr6/L9gAttE7Ny1hFB8HAKlZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109662; c=relaxed/simple;
	bh=vry3klap9u4GjQNVsbX+2L8vo2NtkD7sLGYczUDYo14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/bKUmJsNr784qKhpxJKkoDTFewzpF4a8Afy5E9aL+sMsMEwk9Lnv/Mtobubtbm1vjOrrsHL2FpXCXKG8VzmH05cF+zcxz9zrdTmStU1ScQ2KqfSbVDBbW9xWOdsG1o868smEzKflbmtUtj0cYaPXivSHS4uYuLm26VCKeSKnKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlnzFUjl; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlnzFUjl"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398a5aad413so572494a91.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789109649; x=1789714449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=45NBjTXP85L2NWWZj0GIgJ+kRVkTLutBHdaU4FJg9VE=;
        b=SlnzFUjlpJuAXk0c4b3WKTWOvoL+gm2sqyb3LfKwwJR8cVF9mDXqq09ORQttoyGzAt
         dmzREDFpCCqYAxK6AEihFp12q/BWiMevkgpjlBM9rx97zuYQ+EmRZhm5CCD6ER+EX5dp
         ex0RPQrRUusWtooZ11CaQkWmACqew9arfxr1FH12/0cjihqIHjDcia4owZHRMtREkuXi
         8Lq+71sdmKbRGpF8FO53Op0Fuqdh8DYPhAN0b10yJtUpfRqVLaqQy+60iNgLN/PMqZ10
         JAf3jPZqEC6enNRIquNHovJt/voL/7bFk/XZObOlMObsi1qatqJSvAEcc+27ZjGRbXLl
         5NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789109649; x=1789714449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45NBjTXP85L2NWWZj0GIgJ+kRVkTLutBHdaU4FJg9VE=;
        b=cpOiyTOWkSb7+M6JGirpLno9K6wCMaQlqJojMeduap9saas0drhUF/bXw9kuGlYdQy
         uljQq1Qdk/bg1PHxNPjbYmPiDhaMT+W3DoEACr4QgCtoUYSnhhn0GsISZMH+9pxKKYVz
         HK+PrYy+JC6KMC/dM+PsUt1GY34fM1LqeV8NwyKQuf5iDXsAUATKG3zG2GlaVV10krOI
         pyVm64DPHPdqgXou/So/C90bzr1c/BRe1KQ+vI9xvnCbVR+GOB463GiQh7RJteaJbR/Q
         Zd++mRmPkXNgdrLPIY4XDPl2hyizmyhTIosmgUp8W0Bk2mgwqE/kI4cKIkj8/0y1Sz2n
         3bKw==
X-Forwarded-Encrypted: i=1; AKwUvBx1y09aPS5FvNENJmTE1PuoIKLcYHg9qdec0eJ1MUWD/L2bCpEjbzRHsm/eU6zDzl2JUacDPHY=@vger.kernel.org
X-Gm-Message-State: AFuF++nOlGUvASlacj01/56UHj0+obgGUvvsylyIXuzaDifueze9Z2O2
	nlBxXTSlpqQlEykuZyeNfsIopsx4R+A1Oah1gQFfXcefA9hh1ME1tvf3
X-Gm-Gg: AYBFou0xlDYodN1PBHa/e3oXZbZe8Z5/+XGnHyx2HyXnZ13tN5GT2Yt214zi8r8hARP
	GOPNapu4AGay6fd4+g/BYK45dYZ7wgVPgFB06i9LK1lHMiczpBPlyPz5UgGr1GHjCahe3yUnJ8H
	nqta2w4pegqzad9wzTTuzBYYcvE2Q0QxM9E8NzMGhy+kkRepSykvB+0B1Iv5kGlHH4cXuYgmIcl
	gf+zP5xuYmRQxyGtWFfa8T3zXgQrwHoEqpFa3x4nwC9OQTQTWwN+29Ae8RpQUo9PJakd2U9mGVR
	8zpSgEMi8GRoGdw35NkLN2X8+GfB9TJWfw79dQiN5v8GNW4MEfo1flETr1ZMpwQ5vnXO5eg0osu
	yXUJ+a79REWI8Kz1Y9R1Dm0ju5h7dB40BvzJaR8wOzFW8LnYqgagSUbTOCxgO+uGckqBwIN+eJu
	g/hJmkkNmJNTb/NFORPHoM8EMz0UaCb6Tw0viJlfHHh3Vrj7bhYXdoSZEH7l+s0DxVtmfMj416L
	5/+0Xv4IrRsWpf9aLPK+Fi66W/4H5jor+WhET/y3lRRc14=
X-Received: by 2002:a17:90a:da8f:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-39d9bc1007dmr3989259a91.5.1789109649253;
        Thu, 10 Sep 2026 23:54:09 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39da1ad5d79sm1830549a91.12.2026.09.10.23.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 23:54:08 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: gfs2@lists.linux.dev
Cc: aahringo@redhat.com,
	teigland@redhat.com,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] dlm: fix RCOM_LOOKUP length underflow
Date: Fri, 11 Sep 2026 14:53:51 +0800
Message-ID: <20260911065357.3511466-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

receive_rcom_lookup() derives the resource name length from the
peer-supplied 16-bit h_length header field:

    int len = le16_to_cpu(rc_in->rc_header.h_length) -
              sizeof(struct dlm_rcom);

The 3.1 receive path only bounds h_length to the range
[sizeof(struct dlm_header), DLM_MAX_SOCKET_BUFSIZE] in
dlm_validate_incoming_buffer(), and the RCOM case in
dlm_midcomms_receive_buffer_3_1() performs no further length check
despite its "length already checked" comment.  A peer can therefore
send an RCOM_LOOKUP message whose h_length is smaller than
sizeof(struct dlm_rcom) (48).  The subtraction is evaluated in size_t
arithmetic and wraps, and the result is assigned to an int as a
negative value.

Both consumers of that length only guard the upper bound
(len > DLM_RESNAME_MAXLEN), which a negative len passes as a signed
comparison:

- with rc_id == 0xffffffff, len reaches dlm_dump_rsb_name() ->
  dlm_search_rsb_tree(), where memcpy() converts it to a huge size_t
  and overflows the on-stack 64-byte key buffer;
- otherwise len reaches dlm_master_lookup() -> _dlm_master_lookup(),
  where jhash() converts it to a huge u32 and reads out of bounds.

Drop the message when the computed name length falls outside
[0, DLM_RESNAME_MAXLEN], which is exactly the range valid lookups
use.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 fs/dlm/rcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index be1a71a6303a..14d5ab658f60 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -385,6 +385,9 @@ static void receive_rcom_lookup(struct dlm_ls *ls,
 	int len = le16_to_cpu(rc_in->rc_header.h_length) -
 		sizeof(struct dlm_rcom);
 
+	if (len < 0 || len > DLM_RESNAME_MAXLEN)
+		return;
+
 	/* Old code would send this special id to trigger a debug dump. */
 	if (rc_in->rc_id == cpu_to_le64(0xFFFFFFFF)) {
 		log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
-- 
2.43.7

