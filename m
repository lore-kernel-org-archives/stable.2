Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793479161;
	b=yeRIeZc/gp2sRzOi8ep9PYk/pO8YwzESM9uuutvNZLGUFzExBYyqCYjMs3bygc/8WJI6
	 OqbQr9xeweqSaggN6DGzvenkqYCNhphRZCQ1UCZq/FawnKfwQktX71HmNdlt/VmrjG4dj
	 X5K5kf+WtaZ14b2AsVr2hWpICuLwxfRwX/KOFiav5kCZL3IbDU5oVvQy4sNsUY9iMpdqR
	 IpIROGzyZDLZwhd1qu/NzUM8yHw6j7hVpA7Xvl+arh6Uw9itPRKp2HeLM2iLq15GIElnO
	 3+cMBwceQD5EkUMVZmIqVPmi8SayX+8wNHEaka0t4CftEdB/ABD+JVv3XqNiYSRkWkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793479161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lw1QeIPbva61X8kOSwfRbW2IpFMSjR97yWrLghxbqQs=;
	b=wwCJcdF/GoRsuLCf0lKx+/yVHFsxT+jEOOYYtfmEurf+WXRURrHiB8Vrfw0zjY4ty7dS
	 dK0lZJyfArBfcxVPllZ8Vs9PQSlhcCw/K92pqkHA7uoir1JwjMc8KSh7ZU7R6QZabIvs1
	 crG20HX6wIliCGnJ3cUHD4vbZWiIwLi1yZBiEH98eg2XSF7ChIeQLIfXZMKVmIT0paKtg
	 37OYky1a/6hgTS3oO6KF6Rx2H/bpb53qvX5SqcSBeYTz2wpj+6PUqKjswGxTA0VbfwtDn
	 AGzuZFnKGnIIjxknYGNmJwRYZz2jwDrhzmVawKCZsD+2I7n8LbDMD3tGkkV+/fIxu3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vnzncOL5;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141B606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 20:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B141B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vnzncOL5
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso18615605e9.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793479159; x=1794083959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw1QeIPbva61X8kOSwfRbW2IpFMSjR97yWrLghxbqQs=;
        b=vnzncOL56tJDqqOdKFxHy2ZiIzQGcH5TieMVIfutGfF47fn50E83iUFGfz63/dsONO
         pyZwMHwvQ5qQDsDf/5dsqMYoeiPPeyq/CfOZgdYBZenIAvf8LFjK8nqd8LcE8tr/N+Yl
         lfPURBQF7RFRTFhwY9iRsM/I0EhOh5OXJX2jdCdgGQLdmkyCn3DEOJ+EOGUZMIEPpA/d
         hbRipmVS1PneGisJlzprJwDG2AwcJLOcby9bqoByWJOyy8xpxOfQw9OYeCFoRlDZvtGE
         kr4JIPbc9bWdLtH30gOdpW3eecKnI5vYgvWOUWN8B6YDKaCp2G66IMaqyfuim85I4TvK
         hJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793479159; x=1794083959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw1QeIPbva61X8kOSwfRbW2IpFMSjR97yWrLghxbqQs=;
        b=KZW45/t6Mm0MooBN3KCR6xBNGotBv9oh642vxZKhiGxXn30AsD8f2p4/LsKjPR0Lqc
         lGiiCD7f022hiALISDuUHHsccmeYP14X5jIGht7IZAyCZbGBEhKN4tgr1BM+uey/Jt15
         DYBiUT/stQmJcuoySfnKW6jVuKGnM3ldlW7qHCR0/GvHVefEpPCyZHzMMKPw7IhBQwvP
         POSGmUwNEs0FIpDnR/l1qJFcXw4TD5kHRkXoByETxjUjjHZiFAPcbJJFw1/YGHpk0qA+
         J3M8Ddbg+kkS17yCX44R5o5UrTgxtGh92w6vly4T3UA8bVnj7c/8Ys6K4ZQDj9HGf/dx
         5NXQ==
