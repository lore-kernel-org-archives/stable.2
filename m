Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523168;
	b=m2kve5CFI95JH7h1z5DYFifKGkIHBK7jykviG9DlxIj3k0Eova1KEWdTn5f9FN17fcaC
	 7f1Ida7bQXSbPpx/8jDCMXZMTtSXNzVq50wIKFo5E4/b7BSoSSarLI2q0sW3J/4wivHjh
	 KfzTsP2WB43M84f/bI4PNzyZu4XBKv2rVV5vsQlfaRxkR42o11UByogHFoOL7uiAkKqCI
	 H4ox9V0dwbhkkfOqWYcP9xZLFomVJYn5Llvdr3ZEAaKXBvoz8TPaO0sHs9BWXAwXMDxMS
	 lcbzQmJJKvb6qa2jyp/ohUWgyPMfEQleo+nTaBAahHx90os2hgqUxHZx28rL90anfoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SqV4Jv6wNfUGVd/YP57RFpsT3eJh+v6vOgo/2e6RqII=;
	b=NjILJqm4Qzeu5XdFRHs2oDTY+aGZv+pT/dk+uS8U8uWT+btFb03EPbzpIHJan9DaD8ff
	 Adhtz8Jq9zYY8EifEmEKw4Q+GURuBAO5nnuuvHHYWHq9JsF3fNdJhISEQ6+ZdkVnOkDnc
	 gPpAUhHiiw9IsJrnpP0FOvloa/f5193IjmjVN+FHoWquHdqR09mR5G86dZOfudLFDkNT6
	 /9rLgclDZg08+4PR5hdT2v6ObLGzbIAVQu28UPAm/QS6finoGHitXXuVkAb2iiGCBfOzM
	 2yf8unZJ3JUBGcXhFeVqilCvH9xUgFp76gOxOunlnEPy2fWRHZfnwOzp3qdvYCKXVtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=EWW5fAQy;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EDD606A339
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9EDD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=EWW5fAQy
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a210470b49so43635835e9.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1795523166; x=1796127966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqV4Jv6wNfUGVd/YP57RFpsT3eJh+v6vOgo/2e6RqII=;
        b=EWW5fAQy7yhC5tdYwOSZHMQRvsqi9e5wfYcZWu7Ph5ezp0bMl4QuMGYylfohd8H+jI
         N1Yxbo78M9qSyj4QcOKokr/sYOrH5HQD+suj5F4RAdkpMuoo2SMjpS0qtPsCCSlFgQun
         HClv8etZWSnI1gqjl6As5D7VbyxRtQapccAjTKM06uESmj7E8UlyCIlmZMkONHuy6Wv9
         oZ7J9/qPgVffQc+ce1IL4BfxqAbMmLhEfunGHtYeItLsJngytf3kafnS4fGuDZOauy54
         nuy8X7hE9T2Jq78B3U1dWJ1+kXTi6v/RNjotrhXGYmbEKPkUaxJmZtuOqXSQskuAbuz3
         BksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795523166; x=1796127966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqV4Jv6wNfUGVd/YP57RFpsT3eJh+v6vOgo/2e6RqII=;
        b=w84oUwfUJvRzlJMYyeocxa7CvGBkWW/+Sc+SpeJ/P/w5xQXqCKNAU2cVnuR43WCh0d
         cXOolgKJHnz+f92NJI3xW7Pps72f8srxIun3FncxE5Uyp5HBcL7i46DHsACOnds0Xvoi
         STLZxEWIeRF9qm8IS7684kvUchKKIUNCNuHgEzTs6cxW1+PfZxZayz+ETNa14tCbPJyk
         QQjGaOBsJ3QtSdq/5YQLZu/do+xXvX9urcOuZoSf6YUIGpXKIT/lZUOME/EwlfMgE/0T
         rMWimoyowxoSs9LSsRHK6sEE8pKVsBb1wjET/1kuBSq/kzesPBbjdEsgqUGSx0NjmbO/
         5SsA==
X-Forwarded-Encrypted: i=1; AL+hErGofJykxPQKNsuQnSBhN5kSFlD+rObpl2KkRjKkly7l7N3G/0x8tZvo/YfHaIJZCMctOUY3Kbg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/laX/fCm2L4/r+LP00G/CcPvoWjqCRjE9PzoilzIK3vdP1QfQf
	jIxseyD+7uo06Bzxgit+FdjUNiVuQR3l7MGr0gfjQ25D4qdnxJReCyMcZ0fXwWSv0uU=
