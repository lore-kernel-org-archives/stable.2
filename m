Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068205;
	b=vHO46jTRzAGvBXpyioe1LoWcpRRlj20Vjb1VpGEuJ6Q+jkJnknDS7DIgJKLALi76wNlK
	 9VBE2WeQjT2LZPm0PkXVbPUu4JahFljLfjnwLYv2W8tZFsHRwPadqbWr0iVsjD6YNVDjk
	 FdoXkD75UHFPvBmhfWQKQvVRHXjdcfwAQfZIPh/xhOvyyxCEylsaF+akSGfqpAuJT6Zi1
	 Wtujrch5PsgfwMqCYny0ZN9zVlKNQ9dy8cYjraCbtOD+2pCheOVgQ3gJ+LAzd8jH0XDUb
	 KYreWnOoThWQN2ApjeS0bYeBU5k9bei0tbILsCgW0b1LQROwzU2V5UCeLGaH7TmprsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wNFsg0t6d2lZgch6pul5K53T6mgmLg/qF0atVwVzvsI=;
	b=QtNUoCXqQIgI+vPaJyp0Y3BTS1mwtc3favNK2a2P30zYhHUlpjoh5kC0v+UYTukumfvv
	 kwCURTiHhIp8cWxIH76m567D5S3SfrCw6Q6+miBLzg7lv0skYkIABEWWshZqNWiCrF/6+
	 qGmz0y9L2UrYyeQP6Nr9yHFMA2jU6HtE2N5rli1OVRp7oKcOM1cWZR3hZmWJyHcqMx6Nc
	 lyorJOhQsZh2p9ZvSi/bePaMQr5OSj4+il8VflrXUVnEIjCEWcSGPrZr0owkFh2pJeqbA
	 3k07AJOJQ0sVulEh/D90tcifZpyxpQydldQVh0R2sSwVNw2uZaeomXZw4y8EYzeTziw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PbLBp6r4;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ABA606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05ABA606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PbLBp6r4
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so764213a91.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068204; x=1794673004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wNFsg0t6d2lZgch6pul5K53T6mgmLg/qF0atVwVzvsI=;
        b=PbLBp6r4A9EFoBSR2KJrxsjiv8WmAmzf/HLx8Wgg3a4h7kLbTjOBx1OolAgSV1ETOK
         JCwvVDgvCZnbm0FPUr2qxV3wCchDwQnoK2MEP23vYdkwbNBsqJ+K7dAmShaZAmChr0B1
         SHAwPwq9Qeh8kc88ddaFzAM09QS8Jt+5JoBJRHLydmfRUmhaayrFxCNV+DyeKvaY+uHr
         AOT9s4GUyETnGEHQpDjb64loicLA5IgCIZ6CiBYr3808LD7qWrBn5ikWyZbhNUFAiDIK
         ir31fBq/he4VSyEElyxcVMcKG9F31/VIFzQWDXndfSr/PaVOMfZURQfzDkGql492+wMg
         Pknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068204; x=1794673004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wNFsg0t6d2lZgch6pul5K53T6mgmLg/qF0atVwVzvsI=;
        b=k7gJzPji88TwJH8fDEwNpKvuha1VmOSIiXNOHHCdEJo5/wq8lKahSjqT4KB6OJzzaS
         LCGAWhh7vCyIlWHV7604A2gW9WHlcfs5rQJU75OZJMHT31zPxNVF7cs8gepTfupH0eG9
         PIKcfOhyUFUo+w50NOA3AQBiH0v5lupKw078yXGqBEN5ddcATyIAEWc4OwSXMeM9Ygsu
         hpqZ/7Xj7MTXjSkkgk+sWjhmdza8ZVNIDjnlVWsrTifvvHDxZbBxM1xupFEChszkVTCa
         iJ0ZSwfV2VP4+NHFNyA4MCpNDmjLM3/iujcu675IH12m5FpQMPVUWIovVaCcImGcb5wT
         f9kw==
X-Gm-Message-State: APuU4Z/e1Hbb5z5Ei07jwP4u6ZTgDworqpgReITe1Msc6icPxMLVOZK2
	GmPAU1v6697EbzGs/yki+dAqKcxIo8KAv+5+yFIbMrZMTT04mbh3j0tGR7JcU/xJatkxukG5Jrg
	+LipHiPs=
X-Gm-Gg: AYBFou0jbp8GgNXlflXhttE8LUABFOEL8++MG7sJCFbL0663vjGMUzdbvT3klqYwZ/n
	kAd9seznRKtEALt0ZQ3M8Ju9j1mlBcpOwW5KdbvcA+r2ZWlog5pO1ygKJ9ARtHtuVSOGH79Qszh
	aqBiPCENZCJoN8YbQSlRQzq4Gq3TbCRhHOuwrxtLkLhasG352UeciDZO1hEcq+WxxTMPW1amSup
	vUvEIzcRuj0B7Y6NdM4CHf4p6X16e8bTLjsEWD9qiEFfbRQZV5vEaK/DfqsrWMs3A6C1O95ziPj
	nmYveehe0lSMxg4iwmWbIA2aN6abErKkQcX0kx18q/9ZpRapwNwTUYvQBWRg0VgY5qdRIKXvDyr
	7kbcH91ppn539IvIZA7sEBGJTSMufau2qgvJRguDTchkc0qonfQ1gCaQudE6eZkxR8GXbs0ltMj
	/sc63DBGwZwmJnjAY6kmTospep2c5387RHGY9b7xGNnNbw/3NzZyhXeTjTPHdUxcY05gVh6a3i9
	tDzh7EMMOmAmthxYCkcLLlSJv09PmHKrXDXATIhylK9OXnUxZ+h+A5qU44eaQyIcxy8XEFOKMyx
	JEDh+x0ONjPWdZc3BWRA/3DIe56hz/aVWInnHm8dtSnAXdCJQ8/fw0sSVsTzHA4C13a1bgeufTj
	Ee3W3lsSEpNH2TToW8dZm
X-Received: by 2002:a17:90b:268a:b0:3ac:d39d:ee4f with SMTP id 98e67ed59e1d1-3b0db712506mr5209638a91.44.1794068204378;
        Sat, 07 Nov 2026 08:16:44 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 5/9] io_uring/cancel: count all requests that a CANCEL_ALL cancels
Date: Sat,  7 Nov 2026 09:16:30 -0700
Message-ID: <20261107161634.2500557-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161634.2500557-1-axboe@kernel.dk>
References: <20261107161634.2500557-1-axboe@kernel.dk>
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
index 44d8b7b25267..1db26c66e45c 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -192,7 +192,8 @@ static int __io_async_cancel(struct io_cancel_data *cd,
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

