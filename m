Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E14B0483
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786752874; cv=none; b=e+97jiY3/PU4QLZiI7JWa5g36y78nfuJsaPQNyT0wIyWoNQJJyVCmj4A/xv6hhyVMn8cl0G6y5wywFAL/S/+dLYMSoSnRv3RMV+bIO4VaUOPdwAltsqGJYFwxRtmPMl8MhsM/wqT3UFTT33d9QT2yFi8f+z1Elf5mujce4KQHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786752874; c=relaxed/simple;
	bh=/Whztue2tCEx1xL3bSqW6ZiMs/a2ovkA84nzHZh9p7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnhliEk4csPhPM9Wb/SGCxv7JuOg/Cu44ZpWmO7r2VeuaI+ED6uTge/3l0M39SYjLkKwvj7l3U38JRcZqWeDOTq0WxxOCQBYUfj4F27grOdqwBGd6E5SU/OiFykTxJxfbPp+WLSMvoU3/0XKLfzzDW1LZ4mkYfoRyZ4gQkGsk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXCo87j/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXCo87j/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1521770f8f.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 17:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786752871; x=1787357671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3FGO108lsW0Q2DmOOQyHg7JpVvYJd0aNzzzQnAbrcaw=;
        b=OXCo87j/ny88pgW8N8VryEhZLTOfH1nL9Nwf68evuBQ9N3R8WuXqfyFPWaciptOEFd
         KyK9b9C0JUP9dlkMo7IbS/GJz4KiFM9/Hcxwv1Jd5UPCDPvUte1JhjIpQ5ftCry97Nay
         QBz96YF047SE/dFmY7JkDxxFQq0ghFXgcSEf8LCSuZ8/w514+dMAIdvYciZGGy/Ww0xb
         kHV0CcVaQXzWlACbEz40nEfokwgEmOWjYGReDEwAjBbyb1sC85ND5ZgfBKWmIkzzpagA
         pfJcEiQOhMWTi6BfG3lFkbc1pQw9g0sZQVwDP96bb2uzljsb842lCr/HhYF1cHufkS71
         wltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786752871; x=1787357671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FGO108lsW0Q2DmOOQyHg7JpVvYJd0aNzzzQnAbrcaw=;
        b=eWGcrv84vo7NzgC+pGsIkSso3Vvo8rDVVejeX6+oW4/msOW2EhZTIpDeOoVVJVll/S
         Ob3JbGafDwYa6g9KGqaS8VAcXJ0lVbWqz8NOcEI+VWfTbeMp3rcLaMWQCSXlHmvg0cdU
         L+9t+sPfxX7eqeHDRXYpw8OuIhhwlCvd0O0RhxDDLh3JYVMeZHg6aROlZ9qM4quxmeVM
         rZ9dyKN3pLKCOvLmZuXPQo3U89rcnDFLjU2S2hnGfYub45i954vfpVjQ/CFM7JiVeMGY
         FZl0/AlZL2MTRhw9Q4FouIrYJaDJ72gv+haMhMREA1QQONJnDz4bznypTfMBcE53/A+i
         GGJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrT1NjDt5gQiyXwUXY6J8U0dtpkAJoC/Yk87hURkIKTotKOkRzaPvR21rsEdcRPPYbqU5CM5Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrU315KBiKkqCMcGJBwB3QGBdeS2/77gOshq41zLvb2J0pveGF
	RyNiY1l7jLgvToKDofBDCgd+zcqNs37zqiOHKzic9xH14FKSC5gbJTg=
X-Gm-Gg: AR+sD12XxtPDyaSIMpuB8AfnRG9j8466xMiRLlL1NCrfNg2vJ9P9AdG2nPkhrABApbp
	acXeXsx/U0WNHKeBDgyX2jJU3LUt3qrD4nHwzO9ytR3DiaTo9e645M9WlN+OLF3UbgGlQoi5B4C
	fmFNFaE2LA1o6JAlC+BMyKM+X/7ehfRVig/fhhxCPGLTyicI3I+hjTotUsDzNCGxQXFl59ftlNi
	joxS+i4D+EIq2266HhrvKNYMavvJ+1DfNZihYQMoyM+hP6zM8l5SQT7MqkyH7CF0sXoihgeV4Uq
	wTtwfHryWrvM45Iy9kLC9pv7ZrNvQVnUsHyWJvpJIkcW6LNoYES1ADPob1d0884wfZKZOxZF4N/
	/C0+PKt0we6CQSAHeZY8VIxyAf0jrBE5j5sAQTUeZ2ZliIiiDKPTLQ3TSi3/va9CYphHEnvQ4Xs
	mFocPL+VuitW+aOVWfSoAOTN2JOOJSST/oSFY15b1LjA==
X-Received: by 2002:a05:6000:4917:b0:47f:8f8f:db74 with SMTP id ffacd0b85a97d-48160714b64mr15386018f8f.12.1786752871267;
        Fri, 14 Aug 2026 17:14:31 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1a91sm11431444f8f.21.2026.08.14.17.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 17:14:28 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] nvme: add missing SRCU grace period in error path
Date: Sat, 15 Aug 2026 00:14:27 +0000
Message-ID: <20260815001427.3148050-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

nvme_alloc_ns() error path at out_unlink_ns removes ns from the
namespace head siblings list with list_del_rcu(&ns->siblings) but
does not wait for SRCU readers before freeing the namespace struct.
Multipath code iterates the head->list under srcu_read_lock() in
nvme_find_path() and nvme_mpath_revalidate_paths(), so a concurrent
reader can still hold a reference to ns when kfree(ns) runs.

The normal removal path in nvme_ns_remove() correctly calls
synchronize_srcu(&ns->head->srcu) after list_del_rcu() to wait for
in-progress readers. Add the same grace period in the error path.

Fixes: ed754e5deeb1 ("nvme: track shared namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd09..0f5f13ce0b438 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4295,6 +4295,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 			last_path = true;
 	}
 	mutex_unlock(&ctrl->subsys->lock);
+
+	/* guarantee not available in head->list */
+	synchronize_srcu(&ns->head->srcu);
 	if (last_path)
 		nvme_put_ns_head(ns->head);
 	nvme_put_ns_head(ns->head);
-- 
2.47.3

