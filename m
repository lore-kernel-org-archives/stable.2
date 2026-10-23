Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769819;
	b=QXLsdvTGPGjv1fyinMGG/dtOObmAGz+D64+ud7fkEmZsBm245VXP08dZg9AqO9+Us/wh
	 Tq8pvpf47rlnNUX/L8NN/4mRvdFRscjFbQPsl+hy2tYJp+ahWVs2RXLxw1cAkvBPjcd/9
	 9rpWpugWJ70HpxBYuGsKZdY5bqbdqWCseXGiOIhIJgOCuPd5CiUUSmQlLjmoMAW41XH+N
	 5RaHQI7dSCV+pGmuIvaCW/vSVFVANFAfS2z/A6Hw9PbnxRSbxDM36EDQq19EAqvL1nzko
	 2x0O7jHuFL6zjy1NHvBwY5VZw+CnF0TH2/U9ESH0vhmqTEfI5RvSmz2iFhGbKGJONTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4A2LFgNU3Vz3Cd1QkL+GF0Kwq7uWsh+K0kLA3UVTqQQ=;
	b=WIkz0GFs0uHpfu+jRUO25NrneG50DbnpiaZ+1e6kgZGDPLyp973B0HyihEuGnjShYkl/
	 /o1j2fwsGKUDhAe5e0ZczPigX/cCgL2wq1uSTSn1e2VHPkp1OeRA/DKefZvsnK6b/0SwQ
	 Bu73n8to7bjkbV4xaGHOdQO25NQKRQE8G0cJZ/0JbCQR6kpXnuMIDacS00YgwMwGf0gUb
	 AmYh21GFkQq/3lyOZXZfY/MoHZddmLIty/67vv4DomXM0q4Wy5V2UMg4P+D8W3IZno1Qh
	 +HvkJjLL/eKcFIGqay499meD1i00ExREiEzb/7IPBHZsyeW+8F/lybThPwpE4voeE/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dKlS8bo9;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD904606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD904606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dKlS8bo9
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35cd538de29so420882eec.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792769818; x=1793374618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4A2LFgNU3Vz3Cd1QkL+GF0Kwq7uWsh+K0kLA3UVTqQQ=;
        b=dKlS8bo9/2SQaE++bG0l1jBEF+5W6CiLhS8Ya0X6QcdG0+OSjkFSQ7ZTnJQXuOmJmF
         tjcgfjLM6gLXRBj5n4OprkwBA0JBeUCVf+bC4rd4mtVKRE5nIYBd8QvASikib7ifIimc
         ptp9ilY8xK2i0VUg/lkTIj4KD6iQT/NQsNfz9Bpf68eNgrc3VjOeTjrTQAMf1Uu358XP
         dhWArzP4dcdOJHKBixaxNr6NMhO2px9+IaGxtdZhQdZIbAoYmTz46hzbwGczviTk1pNI
         RDn0g206v4cwxuEKfEVs/HGTWXgA+vn2/7reiKIiV7ZffEB0bLda/7QcmfXRcAcNZXYQ
         x/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792769818; x=1793374618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4A2LFgNU3Vz3Cd1QkL+GF0Kwq7uWsh+K0kLA3UVTqQQ=;
        b=nwFzYXshBVZAmeN4aFtbh9VZDBeRAPOGbKpG+dO7P06EiM3+utxmTo/hTUUmC2x1yb
         BDcW1Oj4/0I3aTIfPpq08De/zZr8x4WgKLSMb+mn0lhCp/v7vmI0hFOiiUU7DzpSmnLh
         /snvn15Qxas5KmpTmjbPApl+ID3H2mI/slEn+AZ+b4DO++8IkBCA+breHNQlC+ZhH571
         isS8QlLLjbNzXseqVLcDRdkrrz/+Zc6R0bmCp9OFm1UqomwqQB4dyh2Xi9jAxhju5xlZ
         zf77PCaY5bYB/uU4hJXfnBZS2loJNdJCpa9PkELFgaftlH8tSQf8qKyG929gzfO285zS
         TQig==
