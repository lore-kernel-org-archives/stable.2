Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106D33688F
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702033; cv=none; b=byyYBstDXnbBglEkZzsg8LelySX8NpAoHy/jdsDD2125p0uDItg54RFrrNy16efTWNVQ46EbfdTaRTZT2dhSbGnR+ER5Ej5xK+825hPLJb8a2LrGYM3A+5NRE96YRQnUYWZ93h6cR1PHdKkZletfy/SuUdsq+XqyR19pRgdkU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702033; c=relaxed/simple;
	bh=9BXo/muFLsREaOcPtm/+ElPIDD0Ca1osed8o6Lty7Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGykQ/1FVFtpVqJC2CslXo+4ADReExBAt2vrmNj5pomuFAlmqAjnmWJtp5BEppILe1irEpDOem7SJ6sq7rqbBmKBAqLwiixqirDk62cvYczh/cKZMijxQBz7xhJFOoMpIHNcoUkJAXBYvfrcYOpmFVN1vIZzbNnh3ik8GVxJd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=T6AZlfq5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="T6AZlfq5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955c545a94so1049095e9.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786702014; x=1787306814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rBAAcpNzItcmNm+Og1GwywYIYMTncgOOfv1e2DSsL8=;
        b=T6AZlfq5nFjLWhOSFvJsxjW4OXxPJqj1b8y3pR7WLHVwOUePMvs3h+xaXf9oPo00Op
         vcKaHSKcOL4GMB3m6XAm2lgvUpUXMkUS7opbfpblwSJfFUSbdqbKf9q8/ROo2uCmZcgz
         jLY22Zg6k/xPRGrNmMNyDbgkfNtAjt/KZLBz497uJYhWQOSh6kIbO6Kb2JqJXmGN0R6H
         m2cZy9x3F4ryh2SKLIi+i7ntBTF/KrX8OTDFgxvhztqPwpzrQ4NLwh08t9IUCp7w+vO9
         8rwBHA8ryhnirJxIR7QnwjqaRgrJjaEEL/c+l/03XUZ2ck82X3ppgYrU9wS9YUJXQto6
         ivnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702014; x=1787306814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rBAAcpNzItcmNm+Og1GwywYIYMTncgOOfv1e2DSsL8=;
        b=lY1rH4fC0Emn2lI1T7zw7D0FAEd0xg/3x0IcduzsSTGP/HxvL9xA66KO8lq+Xlmary
         p4i1jIf1O1WKAwG6TOnUQXj3AzvTp/LFHwiLRViyXrbN/QNv9IP5R347u6m7TNJO9BZ2
         H2XJQHC1HzP59hRCGKwTm2Lf94UAgZzLUAIIrzLN0VHV10eVVp2JX7/EM3LH8H62CRRi
         PWxZ4bfdCSi7/R7xSqBWG+LHst6hjFqDi4bHGhY3CuWSX63pC+3VJ+fT1nhbsxKYufpW
         uQbiyTQINYI8dESfX0JS8zLLSuZ9T+MU1LoeAjdCgR66wqFXy3+XRz7kApeavLRwalXX
         rbMg==
X-Forwarded-Encrypted: i=1; AHgh+RrcTIJEAjnBOYVtnQrZOD9ZHLXDHYczEXb3H5etW6wsOkhtQR1850MQHgkmVOuCVNWwgVHmKuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDqQH8+2MsMRL0RNaThmGCu3se+nBxqBG2td2V2+c5sSyaGKN
	KHtDLDVO7cYad+EU81XjFC2UjRFlVivH1JVMtYBTnFRisWc3JteBp0oXmd+dVyf+TT0=
