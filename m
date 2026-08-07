Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0959F38F626
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113656; cv=none; b=WqBof9FyD9dKZry4tyruklZnQ6m8vBQnIUxEMIYouFkyki/1aDlTHTWRCs2ndHhiFE8gZwPpNXV8K5LziMLDiIea9pQCKDXiFpB6eVN+INtAPq66wMp/MDi4frNvpgbb/+7b/K+6dEQMs0usetZWFqDPNFRY1/iwc8T9UPjvP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113656; c=relaxed/simple;
	bh=1BKnXr1/MB/NkXRWCaUFR9AAMwMUPnEGjKZQWbfUj4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSE8sqOx1gNHTO+JCcXZ8HrBI+iCnBpVzG7H0DP/3QcTPQTMPnCzv9h9M8bhgyIzIoRhsjshYQflWkAoqivpS/lmLDxiQPgR3ExhiUeN6D3UI5M9TWkOEimNwf2fYh8xAhdDUsotoaFRWdCAVTt4Cb4Wx2s6H/pcRe0M66fVank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFcjkl1q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFcjkl1q"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d049069377so36559085ad.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113636; x=1786718436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcJguZmeHN+kiaiUR9y3o5cAga+xVBYwoL/bbx1DrYw=;
        b=SFcjkl1qgfOns3w0nr+/XbYj03NBnXnnsbuQEGg6rYrgUTtuyORcmUTV3aX3XoTiuT
         +fDhJewSSZaBNyh9G0pohSQEIA19st6qd2lh6UMJthxyQ7Cc4nne0qWrNxpAEEeYpY4H
         6rgdU2iLGxKBvxIyuRs4816CtRm5GbVmSSXkZo6nc6BaPTS5Q6FZbnBdYlaB8naetxKy
         iIls3nsoYkoAUJ4JIfQXtHkAiF62odW/l/BEc4zzOBklmOk0GNkytsBzahuxJC3t0aBU
         nLuvZpJ6tcQ8ummmY3oicRJvQDPpCjBDzp03cf5YVMCCXhgB7wb7H7oWJ+v3Yof2+/EX
         JyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113636; x=1786718436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CcJguZmeHN+kiaiUR9y3o5cAga+xVBYwoL/bbx1DrYw=;
        b=JgOpkxIqaeMmcX3vIM1GEcqb6kcScK77iZA8yquaFO5Cn00SHhl4C15rSv+7y4kVOk
         T39RleJ20uG9Mz6DK9bQjq6Z9YvSFBNh0hSaG4NkjmF5DpWfh2Mc5cVEAeb+l6j+8tP4
         3NmPJGpS6Cr2/qzy+ia8fHiFaDfY7uOvb5jCQiiVTflZTtUszIwUOYDIxTI6NXfpCy8q
         glYzDY2c3a/rlLNQE1Gx/wVLspoMbjLkfNSUVw7wjEQ4p5pXwIcVH+RGPHuyIwFp8DqB
         QA4oLxdVsbXYYk0DYouc2OIEzN1Dc5TL6BvRr2P5vI/kDPQq4b/xbwxR3dK6vI0BYgpN
         HbSg==
X-Forwarded-Encrypted: i=1; AHgh+Rok7GrWcStPEMvEpiJkG/2JVwM4s6Q/oiUekhufMsfOx1PHHwRBnDBcsZD1o/5mXyX/AnSkK0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kzZHv8auDjWcVxKf3EE67vB2ibRho7GNUioC90Fjby8WDDik
	cEkMpcPbRYHto2CJI0tk7IqtU1+arjIknCHH3xry/dRCAecRAyWfcrvj
X-Gm-Gg: AR+sD10gaWx2KxZQyMZ8pQ4MEIK7hKjlIHT2pYCnmzgrSz5LyHwyakTNv5pwyaoerq6
	uMdjKO08YL6r84TSqrwlI+vSsRDEAWOWRatKqyQuJ+wy+45vhIpvCqR0N1MWP6t/lfuIOy6N4po
	r5IGNLWDWE9EjFJ/6f798L3JYzQedrcwXo+BpUAnqqW9DiOcSEorQxk6irErLvFkIowNokX+SQI
	7YGVQFfTB6f+OaYTyvT6FSQbCXPwV4UdtjGgNXlc681wec+n+vZ+g64RkMxwWOLHNdkOFKB8H4B
	9r9ntiOTP4YzQ1rhPmGbXytWka2kolu6IAxCZhvgs6ZbmGzfLd5GuLvGgZuoEueGvliAwzk24s6
	syepQfODeDAt+qJjcPHlK19Rzu9JffhZNr6a/LVLva49AiraPru60zURii2whhYTybQXk/kaLjo
	psgs0KOMdxVED3eR7yVVMwcJUxkzBNwlyiI2Rq3vec/ijfWbBYy+YfUUKFPGiQaiASA7jBo4PMf
	Lq+bsWj49w5mIT0CppurHvmAoSaWECR5pHDfNYOea7PfLD4gzwn8A==
X-Received: by 2002:a17:90a:ec85:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3909d8075eamr10896910a91.7.1786113636367;
        Fri, 07 Aug 2026 07:40:36 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff24b91sm2917026a91.9.2026.08.07.07.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:40:35 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 1/2] platform/x86: ISST: Validate socket ID in clos_assoc ioctl
Date: Fri,  7 Aug 2026 23:40:02 +0900
Message-ID: <20260807144003.3498972-2-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807144003.3498972-1-sammiee5311@gmail.com>
References: <20260807144003.3498972-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isst_if_clos_assoc() validates the user-supplied socket_id with
'socket_id > topology_max_packages()', but isst_common.sst_inst[] is
allocated with topology_max_packages() entries, so the valid index range
is [0, topology_max_packages()).  The '>' comparison lets
socket_id == topology_max_packages() pass and index one entry past the
array.

In addition, isst_common.sst_inst[socket_id] is NULL for an in-range
package that has no bound TPMI SST instance, and the pointer is used
without a NULL check.  Both the out-of-bounds entry and the NULL pointer
are then dereferenced by map_partition_power_domain_id() and the
following power_domain_info access.

Reject socket_id >= topology_max_packages() and a NULL sst_inst, matching
the checks already performed by get_instance().

Fixes: 12a7d2cb811d ("platform/x86: ISST: Add SST-CP support via TPMI")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 24334ae70d82..b2965baeaa36 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -729,7 +729,7 @@ static long isst_if_clos_assoc(void __user *argp)
 		if (copy_from_user(&clos_assoc, ptr, sizeof(clos_assoc)))
 			return -EFAULT;
 
-		if (clos_assoc.socket_id > topology_max_packages())
+		if (clos_assoc.socket_id >= topology_max_packages())
 			return -EINVAL;
 
 		cpu = clos_assoc.logical_cpu;
@@ -747,6 +747,8 @@ static long isst_if_clos_assoc(void __user *argp)
 		pkg_id = clos_assoc.socket_id;
 
 		sst_inst = isst_common.sst_inst[pkg_id];
+		if (!sst_inst)
+			return -EINVAL;
 
 		punit_id = map_partition_power_domain_id(sst_inst, punit_id, &part);
 		if (punit_id < 0)
-- 
2.43.0