X-Forwarded-Encrypted: i=1; AKwUvBwZNERSCRQ2n08Vq99xKjo5E9otgOVyCOFqoTT/X3l7ELKHs++isbFAlvW3XD79Ps+gk5tyAE0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBoJYy8Q/agACn3rjVAng2V/7MvvBl60aXE/WXqtRu+Vi+XY+0
	gJiD9a4rjzdf9dAlnYblic5WeNK3RvnvdGhJPpXgoN2fl0nJIHLVJC2LN3cE6PKg
X-Gm-Gg: AYBFou29fN4khovUn7i7w1u/2vkplHTrLZcuzet6RoJE32GfVjhnWRws0xHG8YzrzNM
	L1Lq+ehmd717SWuisAMjv8XbC39PJ3+lt95Lb3e6EBLw5gXhyrXm/0aFvmAhvsrmERXAOQS7i9n
	30RLX3MT3cKqXsLnHkRpgNGbzXgWg2UBeSQ2F8reO5PcpHe4dm877VlPmp6L/6cpK+e4p4DyLJf
	hbhGKuTf+vXHlZd4rLSXPJvXmF7oB+W89oN6bcHGAeE+9kH/6uDdwOstImxfynPPWGb5gx6el9F
	8kDxIHSAwjiSOebqISXkazfkB8gkOF6SSNkscuiJLy8eDcncPKOzU6wOZohntwmWWqPZlHCTQyK
	nQNJMZ/oL1KRXsI56JxVPoMUqwoLeGud6Ek6j1xi22xHhpFVTrFJD1jN0udF8vWewYN2wAvkmj6
	BsJszHHQObRCzFvOBCR37g4Co1AdBhe12oOhus0mQrA0Ux64r4eyK4yH8CO1jnT+C0pFde6/yWV
	0ozoa2Zo6BjmjOq92pQB3bdeFqOhMZiIeLy5t+SSKWBHkO+kT20uELkFFljBT9lndMosH0Pizsf
	zaVzpMB+y30LqscFU3CTcYvdFbYL
X-Received: by 2002:a05:693c:88cd:20b0:35c:cd26:3066 with SMTP id 5a478bee46e88-369d985fbc3mr3119669eec.41.1792769817438;
        Fri, 23 Oct 2026 08:36:57 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e6e4e81asm432485eec.17.2026.10.23.08.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:36:56 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: arnd@arndb.de,
	ben.hutchings@codethink.co.uk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] block: Return the soft block size for compat BLKBSZGET
Date: Fri, 23 Oct 2026 15:36:45 +0000
Message-ID: <20261023153645.37546-1-dennylin0707@gmail.com>
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

BLKBSZGET returns the block device's soft block size, while BLKSSZGET
returns its logical sector size. The compat BLKBSZGET_32 handler uses
bdev_logical_block_size(), so it returns the wrong value when these
sizes differ.

For example, on an x86_64 kernel a native query of a RAM or loop device
with 512-byte logical sectors returns the initial soft block size of
4096 bytes, but an i386 process gets 512 bytes. This makes 32-bit
blockdev --getbsz and the BSZ column of --report disagree with native
queries, even without a preceding BLKBSZSET.

Use block_size() as the native handler and the pre-regression compat
handler do, and correct the case comment to describe the soft size.

Fixes: 9b81648cb5e3 ("compat_ioctl: simplify up block/ioctl.c")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 block/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 64b4e6c0f696..fb2f4b4d2505 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -835,8 +835,8 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return compat_put_ulong(argp, bdev_nr_sectors(bdev));
 
 	/* The data is compatible, but the command number is different */
-	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
-		return put_int(argp, bdev_logical_block_size(bdev));
+	case BLKBSZGET_32: /* get the soft block size (cf. BLKSSZGET) */
+		return put_int(argp, block_size(bdev));
 	case BLKBSZSET_32:
 		return blkdev_bszset(file, mode, argp);
 	case BLKGETSIZE64_32:

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.43.0

