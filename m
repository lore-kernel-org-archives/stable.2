Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532726;
	b=E9Sohq5Ie8JubBlkG8AyTTKTrrwKq/DjO7BM8s9So0oUae91qi3+E0VwmSVAPlF7hvcK
	 ZrtU1XKhpdidnZzfUzqHMcURzhT9Ax1d1DziU3GfTJCqjUjLPQzCxs2nLcUK/+VTtuaNT
	 0sPlEDReTJ1U71nb4L1t0o6+Sl/DOVfkk9fOtdd543wGSCYklzZaGilL2vPFXV8XGCQtw
	 11JOnnzRdE1u8+DEha7c9yAUTUiOf9N/0UehQPZa8j87s6xMz4nMCuQZ9rszN1kYoP2LD
	 579obArrf6kdl1U8nNHQgORYFkCX1ot2CjPePDGujJ269z0END63U9+FY9YH2lSnjLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VasWpqSUZYD0V4VYxxbwomWuyZegnnIz6kc2wFLpprs=;
	b=JTvO1MBAcVSxoPUm4QrP2ncE6CpPqWypGI1fRKegaKvji5sFb6T1AP/eKsSotv6AoQuG
	 XrRtKQFTsmASN9eKkdpMoqUkfmjTjDHrq9bnPb+sBPd4RKbruEmuaZtFx0n1++OE9NIbg
	 j3Zm+b8LpOEEiJSqpy8kNCzE+UOCXYN0QJ7AP6+Y8dWraoVXmO2EoJbjGwXLA/4JWAS3l
	 K1s+rO+dbDZ8IwhxwXn6J4wb7ui3LD60kuWbtwe2l7+nqTxzUXGGrVkw/I7G9Iae01iE4
	 Q+QiuolvBQzEF37TEPfWqpzxadesKHwaPbjkIKDI5sTMOwYU3Gk7E8lloOo4X3l7lCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbwr0IK0;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F9606A882
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A29F9606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbwr0IK0
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8241a56cd70so479838a34.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794532725; x=1795137525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VasWpqSUZYD0V4VYxxbwomWuyZegnnIz6kc2wFLpprs=;
        b=Gbwr0IK0qd1Y/y7HBMuf9IUXwTm1GD3GcGNZPmJ1lAYZJxS9CEQryMc6NhKoIJE+Bo
         d/DETRVD7Yr2TJ8MnzMvwdJDeGO9PKieWKkwVjxjdFHx0x19ePXKYdMSqKnWlb6hb9nH
         HLwKuCTlpOhDLIIzPqad5DgqCy+q7YvwdAH1w70j2nhoeD9L0veIb9fe7xqnNpLV+1Ro
         hoy7/e9qlNO958nQJ5LfomK6a1419t6AZ6MEdEbyJ+YqNgg9rTUe1pRbBNLpgzyJt78S
         wqm3q4S8sjeCQf1kBhJfKIWq/4VHU3brAqcQL8gYfp06+ntjJmGtD9NBGWRPEOwhXoQ+
         ytDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794532725; x=1795137525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VasWpqSUZYD0V4VYxxbwomWuyZegnnIz6kc2wFLpprs=;
        b=20aIL2lvBHKEA4yzKLArJ8kQCorklk+EEesa0hksvtNPnizvV1+rzdg9p7cS0FVtEZ
         +oHEq7ux9CMuRNpvXlDuSjZ27mhhm/dRufJ3vakFN9IFT2dKpeKuRPqphak7kOVrHSwt
         ulR7K841w0GMlWTo2T2zplUxojO/kdEroRnIKtwWipkUyBCXA3QGKmdFCqT2jCGnw48h
         hseiuqE371pQIVSX5Y5x1ySLnDzYMSiIrngSz71ZztihrL5v914NrdoEPVPw0LKrzg16
         E/1XAvV2J1d42uj16A+Ds/ZXhLOFmqfAUWI5NRA6tMxdqmtO/UuJmNzVYgsE9SKuYuDj
         KDHw==
X-Forwarded-Encrypted: i=1; AL+hErEgfH7t2BYRK48WzNlRhrbr810v52yZ7HRrgdnsIDqxVXD0rnqdZ//O0fkT3LT/MCP45MxGmCw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XCKPKatP5mEgdnUhkalj93BbMujcgE5cuJeFKzbQE+jhRCaaV
	vrRz2qcgx47ZsmVjLLvedRuwk6zFSAruYW0pL/ba+7rLqyNoj9wnHyvS
