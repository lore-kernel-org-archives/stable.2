Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795060091;
	b=Ciro2sPIDqw9rnUNB6DIFkXO20d7PAPv8Fz8jAW6HI3Gzf1Mij7t9wq7BHVmR95KMyw3
	 rA2KYy7be3TyqVqcPh5dF+QHfsyLsSbW9XiYtiopzx0m1JvJDt56/hXgJ22TananD8PY/
	 j7+9VZJPHxSBrfENJVxv7qvY+o4eldxyrELBhyQEeus/kG7CshFxdUd8uqWFCSoCT47G7
	 KosLy+8P+OspEU6nMg1eu1Qv4bSOkljNPJ0qi74gWmydAB+N22g+Vp1zGTTiQCH+n0lxc
	 yXHatxWt0nfVXp1QXTPZ2jE052N9OFUWB6o0p4STYw3NSyLDfec9fppdNRN9JJK3Lwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795060091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S5D8kWPJIdUaQq5yb68+AQ6+c9WqO7R4Em+vte/XbIk=;
	b=DpmweOZ/bO7wdQ1KcXOGs+E3YFa7jybYr5aZw3M6ypWxr4zQjrfC4Zofyc/KUoMZ04WL
	 6qaHXl1WCIQpoKraOvkF1egxTrbUnl5t0pWmlFOWc7ii+ak/JdSD9rBzzyXYPDiprN22Q
	 0L2gJvLffO+QZeTk78aRfI9MEji39jprk4+N208M4EsIZudmJV+uzNW+5M5RDUUz/2sba
	 7SafUaCbCV1xXl+7PtKQ5uyrG8TtsZwTnOKx7aVsDoGe+Yl5Z9XaFpzOJDBIGps9wyLD1
	 pImAtxaQ71TkJgboBkHgGwdorsyd/09GIefVU0fItxm8tikPDcmKp8DT+A5ZVLcZE2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9R2psxl;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3E606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C3E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9R2psxl
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b3b3c072eeso1098775a91.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795060090; x=1795664890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S5D8kWPJIdUaQq5yb68+AQ6+c9WqO7R4Em+vte/XbIk=;
        b=X9R2psxl/Q2649gdnN0PuQFx0A8OsZgJ0zF36kzeEn8A1fSUVc/ZNrRMUYVTDRTkvm
         jbPvHL/++HGajfR+RBB5T4zjK6ZpNxLyUFe9kCR4YfcyLlD3QDZ9Eg6YVPyUzJ4jfrS1
         XVsNfJp+6KfEIy0usrBzX1UBz8w05UWjg526OgPCShxgbLZDEY5Xs7TFNhTASXEg6sCS
         yBPzowEPMiroW64x3VCdt1GwRLVdw6CSAon+0w07S0fwujpCrwqMI3CWl7omXHaOE/TM
         wmQH5wlSMXS7T2o3hRC5aa23/p/N6ekNt6+YiizVQ+JsxMb1aYFD2nQ+VUAJDJmh7GSy
         1OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795060090; x=1795664890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S5D8kWPJIdUaQq5yb68+AQ6+c9WqO7R4Em+vte/XbIk=;
        b=sQGsnZGsIz3G0lNMsFg9+8sVg5Wi4X0mmzF4LkV1WUTm/5A19w+xu/mk4IwhVfq/+9
         pzJN2/WmWeNKa8Okp3la5nH/oj69MI7MPAT+SX3iFYMTMwMmRY5kzWEa97YBsWA6aOhz
         kdGAEgciClPwatbEt+OsCfhl4I6uMd2Rw2i+qObEcZlc/gmaqphCR36pP20CqGDE/AHh
         4pnbuEkM4RQIeDRmJGCw64DP64HfUK11itE5Y04XVaA3cSqd/qXwKmHa1HLkAHSf7fE8
         BFQ8GYHLqsahiSCOAdppm6Qd+/yzntljY4gNwKlsnDtBMFLsSHSYAn6l5GHpmDpRYE/f
         8KbA==
X-Forwarded-Encrypted: i=1; AL+hErGZc0GoF0hGGSrrtcDo5QeoSCG7OMNI8DwGPgl6Er4USue06a3suF/QJIBpA0yi4pmlD4CWVbg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9a8pIshrf+mqmfo0EPtvP7VwMzk239ub5qrTUBClNdLqSxVe+L
	un2Ya8ukKmvStOxGhBIn64joIWMJbaBFLltq3oUYmQ81tPyVkVAIioRv
X-Gm-Gg: AZFdTZeNeCjtSALotFmofqw5r3rgvheGE+vrCOuI+fBbsqehDEHKA8Sbhx7m+S03Zx9
	oOJsHLABZDwotytUZHFgVtgcORvNVYzM235bLVWAalmTAXNibOghV3sfjXrtN9cMcXQJr/RRI5O
	3WcnBWKfdbEcGygjC9FXgyMOQAWU+Y/40PCTZlLjr4Bk/QQWsiTdYXOBskjuKx6FWXpsvhM+sGp
	Jq7jDJ7Irtf68FZF5gSz+6T+RNh179Lx29ibrbibXp/xQ+Q72xUY6u6ig+un/x5wrCQpUI54VsE
	n6dIAv2Qf2DLWCsFD4fWXzS6wCOn5J5EootRGW2CFyAA9RjobbVCAUyhsn8hk0TA9WC8zwL++K4
	sUc8nWJwXEhF/b0doPUqfH+RkZaDP62qRPR9xDBR2xKpzMWZbtGOUN5s0zbEKftdm2uKvYpwCiq
	5dyQd2rc0QBAO5rWqUibPmIE6LP08nr6WZUDXwJeo7lkgGRajKo/1cPnKNEFLaBYh2ekJnE4eMR
	fF8WmSoDTNvxTULGQK7v1I0K1jQuy1ev28obybY2O8lylm+HRWDFGYm95OP+ZD4hBffmxnlf0UY
	Y7gzcQAhsOrqhC8DVcnIWMLX6eqDa5C77fo06HiNzQk2hugR
X-Received: by 2002:a17:90a:d445:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3b3d0686792mr4179890a91.6.1795060089811;
        Wed, 18 Nov 2026 19:48:09 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d629ccsm316045a91.7.2026.11.18.19.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:48:09 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] powerpc/papr_scm: initialise metadata_size before reading it
Date: Thu, 19 Nov 2026 12:47:45 +0900
Message-ID: <20261119034745.1460361-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

papr_scm_probe() reads "ibm,metadata-size" into metadata_size without
checking the return value, and the property is optional, as the comment
right above the call says.  of_property_read_u32() only writes the output
when it can decode a value, so for a device tree without that property
p->metadata_size is set from an uninitialised stack value.

p->metadata_size is the bound for the metadata get/set commands:

	if ((hdr->in_offset + hdr->in_length) > p->metadata_size)

so a garbage value decides which metadata accesses are accepted.
Initialise it to zero, which makes those commands reject every access
when the platform does not advertise a metadata area.

Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/powerpc/platforms/pseries/papr_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 5c3bf06bb59b..e9895e9b070c 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1361,7 +1361,7 @@ static struct notifier_block mce_ue_nb =
 static int papr_scm_probe(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
-	u32 drc_index, metadata_size;
+	u32 drc_index, metadata_size = 0;
 	u64 blocks, block_size;
 	struct papr_scm_priv *p;
 	u8 uuid_raw[UUID_SIZE];
-- 
2.51.0

