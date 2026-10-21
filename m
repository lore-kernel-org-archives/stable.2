Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605402;
	b=4MlptjfPXQ60LH8I8WHbIufJEq/NH4VoBJkuEbZJ1KANe07GYdtQRrWRb9GqAxwHLmNQ
	 NwbetyRhZWa0Qx6MThpq26t9f+PCjqJLg00tgNFstI1UZQ4QVM4tMMWBMjTICFAdStxqz
	 gvSh8BoWOkNyn7ehvTjayMvg9JxH9ghCvE5fDKldlooxFDb+LNk2bEMHKMAm0L7m+ptVs
	 vejPcagOay1QDw5iMbCDfYkMsRsVizRiHpnsBtCmkjZxMcJFtTfjw3oyD5mTsrMKWPvlK
	 G0iNhOHWTapmHi+ExZBX4BsJmXnVXMv3IKcfFzcixi50+h3vMgvEwW2L/KUsyK9MGxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8ILZGqeePK3tN5s5Fa4xyHKs3r5hIM8Fdn/roa97zOY=;
	b=1oBbXlTuTF3ArhScZf2urP01SIsAH/RVDbYeE2FVQy25nl0LEX9u2oHNcLOMU8GMiN4B
	 c+hYJvM8szTOBkc73z74rj7VJIJxzdKmBMdaCe2ELSCqmt18EeikL22LVM3PkTZ9nWDvb
	 iddYZLz2JaUUm7lBsDEgHl6fkKIOVnzNNXBJ7l01FAifU1sc0CEfmMfdPacvRJ4faiY2R
	 yHS7V+6z8+pJzzqESsfMmVzD5uOGn640cCE6LZzRPOMzLwtpRdY951Cb0UmkvGKL3X7Zq
	 BxlxjSb86b1zjb5pbNP2B3mV186prjGH+1+azLblpzGfsSg6/mwwFhOwzJzgCtsr+og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=XQ8MzsJf;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A8606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B2A8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=XQ8MzsJf
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-17bc533fda3so1222090c88.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792605401; x=1793210201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ILZGqeePK3tN5s5Fa4xyHKs3r5hIM8Fdn/roa97zOY=;
        b=XQ8MzsJfm7hVLaVVmJxcZ6cCv2OpnZhEPS/ixp+1iyeH7bdd67uqG1H1T22iN81Vpj
         IqdFpLXy+hex8KLmaifYYxCctnfDmCSeb6G/AZ2ct0NJ7cUn6kLJdQhpKeFcQ0KzF1QO
         MaQCpyPrutkdj7djQwJeI99nmLRhJMs07Kkrf+Y/qy+Vl6TpSthXMSA1odxP9ZiiAWfJ
         jkVxSyB/XBfrqpb4OYXbXcDz52Ok2oaXNuR2p6KUICorES9mE3pSIOIZVbHrA+dpsHBI
         /8OuhiCIh+NdJvgh0zzCsMwPSjQK1TE+TJk+8qxNr4sz5wUBSb29H8lSMda6j9GbB8EB
         l/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605401; x=1793210201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ILZGqeePK3tN5s5Fa4xyHKs3r5hIM8Fdn/roa97zOY=;
        b=WWHELi9IT+xEQ1dlHB3fEhyIvo/Hyux6JXmPIpwqtYhklv61vv3+xtsFecxqXwhLQd
         ClHfTv4TwmCNSGcw9djbXVZaoTJ1snXMhv6KxV4io5X5whiklcxpMCEVn7hhsSxfGJdo
         q7DDG7V5RvvlC+O1nPAZq+xy0yWsBRSj5gYe94QSDrwLhjsFew8rt2kYIPNi/mOA26i5
         4Nazdd1rFLJlEZxsjSFAhDaJ/3Q6Bn4WWnWWTvNFfUX93mp2iqvIzpI6Gq7VDPxxiI5v
         JoxuLrSKAJr541a+7smmWBmO/LU0bWxPaHmojgrW92CjbpbDrMYP7Lksr7rhhlJhveWG
         Gv+w==