X-Gm-Gg: AR+sD13xrtCtLAeVssgV5jvzvDg3AENVrzqU71KaDqXfwuH3NXLZ1prkGw5x/IL2r8W
	iHAfCEpmqQ9MN3GcWbpFO08XKyOBlsyS6NZyux5b4BZTXT4kFJae78oggyYkUB7BkATC/Vgt30L
	gqZPiVmAa48ttC6LburqtQ8lEzffOQHrQh+HsQBLMPIcGimGvf0iUai4NZR/1T3vVjfHjKTp5Sm
	COwl2LsETvkSI/ejMbTirLFHWOXAhwn8n5bVUEETE7s4FYtwoqSh5O2kJkuuGieMEvWvdiWtBqw
	Hu/7Vka5DYmvKpGtDrF8ybUYEKbk9TX8sSTJYthxKVZoqht56qZrJyPCIT+evUXKNfxBkuTZ7s1
	fjiL5J85nXYj7ZM5cZsjd4kMWwU3HgCdJcQWiHn35of62J9dszuHanCYwdh8GavlWfk7hplui+B
	liYJoNp6fRchzqBjcXRCZ2L22jKSi46UlSPYmL5s7GTGA5VOkKa6+3k5kTYr9gxcAZKfGY4I6Xx
	sV68h19CkgHSBN9Vu/6xOmvrBw+Vr4TQLbN
X-Received: by 2002:a05:600c:8b57:b0:499:8411:9e8d with SMTP id 5b1f17b1804b1-499878cb099mr33019185e9.0.1786702014071;
        Fri, 14 Aug 2026 03:06:54 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net ([2001:9e8:144c:bd00:56c3:670b:dfc6:d046])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm6948207f8f.24.2026.08.14.03.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:06:53 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: dmitrii.omelchenko@cloud.ionos.com,
	Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 6.12.y 0/4] crypto: ccp, KVM: SVM - missing SEV/SNP platform-init dependency + 2 bugfixes
Date: Fri, 14 Aug 2026 12:02:53 +0200
Message-ID: <20260814100652.225499-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Hello Greg, hello Sasha

Backport of 4 upstream commits to 6.12.y (applies on stable-rc
queue/6.12), Option 3 of stable-kernel-rules.rst (no Cc: stable tag
upstream).

Patches 1-2 are the missing dependencies of commit 3f8f0133a5fc
("crypto: ccp - Move SEV/SNP Platform initialization to KVM"), already
queued as of 6.12.97 (bb1c8464702540 on queue/6.12). That commit
dropped SEV/SNP platform init from the CCP driver's probe path,
expecting KVM to take over, but the counterpart commits that give KVM
that responsibility were never queued alongside it. Net effect:
6.12.97+ has no code path left that initializes SEV/SNP, so starting a
SEV-SNP guest crashes the host.

1) crypto: ccp - Add new SEV/SNP platform shutdown API
   Upstream f7b86e0e75bc234751cb7a82d888083a57ef28b2

2) KVM: SVM: Add support to initialize SEV/SNP functionality in KVM
   Upstream 6f1d5a3513c2370bbd6115dd430906bc2f4bdc53

Patches 3-4 are unrelated, independent bugfixes:

3) crypto: ccp - Fix checks for SNP_VLEK_LOAD input buffer length
   Upstream ed53a5050f42a3243a7ed8dfa49030e54034b952
   Context deviation: 6.12.y lacks the SEV_CMD_SNP_FEATURE_INFO case
   the upstream hunk anchors on (added later, not queued here), so
   the new case was placed after SEV_CMD_SNP_COMMIT instead. No
   functional difference; noted as [Jack: ...] in the commit.

4) crypto: ccp - Abort doing SEV INIT if SNP INIT fails
   Upstream 6131e119f5799bec55535530fa2fc44f5c7be1f1
   Fixes SEV INIT succeeding to be issued (and failing) even when SNP
   host support is enabled and SNP_INIT(_EX) hasn't succeeded.

Patches 1, 2 and 4 applied clean; only patch 3 needed the context
adjustment above. Please consider queue them for future release.

Thanks,
Jack Wang @ IONOS Cloud

Ashish Kalra (3):
  crypto: ccp - Add new SEV/SNP platform shutdown API
  KVM: SVM: Add support to initialize SEV/SNP functionality in KVM
  crypto: ccp - Abort doing SEV INIT if SNP INIT fails

Michael Roth (1):
  crypto: ccp - Fix checks for SNP_VLEK_LOAD input buffer length

 arch/x86/kvm/svm/sev.c       | 12 ++++++++++++
 drivers/crypto/ccp/sev-dev.c | 17 ++++++++++++-----
 include/linux/psp-sev.h      |  3 +++
 3 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.43.0

