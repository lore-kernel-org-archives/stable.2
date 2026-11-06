Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988493;
	b=xBefKbCK3MY9ifDqqLpbnsier9ngnDHs+SDfMlwhzrdAEH6ZwF1N/JLzFebbCOfa5OmJ
	 mEBFZRBt2SRF/8sX6aromPUm9KP7sPglWUpUbUEl09TCmRB9kjDLuq+Hr9suWpbU3VRKP
	 Mao7c1Bw0kCwLc/p5YrjH5rcbWqQf8FLTHmyYXKxBwGLG2bXPOrQzI+ACea31e8w6r2AK
	 ZzQz7pbJSVMllZAGBLhS8oC5P7PAQdvoKUI4y3vpYQfZOJF0e6Hhv+8mUCh9ibBCGDmKp
	 BM5mnn6N2PXwVspwoK0lwLWhiJgtlmy1VX9Lo2orN0wVurnGkVOEgTcPhmi9JwYMgrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4SY/KgBc5jPjR7kY6LZ58uTUj68rwgS+h0034ZsmJvw=;
	b=JkjUGNBLC3PJAiIu8aGz0MEE5r7FjVUTar318gI5CwIAb38ABuivKxm+eVFNta3jbT3K
	 qIlpAgDJZPZBJObmMun9LKNOxhytR483paaG7DVMXhuRJehzgNhf246CQNDQ13sv5oFXK
	 FMbUa7+frc5BM+pp7ZstPvbjQD5Dr+rmhuc5gWbVxfQNPOj9qNu9UAo58sBXV8PDSR24S
	 KNB1tJK4oGmbSQlG3UdpugPefUJBGPI7R+2qzuh7lNgSANYMykJtZIYxUgNxnn4HV3Y5L
	 DnPYbATeVNBmWYr3H6guNcXd0CnTLjY5JO6hXkVQkw1m5G1HtEgwSI5Onkp0DPrcmKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eg3g87tP;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532A606EE88
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4532A606EE88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eg3g87tP
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490585eddfcso642450f8f.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988492; x=1794593292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4SY/KgBc5jPjR7kY6LZ58uTUj68rwgS+h0034ZsmJvw=;
        b=eg3g87tP5Bh515faKrCEqgJd0gAd7dhAmq53sTBq8Yr8HcVOUMAaJpogGoG3dXhm/O
         G4QmKXoXySuj9nh0JIbFuGxW7VcgSl45SpHMSZ8PYd0XU+EXnEWca1dC6+2TTFC8dg0F
         clW3kJPqtYi5NWWLR9iP/7CAzJFhshKFlVHKa1C/bvpcXKiyoRrdoq86+Iofbh8/TfF6
         UhpubSHgDbp3OAiynlOuFY+TeDpycXmp4uTCff8aTBOioOKzgyZFVR0SjioKBuUehMbU
         CiLjYkgsYHbEa+Y/H5eMMyFDzt8r1FuKgyk2tTDf60VtEJ6v+VPJQyV57kQPHiLsOisy
         XiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988492; x=1794593292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4SY/KgBc5jPjR7kY6LZ58uTUj68rwgS+h0034ZsmJvw=;
        b=ougyJ0bwzKSFm8qKZIet0vXmthDKJRNJedyWAfzwaQHKO1uHRjIe3h9pIDhxrVBTwf
         5rZEjA1YKEuH++9c9rN8n/3q9J2KXAk/QXoXgA+Ty/8d8ZsxFNihLKgMnzhQCky8qf3v
         KZwfV//25uwYECqPl0kOt40AS1tSDNPPceSztXejwlpvoXTW3FHckS7Besn62FlXJhgP
         XXbjj0VkjctX9suselBiWPzcMv5XlIkCxaA3yvKu4ijW/mPQoCsi+Broc+2gNKTjILHd
         +xA8sxtSjWPxxkHAjn1FO6Px3NvetdvbH6H+ypzYq4RIcntlhftOaIeHj35rubhYyNmc
         VIxw==