X-Gm-Gg: AYBFou2FPLeYawRJgCZNSw8awC7WwOIg0kAQ+FKzLTYinBSbemflvlBo8dBPrWM5htJ
	56ykq4jTJfHGx7VCC+VP7StLPbeDR5KQhRg2NncE9g9DNC6URvroN/cbnWilC211OacAnoC8z1D
	RehlralkZr2TDoK26aFOFVDoj1udHQmkMsLi0x9k9/ieObJZjdidWzfHzI9RzVn2jmIg9X5OLRb
	hiZ7oQqcUr/TGonyWpIrWfmMo8R0O01LoGCPoBDRUwIhTeKzbUV+U6A88UdlWEgtPSvr3vdWR4D
	bX92kGnzk4ZdWagWQlVBJV92qMtVh2Q23M4tcgqGqzABJxBCyTDeQazWIm51yHdFxXDuIc8mRrR
	7nz7Il0Z3H7viloAxML7Jv6P7Th69Ue7kkX2niHDMuUFq637aG5sxWif/9Rwnjb5mY8jxqvrUWD
	isjuSrm5C9K7u9Boy+sAOMNTChS8zxcu4TydOXAd1nosSM6Ib8nlTvm4ZW3SUsBbF4V0WSGBEtQ
	XPRBUYNdxFDn6C2MnTAKSlz/bwjfXFrjEOfbzgemhuqP+FcYS3clLKYqIZW2IFrLWF1TtVfsVfw
	fiQhvBX7lbxvzZFz/BC3GVmlq+qXvz8/q6mHaCoZ60db2oDt+S+uIY6CbmwVkw6aPbgOQQhsvZL
	VWy6y84OCXMATLnE1MguGeRVnFyCt4lZ9eoDwq2VLGgOeWoO65D1cEbU=
X-Received: by 2002:a05:6830:914:b0:843:8982:9532 with SMTP id 46e09a7af769-8628992d65cmr1277963a34.28.1794532724575;
        Thu, 12 Nov 2026 17:18:44 -0800 (PST)
Received: from cachyos-x8664 (fixed-186-96-141-48.totalplay.net. [186.96.141.48])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862880a5298sm1230599a34.7.2026.11.12.17.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:18:44 -0800 (PST)
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>,
	stable@vger.kernel.org,
	syzbot+1a7507a194fff09e5c44@syzkaller.appspotmail.com
Subject: [PATCH] media: em28xx: clear dev->v4l2 when v4l2 init fails
Date: Thu, 12 Nov 2026 19:12:34 -0600
Message-ID: <20261113011234.45270-1-diegomancera.dev@gmail.com>
X-Mailer: git-send-email 2.56.1
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

In em28xx_v4l2_init(), if an error occurs after video_register_device()
succeeds, the unregister_dev error path unregisters the video devices and
drops the initial v4l2_dev reference, but leaves dev->v4l2 set.

An em28xx_v4l2_open() call already in progress (such as from v4l_id)
that blocked on dev->lock while em28xx_v4l2_init() held it will then
find dev->v4l2 still non-NULL and succeed on an unregistered node
instead of returning -ENODEV. When the device is later disconnected,
em28xx_v4l2_fini() also sees dev->v4l2 is still set and calls
v4l2_device_put() a second time, dropping the refcount to zero and
freeing v4l2 while v4l_id still holds it, causing a slab-use-after-free
in v4l2_open().

Fix this by clearing dev->v4l2 under dev->lock in the unregister_dev
error path of em28xx_v4l2_init().

Fixes: 288254383674 ("media: em28xx: use v4l2_device release callback")
Cc: stable@vger.kernel.org
Reported-by: syzbot+1a7507a194fff09e5c44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1a7507a194fff09e5c44
Assisted-by: Gemini
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
---
Note: compile-tested drivers/media/usb/em28xx/em28xx_video.o with allmodconfig (no warnings); not runtime-tested locally against the syzbot reproducer.

 drivers/media/usb/em28xx/em28xx-video.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 84424284d486..f78325a41124 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -3129,6 +3129,12 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 		vb2_video_unregister_device(&v4l2->vdev);
 	}
 
+	/*
+	 * Clear dev->v4l2 to prevent an in-progress em28xx_v4l2_open() from
+	 * succeeding on an unregistered node (returning -ENODEV instead) and
+	 * to prevent em28xx_v4l2_fini() from tearing down the instance again.
+	 */
+	dev->v4l2 = NULL;
 	mutex_unlock(&dev->lock);
 
 	/*
-- 
2.56.1

