Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DF3E6399
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106248; cv=none; b=ivG5V37lo3h4ph6ctj0Xeq0vyCyfNi9n3XvE+rKY98LLby6ZjOJH8q725oi8UgBqGdpSQeGbY3UKi/n8HgtAYIH5vAy9sZlLO8vVbHuMJVv5SBxFZylnrk7Ix/3L5K3gqzyUO09pJxnm0CFboiOc2vnVGZEGoPUeIQqg0RNAWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106248; c=relaxed/simple;
	bh=QtZuuTXeL7qNONG+T6jPjUHti24E2NJ208VyfSfoXUo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nFbCk+Bhn+x13P6AtoK3EKMkof2RIgFjpqQumJaWYCaQYUYVK7gdABmGH4ZhGZR2SPd2rbU+S4a77TsMCuBOKnpGfqiS13YhVpdhlHlvcnj8fxU+O/fJ8yvpF9jtLSzbg0prb4SRzYjnNPbpJhUlQ5gblewVgdStqkwO2GknNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGax7jb5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGax7jb5"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493e9ea2c77so42312995e9.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784106241; x=1784711041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IDIP0De1XSMLmGN2HWgFiSuT2CRNSpjj0NqoKtySel0=;
        b=tGax7jb5W/EsfKztXgXjZYq+KuIrfZSgjvQw/Lq2AbPRdvB8Jpah3jM4NGdYV/WnBD
         D00jdWc5pT7QwROQsyC36PYV3e+qXYhSHnSa8jJGO/V+6akplHEeTssdPhGpgsn2JmUJ
         8WeHzyrSwRPzusYIrOn4kFk924Ha5oi+zTkgYg5SVm8AlVX30QRNWbwT9jCfdoopqewT
         GJi6TgRTpeN8mFDpwnnl+rKLOmrxpue/tQE5P6Ux4Gq1Ju2yqWCWDfRuWeE0D2xJdAqJ
         agWyTZyDDQDOjEyLk7G6Nu3hKWkLT3yucHyMlio1/FqkaGUIU808IcaOlTIiax9vafal
         PkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106241; x=1784711041;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IDIP0De1XSMLmGN2HWgFiSuT2CRNSpjj0NqoKtySel0=;
        b=l0UqHtw8tarUfp+oqWJIiuKY7rQenjwajxWLMleyfnJhSB8UlhRVK2AqfIxgUK8039
         syctmjOXWqyGV98z3dlH0Kob6qcFLiXk2nnywyxDAGBwmIHelb6O+tbTAvo63dIXmzIK
         Utm1jQSB3T89qc6nmxvLely3U7KehSkvyS4/EmIkT3WCmRMCGTQKeICPGCYzyPiuTqu+
         F6UX6Uaa1l7ioVXGhbqga9jR4tPjQ4mg1niIdCIORjSwVaNoyvpV3vyhMOWPz/Omf6pE
         sVV2FQntyyoMooVy+UeJMBUNve9bIwH9h5mKuztoYqtFcSNP1Lw4knRZwheInTqmMK7D
         v+8A==
X-Forwarded-Encrypted: i=1; AHgh+RqqHCx0tumx6JjJylS6mMO2oN7sHBrWoYttdcp5fOuTg4W4u3UEF9QhYs/reeQ6NopHqJ8oK8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Y126XvliwvCuGoMM0wKhcWZiH2IbImUauUp+AveEdrpK4zPs
	kcwc9PH1TUT+oADXEpHy5ubuLbgt0w8Zx6QztHMO93cZccW92LHKBzbmLB/QzMymVvMg+h0Y6RC
	RniILP2tKUch0VQ==
X-Received: from wmbh17.prod.google.com ([2002:a05:600c:a111:b0:493:ad14:710b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1507:b0:493:9b02:484c with SMTP id 5b1f17b1804b1-4953c289549mr13387055e9.29.1784106241314;
 Wed, 15 Jul 2026 02:04:01 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:03:57 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP1MV2oC/yWMSwqDQBAFryK9TsOMEX9XCS500monMiPTGgLi3
 W1186B4VG0gFJkE6mSDSD8WDl7BPhJwY+sHQn4rQ2rS3BQ2w3aagkMfdL/Y858E6WlyW5qs7Ko KVJwjXYd6r+ZmWbsPueUswb4fl4/FI3YAAAA=
X-Change-Id: 20260714-alloc-nolock-fixes-e30618048b99
X-Mailer: b4 0.15.2
Message-ID: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
Subject: [PATCH 0/2] mm/page_alloc: fixes for free_pages_nolock() on RT/UP
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="utf-8"

First patch was originally part of a different series but Andrew asked
for it to be separate:
https://lore.kernel.org/all/20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org/

Pre-existing bugs found by Sashiko during review of this other series:
https://lore.kernel.org/all/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com/

I have not reproduced these bugs, and I suspect there is no real-world
user that is affected by them.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (2):
      mm/page_alloc: don't spin_trylock() in NMI on UP
      mm/page_alloc: don't spin_trylock() when disallowed in free_one_page()

 mm/page_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
---
base-commit: 83c85fdab41ef98198bdbd731cebc9a15a185dcc
change-id: 20260714-alloc-nolock-fixes-e30618048b99

Best regards,
--  
Brendan Jackman <jackmanb@google.com>

