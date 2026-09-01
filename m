Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6DD38C42F
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298787; cv=none; b=C0l8EZs9F14pbSEbW9BkE3uFpZ3Z7/RE/413CqBuNb1ypEZtS2lbmV5bbYWYkJPXgWcglDANqPnGOOYbJnsj2K2AJLcDMwVm49OWmNXglldf8NKaS6MCQhLEctnd7Q/cLABjjsRNfGVLm11nysbTK2U1T80W2TNdhP9aRWiqR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298787; c=relaxed/simple;
	bh=G+JjWQQ1tgd6npjQ9GEGcrac5ZKqPWDiAdAriHjhwEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f5zv8rnq/LbowSKp4leXRh1XHBZlh/Kt/xZ6fLfF6C/uq8kJVTdQ2awtdbxtxjyAVdyPW8jBz+OUZdzd6fZf41JZHKl82I41orZTJ1CeHcvzNPgHzbyO7B8tarv/mas67A+3oxVOKJiMEXW5L/8WnYzLpBftSkzxExCk1ZWlJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Cm5wgqwj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Cm5wgqwj"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90ccbed6edcso5494726d6.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298785; x=1788903585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7HTmDoLr2gVrR4KXlsYIyT7LORLTTblGYb6jNqqivbo=;
        b=Cm5wgqwjfJJyvnZe+/9DpjstdFgSkV7OkhEiInrL9QG/f3A4Gr/ZcEt5EspUKCQ/ME
         OTKVNosykpazTVXQLjum15f8I3fBP/SvuijwM0eylY4sWam9A7wHnKjo+ywTg6ycDlzO
         0Pr9ySVUJ6F6ZgXI+duK4nUspRMAfmIOd0IBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298785; x=1788903585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7HTmDoLr2gVrR4KXlsYIyT7LORLTTblGYb6jNqqivbo=;
        b=QByugg/geMsJgTy+YkMn4CXII4/oyT38qfmHuafivqAVqchwYGp4BBLgyYHvxWTlQv
         nYYVt21J3YzJ9km4FPQampqqzG2K1inmCRP1Gtu/cKSyzMpi/NgtY4nwPRATgy1cFqJS
         kVVF760z9rWBkJNoVwLsmPz2Fh11ymtOwQC07vhIwSJ0Jzyl4piwEZH6YI4PGNbMXck/
         kdmOvQcVnjgQgpsTTberw9aM/MjoKO9NExLeYx/GXbkPTTvh0OWrXpGldwLIeDnG3Qi2
         e45BT5/oRSsnyc3Q6YmEB8k24UccWF7O3DdIamDJZZ1XQ124OLnSTTlGRU7ovOanO+VE
         PTBg==
X-Forwarded-Encrypted: i=1; AHgh+RrLiNrkEfsbKys/3tlJ9DZ7siUQCWKYIjbrqzaA7O+zdtRw5Vahkyvvox4z/odfGrezhFsbK0w=@vger.kernel.org
X-Gm-Message-State: AFuF++mXYQg/Txsjlt12u9pz/fQ6+X94mKpCQb6Ix+8sQostxPEfPHSW
	ow/DxXfW7gCPd+22/GvC6eHdkAY5Rz5Fdx+9uKLkI58btr0izslieBSS+yg58twxhg==
X-Gm-Gg: AR+sD10SJXxifQvtRmNw8lxAeT5RQ9fdQ44N3JGG0uo8Ces1fEAJ4n1vWdhnJyXjBMJ
	xWzJu8BD35XM4nzLbnnsfRZv/MrjrPJ4aMORcnmtw2OcCS5/iyI1GkvXc+6H4m+UJHJFY07odin
	3QYDPFQspv+tJMOavS63hL27AgVJWGdW1fBITLttYGHDwXcmnE06jozQe+Xn2pilpiUQrOll3l/
	c7V9zmskXchnyHQGQQjSgUqAKe5AmX8PLONDDYfdHqIk6iRwADgxMcM06plafM0hH7OHGzAIhpL
	xlvDXovX4JevLMVSeitkWBm0jjKb0Dj9xbTOCgcy8n7xmmms/8dmsapi1t2mFBZhL8jthDaOvp9
	7exNdg/4Ws41Sa2I3x7o/TtefJifm4Qod/a1LVHEGn0zVudstxncwt7cbFpQ+k8CPC8OQ5SAMfH
	RwXDJDCis54PF0LGq6BJKYTQKg4z9P+WDYv94CASpHhkihLiYroIPkcZ+pN4ydbUQ6kY4sLrhYk
	9FUL0Ipb8vGa2tVJKyrsLh5Jn4XUuX3LTKft4k=
