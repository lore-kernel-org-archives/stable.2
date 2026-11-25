Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573682;
	b=rxq3HdoO6sSoIpdr2Lh7X9i2QE7Uc1Va+qVCW1i6bPcJ2lEv/E0YGzzPBSXC41Gchq/f
	 UTpNSA0fOvGuJlJmAFgnbnbaqjCysuhDlT6Nh3es4X6jcq9loZr66Rse0HBRRSR4pQ1C7
	 RBzHs9mShrY6ZS0St9IBo/dwJhmxsVYR2BRZvMfaH7jzuyBFLuJf2TKfBTRGXwtoe40Y9
	 wYD6CiSCYawaeqS+0SExf16HVyh4yEi7Ayk041CWeiszaXFR4uUAKZDdP+cdz75jzeqCY
	 v0ku/btDkH8Uo2pWF8sjR8z+uz0oiViVQvlGleay1/azmwDzmp9aHHxsWi0gVpNMWAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gDxnzLaRy14zxoKiwsBabewsAmx6hWXhtiUNmVzNEZA=;
	b=E6aQ8i3yYmAD9LLYT3eF83QkOyypJqI8o3KmAAmJesNZQUwvm7O4//kjKH5wk2RLoLm6
	 Y0sEy7rwEJKMeFSgupBUsEIiyHg6zgPXDc7XegwLRbC2LaiTacK2ChAvx7i9A1LIPtEu8
	 Q723RtqUzE8bgjGoX3A0PhOSp8fPGDUnJRk4qamJmZxtlqcXdUhwtYPmf1EXWMKYjZby2
	 6OgZRnEplhr04yOus72K/s7tVwiBh/krlvp/PhayxM6JfDGmFk05IET+L8cFy0Tl8PVw0
	 x7seDqR7XoPx8JhfoB8/dMezZBqFfT4ePklMD9ZI73eqJLnMHdERsBjCkqGTuWItAAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZyrnBWX0;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5AE606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED5AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZyrnBWX0
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so2598489b3a.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795573681; x=1796178481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gDxnzLaRy14zxoKiwsBabewsAmx6hWXhtiUNmVzNEZA=;
        b=ZyrnBWX0ttgzqFgq0xyQTuGRtOjZfjiHXe7hGWHPPsV+Kxlj403bCAD+K6BtmeRdz0
         8nwOVbBI0bUqV8TTQj8GVoSEJZhq0rJlxVkbdavpA1pQTfIMgr+MoIsyRXh9721bGn2B
         p3/TaY9rLLqxym8n1Wv3nMfXOSxtjRy3O48e6LCg5at1b0dLYw08k3vDNX4ISE37ZgCa
         l7KhkJvcubBSG/XzOQa/3fEY2adfT0GGR4b+FPxYctlo+nV8SgvcJUQNhYhAEeY7I7j7
         2wf+tx1KWOLH6DEeOhCkj5m7iCvkecStfZhZByFG/d5H4LUufAMi/Lsgfdcxv9mm1kzc
         2SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795573681; x=1796178481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gDxnzLaRy14zxoKiwsBabewsAmx6hWXhtiUNmVzNEZA=;
        b=iwgXlgMlEGHnkpeNtnwA/gnMQSyXk7ZDiwMr/GfRdNzOOso3REjm+k4OijQKcA1Vcv
         kHRoXWMceY64/WiF2DG8OPTwmrABSdVK1LD85DS4KJh1KRsTdgAiRM/Swcu/1PrZ5YNe
         8iNL8TkYv4F+7GJe1g1i6QpldWQkOCj9JL7o9iIolIAly09DGsFYQqJMX0ByzNh07fOF
         Q7tB/TYvF2eXn5XLwSu72QldEwZRs1GX0U27duPjwpWMY/mFEIa/vdsxtrpOHN5P5UYz
         gm3G6lOGQT34vkjWz8rLjBdRYLh8AI1I2UbveIXYI4dhfdIfdkIDpk9z/ojiirZeQ+Ph
         v1pw==
X-Forwarded-Encrypted: i=1; AL+hErGSb4vJfP2R3KOH0hQRkL4yx3zbV+gjhWCa67IF37LqXnc5CJxA1dU5gz8KARzw3y9nWgpJAT8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dO1WodARK93PCB9Ff4dABNxHuLmRuuU1XxGMSq9z9rWQYdlni
	TvB75LphyiqEsMGCWsDUGXPSYo3+WlNHQXDM+MOOlKfFGnDnHG8fqDM4
