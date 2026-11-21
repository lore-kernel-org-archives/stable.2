Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296720;
	b=g7s6oNoCfos8kAGvNMSvl5Kj4KwnXlPwzakOaOpdwxqz+oysGixPXw3gjb0jBcpwYqJL
	 LAQPM/Jud/6ZWDiCrzUQzp/Byrmj143nhMbEpJRn5giuH0Vo8qJK1EZY7u2eeCAJUubn0
	 GfuOZ/N/g82d5YiAgQCdzPW8Zx+Jf710Y6f7rvkNrV+fDh8xkOg3daM+CviQgPybMt+NW
	 VXvHJAiDyvkgq+i82qV4kyyIXGv3bfEn1kOHZsd3ApOY9rDOBEAtauRM/NyxAlcL3DSuL
	 tf5CZbCla7o8CvU0NUn9H0pjLNMtAa4peEECbbyAObJk0aAlQtv9SPYjDl6Ldn4Hwuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yebD5/phmEoZeB4OfftjnTe5ez9/AB5roRJ/zZrGp9s=;
	b=IryNhmmcUAiaeyDkCKHuqpnkKsTYk3njbTHvWf1r0QY1A7ostjtH4oGY6lpS9Q4FAF7i
	 E9oK/zqdV/y7GdL0OW6ihkMB0On49U38gZuHcRobWMBmt6VdWdrAIWNkLkCVg12fhQcPO
	 Cz697JS2bEheLiS2O0sPRaZedWNfUnwsDiPcHiS+4m/a3ahlht5JDogP6ERy4J0nAJFrZ
	 WHVq38hCfBM3k8RydWLRM82rg2mUMRE8+PbdwVX+/LVCT5rkhab8suoFmA53KK3M6VrIZ
	 4udS5x+oEnz+Tm4Uzd6Txa6oqo0ipTX7vIdTLajVWEhXSStXDUSyMnnSEQOBulf+Xig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=KeJk3Wrm;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B1606A33A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC0B1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=KeJk3Wrm
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4ad881b6517so1544056fac.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296719; x=1795901519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yebD5/phmEoZeB4OfftjnTe5ez9/AB5roRJ/zZrGp9s=;
        b=KeJk3WrmLd3ypbjYnHUcHqceUU5XsrUKb4pnG1asoAXV5Dt/aJarK/2+kRYBxVyTTv
         nxJy30RPBFx7bw2uzed6g1qQNrOQVoUZeDrb/+/57EHDng1d/TZ6XZN6qW4jIvIACZJ5
         uUpUL3sONW7uLPx2Yr0G51UCpFsGP8wlypA7hEyxHwCZWSH3sVgJnH5SM+/tQcXQjs63
         onwxaF1BSaef7ETErxJ1dYlKQ72D9yLkGwtcOF97JbqfxgGJfq/S3Xs67djCJ6+6cyCG
         W2TlfoxKNKItJBqlmlrZXXkFpwNy1rxySoY3cK4YOSp2ILcwjo7XUMj8xNC5F+SaqLs8
         q6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296719; x=1795901519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yebD5/phmEoZeB4OfftjnTe5ez9/AB5roRJ/zZrGp9s=;
        b=wFH5/oQe5EM1AB8/erOuaSOFEqg9chOHP7FbL783m9q0/WA/zo+R8qeRDvArUx7xUn
         IoVB1CQOc/+1+7mmtvELW5yiLF0VmC7xVq3uvFYoNn1vNErS/1sx5bxlQxZ6uNA6HaK3
         k3N4kBeFEBNcCdWrOd/hSBHA2ThlcjMU4Mfod4NAWJ492FkxvKsANo2wDbYbPv7OfJ9i
         4iCUIpia2AYTIKDqfbTTIE/a7RywiB/ix5Dzys3yWAMB52i5XE2eo0YLGfI6Gfl7hbeU
         2TeTD2gKtBiUgiRBD20d3qGH19si7m7pCg/WyyY/wPDUhLCBBBdDJ1Igg8Wfw+xp2aYi
         a7nw==
