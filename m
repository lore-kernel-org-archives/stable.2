Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619637;
	b=Y9JBtHcY7OHXakWPgIfma/Yxo3XV8LsQawNBjNoyY5RP8GehgHyPna8kezE4ATbdNTaR
	 Ktw3xqVZ8oGTq67QTnfzTMbK540LJGwVigiDxyzIl5fmbKnQl8v429Tk/F81O/vhGLAhl
	 odB4be23nESJY3Cnju0Yhv8Fu4D0FyvX8LqOacZS0Et/rk1XwiF964HuUjZ6Wn0/V4xNX
	 bp2TonEq47pzxccngt8q9Wo0lHsgfEkmXEaht7fNp/4zgz6r9Ifzb1eF61g0pc/e7YUOQ
	 Dg4z3ETbz5aCUFEEWrZX4MCh35L5mrP9tzT9TO+reGoIOg0OomHppOr3HbuPuLoXvSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5smmWE+vGhxqhwgGmPR4F8hVHSCwizeNx+PLtfEMP9Q=;
	b=n+KLX25CU3jgECbBCas4/349iW8lqA25xZAPq4r58+QsZvPkudnj0nF8mzKPj7idz1tx
	 FN5uKYP4tCuvkP8PWrtRfPZzj2hH8qybo3ZgvyW6jisQcd2/rVSIcMnqq2JSyfA2ECn/Q
	 3Aix5k8lXaH3Ot4fMLm7uIHSh72YnZUgSbObSnV9t1vWjc3civ0g7slijNrSSNq8cDtD5
	 mbQdt++l1VzPU8hlYCfosqmXbrrgVnKgQabiagrwB9eNNr3gNKSy9SptVxgOXR/ydXQ77
	 avOQxWBEKTQiiE3UKOBuO/teYbck7xD0Qi9eT/e7qOQTSkXIe5VGNwq40suWEyW1bKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iYrOIihm;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8F60A381A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA8F60A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iYrOIihm
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso16236275ad.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793619636; x=1794224436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5smmWE+vGhxqhwgGmPR4F8hVHSCwizeNx+PLtfEMP9Q=;
        b=iYrOIihmmWOs9SPq4jDKL7HzWHnQCHPuGaIb0AnxDCuAklvQaLIIdwSPfsKbbLikb4
         iVpn1+fae3ccR9Ipe6bW/9aLIbIAV1/jxX5cZRlpT/OT1n/2vZEzNI3ppnTtRdxgqLhT
         NA/IT5jr6Oq3330YAtpTQX8g1euRnlTjJdNUaylITRB8ks9tEzV7IxNqhDng7LF9koWg
         OQ3PhiXWzo38nvLiyO+vUT4vSxLK0anAJko1IRxKv4Ii9vFTmExTZ8jflVfce2kSYyFE
         TCHxubALTrvkXc2hBpFpsG3pIezMuTYBbNMNi9ImFe9wHtMPHKvKQdH+Jq7UteApQJpl
         vErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619636; x=1794224436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5smmWE+vGhxqhwgGmPR4F8hVHSCwizeNx+PLtfEMP9Q=;
        b=BlwE3DsYXGDc2X7FlXXOj72ke4+AwlTXOlUQaRvNl5d8DmOHju4Pn8SHZ0J1MiQ1iH
         4GN/0EUDEcZ5xgmOpxnqpLhfdjwx4DrIzvY5Eb+hZQnBNCG2ELxjwjVGoD5P+gOUKNrH
         oRyvzV876Ait+oL/QESLeqks1FCtaMfi19p0i6lgO0W8mhhS1LkgH0uqWDbIh9efQRX1
         95isAv85nzseN2fJzbEls9+zWwU8jscoxXCoOKkZAsOf9vmudLt09e0CEzNW5GVaGtpx
         kfJxUAIAVcQucI8Uwc66Jq6qzbS+ushyz2npOhFHo8ypGzUXngXS5VKiSFK3gyBEp8k3
         OpJQ==
X-Forwarded-Encrypted: i=1; AKwUvByrDR1Mt63lj0N8HUJI6IXeLQ1zmQX1Lf5HDPK+H+l+PZA5cVQVMQ3W/bzonAWqYUVxgY6qNk8=@vger.kernel.org
X-Gm-Message-State: APuU4Z89SmwTleW43WPCeiBkK/Pd8cGbbGyInR8uisq1vnvog6fcNts7
	lT4SGFkqHGHMXCW/nTKntpoweaSxEdgIfK1fWyUyOvdRfoqXpQLMXU7z
