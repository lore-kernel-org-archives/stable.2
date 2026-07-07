Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889B437857
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443571; cv=none; b=dohk6wn2MHx/ekE/oK5Y3eWyiSl6aajvFyaDARE0ajgIpKUrIN7tZk5KTkStpDEZSZMge5BNenY+FEwLUGUg8hOveQiDYlCbPvWn0ClF+hRfQ93cGLsVf2iGZCcQ3zIttphcfhcUINExQdzQFSoRK5O1mKy9gU6ScshNY+LfLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443571; c=relaxed/simple;
	bh=wVpUm1v/RMR6gvje70eJqG2PiFg23Q5lx4GrDBMwOvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gfqw40NR4U5bQoQKudHc2LHX2m4FYXkDwQeXRgc0t+nvjaVeVudJS86zDZesLqcmI1WTpQ2ySHXBdUzi9n6Z0+iLJ81JKnVsmtJ5u2VHC/96pmC6AtDwsK6YKgadh955KcIe/LBrinHGj0EsX/D7K+i5iqbuxLcMi1liGqHEOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyquBbzD; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyquBbzD"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f23e851626so36059516d6.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443569; x=1784048369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSuBxh5hIAtEieYGaAH1R8faa2usOp5VRIGJ+Usc34I=;
        b=RyquBbzDBiYMA9bAMTD4LBYZnqJ66ZlNHLd7BE1S1Ekejk4sP87lv4R8sAOmZ3iAEl
         6v1zxmEGb4nMMD6Vv6Of+gBzXRK9zGhiF05RhiFzhla/TeTcEcXd5sH1CNR9x9Eb2Rde
         9+EfaLi7V/50SGCBZKcJ5rkH/ZU1Ixuf+itdfZS+12Pwf/zFmn19Af5qPRpb7f0UtZ2W
         fz2FzbfNX3/nWq4qYj9EZZaSejXbouwJOTFJmVJ6/2XlFaOknjXK3COheBV92sSwjIYe
         SmX2LYj4kObyBtZpJ0R7Lh1bbuaF4TtApj/4TCj7wb7oSEe98H3gnv4sP7jllN/9cVcI
         h6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443569; x=1784048369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSuBxh5hIAtEieYGaAH1R8faa2usOp5VRIGJ+Usc34I=;
        b=U6yKSdL6cc6pCVswpnM9961YcyBCm+swKwTdmyg1l8S36dOvltZxxwVE4T1a1UOnli
         BkiMu17GOKdfG/UjN/2HHHzFrbiMLTkWfErZKmWy9CD2PVkmNZF2p0EU2hDAegUY4nWK
         v6aWXdPshh16YSDnNYYh1R7dovC6fmOMLu+cGCCbn4OgYqqDiy/zxf+7e4OQ5hAbRQC7
         7h0U+rSeLXpVoPpx/8eosJNGnBO/QiPsACHn4br4Qril6taUqRrTOaxt4BZhWeGzmMfI
         Cq2TWfCKpeV9cpq7eOkPofdDfiBLgtSAipTMY8cXV9070VajqVRD0aP2cSl48SK9xP/N
         nmXw==
X-Forwarded-Encrypted: i=1; AHgh+Rp453dGTrF+8EQv0El7EHi90ntmwjJtrVQu6eIjotjAr0G0i9Viumf/W5f/aj1064lFLmpQopM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44v5VRm0owAQcsFIoHzQEWWpJc1zPs25zs9KByK0pGDG7cG1B
	Yw2etkffrsw43pmONwTyphZzsLanm2PUqsGr9BHh+5N7bcTwogCYxKgC
X-Gm-Gg: AfdE7clpaTmPSdb7KRhN/DVvjCQUxb9rByrTjoefDAX4QIpyxMo8AwWMhnRFEwf8ElW
	mjsMDzOcFYWDfWN+mZW7BBTJQ6WbdisLSi4DPHuxF6m24ROPl4ZlDbnyyUcUAFA+ue3BYhs7/IG
	H9h4B6PZuB3dMsl3RdYQ1VFuuMflu5NRiVlkpfmExMUH+zzXbB2s7V9h15yA6uK1pYiOKGT2ses
	kZeD5wVEWojg5VsueTbLSFzeijGCgFFqmuHe0ZngB/5ICtslmUl6k51S6xzv6TzWtfMPYFp3RKW
	8NuStT9Pd3wqmt8vo7rQ6+YH5aYTs+R9+SqLBn1nb9XaPPgV6Esqtlw9lNXQZwuT/jEBEt80Tgo
	mbUQp7FAVwfoiylAs1yiH3HfxqwG8OOfSwg0ahlf+o2hyxWwqbAxtTyrSO+jLJaj6cTBTJ0vP03
	uLCD2uHo7bMFI0C1JwSMV9wTT0yaichMM7EWBOP5Zms/3H+uYV3rOunowFIq4npqrk8nn1Qw0uX
	2b7QxDniNJCTvRTip5VOOkCKWcfvKde
