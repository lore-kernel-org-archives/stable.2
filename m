Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157983;
	b=C3b+fWLwJeOPtXkIS7ks6lh+mljvEhnm3RYpzbeyT3onH4+C46xWO2wPl4tgof+rVlyG
	 +M/W2O+/gkxuEVmEqh0y0wzTyDIVqZflMZ0i8R8S2hntZgc+fLNzH6D+1IuzwdIUD5ohH
	 YIcZ0CJX5XAUPJIw95khkb/DMRBlpC8MhsqBUV8hHgmV3rXLZqZdJh00XX/n/IO//EiW4
	 7idsClxt6EM0LN7vrdnAG43KuqDd4zlRdrZOY/XEjOZc8PzOPGIC4bzOudWvvzfYtBBHy
	 K/dr7z3g9yUBUKeDrs+PvGZJ/9WYKkb6kj0KUlrVTTKiNnRgWsHJED2rmTzBRaBRi6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157983;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gCcQcz3vL7Ebq2RRTVorvG0AcFp5DKW0uLVeX7DCrkg=;
	b=TFggX7Bhr+swfGfZqwQLqvhI90PcALQYbe6wm5RT+a9PWa1bXiZM8TZ+KaJs6QpN8D9y
	 YnC5QlYYIt26ajVdQ6/DczW05umKRje6l/vzg6TnorUp4PDr6mnlFhjdpbZYs+NOANR8F
	 Ulzww8sUFkqgYTj+rpfx6o/iJv+3EUW53X5GfKmuJyG9+4igLr3lgaLVbHMZWkFhWcEPi
	 W6+jaECSteGCZFzLAUYjTuQNcOblqsFttvxo3ZLLenoZyRZmZPnJuDrIKACh3Woq9QJXM
	 GqGDA20/JZj70NNZae3rxh2aHWj2zjQvMo/V/OyPzt8xF9/W6XPs5/wCizby6XrjCDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=gYkejC5G;
	arc=none smtp.remote-ip=43.163.128.49
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CFA606A31D;
	Wed, 28 Oct 2026 03:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21CFA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=gYkejC5G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793157973; bh=gCcQcz3vL7Ebq2RRTVorvG0AcFp5DKW0uLVeX7DCrkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gYkejC5G2hCURTckIF0HNwJ4a0YAXUOcvhkCBLT2xDaU4InaVhPX5qhd1FxmwqjuR
	 RlaZW5hh7JYafWiJVISwIS1e1bn34AsJFzvEpuG/IB2JnEn4wSr+0L77qqG3rz02B+
	 Goiss15Y1d3TgsiSUSCmkqO2lew1nGMEvGhGoce0=
Received: from CRASHEDROM.localdomain ([117.147.101.47])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 66D82CB3; Wed, 28 Oct 2026 11:25:45 +0800
X-QQ-mid: xmsmtpt1793157970tyw533o60
Message-ID: <tencent_01EA70DD2A37DFF1634781DAD4E349400008@qq.com>
X-QQ-XMAILINFO: OYiA/jx4/AJLdUbwfnfg0qmp3vHcIP2d0UkdZ85UuvWxR4ci7eUADYXQNJuo6C
	 TLNopZ81VUY9RAqDadlnt8xjTTi0stCxHdA1woYvQcoT0YrVsg+myOesD5SfkHfGA0KA5jjtZom9
	 b55XD8B3mz2ODAtboRBRY7pEgRH//oPLdNN6ZJskk6WpE5trbVqFrjZWgTAZ1uoT6AnGJ3kkTyW1
	 wiWRCnZPKL2ChJk0ipfN7PdmfpBuIgJ64Zr6tLWOzYXqQFyVsXkPs/Jo8b4EDIe5JYnOHnpPjdRf
	 bF0fLPutWm2JCafss4JKm6nN4SWl9TnLKokCsvt2msX8e21RkTNr1HFqE3kDNwRwedoGax8MEuHp
	 ojaa+8+Pv1k5tYuvLQU9UHf8PKjOorJTPsWgyuXaqjCnkKuvGUsjbv/mZUa7V3GTzI7J2u4xdUQb
	 CIgFWbQxOih9m+kqdY/e95aHREmFxOD/4r7HUmjQyjXtKzp4whnZnBHRMZa73F/gRcNElabHFWd7
	 rPfPwW+gObSuNT1be5C+E2BRfgBu/n0corWwhkVyiRLzPRBTR8f6Vl4VlXJsTD2kepvmiFPdMjOS
	 iqjT3fFH3eAQflNQ7av048aQ5WV2JrV5MGeSTd5nYkuRXbimSnPg5Bu4EO3O9kI+rrphA9ER1Lht
	 2dr87sLg/TmNwoZw85+18FJ53sy5aAruKhyUEu4Y5Qw19QZWGehRWOrUlX9B+Ve0pVsQYE9FdSkA
	 aDNxoEXEyVdNfE2R6Ag+yUAvnOIYdG+pm2xMDVHFAg/eN82BW0H4wepVEaJGGWr+nlQIxYB/Nlr/
	 DdOT2vDaSCBFFQIECxatsRHE8Q3ESwyocb/jdyB/9w9QuOoDbkQIZZE/xFZhRc0LSP0zu8HPSL7h
	 aNdFF1QcrpQbA5OrQPXFJmPby8DBrMr5dK0ldzj/aShiLKb0I8rm3U/o/7BVrcNGr02SPejVfF8J
	 ZgzDoTuc+JogP5kEB2QWJ/yFGeb2gvOXGzsZQCg48yRiAcroSBjaE3YXb3e+rjKpxW6umOF1tqzL
	 6ewFpWilzP0Js1xrVEzFOzPZRdYNShwrPrZUrD9StT9sfsD+oknET/yDLMTYA=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Chengyu Liu <19290937@qq.com>
