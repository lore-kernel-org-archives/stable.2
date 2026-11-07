Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068227;
	b=WAaZHJOEMF4vTruLawuY3EEzxRwytx0Uh+HSbr42H7UniKztQMWlbRgz2BI7l/q6pTc6
	 3eLMV23/lC7AbftQ2HTG9xrtvsjluOdxuB6ScfVFtmyDLJRoMWfPnaui0f3wb8i2voB52
	 tFi2Uty3hcHMMga537zduzdDfs2B8NLW6w8WW6MVjClcFTmzn1Kt+kE736Jqji+kFm8Ig
	 XUMdxFlG4zOVgw/9WacFSgfCI0qJwpkSxKi5UYmVZaVyBEoHotDYthqRniMrNTMhglh9p
	 8lItpQ6fW2Frai8OOaksmVlkjVPt6OztLLzeWkNV/pR5/O7w/SMWDQV650ObK6INmFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=80NHUdfBUevINay9/ZU6VPfFS6YJqKUSm4yVfpp6zWM=;
	b=kGB1h0K/ryzwTuh5ZQ/WLkarGC18sZDCqRqg0TF5u5r2+tPBJGR8x/K4YyLYsouEpPNC
	 rthb7e4pLmmCSln8n6p14pZ7U8SqRL7WIQxcLIjE/3MflVSpbqTRZNBXp6eMJIQ9tn/De
	 LdjnR6dLEv5R5GnUOQzdJjuhZOG3RzGujoX8P1kdpbHixgeBNniHwNj14UG69ijNEqeuf
	 8d+gT/kmS+ecqRBdFKpTrtQLWnPNUY1NveIkfCxBuT+FFztIIWwa6bj57XSQYv09RykuW
	 zK599xcdkRrpSr6e9+CwioJ4evIP6MAtd9GCrv8VaVijh/UPiIYJmr3znb1S+1kSOLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="n2iCf2L/";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A5606AC13
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC1A5606AC13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2iCf2L/
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb2893531bso916517a12.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068226; x=1794673026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=80NHUdfBUevINay9/ZU6VPfFS6YJqKUSm4yVfpp6zWM=;
        b=n2iCf2L/vIP4eW5BtvCPfcK+HBmBvH6JiGENKI0JJ1c9ciGnBdoHi2UkdWIkz79+4n
         /KYAqiYu5DOnrfXKkDHTVgSa/yYJO0oIhVEgqB3AKUGPGK0rMnuBs6jPU9xRB7tw8Nsv
         f8pOcDlAT0WygtaCRrXHl68DzDIy6Mebi/7ZkStwC/pxCurX9/70RdEpjEb0jawQZpx0
         16z2rhRbKRVwgIjElYo0yk43Cuwo/7u/FlLGUFOH6GFkkuExMuxI+I/TJpsmBDknQBtf
         /HLqWW7uT6dkSLgFDdqXruoliHWvNf8miQ1mJGdaPmS99iQd1aWKNS/XmqHQq6ComJ3V
         xtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068226; x=1794673026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=80NHUdfBUevINay9/ZU6VPfFS6YJqKUSm4yVfpp6zWM=;
        b=vR2ieU1BihAzuU/OsGHFs4/dZI3ju4MG94VxDqM0BkJPkVzFnca6oVJx76RKFG2cRf
         6xwtEx7uJ8gakR4E5FQDXvaYuFFAXGzd04B/xpg2MBslZ5t41XnSXrvS/dZOFgLHzgl1
         ovHzf7d7Ln+9MbuFC6EwWPmdbh2YLuw4XJ99fd5W0fs0rdBJ4WnqiOTrQa0uvg6s/AMv
         0DHNX492za3OW+ygIqXjUGCz4G4s88xwz0NBLDs7bnXCjrUppvO113Tv+wwcToDcijqU
         B6pf8VvSMikL/1Ilil2ZDZUcY8ACLRs6PsCdlO4vZDxGX3hMVoJLm9OHUvgVX16xCROJ
         Xbxw==
