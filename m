Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544457;
	b=oMAIprIKpJs/hBnbDE56IMH9H02mmQkHpSWy3aeowRC2vSh/g2D9U0YzbdGOczTQePpg
	 GD1PSrBqugYBWgb0+WXEojAo0FKY0KqK8ReQO0Aj2vkbuAP4NXD2wO4IU7V1P0wcRZJuV
	 Tk7amSSZQdY/shY4PHDSmdfT2dm4j4I5Gqj7lcCueL0hWGx6VVph/yZ6IK+muYwrr9A7x
	 YP5cfKaivsaxM1GSMXy3dX/PdLonOBTVqQE/v6pDxjNC8Y7hvn0GOGQOZiUixhCPivIGD
	 S5Gw2bj0Jx8onuZs+c1s+iZhTNUYCkYqFuo1V7sGJYpjnZfb5srN6Pv8FZS+psHMlig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W+i1rIyr3V8Nl/4loAFxXnAn2+GLk4upZOLm6BNXOEw=;
	b=yPSx7NQZx8xIz7jHlowWizTUNQdAvVpKyjOQFsu7Xx3lD9gIo32pahXIhPK16DygVxda
	 oL/1y5SB7kObAuM77cip/FRrFKZ7n1ML2lsYKIgFNYbaRADGF0D9lv8F36zuNnmqD9J6u
	 1hnnQ2H+BxWJwsqm9NNazj1xPapKIDGGjy6bQ6eQzXtj+jXI3XGENoZ20oFTK2VS9tC1Y
	 n7kHXwqMfciDiOrdzmvraXM0zMlN4v4hRvxrrcmsl2mzzZOeWf13gV8XGeVsn3l3kf4un
	 /SY88gSxtkFAhtkfNpLTtmaZt7s48mf/V6KztFfylCoUEgCh1dR+mxQvVtT/cq0ISpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OazWZGtb;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7FF606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 01:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC7FF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OazWZGtb
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so119555eec.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792544456; x=1793149256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+i1rIyr3V8Nl/4loAFxXnAn2+GLk4upZOLm6BNXOEw=;
        b=OazWZGtbA71CeU2cmOt/W7CI0AtqVl/3TwcSWlanzHPWQhHRGyuuhPnqK7FIfLdb3K
         +ud+7qM7n8MkFkH+v74zPE0OdsmuORcgFPgE/0ofnAMrR6hKDm8KobcQIQIUR/j9tG35
         ZdlY77VKCthsX5ALher2p9rHGUbt+duu89XEFMNg70pYPaOkjY3YaPoVR2J6Y/yv8KDR
         GuMm5U9PiwOE3DuJ2rAIkDTY0TauGg5C/eU4/HkA+1qxMJyn2Ae7FeAocOkbbbYYl2OY
         QyPoDsqR1bYWLaIKnceOnLCDiDUICS2DkRvV2v3Z2lBwFxDCZZdHzke43h8geKojYaAm
         n5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544456; x=1793149256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+i1rIyr3V8Nl/4loAFxXnAn2+GLk4upZOLm6BNXOEw=;
        b=R4UU77o9rPw+pake+JYh8ymbsW4385Rs2051kO2Q6+bH6h//SWr/whV2Y2AHWOMPF5
         sqe5lmsNxZi0fYZMEiVMIA4+rh7F/gGY44qm+83Qud/Txql+Gq3IqwhHkA0wK02cxdfV
         vMgyXJSD85+BjmML5c2O1iE7px/sSYsks8IzAsXHgRKUp0IyegRNHxeQ8KVWD/v6Bv9A
         zNyl7xiU3TtjwFS8pN+buWGomRJvD3Da1987hYmxZ4U9NToMAA3iNa42dqEOVNtYwWuD
         ISAfYwJPWMv+m+h1wZ8aXU3OhzvoWahy6TkYvo2+jwXo6q+yoPipsLSMOj51lNyt6IJf
         fcOw==
X-Forwarded-Encrypted: i=1; AKwUvByv+5G/SokQ5jamjQ/TPZYuMQyhdqpC84jGWeim96M5304dgqzcBxErzE+73R8w4iWzpAK9SpE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsuaVdDwIeJ7Pzw0wzB+anIf71noSNjDXnOndiq8nrtfBYuBWK
	cfNUB9kreyCYFBMuKsHl2oBYCy2B1lSh4KTHepIUhWpks6SfeiPDSiDF
