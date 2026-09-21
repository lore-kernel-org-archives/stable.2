Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0483393DE0
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018775; cv=none; b=fwxAuSirworoab1vP7p6p680IjmEuBPUOZvdEOaoTn3IbhAqtD7RZ3fZorxuOhkofmMccCMhO8Ht65LFCNH7fmpnLsQCi6Ufv48Xtvqp4fJBQbFYLMkLpZAZee7L3JT+8hjdG32tlFEdoPvK+rF77HN5GCfNLRSi1ftss8N4Ms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018775; c=relaxed/simple;
	bh=RaJdotNRjQ7v4XLVdNOrJ2F3tz9HzM/CSax0HTuqhF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baxX2C1BGlqJwWhB7FwsY09Mu6/GU30zH7wFXngaMOyWtwFsa3I4sygix2mZJEFQIiS+/5NOzAJ4f2JQ8ITD170SkzbgMK/kGP+d5PeBK1F1gv7xxlqKamePHnwhsWgMXSREa//fENghzUruVPO77qs2HCAc0zRfFnY1c0tLUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXukoIQK; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXukoIQK"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so3713764b3a.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790018773; x=1790623573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPHA1/g/WcT24PIfBNMekc+zAjDKuj7dhADig3JaAok=;
        b=LXukoIQK426K+iiG8WWqQTbuFr8W/3FAxv+LPeJ4BogbgxKA1oTs++AABGrEcZoIir
         70lXi1yX7umnwdHC9EGHM5qTzyxEAjFrkY9KzQaul0vefpkAbM9ftf35JsDI9U/6IQzq
         0t202wTH06AwnAz0N+9R3p/ryYlDttSIpBC3wfCUAeeIux5kB6unHGCSoOi259grhRCI
         xf1PUwUhKq57IRmibl9yo8vrkt5aDMPVScAspL/6E++7wIiSgP9w/CsI7waIHFEC4Oby
         HmFQWMrBwvl088hKmbw4QZglNSxYNQOo7Y5aep8wQHLmbGSfhE2aWgMd0SQb2L17mjIb
         bAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018773; x=1790623573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPHA1/g/WcT24PIfBNMekc+zAjDKuj7dhADig3JaAok=;
        b=uwtxMTzL7jtXUsRBoPzZjar72gNVMj1uA7Bo9yl9rn1pSB+p8aHhA8J/HbF7YJA+qf
         VxFmPTAGDeRIZ5FVy51Z0C7fL/ZjH5sqmQEbggdbLGiFzc6IM497T9RsS7SrgpmhxUxc
         9ZfOdb9kH9fjWDLh8P5bW222U4AW6WrOutRsEeP5qdxTxsOMVn+qbW1udOdHn2Cr+kxw
         m0uXNQkeYqzrSG6cxXvI7HHcdDodIQv5uw3RKlqP2PSEvBD0Ym8q83fi45t4ATbcOQgQ
         k9HPHfXMjHRPuv6r3in9nd/d8zRrNcmxctS+nAdtwEMSeS92G3uqoRsBxtIp2FPHEOSd
         2Pzw==
X-Forwarded-Encrypted: i=1; AKwUvBwaVX3buKyRdw5NCZexM4Sszsbf9xanq673cl/QIjI3JRHXWiCeFC7JZf6+3OMJck7gR5NdJtI=@vger.kernel.org
X-Gm-Message-State: AFuF++nrm/vazB//2P/yW/VCt78BzVEftf0XiMHLRVlzkosj0D2ZL5pg
	uCBFCjTb3qKOAEUGyEJoBjb6VamL2xn6hjl+ZVokh0C11480askd8Py4
X-Gm-Gg: AYBFou0Ca28LJuvJKwwXg24wOoHephJP6+UT2jCaADt0OhsIT6KdmXjUSsQjZme6+R4
	wXD/mAMymXx4AMr+7i9Fis5YNn4OmThqzOLHRb8EWWsWRyxUaoKu7jr96pW8V7ZjXPKMObLQ+th
	42psbysvT1LI5GN7GNj/BI2j78+CgAbidSaZWbs8egJWtJa9GTi9+eFJVl7OSB7flESjGc0GWf7
	AvVctSBpBxwUTF73DH++zJZWeb12AG69zYuTjAGaSJloQrpTA2L7hCA28YX9y66gBAYKHF4mxef
	V/2XLL33jjx7Qv9BQx97RCjEzRgfeptXsEykyYw5Gyh3P1A1dYoTT0znrZdZc7Fbml0hMCGVNZB
	NQKwRwLJeI1yumUa/N3QOlr2j2U5t5czjpHna9Yler3zFcvwqS2OWuWzOtAgXZs3dVyxevPEjpQ
	Lkbf0rVNw4oVgkFXQCqoBBOnspsiU+YZTg7bESl5hexvZj56hiVgQt+jOioNExvwjXT6nPxor+