X-Gm-Message-State: APuU4Z/dMl15p8fr9hfirgx2Ayfol57MrrDRi7IfmaPLqXXKRUk2e5l9
	VQp2GcS6+ELcXx9ZhiU7deNb7r/fBiIvRBO3wl//cOS8pq5aBoTOOdthS5AN6Zb76qNQTdrtoRm
	FM7uZwJM=
X-Gm-Gg: AZFdTZecN7P/TEFe3SnsqnLS9lB7C2CNkz0nKQwQoxZtRSB8nusRTF4YLXeIdoh3jnM
	Va6sGllG/lt7U/EAgEDEY2JLFkQ+sjrQ2M2o859StwiwR2z2UdUFetX6JVNGksBnT6C3co4RyyX
	vp9GTqdaJHQx43RgpGtR2LI8T07F6copgDm/sUTA6KSPdaMRlfjPKnnj0G5ugq9GGUYmPR21Re9
	nveWVoNOhfxkBxSfRHlO3PLFcI9djBq5k2LjjQwfFiPRtseX2CUoE5gsXAdBlBmyK8v8d63gSBS
	ISk/SP+YnP5MU6M1NuQ8D0h5D3PNnpgfsKqp5vUJ1b2nx466GJMkGivq3b6PDe7HpoiVQq4XZhu
	/3ugcZ/yWb3TS3dzOmORaq5LttmpgquSljTgg0yeJEBQFrdoWB5Oxqrhh2oDnBg3EW/YCzguJdr
	Xh7OiBXMBwGpEBH/EmW0piCrzgToydddWj6Eu5H9gIetD2Mhod4tV3mQKtqdqUGtCaS101y2OhN
	co3k2sGFx6XSeiNUZK9QHlLQObGhy0xihPml7hejqk+TH6yL1PgTD+6RiApF66dHcThgBcA0U43
	37oUWE3ZIiNHw0JkjIzk+nfdwwurS9cc16R+RCafP5sTtC1D5o1itkys2rsUJ1lqaBZdJxGNqKR
	C47cFoyNXo5PRrd6UgbiaC302oHd9upU1owev
X-Received: by 2002:a05:6808:c16a:b0:53f:4cb6:cda8 with SMTP id 5614622812f47-57a0a20ac09mr8301127b6e.23.1795296718685;
        Sat, 21 Nov 2026 13:31:58 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.31.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 2/9] io_uring: fail soft links on negative IOU_COMPLETE results
Date: Sat, 21 Nov 2026 21:31:47 +0000
Message-ID: <20261121213154.1790334-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213154.1790334-1-axboe@kernel.dk>
References: <20261121213154.1790334-1-axboe@kernel.dk>
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

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

Commit 9ed19503a7b34e1ffb2b81236843204c473b0ae0 upstream.

Handlers such as fsync return IOU_COMPLETE with a negative cqe.res.
The old io_req_complete() path called req_set_fail() for res < 0.
After completions moved into the core, that check was dropped,
so IOSQE_IO_LINK dependents kept running after the head failed.

Fixes: 97b388d70b53 ("io_uring: handle completions in the core")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114041123.109163-1-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 41a03979cb8b..c6bd17cca45f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1498,9 +1498,11 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 	ret = __io_issue_sqe(req, issue_flags, def);
 
 	if (ret == IOU_COMPLETE) {
-		/* not all handlers take care of the internal restart codes */
-		if (unlikely(req->cqe.res <= -ERESTARTSYS))
-			req->cqe.res = io_fixup_restart_res(req->cqe.res);
+		if (unlikely(req->cqe.res < 0)) {
+			if (req->cqe.res <= -ERESTARTSYS)
+				req->cqe.res = io_fixup_restart_res(req->cqe.res);
+			req_set_fail(req);
+		}
 		if (issue_flags & IO_URING_F_COMPLETE_DEFER)
 			io_req_complete_defer(req);
 		else
-- 
2.55.0

