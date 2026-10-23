Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753286;
	b=llCcg3TGz057C2RCz/xHdu/ZrjGUPn6Q/FN+3+1d8tFjt0RvR88I++IZpxr2ETOdVzJG
	 FLrfQ58VtOx2CA2NDJ5G5EQYxkLhPAPbKl2k+c7Ri1iA845kT8e0IH8+kbC8js6alHwVp
	 MOF9uKRWbbSLR/JEVr9kwEHSx35E01/ZtJSS8piKE076dAPX89oIjOG5pDfP451r3fBy5
	 ZRk/LSPeA5ClCme6AmwviZ2SmdP9NTvxo4gUri7lzi1APiWFZcS+BJb1ys+0kaeyGft6H
	 5/QuqblLGk62/3g8TDvkoAmHjs0+lhcial/a3qUSfXcFMOwjQY8775bboOKwZtPXkwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753286;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Dx2Tbtv5flHAZ7I0g5glR2gdb318idcO7oVSLafTpw=;
	b=emmjd8/GM19lfA4l7HAJLI9sToIHaAyRvULtcZb+k2J0kB0/7M5zUc7PfYpgMDiDStWO
	 eMXC4SIOxgf0u2BV+3kT8aqn7Ecdh8z22f4Lz5yT7+WpYkyxREdJFWwt9/q1linLCqHV7
	 rsalYKEQBtAOzfdUFvl8Qi9Kahf7ctJj0EFBQi8ork5bK0VugzP8diLVjD3uuso8l1uV2
	 7G8UeoFXZjpKXuTmH6MNlykk6imiCUx9CipPCf1tuHxzHPXLp3KZWUYjp6ATJiNQxjm43
	 jNMXw35YpoJgdeLecf3CvFN6a8FgxXTaOwVSctVdGWYIKX6G15Gy+X9k2cyjQJlGiVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=K09z9O38;
	arc=none smtp.remote-ip=115.124.28.148
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8A606A31A;
	Fri, 23 Oct 2026 11:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EC8A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=K09z9O38
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792753274; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4Dx2Tbtv5flHAZ7I0g5glR2gdb318idcO7oVSLafTpw=;
	b=K09z9O38PEYdB32b3OXDrIqqpybe7D/dkRdaty4a1jcJ+b0dggLUth8/1xXwRKyVEz0kml5UfNI9sypijDVIL9t1cfwZ2tzieZaudMz//MF9C9l0daDVMYge/dNPQ3x4WU3rCDE0O+6Cytjdypo63tNMCRlYrN2QpWMWSio0ofA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07447688|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0156875-0.000218424-0.984094;FP=16245881213183280154|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.joBmZWu_1792753273;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.joBmZWu_1792753273 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 19:01:14 +0800
From: liuc63 <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: khtsai@google.com,
	andriy.shevchenko@intel.com,
	fangxy@xiaopeng.com,
	rdunlap@infradead.org,
	dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
Date: Fri, 23 Oct 2026 19:00:59 +0800
Message-ID: <20261023110113.2969708-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

get_ether_addr() parses a MAC address string with a fixed six-iteration
loop, unconditionally calling hex_to_bin() twice per iteration.  It never
checks for the terminating NUL, so a short string supplied through the
configfs dev_addr attribute (e.g. "ab") makes the parser read past the
end of the buffer, triggering a slab-out-of-bounds read reported by
KASAN.  hex_to_bin() also returns -1 for non-hex characters, which is
shifted and OR'ed into dev_addr.

Bail out as soon as the string ends or a non-hex digit is found, routing
all failure paths through the existing eth_random_addr() fallback so that
dev_addr is always fully initialized before the function returns.

Fixes: 2b3d942c4878 ("usb ethernet gadget: split out network core")
Cc: stable@vger.kernel.org
Reviewed-by: Fang Xieyan <fangxy@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/function/u_ether.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 59d85d6a84a8..12edad59ddc3 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -689,17 +689,26 @@ static int get_ether_addr(const char *str, u8 *dev_addr)
 		unsigned	i;
 
 		for (i = 0; i < 6; i++) {
-			unsigned char num;
+			int hi, lo;
 
+			if (!*str)
+				goto fail;
 			if ((*str == '.') || (*str == ':'))
 				str++;
-			num = hex_to_bin(*str++) << 4;
-			num |= hex_to_bin(*str++);
-			dev_addr [i] = num;
+			if (!*str)
+				goto fail;
+			hi = hex_to_bin(*str++);
+			if (hi < 0 || !*str)
+				goto fail;
+			lo = hex_to_bin(*str++);
+			if (lo < 0)
+				goto fail;
+			dev_addr[i] = (hi << 4) | lo;
 		}
 		if (is_valid_ether_addr(dev_addr))
 			return 0;
 	}
+fail:
 	eth_random_addr(dev_addr);
 	return 1;
 }
-- 
2.50.1

