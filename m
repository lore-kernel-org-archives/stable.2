Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535874;
	b=kNPdAp2DIwpuULpH73CxsLTRueaPShSXOgfREVbkAReDXbyLkmvqnBaxfKf3zmf1tWhZ
	 YIvrb1jA21vgdJDPOC74OTWDcv6wwXw7nvJSEur0/KewhZEZKAiRXsryTlMwczkx4JTDo
	 QRKdJwM8Q25ZPkCt/wfNNJL6wseMUhNQbQvg9W5yqUxd9fPrRXFLmzah5oXOC3QKiyluH
	 efNM7hwndhwhBcRePK8o6yiyPf5WHZc0PpaIAZ7vttchX9ycyBEe/+dE+DTquj6VAcKPO
	 bDkRyn3jkbo28GheiHnB1VPsM3Vd+mhYAz0fZOVHlcmuX/dQImMQJk/tM1RMpgOfOXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g0gEaIRDTY1K69j/D5IaLboUedEzzbnxpazBSAu512A=;
	b=gXkZSKxfrVoDImA6Us8edF5+jyyrAQ5KuD734Mt+7/XDHX9Ncg6UoSumUTSVBiz0PFJ2
	 anFaJOucukxUE4J49cjYp8Ne5u96y2z78t5rE95bhzV0gOn3wehg5CJKIYGBhMLJoTVEw
	 1hvWI6HMlVTIi6vO7WmJrWDlYdrWKr4ZnYCLMSAhTeXenKP2yyWAnuGIjr7y2QsyIjy3x
	 CxwF4fXAxtf7tty5HkS35Kp7ZT1aYKmBJ66LzGktuwsZX1McYpz7ThQ0FVThe4H8TBg6j
	 XCiFNn3C2CwurUH38Ck8fTaJn63FdxfZyQLM+W8U48LCelYJCpprsZs64/vSj3L+GYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYJbVUzi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B34606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYJbVUzi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5EF1F000C6;
	Tue, 24 Nov 2026 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535873;
	bh=g0gEaIRDTY1K69j/D5IaLboUedEzzbnxpazBSAu512A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cYJbVUzisB6nAcdjLQei7OdkUCOzmXOtK3r9BNyqaUrX2RIPJUSsuUTA3gS+2Svgf
	 6UXwbSRU+/Kzw/ohImQpcanv73OsUe6obaATpPsjnrk0cJY3waOmvZUCOX+6FsnNMv
	 moDAlJt4r1YWB8fFmdfRBLdiwfehkv/HALSDTnWcgVdy7Cjqq9Umshv8S7W1xnEqZw
	 N4Mgb272Tw6MrCxybP4h1cjdPJFq18qdY+0XABR6FYkbcYcGj1GBGlPuu8K2qFKxHR
	 kAIFZ5I5Ea9g4yNftx2Q4JKGZOcCJX6yRwtsBF7HShWeg4yJCzd6e2sAFxnW/ivlJk
	 zciAYxhQTvJNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuang Wang <nashuiliang@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] tracing/eprobe: Iterate trace_eprobe directly
Date: Tue, 24 Nov 2026 10:57:51 -0500
Message-ID: <20261124155735.795316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112427-vastly-starter-c2ec@gregkh>
References: <2026112427-vastly-starter-c2ec@gregkh>
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
index dbe6ef2489a44..d0afe3250d5ce 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -38,6 +38,10 @@ struct eprobe_data {
 	struct trace_eprobe	*ep;
 };
 
+
+#define for_each_trace_eprobe_tp(ep, _tp) \
+	list_for_each_entry(ep, trace_probe_probe_list(_tp), tp.list)
+
 static int __trace_eprobe_create(int argc, const char *argv[]);
 
 static void trace_event_probe_cleanup(struct trace_eprobe *ep)
@@ -722,7 +726,7 @@ static int disable_eprobe(struct trace_eprobe *ep,
 static int enable_trace_eprobe(struct trace_event_call *call,
 			       struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 	bool enabled;
 	int ret = 0;
@@ -744,8 +748,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	if (enabled)
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		ep = container_of(pos, struct trace_eprobe, tp);
+	for_each_trace_eprobe_tp(ep, tp) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
@@ -762,8 +765,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 			 */
 			WARN_ON_ONCE(ret != -ENOMEM);
 
-			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-				ep = container_of(pos, struct trace_eprobe, tp);
+			for_each_trace_eprobe_tp(ep, tp) {
 				disable_eprobe(ep, file->tr);
 				if (!--cnt)
 					break;
@@ -781,7 +783,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 static int disable_trace_eprobe(struct trace_event_call *call,
 				struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 
 	tp = trace_probe_primary_from_call(call);
@@ -798,10 +800,8 @@ static int disable_trace_eprobe(struct trace_event_call *call,
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

