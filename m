Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674034;
	b=uYBNpoB2LeYd42fgikjOxAq17KItg8MZYDzlkY+ysC4h0M+hqMot071eqlpdLPHAw65x
	 IRJ1CQ6l9qqBQMfbU/yOHlY6pARHhilGWoS4zBVFlH7ORckNp9OhREv79JADwke5RIQUl
	 hpLB7OMLDMgSEeIyJm9CA9WVrhDhPplWirSIbGLiHdZsuk8HoAbWB+ORmw7vsyyY/RJPZ
	 0Fz+KIvuNg7tCG9IMln1AbQxoB9BBV9B/2Ri25IWYvJIX9ApIcF+COdVk+k5uH1JXhA5v
	 +/vI9QzMnlO5P+TXWeWEjQ9NGp3ypvzIt5xKfbKdCfild0jEiESLLuFkEEX9v3sRkuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674034;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Qf78webqKTFQH3x1OeHEf1XBGifGs4T6pxOG/rNraig=;
	b=eNYnVHTUAu1e9RnOszJVlHIs/7s7ErUYgKurNGoNYfrK5JBtPGzVM5b6dyQoHArr0T9P
	 4kZxwMxTzwMMR2m8xZKerGB3/HJPp3/7cAUdCLkWGJBsUhlzLiNK8UlnBZuZX6r3wYHdR
	 CaBQVSwdHRct+o5D2dOt8/5uxDFC3xxa8VgBGN1LzX9ujMDPX55/JG4bjC+j67k5irwIX
	 9Bo7RO7l/01j+MlgybRbR+zQFJzoonpiovCbAlxxQRSyyl7RXaH4GS2CRfk/RIs4QsFlo
	 4+DQOrnKX21Y33stk47Mm6dBjMBYC0Ve9ZGI2Sw6ZF3ue3+Zwksxb9rxH3vR049pQmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=b0T94ja+;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F03606A8B7;
	Sat, 14 Nov 2026 16:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F03606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=b0T94ja+
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jRfp139jXz4xPSF;
	Sun, 15 Nov 2026 00:33:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794674025;
	bh=xLDgdr6+3qwbQBx6NEyLbkgD2NvygyaSYz0mi5aeCD8=;
	h=Date:From:To:Cc:Subject;
	b=b0T94ja+GO6I95dOEM/ESsVHlo1rrG7M4uAYWricVXiSRcN2nw/fittxXBwX82RlV
	 WJXo5Fy5peFP27qFgVfMnXOPe3LLs/Nc1uIGzH9zLeR/WubSSJQOjfjujs3mDE2LpO
	 cp0uz+Y7IaucmLqd124pJtwuEYZp24MNAn+BCL7Um1AEraV6UbHkzOER5hMt+99lqJ
	 1Tv6YQEhr5o3MYdBC2K7w6v9Vm/9pwZ0kA7YPwf9dlUVQnIle8xDgdkn6hG59E4NSU
	 9DnkQJ5fp1J1BqCI5AVpO0W240hX157xZHU56tX7dp1kcIHNpcsn7VZlroiiVBoIeH
	 0JNN1j3O+xBrg==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6AEGXhVj085692;
	Sun, 15 Nov 2026 00:33:43 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 00:33:47 +0800 (CST)
X-Zmail-TransId: 2afc6af88d6b33b-25316
X-Mailer: Zmail v1.0
Message-ID: <20261115003347468yvY7EkDVXpRQABqNYceKf@zte.com.cn>
Date: Sun, 15 Nov 2026 00:33:47 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwYXJ0aXRpb25zOiBzdW46IGNhbGN1bGF0ZSBwYXJ0aXRpb24gc3RhcnRzIGluIHNlY3Rvcl90?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEGXhVj085692
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 00:33:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF88D69.000/4jRfp139jXz4xPSF

From: Shao Mingyin <shao.mingyin@zte.com.cn>

The Sun label parser calculates sectors per cylinder and partition
starts in unsigned long. On 32-bit systems a start above UINT_MAX
sectors wraps before put_partition() receives it, potentially exposing
a partition at the wrong location. The same label is parsed differently
on a 64-bit system.

Keep both values in sector_t and promote the first geometry operand
before multiplication. This also prevents the two 16-bit geometry
fields from being multiplied as signed int when their product exceeds
INT_MAX.

Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Testing:
Built with W=1 for i386 and m68k. Ran the complete parser against five
checksummed labels in freestanding i386 and x86_64 test programs with
substitutes for disk reads and partition registration. The base parser
miscalculates two starts on each ABI; the fixed parser matches the
independently calculated starts for all five labels on each ABI.

Also tested a checksummed Sun label in x86_64 QEMU/KVM with both geometry
fields set to 65535. The base kernel discards its partition because of
the miscalculated start; the fixed kernel reports start sector
4294836225 and length 128. The backing disk is a sparse image.

The arithmetic is already present in the initial Linux git snapshot;
its original introducing commit has not been identified.

base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48

 block/partitions/sun.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/partitions/sun.c b/block/partitions/sun.c
index 92c645fcd2e09bfd82a51fdfa81e4ee61f42051d..02ddc967846b884d2e03e3858c0ecfdf5be888b2 100644
--- a/block/partitions/sun.c
+++ b/block/partitions/sun.c
@@ -64,7 +64,7 @@ int sun_partition(struct parsed_partitions *state)
 		__be16 csum;       /* Label xor'd checksum */
 	} * label;
 	struct sun_partition *p;
-	unsigned long spc;
+	sector_t spc;
 	int use_vtoc;
 	int nparts;
 
@@ -102,9 +102,9 @@ int sun_partition(struct parsed_partitions *state)
 	 */
 	use_vtoc = use_vtoc || !(label->vtoc.sanity ||
 				 label->vtoc.version || label->vtoc.nparts);
-	spc = be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
+	spc = (sector_t)be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
 	for (i = 0; i < nparts; i++, p++) {
-		unsigned long st_sector;
+		sector_t st_sector;
 		unsigned int num_sectors;
 
 		st_sector = be32_to_cpu(p->start_cylinder) * spc;
-- 
2.43.0
