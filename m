Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA744236C
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298798; cv=none; b=FnzAwZtpq5sZtIne+yAGp8oX0TNd2nfBCwsjqgi/BEBj5dapHorp0XNWHNc1Un5CKLQ0cM+3wxNdfX++K5qYYcoLYyMBcULyMUHtDr0E0VrztYOnKIeFMUm+y1Ibyfw0unqeKokmGk/kZf4iLcfKZl8aLSVDL93x0g+RM8jMJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298798; c=relaxed/simple;
	bh=sziN1WTxdrWA0/eaCfdoIvXyznvXx429BIdmYLBm8WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpHnwGOR1TgsOln2gYJGW7mnj7RdcHKUnLm4DoiBYqvQwfcPbfhZ613jxL5Bp97kCXcNiDBgA9afEQzZNRBAzUlgJA9GDFIMqvrOVAZAeMVnb3V/WLr9yQDWH+AsBBHmBdp8OzKkVOxVX7EzU9SjAWTqOF1QaMavpoat0nxiPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=b4itef3C; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="b4itef3C"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90cdebdfe63so2401836d6.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298796; x=1788903596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W5MvV0x1EBsSpklgDw3P0bUHlzoYD1WHBSUfOtcrQ6g=;
        b=b4itef3C81xNUAoW00Iqevzmauh9QMmk2YjuMeajbxeB08/X0OcjIeKX1s0j4adCLA
         vPVZHZFpXvkiE43t9dgP1tsVwsZvoUdp17Ap4bRuFjyizOSF/dipTaFm9TjWx14q1JQF
         Ca3fF/0WY37FT87ebKEdQtScVDwl3tFS2xaOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298796; x=1788903596;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W5MvV0x1EBsSpklgDw3P0bUHlzoYD1WHBSUfOtcrQ6g=;
        b=UcTJnYq3NI+5RmJTWTUClGbnKJers0nx1GYGHMQYHfKIqNo7dwotY8Pk3qJXFrq1Zg
         +DgXnqzZB9v/OzmpUMT1Bb98hdBwKWQaZGA1N3cDrpYbHyfVpwCW2SKPPk1t8vMQPgKk
         l7swkNMO1VCVOcyvbX1/4yWEsOP8eyoi1Qksx80aWn7kjCvaA3OWWpqjWK5b2O/oP23X
         3HI8PHEE+PpmW4cqX/0iZ2uUVv7mJqLFXhOZlCJlEdd1C/3B+2QzXfEXPE0etDDiRE4d
         Ev2YlNkd41sHdczLUG1zMglGNjbGBocz/pfobJ4QIRKpghjpsYJ7WfG+jnFLzQpJiCbr
         fdXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNIXWTKNB4lLTx++JjZbrDPe0zbKZK+zqqObVND/aN+JtUFAh7ftEfk4uu4JZfwvzKZ3iE3Mg=@vger.kernel.org
X-Gm-Message-State: AFuF++mFKz7yF4XoI7nGJRgmLMsNbzMIE79NovcjlXoqpvWCtbp9c1+v
	Tpb3gYFSONc8IaKwxIBeBWZOc73TfzLvQTkBp8dJwvfqtEbm48Tn2+MB25iNrYB5IyWU/yipuAk
	Rjbo/yw==
X-Gm-Gg: AYBFou1cJoj7S+k9t9SMekJPdmJUBNEmebhF3DCWh8bJZB8AZ4ew7g12q452rl7zF+I
	JgEY4fv9lhI+i7PfDYI9ZCVlplYimxPdEawjR1DJ0DQxVTA3JAGh7ms8VIT/X3GkEXFOeiXJ8iE
	Dc52/QbCxTfmALagyyRlDv1PWGuL9yZpDAIXbLGFd8jrA8xeRTAu3QyWBK0kxb3uB/lAEvY6mys
	gaSTCS7EWW9NaVZV45pAwddAq+ghQvvwEg8uh3W5KGUcauXp/BNZ0nK/sR1w0Gj2XKVIrLOFiWS
	YhuQuDZnAm/Z0nlY6QLJ+hCq4LVIKLusmsmk8k2L4LJsultacV7/VKMzlDeEj6Gheu2qBQ+DeI3
	jUrWlIxhNGNo4mUgyauG1A1RI3FYemtBnd7GFZJYHIU0qG28yRvnlUK3XGMmXIZMZK3Y4AjkKZj
	Vk/RFqdArugS/xLBkjWJr+6qa0xRHMCkSMQMJSG0eTL0/d0PQ0HqLj2iPYi14NrScnyhXP3VqfX
	zc5PYJYKq07t0gM0tclsFIR9G0nwlFuEdl0XsRkC0xhd3uQ
X-Received: by 2002:a05:6214:f61:b0:90e:9665:71b9 with SMTP id 6a1803df08f44-90ebafb8dc6mr9465336d6.27.1788298795811;
        Tue, 01 Sep 2026 14:39:55 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:55 -0700 (PDT)
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
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net v3 6/9] net/sched: pie: clamp psched_mtu in pie_drop_early
Date: Tue,  1 Sep 2026 17:39:27 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.7>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pie_drop_early() calls psched_mtu() with no clamp. With mtu=0x80000000
the bytemode divide silently zeroes the drop probability, disabling AQM.
Clamp to [1, 1<<20].

Conditions to recreate the bug:
  CONFIG_NET_SCH_PIE=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root pie
  tc qdisc change dev dummy0 root pie stab data 32768 size_log 15 cell_log 0

Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_pie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index b41f2def2e2c..3b7863ffd284 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -35,7 +35,7 @@ bool pie_drop_early(struct Qdisc *sch, struct pie_params *params,
 {
 	u64 rnd;
 	u64 local_prob = vars->prob;
-	u32 mtu = psched_mtu(qdisc_dev(sch));
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 
 	/* If there is still burst allowance left skip random early drop */
 	if (vars->burst_time > 0)
-- 
2.43.0