X-Gm-Message-State: AFq9FYLm+OnoD2uW255+fA7P0SVFQJp5UjmN3M9uvmi5zDsA/UWdCoiy
	4pEkJL4Urca087TEbR5EL+eW7x9wo9JivwlVo46fES2NBxLd6N2tqfhDpWDbju8zfsHVQCrFlz6
	2UJyc9m8vzA==
X-Gm-Gg: AYBFou2WHTN8Vv4JhoQ63bGf1f2EHoKWGMtkEMT08DKVM7FlPIr5GTo9pyBF6fJBjBx
	GKuSi2FKHxVWp5VVVnDrmpLEB36hzG9kLc1Rf7Wm8w8xKbi9kwau+EDp/EUvUE/czlCNoFURStj
	hpooV2Oy5JTZYS/sze/funep0y50fimbuy+9NrNHF75nOPfBN+0Omj2EEhD0OFFKXL1zO2ZLRQc
	alxx93YTadu78e0fwLHeaUrCNnouB1fes3TRLQ5o/61afrHf/GL54TCrPh6LxwOKpYpYhE6jzTu
	uSs2opReKUYpZyObsCkT8FBEYwMrEXlGoDkREpm0FZu7Rp6PvEIqFyEacXn73Lm/zUsmozn5HbQ
	ZXVSw7XbuQHMURoSAXkrdX9S7Kq1Zta2S0v9i1P1jREEscRACt2Hp4iK9HX0nsUKsTnSwM+NSfh
	t1FWz3H82r62iho5P8a441P6nhlXnHJx8Q2gq/o6AX+6kgvb75ev4CwbrQfest0Km0JV3jxlWJv
	cG/pBRrjBgdFO3TD9tHKTr5t9k6YIaukXPjkBVQOj/swCR+o9dUJV3M5c3MP0npekwLqVovAvgW
	annz5k5/noMkyk9dSUEZu6Z56OrUs7e+Fqi20LnGs7irT2YnfmEJ
X-Received: by 2002:a05:7022:928:b0:151:6e80:baa9 with SMTP id a92af1059eb24-190a4ffadbbmr4178212c88.12.1792605401167;
        Wed, 21 Oct 2026 10:56:41 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d0a1sm7736763c88.14.2026.10.21.10.56.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:56:40 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: alison.schofield@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	djbw@kernel.org,
	icheng@nvidia.com,
	iweiny@kernel.org,
	jic23@kernel.org,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com
Subject: [PATCH 6.6.y] cxl/mbox: Clamp mailbox output allocation to the payload size
Date: Wed, 21 Oct 2026 13:56:37 -0400
Message-ID: <20261021175637.1655-1-artem@trailofbits.com>
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

From: Richard Cheng <icheng@nvidia.com>

[ Upstream commit 8a13db9f899d149c3aab24abcb668121cfda5a4f ]

CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
kvzalloc(out.size). A large out.size drives a huge allocation, above
INT_MAX it WARNs and taints, and with panic_on_warn=1 it panics.

The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
to min(out.size, payload_size, device len), so the output buffer is
never written beyond payload_size. Clamp the allocation to payload_size
too, matching the RAW path.

Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Link: https://patch.msgid.link/20260624144147.53997-1-icheng@nvidia.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Assisted-by: LLM
[ Backport to 6.6.y: Use the target mbox and mds objects for the upstream
  output-size clamp. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-93186 to 6.6.y.

The code changes match upstream with the target mailbox object names. See
the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 drivers/cxl/core/mbox.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 059e95e086205a497eb5f6c863a4bfc29c1c16c9..278a11657d8b7516533749bc8c1ce3eb933848cf 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -359,11 +359,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
 		}
 	}
 
-	/* Prepare to handle a full payload for variable sized output */
-	if (out_size == CXL_VARIABLE_PAYLOAD)
-		mbox->size_out = mds->payload_size;
-	else
-		mbox->size_out = out_size;
+	mbox->size_out = min_t(size_t, out_size, mds->payload_size);
 
 	if (mbox->size_out) {
 		mbox->payload_out = kvzalloc(mbox->size_out, GFP_KERNEL);