X-Received: by 2002:a05:6214:5298:b0:90e:7cee:3c84 with SMTP id 6a1803df08f44-90eca3a9527mr9787726d6.28.1788298784953;
        Tue, 01 Sep 2026 14:39:44 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:43 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net v3 0/9] net/sched: clamp quantum/psched_mtu in change paths
Date: Tue,  1 Sep 2026 17:39:21 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a followup to commit 709f34f7c28d ("net/sched: fq: add overflow
bounds to quantum and initial quantum").

The quantum_backlog_overflow series and the five siblings that followed
clamped the init-path quantum in fq, fq_codel, fq_pie, hhf, sfq. The
change() paths were not clamped but it is the same pattern, same writer
of q->quantum, same privilege level (CAP_NET_ADMIN in a user namespace).
A user can override the init clamp via tc qdisc change, restoring the
small-quantum deficit spin that the init clamp was meant to prevent.

This series also covers two siblings that were missed entirely by the
original series: sch_dualpi2 and sch_pie call psched_mtu() without any
clamp at all. With a crafted size table qdisc_pkt_len reaches ~2 GiB,
so quantum=1 (or a zero psched_mtu on a headerless device) makes the
deficit-refill loop spin ~2^31 times under the qdisc lock (a soft
lockup / denial of service).

Each patch fixes one qdisc with its own Fixes: tag so they can be
backported independently - the commits they fix shift differently in
the git tree.

Patch 1: fq - clamp TCA_FQ_QUANTUM and TCA_FQ_INITIAL_QUANTUM in change
Patch 2: fq_pie - clamp quantum in change path
Patch 3: sfq - clamp quantum and reject > 1<<20 in change path
Patch 4: hhf - clamp quantum in change and init paths
Patch 5: dualpi2 - clamp psched_mtu at all 3 call sites
Patch 6: pie - clamp psched_mtu in pie_drop_early
Patch 7: drr - clamp quantum in change class
Patch 8: ets - clamp quantum in parse and fallback paths
Patch 9: selftests - update ETS test 41f5 for clamped quanta

Conditions to recreate (applies to all): create the qdisc, then
tc qdisc change ... quantum 1 with a STAB size table inflating
qdisc_pkt_len. Requires CAP_NET_ADMIN in a user namespace (unshare -Urn).

Sashiko links:
- v1: https://sashiko.dev/#/patchset/20260826074056.7873-1-jhs@mojatatu.com
- v2: https://sashiko.dev/#/patchset/20260829081229.81708-1-jhs@mojatatu.com

v2 -> v3:
- Add patch 9/9: update tdc case 41f5 (ETS offload quanta wrap test) -
  the [256, 1<<20] clamp in ets_quantum_parse() rejects/normalises the
  wrapping quanta 41f5 asserts verbatim, so the tc executor run failed
  (Jakub). 41f5 now matches the clamped values (quanta 1048576 256 256)
  and its name reflects the new behavior.
- No kernel-code changes; patches 1-8 are identical to v2.

v1 -> v2:
- Split the single monolithic patch into 8 per-qdisc patches, each with
  its own Fixes: tag, so stable backports can cherry-pick individually.
- Add cover letter.
- ETS: move 256 floor into ets_quantum_parse() so explicit quanta are
  clamped, not just the fallback path (Sashiko gemini + nipa gpt-5-6-sol-1-7).
- DRR: add upper bound clamp_t(u32, quantum, 256, 1<<20) matching sfq
  (Sashiko nipa gpt-5-6-sol-3-19).
- ETS: add upper bound clamp in ets_quantum_parse() and fallback path.
- sch_fq: add 256 floor in fq_change() for TCA_FQ_QUANTUM and clamp
  fq_init() quantum to [256, 1<<20] for tiny-MTU devices
  (Sashiko gemini + nipa main-1-1).
- hhf: clamp hhf_init() to [256, 1<<20] matching siblings
  (Sashiko gemini + nipa gpt-5-6-sol-6-24).
- Add Fixes: dcc68b4d8084 for ETS (Sashiko nipa gpt-5-6-sol-1-8).
- Re-add Toke's Reviewed-by from v1 (kept since v2 only splits the patch,
  the code Toke reviewed is unchanged in approach).

Jamal Hadi Salim (9):
  net/sched: fq: clamp quantum and initial_quantum in change path
  net/sched: fq_pie: clamp quantum in change path
  net/sched: sfq: clamp quantum in change path
  net/sched: hhf: clamp quantum in change and init paths
  net/sched: dualpi2: clamp psched_mtu at all call sites
  net/sched: pie: clamp psched_mtu in pie_drop_early
  net/sched: drr: clamp quantum in change class
  net/sched: ets: clamp quantum in parse and fallback paths
  selftests: tc-testing: update ETS test 41f5 for clamped quanta

