Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817898;
	b=uDjQbOIZJxH5iyn7O3U0tNJU2a0al1MRlsXEYVBiZVH899Ab9HLqYAU9mwzF0St1hZEF
	 QaHAuUeDtaVgYDljAkZcA9YhInbtPGF0ddBMro19rXf4x7Xojq7u+Hfq4LKW0oUMms9E+
	 NLC+f8VJ9mC9aRd1ngM8CvQ60yUPCVa7uQ9/XagYUM7gKlEHCIeK3UfBHP78y92eWztWc
	 YXAoLHS51S+BKHWQQb0W5fdz0Iqlyzxo+XqMQghcGcDLZeWLBJs3D0QyWziHIr+UcmeaP
	 LnelyOqsadKzFYTgP3DfM2BSy+CSIGs4Fap/xtjDwh5Qr/EgmoY9xMxythQVpnkDxSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4ap/siDqDiIVmZjUjvTBE/p011L1lWwF9vxeWnSNJBw=;
	b=KbGDOHvT6TZ6ikCx2gB+6QrD6fdrObZNI0ZaOH2ICDiHanlTFlLHDCZfjTVEn6F8f1P1
	 U9Pa4IpvHF+JJRMABZMGDkishaK7om2x+R6nFpZamzWjIO/FA/URWDwRBHPNPZHYlWj/Z
	 DX0mIvSsCb5vZ0GI0GxmX5mptgWgKAW9Ry6cCzMJxHgneE353cPGMe+rNUt1Doy6a7JST
	 9OyHa2YxWiUqO2Wcf09SAr+y6CFGlDYdBLegRZMhrWGIjTV5GLSTAoZpQ3drbYgveJYZd
	 XdEnpuQELld5YlWRomiRcC2To+VGkKkDSw9zzw26waFtEtz9MU2Mlnf+eLX+XJ6QxyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="SGl/6Hmc";
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A3606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF4A3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SGl/6Hmc
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4a75171af39so282257fac.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817897; x=1794422697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ap/siDqDiIVmZjUjvTBE/p011L1lWwF9vxeWnSNJBw=;
        b=SGl/6HmcqOqA9JFWbzZBbYK8XIbT7Tk3rIw+QhYKGqJ2o6ZdeXdAnGz+w2LzK7lvd1
         Zwvw7c8Tz5EkC0NBSKCQkMVfxFN8m5mohUCgQIjQWocADZqtuM5HPzarpmVdgPwJ0mBU
         C1doCCCROi4IpetP91aOBOLmMzxVImRh2gC7jeUf3eDwebPZwlLu9GfvXaWyz/twks63
         HGMEr+8m6go0ukl/ZS8mi4LrUgGUFtzzcINOoyPjHO8Tf/clVqmS7h2YydTmWRROrcQ2
         KEmXaSLMLL0UNddSV+kee96gQXJsB+m4bQz2t6cIJj0MgD+Pj4qQCkwiOTmlPNu1723D
         Swhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817897; x=1794422697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4ap/siDqDiIVmZjUjvTBE/p011L1lWwF9vxeWnSNJBw=;
        b=FmYtJ2YEkWfKo7RrWg//8hQGm1e2QpiXBFUgHhecdcHTJBJxbfDFtKkhvg2UrtkIEJ
         TFDSV8Dmq2DXXh/fHG2xwv/Yxt62KphE1AZe2Id3t9+gnYQH2LclO1ycC55NzEs//cIO
         uv6vvcio9/7CJPW6viT6efA2yIHKU7857tp4zHh5+THuu5CPbuzg574NCxmjtWsYy/dy
         1b+JPEKzlMEwDpXiLFU3jIMwTZBia7hbZBFy7KL3+tNha2oERPF7Dd6fgoC/HBoAEX6O
         hlrNz8LL9pvN5Ws/oyzqgVYNGyH9V81Yb7wKLBIKqfgXD95mPOFsKpveSQ2ToKwjZCg1
         LipA==
X-Gm-Message-State: APuU4Z8VG3O5tHfKchu+qpu+u1T/baAgrpvOVdCQhyRmdFi/bD1Q5TXp
	v8nKBQId0qALhmiRbnWKQKHZ8zsLxmrJ8W3UKhbQD4aVol/5YK4z8sdB55z1OyfaslaYeXtKrbl
	Mv3Vz/q8=
X-Gm-Gg: AYBFou204OGpnsi9khOlCHaNKotSiA151S3HRh0RGQpgPLZ27V4dOh2N9r6TrVzgzNA
	LZZdrfYGW+B8Hx/8dsrCRncBFmv+UHrJe30UzWUxv7fkgP8OMHs1Ze3l8AdMqdcmSLogj/yS1AR
	+3gBi5ve5/AVJwVxlv481qKbvCfBE8QqwbgB8DS8z+WaPWwFOV+b82IJ3LEjzCM+rSDlst9Yb8V
	ia/t5p3KPgXjhnHAG3aPVhHmvnupIrw3d6c9ssMpU97wf43+pnlGhZz1Yp+J6hURky8Qn0+zi+V
	09bzLDO4yG/kKvkYDgNpILrzI1/dZSO/U0Wx+Vdf5AK1oE1hLmHJqGKnmgeIWlhoNlkqnnUMwzS
	Dvc7mpbCU7AG9PtZwLhJVFbE1U/4F4vKXJGV06QpZw09do77cOsnrIHu1RqsAGt5r3I25YdZ++4
	rtqVNGHXWFFe1oTXor74fRbVV9zTwtq2W2a1oSA28O87mixrMYN1i8/rwOPYvnuRBLwzPGTuZFb
	2Cz9Utovst/WekQNiIE37TA2Q+0OBxf/OcGuNJ3NsTpBBkOeQ2KbLu/WKRmq86lJtpl1nWw5wm1
	BfLKFU3HKXcUoR+RfqDdN8hrJQLiINarM3A1d1QDQrYKWjDP8vvSUHwfssN2bjVzbla5Z27nuA=
	=
X-Received: by 2002:a05:6870:d208:b0:475:a112:126e with SMTP id 586e51a60fabf-4a90767d20emr11586336fac.27.1793817896766;
        Wed, 04 Nov 2026 10:44:56 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.44.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 02/16] io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT
Date: Wed,  4 Nov 2026 11:44:33 -0700
Message-ID: <20261104184447.516768-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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

From: Yichong Chen <chenyichong@uniontech.com>

Commit 18d3f56eb6e6500a65d81cf265f0fe74fd9ecab6 upstream.

io_recvmsg() takes the transfer length from the ring provided buffer when
sqe->len is 0, and such a buffer can be up to 4G. min_ret is an int, so 2G
or more makes it negative and the (ret < min_ret) block is skipped, and the
oversized length reaches the socket layer unchanged: an empty socket then
completes with 0 instead of arming poll, and a short read is reported as
complete. Clamp the length to MAX_RW_COUNT, as io_recv() does.

Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Link: https://patch.msgid.link/20261023112209.87979-1-chenyichong@uniontech.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/net.c b/io_uring/net.c
index eeab88e77fd8..4678f29f5177 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1068,6 +1068,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		sel = io_buffer_select(req, &len, sr->buf_group, issue_flags);
 		if (!sel.addr)
 			return -ENOBUFS;
+		len = min_t(size_t, len, MAX_RW_COUNT);
 
 		if (req->flags & REQ_F_APOLL_MULTISHOT) {
 			ret = io_recvmsg_prep_multishot(kmsg, sr, &sel.addr, &len);
-- 
2.56.0

