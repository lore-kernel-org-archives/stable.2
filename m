Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793770820;
	b=z/3e+iUj0YZUoCTVkRQFBFfQ7BilJglaAH6YPG23kn1BgQuIbuhIZoEae+oalivvMwo9
	 k7QwqzbG5UgfJ4pvfZcrxnNT/+Qnd9MIQYDIEejQQj2Nn8skwZtRflu/gWE3GPpVSp5TU
	 0KV0sAezrzhoAWeFH8UCFbJ0yJTXEK83fVn2wgSOrPplkC/xzkFSO+dHXbYOOzkGnUnko
	 Ywfaaszs2zV1Tnz8KZJU61MaTGvII+ZHtYi0WJp27oYqxwhXEq68ETIz4Hrxxv0Uwit26
	 W7PSuJ1KxQPRwBRQyj0tLgGs+BHgMgrQJY3dusvt+Q8rCMl0QthgOB1SMiy42FGxXTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793770820;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=XK14gn3afGjQO93vtxOK4rX2+8gn13HtO8JN2/VQ3Cw=;
	b=mYgORunCVymX1h3RYmEB6goRfCdkoOAudzlVGgAFsyn6SQyv6gPeJXo6lunTzjbdW0a0
	 rPZEFBWf/KarslnUVrNgf7L2y+Wr50lpUEjtYuJEmPDKCsxaOIDzqZVP95NOULz/ub3Gb
	 7SsPD6HA7yyR/FcktnJLOHOaK0TYfH9IGEp/B/Zdf2VPXBDC7RsnPfozQWxdY/He5Vt16
	 lcWOW3KIz3MBNqEeWdBeYjFskYRda/+NELrsAZwlCWqSidq6pnN7yhtPzzTPDem5CTrhG
	 owpMk7JKOvMhg/3+ISI5iPb87dEVFy6vJFT1czC4uMW80GsqvmNQypg6x6oCC/EiwZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=oEvwo11g;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA9606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 05:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3FA9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=oEvwo11g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1793770776;
	bh=XK14gn3afGjQO93vtxOK4rX2+8gn13HtO8JN2/VQ3Cw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oEvwo11gNhv/l82eQawvMsHRYC9BobHE95QfaRZn3cZ6gRzaZBdD66/M22mRPfY9z
	 /OzKUGJkvaGZDrjxgpL8tt2ftayfREkAb7N10oTD2fnOynmGhqS3+T3MkrX+1blRHt
	 I9OC369Wq8yLcOrov/W3iIyLrSYtN0VnC8zQQIrs=
X-QQ-mid: zesmtpsz8t1793770758t3d36a38e
X-QQ-Originating-IP: i2/274j8W+IzMMKT+4D6S+IUbWiQBGVsl/7IIyWqb4A=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Nov 2026 13:39:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 337138461145264766
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: joonas.lahtinen@linux.intel.com,
	imre.deak@intel.com,
	jouni.hogander@intel.com
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/display: Don't drop the async-put delay on self-requeue
Date: Wed,  4 Nov 2026 13:39:10 +0800
Message-ID: <134A26B6BCDD3C9C+20261104053910.1065103-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.47.3
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: No4GWyI4cWt6Kjo7qRlUDJvLUFRLYgvhJadss/tsQS75ID9ohL0hTa9z
	/DXUWU2zg34ePTZA5xKfrdMtA0U75LIW2PC0mwjG2zd4t+ARAKhX86MozyXkPubWHyYifYQ
	FZgh4+bVuK8OUMXik+xh+ISxd+k6NS9yFDrhG5/TzW4v9E95pCBJAEjURkxqsOePpggSNdo
	Elwv0XUQFW6KPdO//S1eIAeyhH6gQnrEqWj6IR3HVdU68lLX7z9N3Y1f14ufLnbhYVa+qNC
	+EeorAKFIoHzetuduPsGp1RDsljjzgJWUPOuJ0Cj9P68Sb99y29f0kOWQkNLhemmYhe3bN4
	3JpwTjBtvFDeMbD7gaSAJJ0BqEx2HA3OuvN8AYdBM1it3zbu4CxTKnyHb1Dmis6T5+oHsbi
	YQEYjHU3FkaNQ/pxRQ6TwEs7NhGaRY32z5mNhPodiGd7shIyzztzyNdM4j8NY06J39/EF7B
	8uCbwxILxR110wjU1gOqEStRKOLD2nE7T+Mn8LdePp7MJgRrSQ+QfnpiPainH9Z9yabY+UN
	N8o5b2ZfNyzjJK168PPTjtT+S4HnaGJ2BKOi24R7GwRY4TPfkgC44IhF+9XBbqqwgDg2V8R
	0XJX13qeATa0JihbbAno/uem+tPdnRV9c4ZbCaXQY0tEHP9dpYszBKjM/elrKwrSMIyV3BP
	kCFzauAKrbEzETgaMpiYtV/1ovjgFKeij+izw1XU2RTIx7QaIO5aQavTYB+9MgZ6991CgN2
	SdStpPa7Evql0wV64J8TBw72qJK+jzcP7FK1cT1mmWwXlv7YOzhxUNKYQOlstQL8tfmt7Hq
	jiCq3k9CNheUb9OxPTwsp7s/MUf91OO/VCWefwmFUarn30DayODAbJdD2KP6AkGFdgQeHo7
	8STwGqwSR7exNVz+JKWKmMEGZkGLwpRYzKmvwFT7t5+dNLb+NEMyWIBqQhFciVfryGkNm1j
	73aJ7b/LIZUBTLhEi88l+6v+ybhy1plqIhfAUnS2k8gx/RaU51OfUSMrNZA6p9YqZf32KSE
	6xKnsJafkbjy3Y6dUejvyQXZSIX6GZ3LQD4nq6+w==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

cancel_async_put_work() also clears async_put_next_delay, so moving it
ahead of the requeue in intel_display_power_put_async_work() makes the
requeue always use a zero delay. That discards the delay accumulated by
concurrent async puts, including the 17 ms DC-state anti-toggle delay
requested for POWER_DOMAIN_DC_OFF.

Use cancel_delayed_work() directly to cancel the stale instance without
clearing the delay, and clear the delay only after the requeue has
consumed it.

Fixes: 30ca6365bb42 ("drm/i915: Fix assert on pending async-put power domain work when it requeues itself")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/gpu/drm/i915/display/intel_display_power.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index b000ec001ccfc..7da6eda46e9e0 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -873,7 +873,7 @@ intel_display_power_put_async_work(struct work_struct *work)
 	 * Cancel the work that got queued after this one got dequeued,
 	 * since here we released the corresponding async-put reference.
 	 */
-	cancel_async_put_work(power_domains, false);
+	cancel_delayed_work(&power_domains->async_put_work);
 
 	/* Requeue the work if more domains were async put meanwhile. */
 	if (!bitmap_empty(power_domains->async_put_domains[1].bits, POWER_DOMAIN_NUM)) {
@@ -885,9 +885,10 @@ intel_display_power_put_async_work(struct work_struct *work)
 		queue_async_put_domains_work(power_domains,
 					     fetch_and_zero(&new_work_wakeref),
 					     power_domains->async_put_next_delay);
-		power_domains->async_put_next_delay = 0;
 	}
 
+	power_domains->async_put_next_delay = 0;
+
 out_verify:
 	verify_async_put_domains_state(power_domains);
 
-- 
2.47.3