X-Gm-Message-State: APuU4Z84tE0B0Ob4iF8bTFzueM99omR4bRARQCjP/w5p4yGw3WXQm4fW
	dbjw0NuDB7O+P5lKWqkfcqgjPhZi8DS7BxdCRV9JaGayOiXmMFw0boIQROVB7Lz8bPvSy7su/x7
	2Iipr
X-Gm-Gg: AYBFou1V4owE8ZEZQLgiAoE+aNl2VQ8QZEFDKY64H1xMfbrepRTixypFztw1DvORI0j
	uzRRoT3zlcgPBQ3rnHparnMyaLrz8aSL4qq6VtkMAT4cn3q05dj8FaIUQ38lqDrDus+df4oKeAC
	YmpqzvsLSKhM1yHC6IFjK4LyBk8cvaDEOB5tjld6iOdgMHfr+l/wR2nFmbz064kjzaaoR4IC0Ok
	9hxi0D14li+MuYCfO4mZ2leZ0NVP93DWUmvSfczdKGUlsfMAH4+ttIvHH87Txwoj7NkVRB//0iP
	lR5XChGes75wDcl0SuEpV9Yi/3eqQ91INFQGj+bwSENu80Ojds43mMK5+qSlFiPaEWfYJfYw8Sp
	jW9VLCB3CdEGbpQCVOn3FzXAAWK6YhOxSyAi/HIJfutCky+MTcMUCDkObRIvNNfbinJ5I9UhFsC
	A6v8+WWBPep88PO7OabSsct/UOYAxV1MyWvg5Nu+l5wTF9C1NkVuBljAuOYql2S3doqpdo6fks3
	BMLPw/15y/U4I+pNQ/xGAhVq3M057lBTDlzP9z5eMlOT31gIzjG1c8lWRCO37R/beq8tWXar3cQ
	Diat1jAmRgwjwS9wG7PtOCM2kzlCqwaMTttS9WDZMv9JnVhFxqXGq0gfq1iCIrqjGA/W7J265B2
	l04sKXHLqIjsg4LLYMbP8
X-Received: by 2002:a17:90b:4b8e:b0:3aa:6b5d:a00a with SMTP id 98e67ed59e1d1-3b0db70a29emr6105227a91.53.1794068226238;
        Sat, 07 Nov 2026 08:17:06 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.17.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:17:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 5/9] io_uring/cancel: count all requests that a CANCEL_ALL cancels
Date: Sat,  7 Nov 2026 09:16:52 -0700
Message-ID: <20261107161656.2500790-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161656.2500790-1-axboe@kernel.dk>
References: <20261107161656.2500790-1-axboe@kernel.dk>
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

From: Shang En Sim <sim@shangen.org>

Commit 21ddbb14f7c3baab50a2a6c13ee375edc2bbe031 upstream.

With IORING_ASYNC_CANCEL_ALL, __io_async_cancel() counts one for each
io_try_cancel() call that cancels something. io_futex_cancel() and
io_waitid_cancel() cancel every match in one call and return how many,
so four futex waits cancelled with CANCEL_ALL give a result of 1.

Add the number that they return.

Cc: stable@vger.kernel.org
Fixes: 194bb58c6090 ("io_uring: add support for futex wake and wait")
Fixes: f31ecf671ddc ("io_uring: add IORING_OP_WAITID support")
Signed-off-by: Shang En Sim <sim@shangen.org>
Link: https://patch.msgid.link/20261030050319.1448530-2-sim@shangen.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/cancel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index c7ed51377dea..a34543cb423c 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -198,7 +198,8 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 			break;
 		if (!all)
 			return ret;
-		nr++;
+		/* futex and waitid return how many they cancelled */
+		nr += max(ret, 1);
 	} while (1);
 
 	/* slow path, try all io-wq's */
-- 
2.56.0