X-Forwarded-Encrypted: i=1; AL+hErFLwobPF/KR4U8h2Gkcert00DpOe86wUzjIIQrTXY3LqMsUc7enYAX41M85SFjDuyNRgTmIM9w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qhID9kU5jsYUmKttY0Cfkdgt2PwsIY+J3zS3KMv/QDMztmVAf
	iUZ2YE3GX5DXq2RT4avEtdOnCEJtu5h29h5uwBXYBdJgVOWjrNt3hYc2
X-Gm-Gg: AYBFou0MyoexVsV6pIUGhd5C1P6y3bwnIgqsBNtVOBM/+0vRHPBpfem7Uchcz3Gi8c/
	YZL7xnx35pLq4gTZBiQwcNxUT3uvE8waEKUYZe1dXrVTMlzOAUA4JQSOMNj6ALffjsNXZQ6rnU6
	xvQJNwQXG1Alph/w3mU0LWpRa6U40HiYuT6Gpao11qf8aigfoEzuBaXfm/29Sj44u5O4AePDwSI
	pc4OeS7+ctc9JsYO7PsOZSJx60kxIuDj54Lfk8hWYW1EtPEY33x6fS/x9Okp9CkCCo4nUCz/PGz
	gbC93gmwI4fFfpZTluczyqVlp57twZiXEpStUVeWw4dwb6pKCzbgBVBHVgX5StwGnohamorNCkK
	0he6x4JWpv5ScOAW+kG6hiXdnVW+iTHnMosPOAtv3iz6Qj2+0IVHd8by3X0X23+GiIuZGllZMI2
	XmqYvBJEw2ZR64u9YYgu+D8VPCeRrxv2Vv4U42g23ABOAoR2gkmWA8oXr17TCLAnwE7/ucMkOWq
	jEgfdgy6jnCcp4MkmJLCClH+AbV3S1atcB79TfqPcI55NAL9IDjYJxIE8eUQn7VcrLLSYa0+M+s
	qDeioeI9W/CxTdVqwlB7zZVlspv18sevb4mdhbu/4PDgJEpMZWDqU7zqc8v4dF73J3SDkv1iXfX
	tlFLn695SepKqQtPhWkrlsITOIO1f4XVWc2NPhbjKYkLOa/x+y1U9Yi4SIu0B
X-Received: by 2002:a05:6000:4818:b0:492:820d:5e6 with SMTP id ffacd0b85a97d-492820d0d4amr5606669f8f.49.1793988491610;
        Fri, 06 Nov 2026 10:08:11 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([105.99.148.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7232832sm4830636f8f.25.2026.11.06.10.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:08:11 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+3e16980543e238b95bd1@syzkaller.appspotmail.com,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] dm cache: fix divide error in too_many_discard_blocks()
Date: Fri,  6 Nov 2026 19:08:08 +0100
Message-ID: <20261106180809.1419-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
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

too_many_discard_blocks() uses sector_div(), whose divisor is a u32.
discard_block_size is a 64-bit sector_t that calculate_discard_block_size()
keeps doubling, so once it reaches a multiple of 2^32 the divisor is
truncated to 0 and the division traps with a divide error. Smaller values
above 2^32 are also silently truncated, giving a wrong quotient.

This needs an origin of more than 2^45 sectors, which is unrealistic (this
is a thing still in 2026!!) for a real device but reachable with a fuzzer.

Use div64_u64 so the full 64-bit divisor is used.

Reported-by: syzbot+3e16980543e238b95bd1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e16980543e238b95bd1
Fixes: 08b184514f65d ("dm cache: revert "prevent corruption caused by
				discard_block_size > cache_block_size"")
Cc: stable@vger.kernel.org
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 drivers/md/dm-cache-target.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 1a5072425c4a..2d40d6047ef1 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2383,9 +2383,7 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
 static bool too_many_discard_blocks(sector_t discard_block_size,
 				    sector_t origin_size)
 {
-	(void) sector_div(origin_size, discard_block_size);
-
-	return origin_size > MAX_DISCARD_BLOCKS;
+	return div64_u64(origin_size, discard_block_size) > MAX_DISCARD_BLOCKS;
 }
 
 static sector_t calculate_discard_block_size(sector_t cache_block_size,
-- 
2.43.0

