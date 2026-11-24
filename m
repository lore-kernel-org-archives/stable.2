Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534984;
	b=d3PrKllckwAAMxyQGt4sBrbG7shTmNzyx/7AN9TFPrez9IFRdx6vZ2mK44lWMZT1zDTB
	 scLaiEcPeH0lkAkMx7FoIOxjdjCq9ia+xxEKdN4Aq9/xnwJgrHLpSjSnL5WECdAe0W/EL
	 KZFVuFON0Z9NydoA3yDC4zOLdR+uNvfvHQat3NpDwgYxMCdYs7IKx9JJwMUGBNMTtyIWt
	 qVQeiKyM/UaRnlcq4D4K5Ma0Ue9WNnGrNEJlrPQuuU2jimp4Lk8wcEYsepjVFrwHXFja0
	 WylljB6N90AEo4nReBf+4hs2TaLQeX+FQpbd3Fog9LJJYrkrzW5UM/3Z3J544oTGgmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534984;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7sD8QLvolv+x5fEAFg4MgN4WMiBEj+c6MxxfS5MNWio=;
	b=tsgqVNs/C5Jx51t32poAsts3xA/7PVMpat/1LR1DoWe2vDjIFFLHKiO4/wJ3pBSYnWWj
	 s+hNV63vdv6H8yK814ArOqw10WCjMjuUNFn9k53jw94D8EruMJZAGiN+LgYlge63RGGVO
	 NXb37WbPkWI2czZxWIljK+/FZdrTHLIvPUUNJj1jmZz3EV2KCjR+hewy0+ScgGgQpxXYs
	 ldykAyB11iLtlYhA4OrhC/P0/VFni4OBvEyJ3lZAcFp6OROdDzqtq7bTW0YQS81j9qN4s
	 ta4TngKkxg9PeqWKZrGHklmtUPi3V7lDtib3QDLCz16XYoK1WZKL6hZjK5h1Wcs+5dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQ69OrYv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67B606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQ69OrYv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744BA1F000D1;
	Tue, 24 Nov 2026 15:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534984;
	bh=7sD8QLvolv+x5fEAFg4MgN4WMiBEj+c6MxxfS5MNWio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UQ69OrYvZuVD2x5/vtNw2qYE+WcYbIDFddsOOmelvQmA3rW/OR2Bhf2pSk1Qr2dR+
	 fpcByW2tAMewwAe8a7TREMYOH4bcjj76sdJ0Y+CFaOltd9kh+MDhxOJZY+HMmavVt5
	 N8gSlC3VbR/ej0vzV7neDtsi6QNbQT0hRA8hSZVlCYMKaaBZB29DWl0v0iVXihP0d7
	 /V1lVSbmskjVa6jiKgm3FngBJwpzN2uu3A1SqO9E7H/iumo7j7iYWW8ILXzNdRKOBr
	 12Er2EBjF4yNCzAvgWA/sIkBdkzU+QBOtZ2JiUdIyucsvMfSH0cl0mVI5FpPcyq2HA
	 9Pk6aXJcSwv7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuang Wang <nashuiliang@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] tracing/eprobe: Iterate trace_eprobe directly
Date: Tue, 24 Nov 2026 10:43:01 -0500
Message-ID: <20261124154254.4181285-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112427-galvanize-pointed-f15e@gregkh>
References: <2026112427-galvanize-pointed-f15e@gregkh>
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

From: Chuang Wang <nashuiliang@gmail.com>

[ Upstream commit f8bbf8b9901a09915d7b466ceb2bccc1fb5abea8 ]

Refer to the description in [1], we can skip "container_of()" following
"list_for_each_entry()" by using "list_for_each_entry()" with
"struct trace_eprobe" and "tp.list".

Also, this patch defines "for_each_trace_eprobe_tp" to simplify the code
of the same logic.

[1] https://lore.kernel.org/all/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com/

Link: https://lore.kernel.org/all/20230822022433.262478-1-nashuiliang@gmail.com/

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: be94710b1f6b ("tracing/eprobe: Install the trigger for every instance that enables the eprobe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_eprobe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 2c98e831808c0..161afacb5c7ca 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -41,6 +41,10 @@ struct eprobe_data {
 	struct trace_eprobe	*ep;
 };
 
+
+#define for_each_trace_eprobe_tp(ep, _tp) \
+	list_for_each_entry(ep, trace_probe_probe_list(_tp), tp.list)
+
 static int __trace_eprobe_create(int argc, const char *argv[]);
 
 static void trace_event_probe_cleanup(struct trace_eprobe *ep)
@@ -740,7 +744,7 @@ static int disable_eprobe(struct trace_eprobe *ep,
 static int enable_trace_eprobe(struct trace_event_call *call,
 			       struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 	bool enabled;
 	int ret = 0;
@@ -762,8 +766,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	if (enabled)
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		ep = container_of(pos, struct trace_eprobe, tp);
+	for_each_trace_eprobe_tp(ep, tp) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
@@ -780,8 +783,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 			 */
 			WARN_ON_ONCE(ret != -ENOMEM);
 
-			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-				ep = container_of(pos, struct trace_eprobe, tp);
+			for_each_trace_eprobe_tp(ep, tp) {
 				disable_eprobe(ep, file->tr);
 				if (!--cnt)
 					break;
@@ -799,7 +801,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 static int disable_trace_eprobe(struct trace_event_call *call,
 				struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 
 	tp = trace_probe_primary_from_call(call);
@@ -816,10 +818,8 @@ static int disable_trace_eprobe(struct trace_event_call *call,
 		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
 	if (!trace_probe_is_enabled(tp)) {
-		list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-			ep = container_of(pos, struct trace_eprobe, tp);
+		for_each_trace_eprobe_tp(ep, tp)
 			disable_eprobe(ep, file->tr);
-		}
 	}
 
  out:
-- 
2.53.0