X-Received: by 2002:a05:620a:4144:b0:92e:745c:6c5a with SMTP id af79cd13be357-92ebb4bd1dbmr703200185a.14.1783443569056;
        Tue, 07 Jul 2026 09:59:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bb91adsm1209145385a.20.2026.07.07.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:59:28 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	XIAO WU <xiaowu.417@qq.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] selftests/user_events: wait for deferred event teardown after unregister
Date: Tue,  7 Jul 2026 12:59:12 -0400
Message-ID: <20260707165912.2560537-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707165912.2560537-1-michael.bommarito@gmail.com>
References: <20260707165912.2560537-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Unregistering a user event now defers the drop of the enabler's event
reference (and the freeing of the enabler) past an RCU grace period. As a
result DIAG_IOCSDEL can transiently fail with -EBUSY while that last
reference is still being dropped, where it previously succeeded
immediately.

Two tests assumed the delete takes effect the instant the unregister
returns:

  - abi_test "flags" deletes the event right after disabling it.
  - perf_test's fixture teardown clear() deletes __test_event before the
    next test registers the same name; a stale event makes the following
    registration fail with -EADDRINUSE.

Retry the delete until it succeeds (or the event is already gone) with a
bounded wait, matching the existing wait_for_delete() idiom in the same
suite, so the tests are robust to the deferred teardown.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 .../testing/selftests/user_events/abi_test.c  | 24 ++++++++++++++++-
 .../testing/selftests/user_events/perf_test.c | 26 ++++++++++++++++---
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 85892b3b719cc..9e2f84d281afc 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -132,6 +132,28 @@ static int event_delete(void)
 	return ret;
 }
 
+/*
+ * Deleting an event drops its last reference, but an unregister may defer
+ * that put (and the freeing of the associated enabler) past an RCU grace
+ * period. The delete can therefore transiently fail with -EBUSY while the
+ * previous reference is still being dropped. Retry for up to ~10 seconds.
+ */
+static int wait_for_event_delete(void)
+{
+	int i, ret;
+
+	for (i = 0; i < 10000; ++i) {
+		ret = event_delete();
+
+		if (ret == 0)
+			return 0;
+
+		usleep(1000);
+	}
+
+	return ret;
+}
+
 static int reg_enable_multi(void *enable, int size, int bit, int flags,
 			    char *args)
 {
@@ -262,7 +284,7 @@ TEST_F(user, flags) {
 	ASSERT_TRUE(event_exists());
 
 	/* Ensure we can delete it */
-	ASSERT_EQ(0, event_delete());
+	ASSERT_EQ(0, wait_for_event_delete());
 
 	/* USER_EVENT_REG_MAX or above is not allowed */
 	ASSERT_EQ(-1, reg_enable_flags(&self->check, sizeof(int), 0,
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index cafec0e52eb31..5727cb5b914cf 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -85,6 +85,7 @@ static int get_offset(void)
 static int clear(int *check)
 {
 	struct user_unreg unreg = {0};
+	int i, ret;
 
 	unreg.size = sizeof(unreg);
 	unreg.disable_bit = 31;
@@ -99,13 +100,32 @@ static int clear(int *check)
 		if (errno != ENOENT)
 			return -1;
 
-	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
-		if (errno != ENOENT)
+	/*
+	 * Deleting the event drops its last reference, but the unregister
+	 * above defers that put (and the freeing of the enabler) past an RCU
+	 * grace period. The delete can therefore transiently fail with -EBUSY
+	 * until that reference is dropped. Retry for up to ~10 seconds so the
+	 * event is actually gone before the next test registers the same name.
+	 */
+	for (i = 0; i < 10000; ++i) {
+		ret = ioctl(fd, DIAG_IOCSDEL, "__test_event");
+
+		if (ret == 0 || errno == ENOENT) {
+			ret = 0;
+			break;
+		}
+
+		if (errno != EBUSY) {
+			close(fd);
 			return -1;
+		}
+
+		usleep(1000);
+	}
 
 	close(fd);
 
-	return 0;
+	return ret;
 }
 
 FIXTURE(user) {
-- 
2.53.0