To: khc@pm.waw.pl,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Chengyu Liu <19290937@qq.com>
Subject: [PATCH net 2/2] hdlc_fr: shut down the LMI timer in fr_destroy()
Date: Wed, 28 Oct 2026 11:23:10 +0800
X-OQ-MSGID: <20261028032310.2832307-3-19290937@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028032310.2832307-1-19290937@qq.com>
References: <20261028032310.2832307-1-19290937@qq.com>
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

fr_start() arms state(hdlc)->timer when LMI is enabled
(settings.lmi != LMI_NONE).  The only deletion lives in fr_stop(), which
is unreachable on the protocol-detach path: detach_hdlc_protocol() calls
only ->detach() (never ->stop()) and then kfree()s hdlc->state.  FR's
->detach, fr_destroy(), tears down the PVC list but never touches the
timer, so unregistering an up FR device with LMI enabled leaves the timer
armed on top of freed memory; fr_timer() then fires into the dead
frad_state.

Shut the timer down at the top of fr_destroy().  Use
timer_shutdown_sync() so the timer cannot be re-armed afterwards,
matching the CVE-2026-63803 ppp fix (ppp_timer_release()).

Initialize the timer in fr_ioctl() when the protocol is attached and
drop the timer_setup() from fr_start(): attach_hdlc_protocol() uses
kmalloc() (not kzalloc), so state(hdlc)->timer is uninitialized garbage
until the first timer_setup() and fr_destroy() must never run
timer_shutdown_sync() on it.

This bug was found by static analysis and confirmed with a KASAN
reproducer: slab-use-after-free in the timer softirq after rmmod of an
up Frame Relay HDLC device with LMI enabled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <19290937@qq.com>
---
 drivers/net/wan/hdlc_fr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
index 5f0e54ed1e..2086ff85b5 100644
--- a/drivers/net/wan/hdlc_fr.c
+++ b/drivers/net/wan/hdlc_fr.c
@@ -1009,7 +1009,6 @@ static void fr_start(struct net_device *dev)
 		state(hdlc)->txseq = state(hdlc)->rxseq = 0;
 
 		state(hdlc)->dev = dev;
-		timer_setup(&state(hdlc)->timer, fr_timer, 0);
 		/* First poll after 1 s */
 		state(hdlc)->timer.expires = jiffies + HZ;
 		add_timer(&state(hdlc)->timer);
@@ -1153,6 +1152,9 @@ static void fr_destroy(struct net_device *frad)
 	hdlc_device *hdlc = dev_to_hdlc(frad);
 	struct pvc_device *pvc = state(hdlc)->first_pvc;
 
+	/* The LMI timer must not outlive the state being torn down. */
+	timer_shutdown_sync(&state(hdlc)->timer);
+
 	state(hdlc)->first_pvc = NULL; /* All PVCs destroyed */
 	state(hdlc)->dce_pvc_count = 0;
 	state(hdlc)->dce_changed = 1;
@@ -1242,6 +1244,7 @@ static int fr_ioctl(struct net_device *dev, struct if_settings *ifs)
 				return result;
 			state(hdlc)->first_pvc = NULL;
 			state(hdlc)->dce_pvc_count = 0;
+			timer_setup(&state(hdlc)->timer, fr_timer, 0);
 		}
 		memcpy(&state(hdlc)->settings, &new_settings, size);
 		dev->type = ARPHRD_FRAD;
-- 
2.25.1

