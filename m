Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467951;
	b=IUsxzIDmEjTjvsY2Wd5YSXwEiqLH/VFZbbnKEQ0WB8ID+7rSFWLwcPe6j+x0Hx09hj9G
	 wmyGIG1ZSRZvYqe0biosPYGnW00T/rp185dejV+vS3leEIqpoh5MR5/2EtlKK6f6HziAO
	 ZLSH6x6U9Cf9aXfVzNa7uPxFztojMZ/aZwJb+AeeMQbqOPCKkScWSAR67EskYO0nYWpzK
	 YZKSZbkQXWSqZvtYswyZDOVPwP6olIQBfGThJfevKluDdrL2fkJOQh6BJ1v6UvLMQh5Zs
	 1m+tPNNdawGJyaYIIrrDi+NCX3B860/DCrtA/JCFpEMcRumpqGpzVCAT8L5ymOKV70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467951;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UEawjYf4KP5VSikDXKhRYVtZcdIPXAkEsckpZehMyOQ=;
	b=ql5C0i6/eMOQmSwZeBTWE7JJjjTRNj6I1o0sJn5SqKY+ZcJ/MXoJMt05TmHo4mgI1Ucp
	 OhDPA4kN1CFtXZGQSUaCsyEY3TnrhvcgUbs3CDc50nYs/5qUkBOj7tDPOynRBWlKf4rEL
	 nKPs+NxE2AjG58R6wq2xOGXcPnqhHV9KG/CKDCNzUux2HBfOfB43EGFXUATKjLSAk4Gr+
	 CDzHzbulDgOyd3/+J9Natt2LmuPjB1StHpc+1sJjApYLZxU2YpW2c3soKjqqPmUtGij5y
	 7ZSCRXs/zO/deZcXPMc0RF6n7EX35VEZ1+YtoHlM6/1L0VxGcX0xJ0sf9VwAK4ytt2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jakejoyner.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24540606A327
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 21:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24540606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jakejoyner.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-386b921f2a5so100182eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795467950; x=1796072750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UEawjYf4KP5VSikDXKhRYVtZcdIPXAkEsckpZehMyOQ=;
        b=scd0VM1/YejrwSxCRp16xiPPMscEgO0qE3IZ6sClsc6NzG2PxGlMLJ/taTtOLLBZxt
         MJBf+S3dmkBgQxVypJmx6YD4HUcZQE6lVbl17Z7CsD1E79gqhGrUsnTC227cN1JZEb4d
         Fnh1urzk+ZK6fpMMYnNRzseozGxu0ekjR6mv4NgdY6tVdJnhXQeHuOYfVGpJt02UasXu
         t8/ssiKdYu2rhXKC2V8+3OlQjrOqRceiMpsQFnIfKDMQtd3DI9lIILnm2OrSw2a1p01M
         OEaZdKYtoxG1sPmN8tiDqoiVqHzCDOqXRFlnZ/DiWgikA81U2afOp0n506ZX1ldHM2eJ
         mZzA==
X-Forwarded-Encrypted: i=1; AL+hErGUgcAi5jGcYuJ1hayvXn6WFB0mWnbuzzix2ggfIgIs97WZJ4mkZal7rTMHEhfsd9LNSt3cERo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vglXjGEOTinUnIcDnnF1mSfcTEkLkBaZMTSHfYeBrg5n6qMX/
	CvUgQ5yQYSltQZxibIVCKq1xnkjyI5haLbk1SUKaJVlIoMGcckn/qWjM
X-Gm-Gg: AZFdTZdQBoEBG6w8d6t140Lt+pfb/TBJG0noxz+5kKJ0TnRKq5T7E51eOfdMBy5Zr57
	17IaqL1Emp/Z+HwY7YrWDc3pju8ufx+pVGMfWzDUpBZkYnPvPCxJgTOG14pgfm2PKJUVrqXGoVs
	88FqD0KR8qEytlGgeOiWCZwRRxnzhKJeZ1yhtUYUuxQnsuMN6mpJz1SEzdFc4lKVnMpZZ36Q7bb
	PNjOo3hxau/AAH8SmL4OYd+e92KY7XAGp/v0po8G9HEFg6DTP6g7GM+bbh0jyWtfukYcPLtCgSh
	AUATCAD2O9hpxXTiEHEJj6cGiwFb8AJQfEeUofTX7aR5Oe7g8Rnm5e1IVNc3w2XF1J6RVWHz3sB
	GP+9oed75qrRfZhjGD9RbxXX/K7KV85E+EZi7bEGduW7iDsuyxC4F9Bld1SHy7/nsxP32F1YfzG
	ponbxXetuZiJDNadRlEggjatQHZ3DXaFBeBCaAnZg/o1huGHc6cVhd4OH2fEPIIcIMqX2XyG9WR
	G82/WEVPLmlpUC0YS5RtGIqU/BLagE/qODMId0ENVCETtPpXHj73UWfwtKK+1K/CCP6JNtJK1pP
	8rShDOH6I07rY0xlTGwuGoiI9GhqTbP2UwiCe6ub+NibHEL0lM+SiO29lA==
