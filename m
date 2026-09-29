Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA58234EEEE;
	Tue, 29 Sep 2026 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683564; cv=none; b=jV7Nlnhfm2LYt9sgLZA6N/sOsUJJzjSGuPnVOKPTYkaq7567zFARk/VNTmdPtRh5n8+dG9Ra2lZqb2iUHIpN5Ysp+iHuMOWLkJMjt+yaNLkBTRNC90P7NiHfXaWCorhxV3UDKQ5WJY/JqN1eYISNUHWfND4XS6rJjVoW/YNTTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683564; c=relaxed/simple;
	bh=skBfSfkaVniukQJGyOyvGfb0mKkFM2RTSY+kessAl54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Deaj5QvcgO8j97VIncpl/fkAydr+2JVmHRBNjwRKIfK0J305z9UR3QM+EZ+GeeJi2Qei2M4PXEcYzeWJqUDBT2iSr7jO5/s+sSjlcS3rfTBGRBewHi/QgYn2LHSDW2RBBwTj9p/zuZv3ugNZKxcMqd70oJgo7jB5Er22xKx9x2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Y9shfjEY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUclTctN; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Y9shfjEY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUclTctN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B85E4EC1602;
	Tue, 29 Sep 2026 08:05:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 29 Sep 2026 08:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1790683559; x=1790769959; bh=acvOpX8oC8
	06uQi/KvtOpClju+a1Tt50eVgVxmyNPdw=; b=Y9shfjEY5f8aRnEGhR56DGx0yR
	jH9vQCy6VIg1dMC9gpyLkBdrMt4TJhNKWVj+O0TXUIsZLdErQAsIO0w9fjku88D4
	FrWxhGfcc9lobv7rsGG7A8zHo8gRtWADeyISDVmP6n7rnYlk6V26syV7GZSmleWH
	sSppMwLOUKnWtiQKXZkecsr2ZoeoUeYbApL3ev2bu/WDqhSOK9DF776rcAi00o5R
	r7Pvlxka1GwA2NCncqop8CnUYBy9lvSacAPqYKGWi/Ry4870afMrE4oKP1lfqAj6
	ZKP9rIkaibxcvD6OUA+SE/SxHw7bCZZ4RLlgZEu5EMrUwtN2egabjlVnWwyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790683559; x=1790769959; bh=acvOpX8oC806uQi/KvtOpClju+a1Tt50eVg
	VxmyNPdw=; b=gUclTctNggsty1MdR8xbse0D61/P9kB1UXk3zgrDJl7HyLTpVoG
	8iO/+B2mJ+BNIO99YkJ8D2weCZvidRpuXenU5kSGpZXbVGx6HlVfRxthy41g+KmK
	jzEic2VepiJ1do4DQrLtqxYsmSeaD6kcJP5dsI6+2lkn+Jcq9xM57V+sJDtxGRz7
	8kF5xcjLaomc9iqoeHRxEWCpsO3IaEsvMtOaMUHZ8tVYKOLeOB2DD+6NDBBIgOL6
	AW4Wnqt4BOBJCVW2LEwvt9bcZ1yGqCgIaGQczcncslB5464SKVsyLthcgUs1PSFc
	KuEbJ5pAMZtYIwT/9LNysD6NL6oK8a6aZ4A==
X-ME-Sender: <xms:p6m7aue0SZhM0QHe8dw7tGaByG50xU1DJaanIjP0DKCBP6kQu2XuDA>
    <xme:p6m7apu6fqwtJvBHIKztbJNgES81g-PeVYFvqMxB8gDvDUAdnv4kF084yuREbVkW3
    QQjOyo3XZtfHXxM0U21bvfXuumxM1iwD8A7-BO6bteZQ239SMdgt3S8>
