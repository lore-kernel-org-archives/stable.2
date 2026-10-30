Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379867;
	b=sTTRU7tXOdITEP2Js2AkjZUUaL/TlQY/qWTMXS1XPCiZECgE/yCnLWFoECWqL82B+1EF
	 OoD9jtrKLHa2X1tW7WebC+BFMqPP3sNmd3TpNdN7dMy0Bu1PZghuWTqE4EejBKlIXOy7c
	 hLqlSDwMeRuC0GCVxp9kIrC/YbBt03mqUoTcgsGz4hKqDgM9QNnoZ8j1LwxmPw4924p63
	 zvtiuTHqQFsIl9hnmR0dhK2EFZbov8x9fGyelB6Bbzms6pr+JW1GDuzQqqfXrSaL8vOOY
	 6+k0uP6++nBmqVcxkLjJdrWQMDux1jWvIewtzMlkdLgIRtE5N5CAvY3cb2TZsDhXLow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lvTI4kYswy8nJRdl9QxlU0eMLqhgVMDUC7UVIheEm08=;
	b=kvplX5Jg5hydQSuSqG4sdysd6Z7jBPhK9DgyIsHvYQr415wRxP9ulmoJu93QZ4sHCGH0
	 vSBlGhFtliSDKYC/idUlMu0MAoy88YX/ngbImbKA2lP6KMzJKveFh8wrwIOTJvjbLXOtu
	 P8CAIcZ7vWCR3Gzz+A0nBzSSkl8h41zQz+YFA7mofF2VsLGU3Zq/buE+nrfu46nVAuNE8
	 UmfSlZuBvUmkMJ0fSRF6atpPPuGLYK1kRiOWim5OTge+HYDbgixXK/2fCae3hAk3e3gIk
	 z42rPEym94HQhx5ZabfG/A8wEd6BiGcw32ST1fBAfy7hunOfsNfLyFh+imleyFS8wLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qAh5QXhW;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586D606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9586D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qAh5QXhW
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so9950495e9.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379866; x=1793984666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvTI4kYswy8nJRdl9QxlU0eMLqhgVMDUC7UVIheEm08=;
        b=qAh5QXhWpUpVvZMP7HgQmJRPhLlItfGnffF+wryoIEIuocg0Z3gTKtBHdosKEChlxf
         ovHownzIogEm7xNYDI9iJm2f+NYYU1Tx1r/ioHcJxav7mUfXGZPJ0FtMVQxRs9FL9UPQ
         94KTHoT0AoFujNpX6kbCJRQ+LSr5OKQcpEddxTHhwZ3HgLsakt00sIJoDrlEF237XCMq
         +v4m1YZYq5Uw9S7epp/OnOLBuPrClv3Ldw7FIyk6rJ4Fu+2R1UpAA87jNdYMbxEF2kZJ
         vmFWyP0c1Xy7xcrVnk/FIJjG2iFnCjmGjGu/Or93vFfwZj5BkW0JQ83VO9sLO2bMsxpJ
         1emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379866; x=1793984666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvTI4kYswy8nJRdl9QxlU0eMLqhgVMDUC7UVIheEm08=;
        b=dGTeKrA6pdjP9yRcIyxPnJwlInKMtOde4yhbkKuybpwqjszkgRWS0Fv3cyLAF9zdPs
         8mu3sshmGAfecWJjOt48wWEgmF72TVwT6uF/lhbL+pKskJu6VN3OkpJC8liN7nHQoXfg
         msmA8CbG+bJIEFc1bK781taZ00qI98FPRydGoMbk7ig7YApZHBGdSNWcz4MbJqqHXZP4
         S1F7AQQKJrqMoTBoHwrcRCNEHHWEiK8XeDTIZBSAt6lrgXT+mTYrtKLFeM+i643679A/
         k4vto1oW1AmwdszVdh9NdnAo6QgTwM2VdeAfUe3CteluLgq8aWjqPxf1LfSfn3uPWNz/
         hFrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzCOItJxQB5dtyAKj+HSz1U6k4MR9sSjRn8l3tVBo6Elkw6JjWgnzQS4JcDQFwvjU2/LE/CnA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1vJ+jErPXhUDtWA7ipKn+pku0li1um6OKgOb7l98dd1X5rR9Y
	xlmgl4K25/AC/4nN5Qi5EpdGsYMnr4m0DD/PLdq9ZjizQIp/ytmd+HI=
X-Gm-Gg: AYBFou26uEr9j18kfElXJ1BnY7i4qBapRb3Lc3U/lGKRV6ldTCsZrq9+YJ9/F0B5Iwo
	5nw44H3a+NGtjUhYkdkIWCvFuw/2DsE6mTA8PP/fUV4++eah+aXtyehVvT9p62oIMeHQw/DPHA3
	XtApMUl+Zs5WeHXoY+uK5hzyJ+hQHtBXaWLGLl99sjpAe3jJZ4oVCCOrCVAmDvU2j+a5a1sS5NW
	jZAY34uTGFgZWkBbW51TOOU16setqfgluM2GZnxTC166PTgQtCA1DBYazxaMnzvi/lYgp+wtGB4
	TETDHrAV7alaEUR2lTq2/c02cdk9WTWTI3KSZhZQKnw4L2nMrhdBPgCdNbAjRfK+eQJhGi8JS3U
	ADT7al50deeXxGdFTQJgx90fKqh1WuhZEZwe1k6dmb0anfRwAn7irUZ5T39DPGYOZYT5L8pyIRx
	/6P+1HDkx2mXNjiSF1qeOgeLVFJ+DRcfDj4zZLZqboVo27iQMThFGt+J7YWvdoScST+gDvQPpvH
	NBhOkincrhMp6jhk/iITSgigscPjIfVq/boa3eUQfNuLbt323bRLskZ/EGVpugQQ/bBaPGDNr2a
	foyDnGQ4qaay
X-Received: by 2002:a05:600c:8b55:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4ac19234a06mr63464125e9.31.1793379865897;
        Fri, 30 Oct 2026 10:04:25 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf7146621sm75121785e9.13.2026.10.30.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:04:24 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Mark Brown <broonie@kernel.org>,
	Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v4 3/4] ASoC: twl6040: cancel headset jack work on component removal
Date: Fri, 30 Oct 2026 17:04:15 +0000
Message-ID: <20261030170416.3561618-4-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030170416.3561618-1-tristan@talencesecurity.com>
References: <20261030170416.3561618-1-tristan@talencesecurity.com>
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

The twl6040 codec driver initializes a delayed work for headset jack
detection (hs_jack.work) but the component remove callback only frees
the plug IRQ without cancelling the pending work.

Free the IRQ first so that the threaded handler cannot schedule new
work, then cancel any residual queued work synchronously.  This
ordering prevents the race where the handler fires between a cancel
and the free_irq, re-arming the work after it was drained.

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 650836f9615fb..826bde1a9ba46 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1136,6 +1136,7 @@ static void twl6040_remove(struct snd_soc_component *component)
 	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	free_irq(priv->plug_irq, component);
+	cancel_delayed_work_sync(&priv->hs_jack.work);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
-- 
2.47.3