X-Gm-Gg: AYBFou3XYhA3AReSIsIvSL1C+Fn7KV/ZRYFn7Xvwkk+OUavSRgjAHDqh1i7/ZC1elr9
	SIO6q50ITWUsKFPN+VE07F7/cQwgsnPI4Tp+u4QBSp9zXNVI5zLqcuic+AGC7EKn+76UjS147oY
	tvgSt7okuaIkVDMugzh7gsisLAty4BNMxxvTZCH2BaB3tzy7ykl0hUZMBCWVh2FjuhNjXUIxQ1P
	NxlFBVQvLKp1RFyBZ4mP65qOD4WifD3XizVIs8yquNqgrMhKHbHCuEIiKmxnE8ZB1VAJQppJ/58
	99nHDEVfDzD4gSqKJlQvlCVTqhLozyBEgyRzYGDGtuG+qPmbIX2/90wplFuH63RK4uPS1Nyxm1+
	WkbrUcjZ1Dwu4s83vRDdWPWHkxYFKpDyqhhHD8mgZq4q++10QWiqm3S+goMU7YRYCdDnq1bX+tA
	M+3sYqDhofnIiQiygNSOD3DVSaWeikAPeIqSiVDtUk26PFMRzfZr0aHhaO2dt5faaXYu23rfy6S
	kbtuz6tvtsQBNyLlSL6IdGcEIocUSBX5M49vyHOiqe5Xt7A7DwLzre0MwSEgttAx+LbvXFnty7i
	jg/eLz+Sg+AszP85OJ7yAKbVKBw22U3GU9mxoG8RABn+PrPvsyJT1Sr6EaL65Dn6dStF
X-Received: by 2002:a17:902:f607:b0:2e9:a090:dd69 with SMTP id d9443c01a7336-2eb3646e967mr97761995ad.39.1793619636155;
        Mon, 02 Nov 2026 03:40:36 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39262c47sm26652745ad.38.2026.11.02.03.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:40:35 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: mhocko@suse.com
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	penguin-kernel@i-love.sakura.ne.jp,
	tj@kernel.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH] mm: memcontrol: don't miss processes whose leader has exited in OOM scans
Date: Mon,  2 Nov 2026 19:40:29 +0800
Message-ID: <20261102114029.1259655-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auhiGqKJeukk7t3P@tiehlicka>
References: <auhiGqKJeukk7t3P@tiehlicka>
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

Hi Michal,

This is v1. v2 [1] reworked the check, but your questions apply to
both.

On Mon, Nov 02, 2026 at 11:12:42AM +0100, Michal Hocko wrote:
> Is this a desirable/intended behavior? Shouldn't we move the dead leader
> along with the rest?

Userspace sees it too. After writing the PID of such a process to
dst/cgroup.procs:

  src: cgroup.procs = 85       cgroup.threads = (empty)
  dst: cgroup.procs = (empty)  cgroup.threads = 86 87

Moving the leader would fix that, and memcg would then need no change,
as the PROCS walk already returns a dying leader with live threads.
The catch is that the leader has already gone through
cgroup_task_dead() and is still accounted by controllers: pids, for
one, uncharges it through task_css() when it is reaped, so the move
would also have to transfer its pids charge. Tejun, would that be
acceptable in the core?

> Should CSS_TASK_ITER_PROCS iteration see all processes
> regardless leader being alive after or prior the migration?

With the leader moved, it would. Otherwise PROCS would have to pick a
stand-in thread, which is what this patch does inside memcg.

> Shouldn't this be CSS_TASK_ITER_THREADED instead of 0?

No. Walking a memcg css goes over e_csets[memory], which already
includes the csets of threaded descendants, as memory is not a
threaded controller. THREADED also walks each cset's threaded_csets,
so those would be visited twice. It is meant for walks over
cgrp->self, like cgroup.procs. 0 is also what this function used
before f168a9a54ec3.

[1] https://lore.kernel.org/all/20261027144016.2582880-1-zhanxusheng1024@gmail.com/

Thanks,
Zhan Xusheng