X-Gm-Gg: AZFdTZeuuuSwMVDOo6CxG/aGzj+z30AQ9P30nbnl7tx57EXGqbSfv7FzSd+J9XlnSlF
	NDK9UsukRy46/STerNY/uwTqGi/nbGrj/OGMQC7w06f+mKSfY370vuk8dCy/VLgUPzyUYtfHo/h
	DsRB/mS8d+dBaCwLFrrBv7eYey4qpYVGtDQlJMiiCNcXCRX/YJ569Bgd9qpeJgqJh/IxXdlgZTT
	0ZjH+5zc0A6QKocINpdeh79plNghWFoRqawZKRl9ORmdGT8Qtgv9N+4VcrGQyMqWitQd7YETa81
	Jg8HrnR1Jc4S9AQWYGNfyWN1JnCcU1cSwMQXSmKXFT0Bri6FbP24GHbn9Ug6pELFPyKIvjR8XLJ
	Wvhusg5oQF9Mp1gBxWs2MDQkaJP/mOHfFJFx+hcFO8UjST5AtDE5pGChz4YOd1rFoGuiZ102piM
	LMdompa5bVlMR9yG1+Bvq2eaJDrluYVRSuAEgVbQja9yv/MeKC7MDefssj87hV1WxrJ+rRH1AJ5
	RG3w14alsnsaYZvoBxLWQmdgAFONjgGgFp2aMZr/lEhpad0OljEl38yBSEfVLjMziu5sono2TsS
	VXhOxLOa4AEmoHQLZQtPh11SaS+koImkWttQWv+kXWdsWCeF
X-Received: by 2002:a05:600c:468c:b0:4bb:6d61:af7c with SMTP id 5b1f17b1804b1-4bb88944bf5mr286853905e9.35.1795523166104;
        Tue, 24 Nov 2026 04:26:06 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:8dcd:31dc:bf64:9564])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm423615975e9.15.2026.11.24.04.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:26:05 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev
Cc: bmarzins@redhat.com,
	thornber@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	den@openvz.org
Subject: [PATCH v2 2/3] dm era: refuse metadata rpcs once the target is suspended
Date: Tue, 24 Nov 2026 13:26:00 +0100
Message-ID: <20261124122601.436965-3-den@openvz.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124122601.436965-1-den@openvz.org>
References: <20261124122601.436965-1-den@openvz.org>
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

From: Denis V. Lunev <den@openvz.org>

An rpc reaches the worker in two steps: the caller puts it on the rpc
list, then wake_worker() queues the work unless the target is
suspended. stop_worker() raises that flag and drains the workqueue with
no ordering against either step, so an rpc can land on both sides of
the drain.

An rpc queued before the flag is raised, whose wake_worker() runs after
it, is never served. The caller waits for a completion that only the
next resume can deliver, and it waits holding the table srcu, so a
reload blocks in dm_swap_table() and the device can no longer be
reloaded or removed.

An rpc whose wake_worker() read the flag as clear can instead queue the
work after drain_workqueue() has returned. The worker then commits the
metadata beside the commit era_postsuspend() runs in its own thread.
Both commits allocate from the same space map and take the same block,
which corrupts it, and every commit after that fails:

  device-mapper: space map common: unable to decrement block
  device-mapper: era: metadata_commit: pre commit failed

Add the rpc and queue the work under the rpc lock, take that lock to
raise the flag, and refuse an rpc that arrives once it is raised. An
rpc that made it onto the list is then queued before the drain waits
for it.

Userspace sees one change. A status query on a suspended era device
used to block until the device was resumed, and now reports the target
in error.

Fixes: eec40579d848 ("dm: add era target")
Cc: stable@vger.kernel.org
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/md/dm-era-target.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index ea499adca4ce..29b0602e7849 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1389,10 +1389,14 @@ static int perform_rpc(struct era *era, struct rpc *rpc)
 	init_completion(&rpc->complete);
 
 	spin_lock(&era->rpc_lock);
+	if (atomic_read(&era->suspended)) {
+		spin_unlock(&era->rpc_lock);
+		return -EBUSY;
+	}
 	list_add(&rpc->list, &era->rpc_calls);
+	queue_work(era->wq, &era->worker);
 	spin_unlock(&era->rpc_lock);
 
-	wake_worker(era);
 	wait_for_completion(&rpc->complete);
 
 	return rpc->result;
@@ -1427,7 +1431,10 @@ static void start_worker(struct era *era)
 
 static void stop_worker(struct era *era)
 {
+	spin_lock(&era->rpc_lock);
 	atomic_set(&era->suspended, 1);
+	spin_unlock(&era->rpc_lock);
+
 	drain_workqueue(era->wq);
 }
 
-- 
2.55.0