X-Gm-Gg: AYBFou0sF7sPbq8fr+M3PDDAq2oalGSrMtQlAtlROz6QxHJIEkP9NYAqoW3I1LLu2gi
	eJttu4FcbLvLPVx3uYsyRN6ZSgbpLoqRPZUiUD1Lack6fER3SfFXseseyWZ9Y4Rw0vUkXiw6gsS
	ItPDeRM8C4NuYEn5T6qJAGkogB3OvY3YsdmxI3+CofIWcSVFlF97tPO6JmtvADGlkHk0PG6HLVm
	8PTI4XTEDN3QTNdCeZpdYzcAoxrGUVs1qm7g43pF2Wg1odQSCxG9yF6XkIcP5nwrhroZa0dKYdb
	iLRSQFDqaRSfbIrIMS31uupwmY0WOCfwcwXDs6oaW0UEBvq/bezUsZ52WBGkXYIaK4Sq7aJJ175
	2Vz8OfWhnBlOBzLvLVdr0KYq/2KK7TDfrpUT9F/ajEld/5SifJYHatu98ucBLVoizWOLXKrdj1p
	Qvg7lR2ti6mVRuYC5X+b5lWwbPJ/XnOv48BObp3H3SaaFIC6iCmzX1eRcsZnF4s9poXVh/3ih5y
	bHSnZzCFDTYxeiH2TYALMe5EKHJr9FsOClLyLyrVGWZ9Kbe2wQ5ABoiv8Y3ey1WE0nL7MXmBzax
	GKufBPs=
X-Received: by 2002:a05:693c:42c3:b0:35f:2349:a574 with SMTP id 5a478bee46e88-367508e2009mr1139401eec.40.1792544455625;
        Tue, 20 Oct 2026 18:00:55 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367417a2fadsm1977890eec.21.2026.10.20.18.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:00:55 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: bsingharora@gmail.com,
	yang.yang29@zte.com.cn
Cc: akpm@linux-foundation.org,
	wang.yaxin@zte.com.cn,
	wang.yong12@zte.com.cn,
	xu.xin@linux.dev,
	jiang.kun2@zte.com.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] delayacct: Preserve delay extrema when aggregating taskstats
Date: Wed, 21 Oct 2026 01:00:22 +0000
Message-ID: <20261021010022.85881-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

delayacct_add_tsk() adds each task's statistics to the accumulated TGID
statistics, but overwrites the delay maxima, minima and peak timestamps.
Consequently, the last task determines these fields, and a task with no
recorded delay can erase an earlier task's peak despite a nonzero total.

Keep the largest maximum and its associated timestamp, and combine the
minima with min_not_zero() since zero denotes an unrecorded delay. Apply
this to CPU delay and the seven delay types handled by UPDATE_DELAY().
Single-task queries still start with zeroed statistics and retain the
task's values.

Fixes: 658eb5ab916d ("delayacct: add delay max to record delay peak")
Fixes: f65c64f311ee ("delayacct: add delay min to record delay peak")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 kernel/delayacct.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 479e860aff70..ea1424524654 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -12,14 +12,18 @@
 #include <linux/taskstats.h>
 #include <linux/sysctl.h>
 #include <linux/delayacct.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 
 #define UPDATE_DELAY(type) \
 do { \
-	d->type##_delay_max = tsk->delays->type##_delay_max; \
-	d->type##_delay_min = tsk->delays->type##_delay_min; \
-	d->type##_delay_max_ts.tv_sec = tsk->delays->type##_delay_max_ts.tv_sec; \
-	d->type##_delay_max_ts.tv_nsec = tsk->delays->type##_delay_max_ts.tv_nsec; \
+	if (tsk->delays->type##_delay_max > d->type##_delay_max) { \
+		d->type##_delay_max = tsk->delays->type##_delay_max; \
+		d->type##_delay_max_ts.tv_sec = tsk->delays->type##_delay_max_ts.tv_sec; \
+		d->type##_delay_max_ts.tv_nsec = tsk->delays->type##_delay_max_ts.tv_nsec; \
+	} \
+	d->type##_delay_min = min_not_zero(d->type##_delay_min, \
+					 tsk->delays->type##_delay_min); \
 	tmp = d->type##_delay_total + tsk->delays->type##_delay; \
 	d->type##_delay_total = (tmp < d->type##_delay_total) ? 0 : tmp; \
 	d->type##_count += tsk->delays->type##_count; \
@@ -174,10 +178,13 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 
 	d->cpu_count += t1;
 
-	d->cpu_delay_max = tsk->sched_info.max_run_delay;
-	d->cpu_delay_min = tsk->sched_info.min_run_delay;
-	d->cpu_delay_max_ts.tv_sec = tsk->sched_info.max_run_delay_ts.tv_sec;
-	d->cpu_delay_max_ts.tv_nsec = tsk->sched_info.max_run_delay_ts.tv_nsec;
+	if (tsk->sched_info.max_run_delay > d->cpu_delay_max) {
+		d->cpu_delay_max = tsk->sched_info.max_run_delay;
+		d->cpu_delay_max_ts.tv_sec = tsk->sched_info.max_run_delay_ts.tv_sec;
+		d->cpu_delay_max_ts.tv_nsec = tsk->sched_info.max_run_delay_ts.tv_nsec;
+	}
+	d->cpu_delay_min = min_not_zero(d->cpu_delay_min,
+					tsk->sched_info.min_run_delay);
 	tmp = (s64)d->cpu_delay_total + t2;
 	d->cpu_delay_total = (tmp < (s64)d->cpu_delay_total) ? 0 : tmp;
 	tmp = (s64)d->cpu_run_virtual_total + t3;
-- 
2.43.0

