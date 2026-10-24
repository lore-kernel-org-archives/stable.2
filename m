Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841985;
	b=xZXCXgI+agDWVaPXgWtAnF2Uwg11zbDCoWL/hD6XgII++A6SmVwWT8UelfIe+SGYTSla
	 Ofwm75eR0e2r4kewgu9kDVk4nwGlTCfjaFTYYZm4Gl8gx0utBnI62G8o/mb/6wlDqJEeC
	 ivk3xZh1sMI7ljANuEirNAJlQqT1uOSLsenbc29UZmL40lsqTAKISQu60WiYKL3VGVqvR
	 UtxJRrK6XhIjZaRJrk/duFpZGQBXxV+6PGRDnPs5k/eGsGZwIaD4sPovsxnucuiLViVOL
	 V6cEXJljc/i+9bguZxalFKAj7gp66BYOV1Ts6etO0iBE4yWjHTSH9ZzVQkIy3XZHk1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841985;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Qro+a1DI5oQUSW/actE6Gjk+N6snSn/2z6jQmSgRqno=;
	b=Wl3GBvgkNu7XRV9wOdA75lUm3RdE1OzB0zPInTr6VJZccayboJm2eRRYxM1fOWMkllOV
	 /ooMRVJBLh58/yeWTP/O7gEUJsZHHnHT0OdAgFaBECeV/y0YejwAwEsGRhwr7NCaDewIN
	 IL6upMz2L+37nzPCBa2fU5EHphiva+uSz741hjltxm+UGZsoJyc+/WEJRqW4pU63IjoXY
	 7X1krWWG2UCeovVrq5I6A5U4X7QHa+OOWXsL0X+Okillrim7m4Y7FC/F0fbqVhxqV10Sr
	 9rZq9WJ+6uv9ZLxaLGcsh+E05Kh0uqKa3+aFiyU6BWE/CLd4ND5nuNlTS3r2ORkHhag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="Ll0/Mo0U";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=dbfwtJ2m;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA86606A31A;
	Sat, 24 Oct 2026 11:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCA86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Ll0/Mo0U;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=dbfwtJ2m
Date: Sat, 24 Oct 2026 11:39:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792841982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qro+a1DI5oQUSW/actE6Gjk+N6snSn/2z6jQmSgRqno=;
	b=Ll0/Mo0UKlvCT3fWX5ap5YSOinUHGbQXPC6YI77cWaLpEQQLVZRUdrXYcBwGCq1kAggMGm
	hwsKXWNJMKNyAxChMqL7LbqXucczwOqo0imN5dM+I1F8Bm0cyWB4/3TMs4ZOwq3bLtMWIl
	a2gM9/3r2c7Od3ihmRja+aGLV0vroMX/fZhgjC3zhUUpoRGD109dX3T1xH0/9rzgaGC+hW
	JnMta1PLfir8cZSylMM41ExGVdlFGfh2/8xYZ7pH0+ad7Cc1UaoleetwrqzaswjKTqR6xu
	ePVXhJ4fLjsJKZjyGjdO8tP65pgp4tdQ6N0b7gCaCmY35UIsXHnta8hdufxFxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792841982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qro+a1DI5oQUSW/actE6Gjk+N6snSn/2z6jQmSgRqno=;
	b=dbfwtJ2mHAxTEWxeAFgKrEd8yUSCpSzVkOwTVegv8esO1kndD3YkdF5kZtZgsckIMXpv7e
	NRzIFkxX0pnYPxCg==
From: "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: fix stale get_pref_llc() stub for
 !CONFIG_SCHED_CACHE
Cc: Yafang Shao <laoar.shao@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Gregory Price (Meta)" <gourry@gourry.net>, Chen Yu <yu.c.chen@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,  <stable@vger.kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261023023105.28829-2-laoar.shao@gmail.com>
References: <20261023023105.28829-2-laoar.shao@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179284198077.4109677.6349615888209078475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     cac037a85c1971ec75c4d3edf5a28af9ec2a089c
Gitweb:        https://git.kernel.org/tip/cac037a85c1971ec75c4d3edf5a28af9ec2=
a089c
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Fri, 23 Oct 2026 10:31:04 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 23 Oct 2026 19:09:54 +02:00

sched: fix stale get_pref_llc() stub for !CONFIG_SCHED_CACHE

Commit b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_grp
to fix UAF") switched get_pref_llc() from taking a struct mm_struct * to
taking the task's struct sched_cache_group *, but only updated the
CONFIG_SCHED_CACHE definition and its caller: the stub in the
!CONFIG_SCHED_CACHE branch kept the old mm_struct parameter.

Fixes: b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_grp to =
fix UAF")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Cc: <stable@vger.kernel.org> #v7.2.x
Link: https://patch.msgid.link/20261023023105.28829-2-laoar.shao@gmail.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d750f2f..6057bb5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2194,7 +2194,7 @@ void init_sched_mm(struct task_struct *p) { }
 static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
=20
 static inline int get_pref_llc(struct task_struct *p,
-			       struct mm_struct *mm)
+			       struct sched_cache_group *grp)
 {
 	return -1;
 }