X-Gm-Gg: AZFdTZcGMcS/LeM4d3K3OoPtuPy0RkW/2yA1pFCkyBNAzbltMoAQ7m/v12kWfaLIYy9
	y8zDnqziMKtzoKcImYWPnvLRaS9mO4W7bQPEfCc1okcyKs0KvE8KFsU8SHe1OcJ3fTmsEV0wF5m
	Zx8aMUTnZBV2lc2Te6NIhjF5Uom0radqXE3rzhxKqSv6gSWVjFN3OsPNYflj2bvZbpw8bELSCS2
	hbuY4VvasxUTx+RTMjtpoUYeEzdwzKPhsx1YzuFBrgY+FX/Neo4jkv+T49HaCewgYFivrYwwE8M
	0C4YVd5ajNpV/PMCcVPe14XoI54ESVSaHyAbxKqkItQSakUWVMbupLzzAvRdHu7/TyZYKl8vxjS
	19+5AGr7IoWQfG2VmRfg5OSW0CKyfWWoIQywmGvE01JIWfGzhUZ8w6aMrw6zZEpCD9qNRodKPf4
	BCnzy6H4+pYPvCepYtVIQwy/C0d3McltQLLHh64/LdGmK2k/X53II1R5Pv5kC7vDovxhuh3GRDT
	IoiPNKnQsuZUTcoQY0SkHk+SgtpCnUC3HpozrjHGfu1nhAfjP5yaFhqrYprUnlujyflm8q4N5KJ
	n0RWHQOESlgLXF8tCQ93ZdWBQR5haSTDUQydCbXiesauGrlWKXas+FQrdjI4OPFmLIjPt1JyKJt
	83CVVYTR94pZruHJO1H4=
X-Received: by 2002:a05:6a00:6de7:b0:892:d40c:4f7b with SMTP id d2e1a72fcca58-8c87bdb52c0mr14274341b3a.10.1795573681357;
        Tue, 24 Nov 2026 18:28:01 -0800 (PST)
Received: from LDYT9Q2G2M.pvgl.sap.corp ([2a09:bac5:cad3:119::1c:2e7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8cdfd2d2fc4sm2475115b3a.49.2026.11.24.18.27.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 18:28:00 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: netdev@vger.kernel.org
Cc: willemb@google.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	koen0607@gmail.com,
	chia-yu.chang@nokia-bell-labs.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/sched: dualpi2: refresh head timestamps after trimming
Date: Wed, 25 Nov 2026 10:27:55 +0800
Message-ID: <d6273ba14831fb2e63413a0c532ccc716512de78.1795573222.git.zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118143500.dualpi2.1.543a9a1be910-zhiqizhangg@gmail.com>
References: <20261118143500.dualpi2.1.543a9a1be910-zhiqizhangg@gmail.com>
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

Reducing limit or memory_limit in dualpi2_change() removes packets with
qdisc_dequeue_internal(), bypassing the timestamp refresh performed by
dequeue_packet(). The cached c_head_ts and l_head_ts can therefore refer
to a packet that has already been removed. A drained queue keeps a
nonzero timestamp and reports an increasing delay; a partially trimmed
queue reports the delay of its old head. These stale delays are also
used by the PI2 controller.

Refresh both cached timestamps from the internal queue heads after the
trim loop, while still holding the qdisc tree lock. head_enqueue_time()
returns zero when the corresponding queue is empty.

I identified the issue and reviewed the fix. OpenAI Codex assisted with
root-cause analysis, the fix and changelog, and automated validation.
Local regression checks on arm64 net-tree kernels in QEMU pass three
controls and fail eight trimming checks before the fix; all 11 pass
with the fix. The tests use real AF_PACKET traffic in an isolated
network namespace with HFSC shaping, without fault injection.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Cc: stable@vger.kernel.org
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
Changes in v2:
- Drop the 659-line selftest patch following review; retain the
  regression checks for local validation. The qdisc fix is unchanged.
- Add Chia-Yu Chang to CC and use Koen De Schepper's current primary
  IETF address; the Nokia Bell Labs address used in v1 bounced.
- Check the patch with --strict --max-line-length=80.

The local before/after tests cover C/L dequeue, complete and partial
trimming, mixed queues, and a configuration change without trimming.
The baseline passes three controls and fails eight trimming checks;
the fixed kernel passes all 11. These tests are not part of v2.

The two-line fix and its arm64 W=1 object-build results are unchanged
from v1. This revision does not claim a new full kernel build.

AI assistance: I used OpenAI Codex for root-cause analysis, drafting
the fix, initial tests and changelog, and automated validation. The
revision prompt asked to address the review of the DualPI2 patch.

V1: https://lore.kernel.org/netdev/20261118143500.dualpi2.1.543a9a1be910-zhiqizhangg@gmail.com/
Review: https://lore.kernel.org/netdev/willemb.4158a0ba73d8@google.com/

 net/sched/sch_dualpi2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4947def7c4..79eba7209e 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -938,6 +938,8 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 			break;
 		}
 	}
+	WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
+	WRITE_ONCE(q->l_head_ts, head_enqueue_time(q->l_queue));
 	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
 				  old_backlog - sch->qstats.backlog);
 