X-ME-Received: <xmr:p6m7avlylvN1-E9HCmOvDuL4IxQvxJOFy1fzhcakinEGLBSMkdKbnieJIvXK>
X-ME-Proxy-Cause: dmFkZTEkBcLF+K+iaumu8iwovLtbdPYDZluHM1adBFRuLH5vjH9BiU3/FALEDeZnlAq9x4
    QAa5zW4PI2qMplT+YfHT3Wy/0sZVxC62QczIAJ6cBlzzDSQZEZMtzRqgdZjGrMdgzJtLj6
    HbV2DKCEtpPBknVXqvONKZAWIVTgV4VA7U3mMEUAPNFtBol4yT5PABvifcNHR9vaMdzfZF
    cpgxClwUVAb8wKe4lTbmfvC2L5+X+4yQ5cuwPJ7YKh8ODR++mcWSRdOUWoUqo93dto2zTQ
    CDnOxAITSWv+JX89LX+a8kvkEQXpKP3GHCPmKIBQppcs0z6fizJB76/nznli7IBab0rtMK
    Z6UqS0SOE7bxskX/YeNLXls+60llmS6oHq8LIWebJpHKLmTAWKBzVHCBkbblxJjMdnEHx9
    nYbXrwyQgHpWx2Mfn51iwmnYJWwmrrfzhNNZ6BNCOikhqwWEi9bXnG8wazC1ZyUZBviPQK
    SCr2iB+S1C90WDBpq902VlQyNxlC08KW4d4LKpQcYRqBMFmdx4LSebh3bLgstDxjfHOh7g
    P/dFAPlzFfNej+q6mpQeiAIuTolZ+TQFUuc4+IH/QEvFwhEdDrPEACiSJ4Jj8UEnl0Jsf+
    isoNOBhzeYZjNky9ktZfp46anQOs1YA3k6LjRRwGob1TgMqqRgzqBK6cGQBg
X-ME-Proxy: <xmx:p6m7arwD49G5PSH1xoKDyGn-RXtEHwocLNSYQTCQ1saqmnx-2h8ldA>
    <xmx:p6m7ahPHjCIiAjlWkkiqzIegivMxWFPHRA3RWatkO25qsB4fE8e5fA>
    <xmx:p6m7anoWwSfT8btwoUvpq4nsCNUBK-PYNnDJ_yKzwFEZxSmbmlbZGw>
    <xmx:p6m7aqGIozSJGI3jvAiU7VEvVKIqtlfDirNECMz2seenW4ymv_L_Uw>
    <xmx:p6m7akxCscCijQXRDiSsL1gP6Ebqu2UXiNcdTFKijVQa2Va2qhWd7CgG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 08:05:58 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] strparser: make sure __strp_recv isn't running before tearing down the parser
Date: Tue, 29 Sep 2026 14:05:52 +0200
Message-ID: <f06217a9b95b7027286c7df21336e67e334c3e6e.1790674872.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment above strp_done() claims that if strp is stopped,
strp_recv will no longer be called. That's only true if the caller has
a mechanism (eg locking) to guarantee that strp_recv() calls that
started before strp_stop() have completed by the time we call
strp_done().

This adds a lock_sock/release_sock pair to guarantee that any
in-flight strp_recv() (which runs under either bh_lock_sock or
lock_sock, depending if it's called from ->sk_data_ready or strp_work)
has completed.

Only espintcp can be affected by this race condition, but this patch
makes sure no future user of strp can have the bug.

This could crash on strp->sk ("general mode" of strp), but this mode
has been here for 9 years and has never been used.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/
Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Reviewed-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v2: no code change, just add Cc: stable and Reviewed-by: tags
v1: https://lore.kernel.org/all/4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net

 net/strparser/strparser.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index a23f4b4dfc67..401e67533005 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -511,6 +511,10 @@ void strp_done(struct strparser *strp)
 {
 	WARN_ON(!strp->stopped);
 
+	lock_sock(strp->sk);
+	/* sync with pending strp_recv */
+	release_sock(strp->sk);
+
 	cancel_delayed_work_sync(&strp->msg_timer_work);
 	cancel_work_sync(&strp->work);
 
-- 
2.55.0