X-Received: by 2002:a05:7301:6187:10b0:386:a8e0:ac22 with SMTP id 5a478bee46e88-386a8e0b29dmr9138288eec.0.1795467950091;
        Mon, 23 Nov 2026 13:05:50 -0800 (PST)
Received: from localhost ([47.156.153.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm46614607eec.11.2026.11.23.13.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:05:49 -0800 (PST)
From: Jake Joyner <jake@jakejoyner.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jake Joyner <jake@jakejoyner.com>,
	syzbot+3f8f5b65af8de862dcec@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] dm-verity: fix shift-out-of-bounds and overflow in hash level sizes
Date: Mon, 23 Nov 2026 13:05:44 -0800
Message-ID: <20261123210544.196717-1-jake@jakejoyner.com>
X-Mailer: git-send-email 2.56.0
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

verity_ctr() computes the number of hash blocks at each level of the
hash tree as

	s = (data_blocks + (1 << n) - 1) >> n

where n = (i + 1) * hash_per_block_bits, i.e. data_blocks / 2^n rounded
up. This goes wrong in two ways.

First, the loop that counts the levels only stops once
hash_per_block_bits * levels is 64 or more, so n can be 64 or larger for
the top level. For example, with 1024-byte hash blocks and sha512,
hash_per_block_bits is 4, and a large enough number of data blocks gives
16 levels and n = 64. Shifting a 64-bit value by 64 or more is undefined
behaviour, and UBSAN reports:

  UBSAN: shift-out-of-bounds in drivers/md/dm-verity-target.c:1598:38
  shift exponent 64 is too large for 64-bit type 'long long unsigned int'

Second, the addition can overflow. With 512-byte data blocks any 64-bit
number of data blocks is accepted, and for data_blocks close to 2^64 the
sum wraps around, so s is far too small (0 for data_blocks = 2^64 - 1
and 1 <= n < 64). The hash area then appears to need almost no space,
and such a table is accepted on a small hash device.

data_blocks is non-zero here (levels is 0 otherwise), so compute the
rounded-up quotient as ((data_blocks - 1) >> n) + 1, which cannot
overflow, and use 1 directly when n >= 64, where the quotient is
always 1.

Tested on v7.4-rc4 in QEMU: the syzbot reproducer no longer triggers the
UBSAN report, a table with 2^64 - 1 data blocks of 512 bytes is now
rejected with "Hash device is too small", and a small valid table still
loads.

Fixes: b1bf2de07271 ("dm verity: fix inability to use a few specific devices sizes")
Reported-by: syzbot+3f8f5b65af8de862dcec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3f8f5b65af8de862dcec
Cc: stable@vger.kernel.org
Signed-off-by: Jake Joyner <jake@jakejoyner.com>
---
Changes in v2:
- Compute s as ((data_blocks - 1) >> n) + 1 so the addition cannot
  overflow, as pointed out by the Sashiko review of v1.
- Describe and test the overflow case; add Cc: stable.
v1: https://lore.kernel.org/r/20261123203413.145298-1-jake@jakejoyner.com

The v1 review also noted that verity_prefetch_io() can underflow
hash_block_end - hash_block_start when v->hash_end is wrongly small.
That path is only reachable once verity_ctr() has accepted a table whose
level sizes do not match the hash device, which is exactly what the
shift and overflow above allowed; with the sizes computed correctly such
a table is rejected at construction, so the prefetch path is no longer
reached. I did not add a separate change for it.

The code change is mine. An AI assistant (Claude) helped me reproduce
the syzbot report, write a table-loading test, review the change and
word this description.

 drivers/md/dm-verity-target.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 306ed1f6c118..6b6b9116fc28 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1593,10 +1593,13 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	hash_position = v->hash_start;
 	for (i = v->levels - 1; i >= 0; i--) {
 		sector_t s;
+		unsigned int shift = (i + 1) * v->hash_per_block_bits;
 
 		v->hash_level_block[i] = hash_position;
-		s = (v->data_blocks + ((sector_t)1 << ((i + 1) * v->hash_per_block_bits)) - 1)
-					>> ((i + 1) * v->hash_per_block_bits);
+		if (shift >= 64)
+			s = 1;
+		else
+			s = ((v->data_blocks - 1) >> shift) + 1;
 		if (hash_position + s < hash_position) {
 			ti->error = "Hash device offset overflow";
 			r = -E2BIG;
-- 
2.56.0

