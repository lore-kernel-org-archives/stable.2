Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5F2F7EF2
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443559; cv=pass; b=mreYB2JKidjTBRKC1mQdTdM4FhXujvg+Mhx+GVGwc63T+1YICMkhJOypzrCTRepf+P8WlXtbR7OVwb0IwhhDl4SvATytd5Q3QoShzo+Eqmnl83FPgHY0yvp7Lwqs1YiYY0Yazfx4u/D6y9cBThzkMTiByoZopRboHr1cWgFvE4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443559; c=relaxed/simple;
	bh=8a8z9o8uhQwn072Nwdwrsu8F50f0ae0l8EpJfnSe8Zs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7CkWP2FOX6zFRqPoyQ00ytbT7ubZPl50jwlAsDSXRGwgLVGkGgtbV0d+X2rAkGvYyJD0e7RrAr2zAuymPqRxAw7HolzhL9w/CVv2qxLL+FDkzAs9sWCNYMZnOoAOcp/vxJYgABrYcTz51UcWdSqg1gtgMqOBTPUPD+bSO6fcUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=s3ZdgQ0j; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="s3ZdgQ0j"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e86d46b02dso25741447b3.3
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 06:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781443557; cv=none;
        d=google.com; s=arc-20240605;
        b=eH1gxjtK8G/nwa4UJ8HOL1HLGK8ADE6TT02u6ijliIgYoj+Z0PZWtiLPrQ06Qw+NWx
         i+KfaR4wAelWOh2nL6wJljwqjG/4SDJJGqw+leRmJq/B9kPPyT3HBL/m0kUUWNg+1LWI
         PRytBDk1OSETZqwDQL3AvUG2tYQJUR/UaS6JYQ1ms/RxBdi5+5teDMw4fPaUXw42yz65
         GEJU9s1tVvPqUx/15PdoG5muWJ1hQdZi3OUbvmYw2VYP5FEobM6KDPOLr/yrmrfB1J1P
         2T2wlkK9qbOj9JSCs5Hl1CjNrXzKHfnoPc4cEP1xsMN+edLQa39t8lLWejfzvRiHpTRd
         m+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=my7WznhvuaINq07i0eln+93EnzFiKa95Z+VUna30ulc=;
        fh=9iU1PycPfPGbvpVX8z/siv35/GTBBfVqRdgSTgmgwW8=;
        b=FrWVDWexE/OZXrEplCTpDKvx/oUG7xEQRH1G5QaydIfgLKVTAOxaO8VadOIobSyiJ+
         DYcHjvNdjxDf8t4HTpEXWWvbeBjotjw45XnKa1yLWJPKGvDm64cb7qE3wRA3KmWwzt38
         47+Iy6PX1E3ljZebfGi9zhOlpaj2rz7dCX66g2TkBl65yhoKrXWQRxzR9H3cpADP5Lec
         IiRclHCgEaqgnnuLZcfgZdu1wCxnFRm3R/quF6mHHUCs6lMONtmb+T0FU1JW1zpJf0ig
         ZHaUnhXP01f9DaQzFtOz0qZBommiO1jOyH7nmbhcndqBd5sB50UypDAjtAHz+RbRH9vQ
         NuHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1781443557; x=1782048357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=my7WznhvuaINq07i0eln+93EnzFiKa95Z+VUna30ulc=;
        b=s3ZdgQ0j6wdDyJK+1d22+jBZLt2LhR2Mi8jqPQ3z/isAwctf3ViXA56e3N8khKKhww
         vmnVZeVAW1wDeL+KZtU2URDcwHYxTdvDKj7dQAg2rIz9I+oy4ubfKlsNI32QZ+LDw4Oe
         qW7GQAFqe+cJvP/0VHfPgrO58FSi8UglgtTFX9H9cSpSqkzpIwpgD4WzFLBDKHVkuTAe
         bKPdX19pyf2uEXOILG62k3EUQwNZ+3JbH4EA72HLdrw6dba8fYV0Vaemkuy56hwM0oWI
         FG1mbyrtkMB8CbtPKlmsvp7y845jcXXgqpVuTaB9qMLiIVdu5T9KBNz8Tat5V81a9/KG
         LwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443557; x=1782048357;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=my7WznhvuaINq07i0eln+93EnzFiKa95Z+VUna30ulc=;
        b=DJQ/Z0TLg0OOJI+S4v6JTG5gu1KXGk2UAYGEJ1jfXqiiuLMzOObPt8acaVX2aZUcdO
         JDLlJQDlmwHxKJ0bTejvG7O5kurqBGNW2kbkKxg7oYmFKV3It1CY/sortF9lSCqSCs3f
         B8CGuYKMPsg0aHFMPB9/28THQUmbPdatCQxhViexsDnWnuVw0Nm7FMqHagK1LHv+HP/2
         ytLWiiYn1MKykrHi66iWJCOpRhbvw9Ij5dBv0UHmey0pESrnk7dIRoQtBTYRRbkoCc6a
         fiTLi76KQXpVuGmbMaxHYxCC2oybvxFQBMZQZcbRRM2F8idPwXCf+oZnq4e0MUyx+EG4
         6z0A==