X-Received: by 2002:a05:6a00:1d8c:b0:874:705d:f657 with SMTP id d2e1a72fcca58-874deced87fmr14985305b3a.37.1790018772523;
        Mon, 21 Sep 2026 12:26:12 -0700 (PDT)
Received: from localhost ([180.184.47.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87bf7eb7514sm827b3a.38.2026.09.21.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:26:11 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: netdev@vger.kernel.org
Cc: Dairui Zhang <zhangdairui@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org
Subject: [PATCH net] af_packet: fix integer overflow in prb_calc_retire_blk_tmo()
Date: Tue, 22 Sep 2026 03:26:08 +0800
Message-ID: <20260921192608.1420047-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prb_calc_retire_blk_tmo() computes in 32-bit int arithmetic:

        mbits = (blk_size_in_bytes * 8) / (1024 * 1024);

If I'm reading the validation right, tp_block_size is user
controlled and packet_set_ring() only rejects values that are <= 0
as int or not page aligned, so a 256MiB block goes right through
(and alloc_one_pg_vec_page() even has a vzalloc fallback for it).
0x10000000 * 8 wraps to INT_MIN, and on a NIC reporting 1 Gbps
(div == 1) the function ends up returning -2047.

The condition is actually (8 * size) mod 2^32 >= 2^31 && div == 1,
so the trigger set is [256,512), [768,1024), [1280,1536) and
[1792,2048) MiB. Other sizes wrap to non-negative values and faster
links divide the unsigned value back below 2^31, which is why this
doesn't blow up for everyone.

What makes it fatal is what happens next in init_prb_bdqc():

        p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(...));
        hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
                      HRTIMER_MODE_REL_SOFT);

A negative relative timeout expires immediately. The callback
unconditionally returns HRTIMER_RESTART, and hrtimer_forward() turns
the negative interval into hrtimer_resolution:

        if (interval < hrtimer_resolution)
                interval = hrtimer_resolution;

So the SOFT timer re-fires at the maximum rate forever, holding
sk_receive_queue.lock each pass. One CPU spins in softirq until the
socket is closed. Repeat with more rings and the machine is gone.

This is mostly a new problem: the overflow is ancient, but with
msecs_to_jiffies() a negative timeout just got clamped to a huge
unsigned value, i.e. the retire timer effectively never fired.
f7460d2989fa ("net: af_packet: Use hrtimer to do the retire
operation", v6.18) turned it into "fire immediately and spin".
Still present in 7.2.6 and in current mainline as of this
writing.

(Unrelated to CVE-2019-20812 - that one was the ethtool failure path
returning 0, which now returns DEFAULT_PRB_RETIRE_TOV.)

Reproducer, needs CAP_NET_RAW (a --network host container has it by
default) and a 1 Gbps NIC (QEMU e1000 works):

        int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
        bind(fd, ...);
        int v = TPACKET_V3;
        setsockopt(fd, SOL_PACKET, PACKET_VERSION, &v, sizeof(v));
        struct tpacket_req3 req = {
                .tp_block_size = 0x10000000,
                .tp_block_nr = 1,
                .tp_frame_size = 2048,
                .tp_frame_nr = 0x10000000 / 2048,
                .tp_retire_blk_tov = 0,
        };
        setsockopt(fd, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));

Compute in 64 bits instead. The operands are already bounded by the
existing validation, so nothing else changes. If you'd prefer a
different fix, just say so and I'll respin.

Fixes: f7460d2989fa ("net: af_packet: Use hrtimer to do the retire operation")
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
First patch to netdev, and compile-tested only - I don't have a
1 Gbps setup to trigger it live. If I've misread the code, got the
Fixes: tag wrong, or picked the wrong fix, please say so and I'll
respin.

 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b22cda3..24cf2d2 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -617,7 +617,7 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 		return DEFAULT_PRB_RETIRE_TOV;
 
 	div = ecmd.base.speed / 1000;
-	mbits = (blk_size_in_bytes * 8) / (1024 * 1024);
+	mbits = (u64)blk_size_in_bytes * 8 / (1024 * 1024);
 
 	if (div)
 		mbits /= div;