X-Forwarded-Encrypted: i=1; AKwUvBy96LK1cJFH2+lhaKyRURIOjKM3uGh7U9EIjkgEK/wlcqaFWw9iFcZ9fBSHHtwO3yyYdFnFlyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJVTxdlN+I5wCs+cNi77FWR3+wafQfIEf5YYR3BLgrqHcytvBC
	14r74tT7EeQqL76SnuZDtaYRBZjwsppfJwUlj7sTodPBR3ESQGvxqtd2
X-Gm-Gg: AYBFou2AVbT/rjyCRo9cMfT3KHX08yQYxsBRjFZaMUOAuP3+tDaBb08V8SFxxC6uov5
	3B7YRNxMORL/gEkNcVBEF9A2iyFSWObiPMzx4bS1y08paEKMFvZVVDbdflfTIoNsqxx6M1GjMfe
	icQvz5n1CsYvT1go/oBeq2XOhH3BwPNE7so/jLFiXadZpSuIx//MZD4bp2m57bf5HatPYCDP7nr
	83jk8Bl46CNpO3MBDzssEHsFQPV1Bwpe4GTJb198EXP6CNIoLYmsDgJhtcvlZ+KDurJIWfjoee/
	YXHM+ngCcL3nm8IDb+2l0z7T1vEsTsgID/ryLLb+vo7nEEQW4lJ/90aCWE8TAGW/LLFTbqKvNav
	U/9vMG2tHJy/X6NAYogqToLc0FqPsM7ugXlMvP4uogkLTG6iPOjsMy3n7E+SIvE58Eo++qK3Wa0
	wJp6ZOs0A7m4cRsVSpi7fmPqyLG5KkQwaHi21hbxDrMrDJVFXA5hj8N73X8h7dqaZNZlDsZ6YZ6
	MT/Q4gmnX1zcBXRj7T4OUX2Jh5Aa/JwVMr9VUcUXjOkILGb48oBopLJLbgGrWFF2S40YIoAQZx3
	HGsV+ksOl/NtoNL8nKgujf7Ag1AP7kWlhiEZaBk+h5ePHxQjGtqeTzCoqfW+bI419zxl+SBfLrA
	KBBXGi18Vh1IemA==
X-Received: by 2002:a05:600c:870f:b0:4a2:1196:db0e with SMTP id 5b1f17b1804b1-4ac1899348bmr125929225e9.30.1793479158956;
        Sat, 31 Oct 2026 13:39:18 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a84esm11386624f8f.39.2026.10.31.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:39:18 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/eprobe: Install the trigger for every instance that enables the eprobe
Date: Sat, 31 Oct 2026 20:39:15 +0000
Message-ID: <20261031203915.491866-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The eprobe trigger lives in the instance of the enabling file, but it is
only added when the eprobe is first enabled and only removed when the
last file goes away. A second instance then records nothing, and the
first instance's trigger is left behind once the eprobe is disabled
there, so the eprobe can be deleted while that trigger still uses it.

Add and remove the trigger for each file.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_eprobe.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 998e6390937a..a0bc6fa1fc69 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -661,20 +661,20 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	} else
 		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
 
-	if (enabled)
+	/* The trigger lives in the instance of the file, add it for each file */
+	if (!file && enabled)
 		return 0;
 
 	for_each_trace_eprobe_tp(ep, tp) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
-		enabled = true;
 		cnt++;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled) {
+		if (cnt) {
 			/*
 			 * It's a bug if one failed for something other than memory
 			 * not being available but another eprobe succeeded.
@@ -709,18 +709,11 @@ static int disable_trace_eprobe(struct trace_event_call *call,
 	if (file) {
 		if (!trace_probe_get_file_link(tp, file))
 			return -ENOENT;
-		if (!trace_probe_has_single_file(tp))
-			goto out;
-		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-	} else
-		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
-
-	if (!trace_probe_is_enabled(tp)) {
 		for_each_trace_eprobe_tp(ep, tp)
 			disable_eprobe(ep, file->tr);
-	}
+	} else
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
- out:
 	if (file)
 		/*
 		 * Synchronization is done in below function. For perf event,
-- 
2.55.0