X-Forwarded-Encrypted: i=1; AFNElJ9bgtVoeNZWju3yJTTa4RuXbF8cNK5w2A5gX1xl1P8tcjzVQMywcui8j2FkjZ0bUdr0NV+VTMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2c83nVpCqziaZC9p4bl41xy4sSUQlF8og9YWVevG00/p0uXsf
	6KepiHA8WgWSLQC7E6+3sC6XaPZ+IcY4jrrY6pF0AEwWNmdMC6U3jqSvYcIWfGDsQeDgDBLN/g5
	kYsm7uXStDoslm55DeMPK+b+G/U2Z+tqq/YOLB8VZ
X-Gm-Gg: Acq92OG2Is1k7ykQG1FTmxb/Q89B/aBuHn964mOiNn6QBJ+jDFC+dodE6b6qUSbo26P
	h7uNPC1RC5l6fDXL4eW4sa7x7Nr+33U91cTasoFIGi4zZltrBU0iW2m2C3igsxE1/hzl8Kdr+Qt
	NGLIZ0nhHB29d6yK34QHbWY9nmrEyOEzUPlaAiTCDflSlRId6px1JBSAQ8xeXE85kPUcUiiIE5P
	mu5K/Ln/ia45IvB14rsJz8P6e4napSuojNgppx17mkl6ub6m0pculBvc49ZbI3nv2IBFv3lh9N+
	r3dK7gd7CQ==
X-Received: by 2002:a05:690c:3745:b0:7e2:a956:4083 with SMTP id
 00721157ae682-7f8c1f15742mr70603597b3.20.1781443555816; Sun, 14 Jun 2026
 06:25:55 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 14 Jun 2026 06:25:55 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 14 Jun 2026 06:25:55 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
References: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 14 Jun 2026 06:25:55 -0700
X-Gm-Features: AVVi8CdOyddTc0VCwydJ03Yt1oOOOGpiCzbsY_HpVqvtkDz1Xj3Bl7yujHIBV_M
Message-ID: <CA+0ovCgfHJHv5d1mzapWWvF-LhjppzDX8NPPLvCPZxPKg8RiYw@mail.gmail.com>
Subject: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed
To: Andrew Morton <akpm@linux-foundation.org>, Waiman Long <longman@redhat.com>
Cc: Farhad Alemi <falemi@asu.edu>, David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Yury Norov <ynorov@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Creating a child cpuset where cpuset.mems is never set leads to a div/0
when a VMA mempolicy with MPOL_F_RELATIVE_NODES rebinds in response to a
CPU hotplug event.

Reproduction steps:
 1) Create a cgroup w/ cpuset controls (do not set cpuset.mems)
 2) Move the task into the child cpuset
 3) Create a VMA mempolicy for that task with MPOL_F_RELATIVE_NODES
 4) unplug and hotplug a cpu
      echo 0 > /sys/devices/system/cpu/cpu1/online
      echo 1 > /sys/devices/system/cpu/cpu1/online
 5) mempolicy rebind does a div/0 in mpol_relative_nodemask on the
    call to __nodes_fold()

The cpuset code passes (cs->mems_allowed) which is not guaranteed to have
nodes to the rebind routine.  Use cs->effective_mems instead, which is
guaranteed to have a non-empty nodemask.

Link: https://lore.kernel.org/linux-mm/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
Link: https://lore.kernel.org/all/CA+0ovCiEz6SP_sn3kN4Tb+_oC=eHMXy_Ffj=usV3wREdQrUtww@mail.gmail.com/
Fixes: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}")
Suggested-by: Gregory Price <gourry@gourry.net>
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: stable@vger.kernel.org
---
v2: rebind to cs->effective_mems instead of newmems (Waiman Long);
    condense the changelog.

 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2649,7 +2649,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)

 		migrate = is_memory_migrate(cs);

-		mpol_rebind_mm(mm, &cs->mems_allowed);
+		mpol_rebind_mm(mm, &cs->effective_mems);
 		if (migrate)
 			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
 		else
-- 
2.43.0
